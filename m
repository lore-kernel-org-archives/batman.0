Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Apr 2016 22:37:20 +0200
Message-Id: <1461875848-11720-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: Suppress debugfs entries
	for netns's
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Debugfs is not netns aware. It thus has problems when the same
interface name exists in multiple network name spaces.

Work around this by not creating entries for interfaces in name spaces
other than the default name space. This means meshes in network
namespaces cannot be managed via debugfs, but there will soon be a
netlink interface which is netns aware.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/debugfs.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 9529004..c6dd52a 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -78,7 +78,7 @@ static void batadv_emit_log_char(struct batadv_priv_debug_log *debug_log,
 		debug_log->log_start = debug_log->log_end - batadv_log_buff_len;
 }
 
-__printf(2, 3)
+_printf(2, 3)
 static int batadv_fdebug_log(struct batadv_priv_debug_log *debug_log,
 			     const char *fmt, ...)
 {
@@ -495,12 +495,16 @@ void batadv_debugfs_destroy(void)
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
@@ -531,6 +535,11 @@ out:
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
@@ -541,11 +550,15 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
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
@@ -582,6 +595,10 @@ out:
 void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct net *net = dev_net(dev);
+
+	if (net != &init_net)
+		return;
 
 	batadv_debug_log_cleanup(bat_priv);
 
-- 
2.8.0.rc3

