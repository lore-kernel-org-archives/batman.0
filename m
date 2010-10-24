Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 24 Oct 2010 03:14:18 +0200
Message-Id: <1287882863-11314-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201010240313.35215.lindner_marek@yahoo.de>
References: <201010240313.35215.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: move gateway selection class
	into its own sysfs file
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

The Linux kernel guidelines require each sysfs file to have a single
value / purpose, therefore it is necessary to split up the sysfs
gateway files.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/bat_sysfs.c      |   10 ++++++++++
 batman-adv/gateway_client.c |    6 +++---
 batman-adv/gateway_common.c |    5 ++++-
 batman-adv/routing.c        |    5 ++++-
 batman-adv/soft-interface.c |    1 +
 batman-adv/types.h          |    1 +
 6 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index e85a922..34a69be 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -252,6 +252,12 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
+static void post_gw_deselect(struct net_device *net_dev)
+{
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	gw_deselect(bat_priv);
+}
+
 static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 			    char *buff)
 {
@@ -262,6 +268,7 @@ static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 
 	switch (gw_mode) {
 	case GW_MODE_CLIENT:
+		gw_class = atomic_read(&bat_priv->gw_sel_class);
 		bytes_written = sprintf(buff, "%s (gw_class: %i)\n",
 					GW_MODE_CLIENT_NAME, gw_class);
 		break;
@@ -299,6 +306,8 @@ static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
+BAT_ATTR_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
+	      post_gw_deselect);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
@@ -311,6 +320,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
 	&bat_attr_hop_penalty,
+	&bat_attr_gw_sel_class,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	&bat_attr_log_level,
 #endif
diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 6c6a0b3..4217b6b 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -117,7 +117,7 @@ void gw_election(struct bat_priv *bat_priv)
 		if (gw_node->deleted)
 			continue;
 
-		switch (atomic_read(&bat_priv->gw_class)) {
+		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
 			gw_srv_class_to_kbit(gw_node->orig_node->gw_flags,
 					     &down, &up);
@@ -216,8 +216,8 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	 * if the routing class is greater than 3 the value tells us how much
 	 * greater the TQ value of the new gateway must be
 	 **/
-	if ((atomic_read(&bat_priv->gw_class) > 3) &&
-	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_class)))
+	if ((atomic_read(&bat_priv->gw_sel_class) > 3) &&
+	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_sel_class)))
 		return;
 
 	bat_dbg(DBG_BATMAN, bat_priv,
diff --git a/batman-adv/gateway_common.c b/batman-adv/gateway_common.c
index 3851930..05efe43 100644
--- a/batman-adv/gateway_common.c
+++ b/batman-adv/gateway_common.c
@@ -237,12 +237,15 @@ next:
 
 	switch (gw_mode_tmp) {
 	case GW_MODE_CLIENT:
+		gw_class_tmp = atomic_read(&bat_priv->gw_sel_class);
 		if ((gw_mode_tmp == GW_MODE_CLIENT) && (!gw_class_tmp))
 			gw_class_tmp = 20;
 
 		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s' "
-			 "(gw_class: %ld)\n",
+			 "(gw_sel_class: %ld)\n",
 			 gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
+
+		atomic_set(&bat_priv->gw_sel_class, gw_class_tmp);
 		break;
 	case GW_MODE_SERVER:
 		if (!down)
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 3b03e2a..affc15f 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -33,6 +33,7 @@
 #include "vis.h"
 #include "aggregation.h"
 #include "compat.h"
+#include "gateway_common.h"
 #include "gateway_client.h"
 #include "unicast.h"
 
@@ -331,7 +332,9 @@ update_gw:
 	orig_node->gw_flags = batman_packet->gw_flags;
 
 	/* restart gateway selection if fast or late switching was enabled */
-	if ((orig_node->gw_flags) && (atomic_read(&bat_priv->gw_class) > 2))
+	if ((orig_node->gw_flags) &&
+	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_CLIENT) &&
+	    (atomic_read(&bat_priv->gw_sel_class) > 2))
 		gw_check_election(bat_priv, orig_node);
 }
 
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 25564c3..d737f76 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -593,6 +593,7 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
+	atomic_set(&bat_priv->gw_sel_class, 0);
 	atomic_set(&bat_priv->gw_class, 0);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->hop_penalty, 10);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 2678ce1..b68add4 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -128,6 +128,7 @@ struct bat_priv {
 	atomic_t fragmentation;		/* boolean */
 	atomic_t vis_mode;		/* VIS_TYPE_* */
 	atomic_t gw_mode;		/* GW_MODE_* */
+	atomic_t gw_sel_class;		/* uint */
 	atomic_t gw_class;		/* uint */
 	atomic_t orig_interval;		/* uint */
 	atomic_t hop_penalty;		/* uint */
-- 
1.7.1

