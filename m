Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jun 2012 22:31:29 +0200
Message-Id: <1338928292-23085-3-git-send-email-sven@narfation.org>
In-Reply-To: <1338928292-23085-1-git-send-email-sven@narfation.org>
References: <1338928292-23085-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: Prefix local sysfs struct
	with batadv_
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

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_sysfs.c |   12 ++++++------
 bat_sysfs.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 887c35f..56ed126 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -54,7 +54,7 @@ static char *batadv_uev_type_str[] = {
 
 /* Use this, if you have customized show and store functions */
 #define BATADV_ATTR(_name, _mode, _show, _store)	\
-struct bat_attribute batadv_attr_##_name = {		\
+struct batadv_attribute batadv_attr_##_name = {		\
 	.attr = {.name = __stringify(_name),		\
 		 .mode = _mode },			\
 	.show   = _show,				\
@@ -487,7 +487,7 @@ static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
 #endif
 
-static struct bat_attribute *batadv_mesh_attrs[] = {
+static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_aggregated_ogms,
 	&batadv_attr_bonding,
 #ifdef CONFIG_BATMAN_ADV_BLA
@@ -512,7 +512,7 @@ int batadv_sysfs_add_meshif(struct net_device *dev)
 {
 	struct kobject *batif_kobject = &dev->dev.kobj;
 	struct bat_priv *bat_priv = netdev_priv(dev);
-	struct bat_attribute **bat_attr;
+	struct batadv_attribute **bat_attr;
 	int err;
 
 	bat_priv->mesh_obj = kobject_create_and_add(BATADV_SYSFS_IF_MESH_SUBDIR,
@@ -549,7 +549,7 @@ out:
 void batadv_sysfs_del_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
-	struct bat_attribute **bat_attr;
+	struct batadv_attribute **bat_attr;
 
 	for (bat_attr = batadv_mesh_attrs; *bat_attr; ++bat_attr)
 		sysfs_remove_file(bat_priv->mesh_obj, &((*bat_attr)->attr));
@@ -676,7 +676,7 @@ static BATADV_ATTR(mesh_iface, S_IRUGO | S_IWUSR, batadv_show_mesh_iface,
 		   batadv_store_mesh_iface);
 static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, NULL);
 
-static struct bat_attribute *batadv_batman_attrs[] = {
+static struct batadv_attribute *batadv_batman_attrs[] = {
 	&batadv_attr_mesh_iface,
 	&batadv_attr_iface_status,
 	NULL,
@@ -685,7 +685,7 @@ static struct bat_attribute *batadv_batman_attrs[] = {
 int batadv_sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 {
 	struct kobject *hardif_kobject = &dev->dev.kobj;
-	struct bat_attribute **bat_attr;
+	struct batadv_attribute **bat_attr;
 	int err;
 
 	*hardif_obj = kobject_create_and_add(BATADV_SYSFS_IF_BAT_SUBDIR,
diff --git a/bat_sysfs.h b/bat_sysfs.h
index 28c2948..88f95f8 100644
--- a/bat_sysfs.h
+++ b/bat_sysfs.h
@@ -23,7 +23,7 @@
 #define BATADV_SYSFS_IF_MESH_SUBDIR "mesh"
 #define BATADV_SYSFS_IF_BAT_SUBDIR "batman_adv"
 
-struct bat_attribute {
+struct batadv_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
 			char *buf);
-- 
1.7.10

