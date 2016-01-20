Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 20 Jan 2016 18:48:30 +0100
Message-Id: <1453312110-32683-5-git-send-email-andrew@lunn.ch>
In-Reply-To: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: debugfs: Add netns support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

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
---
 net/batman-adv/debugfs.c | 118 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index c4c1e80..b87ffad 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -53,6 +53,73 @@
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
+		sprintf(name, "%u", net->ns.inum);
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
@@ -438,6 +505,7 @@ void batadv_debugfs_init(void)
 {
 	struct batadv_debuginfo **bat_debug;
 	struct dentry *file;
+	char name[32];
 
 	batadv_debugfs = debugfs_create_dir(BATADV_DEBUGFS_SUBDIR, NULL);
 	if (batadv_debugfs == ERR_PTR(-ENODEV))
@@ -458,6 +526,15 @@ void batadv_debugfs_init(void)
 		}
 	}
 
+	batadv_ns_debugfs = debugfs_create_dir("netns", batadv_debugfs);
+	if (!batadv_ns_debugfs)
+		goto err;
+
+	/* Create a symlink for the default name space */
+	sprintf(name, "%u", init_net.ns.inum);
+	if (!debugfs_create_symlink(name, batadv_ns_debugfs, ".."))
+		goto err;
+
 	return;
 err:
 	debugfs_remove_recursive(batadv_debugfs);
@@ -477,14 +554,26 @@ void batadv_debugfs_destroy(void)
  */
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
 {
+	char *name = hard_iface->net_dev->name;
+	struct net *net = dev_net(hard_iface->net_dev);
 	struct batadv_debuginfo **bat_debug;
+	struct dentry *debugfs_ns_dir;
 	struct dentry *file;
 
 	if (!batadv_debugfs)
 		goto out;
 
-	hard_iface->debug_dir = debugfs_create_dir(hard_iface->net_dev->name,
-						   batadv_debugfs);
+	if (net != &init_net) {
+		debugfs_ns_dir = batadv_debugfs_ns_get(net);
+		if (!debugfs_ns_dir)
+			goto out;
+		hard_iface->debug_dir = debugfs_create_dir(name,
+							   debugfs_ns_dir);
+	} else {
+		hard_iface->debug_dir = debugfs_create_dir(name,
+							   batadv_debugfs);
+	}
+
 	if (!hard_iface->debug_dir)
 		goto out;
 
@@ -502,6 +591,8 @@ int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
 rem_attr:
 	debugfs_remove_recursive(hard_iface->debug_dir);
 	hard_iface->debug_dir = NULL;
+	if (net != &init_net)
+		batadv_debugfs_ns_put(net);
 out:
 	return -ENOMEM;
 }
@@ -513,22 +604,38 @@ out:
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
+	if (net != &init_net) {
+		debugfs_ns_dir = batadv_debugfs_ns_get(net);
+		if (!debugfs_ns_dir)
+			goto out;
+		bat_priv->debug_dir = debugfs_create_dir(dev->name,
+							 debugfs_ns_dir);
+	} else {
+		bat_priv->debug_dir = debugfs_create_dir(dev->name,
+							 batadv_debugfs);
+	}
+
 	if (!bat_priv->debug_dir)
 		goto out;
 
@@ -557,6 +664,8 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 rem_attr:
 	debugfs_remove_recursive(bat_priv->debug_dir);
 	bat_priv->debug_dir = NULL;
+	if (net != &init_net)
+		batadv_debugfs_ns_put(net);
 out:
 	return -ENOMEM;
 }
@@ -564,6 +673,7 @@ out:
 void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net *net = dev_net(dev);
 
 	batadv_debug_log_cleanup(bat_priv);
 
@@ -571,4 +681,6 @@ void batadv_debugfs_del_meshif(struct net_device *dev)
 		debugfs_remove_recursive(bat_priv->debug_dir);
 		bat_priv->debug_dir = NULL;
 	}
+	if (net != &init_net)
+		batadv_debugfs_ns_put(net);
 }
-- 
2.7.0.rc3

