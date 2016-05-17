Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 17 May 2016 15:39:27 +0200
Message-Id: <1463492367-25513-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix hardif remove/add race
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

A hard interface can be removed and then added back in quick
succession. This is particularly true for hdlc interface when changing
the protocol.

It is not possible it synchronously remove the sysfs and debugfs
entries for the hard interface when it is removed because the files
may be open. Thus removal is deferred. The files may thus already
exist in sysfs and debugfs when the hard interface is re-added, and
the operations fail.

To fix this race, synchronously rename the debugfs and sysfs files to
a unique temporary name, thus making the name available when the
interface comes back, yet keeps open files still available.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/debugfs.c        | 23 +++++++++++++++++++++++
 net/batman-adv/debugfs.h        |  1 +
 net/batman-adv/hard-interface.c | 19 +++++++++++++++++++
 net/batman-adv/sysfs.c          | 17 +++++++++++++++++
 net/batman-adv/sysfs.h          |  2 ++
 5 files changed, 62 insertions(+)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 50545b0..8b852aa 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -55,6 +55,7 @@
 #include "translation-table.h"
 
 static struct dentry *batadv_debugfs;
+static atomic_t batadv_rename = ATOMIC_INIT(0);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 #define BATADV_LOG_BUFF_MASK (batadv_log_buff_len - 1)
@@ -570,6 +571,28 @@ void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
 	}
 }
 
+/**
+ * batadv_debugfs_rename_hardif - rename the base directory
+ * @hard_iface: hard interface which is renamed.
+ *
+ * The interface may be removed and then quickly added back
+ * again. Rename the old instance to something temporary and unique,
+ * so avoiding a name space clash if it does reappear before the deferred
+ * work completes the removal.
+ */
+void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface)
+{
+	char new_name[32];
+
+	snprintf(new_name, sizeof(*new_name) - 1, "tmp-%d",
+		 atomic_inc_return(&batadv_rename));
+
+	if (batadv_debugfs && hard_iface->debug_dir) {
+		debugfs_rename(batadv_debugfs, hard_iface->debug_dir,
+			       batadv_debugfs, new_name);
+	}
+}
+
 int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 1ab4e2e..e7d19c1 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -34,6 +34,7 @@ int batadv_debugfs_add_meshif(struct net_device *dev);
 void batadv_debugfs_del_meshif(struct net_device *dev);
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface);
 void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface);
+void batadv_debugfs_rename_hardif(struct batadv_hard_iface *hard_iface);
 
 #else
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bf4ee24..08b62d9 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -747,6 +747,23 @@ out:
 	return NULL;
 }
 
+/**
+ * batadv_hardif_rename - rename the sysfs and debugfs
+ * @hard_iface: The hard interface to rename
+ *
+ * The sysfs and debugfs files cannot be removed until all users close
+ * them.  So the removal is differed into a work queue. This however
+ * means if the interface comes back before the work queue runs, the
+ * files are still there, and so the create gives an EEXISTS error. To
+ * avoid this, rename them to a tempory name.
+ */
+static void batadv_hardif_rename(struct batadv_hard_iface *hard_iface)
+{
+	batadv_sysfs_rename_hardif(&hard_iface->hardif_obj,
+				   hard_iface->net_dev);
+	batadv_debugfs_rename_hardif(hard_iface);
+}
+
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 {
 	ASSERT_RTNL();
@@ -760,6 +777,8 @@ static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 		return;
 
 	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
+	batadv_hardif_rename(hard_iface);
+
 	queue_work(batadv_event_workqueue, &hard_iface->cleanup_work);
 }
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 233abcf..37b0aae 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -47,6 +47,8 @@
 #include "packet.h"
 #include "soft-interface.h"
 
+static atomic_t batadv_rename = ATOMIC_INIT(0);
+
 static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
 {
 	struct device *dev = container_of(obj->parent, struct device, kobj);
@@ -1045,6 +1047,21 @@ out:
 	return -ENOMEM;
 }
 
+void batadv_sysfs_rename_hardif(struct kobject **hardif_obj,
+				struct net_device *dev)
+{
+	char new_name[32];
+	int err;
+
+	snprintf(new_name, sizeof(*new_name) - 1, "tmp-%d",
+		 atomic_inc_return(&batadv_rename));
+
+	err = kobject_rename(*hardif_obj, new_name);
+	if (err)
+		batadv_err(dev, "Can't rename sysfs dir: %s/%s: %d\n",
+			   dev->name, new_name, err);
+}
+
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 {
 	kobject_put(*hardif_obj);
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index c76021b..64d3722 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -48,6 +48,8 @@ void batadv_sysfs_del_meshif(struct net_device *dev);
 int batadv_sysfs_add_hardif(struct kobject **hardif_obj,
 			    struct net_device *dev);
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj);
+void batadv_sysfs_rename_hardif(struct kobject **hardif_obj,
+				struct net_device *dev);
 int batadv_sysfs_add_vlan(struct net_device *dev,
 			  struct batadv_softif_vlan *vlan);
 void batadv_sysfs_del_vlan(struct batadv_priv *bat_priv,
-- 
2.8.0.rc3

