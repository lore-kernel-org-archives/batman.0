Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 May 2016 17:59:33 +0200
Message-Id: <1464019185-8381-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
References: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v8 02/14] batman-adv: Suppress debugfs
	entries for netns's
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

Debugfs is not netns aware. It thus has problems when the same
interface name exists in multiple network name spaces.

Work around this by not creating entries for interfaces in name spaces
other than the default name space. This means meshes in network
namespaces cannot be managed via debugfs, but there will soon be a
netlink interface which is netns aware.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/debugfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 1d68b6e..b4ffba7 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -31,6 +31,7 @@
 #include <linux/stddef.h>
 #include <linux/stringify.h>
 #include <linux/sysfs.h>
+#include <net/net_namespace.h>
 
 #include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
@@ -305,12 +306,16 @@ void batadv_debugfs_destroy(void)
  */
 int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
 {
+	struct net *net = dev_net(hard_iface->net_dev);
 	struct batadv_debuginfo **bat_debug;
 	struct dentry *file;
 
 	if (!batadv_debugfs)
 		goto out;
 
+	if (net != &init_net)
+		return 0;
+
 	hard_iface->debug_dir = debugfs_create_dir(hard_iface->net_dev->name,
 						   batadv_debugfs);
 	if (!hard_iface->debug_dir)
@@ -341,6 +346,11 @@ out:
  */
 void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface)
 {
+	struct net *net = dev_net(hard_iface->net_dev);
+
+	if (net != &init_net)
+		return;
+
 	if (batadv_debugfs) {
 		debugfs_remove_recursive(hard_iface->debug_dir);
 		hard_iface->debug_dir = NULL;
@@ -351,11 +361,15 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct batadv_debuginfo **bat_debug;
+	struct net *net = dev_net(dev);
 	struct dentry *file;
 
 	if (!batadv_debugfs)
 		goto out;
 
+	if (net != &init_net)
+		return 0;
+
 	bat_priv->debug_dir = debugfs_create_dir(dev->name, batadv_debugfs);
 	if (!bat_priv->debug_dir)
 		goto out;
@@ -392,6 +406,10 @@ out:
 void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net *net = dev_net(dev);
+
+	if (net != &init_net)
+		return;
 
 	batadv_debug_log_cleanup(bat_priv);
 
-- 
2.8.1

