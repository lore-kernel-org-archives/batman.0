Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 14 Jun 2013 19:50:09 +0200
Message-Id: <1371232209-7808-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
References: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv6 3/3] batman-adv: Modified forwarding
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
 distributed-arp-table.c |    2 +-
 multicast.c             |   56 ++++++++++++++++++++++++++++++++++
 multicast.h             |   23 ++++++++++++++
 send.c                  |    5 ++--
 send.h                  |    9 +++---
 soft-interface.c        |   18 +++++++++--
 translation-table.c     |   76 +++++++++++++++++++++++++++++++++++++----------
 translation-table.h     |    2 ++
 types.h                 |    3 +-
 9 files changed, 168 insertions(+), 26 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index f2543c2..87248bb 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -1030,7 +1030,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 						    BATADV_P_DAT_CACHE_REPLY,
 						    vid);
 	else
-		err = batadv_send_skb_unicast(bat_priv, skb_new, vid);
+		err = batadv_send_skb_unicast(bat_priv, skb_new, vid, false);
 
 	if (!err) {
 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
diff --git a/multicast.c b/multicast.c
index 74fb19e..7a52a63 100644
--- a/multicast.c
+++ b/multicast.c
@@ -21,6 +21,7 @@
 #include "originator.h"
 #include "hard-interface.h"
 #include "translation-table.h"
+#include "multicast.h"
 
 struct batadv_hw_addr {
 	struct list_head	list;
@@ -210,6 +211,61 @@ out:
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
+	if (!atomic_read(&bat_priv->mcast_group_awareness))
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
diff --git a/multicast.h b/multicast.h
index aa58e4b..7b291d5 100644
--- a/multicast.h
+++ b/multicast.h
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
 #ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
 
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
diff --git a/send.c b/send.c
index b631355..68f65f1 100644
--- a/send.c
+++ b/send.c
@@ -242,13 +242,14 @@ out:
  * @packet_subtype: the unicast 4addr packet subtype (only relevant for unicast
  *  4addr packets)
  * @vid: the vid to be used to search the translation table
+ * @forw_to_gw: whether to forward to a gateway (or via TT otherwise)
  *
  * Returns 1 in case of error or 0 otherwise.
  */
 int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, int packet_type,
 				    int packet_subtype,
-				    unsigned short vid)
+				    unsigned short vid, bool forw_to_gw)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_unicast_packet *unicast_packet;
@@ -256,7 +257,7 @@ int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 	int ret = NET_RX_DROP;
 
 	/* get routing information */
-	if (is_multicast_ether_addr(ethhdr->h_dest))
+	if (forw_to_gw)
 		orig_node = batadv_gw_get_selected_orig(bat_priv);
 	else
 		/* check for tt host - increases orig_node refcount.
diff --git a/send.h b/send.h
index c030cb7..642f9fc 100644
--- a/send.h
+++ b/send.h
@@ -41,22 +41,23 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, int packet_type,
 				    int packet_subtype,
-				    unsigned short vid);
+				    unsigned short vid, bool forw_to_gw);
 
 /**
  * batadv_send_unicast_skb - send the skb encapsulated in a unicast packet
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
  * @vid: the vid to be used to search the translation table
+ * @forw_to_gw: whether to forward to a gateway (or via TT otherwise)
  *
  * Returns 1 in case of error or 0 otherwise.
  */
 static inline int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 					  struct sk_buff *skb,
-					  unsigned short vid)
+					  unsigned short vid, bool forw_to_gw)
 {
 	return batadv_send_skb_generic_unicast(bat_priv, skb, BATADV_UNICAST,
-					       0, vid);
+					       0, vid, forw_to_gw);
 }
 
 /**
@@ -76,7 +77,7 @@ static inline int batadv_send_skb_unicast_4addr(struct batadv_priv *bat_priv,
 {
 	return batadv_send_skb_generic_unicast(bat_priv, skb,
 					       BATADV_UNICAST_4ADDR,
-					       packet_subtype, vid);
+					       packet_subtype, vid, false);
 }
 
 #endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index 90d06c5..d91526f 100644
--- a/soft-interface.c
+++ b/soft-interface.c
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
 
-		ret = batadv_send_skb_unicast(bat_priv, skb, vid);
+		ret = batadv_send_skb_unicast(bat_priv, skb, vid, forw_to_gw);
 		if (ret != 0)
 			goto dropped_freed;
 	}
diff --git a/translation-table.c b/translation-table.c
index 18a2051..8453981 100644
--- a/translation-table.c
+++ b/translation-table.c
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
+	count = tt_global_entry->orig_list_count;
+	batadv_tt_global_entry_free_ref(tt_global_entry);
+
+out:
+	return count;
+}
+
 static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
@@ -874,7 +900,9 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_lock_bh(&tt_global->list_lock);
 	hlist_add_head_rcu(&orig_entry->list,
 			   &tt_global->orig_list);
+	tt_global->orig_list_count++;
 	spin_unlock_bh(&tt_global->list_lock);
+
 out:
 	if (orig_entry)
 		batadv_tt_orig_list_entry_free_ref(orig_entry);
@@ -944,6 +972,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		common->added_at = jiffies;
 
 		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
+		tt_global_entry->orig_list_count = 0;
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
+	hlist_del_rcu(&orig_entry->list);
+	tt_global_entry->orig_list_count--;
+	batadv_tt_orig_list_entry_free_ref(orig_entry);
+}
+
 /* deletes the orig list of a tt_global_entry */
 static void
 batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
@@ -1174,18 +1220,16 @@ batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 
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
@@ -1202,8 +1246,8 @@ batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
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
@@ -1245,8 +1289,8 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 		/* there is another entry, we can simply delete this
 		 * one and can still use the other one.
 		 */
-		batadv_tt_global_del_orig_entry(bat_priv, tt_global_entry,
-						orig_node, message);
+		batadv_tt_global_del_orig_node(bat_priv, tt_global_entry,
+					       orig_node, message);
 }
 
 /**
@@ -1272,8 +1316,8 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 		goto out;
 
 	if (!roaming) {
-		batadv_tt_global_del_orig_entry(bat_priv, tt_global_entry,
-						orig_node, message);
+		batadv_tt_global_del_orig_node(bat_priv, tt_global_entry,
+					       orig_node, message);
 
 		if (hlist_empty(&tt_global_entry->orig_list))
 			batadv_tt_global_free(bat_priv, tt_global_entry,
@@ -1342,8 +1386,8 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 						 struct batadv_tt_global_entry,
 						 common);
 
-			batadv_tt_global_del_orig_entry(bat_priv, tt_global,
-							orig_node, message);
+			batadv_tt_global_del_orig_node(bat_priv, tt_global,
+						       orig_node, message);
 
 			if (hlist_empty(&tt_global->orig_list)) {
 				vid = tt_global->common.vid;
diff --git a/translation-table.h b/translation-table.h
index 1d9506d..3916ca8 100644
--- a/translation-table.h
+++ b/translation-table.h
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
index 12d3ba7..f0f4a5c 100644
--- a/types.h
+++ b/types.h
@@ -769,7 +769,8 @@ struct batadv_tt_local_entry {
 struct batadv_tt_global_entry {
 	struct batadv_tt_common_entry common;
 	struct hlist_head orig_list;
-	spinlock_t list_lock;	/* protects orig_list */
+	unsigned int orig_list_count;
+	spinlock_t list_lock;	/* protects orig_list and orig_list_count */
 	unsigned long roam_at;
 };
 
-- 
1.7.10.4

