Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 15 Aug 2013 21:21:16 +0200
Message-Id: <1376594479-11563-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1376594479-11563-1-git-send-email-linus.luessing@web.de>
References: <1376594479-11563-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv9 2/5] batman-adv: Announce new capability
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
announces a new multicast TVLV: The existence of this TVLV
signalizes that this node is announcing all of its multicast listeners
via the translation table infrastructure.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 main.c           |    4 ++
 main.h           |    1 +
 multicast.c      |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 multicast.h      |   14 ++++++
 originator.c     |    6 +++
 packet.h         |    2 +
 soft-interface.c |    4 ++
 types.h          |   11 +++++
 8 files changed, 162 insertions(+), 5 deletions(-)

diff --git a/main.c b/main.c
index cc1d426..69dbb75 100644
--- a/main.c
+++ b/main.c
@@ -149,6 +149,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
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
index 142228e..7225f63 100644
--- a/main.h
+++ b/main.h
@@ -68,6 +68,7 @@
 #define BATADV_ROAMING_MAX_TIME 20000
 #define BATADV_ROAMING_MAX_COUNT 5
 
+#define BATADV_UNINIT_FLAGS BIT(15)
 #define BATADV_NO_FLAGS 0
 
 #define BATADV_NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */
diff --git a/multicast.c b/multicast.c
index e46df5b..5211b63 100644
--- a/multicast.c
+++ b/multicast.c
@@ -203,11 +203,45 @@ out:
 }
 
 /**
+ * batadv_mcast_mla_tvlv_update - update multicast tvlv
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Update the own multicast tvlv with our current multicast related settings,
+ * capabilities and inabilities.
+ */
+static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
+{
+	uint8_t mcast_flags = BATADV_NO_FLAGS;
+
+	/* Avoid attaching MLAs, if there is a bridge on top of our soft
+	 * interface, we don't support that yet (TODO)
+	 */
+	if (batadv_mcast_has_bridge(bat_priv)) {
+		if (bat_priv->mcast.flags != BATADV_UNINIT_FLAGS) {
+			batadv_tvlv_container_unregister(bat_priv,
+							 BATADV_TVLV_MCAST, 1);
+			bat_priv->mcast.flags = BATADV_UNINIT_FLAGS;
+		}
+
+		return false;
+	}
+
+	if (mcast_flags != bat_priv->mcast.flags) {
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
+					       &mcast_flags,
+					       sizeof(mcast_flags));
+		bat_priv->mcast.flags = mcast_flags;
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
@@ -215,10 +249,7 @@ void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 	struct hlist_head mcast_list = HLIST_HEAD_INIT;
 	int ret;
 
-	/* Avoid attaching MLAs, if there is a bridge on top of our soft
-	 * interface, we don't support that yet (TODO)
-	 */
-	if (batadv_mcast_has_bridge(bat_priv))
+	if (!batadv_mcast_mla_tvlv_update(bat_priv))
 		goto update;
 
 	ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
@@ -234,10 +265,94 @@ out:
 }
 
 /**
+ * batadv_mcast_counter_update - update the counter of a flag
+ * @flag: the flag we want to update counters for
+ * @flag_counter: the counter we might update
+ * @new_flags: the new capability bitset of a node
+ * @old_flags: the current, to be updated bitset of a node
+ *
+ * Update the given flag_counter with the help of the new flag information
+ * of a node to reflect how many nodes have the given flag set.
+ */
+static void batadv_mcast_counter_update(uint8_t flag, atomic_t *flag_counter,
+					uint8_t new_flags, int old_flags)
+{
+	if (new_flags & flag && !(old_flags & flag))
+		atomic_inc(flag_counter);
+	else if (!(new_flags & flag) && old_flags & flag)
+		atomic_dec(flag_counter);
+}
+
+/**
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
+	bool mcast_enabled = !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	int old_capabilities = orig->capabilities;
+	uint8_t mcast_flags = BATADV_NO_FLAGS;
+
+	if (mcast_enabled)
+		orig->capabilities |= BATADV_ORIG_CAPA_HAS_MCAST;
+	else
+		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_MCAST;
+
+	if (orig->mcast_flags == BATADV_UNINIT_FLAGS)
+		old_capabilities |= BATADV_ORIG_CAPA_HAS_MCAST;
+
+	if (mcast_enabled && tvlv_value &&
+	    (tvlv_value_len >= sizeof(mcast_flags)))
+		mcast_flags = *(uint8_t *)tvlv_value;
+
+	batadv_mcast_counter_update(BATADV_ORIG_CAPA_HAS_MCAST,
+				    &bat_priv->mcast.num_disabled,
+				    ~orig->capabilities, ~old_capabilities);
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
+	batadv_mcast_counter_update(BATADV_ORIG_CAPA_HAS_MCAST,
+				    &bat_priv->mcast.num_disabled,
+				    ~BATADV_NO_FLAGS, ~orig->capabilities);
+}
diff --git a/multicast.h b/multicast.h
index 3509b37..fca066e 100644
--- a/multicast.h
+++ b/multicast.h
@@ -24,8 +24,12 @@
 
 void batadv_mcast_mla_update(struct batadv_priv *bat_priv);
 
+int batadv_mcast_init(struct batadv_priv *bat_priv);
+
 void batadv_mcast_free(struct batadv_priv *bat_priv);
 
+void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
+
 #else
 
 static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
@@ -33,11 +37,21 @@ static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
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
index ee1d847..5b889a3 100644
--- a/originator.c
+++ b/originator.c
@@ -29,6 +29,7 @@
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
 #include "fragmentation.h"
+#include "multicast.h"
 
 /* hash class keys */
 static struct lock_class_key batadv_orig_hash_lock_class_key;
@@ -225,6 +226,8 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	batadv_mcast_purge_orig(orig_node);
+
 	/* Free nc_nodes */
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
@@ -342,6 +345,9 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
 	orig_node->batman_seqno_reset = reset_time;
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	orig_node->mcast_flags = BATADV_UNINIT_FLAGS;
+#endif
 
 	atomic_set(&orig_node->bond_candidates, 0);
 
diff --git a/packet.h b/packet.h
index f4bbb05..c8cc1b2 100644
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
 
 /* the destination hardware field in the ARP frame is used to
diff --git a/soft-interface.c b/soft-interface.c
index d018c49..aa19502 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -658,6 +658,10 @@ static int batadv_softif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_set(&bat_priv->distributed_arp_table, 1);
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	bat_priv->mcast.flags = BATADV_UNINIT_FLAGS;
+	atomic_set(&bat_priv->mcast.num_disabled, 0);
+#endif
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
 	atomic_set(&bat_priv->gw.bandwidth_down, 100);
diff --git a/types.h b/types.h
index 53d1d6c..7ea9631 100644
--- a/types.h
+++ b/types.h
@@ -144,6 +144,7 @@ struct batadv_orig_node_vlan {
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
  * @batman_seqno_reset: time when the batman seqno window was reset
+ * @mcast_flags: multicast flags announced by the orig node
  * @capabilities: announced capabilities of this originator
  * @last_ttvn: last seen translation table version number
  * @tt_buff: last tt changeset this node received from the orig node
@@ -194,6 +195,9 @@ struct batadv_orig_node {
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	int mcast_flags;
+#endif
 	uint8_t capabilities;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
@@ -236,10 +240,13 @@ struct batadv_orig_node {
  * enum batadv_orig_capabilities - orig node capabilities
  * @BATADV_ORIG_CAPA_HAS_DAT: orig node has distributed arp table enabled
  * @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled
+ * @BATADV_ORIG_CAPA_HAS_MCAST: orig node has some multicast capability
+ *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
  */
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT = BIT(1),
 	BATADV_ORIG_CAPA_HAS_NC = BIT(2),
+	BATADV_ORIG_CAPA_HAS_MCAST = BIT(3),
 };
 
 /**
@@ -541,9 +548,13 @@ struct batadv_priv_dat {
 /**
  * struct batadv_priv_mcast - per mesh interface mcast data
  * @mla_list: list of multicast addresses we are currently announcing via TT
+ * @flags: the flags we have last sent in our mcast tvlv
+ * @num_disabled: number of nodes that have no mcast tvlv
  */
 struct batadv_priv_mcast {
 	struct hlist_head mla_list;
+	int flags;
+	atomic_t num_disabled;
 };
 #endif
 
-- 
1.7.10.4

