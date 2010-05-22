Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 16:17:11 +0200
Message-Id: <1274537833-2512-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005221616.46785.sven.eckelmann@gmx.de>
References: <201005221616.46785.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/10] Staging: batman-adv: convert all sysfs
	files to single value files
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
To: gregkh@suse.de
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

This patch removes the extra usage output which came when
the sysfs files were read.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 651bdb4..b961817 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -36,18 +36,18 @@ struct bat_attribute bat_attr_##_name = {	\
 	.store  = _store,			\
 };
 
-static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
+static ssize_t show_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
 	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
 
-	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1\n",
+	return sprintf(buff, "%s\n",
 		       aggr_status == 0 ? "disabled" : "enabled");
 }
 
-static ssize_t store_aggr_ogm(struct kobject *kobj, struct attribute *attr,
+static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 			      char *buff, size_t count)
 {
 	struct device *dev = to_dev(kobj->parent);
@@ -91,10 +91,9 @@ static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
 	int vis_mode = atomic_read(&bat_priv->vis_mode);
 
-	return sprintf(buff, "status: %s\ncommands: client, server, %d, %d\n",
+	return sprintf(buff, "%s\n",
 		       vis_mode == VIS_TYPE_CLIENT_UPDATE ?
-							"client" : "server",
-		       VIS_TYPE_SERVER_SYNC, VIS_TYPE_CLIENT_UPDATE);
+							"client" : "server");
 }
 
 static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
@@ -109,7 +108,8 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 	ret = strict_strtoul(buff, 10, &val);
 
 	if (((count == 2) && (!ret) && (val == VIS_TYPE_CLIENT_UPDATE)) ||
-	    (strncmp(buff, "client", 6) == 0))
+	    (strncmp(buff, "client", 6) == 0) ||
+	    (strncmp(buff, "off", 3) == 0))
 		vis_mode_tmp = VIS_TYPE_CLIENT_UPDATE;
 
 	if (((count == 2) && (!ret) && (val == VIS_TYPE_SERVER_SYNC)) ||
@@ -143,7 +143,7 @@ static ssize_t show_orig_interval(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = to_dev(kobj->parent);
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
 
-	return sprintf(buff, "status: %i\n",
+	return sprintf(buff, "%i\n",
 		       atomic_read(&bat_priv->orig_interval));
 }
 
@@ -180,14 +180,14 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
-static BAT_ATTR(aggregate_ogm, S_IRUGO | S_IWUSR,
-		show_aggr_ogm, store_aggr_ogm);
+static BAT_ATTR(aggregated_ogms, S_IRUGO | S_IWUSR,
+		show_aggr_ogms, store_aggr_ogms);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
 		show_orig_interval, store_orig_interval);
 
 static struct bat_attribute *mesh_attrs[] = {
-	&bat_attr_aggregate_ogm,
+	&bat_attr_aggregated_ogms,
 	&bat_attr_vis_mode,
 	&bat_attr_orig_interval,
 	NULL,
@@ -261,7 +261,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (!batman_if)
 		return 0;
 
-	return sprintf(buff, "status: %s\ncommands: none, bat0\n",
+	return sprintf(buff, "%s\n",
 		       batman_if->if_status == IF_NOT_IN_USE ?
 							"none" : "bat0");
 }
-- 
1.7.1

