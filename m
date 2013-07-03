Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu,  4 Jul 2013 00:03:21 +0200
Message-Id: <1372889002-6767-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
References: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv7 3/4] batman-adv: Modified forwarding
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
 multicast.c         |   60 +++++++++++++++++++++++++++++++++++
 multicast.h         |   23 ++++++++++++++
 soft-interface.c    |   18 +++++++++--
 translation-table.c |   86 +++++++++++++++++++++++++++++++++++++++++----------
 translation-table.h |    2 ++
 types.h             |    2 ++
 6 files changed, 173 insertions(+), 18 deletions(-)

diff --git a/multicast.c b/multicast.c
index 4af4bc9..dee86ab 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -21,6 +21,7 @@
 #include "originator.h"
 #include "hard-interface.h"
 #include "translation-table.h"
+#include "multicast.h"
 
 /**
  * batadv_mcast_mla_softif_get - get softif multicast listeners
@@ -207,6 +208,61 @@ out:
 }
 
 /**
+ * batadv_mcast_forw_mode - check on how to forward a multicast packet
+ * @skb: The multicast packet to check
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return the forwarding mode as enum batadv_forw_mode.
+ */
+enum batadv_forw_mode
+batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)(skb->data);
+	struct ipv6hdr *ip6hdr;
+	int count;
+
+	if (!atomic_read(&bat_priv->multicast_mode))
+		return BATADV_FORW_ALL;
+
+	if (atomic_read(&bat_priv->mcast.num_no_mla))
+		return BATADV_FORW_ALL;
+
+	if (ntohs(ethhdr->h_proto) != ETH_P_IPV6)
+		return BATADV_FORW_ALL;
+
+	/* We might fail due to out-of-memory -> drop it */
+	if (!pskb_may_pull(skb, sizeof(*ethhdr) + sizeof(*ip6hdr)))
+		return BATADV_FORW_NONE;
+
+	ip6hdr = ipv6_hdr(skb);
+
+	/* TODO: Implement Multicast Router Discovery, then add
+	 * scope >= IPV6_ADDR_SCOPE_LINKLOCAL, too
+	 */
+	if (IPV6_ADDR_MC_SCOPE(&ip6hdr->daddr) !=
+	    IPV6_ADDR_SCOPE_LINKLOCAL)
+		return BATADV_FORW_ALL;
+
+	/* We cannot snoop and therefore cannot optimize the
+	 * all-nodes-multicast address
+	 */
+	if (ipv6_addr_is_ll_all_nodes(&ip6hdr->daddr))
+		return BATADV_FORW_ALL;
+
+	count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
+					    BATADV_NO_FLAGS);
+
+	switch (count) {
+	case 0:
+		return BATADV_FORW_NONE;
+	case 1:
+		return BATADV_FORW_SINGLE;
+	default:
+		return BATADV_FORW_ALL;
+	}
+}
+
+/**
  * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
@@ -264,6 +320,10 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 	batadv_mcast_mla_tt_clean(bat_priv, NULL);
 }
 
+/**
+ * batadv_mcast_purge_orig - reset originator global mcast state modifications
+ * @orig_node: the originator which is going to get purged
+ */
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node)
 {
 	if (!(orig_node->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT))
diff --git a/multicast.h b/multicast.h
index d8bb869..c48bb8c 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -20,10 +20,27 @@
 #ifndef _NET_BATMAN_ADV_MULTICAST_H_
 #define _NET_BATMAN_ADV_MULTICAST_H_
 
+/**
+ * batadv_forw_mode - the way a packet should be forwarded as
+ * @BATADV_FORW_ALL: forward the packet to all nodes
+ *  (currently via classic flooding)
+ * @BATADV_FORW_SINGLE: forward the packet to a single node
+ *  (currently via the BATMAN_IV unicast routing protocol)
+ * @BATADV_FORW_NONE: don't forward, drop it
+ */
+enum batadv_forw_mode {
+	BATADV_FORW_ALL,
+	BATADV_FORW_SINGLE,
+	BATADV_FORW_NONE,
+};
+
 #ifdef CONFIG_BATMAN_ADV_MCAST
 
 void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv);
 
+enum batadv_forw_mode
+batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv);
+
 int batadv_mcast_init(struct batadv_priv *bat_priv);
 
 void batadv_mcast_free(struct batadv_priv *bat_priv);
@@ -37,6 +54,12 @@ static inline void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
 	return;
 }
 
+static inline enum batadv_forw_mode
+batadv_mcast_forw_mode(struct sk_buff *skb, struct batadv_priv *bat_priv)
+{
+	return BATADV_FORW_ALL;
+}
+
 static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
 {
 	return 0;
diff --git a/soft-interface.c b/soft-interface.c
index 1992c42..8fad00e 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -34,6 +34,7 @@
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include "multicast.h"
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
 
@@ -169,6 +170,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	bool do_bcast = false;
 	unsigned short vid;
 	uint32_t seqno;
+	enum batadv_forw_mode mode;
+	bool forw_to_gw = false;
 
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
@@ -226,13 +229,24 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			 * via unicast to their gateway
 			 */
 			ret = batadv_gw_is_dhcp_target(skb, &header_len);
-			if (ret)
+			if (ret) {
 				do_bcast = false;
+				forw_to_gw = true;
+			}
 			break;
 		case BATADV_GW_MODE_OFF:
 		default:
 			break;
 		}
+
+		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
+			mode = batadv_mcast_forw_mode(skb, bat_priv);
+			if (mode == BATADV_FORW_NONE)
+				goto dropped;
+
+			if (mode == BATADV_FORW_SINGLE)
+				do_bcast = false;
+		}
 	}
 
 	/* ethernet packet should be broadcasted */
@@ -289,7 +303,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 		batadv_dat_snoop_outgoing_arp_reply(bat_priv, skb);
 
-		if (is_multicast_ether_addr(ethhdr->h_dest))
+		if (forw_to_gw)
 			ret = batadv_send_skb_via_gw(bat_priv, skb, vid);
 		else
 			ret = batadv_send_skb_via_tt(bat_priv, skb, vid);
diff --git a/translation-table.c b/translation-table.c
index 1a2fb69..fff0d45 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -195,6 +195,32 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 	}
 }
 
+/**
+ * batadv_tt_global_hash_count - count the number of orig entries
+ * @hash: hash table containing the tt entries
+ * @addr: the mac address of the client to count entries for
+ * @vid: VLAN identifier
+ *
+ * Return the number of originators advertising the given address/data
+ * (excluding ourself).
+ */
+int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
+				const uint8_t *addr, unsigned short vid)
+{
+	struct batadv_tt_global_entry *tt_global_entry;
+	int count = 0;
+
+	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
+	if (!tt_global_entry)
+		goto out;
+
+	count = atomic_read(&tt_global_entry->orig_list_count);
+	batadv_tt_global_entry_free_ref(tt_global_entry);
+
+out:
+	return count;
+}
+
 static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
@@ -875,6 +901,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	hlist_add_head_rcu(&orig_entry->list,
 			   &tt_global->orig_list);
 	spin_unlock_bh(&tt_global->list_lock);
+	atomic_inc(&tt_global->orig_list_count);
+
 out:
 	if (orig_entry)
 		batadv_tt_orig_list_entry_free_ref(orig_entry);
@@ -944,6 +972,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		common->added_at = jiffies;
 
 		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
+		atomic_set(&tt_global_entry->orig_list_count, 0);
 		spin_lock_init(&tt_global_entry->list_lock);
 
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
@@ -1164,6 +1193,23 @@ out:
 	return 0;
 }
 
+/**
+ * batadv_tt_global_del_orig_entry - remove and free an orig_entry
+ * @tt_global_entry: the global entry to remove the orig_entry from
+ * @orig_entry: the orig entry to remove and free
+ *
+ * Remove an orig_entry from its list in the given tt_global_entry and
+ * free this orig_entry afterwards.
+ */
+static void
+batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
+				struct batadv_tt_orig_list_entry *orig_entry)
+{
+	atomic_dec(&tt_global_entry->orig_list_count);
+	hlist_del_rcu(&orig_entry->list);
+	batadv_tt_orig_list_entry_free_ref(orig_entry);
+}
+
 /* deletes the orig list of a tt_global_entry */
 static void
 batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
@@ -1174,18 +1220,26 @@ batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 
 	spin_lock_bh(&tt_global_entry->list_lock);
 	head = &tt_global_entry->orig_list;
-	hlist_for_each_entry_safe(orig_entry, safe, head, list) {
-		hlist_del_rcu(&orig_entry->list);
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
-	}
+	hlist_for_each_entry_safe(orig_entry, safe, head, list)
+		batadv_tt_global_del_orig_entry(tt_global_entry, orig_entry);
 	spin_unlock_bh(&tt_global_entry->list_lock);
 }
 
+/**
+ * batadv_tt_global_del_orig_node - remove orig_node from a global tt entry
+ * @bat_priv: the bat priv with all the soft interface information
+ * @tt_global_entry: the global entry to remove the orig_node from
+ * @orig_node: the originator announcing the client
+ * @message: message to append to the log on deletion
+ *
+ * Remove the given orig_node and its according orig_entry from the given
+ * global tt entry.
+ */
 static void
-batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
-				struct batadv_tt_global_entry *tt_global_entry,
-				struct batadv_orig_node *orig_node,
-				const char *message)
+batadv_tt_global_del_orig_node(struct batadv_priv *bat_priv,
+			       struct batadv_tt_global_entry *tt_global_entry,
+			       struct batadv_orig_node *orig_node,
+			       const char *message)
 {
 	struct hlist_head *head;
 	struct hlist_node *safe;
@@ -1202,8 +1256,8 @@ batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
 				   orig_node->orig,
 				   tt_global_entry->common.addr,
 				   BATADV_PRINT_VID(vid), message);
-			hlist_del_rcu(&orig_entry->list);
-			batadv_tt_orig_list_entry_free_ref(orig_entry);
+			batadv_tt_global_del_orig_entry(tt_global_entry,
+							orig_entry);
 		}
 	}
 	spin_unlock_bh(&tt_global_entry->list_lock);
@@ -1245,8 +1299,8 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 		/* there is another entry, we can simply delete this
 		 * one and can still use the other one.
 		 */
-		batadv_tt_global_del_orig_entry(bat_priv, tt_global_entry,
-						orig_node, message);
+		batadv_tt_global_del_orig_node(bat_priv, tt_global_entry,
+					       orig_node, message);
 }
 
 /**
@@ -1272,8 +1326,8 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 		goto out;
 
 	if (!roaming) {
-		batadv_tt_global_del_orig_entry(bat_priv, tt_global_entry,
-						orig_node, message);
+		batadv_tt_global_del_orig_node(bat_priv, tt_global_entry,
+					       orig_node, message);
 
 		if (hlist_empty(&tt_global_entry->orig_list))
 			batadv_tt_global_free(bat_priv, tt_global_entry,
@@ -1342,8 +1396,8 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 						 struct batadv_tt_global_entry,
 						 common);
 
-			batadv_tt_global_del_orig_entry(bat_priv, tt_global,
-							orig_node, message);
+			batadv_tt_global_del_orig_node(bat_priv, tt_global,
+						       orig_node, message);
 
 			if (hlist_empty(&tt_global->orig_list)) {
 				vid = tt_global->common.vid;
diff --git a/translation-table.h b/translation-table.h
index c6bf33c..396e7e1 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -31,6 +31,8 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       const char *message);
+int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
+				const uint8_t *addr, unsigned short vid);
 struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 						  const uint8_t *src,
 						  const uint8_t *addr,
diff --git a/types.h b/types.h
index ceb96b0..7535c69 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -784,12 +784,14 @@ struct batadv_tt_local_entry {
  * struct batadv_tt_global_entry - translation table global entry data
  * @common: general translation table data
  * @orig_list: list of orig nodes announcing this non-mesh client
+ * @orig_list_count: number of items in the orig_list
  * @list_lock: lock protecting orig_list
  * @roam_at: time at which TT_GLOBAL_ROAM was set
  */
 struct batadv_tt_global_entry {
 	struct batadv_tt_common_entry common;
 	struct hlist_head orig_list;
+	atomic_t orig_list_count;
 	spinlock_t list_lock;	/* protects orig_list */
 	unsigned long roam_at;
 };
-- 
1.7.10.4

