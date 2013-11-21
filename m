Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 21 Nov 2013 11:52:15 +0100
Message-Id: <1385031136-15967-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1385031136-15967-1-git-send-email-sw@simonwunderlich.de>
References: <1385031136-15967-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv4 1/2] batman-adv: add debugfs structure for
	information per interface
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

To show information per interface, add a debugfs hardif structure
similar to the system in sysfs. Hard interface folders will be created
in "$debugfs/batman-adv/". Files are not yet added.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to PATCHv3:
 * move hardif debugfs files into $debugfs/batman-adv/$hardif

Changes to PATCHv2:
 * add macro to add hardif debug infos
---
 debugfs.c        |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debugfs.h        |    2 ++
 hard-interface.c |    9 +++++++
 types.h          |    2 ++
 4 files changed, 83 insertions(+)

diff --git a/debugfs.c b/debugfs.c
index 367ea86..e01e1c0 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -366,6 +366,22 @@ static struct batadv_debuginfo *batadv_mesh_debuginfos[] = {
 	NULL,
 };
 
+#define BATADV_HARDIF_DEBUGINFO(_name, _mode, _open)		\
+struct batadv_debuginfo batadv_hardif_debuginfo_##_name = {	\
+	.attr = { .name = __stringify(_name),			\
+		  .mode = _mode, },				\
+	.fops = { .owner = THIS_MODULE,				\
+		  .open = _open,				\
+		  .read	= seq_read,				\
+		  .llseek = seq_lseek,				\
+		  .release = single_release,			\
+		}						\
+};
+
+static struct batadv_debuginfo *batadv_hardif_debuginfos[] = {
+	NULL,
+};
+
 void batadv_debugfs_init(void)
 {
 	struct batadv_debuginfo **bat_debug;
@@ -393,6 +409,7 @@ void batadv_debugfs_init(void)
 	return;
 err:
 	debugfs_remove_recursive(batadv_debugfs);
+	batadv_debugfs = NULL;
 }
 
 void batadv_debugfs_destroy(void)
@@ -401,6 +418,59 @@ void batadv_debugfs_destroy(void)
 	batadv_debugfs = NULL;
 }
 
+/**
+ * batadv_debugfs_add_hardif - creates the base directory for a hard interface
+ *  in debugfs.
+ * @hard_iface: hard interface which should be added.
+ */
+int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_debuginfo **bat_debug;
+	struct dentry *file;
+
+	if (!batadv_debugfs)
+		goto out;
+
+	hard_iface->debug_dir = debugfs_create_dir(hard_iface->net_dev->name,
+						   batadv_debugfs);
+	if (!hard_iface->debug_dir)
+		goto out;
+
+	for (bat_debug = batadv_hardif_debuginfos; *bat_debug; ++bat_debug) {
+		file = debugfs_create_file(((*bat_debug)->attr).name,
+					   S_IFREG | ((*bat_debug)->attr).mode,
+					   hard_iface->debug_dir,
+					   hard_iface->net_dev,
+					   &(*bat_debug)->fops);
+		if (!file)
+			goto rem_attr;
+	}
+
+	return 0;
+rem_attr:
+	debugfs_remove_recursive(hard_iface->debug_dir);
+	hard_iface->debug_dir = NULL;
+out:
+#ifdef CONFIG_DEBUG_FS
+	return -ENOMEM;
+#else
+	return 0;
+#endif /* CONFIG_DEBUG_FS */
+}
+
+/**
+ * batadv_debugfs_del_hardif - delete the base directory for a hard interface
+ *  in debugfs.
+ * @hard_iface: hard interface which is deleted.
+ */
+void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
+{
+	if (batadv_debugfs) {
+		debugfs_remove_recursive(hard_iface->debug_dir);
+		hard_iface->debug_dir = NULL;
+	}
+}
+
 int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
diff --git a/debugfs.h b/debugfs.h
index 169ab7b..f6e16f3 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -21,5 +21,7 @@ void batadv_debugfs_init(void);
 void batadv_debugfs_destroy(void);
 int batadv_debugfs_add_meshif(struct net_device *dev);
 void batadv_debugfs_del_meshif(struct net_device *dev);
+int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface);
+void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface);
 
 #endif /* _NET_BATMAN_ADV_DEBUGFS_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index 42db38e..3873175 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -20,6 +20,7 @@
 #include "translation-table.h"
 #include "routing.h"
 #include "sysfs.h"
+#include "debugfs.h"
 #include "originator.h"
 #include "hash.h"
 #include "bridge_loop_avoidance.h"
@@ -536,6 +537,7 @@ static void batadv_hardif_remove_interface_finish(struct work_struct *work)
 	hard_iface = container_of(work, struct batadv_hard_iface,
 				  cleanup_work);
 
+	batadv_debugfs_del_hardif(hard_iface);
 	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
 	batadv_hardif_free_ref(hard_iface);
 }
@@ -566,6 +568,11 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	hard_iface->net_dev = net_dev;
 	hard_iface->soft_iface = NULL;
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
+
+	ret = batadv_debugfs_add_hardif(hard_iface);
+	if (ret)
+		goto free_sysfs;
+
 	INIT_LIST_HEAD(&hard_iface->list);
 	INIT_WORK(&hard_iface->cleanup_work,
 		  batadv_hardif_remove_interface_finish);
@@ -582,6 +589,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	return hard_iface;
 
+free_sysfs:
+	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
 free_if:
 	kfree(hard_iface);
 release_dev:
diff --git a/types.h b/types.h
index 245a547..0e5d238 100644
--- a/types.h
+++ b/types.h
@@ -81,6 +81,7 @@ struct batadv_hard_iface_bat_iv {
  * @rcu: struct used for freeing in an RCU-safe manner
  * @bat_iv: BATMAN IV specific per hard interface data
  * @cleanup_work: work queue callback item for hard interface deinit
+ * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
  */
 struct batadv_hard_iface {
 	struct list_head list;
@@ -95,6 +96,7 @@ struct batadv_hard_iface {
 	struct rcu_head rcu;
 	struct batadv_hard_iface_bat_iv bat_iv;
 	struct work_struct cleanup_work;
+	struct dentry *debug_dir;
 };
 
 /**
-- 
1.7.10.4

