Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 24 May 2013 10:02:28 +0200
Message-Id: <1369382549-8787-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: Modified forwarding
	behaviour for multicast packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

With this patch a multicast packet is not always simply flooded anymore,
the bevahiour for the following cases is changed to reduce
unnecessary overhead:

If all nodes within the horizon of a certain node have signalized
multicast listener announcement capability
(BATADV_MCAST_LISTENER_ANNOUNCEMENT) then an IPv6 multicast packet
with a destination of IPv6 link-local scope coming from the upstream
of this node...

* ...is dropped if there is no according multicast listener in the
  translation table,
* ...is forwarded via unicast if there is a single node with interested
  multicast listeners
* ...and otherwise still gets flooded.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 multicast.c         |   43 +++++++++++++++++++++++++++++++++
 multicast.h         |    8 +++++++
 soft-interface.c    |   10 ++++++++
 translation-table.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 translation-table.h |    1 +
 5 files changed, 128 insertions(+)

diff --git a/multicast.c b/multicast.c
index 36e4c59..bd55c8f 100644
--- a/multicast.c
+++ b/multicast.c
@@ -213,6 +213,49 @@ out:
 }
 
 /**
+ * batadv_mcast_flood - check on how to forward a multicast packet
+ * @skb: The multicast packet to check
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return 1 if the packet should be flooded, 0 if it should be forwarded
+ * via unicast or -1 if it should be drooped.
+ */
+int batadv_mcast_flood(struct sk_buff *skb, struct batadv_priv *bat_priv)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)(skb->data);
+	struct ipv6hdr *ip6hdr;
+	int count, ret = 1;
+
+	if (atomic_read(&bat_priv->mcast_group_awareness) &&
+	    !atomic_read(&bat_priv->mcast.num_non_aware) &&
+	    ntohs(ethhdr->h_proto) == ETH_P_IPV6) {
+		if (!pskb_may_pull(skb, sizeof(*ethhdr) + sizeof(*ip6hdr))) {
+			ret = -1;
+			goto out;
+		}
+
+		ip6hdr = ipv6_hdr(skb);
+
+		/* TODO: Implement Multicast Router Discovery, then add
+		 * scope >= IPV6_ADDR_SCOPE_LINKLOCAL, too
+		 */
+		if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) !=
+		    IPV6_ADDR_SCOPE_LINKLOCAL)
+			goto out;
+
+		count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest);
+
+		if (!count)
+			ret = -1;
+		else if (count == 1)
+			ret = 0;
+	}
+
+out:
+	return ret;
+}
+
+/**
  * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
diff --git a/multicast.h b/multicast.h
index 9955a18..0c2baad 100644
--- a/multicast.h
+++ b/multicast.h
@@ -24,6 +24,8 @@
 
 void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv);
 
+int batadv_mcast_flood(struct sk_buff *skb, struct batadv_priv *bat_priv);
+
 int batadv_mcast_init(struct batadv_priv *bat_priv);
 
 void batadv_mcast_free(struct batadv_priv *bat_priv);
@@ -35,6 +37,12 @@ static inline void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
 	return;
 }
 
+static inline int batadv_mcast_flood(struct sk_buff *skb,
+				     struct batadv_priv *bat_priv)
+{
+	return 1;
+}
+
 static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
 {
 	return 0;
diff --git a/soft-interface.c b/soft-interface.c
index 8bdd649..83e4679 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -36,6 +36,7 @@
 #include <linux/if_vlan.h>
 #include <linux/if_ether.h>
 #include "unicast.h"
+#include "multicast.h"
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
 
@@ -222,6 +223,15 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		}
 	}
 
+	if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+		ret = batadv_mcast_flood(skb, bat_priv);
+		if (ret < 0)
+			goto dropped;
+
+		if (!ret)
+			do_bcast = false;
+	}
+
 	/* ethernet packet should be broadcasted */
 	if (do_bcast) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
diff --git a/translation-table.c b/translation-table.c
index be5cfe1..680c5c1 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -83,6 +83,72 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
 	return tt_common_entry_tmp;
 }
 
+/**
+ * batadv_tt_orig_entries_count - count the number of originators
+ * @head: a list of originators
+ *
+ * Return the number of originator entries in the given list.
+ *
+ * The caller needs to hold the rcu_read_lock().
+ */
+static int batadv_tt_orig_entries_count(struct hlist_head *head)
+{
+	struct batadv_tt_orig_list_entry *orig_entry;
+	int count = 0;
+
+	hlist_for_each_entry_rcu(orig_entry, head, list) {
+		if (!atomic_read(&orig_entry->refcount))
+			continue;
+
+		count++;
+	}
+
+	return count;
+}
+
+/**
+ * batadv_tt_global_hash_count - count the number of orig entries
+ * @hash: hash table containing the tt entries
+ * @data: the data to count entries for
+ *
+ * Return the number of originators advertising the given address/data
+ * (excluding ourself).
+ */
+int batadv_tt_global_hash_count(struct batadv_priv *bat_priv, const void *data)
+{
+	struct hlist_head *head, *orig_list;
+	struct batadv_tt_common_entry *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global_entry;
+	uint32_t index;
+	int count = 0;
+
+	if (!bat_priv->tt.global_hash)
+		goto out;
+
+	index = batadv_choose_orig(data, bat_priv->tt.global_hash->size);
+	head = &bat_priv->tt.global_hash->table[index];
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tt_common_entry, head, hash_entry) {
+		if (!batadv_compare_eth(tt_common_entry, data))
+			continue;
+
+		if (!atomic_read(&tt_common_entry->refcount))
+			continue;
+
+		tt_global_entry = container_of(tt_common_entry,
+					       struct batadv_tt_global_entry,
+					       common);
+		orig_list = &tt_global_entry->orig_list;
+		count = batadv_tt_orig_entries_count(orig_list);
+		break;
+	}
+	rcu_read_unlock();
+
+out:
+	return count;
+}
+
 static struct batadv_tt_local_entry *
 batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
diff --git a/translation-table.h b/translation-table.h
index 015d8b9..5986c57 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -31,6 +31,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       const char *message);
+int batadv_tt_global_hash_count(struct batadv_priv *bat_priv, const void *data);
 struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 						  const uint8_t *src,
 						  const uint8_t *addr);
-- 
1.7.10.4

