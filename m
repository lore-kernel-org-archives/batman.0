Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  9 Feb 2014 04:48:58 +0100
Message-Id: <1391917738-4483-7-git-send-email-linus.luessing@web.de>
In-Reply-To: <1391917738-4483-1-git-send-email-linus.luessing@web.de>
References: <1391917738-4483-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv13 6/6] batman-adv: Send multicast packets to
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
 main.c           |    2 +
 multicast.c      |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h      |   12 ++++-
 packet.h         |    4 ++
 send.c           |    1 +
 soft-interface.c |    2 +
 types.h          |   14 +++++-
 7 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index 57b09fa..d1183e8 100644
--- a/main.c
+++ b/main.c
@@ -123,6 +123,8 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->gw.list);
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_unsnoopables_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv4_list);
+	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv6_list);
 #endif
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
 	INIT_LIST_HEAD(&bat_priv->tt.req_list);
diff --git a/multicast.c b/multicast.c
index c0b29bc..ae9ae06 100644
--- a/multicast.c
+++ b/multicast.c
@@ -416,6 +416,109 @@ out:
 }
 
 /**
+ * batadv_mcast_want_ipv4_count - count the number of WANT_ALL_IPV4 nodes
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: a pointer to set to a node with a WANT_ALL_IPV4 flag
+ *
+ * Set an orig_node with a BATADV_MCAST_WANT_ALL_IPV4 flag and increase its
+ * refcount if *orig_node was not set yet. Or keep it unchanged if none with
+ * such a flag was found. Finally return the total number of orig_nodes with
+ * this flag.
+ */
+static int batadv_mcast_want_ipv4_count(struct batadv_priv *bat_priv,
+					struct batadv_orig_node **orig_node)
+{
+	int ret = atomic_read(&bat_priv->mcast.num_want_all_ipv4);
+
+	if (!ret || *orig_node)
+		goto out;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(*orig_node,
+				 &bat_priv->mcast.want_all_ipv4_list,
+				 mcast_want_all_ipv4_node) {
+		if (atomic_inc_not_zero(&(*orig_node)->refcount))
+			goto unlock;
+	}
+
+	*orig_node = NULL;
+	ret = 0;
+
+unlock:
+	rcu_read_unlock();
+out:
+	return ret;
+}
+
+/**
+ * batadv_mcast_want_ipv6_count - count the number of WANT_ALL_IPV6 nodes
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: a pointer to set to a node with a WANT_ALL_IPV6 flag
+ *
+ * Set an orig_node with a BATADV_MCAST_WANT_ALL_IPV6 flag and increase its
+ * refcount if *orig_node was not set yet. Or keep it unchanged if none with
+ * such a flag was found. Finally return the total number of orig_nodes with
+ * this flag.
+ */
+static int batadv_mcast_want_ipv6_count(struct batadv_priv *bat_priv,
+					struct batadv_orig_node **orig_node)
+{
+	int ret = atomic_read(&bat_priv->mcast.num_want_all_ipv6);
+
+	if (!ret || *orig_node)
+		goto out;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(*orig_node,
+				 &bat_priv->mcast.want_all_ipv6_list,
+				 mcast_want_all_ipv6_node) {
+		if (atomic_inc_not_zero(&(*orig_node)->refcount))
+			goto unlock;
+	}
+
+	*orig_node = NULL;
+	ret = 0;
+
+unlock:
+	rcu_read_unlock();
+out:
+	return ret;
+}
+
+/**
+ * batadv_mcast_want_count - number of nodes with unspecific mcast interest
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ethhdr: ethernet header of a packet
+ * @orig_node: a pointer to set to a node with a WANT_ALL_IPV4/6 flag
+ *
+ * Return the number of nodes which want all IPv4 multicast traffic if
+ * the given ethhdr is from an IPv4 packet or the number of nodes which want
+ * all IPv6 traffic if it matches an IPv6 packet and set the orig_node pointer
+ * to a matching node. For other frame types leave the orig_node untouched
+ * and return zero.
+ */
+static int batadv_mcast_want_ip_count(struct batadv_priv *bat_priv,
+				      struct ethhdr *ethhdr,
+				      struct batadv_orig_node **orig_node)
+{
+	int ret;
+
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		ret = batadv_mcast_want_ipv4_count(bat_priv, orig_node);
+		break;
+	case ETH_P_IPV6:
+		ret = batadv_mcast_want_ipv6_count(bat_priv, orig_node);
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
  * batadv_mcast_want_unsnoop_count - count the number of WANT_ALL_UNSNOOPABLES
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: a pointer to set to a node with a WANT_ALL_UNSNOOPABLES flag
@@ -476,6 +579,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		return BATADV_FORW_ALL;
 
 	ret = batadv_mcast_tt_count(bat_priv, ethhdr, mcast_single_orig);
+	ret += batadv_mcast_want_ip_count(bat_priv, ethhdr, mcast_single_orig);
 
 	if (is_unsnoopable)
 		ret += batadv_mcast_want_unsnoop_count(bat_priv,
@@ -596,11 +700,35 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
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
 	batadv_mcast_list_update(BATADV_MCAST_WANT_ALL_UNSNOOPABLES,
 				 &orig->mcast_want_all_unsnoopables_node,
 				 &bat_priv->mcast.want_all_unsnoopables_list,
 				 &bat_priv->mcast.want_lists_lock,
 				 mcast_flags, orig->mcast_flags);
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
 
 	orig->mcast_flags = mcast_flags;
 }
@@ -640,10 +768,24 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 		atomic_dec(&bat_priv->mcast.num_disabled);
 	if (orig->mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES)
 		atomic_dec(&bat_priv->mcast.num_want_all_unsnoopables);
+	if (orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV4)
+		atomic_dec(&bat_priv->mcast.num_want_all_ipv4);
+	if (orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV6)
+		atomic_dec(&bat_priv->mcast.num_want_all_ipv6);
 
 	batadv_mcast_list_update(BATADV_MCAST_WANT_ALL_UNSNOOPABLES,
 				 &orig->mcast_want_all_unsnoopables_node,
 				 &bat_priv->mcast.want_all_unsnoopables_list,
 				 &bat_priv->mcast.want_lists_lock,
 				 BATADV_NO_FLAGS, orig->mcast_flags);
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
index 61e631b..0a77159 100644
--- a/multicast.h
+++ b/multicast.h
@@ -43,6 +43,9 @@ void batadv_mcast_free(struct batadv_priv *bat_priv);
 
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
 
+struct batadv_orig_node *
+batadv_mcast_want_all_node_get(struct hlist_head *want_all_list,
+			       struct batadv_priv *bat_priv);
 #else
 
 static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
@@ -51,7 +54,8 @@ static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 }
 
 static inline enum batadv_forw_mode
-batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb)
+batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
+		       struct hlist_head **want_all_list)
 {
 	return BATADV_FORW_ALL;
 }
@@ -71,6 +75,12 @@ static inline void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node)
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
index ef4c93e..aad6d4b 100644
--- a/send.c
+++ b/send.c
@@ -27,6 +27,7 @@
 #include "originator.h"
 #include "network-coding.h"
 #include "fragmentation.h"
+#include "multicast.h"
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
 
diff --git a/soft-interface.c b/soft-interface.c
index bfbb1de..e7c96dd 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -714,6 +714,8 @@ static int batadv_softif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->multicast_mode, 1);
 	atomic_set(&bat_priv->mcast.num_disabled, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
+	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
 #endif
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
diff --git a/types.h b/types.h
index 1a674cb..d4b923c 100644
--- a/types.h
+++ b/types.h
@@ -207,6 +207,8 @@ struct batadv_orig_bat_iv {
  * @mcast_flags: multicast flags announced by the orig node
  * @mcast_want_all_unsnoop_node: a list node for the
  *  mcast.want_all_unsnoopables list
+ * @mcast_want_all_ipv4_node: a list node for the mcast.want_all_ipv4 list
+ * @mcast_want_all_ipv6_node: a list node for the mcast.want_all_ipv6 list
  * @capabilities: announced capabilities of this originator
  * @capa_initialized: bitfield to remember whether a capability was initialized
  * @last_ttvn: last seen translation table version number
@@ -252,6 +254,8 @@ struct batadv_orig_node {
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	uint8_t mcast_flags;
 	struct hlist_node mcast_want_all_unsnoopables_node;
+	struct hlist_node mcast_want_all_ipv4_node;
+	struct hlist_node mcast_want_all_ipv6_node;
 #endif
 	uint8_t capabilities;
 	uint8_t capa_initialized;
@@ -624,21 +628,29 @@ struct batadv_priv_dat {
  * @mla_list: list of multicast addresses we are currently announcing via TT
  * @want_all_unsnoopables_list: a list of orig_nodes wanting all unsnoopable
  *  multicast traffic
+ * @want_all_ipv4_list: a list of orig_nodes wanting all IPv4 multicast traffic
+ * @want_all_ipv6_list: a list of orig_nodes wanting all IPv6 multicast traffic
  * @flags: the flags we have last sent in our mcast tvlv
  * @enabled: whether the multicast tvlv is currently enabled
  * @num_disabled: number of nodes that have no mcast tvlv
  * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP traffic
+ * @num_want_all_ipv4: counter for items in want_all_ipv4_list
+ * @num_want_all_ipv6: counter for items in want_all_ipv6_list
  * @want_lists_lock: lock for protecting modifications to mcast want lists
  *  (traversals are rcu-locked)
  */
 struct batadv_priv_mcast {
 	struct hlist_head mla_list;
 	struct hlist_head want_all_unsnoopables_list;
+	struct hlist_head want_all_ipv4_list;
+	struct hlist_head want_all_ipv6_list;
 	uint8_t flags;
 	bool enabled;
 	atomic_t num_disabled;
 	atomic_t num_want_all_unsnoopables;
-	/* protects want_all_unsnoopables_list */
+	atomic_t num_want_all_ipv4;
+	atomic_t num_want_all_ipv6;
+	/* protects want_all_{unsnoopables,ipv4,ipv6}_list */
 	spinlock_t want_lists_lock;
 };
 #endif
-- 
1.7.10.4

