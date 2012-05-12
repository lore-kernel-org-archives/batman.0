Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:23 +0200
Message-Id: <1336781383-15649-3-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 03/23] batman-adv: Prefix bat_debugfs
	non-static functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_debugfs.c    |   10 +++++-----
 bat_debugfs.h    |    8 ++++----
 main.c           |    4 ++--
 main.h           |    5 +++--
 soft-interface.c |    6 +++---
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index 3b588f8..3b3790e 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -76,7 +76,7 @@ static int fdebug_log(struct debug_log *debug_log, const char *fmt, ...)
 	return 0;
 }
 
-int debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
+int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
 {
 	va_list args;
 	char tmp_log_buf[256];
@@ -304,7 +304,7 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
 	NULL,
 };
 
-void debugfs_init(void)
+void batadv_debugfs_init(void)
 {
 	struct bat_debuginfo *bat_debug;
 	struct dentry *file;
@@ -327,7 +327,7 @@ out:
 	return;
 }
 
-void debugfs_destroy(void)
+void batadv_debugfs_destroy(void)
 {
 	if (bat_debugfs) {
 		debugfs_remove_recursive(bat_debugfs);
@@ -335,7 +335,7 @@ void debugfs_destroy(void)
 	}
 }
 
-int debugfs_add_meshif(struct net_device *dev)
+int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct bat_debuginfo **bat_debug;
@@ -375,7 +375,7 @@ out:
 #endif /* CONFIG_DEBUG_FS */
 }
 
-void debugfs_del_meshif(struct net_device *dev)
+void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 
diff --git a/bat_debugfs.h b/bat_debugfs.h
index d605c67..3b206c8 100644
--- a/bat_debugfs.h
+++ b/bat_debugfs.h
@@ -25,9 +25,9 @@
 
 #define DEBUGFS_BAT_SUBDIR "batman_adv"
 
-void debugfs_init(void);
-void debugfs_destroy(void);
-int debugfs_add_meshif(struct net_device *dev);
-void debugfs_del_meshif(struct net_device *dev);
+void batadv_debugfs_init(void);
+void batadv_debugfs_destroy(void);
+int batadv_debugfs_add_meshif(struct net_device *dev);
+void batadv_debugfs_del_meshif(struct net_device *dev);
 
 #endif /* _NET_BATMAN_ADV_DEBUGFS_H_ */
diff --git a/main.c b/main.c
index f272ed4..3bddd63 100644
--- a/main.c
+++ b/main.c
@@ -66,7 +66,7 @@ static int __init batman_init(void)
 		return -ENOMEM;
 
 	bat_socket_init();
-	debugfs_init();
+	batadv_debugfs_init();
 
 	register_netdevice_notifier(&hard_if_notifier);
 
@@ -78,7 +78,7 @@ static int __init batman_init(void)
 
 static void __exit batman_exit(void)
 {
-	debugfs_destroy();
+	batadv_debugfs_destroy();
 	unregister_netdevice_notifier(&hard_if_notifier);
 	hardif_remove_interfaces();
 
diff --git a/main.h b/main.h
index a94ceae..fef7fd6 100644
--- a/main.h
+++ b/main.h
@@ -182,12 +182,13 @@ int bat_algo_select(struct bat_priv *bat_priv, char *name);
 int bat_algo_seq_print_text(struct seq_file *seq, void *offset);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-int debug_log(struct bat_priv *bat_priv, const char *fmt, ...) __printf(2, 3);
+int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
+__printf(2, 3);
 
 #define bat_dbg(type, bat_priv, fmt, arg...)			\
 	do {							\
 		if (atomic_read(&bat_priv->log_level) & type)	\
-			debug_log(bat_priv, fmt, ## arg);	\
+			batadv_debug_log(bat_priv, fmt, ## arg);\
 	}							\
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
diff --git a/soft-interface.c b/soft-interface.c
index 101253d..1a9ba93 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -434,7 +434,7 @@ struct net_device *softif_create(const char *name)
 	if (ret < 0)
 		goto free_bat_counters;
 
-	ret = debugfs_add_meshif(soft_iface);
+	ret = batadv_debugfs_add_meshif(soft_iface);
 	if (ret < 0)
 		goto unreg_sysfs;
 
@@ -445,7 +445,7 @@ struct net_device *softif_create(const char *name)
 	return soft_iface;
 
 unreg_debugfs:
-	debugfs_del_meshif(soft_iface);
+	batadv_debugfs_del_meshif(soft_iface);
 unreg_sysfs:
 	sysfs_del_meshif(soft_iface);
 free_bat_counters:
@@ -462,7 +462,7 @@ out:
 
 void softif_destroy(struct net_device *soft_iface)
 {
-	debugfs_del_meshif(soft_iface);
+	batadv_debugfs_del_meshif(soft_iface);
 	sysfs_del_meshif(soft_iface);
 	mesh_free(soft_iface);
 	unregister_netdevice(soft_iface);
-- 
1.7.10

