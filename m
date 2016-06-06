Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  6 Jun 2016 23:05:49 +0200
Message-Id: <1465247149-31013-5-git-send-email-sven@narfation.org>
In-Reply-To: <1465247149-31013-1-git-send-email-sven@narfation.org>
References: <1465247149-31013-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 5/5] batman-adv: Avoid sysfs name
	collision for netns moves
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

The kobject_put is only removing the sysfs entry and corresponding entries
when its reference counter becomes zero. This tends to lead to collisions
when a device is moved between two different network namespaces because
some of the sysfs files have to be removed first and then added again to
the already moved sysfs entry.

    WARNING: CPU: 0 PID: 290 at lib/kobject.c:240 kobject_add_internal+0x5ec/0x8a0
    kobject_add_internal failed for batman_adv with -EEXIST, don't try to register things with the same name in the same directory.

But the caller of kobject_put can already remove the sysfs entry before it
does the kobject_put. This removal is done even when the reference counter
is not yet zero and thus avoids the problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased on top of current master

 net/batman-adv/sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 9ca90d1..a146fcf 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -713,6 +713,8 @@ rem_attr:
 	for (bat_attr = batadv_mesh_attrs; *bat_attr; ++bat_attr)
 		sysfs_remove_file(bat_priv->mesh_obj, &((*bat_attr)->attr));
 
+	kobject_uevent(bat_priv->mesh_obj, KOBJ_REMOVE);
+	kobject_del(bat_priv->mesh_obj);
 	kobject_put(bat_priv->mesh_obj);
 	bat_priv->mesh_obj = NULL;
 out:
@@ -727,6 +729,8 @@ void batadv_sysfs_del_meshif(struct net_device *dev)
 	for (bat_attr = batadv_mesh_attrs; *bat_attr; ++bat_attr)
 		sysfs_remove_file(bat_priv->mesh_obj, &((*bat_attr)->attr));
 
+	kobject_uevent(bat_priv->mesh_obj, KOBJ_REMOVE);
+	kobject_del(bat_priv->mesh_obj);
 	kobject_put(bat_priv->mesh_obj);
 	bat_priv->mesh_obj = NULL;
 }
@@ -782,6 +786,8 @@ rem_attr:
 	for (bat_attr = batadv_vlan_attrs; *bat_attr; ++bat_attr)
 		sysfs_remove_file(vlan->kobj, &((*bat_attr)->attr));
 
+	kobject_uevent(vlan->kobj, KOBJ_REMOVE);
+	kobject_del(vlan->kobj);
 	kobject_put(vlan->kobj);
 	vlan->kobj = NULL;
 out:
@@ -801,6 +807,8 @@ void batadv_sysfs_del_vlan(struct batadv_priv *bat_priv,
 	for (bat_attr = batadv_vlan_attrs; *bat_attr; ++bat_attr)
 		sysfs_remove_file(vlan->kobj, &((*bat_attr)->attr));
 
+	kobject_uevent(vlan->kobj, KOBJ_REMOVE);
+	kobject_del(vlan->kobj);
 	kobject_put(vlan->kobj);
 	vlan->kobj = NULL;
 }
@@ -1103,6 +1111,8 @@ out:
 
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 {
+	kobject_uevent(*hardif_obj, KOBJ_REMOVE);
+	kobject_del(*hardif_obj);
 	kobject_put(*hardif_obj);
 	*hardif_obj = NULL;
 }
-- 
2.8.1

