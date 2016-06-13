Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2016 07:41:29 +0200
Message-Id: <1465796492-5039-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v5 1/4] Revert "batman-adv: Fix hardif
	remove/add race"
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

The description given in the commit is misleading and is at least not true
for sysfs. The sysfs file structure should instead be deleted immediately on
rtnl notifications and be underlying objects should be removed later when
all kobject_put were done for the object.

This reverts commit 6b0485c758be ("batman-adv: Fix hardif remove/add race")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v5:
 - add this revert
---
 net/batman-adv/debugfs.c        | 23 -----------------------
 net/batman-adv/debugfs.h        |  1 -
 net/batman-adv/hard-interface.c | 19 -------------------
 net/batman-adv/sysfs.c          | 17 -----------------
 net/batman-adv/sysfs.h          |  2 --
 5 files changed, 62 deletions(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index aea4133..1d68b6e 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -44,7 +44,6 @@
 #include "translation-table.h"
 
 static struct dentry *batadv_debugfs;
-static atomic_t batadv_rename = ATOMIC_INIT(0);
 
 static int batadv_algorithms_open(struct inode *inode, struct file *file)
 {
@@ -348,28 +347,6 @@ void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
 	}
 }
 
-/**
- * batadv_debugfs_rename_hardif - rename the base directory
- * @hard_iface: hard interface which is renamed.
- *
- * The interface may be removed and then quickly added back
- * again. Rename the old instance to something temporary and unique,
- * so avoiding a name space clash if it does reappear before the deferred
- * work completes the removal.
- */
-void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface)
-{
-	char new_name[32];
-
-	snprintf(new_name, sizeof(*new_name) - 1, "tmp-%d",
-		 atomic_inc_return(&batadv_rename));
-
-	if (batadv_debugfs && hard_iface->debug_dir) {
-		debugfs_rename(batadv_debugfs, hard_iface->debug_dir,
-			       batadv_debugfs, new_name);
-	}
-}
-
 int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index e7d19c1..1ab4e2e 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -34,7 +34,6 @@ int batadv_debugfs_add_meshif(struct net_device *dev);
 void batadv_debugfs_del_meshif(struct net_device *dev);
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface);
 void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface);
-void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface);
 
 #else
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ccc7641..1f90808 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -706,23 +706,6 @@ out:
 	return NULL;
 }
 
-/**
- * batadv_hardif_rename - rename the sysfs and debugfs
- * @hard_iface: The hard interface to rename
- *
- * The sysfs and debugfs files cannot be removed until all users close
- * them.  So the removal is deferred into a work queue. This however
- * means if the interface comes back before the work queue runs, the
- * files are still there, and so the create gives an EEXISTS error. To
- * avoid this, rename them to a tempory name.
- */
-static void batadv_hardif_rename(struct batadv_hard_iface *hard_iface)
-{
-	batadv_sysfs_rename_hardif(&hard_iface->hardif_obj,
-				   hard_iface->net_dev);
-	batadv_debugfs_rename_hardif(hard_iface);
-}
-
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 {
 	ASSERT_RTNL();
@@ -736,8 +719,6 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 		return;
 
 	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
-	batadv_hardif_rename(hard_iface);
-
 	queue_work(batadv_event_workqueue, &hard_iface->cleanup_work);
 }
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 9b2c28f..fe9ca94 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -48,8 +48,6 @@
 #include "packet.h"
 #include "soft-interface.h"
 
-static atomic_t batadv_rename = ATOMIC_INIT(0);
-
 static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
 {
 	struct device *dev = container_of(obj->parent, struct device, kobj);
@@ -1048,21 +1046,6 @@ out:
 	return -ENOMEM;
 }
 
-void batadv_sysfs_rename_hardif(struct kobject **hardif_obj,
-				struct net_device *dev)
-{
-	char new_name[32];
-	int err;
-
-	snprintf(new_name, sizeof(*new_name) - 1, "tmp-%d",
-		 atomic_inc_return(&batadv_rename));
-
-	err = kobject_rename(*hardif_obj, new_name);
-	if (err)
-		batadv_err(dev, "Can't rename sysfs dir: %s/%s: %d\n",
-			   dev->name, new_name, err);
-}
-
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 {
 	kobject_put(*hardif_obj);
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index 64d3722..c76021b 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -48,8 +48,6 @@ void batadv_sysfs_del_meshif(struct net_device *dev);
 int batadv_sysfs_add_hardif(struct kobject **hardif_obj,
 			    struct net_device *dev);
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj);
-void batadv_sysfs_rename_hardif(struct kobject **hardif_obj,
-				struct net_device *dev);
 int batadv_sysfs_add_vlan(struct net_device *dev,
 			  struct batadv_softif_vlan *vlan);
 void batadv_sysfs_del_vlan(struct batadv_priv *bat_priv,
-- 
2.8.1

