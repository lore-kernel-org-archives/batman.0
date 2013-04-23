Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 23 Apr 2013 21:40:00 +0800
Message-Id: <1366724403-29629-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366724403-29629-1-git-send-email-lindner_marek@yahoo.de>
References: <1366724403-29629-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/7] batman-adv: tvlv - add network coding
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
 network-coding.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 network-coding.h |    6 ++++++
 packet.h         |    2 ++
 sysfs.c          |    4 +++-
 types.h          |    2 ++
 5 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/network-coding.c b/network-coding.c
index 65af447..277f5e0 100644
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
+ * batadv_nc_status_update - update the network coding tvlv container after
+ *  network coding setting change
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
+					  void *tvlv_value,
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
@@ -793,6 +850,10 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 	if (!atomic_read(&bat_priv->network_coding))
 		goto out;
 
+	/* check if orig node is network coding enabled */
+	if (!(orig_node->capabilities & BATADV_ORIG_CAPA_HAS_NC))
+		goto out;
+
 	/* accept ogms from 'good' neighbors and single hop neighbors */
 	if (!batadv_can_nc_with_orig(bat_priv, orig_node, ogm_packet) &&
 	    !is_single_hop_neigh)
@@ -1723,6 +1784,8 @@ free_nc_packet:
 void batadv_nc_free(struct batadv_priv *bat_priv)
 {
 	batadv_recv_handler_unregister(BATADV_CODED);
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_NC, 1);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_NC, 1);
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
diff --git a/network-coding.h b/network-coding.h
index 85a4ec8..8a97b40 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -22,6 +22,7 @@
 
 #ifdef CONFIG_BATMAN_ADV_NC
 
+void batadv_nc_status_update(struct net_device *net_dev);
 int batadv_nc_init(struct batadv_priv *bat_priv);
 void batadv_nc_free(struct batadv_priv *bat_priv);
 void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
@@ -46,6 +47,11 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv);
 
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
index 5a293da..526af61 100644
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
index a8e0459..b3807f4 100644
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
@@ -443,7 +444,8 @@ static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
 #endif
 #ifdef CONFIG_BATMAN_ADV_NC
-BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR, NULL);
+BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR,
+		     batadv_nc_status_update);
 #endif
 
 static struct batadv_attribute *batadv_mesh_attrs[] = {
diff --git a/types.h b/types.h
index d499204..18e0149 100644
--- a/types.h
+++ b/types.h
@@ -188,9 +188,11 @@ struct batadv_orig_node {
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

