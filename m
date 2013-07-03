Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu,  4 Jul 2013 00:03:20 +0200
Message-Id: <1372889002-6767-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
References: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv7 2/4] batman-adv: Announce new capability
	via multicast TVLV
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

If the soft interface of a node is not part of a bridge then a node
announces a new multicast TVLV: The according flag
(BATADV_MCAST_LISTENER_ANNOUNCEMENT) signalizes that this node is
announcing all of its multicast listeners via the translation table
infrastructure. More precisely, all multicast listeners of scope greater
than link-local for IPv4 and of scope greater
or equal to link-local for IPv6.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.c           |    4 +++
 main.h           |    1 +
 multicast.c      |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 multicast.h      |   14 +++++++++++
 originator.c     |    6 +++++
 packet.h         |    7 ++++++
 soft-interface.c |    1 +
 types.h          |    4 +++
 8 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/main.c b/main.c
index d24b950..ce58900 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -145,6 +145,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
+	ret = batadv_mcast_init(bat_priv);
+	if (ret < 0)
+		goto err;
+
 	ret = batadv_gw_init(bat_priv);
 	if (ret < 0)
 		goto err;
diff --git a/main.h b/main.h
index ede23d5..fe612d6 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -68,6 +68,7 @@
 #define BATADV_ROAMING_MAX_TIME 20000
 #define BATADV_ROAMING_MAX_COUNT 5
 
+#define BATADV_UNINIT_FLAGS -1
 #define BATADV_NO_FLAGS 0
 
 #define BATADV_NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */
diff --git a/multicast.c b/multicast.c
index 7ea19ab..4af4bc9 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -169,13 +169,30 @@ void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
 	struct net_device *soft_iface = bat_priv->soft_iface;
 	struct hlist_head mcast_list = HLIST_HEAD_INIT;
 	int ret;
+	static bool enabled;
+	uint8_t mcast_flags;
 
 	/* Avoid attaching MLAs, if multicast optimization is disabled
 	 * or there is a bridge on top of our soft interface (TODO)
 	 */
 	if (!atomic_read(&bat_priv->multicast_mode) ||
-	    bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT)
+	    bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT) {
+		if (enabled) {
+			batadv_tvlv_container_unregister(bat_priv,
+							 BATADV_TVLV_MCAST, 1);
+			enabled = false;
+		}
+
 		goto update;
+	}
+
+	if (!enabled) {
+		mcast_flags = BATADV_MCAST_LISTENER_ANNOUNCEMENT;
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
+					       &mcast_flags,
+					       sizeof(mcast_flags));
+		enabled = true;
+	}
 
 	ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
 	if (ret < 0)
@@ -190,10 +207,65 @@ out:
 }
 
 /**
+ * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node of the ogm
+ * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
+ * @tvlv_value: tvlv buffer containing the multicast data
+ * @tvlv_value_len: tvlv buffer length
+ */
+static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
+					     struct batadv_orig_node *orig,
+					     uint8_t flags,
+					     void *tvlv_value,
+					     uint16_t tvlv_value_len)
+{
+	uint8_t mcast_flags = BATADV_NO_FLAGS;
+
+	/* only fetch the tvlv value if the handler wasn't called via the
+	 * CIFNOTFND flag and if there is data to fetch
+	 */
+	if (!(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
+	    (tvlv_value) && (tvlv_value_len == sizeof(mcast_flags)))
+		mcast_flags = *(uint8_t *)tvlv_value;
+
+	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
+	    (orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT ||
+	     orig->mcast_flags & BATADV_UNINIT_FLAGS))
+		atomic_inc(&bat_priv->mcast.num_no_mla);
+	else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
+		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT))
+		atomic_dec(&bat_priv->mcast.num_no_mla);
+
+	orig->mcast_flags = mcast_flags;
+}
+
+/**
+ * batadv_mcast_init - initialize the multicast optimizations structures
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+int batadv_mcast_init(struct batadv_priv *bat_priv)
+{
+	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler_v1,
+				     NULL, BATADV_TVLV_MCAST, 1,
+				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	return 0;
+}
+
+/**
  * batadv_mcast_free - free the multicast optimizations structures
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
+
 	batadv_mcast_mla_tt_clean(bat_priv, NULL);
 }
+
+void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node)
+{
+	if (!(orig_node->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT))
+		atomic_dec(&orig_node->bat_priv->mcast.num_no_mla);
+}
diff --git a/multicast.h b/multicast.h
index 8c03487..d8bb869 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -24,8 +24,12 @@
 
 void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv);
 
+int batadv_mcast_init(struct batadv_priv *bat_priv);
+
 void batadv_mcast_free(struct batadv_priv *bat_priv);
 
+void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
+
 #else
 
 static inline void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
@@ -33,11 +37,21 @@ static inline void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
 	return;
 }
 
+static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
 static inline void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
 	return;
 }
 
+static inline void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node)
+{
+	return;
+}
+
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 #endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/originator.c b/originator.c
index a591dc5..9f899cd 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -29,6 +29,7 @@
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
 #include "fragmentation.h"
+#include "multicast.h"
 
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
@@ -143,6 +144,8 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	batadv_mcast_purge_orig(orig_node);
+
 	/* Free nc_nodes */
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
@@ -258,6 +261,9 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
 	orig_node->batman_seqno_reset = reset_time;
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	orig_node->mcast_flags = BATADV_UNINIT_FLAGS;
+#endif
 
 	atomic_set(&orig_node->bond_candidates, 0);
 
diff --git a/packet.h b/packet.h
index 08e175a..1090977 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -91,6 +91,11 @@ enum batadv_icmp_packettype {
 	BATADV_PARAMETER_PROBLEM       = 12,
 };
 
+/* multicast capabilities */
+enum batadv_mcast_flags {
+	BATADV_MCAST_LISTENER_ANNOUNCEMENT = BIT(0),
+};
+
 /* tt data subtypes */
 #define BATADV_TT_DATA_TYPE_MASK 0x0F
 
@@ -145,6 +150,7 @@ enum batadv_bla_claimframe {
  * @BATADV_TVLV_NC: network coding tvlv
  * @BATADV_TVLV_TT: translation table tvlv
  * @BATADV_TVLV_ROAM: roaming advertisement tvlv
+ * @BATADV_TVLV_MCAST: multicast capability tvlv
  */
 enum batadv_tvlv_type {
 	BATADV_TVLV_GW		= 0x01,
@@ -152,6 +158,7 @@ enum batadv_tvlv_type {
 	BATADV_TVLV_NC		= 0x03,
 	BATADV_TVLV_TT		= 0x04,
 	BATADV_TVLV_ROAM	= 0x05,
+	BATADV_TVLV_MCAST	= 0x06,
 };
 
 /* the destination hardware field in the ARP frame is used to
diff --git a/soft-interface.c b/soft-interface.c
index f984918..1992c42 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -648,6 +648,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	atomic_set(&bat_priv->multicast_mode, 1);
+	atomic_set(&bat_priv->mcast.num_no_mla, 0);
 #endif
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
diff --git a/types.h b/types.h
index 810f014..ceb96b0 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -163,6 +163,9 @@ struct batadv_orig_node {
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	int mcast_flags;
+#endif
 	uint8_t capabilities;
 	atomic_t last_ttvn;
 	uint32_t tt_crc;
@@ -504,6 +507,7 @@ struct batadv_priv_dat {
 #ifdef CONFIG_BATMAN_ADV_MCAST
 struct batadv_priv_mcast {
 	struct hlist_head mla_list;
+	atomic_t num_no_mla;
 };
 #endif
 
-- 
1.7.10.4

