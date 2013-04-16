Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Apr 2013 23:26:30 +0800
Message-Id: <1366125995-18034-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366125995-18034-1-git-send-email-lindner_marek@yahoo.de>
References: <1366125995-18034-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: tvlv - convert gateway flags
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Spyros Gasteratos <morfeas3000@gmail.com>

This patch changes the gateway feature to announce the gateway flags
using the tvlv infrastructure.

Signed-off-by: Spyros Gasteratos <morfeas3000@gmail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c     |   23 +--------------
 gateway_common.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 gateway_common.h |    3 ++
 main.c           |    7 +++++
 packet.h         |   10 ++++++-
 sysfs.c          |    1 +
 6 files changed, 107 insertions(+), 23 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 54227ef..d0a8cc5 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -118,6 +118,7 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	batadv_ogm_packet->header.version = BATADV_COMPAT_VERSION;
 	batadv_ogm_packet->header.ttl = 2;
 	batadv_ogm_packet->flags = BATADV_NO_FLAGS;
+	batadv_ogm_packet->reserved = 0;
 	batadv_ogm_packet->tq = BATADV_TQ_MAX_VALUE;
 	batadv_ogm_packet->tt_num_changes = 0;
 	batadv_ogm_packet->ttvn = 0;
@@ -639,7 +640,6 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	int *ogm_buff_len = &hard_iface->bat_iv.ogm_buff_len;
 	int vis_server, tt_num_changes = 0;
 	uint32_t seqno;
-	uint8_t bandwidth;
 	uint16_t tvlv_len = 0;
 
 	vis_server = atomic_read(&bat_priv->vis_mode);
@@ -668,14 +668,6 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	else
 		batadv_ogm_packet->flags &= ~BATADV_VIS_SERVER;
 
-	if (hard_iface == primary_if &&
-	    atomic_read(&bat_priv->gw_mode) == BATADV_GW_MODE_SERVER) {
-		bandwidth = (uint8_t)atomic_read(&bat_priv->gw_bandwidth);
-		batadv_ogm_packet->gw_flags = bandwidth;
-	} else {
-		batadv_ogm_packet->gw_flags = BATADV_NO_FLAGS;
-	}
-
 	batadv_slide_own_bcast_window(hard_iface);
 	batadv_iv_ogm_queue_add(bat_priv, hard_iface->bat_iv.ogm_buff,
 				hard_iface->bat_iv.ogm_buff_len, hard_iface, 1,
@@ -810,19 +802,6 @@ update_tt:
 				      batadv_ogm_packet->tt_num_changes,
 				      batadv_ogm_packet->ttvn,
 				      ntohs(batadv_ogm_packet->tt_crc));
-
-	if (orig_node->gw_flags != batadv_ogm_packet->gw_flags)
-		batadv_gw_node_update(bat_priv, orig_node,
-				      batadv_ogm_packet->gw_flags);
-
-	orig_node->gw_flags = batadv_ogm_packet->gw_flags;
-
-	/* restart gateway selection if fast or late switching was enabled */
-	if ((orig_node->gw_flags) &&
-	    (atomic_read(&bat_priv->gw_mode) == BATADV_GW_MODE_CLIENT) &&
-	    (atomic_read(&bat_priv->gw_sel_class) > 2))
-		batadv_gw_check_election(bat_priv, orig_node);
-
 	goto out;
 
 unlock:
diff --git a/gateway_common.c b/gateway_common.c
index 84bb2b1..ead96eb 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -20,6 +20,7 @@
 #include "main.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
+#include "packet.h"
 
 /* calculates the gateway class from kbit */
 static void batadv_kbit_to_gw_bandwidth(int down, int up, long *gw_srv_class)
@@ -134,6 +135,31 @@ static bool batadv_parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 	return true;
 }
 
+/**
+ * batadv_gw_tvlv_container_update - update the gw tvlv container after gateway
+ *  setting change
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv)
+{
+	char gw_mode, gw_tvlv_value;
+
+	gw_mode = atomic_read(&bat_priv->gw_mode);
+
+	switch (gw_mode) {
+	case BATADV_GW_MODE_OFF:
+	case BATADV_GW_MODE_CLIENT:
+		batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_GW, 1);
+		break;
+	case BATADV_GW_MODE_SERVER:
+		gw_tvlv_value = atomic_read(&bat_priv->gw_bandwidth);
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_GW, 1,
+					       &gw_tvlv_value,
+					       sizeof(gw_tvlv_value));
+		break;
+	}
+}
+
 ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 				size_t count)
 {
@@ -173,7 +199,67 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 		    (up > 2048 ? "MBit" : "KBit"));
 
 	atomic_set(&bat_priv->gw_bandwidth, gw_bandwidth_tmp);
+	batadv_gw_tvlv_container_update(bat_priv);
 
 end:
 	return count;
 }
+
+/**
+ * batadv_gw_tvlv_ogm_handler_v1 - process incoming gateway tvlv container
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node of the ogm
+ * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
+ * @tvlv_value: tvlv buffer containing the gateway data
+ * @tvlv_value_len: tvlv buffer length
+ */
+static void batadv_gw_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig,
+					  uint8_t flags,
+					  void *tvlv_value,
+					  uint16_t tvlv_value_len)
+{
+	uint8_t gw_flags = BATADV_NO_FLAGS;
+
+	/* only fetch the tvlv value if the handler wasn't called via the
+	 * CIFNOTFND flag and if there is data to fetch
+	 */
+	if (!(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
+	    (tvlv_value) && (tvlv_value_len == 1))
+		gw_flags = *(unsigned char *)tvlv_value;
+
+	if (orig->gw_flags != gw_flags)
+		batadv_gw_node_update(bat_priv, orig, gw_flags);
+
+	orig->gw_flags = gw_flags;
+
+	/* restart gateway selection if fast or late switching was enabled */
+	if ((orig->gw_flags != BATADV_NO_FLAGS) &&
+	    (atomic_read(&bat_priv->gw_mode) == BATADV_GW_MODE_CLIENT) &&
+	    (atomic_read(&bat_priv->gw_sel_class) > 2))
+		batadv_gw_check_election(bat_priv, orig);
+}
+
+/**
+ * batadv_gw_init - initialise the gateway handling internals
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return 0 on success or negative error number in case of failure.
+ */
+int batadv_gw_init(struct batadv_priv *bat_priv)
+{
+	batadv_tvlv_handler_register(bat_priv, batadv_gw_tvlv_ogm_handler_v1,
+				     NULL, BATADV_TVLV_GW, 1,
+				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	return 0;
+}
+
+/**
+ * batadv_gw_free - free the gateway handling internals
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_gw_free(struct batadv_priv *bat_priv)
+{
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_GW, 1);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_GW, 1);
+}
diff --git a/gateway_common.h b/gateway_common.h
index 509b2bf..6b43c0e 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -33,5 +33,8 @@ enum batadv_gw_modes {
 void batadv_gw_bandwidth_to_kbit(uint8_t gw_class, int *down, int *up);
 ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 				size_t count);
+void batadv_gw_tvlv_container_update(struct batadv_priv *bat_priv);
+int batadv_gw_init(struct batadv_priv *bat_priv);
+void batadv_gw_free(struct batadv_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/main.c b/main.c
index 7a72cfc..b631c05 100644
--- a/main.c
+++ b/main.c
@@ -33,6 +33,7 @@
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
 #include "unicast.h"
+#include "gateway_common.h"
 #include "vis.h"
 #include "hash.h"
 #include "bat_algo.h"
@@ -147,6 +148,10 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
+	ret = batadv_gw_init(bat_priv);
+	if (ret < 0)
+		goto err;
+
 	atomic_set(&bat_priv->gw.reselect, 0);
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_ACTIVE);
 
@@ -177,6 +182,8 @@ void batadv_mesh_free(struct net_device *soft_iface)
 
 	batadv_dat_free(bat_priv);
 
+	batadv_gw_free(bat_priv);
+
 	free_percpu(bat_priv->bat_counters);
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
diff --git a/packet.h b/packet.h
index 4de94c7..a5bd6ee 100644
--- a/packet.h
+++ b/packet.h
@@ -118,6 +118,14 @@ enum batadv_bla_claimframe {
 	BATADV_CLAIM_TYPE_REQUEST	= 0x03,
 };
 
+/**
+ * enum batadv_tvlv_type - tvlv type definitions
+ * @BATADV_TVLV_GW: gateway tvlv
+ */
+enum batadv_tvlv_type {
+	BATADV_TVLV_GW		= 0x01,
+};
+
 /* the destination hardware field in the ARP frame is used to
  * transport the claim type and the group id
  */
@@ -147,7 +155,7 @@ struct batadv_ogm_packet {
 	__be32   seqno;
 	uint8_t  orig[ETH_ALEN];
 	uint8_t  prev_sender[ETH_ALEN];
-	uint8_t  gw_flags;  /* flags related to gateway class */
+	uint8_t  reserved;
 	uint8_t  tq;
 	uint8_t  tt_num_changes;
 	uint8_t  ttvn; /* translation table version number */
diff --git a/sysfs.c b/sysfs.c
index 15a22ef..db38f79 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -386,6 +386,7 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 
 	batadv_gw_deselect(bat_priv);
 	atomic_set(&bat_priv->gw_mode, (unsigned int)gw_mode_tmp);
+	batadv_gw_tvlv_container_update(bat_priv);
 	return count;
 }
 
-- 
1.7.10.4

