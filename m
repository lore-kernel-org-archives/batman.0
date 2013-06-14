Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 14 Jun 2013 11:02:04 +0200
Message-Id: <1371200525-2011-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1371200525-2011-1-git-send-email-linus.luessing@web.de>
References: <1371200525-2011-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv5 2/3] batman-adv: Announce new capability
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
 main.c           |    4 ++++
 multicast.c      |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 multicast.h      |   14 +++++++++++
 originator.c     |    6 +++++
 packet.h         |    7 ++++++
 soft-interface.c |    1 +
 types.h          |    4 ++++
 7 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index f5aed17..3b92ba2 100644
--- a/main.c
+++ b/main.c
@@ -146,6 +146,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
+	ret = batadv_mcast_init(bat_priv);
+	if (ret < 0)
+		goto err;
+
 	ret = batadv_gw_init(bat_priv);
 	if (ret < 0)
 		goto err;
diff --git a/multicast.c b/multicast.c
index 580e8f2..74fb19e 100644
--- a/multicast.c
+++ b/multicast.c
@@ -171,6 +171,7 @@ void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
 	struct list_head mcast_list;
 	int ret;
 	static bool enabled;
+	uint8_t mcast_flags;
 
 	INIT_LIST_HEAD(&mcast_list);
 
@@ -179,14 +180,22 @@ void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
 	 */
 	if (!atomic_read(&bat_priv->mcast_group_awareness) ||
 	    bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT) {
-		if (enabled)
+		if (enabled) {
+			batadv_tvlv_container_unregister(bat_priv,
+							 BATADV_TVLV_MCAST, 1);
 			enabled = false;
+		}
 
 		goto update;
 	}
 
-	if (!enabled)
+	if (!enabled) {
+		mcast_flags = BATADV_MCAST_LISTENER_ANNOUNCEMENT;
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
+					       &mcast_flags,
+					       sizeof(mcast_flags));
 		enabled = true;
+	}
 
 	ret = batadv_mcast_mla_local_collect(soft_iface, &mcast_list);
 	if (ret < 0)
@@ -201,10 +210,65 @@ out:
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
+	    orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) {
+		atomic_inc(&bat_priv->mcast.num_no_mla);
+	} else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
+		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT)) {
+		atomic_dec(&bat_priv->mcast.num_no_mla);
+	}
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
index 3b68e3b..aa58e4b 100644
--- a/multicast.h
+++ b/multicast.h
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
 #endif /* CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS */
 
 #endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/originator.c b/originator.c
index a591dc5..5e827fa 100644
--- a/originator.c
+++ b/originator.c
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
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	orig_node->mcast_flags = BATADV_MCAST_LISTENER_ANNOUNCEMENT;
+#endif
 
 	atomic_set(&orig_node->bond_candidates, 0);
 
diff --git a/packet.h b/packet.h
index 08e175a..1090977 100644
--- a/packet.h
+++ b/packet.h
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
index cf759fc..90d06c5 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -473,6 +473,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
 	atomic_set(&bat_priv->mcast_group_awareness, 1);
+	atomic_set(&bat_priv->mcast.num_no_mla, 0);
 #endif
 	atomic_set(&bat_priv->ap_isolation, 0);
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
diff --git a/types.h b/types.h
index 8d57426..12d3ba7 100644
--- a/types.h
+++ b/types.h
@@ -163,6 +163,9 @@ struct batadv_orig_node {
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	uint8_t mcast_flags;
+#endif
 	uint8_t capabilities;
 	atomic_t last_ttvn;
 	uint32_t tt_crc;
@@ -504,6 +507,7 @@ struct batadv_priv_dat {
 #ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
 struct batadv_priv_mcast {
 	struct list_head mla_list;
+	atomic_t num_no_mla;
 };
 #endif
 
-- 
1.7.10.4

