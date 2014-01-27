Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 27 Jan 2014 10:48:33 +0100
Message-Id: <1390816116-23804-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1390816116-23804-1-git-send-email-linus.luessing@web.de>
References: <1390816116-23804-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: Announce new capability via
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
announces a new multicast TVLV: The existence of this TVLV
signalizes that this node is announcing all of its multicast listeners
via the translation table infrastructure.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.c           |    1 +
 multicast.c      |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 multicast.h      |   14 +++++++
 originator.c     |    6 +++
 packet.h         |   12 ++++++
 soft-interface.c |    4 ++
 types.h          |   13 ++++++
 7 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/main.c b/main.c
index 58e98c8..8f11b67 100644
--- a/main.c
+++ b/main.c
@@ -149,6 +149,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 		goto err;
 
 	batadv_gw_init(bat_priv);
+	batadv_mcast_init(bat_priv);
 
 	atomic_set(&bat_priv->gw.reselect, 0);
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
diff --git a/multicast.c b/multicast.c
index ea04c46..bc66c07 100644
--- a/multicast.c
+++ b/multicast.c
@@ -202,11 +202,52 @@ out:
 }
 
 /**
+ * batadv_mcast_mla_tvlv_update - update multicast tvlv
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Update the own multicast tvlv with our current multicast related settings,
+ * capabilities and inabilities.
+ *
+ * Return true if the tvlv container is registered afterwards. Otherwise return
+ * false.
+ */
+static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
+{
+	struct batadv_tvlv_mcast_data mcast_data;
+
+	mcast_data.flags = BATADV_NO_FLAGS;
+	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
+
+	/* Avoid attaching MLAs, if there is a bridge on top of our soft
+	 * interface, we don't support that yet (TODO)
+	 */
+	if (batadv_mcast_has_bridge(bat_priv)) {
+		if (bat_priv->mcast.enabled) {
+			batadv_tvlv_container_unregister(bat_priv,
+							 BATADV_TVLV_MCAST, 1);
+			bat_priv->mcast.enabled = false;
+		}
+
+		return false;
+	}
+
+	if (!bat_priv->mcast.enabled ||
+	    mcast_data.flags != bat_priv->mcast.flags) {
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
+					       &mcast_data, sizeof(mcast_data));
+		bat_priv->mcast.flags = mcast_data.flags;
+		bat_priv->mcast.enabled = true;
+	}
+
+	return true;
+}
+
+/**
  * batadv_mcast_mla_update - update the own MLAs
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Update the own multicast listener announcements in the translation
- * table.
+ * table as well as the own, announced multicast tvlv container.
  */
 void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 {
@@ -214,10 +255,7 @@ void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 	struct hlist_head mcast_list = HLIST_HEAD_INIT;
 	int ret;
 
-	/* Avoid attaching MLAs, if there is a bridge on top of our soft
-	 * interface, we don't support that yet (TODO)
-	 */
-	if (batadv_mcast_has_bridge(bat_priv))
+	if (!batadv_mcast_mla_tvlv_update(bat_priv))
 		goto update;
 
 	ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
@@ -233,10 +271,83 @@ out:
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
+	bool orig_mcast_enabled = !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	uint8_t mcast_flags = BATADV_NO_FLAGS;
+	bool orig_initialized;
+
+	orig_initialized = orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST;
+
+	/* If mcast support is turned on decrease the disabled mcast node
+	 * counter only if we had increased it for this node before. If this
+	 * is a completely new orig_node no need to decrease the counter.
+	 */
+	if (orig_mcast_enabled &&
+	    !(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST)) {
+		if (orig_initialized)
+			atomic_dec(&bat_priv->mcast.num_disabled);
+		orig->capabilities |= BATADV_ORIG_CAPA_HAS_MCAST;
+	/* If mcast support is being switched off increase the disabled
+	 * mcast node counter.
+	 */
+	} else if (!orig_mcast_enabled &&
+		   orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST) {
+		atomic_inc(&bat_priv->mcast.num_disabled);
+		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_MCAST;
+	}
+
+	orig->capa_initialized |= BATADV_ORIG_CAPA_HAS_MCAST;
+
+	if (orig_mcast_enabled && tvlv_value &&
+	    (tvlv_value_len >= sizeof(mcast_flags)))
+		mcast_flags = *(uint8_t *)tvlv_value;
+
+	orig->mcast_flags = mcast_flags;
+}
+
+/**
+ * batadv_mcast_init - initialize the multicast optimizations structures
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_mcast_init(struct batadv_priv *bat_priv)
+{
+	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler_v1,
+				     NULL, BATADV_TVLV_MCAST, 1,
+				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
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
 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
 }
+
+/**
+ * batadv_mcast_purge_orig - reset originator global mcast state modifications
+ * @orig: the originator which is going to get purged
+ */
+void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
+{
+	struct batadv_priv *bat_priv = orig->bat_priv;
+
+	if (!(orig->capabilities & BATADV_ORIG_CAPA_HAS_MCAST))
+		atomic_dec(&bat_priv->mcast.num_disabled);
+}
diff --git a/multicast.h b/multicast.h
index b5c50ed..ad83fbe 100644
--- a/multicast.h
+++ b/multicast.h
@@ -19,8 +19,12 @@
 
 void batadv_mcast_mla_update(struct batadv_priv *bat_priv);
 
+void batadv_mcast_init(struct batadv_priv *bat_priv);
+
 void batadv_mcast_free(struct batadv_priv *bat_priv);
 
+void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
+
 #else
 
 static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
@@ -28,11 +32,21 @@ static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
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
index ab22450..fb1aa8e 100644
--- a/originator.c
+++ b/originator.c
@@ -27,6 +27,7 @@
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
 #include "fragmentation.h"
+#include "multicast.h"
 
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
@@ -521,6 +522,8 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	batadv_mcast_purge_orig(orig_node);
+
 	/* Free nc_nodes */
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
@@ -636,6 +639,9 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	orig_node->tt_buff_len = 0;
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	orig_node->mcast_flags = BATADV_NO_FLAGS;
+#endif
 
 	/* create a vlan object for the "untagged" LAN */
 	vlan = batadv_orig_node_vlan_new(orig_node, BATADV_NO_FLAGS);
diff --git a/packet.h b/packet.h
index 0a381d1..e8c483d 100644
--- a/packet.h
+++ b/packet.h
@@ -145,6 +145,7 @@ enum batadv_bla_claimframe {
  * @BATADV_TVLV_NC: network coding tvlv
  * @BATADV_TVLV_TT: translation table tvlv
  * @BATADV_TVLV_ROAM: roaming advertisement tvlv
+ * @BATADV_TVLV_MCAST: multicast capability tvlv
  */
 enum batadv_tvlv_type {
 	BATADV_TVLV_GW		= 0x01,
@@ -152,6 +153,7 @@ enum batadv_tvlv_type {
 	BATADV_TVLV_NC		= 0x03,
 	BATADV_TVLV_TT		= 0x04,
 	BATADV_TVLV_ROAM	= 0x05,
+	BATADV_TVLV_MCAST	= 0x06,
 };
 
 #pragma pack(2)
@@ -504,4 +506,14 @@ struct batadv_tvlv_roam_adv {
 	__be16 vid;
 };
 
+/**
+ * struct batadv_tvlv_mcast_data - payload of a multicast tvlv
+ * @flags: multicast flags announced by the orig node
+ * @reserved: reserved field
+ */
+struct batadv_tvlv_mcast_data {
+	uint8_t	flags;
+	uint8_t reserved[3];
+};
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index db3e467..ef9d0aa 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -692,6 +692,10 @@ static int batadv_softif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_set(&bat_priv->distributed_arp_table, 1);
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	bat_priv->mcast.flags = BATADV_NO_FLAGS;
+	atomic_set(&bat_priv->mcast.num_disabled, 0);
+#endif
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
 	atomic_set(&bat_priv->gw.bandwidth_down, 100);
diff --git a/types.h b/types.h
index b46117c..96ee0d2 100644
--- a/types.h
+++ b/types.h
@@ -204,6 +204,7 @@ struct batadv_orig_bat_iv {
  * @batadv_dat_addr_t:  address of the orig node in the distributed hash
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
+ * @mcast_flags: multicast flags announced by the orig node
  * @capabilities: announced capabilities of this originator
  * @capa_initialized: bitfield to remember whether a capability was initialized
  * @last_ttvn: last seen translation table version number
@@ -246,6 +247,9 @@ struct batadv_orig_node {
 #endif
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	uint8_t mcast_flags;
+#endif
 	uint8_t capabilities;
 	uint8_t capa_initialized;
 	atomic_t last_ttvn;
@@ -282,11 +286,14 @@ struct batadv_orig_node {
  * @BATADV_ORIG_CAPA_HAS_DAT: orig node has distributed arp table enabled
  * @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled
  * @BATADV_ORIG_CAPA_HAS_TT: orig node has tt capability
+ * @BATADV_ORIG_CAPA_HAS_MCAST: orig node has some multicast capability
+ *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
  */
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT = BIT(0),
 	BATADV_ORIG_CAPA_HAS_NC = BIT(1),
 	BATADV_ORIG_CAPA_HAS_TT = BIT(2),
+	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
 };
 
 /**
@@ -612,9 +619,15 @@ struct batadv_priv_dat {
 /**
  * struct batadv_priv_mcast - per mesh interface mcast data
  * @mla_list: list of multicast addresses we are currently announcing via TT
+ * @flags: the flags we have last sent in our mcast tvlv
+ * @enabled: whether the multicast tvlv is currently enabled
+ * @num_disabled: number of nodes that have no mcast tvlv
  */
 struct batadv_priv_mcast {
 	struct hlist_head mla_list;
+	uint8_t flags;
+	bool enabled;
+	atomic_t num_disabled;
 };
 #endif
 
-- 
1.7.10.4

