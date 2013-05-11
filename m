Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 11 May 2013 19:23:26 +0200
Message-Id: <1368293014-30742-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Announce new capability via
	multicast TVLV
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
 multicast.c      |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 multicast.h      |    7 ++++++
 originator.c     |    3 +++
 packet.h         |    7 ++++++
 soft-interface.c |    1 +
 types.h          |    4 ++++
 7 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index 1c82c18..6ab5b2d 100644
--- a/main.c
+++ b/main.c
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
diff --git a/multicast.c b/multicast.c
index 88bde61..95beac4 100644
--- a/multicast.c
+++ b/multicast.c
@@ -170,6 +170,7 @@ void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
 	struct list_head mcast_list;
 	int ret;
 	static bool enabled;
+	uint8_t mcast_flags;
 
 	INIT_LIST_HEAD(&mcast_list);
 
@@ -183,14 +184,22 @@ void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
 	 * or there is a bridge on top of our soft interface (TODO) */
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
 
 	ret = batadv_mcast_mla_local_collect(soft_iface, &mcast_list,
 					     BATADV_MLA_MAX);
@@ -209,6 +218,52 @@ out:
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
+	    (tvlv_value) && (tvlv_value_len == 1))
+		mcast_flags = *(unsigned char *)tvlv_value;
+
+	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
+	    orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) {
+		atomic_inc(&bat_priv->mcast_num_non_aware);
+	} else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
+		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT)) {
+		atomic_dec(&bat_priv->mcast_num_non_aware);
+	}
+
+	orig->mcast_flags = mcast_flags;
+}
+
+/**
+ * batadv_mcast_init - Initializes the multicast optimizations structures
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
  * batadv_mcast_free - Frees the multicast optimizaitons structures
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -218,5 +273,8 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 
 	INIT_LIST_HEAD(&mcast_list);
 
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
+
 	batadv_mcast_mla_tt_clean(bat_priv, &mcast_list);
 }
diff --git a/multicast.h b/multicast.h
index 3b68e3b..9955a18 100644
--- a/multicast.h
+++ b/multicast.h
@@ -24,6 +24,8 @@
 
 void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv);
 
+int batadv_mcast_init(struct batadv_priv *bat_priv);
+
 void batadv_mcast_free(struct batadv_priv *bat_priv);
 
 #else
@@ -33,6 +35,11 @@ static inline void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
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
diff --git a/originator.c b/originator.c
index 5d53d2f..acc0c2d 100644
--- a/originator.c
+++ b/originator.c
@@ -257,6 +257,9 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
 	orig_node->batman_seqno_reset = reset_time;
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	orig_node->mcast_flags = BATADV_MCAST_LISTENER_ANNOUNCEMENT;
+#endif
 
 	atomic_set(&orig_node->bond_candidates, 0);
 
diff --git a/packet.h b/packet.h
index 7d45890..c89df30 100644
--- a/packet.h
+++ b/packet.h
@@ -97,6 +97,11 @@ enum batadv_unicast_frag_flags {
 	BATADV_UNI_FRAG_LARGETAIL = BIT(1),
 };
 
+/* multicast capabilities */
+enum batadv_mcast_flags {
+	BATADV_MCAST_LISTENER_ANNOUNCEMENT = BIT(0),
+};
+
 /* tt data subtypes */
 #define BATADV_TT_DATA_TYPE_MASK 0x0F
 
@@ -143,6 +148,7 @@ enum batadv_bla_claimframe {
  * @BATADV_TVLV_NC: network coding tvlv
  * @BATADV_TVLV_TT: translation table tvlv
  * @BATADV_TVLV_ROAM: roaming advertisement tvlv
+ * @BATADV_TVLV_MCAST: multicast capability tvlv
  */
 enum batadv_tvlv_type {
 	BATADV_TVLV_GW		= 0x01,
@@ -150,6 +156,7 @@ enum batadv_tvlv_type {
 	BATADV_TVLV_NC		= 0x03,
 	BATADV_TVLV_TT		= 0x04,
 	BATADV_TVLV_ROAM	= 0x05,
+	BATADV_TVLV_MCAST	= 0x06,
 };
 
 /* the destination hardware field in the ARP frame is used to
diff --git a/soft-interface.c b/soft-interface.c
index b97dfa2..c1142c2 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -459,6 +459,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
 	atomic_set(&bat_priv->mcast_group_awareness, 1);
+	atomic_set(&bat_priv->mcast_num_non_aware, 0);
 #endif
 	atomic_set(&bat_priv->ap_isolation, 0);
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
diff --git a/types.h b/types.h
index 5d73a75..4ef5fb9 100644
--- a/types.h
+++ b/types.h
@@ -146,6 +146,9 @@ struct batadv_orig_node {
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	uint8_t mcast_flags;
+#endif
 	uint8_t capabilities;
 	atomic_t last_ttvn;
 	uint32_t tt_crc;
@@ -569,6 +572,7 @@ struct batadv_priv {
 #endif
 #ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
 	atomic_t mcast_group_awareness;
+	atomic_t mcast_num_non_aware;
 #endif
 	atomic_t gw_mode;
 	atomic_t gw_sel_class;
-- 
1.7.10.4

