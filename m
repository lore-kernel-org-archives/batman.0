Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Apr 2013 23:26:32 +0800
Message-Id: <1366125995-18034-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366125995-18034-1-git-send-email-lindner_marek@yahoo.de>
References: <1366125995-18034-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: tvlv - add network coding
	container
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

Create network coding container to announce network coding
capabilities (if enabled).

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 network-coding.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 network-coding.h |    6 ++++++
 packet.h         |    2 ++
 sysfs.c          |    4 +++-
 types.h          |    2 ++
 5 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/network-coding.c b/network-coding.c
index 80fe2ea..7b95a7f 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -45,6 +45,59 @@ static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_nc_tvlv_container_update - update the network coding tvlv container
+ *  after network coding setting change
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void batadv_nc_tvlv_container_update(struct batadv_priv *bat_priv)
+{
+	char nc_mode;
+
+	nc_mode = atomic_read(&bat_priv->network_coding);
+
+	switch (nc_mode) {
+	case 0:
+		batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_NC, 1);
+		break;
+	case 1:
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_NC, 1,
+					       NULL, 0);
+		break;
+	}
+}
+
+/**
+ * batadv_dat_status_update - update the network coding tvlv container
+ *  after network coding setting change
+ * @net_dev: the soft interface net device
+ */
+void batadv_nc_status_update(struct net_device *net_dev)
+{
+	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+	batadv_nc_tvlv_container_update(bat_priv);
+}
+
+/**
+ * batadv_nc_tvlv_ogm_handler_v1 - process incoming nc tvlv container
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig: the orig_node of the ogm
+ * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
+ * @tvlv_value: tvlv buffer containing the gateway data
+ * @tvlv_value_len: tvlv buffer length
+ */
+static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig,
+					  uint8_t flags,
+					  unsigned char *tvlv_value,
+					  uint16_t tvlv_value_len)
+{
+	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
+		orig->capabilities &= ~BATADV_ORIG_CAPA_HAS_NC;
+	else
+		orig->capabilities |= BATADV_ORIG_CAPA_HAS_NC;
+}
+
+/**
  * batadv_nc_init - initialise coding hash table and start house keeping
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -78,6 +131,10 @@ int batadv_nc_init(struct batadv_priv *bat_priv)
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
 	batadv_nc_start_timer(bat_priv);
 
+	batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
+				     NULL, BATADV_TVLV_NC, 1,
+				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+	batadv_nc_tvlv_container_update(bat_priv);
 	return 0;
 
 err:
@@ -654,6 +711,9 @@ static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
 				    struct batadv_orig_node *orig_node,
 				    struct batadv_ogm_packet *ogm_packet)
 {
+	/* check if orig node is is network coding enabled */
+	if (!(orig_node->capabilities & BATADV_ORIG_CAPA_HAS_NC))
+		return false;
 	if (orig_node->last_real_seqno != ntohl(ogm_packet->seqno))
 		return false;
 	if (orig_node->last_ttl != ogm_packet->header.ttl + 1)
@@ -1723,6 +1783,8 @@ free_nc_packet:
 void batadv_nc_free(struct batadv_priv *bat_priv)
 {
 	batadv_recv_handler_unregister(BATADV_CODED);
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_NC, 1);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_NC, 1);
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
diff --git a/network-coding.h b/network-coding.h
index 4fa6d0c..493d97e 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -22,6 +22,7 @@
 
 #ifdef CONFIG_BATMAN_ADV_NC
 
+void batadv_nc_status_update(struct net_device *net_dev);
 int batadv_nc_init(struct batadv_priv *bat_priv);
 void batadv_nc_free(struct batadv_priv *bat_priv);
 void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
@@ -47,6 +48,11 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv);
 
 #else /* ifdef CONFIG_BATMAN_ADV_NC */
 
+static inline void batadv_nc_status_update(struct net_device *net_dev)
+{
+	return;
+}
+
 static inline int batadv_nc_init(struct batadv_priv *bat_priv)
 {
 	return 0;
diff --git a/packet.h b/packet.h
index fec0102..ce7ca53 100644
--- a/packet.h
+++ b/packet.h
@@ -122,10 +122,12 @@ enum batadv_bla_claimframe {
  * enum batadv_tvlv_type - tvlv type definitions
  * @BATADV_TVLV_GW: gateway tvlv
  * @BATADV_TVLV_DAT: distributed arp table tvlv
+ * @BATADV_TVLV_NC: network coding tvlv
  */
 enum batadv_tvlv_type {
 	BATADV_TVLV_GW		= 0x01,
 	BATADV_TVLV_DAT		= 0x02,
+	BATADV_TVLV_NC		= 0x03,
 };
 
 /* the destination hardware field in the ARP frame is used to
diff --git a/sysfs.c b/sysfs.c
index 02ea795..109a0d8 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -21,6 +21,7 @@
 #include "sysfs.h"
 #include "translation-table.h"
 #include "distributed-arp-table.h"
+#include "network-coding.h"
 #include "originator.h"
 #include "hard-interface.h"
 #include "gateway_common.h"
@@ -445,7 +446,8 @@ static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
 #endif
 #ifdef CONFIG_BATMAN_ADV_NC
-BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR, NULL);
+BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR,
+		     batadv_nc_status_update);
 #endif
 
 static struct batadv_attribute *batadv_mesh_attrs[] = {
diff --git a/types.h b/types.h
index ae47225..6919ca4 100644
--- a/types.h
+++ b/types.h
@@ -190,9 +190,11 @@ struct batadv_orig_node {
 /**
  * enum batadv_orig_capabilities - orig node capabilities
  * @BATADV_ORIG_CAPA_HAS_DAT: orig node has distributed arp table enabled
+ * @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled
  */
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT = BIT(1),
+	BATADV_ORIG_CAPA_HAS_NC = BIT(2),
 };
 
 /**
-- 
1.7.10.4

