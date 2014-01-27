Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 27 Jan 2014 10:48:36 +0100
Message-Id: <1390816116-23804-7-git-send-email-linus.luessing@web.de>
In-Reply-To: <1390816116-23804-1-git-send-email-linus.luessing@web.de>
References: <1390816116-23804-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: Send multicast packets to
	nodes with a WANT_ALL flag
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

With this patch a node sends IPv4 multicast packets to nodes which
have a BATADV_MCAST_WANT_ALL_IPV4 flag set and IPv6 multicast packets
to nodes which have a BATADV_MCAST_WANT_ALL_IPV6 flag set, too.

Why is this needed? There are scenarios involving bridges where
multicast report snooping and multicast TT announcements are not
sufficient, which would lead to packet loss for some nodes otherwise:

MLDv1 and IGMPv1/IGMPv2 have a suppression mechanism
for multicast listener reports. When we have an MLDv1/IGMPv1/IGMPv2
querier behind a bridge then our snooping bridge is potentially not
going to see any reports even though listeners exist because according
to RFC4541 such reports are only forwarded to multicast routers:

-----------------------------------------------------------
            ---------------
{Querier}---|Snoop. Switch|----{Listener}
            ---------------
                       \           ^
                      -------
                      | br0 |  <  ???
                      -------
                          \
                     _-~---~_
                 _-~/        ~-_
                ~   batman-adv  \-----{Sender}
                \~_   cloud    ~/
                   -~~__-__-~_/

I)  MLDv1 Query:  {Querier}  -> flooded
II) MLDv1 Report: {Listener} -> {Querier}

-> br0 cannot detect the {Listener}
=> Packets from {Sender} need to be forwarded to all
   detected listeners and MLDv1/IGMPv1/IGMPv2 queriers.

-----------------------------------------------------------

Note that we do not need to explicitly forward to MLDv2/IGMPv3 queriers,
because these protocols have no report suppression: A bridge has no
trouble detecting MLDv2/IGMPv3 listeners.

Even though we do not support bridges yet we need to provide the
according infrastructure already to not break compatibility later.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.c           |    7 ++
 multicast.c      |  200 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 multicast.h      |   15 +++-
 packet.h         |    4 ++
 send.c           |   23 +++++++
 send.h           |    3 +
 soft-interface.c |    9 ++-
 types.h          |   16 +++++
 8 files changed, 273 insertions(+), 4 deletions(-)

diff --git a/main.c b/main.c
index 8f11b67..0f89deb 100644
--- a/main.c
+++ b/main.c
@@ -111,6 +111,9 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->tt.last_changeset_lock);
 	spin_lock_init(&bat_priv->tt.commit_lock);
 	spin_lock_init(&bat_priv->gw.list_lock);
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	spin_lock_init(&bat_priv->mcast.want_lists_lock);
+#endif
 	spin_lock_init(&bat_priv->tvlv.container_list_lock);
 	spin_lock_init(&bat_priv->tvlv.handler_list_lock);
 	spin_lock_init(&bat_priv->softif_vlan_list_lock);
@@ -118,6 +121,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
 	INIT_HLIST_HEAD(&bat_priv->gw.list);
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv4_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv6_list);
+#endif
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
 	INIT_LIST_HEAD(&bat_priv->tt.req_list);
 	INIT_LIST_HEAD(&bat_priv->tt.roam_list);
diff --git a/multicast.c b/multicast.c
index cd85378..d6b9a7d 100644
--- a/multicast.c
+++ b/multicast.c
@@ -382,14 +382,53 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_mcast_want_all_count - number of nodes with unspecific mcast interest
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ethhdr: ethernet header of a packet
+ * @want_all_list: pointer to a mcast want list in our bat_priv
+ *
+ * Return the number of nodes which want all IPv4 multicast traffic if
+ * the given ethhdr is from an IPv4 packet or the number of nodes which want
+ * all IPv6 traffic if it matches an IPv6 packet and set the want_list to the
+ * according one in our bat_priv. For other frame types leave the want_list
+ * untouched and return zero.
+ */
+static int batadv_mcast_want_all_count(struct batadv_priv *bat_priv,
+				       struct ethhdr *ethhdr,
+				       struct hlist_head **want_all_list)
+{
+	int ret;
+
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		ret = atomic_read(&bat_priv->mcast.num_want_all_ipv4);
+		if (ret)
+			*want_all_list = &bat_priv->mcast.want_all_ipv4_list;
+		break;
+	case ETH_P_IPV6:
+		ret = atomic_read(&bat_priv->mcast.num_want_all_ipv6);
+		if (ret)
+			*want_all_list = &bat_priv->mcast.want_all_ipv6_list;
+		break;
+	default:
+		/* we shouldn't be here... */
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/**
  * batadv_mcast_forw_mode - check on how to forward a multicast packet
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: The multicast packet to check
+ * @want_all_list: pointer to a mcast want list in our bat_priv
  *
  * Return the forwarding mode as enum batadv_forw_mode.
  */
 enum batadv_forw_mode
-batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb)
+batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
+		       struct hlist_head **want_all_list)
 {
 	struct ethhdr *ethhdr = eth_hdr(skb);
 	int ret;
@@ -402,6 +441,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb)
 
 	ret = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
 					  BATADV_NO_FLAGS);
+	ret += batadv_mcast_want_all_count(bat_priv, ethhdr, want_all_list);
 
 	switch (ret) {
 	case 0:
@@ -414,6 +454,124 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb)
 }
 
 /**
+ * batadv_mcast_want_all_ipv4_node_get - get an orig_node with want_all_ipv4
+ * @head: list of originators that want all IPv4 multicast traffic
+ *
+ * Return the first orig_node from the given want_all_ipv4 list. Increases
+ * the refcount of the returned orig_node.
+ */
+static struct batadv_orig_node *
+batadv_mcast_want_all_ipv4_node_get(struct hlist_head *head)
+{
+	struct batadv_orig_node *orig_node = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node, head,
+				 mcast_want_all_ipv4_node) {
+		if (atomic_inc_not_zero(&orig_node->refcount))
+			break;
+	}
+	rcu_read_unlock();
+
+	return orig_node;
+}
+
+/**
+ * batadv_mcast_want_all_ipv6_node_get - get an orig_node with want_all_ipv6
+ * @head: list of originators that want all IPv6 multicast traffic
+ *
+ * Return the first orig_node from the given want_all_ipv6 list. Increases
+ * the refcount of the returned orig_node.
+ */
+static struct batadv_orig_node *
+batadv_mcast_want_all_ipv6_node_get(struct hlist_head *head)
+{
+	struct batadv_orig_node *orig_node = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node, head,
+				 mcast_want_all_ipv6_node) {
+		if (atomic_inc_not_zero(&orig_node->refcount))
+			break;
+	}
+	rcu_read_unlock();
+
+	return orig_node;
+}
+
+/**
+ * batadv_mcast_want_all_node_get - get an orig_node with an mcast want list
+ * @want_all_list: list of originators that want all IPv4 or IPv6 mcast traffic
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return the first orig_node from the given want_all list. Increases the
+ * refcount of the returned orig_node.
+ */
+struct batadv_orig_node *
+batadv_mcast_want_all_node_get(struct hlist_head *want_all_list,
+			       struct batadv_priv *bat_priv)
+{
+	if (want_all_list == &bat_priv->mcast.want_all_ipv4_list)
+		return batadv_mcast_want_all_ipv4_node_get(want_all_list);
+	else if (want_all_list == &bat_priv->mcast.want_all_ipv6_list)
+		return batadv_mcast_want_all_ipv6_node_get(want_all_list);
+	else
+		return NULL;
+}
+
+/**
+ * batadv_mcast_list_add - grab a lock and add a node to a head
+ * @node: the node to add
+ * @head: the head to add the node to
+ * @lock: the lock to grab while adding the node to the head
+ */
+static void batadv_mcast_list_add(struct hlist_node *node,
+				  struct hlist_head *head,
+				  spinlock_t *lock)
+{
+	spin_lock_bh(lock);
+	hlist_add_head_rcu(node, head);
+	spin_unlock_bh(lock);
+}
+
+/**
+ * batadv_mcast_list_del - grab a lock and delete a node from its list
+ * @node: the node to delete from its list
+ * @lock: the lock to grab while deleting the node from its list
+ */
+static void batadv_mcast_list_del(struct hlist_node *node, spinlock_t *lock)
+{
+	spin_lock_bh(lock);
+	hlist_del_rcu(node);
+	spin_unlock_bh(lock);
+}
+
+/**
+ * batadv_mcast_list_update - update the list of a flag
+ * @flag: the flag we want to update the list for
+ * @node: a list node of an originator
+ * @head: the list head the node might be added to
+ * @lock: the lock that synchronizes list modifications
+ * @new_flags: the new capability bitset of a node
+ * @old_flags: the current, to be updated bitset of a node
+ *
+ * Update the list of the given node/head with the help of the new flag
+ * information of an originator to contain the nodes which have the given
+ * flag set.
+ */
+static void batadv_mcast_list_update(uint8_t flag,
+				     struct hlist_node *node,
+				     struct hlist_head *head,
+				     spinlock_t *lock,
+				     uint8_t new_flags, int old_flags)
+{
+	if (new_flags & flag && !(old_flags & flag))
+		batadv_mcast_list_add(node, head, lock);
+	else if (!(new_flags & flag) && old_flags & flag)
+		batadv_mcast_list_del(node, lock);
+}
+
+/**
  * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
@@ -464,6 +622,31 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 		 orig->mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES)
 		atomic_dec(&bat_priv->mcast.num_want_all_unsnoopables);
 
+	if (mcast_flags & BATADV_MCAST_WANT_ALL_IPV4 &&
+	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV4))
+		atomic_inc(&bat_priv->mcast.num_want_all_ipv4);
+	else if (!(mcast_flags & BATADV_MCAST_WANT_ALL_IPV4) &&
+		 orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV4)
+		atomic_dec(&bat_priv->mcast.num_want_all_ipv4);
+
+	if (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6 &&
+	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV6))
+		atomic_inc(&bat_priv->mcast.num_want_all_ipv6);
+	else if (!(mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) &&
+		 orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV6)
+		atomic_dec(&bat_priv->mcast.num_want_all_ipv6);
+
+	batadv_mcast_list_update(BATADV_MCAST_WANT_ALL_IPV4,
+				 &orig->mcast_want_all_ipv4_node,
+				 &bat_priv->mcast.want_all_ipv4_list,
+				 &bat_priv->mcast.want_lists_lock,
+				 mcast_flags, orig->mcast_flags);
+	batadv_mcast_list_update(BATADV_MCAST_WANT_ALL_IPV6,
+				 &orig->mcast_want_all_ipv6_node,
+				 &bat_priv->mcast.want_all_ipv6_list,
+				 &bat_priv->mcast.want_lists_lock,
+				 mcast_flags, orig->mcast_flags);
+
 	orig->mcast_flags = mcast_flags;
 }
 
@@ -502,4 +685,19 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 		atomic_dec(&bat_priv->mcast.num_disabled);
 	if (orig->mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES)
 		atomic_dec(&bat_priv->mcast.num_want_all_unsnoopables);
+	if (orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV4)
+		atomic_dec(&bat_priv->mcast.num_want_all_ipv4);
+	if (orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV6)
+		atomic_dec(&bat_priv->mcast.num_want_all_ipv6);
+
+	batadv_mcast_list_update(BATADV_MCAST_WANT_ALL_IPV4,
+				 &orig->mcast_want_all_ipv4_node,
+				 &bat_priv->mcast.want_all_ipv4_list,
+				 &bat_priv->mcast.want_lists_lock,
+				 BATADV_NO_FLAGS, orig->mcast_flags);
+	batadv_mcast_list_update(BATADV_MCAST_WANT_ALL_IPV6,
+				 &orig->mcast_want_all_ipv6_node,
+				 &bat_priv->mcast.want_all_ipv6_list,
+				 &bat_priv->mcast.want_lists_lock,
+				 BATADV_NO_FLAGS, orig->mcast_flags);
 }
diff --git a/multicast.h b/multicast.h
index d92f689..3dfc2e9 100644
--- a/multicast.h
+++ b/multicast.h
@@ -34,7 +34,8 @@ enum batadv_forw_mode {
 void batadv_mcast_mla_update(struct batadv_priv *bat_priv);
 
 enum batadv_forw_mode
-batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb);
+batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
+		       struct hlist_head **want_all_list);
 
 void batadv_mcast_init(struct batadv_priv *bat_priv);
 
@@ -42,6 +43,9 @@ void batadv_mcast_free(struct batadv_priv *bat_priv);
 
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
 
+struct batadv_orig_node *
+batadv_mcast_want_all_node_get(struct hlist_head *want_all_list,
+			       struct batadv_priv *bat_priv);
 #else
 
 static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
@@ -50,7 +54,8 @@ static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 }
 
 static inline enum batadv_forw_mode
-batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb)
+batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
+		       struct hlist_head **want_all_list)
 {
 	return BATADV_FORW_ALL;
 }
@@ -70,6 +75,12 @@ static inline void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node)
 	return;
 }
 
+static inline struct batadv_orig_node *
+batadv_mcast_want_all_node_get(struct hlist_head *want_all_list,
+			       struct batadv_priv *bat_priv)
+{
+	return NULL;
+}
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 #endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/packet.h b/packet.h
index 0aada24..feaa336 100644
--- a/packet.h
+++ b/packet.h
@@ -93,9 +93,13 @@ enum batadv_icmp_packettype {
  * enum batadv_mcast_flags - flags for multicast capabilities and settings
  * @BATADV_MCAST_WANT_ALL_UNSNOOPABLES: we want all packets destined for
  *  224.0.0.0/24 or ff02::1
+ * @BATADV_MCAST_WANT_ALL_IPV4: we want all IPv4 multicast packets
+ * @BATADV_MCAST_WANT_ALL_IPV6: we want all IPv6 multicast packets
  */
 enum batadv_mcast_flags {
 	BATADV_MCAST_WANT_ALL_UNSNOOPABLES = BIT(0),
+	BATADV_MCAST_WANT_ALL_IPV4 = BIT(1),
+	BATADV_MCAST_WANT_ALL_IPV6 = BIT(2),
 };
 
 /* tt data subtypes */
diff --git a/send.c b/send.c
index 3d83bf9..0067311 100644
--- a/send.c
+++ b/send.c
@@ -27,6 +27,7 @@
 #include "originator.h"
 #include "network-coding.h"
 #include "fragmentation.h"
+#include "multicast.h"
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
 
@@ -365,6 +366,28 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 				       orig_node, vid);
 }
 
+/**
+ * batadv_send_skb_via_mcast - send an skb to a node with a WANT_ALL flag
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: payload to send
+ * @vid: the vid to be used to search the translation table
+ * @want_all_list: a list of originators with a WANT_ALL flag
+ *
+ * Get an originator node from the want_all_list. Wrap the given skb into a
+ * batman-adv unicast header and send this frame to this node.
+ */
+int batadv_send_skb_via_mcast(struct batadv_priv *bat_priv,
+			      struct sk_buff *skb, unsigned short vid,
+			      struct hlist_head *want_all_list)
+
+{
+	struct batadv_orig_node *orig_node;
+
+	orig_node = batadv_mcast_want_all_node_get(want_all_list, bat_priv);
+	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
+				       orig_node, vid);
+}
+
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
diff --git a/send.h b/send.h
index aaddaa9..e28c0db 100644
--- a/send.h
+++ b/send.h
@@ -42,6 +42,9 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
 				   unsigned short vid);
 int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			   unsigned short vid);
+int batadv_send_skb_via_mcast(struct batadv_priv *bat_priv,
+			      struct sk_buff *skb, unsigned short vid,
+			      struct hlist_head *want_all_list);
 
 /**
  * batadv_send_skb_via_tt - send an skb via TT lookup
diff --git a/soft-interface.c b/soft-interface.c
index 706825a..e53f983 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -157,6 +157,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
 	__be16 ethertype = htons(ETH_P_BATMAN);
+	struct hlist_head *want_all_list = NULL;
 	static const uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00,
 						   0x00, 0x00};
 	static const uint8_t ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00,
@@ -252,7 +253,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
-			forw_mode = batadv_mcast_forw_mode(bat_priv, skb);
+			forw_mode = batadv_mcast_forw_mode(bat_priv, skb,
+							   &want_all_list);
 			if (forw_mode == BATADV_FORW_NONE)
 				goto dropped;
 
@@ -312,6 +314,9 @@ send:
 			if (ret)
 				goto dropped;
 			ret = batadv_send_skb_via_gw(bat_priv, skb, vid);
+		} else if (want_all_list) {
+			ret = batadv_send_skb_via_mcast(bat_priv, skb, vid,
+							want_all_list);
 		} else {
 			if (batadv_dat_snoop_outgoing_arp_request(bat_priv,
 								  skb))
@@ -708,6 +713,8 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->multicast_mode, 1);
 	atomic_set(&bat_priv->mcast.num_disabled, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
 #endif
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
diff --git a/types.h b/types.h
index a9ac674..3905486 100644
--- a/types.h
+++ b/types.h
@@ -205,6 +205,8 @@ struct batadv_orig_bat_iv {
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
  * @mcast_flags: multicast flags announced by the orig node
+ * @mcast_want_all_ipv4_node: a list node for the mcast.want_all_ipv4 list
+ * @mcast_want_all_ipv6_node: a list node for the mcast.want_all_ipv6 list
  * @capabilities: announced capabilities of this originator
  * @capa_initialized: bitfield to remember whether a capability was initialized
  * @last_ttvn: last seen translation table version number
@@ -249,6 +251,8 @@ struct batadv_orig_node {
 	unsigned long bcast_seqno_reset;
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	uint8_t mcast_flags;
+	struct hlist_node mcast_want_all_ipv4_node;
+	struct hlist_node mcast_want_all_ipv6_node;
 #endif
 	uint8_t capabilities;
 	uint8_t capa_initialized;
@@ -619,17 +623,29 @@ struct batadv_priv_dat {
 /**
  * struct batadv_priv_mcast - per mesh interface mcast data
  * @mla_list: list of multicast addresses we are currently announcing via TT
+ * @want_all_ipv4_list: a list of orig_nodes wanting all IPv4 multicast traffic
+ * @want_all_ipv6_list: a list of orig_nodes wanting all IPv6 multicast traffic
  * @flags: the flags we have last sent in our mcast tvlv
  * @enabled: whether the multicast tvlv is currently enabled
  * @num_disabled: number of nodes that have no mcast tvlv
  * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP traffic
+ * @num_want_all_ipv4: counter for items in want_all_ipv4_list
+ * @num_want_all_ipv6: counter for items in want_all_ipv6_list
+ * @want_lists_lock: lock for protecting modifications to mcast want lists
+ *  (traversals are rcu-locked)
  */
 struct batadv_priv_mcast {
 	struct hlist_head mla_list;
+	struct hlist_head want_all_ipv4_list;
+	struct hlist_head want_all_ipv6_list;
 	uint8_t flags;
 	bool enabled;
 	atomic_t num_disabled;
 	atomic_t num_want_all_unsnoopables;
+	atomic_t num_want_all_ipv4;
+	atomic_t num_want_all_ipv6;
+	/* protects want_all_ipv4_list & want_all_ipv6_list */
+	spinlock_t want_lists_lock;
 };
 #endif
 
-- 
1.7.10.4

