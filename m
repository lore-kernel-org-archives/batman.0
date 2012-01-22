Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 22 Jan 2012 20:00:20 +0100
Message-Id: <1327258827-13861-4-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1327258827-13861-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1327258827-13861-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv3 03/10] batman-adv: make bridge loop
	avoidance switchable
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

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 bat_sysfs.c          |    2 ++
 sysfs-class-net-mesh |    9 +++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 8c588b4..2305cad 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -386,6 +386,7 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
+BAT_ATTR_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 BAT_ATTR_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
@@ -404,6 +405,7 @@ BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 15, NULL);
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregated_ogms,
 	&bat_attr_bonding,
+	&bat_attr_bridge_loop_avoidance,
 	&bat_attr_fragmentation,
 	&bat_attr_ap_isolation,
 	&bat_attr_vis_mode,
diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index b218e0f..c81fe89 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -14,6 +14,15 @@ Description:
                 mesh will be sent using multiple interfaces at the
                 same time (if available).
 
+What:           /sys/class/net/<mesh_iface>/mesh/bridge_loop_avoidance
+Date:           November 2011
+Contact:        Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
+Description:
+                Indicates whether the bridge loop avoidance feature
+                is enabled. This feature detects and avoids loops
+                between the mesh and devices bridged with the soft
+                interface <mesh_iface>.
+
 What:           /sys/class/net/<mesh_iface>/mesh/fragmentation
 Date:           October 2010
 Contact:        Andreas Langer <an.langer@gmx.de>
-- 
1.7.8.3

