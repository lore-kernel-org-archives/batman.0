Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 14 Jun 2013 11:02:05 +0200
Message-Id: <1371200525-2011-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1371200525-2011-1-git-send-email-linus.luessing@web.de>
References: <1371200525-2011-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv5 3/3] batman-adv: Modified forwarding
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
 multicast.c             |   56 +++++++++++++++++++++++++++++++++++++
 multicast.h             |   23 +++++++++++++++
 send.c                  |    5 ++--
 send.h                  |    9 +++---
 soft-interface.c        |   18 ++++++++++--
 translation-table.c     |   71 +++++++++++++++++++++++++++++++++++++++++++++++
 translation-table.h     |    2 ++
 8 files changed, 177 insertions(+), 9 deletions(-)

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
index 18a2051..87287c7 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -125,6 +125,77 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const uint8_t *addr,
 }
 
 /**
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
+ * @addr: the mac address of the client to count entries for
+ * @vid: VLAN identifier
+ *
+ * Return the number of originators advertising the given address/data
+ * (excluding ourself).
+ */
+int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
+				const uint8_t *addr, unsigned short vid)
+{
+	struct hlist_head *head, *orig_list;
+	struct batadv_tt_common_entry to_search, *tt_common_entry;
+	struct batadv_tt_global_entry *tt_global_entry;
+	uint32_t index;
+	int count = 0;
+
+	if (!bat_priv->tt.global_hash)
+		goto out;
+
+	memcpy(to_search.addr, addr, ETH_ALEN);
+	to_search.vid = vid;
+
+	index = batadv_choose_tt(&to_search, bat_priv->tt.global_hash->size);
+	head = &bat_priv->tt.global_hash->table[index];
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tt_common_entry, head, hash_entry) {
+		if (!batadv_compare_eth(tt_common_entry, addr))
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
+/**
  * batadv_tt_local_hash_find - search the local table for a given client
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to look for
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
-- 
1.7.10.4

