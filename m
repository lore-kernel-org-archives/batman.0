Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 15 Feb 2014 17:47:54 +0100
Message-Id: <1392482874-9024-7-git-send-email-linus.luessing@web.de>
In-Reply-To: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv14 6/6] batman-adv: Send multicast packets to
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
 multicast.c      |  178 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 packet.h         |    4 ++
 send.c           |    1 +
 soft-interface.c |    2 +
 types.h          |   14 ++++-
 6 files changed, 198 insertions(+), 3 deletions(-)

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
index ebfbf6e..b2abe00 100644
--- a/multicast.c
+++ b/multicast.c
@@ -386,6 +386,29 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_mcast_want_all_ip_count - count nodes with unspecific mcast interest
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ethhdr: ethernet header of a packet
+ *
+ * Return the number of nodes which want all IPv4 multicast traffic if
+ * the given ethhdr is from an IPv4 packet or the number of nodes which want
+ * all IPv6 traffic if it matches an IPv6 packet.
+ */
+static int batadv_mcast_forw_want_all_ip_count(struct batadv_priv *bat_priv,
+					       struct ethhdr *ethhdr)
+{
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		return atomic_read(&bat_priv->mcast.num_want_all_ipv4);
+	case ETH_P_IPV6:
+		return atomic_read(&bat_priv->mcast.num_want_all_ipv6);
+	default:
+		/* we shouldn't be here... */
+		return 0;
+	}
+}
+
+/**
  * batadv_mcast_forw_tt_node_get - get a multicast tt node
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: the ether header containing the multicast destination
@@ -402,6 +425,84 @@ batadv_mcast_forw_tt_node_get(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_mcast_want_forw_ipv4_node_get - get a node with an ipv4 flag
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 flag set
+ * and increase its refcount.
+ */
+static struct batadv_orig_node *
+batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
+{
+	struct batadv_orig_node *orig_node;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node,
+				 &bat_priv->mcast.want_all_ipv4_list,
+				 mcast_want_all_ipv4_node) {
+		if (atomic_inc_not_zero(&orig_node->refcount))
+			goto unlock;
+	}
+
+	orig_node = NULL;
+
+unlock:
+	rcu_read_unlock();
+	return orig_node;
+}
+
+/**
+ * batadv_mcast_want_forw_ipv6_node_get - get a node with an ipv6 flag
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return an orig_node which has the BATADV_MCAST_WANT_ALL_IPV6 flag set
+ * and increase its refcount.
+ */
+static struct batadv_orig_node *
+batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
+{
+	struct batadv_orig_node *orig_node;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node,
+				 &bat_priv->mcast.want_all_ipv6_list,
+				 mcast_want_all_ipv6_node) {
+		if (atomic_inc_not_zero(&orig_node->refcount))
+			goto unlock;
+	}
+
+	orig_node = NULL;
+
+unlock:
+	rcu_read_unlock();
+	return orig_node;
+}
+
+/**
+ * batadv_mcast_want_forw_ip_node_get - get a node with an ipv4/ipv6 flag
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ethhdr: an ethernet header to determine the protocol family from
+ *
+ * Return an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 or
+ * BATADV_MCAST_WANT_ALL_IPV6 flag, depending on the provided ethhdr, set
+ * and increase its refcount.
+ */
+static struct batadv_orig_node *
+batadv_mcast_forw_ip_node_get(struct batadv_priv *bat_priv,
+			      struct ethhdr *ethhdr)
+{
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		return batadv_mcast_forw_ipv4_node_get(bat_priv);
+	case ETH_P_IPV6:
+		return batadv_mcast_forw_ipv6_node_get(bat_priv);
+	default:
+		/* we shouldn't be here... */
+		return 0;
+	}
+}
+
+/**
  * batadv_mcast_want_forw_unsnoop_node_get - get a node with an unsnoopable flag
  * @bat_priv: the bat priv with all the soft interface information
  *
@@ -444,7 +545,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 {
 	struct ethhdr *ethhdr;
 	bool is_unsnoopable = false;
-	int ret, tt_count, unsnoop_count, total_count;
+	int ret, tt_count, ip_count, unsnoop_count, total_count;
 
 	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable);
 	if (ret == -ENOMEM)
@@ -456,15 +557,18 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	tt_count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
 					       BATADV_NO_FLAGS);
+	ip_count = batadv_mcast_forw_want_all_ip_count(bat_priv, ethhdr);
 	unsnoop_count = !is_unsnoopable ? 0 :
 			atomic_read(&bat_priv->mcast.num_want_all_unsnoopables);
 
-	total_count = tt_count + unsnoop_count;
+	total_count = tt_count + ip_count + unsnoop_count;
 
 	switch (total_count) {
 	case 1:
 		if (tt_count)
 			*orig = batadv_mcast_forw_tt_node_get(bat_priv, ethhdr);
+		else if (ip_count)
+			*orig = batadv_mcast_forw_ip_node_get(bat_priv, ethhdr);
 		else if (unsnoop_count)
 			*orig = batadv_mcast_forw_unsnoop_node_get(bat_priv);
 
@@ -513,6 +617,72 @@ static void batadv_mcast_want_unsnoop_update(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_mcast_want_ipv4_update - update want-all-ipv4 counter and list
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node which multicast state might have changed of
+ * @mcast_flags: flags indicating the new multicast state
+ *
+ * If the BATADV_MCAST_WANT_ALL_IPV4 flag of this originator, orig, has
+ * toggled then this method updates counter and list accordingly.
+ */
+static void batadv_mcast_want_ipv4_update(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig,
+					  uint8_t mcast_flags)
+{
+	/* switched from flag unset to set */
+	if (mcast_flags & BATADV_MCAST_WANT_ALL_IPV4 &&
+	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV4)) {
+		atomic_inc(&bat_priv->mcast.num_want_all_ipv4);
+
+		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
+		hlist_add_head_rcu(&orig->mcast_want_all_ipv4_node,
+				   &bat_priv->mcast.want_all_ipv4_list);
+		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
+	/* switched from flag set to unset */
+	} else if (!(mcast_flags & BATADV_MCAST_WANT_ALL_IPV4) &&
+		   orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV4) {
+		atomic_dec(&bat_priv->mcast.num_want_all_ipv4);
+
+		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
+		hlist_del_rcu(&orig->mcast_want_all_ipv4_node);
+		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
+	}
+}
+
+/**
+ * batadv_mcast_want_ipv6_update - update want-all-ipv6 counter and list
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node which multicast state might have changed of
+ * @mcast_flags: flags indicating the new multicast state
+ *
+ * If the BATADV_MCAST_WANT_ALL_IPV6 flag of this originator, orig, has
+ * toggled then this method updates counter and list accordingly.
+ */
+static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig,
+					  uint8_t mcast_flags)
+{
+	/* switched from flag unset to set */
+	if (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6 &&
+	    !(orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV6)) {
+		atomic_inc(&bat_priv->mcast.num_want_all_ipv6);
+
+		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
+		hlist_add_head_rcu(&orig->mcast_want_all_ipv6_node,
+				   &bat_priv->mcast.want_all_ipv6_list);
+		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
+	/* switched from flag set to unset */
+	} else if (!(mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) &&
+		   orig->mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) {
+		atomic_dec(&bat_priv->mcast.num_want_all_ipv6);
+
+		spin_lock_bh(&bat_priv->mcast.want_lists_lock);
+		hlist_del_rcu(&orig->mcast_want_all_ipv6_node);
+		spin_unlock_bh(&bat_priv->mcast.want_lists_lock);
+	}
+}
+
+/**
  * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
@@ -557,6 +727,8 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 		mcast_flags = *(uint8_t *)tvlv_value;
 
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, mcast_flags);
+	batadv_mcast_want_ipv4_update(bat_priv, orig, mcast_flags);
+	batadv_mcast_want_ipv6_update(bat_priv, orig, mcast_flags);
 
 	orig->mcast_flags = mcast_flags;
 }
@@ -596,4 +768,6 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 		atomic_dec(&bat_priv->mcast.num_disabled);
 
 	batadv_mcast_want_unsnoop_update(bat_priv, orig, BATADV_NO_FLAGS);
+	batadv_mcast_want_ipv4_update(bat_priv, orig, BATADV_NO_FLAGS);
+	batadv_mcast_want_ipv6_update(bat_priv, orig, BATADV_NO_FLAGS);
 }
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
index db6feca..744a59b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -711,6 +711,8 @@ static int batadv_softif_init_late(struct net_device *dev)
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

