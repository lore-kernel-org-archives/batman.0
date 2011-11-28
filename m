Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Nov 2011 00:28:37 +0800
Message-Id: <1322497717-21268-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
References: <201111290028.01655.lindner_marek@yahoo.de>
	<1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: allowing changing the
	routing algorithm via sysfs
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_sysfs.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index c25492f..5375600 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -272,6 +272,39 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
+static ssize_t show_bat_algo(struct kobject *kobj, struct attribute *attr,
+			    char *buff)
+{
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
+	return sprintf(buff, "%s\n", bat_priv->bat_algo->name);
+}
+
+static ssize_t store_bat_algo(struct kobject *kobj, struct attribute *attr,
+			      char *buff, size_t count)
+{
+	struct net_device *net_dev = kobj_to_netdev(kobj);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	int ret;
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+	else
+		buff[count] = '\0';
+
+	if (strcmp(bat_priv->bat_algo->name, buff) == 0)
+		return count;
+
+	ret = bat_algo_select(bat_priv, buff);
+	if (ret < 0)
+		bat_info(net_dev,
+			 "Invalid parameter for 'routing algorithm' setting "
+			 "received: %s\n", buff);
+	else
+		bat_info(net_dev, "Changing routing algorithm to: %s\n", buff);
+
+	return count;
+}
+
 static void post_gw_deselect(struct net_device *net_dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -382,6 +415,7 @@ BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 BAT_ATTR_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
+static BAT_ATTR(routing_algo, S_IRUGO | S_IWUSR, show_bat_algo, store_bat_algo);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
@@ -399,6 +433,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_fragmentation,
 	&bat_attr_ap_isolation,
 	&bat_attr_vis_mode,
+	&bat_attr_routing_algo,
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
 	&bat_attr_hop_penalty,
-- 
1.7.5.4

