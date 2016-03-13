Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 19:50:34 +0100
Message-Id: <1457895034-13823-6-git-send-email-sven@narfation.org>
In-Reply-To: <3465881.llCNFeNLl4@sven-edge>
References: <3465881.llCNFeNLl4@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v3 6/6] batman-adv: debugfs: Add netns support
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

From: Andrew Lunn <andrew@lunn.ch>

Unlike sysfs, debugfs is not netns aware. So batman has to take care
to avoid namespace clashes.

Each namespace is given a directory within debugfs/batman-adv/netns,
using the namespaces inum as the directory name.

Files for namespaces other than the global namespace are placed within
the namespace specific directory. Additionally, a symbolic link is
used to link the global namespaces inum back to debugfs/batman-adv/ so
tools do not need to differentiate between the global namespace and
other namespaces.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-patches/0002-ns.inum.patch |  25 ++++++++
 net/batman-adv/debugfs.c          | 130 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 152 insertions(+), 3 deletions(-)
 create mode 100644 compat-patches/0002-ns.inum.patch

diff --git a/compat-patches/0002-ns.inum.patch b/compat-patches/0002-ns.inum.patch
new file mode 100644
index 0000000..9856f6e
--- /dev/null
+++ b/compat-patches/0002-ns.inum.patch
@@ -0,0 +1,25 @@
+From: Sven Eckelmann <sven@narfation.org>
+Date: Sat, 12 Mar 2016 00:24:58 +0100
+Subject: [PATCH] ns.inum
+---
+ net/batman-adv/debugfs.c | 6 ++++++
+ 1 file changed, 6 insertions(+)
+
+diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
+index cc583e6..59616a6 100644
+--- a/net/batman-adv/debugfs.c
++++ b/net/batman-adv/debugfs.c
+@@ -78,7 +78,13 @@ static DEFINE_MUTEX(batadv_debugfs_ns_mutex);
+  */
+ static unsigned int batadv_debugfs_ns_id(const struct net *net)
+ {
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
++	return 0; /* ???? */
++#elif LINUX_VERSION_CODE < KERNEL_VERSION(3, 19, 0)
++	return net->proc_inum;
++#else
+ 	return net->ns.inum;
++#endif
+ }
+ 
+ static struct dentry *batadv_debugfs_ns_get(struct net *net)
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 3dc5208..cc583e6 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -27,8 +27,12 @@
 #include <linux/fs.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
+#include <linux/ns_common.h>
 #include <linux/poll.h>
 #include <linux/printk.h>
 #include <linux/sched.h> /* for linux/wait.h */
@@ -42,6 +46,7 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
+#include <net/net_namespace.h>
 #include <stdarg.h>
 
 #include "bridge_loop_avoidance.h"
@@ -53,6 +58,84 @@
 #include "translation-table.h"
 
 static struct dentry *batadv_debugfs;
+static struct dentry *batadv_ns_debugfs;
+
+struct batadv_debugfs_ns_entry {
+	struct net *net;
+	struct dentry *dir;
+	struct kref refcount;
+	struct list_head link;
+};
+
+static LIST_HEAD(batadv_debugfs_ns);
+static DEFINE_MUTEX(batadv_debugfs_ns_mutex);
+
+/**
+ * batadv_debugfs_ns_id - Get namespace specific id
+ * @net: namespace of the soft-interface
+ *
+ * Return: internal id of the namespace
+ */
+static unsigned int batadv_debugfs_ns_id(const struct net *net)
+{
+	return net->ns.inum;
+}
+
+static struct dentry *batadv_debugfs_ns_get(struct net *net)
+{
+	struct batadv_debugfs_ns_entry *ns_entry;
+	char name[32];
+
+	mutex_lock(&batadv_debugfs_ns_mutex);
+	list_for_each_entry(ns_entry, &batadv_debugfs_ns, link) {
+		if (ns_entry->net == net) {
+			kref_get(&ns_entry->refcount);
+			mutex_unlock(&batadv_debugfs_ns_mutex);
+			return ns_entry->dir;
+		}
+	}
+
+	ns_entry = kzalloc(sizeof(*ns_entry), GFP_ATOMIC);
+	if (ns_entry) {
+		INIT_LIST_HEAD(&ns_entry->link);
+		ns_entry->net = net;
+		kref_init(&ns_entry->refcount);
+		sprintf(name, "%u", batadv_debugfs_ns_id(net));
+		ns_entry->dir = debugfs_create_dir(name, batadv_ns_debugfs);
+		if (!ns_entry->dir) {
+			kfree(ns_entry);
+			mutex_unlock(&batadv_debugfs_ns_mutex);
+			return NULL;
+		}
+		list_add(&ns_entry->link, &batadv_debugfs_ns);
+	}
+	mutex_unlock(&batadv_debugfs_ns_mutex);
+	return ns_entry->dir;
+}
+
+static void batadv_ns_entry_release(struct kref *ref)
+{
+	struct batadv_debugfs_ns_entry *ns_entry;
+
+	ns_entry = container_of(ref, struct batadv_debugfs_ns_entry, refcount);
+	debugfs_remove_recursive(ns_entry->dir);
+	list_del(&ns_entry->link);
+	kfree(ns_entry);
+}
+
+static void batadv_debugfs_ns_put(struct net *net)
+{
+	struct batadv_debugfs_ns_entry *ns_entry;
+
+	mutex_lock(&batadv_debugfs_ns_mutex);
+	list_for_each_entry(ns_entry, &batadv_debugfs_ns, link) {
+		if (ns_entry->net == net) {
+			kref_put(&ns_entry->refcount, batadv_ns_entry_release);
+			break;
+		}
+	}
+	mutex_unlock(&batadv_debugfs_ns_mutex);
+}
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 #define BATADV_LOG_BUFF_MASK (batadv_log_buff_len - 1)
@@ -451,6 +534,7 @@ void batadv_debugfs_init(void)
 {
 	struct batadv_debuginfo **bat_debug;
 	struct dentry *file;
+	char name[32];
 
 	batadv_debugfs = debugfs_create_dir(BATADV_DEBUGFS_SUBDIR, NULL);
 	if (batadv_debugfs == ERR_PTR(-ENODEV))
@@ -471,6 +555,15 @@ void batadv_debugfs_init(void)
 		}
 	}
 
+	batadv_ns_debugfs = debugfs_create_dir("netns", batadv_debugfs);
+	if (!batadv_ns_debugfs)
+		goto err;
+
+	/* Create a symlink for the default name space */
+	sprintf(name, "%u", batadv_debugfs_ns_id(&init_net));
+	if (!debugfs_create_symlink(name, batadv_ns_debugfs, ".."))
+		goto err;
+
 	return;
 err:
 	debugfs_remove_recursive(batadv_debugfs);
@@ -492,14 +585,24 @@ void batadv_debugfs_destroy(void)
  */
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
 {
+	struct net *net = dev_net(hard_iface->net_dev);
+	char *name = hard_iface->net_dev->name;
 	struct batadv_debuginfo **bat_debug;
+	struct dentry *debugfs_ns_dir;
 	struct dentry *file;
 
 	if (!batadv_debugfs)
 		goto out;
 
-	hard_iface->debug_dir = debugfs_create_dir(hard_iface->net_dev->name,
-						   batadv_debugfs);
+	debugfs_ns_dir = batadv_debugfs;
+
+	if (net != &init_net) {
+		debugfs_ns_dir = batadv_debugfs_ns_get(net);
+		if (!debugfs_ns_dir)
+			goto out;
+	}
+
+	hard_iface->debug_dir = debugfs_create_dir(name, debugfs_ns_dir);
 	if (!hard_iface->debug_dir)
 		goto out;
 
@@ -517,6 +620,8 @@ int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
 rem_attr:
 	debugfs_remove_recursive(hard_iface->debug_dir);
 	hard_iface->debug_dir = NULL;
+	if (net != &init_net)
+		batadv_debugfs_ns_put(net);
 out:
 	return -ENOMEM;
 }
@@ -528,22 +633,36 @@ out:
  */
 void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
 {
+	struct net *net = dev_net(hard_iface->net_dev);
+
 	if (batadv_debugfs) {
 		debugfs_remove_recursive(hard_iface->debug_dir);
 		hard_iface->debug_dir = NULL;
 	}
+	if (net != &init_net)
+		batadv_debugfs_ns_put(net);
 }
 
 int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct batadv_debuginfo **bat_debug;
+	struct net *net = dev_net(dev);
+	struct dentry *debugfs_ns_dir;
 	struct dentry *file;
 
 	if (!batadv_debugfs)
 		goto out;
 
-	bat_priv->debug_dir = debugfs_create_dir(dev->name, batadv_debugfs);
+	debugfs_ns_dir = batadv_debugfs;
+
+	if (net != &init_net) {
+		debugfs_ns_dir = batadv_debugfs_ns_get(net);
+		if (!debugfs_ns_dir)
+			goto out;
+	}
+
+	bat_priv->debug_dir = debugfs_create_dir(dev->name, debugfs_ns_dir);
 	if (!bat_priv->debug_dir)
 		goto out;
 
@@ -572,6 +691,8 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 rem_attr:
 	debugfs_remove_recursive(bat_priv->debug_dir);
 	bat_priv->debug_dir = NULL;
+	if (net != &init_net)
+		batadv_debugfs_ns_put(net);
 out:
 	return -ENOMEM;
 }
@@ -579,6 +700,7 @@ out:
 void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net *net = dev_net(dev);
 
 	batadv_debug_log_cleanup(bat_priv);
 
@@ -586,4 +708,6 @@ void batadv_debugfs_del_meshif(struct net_device *dev)
 		debugfs_remove_recursive(bat_priv->debug_dir);
 		bat_priv->debug_dir = NULL;
 	}
+	if (net != &init_net)
+		batadv_debugfs_ns_put(net);
 }
-- 
2.7.0

