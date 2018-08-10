Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Aug 2018 23:36:15 +0200
Message-Id: <20180810213616.23794-2-sven@narfation.org>
In-Reply-To: <20180810213616.23794-1-sven@narfation.org>
References: <20180810213616.23794-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Mark debugfs functionality
 as deprecated
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

CONFIG_BATMAN_ADV_DEBUGFS is disabled by default because debugfs is not
supported for batman-adv interfaces in any non-default netns. Any remaining
users of this interface should still be informed about the deprecation and
the generic netlink alternative.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/fs.h    | 37 ++++++++++++++++++++++++++++++++++++
 net/batman-adv/debugfs.c     | 37 ++++++++++++++++++++++++++++++++++++
 net/batman-adv/debugfs.h     |  6 ++++++
 net/batman-adv/icmp_socket.c |  3 +++
 net/batman-adv/log.c         |  4 ++++
 5 files changed, 87 insertions(+)
 create mode 100644 compat-include/linux/fs.h

diff --git a/compat-include/linux/fs.h b/compat-include/linux/fs.h
new file mode 100644
index 00000000..4d6bb1d7
--- /dev/null
+++ b/compat-include/linux/fs.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_FS_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_FS_H_
+
+#include <linux/version.h>
+#include_next <linux/fs.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
+
+static inline struct dentry *file_dentry(const struct file *file)
+{
+	return file->f_path.dentry;
+}
+
+#endif /* < KERNEL_VERSION(4, 6, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_FS_H_ */
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 3cb82378..8b608a2e 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -47,8 +47,24 @@
 
 static struct dentry *batadv_debugfs;
 
+/**
+ * batadv_debugfs_deprecated() - Log use of deprecated batadv debugfs access
+ * @file: file which was accessed
+ * @alt: explanation what can be used as alternative
+ */
+void batadv_debugfs_deprecated(struct file *file, const char *alt)
+{
+	struct dentry *dentry = file_dentry(file);
+	const char *name = dentry->d_name.name;
+
+	pr_warn_ratelimited(DEPRECATED "%s (pid %d) Use of debugfs file \"%s\".\n%s",
+			    current->comm, task_pid_nr(current), name, alt);
+}
+
 static int batadv_algorithms_open(struct inode *inode, struct file *file)
 {
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_ROUTING_ALGOS instead\n");
 	return single_open(file, batadv_algo_seq_print_text, NULL);
 }
 
@@ -56,6 +72,8 @@ static int neighbors_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_NEIGHBORS instead\n");
 	return single_open(file, batadv_hardif_neigh_seq_print_text, net_dev);
 }
 
@@ -63,6 +81,8 @@ static int batadv_originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_ORIGINATORS instead\n");
 	return single_open(file, batadv_orig_seq_print_text, net_dev);
 }
 
@@ -79,6 +99,8 @@ static int batadv_originators_hardif_open(struct inode *inode,
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_HARDIFS instead\n");
 	return single_open(file, batadv_orig_hardif_seq_print_text, net_dev);
 }
 
@@ -86,6 +108,8 @@ static int batadv_gateways_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_GATEWAYS instead\n");
 	return single_open(file, batadv_gw_client_seq_print_text, net_dev);
 }
 
@@ -93,6 +117,8 @@ static int batadv_transtable_global_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_TRANSTABLE_GLOBAL instead\n");
 	return single_open(file, batadv_tt_global_seq_print_text, net_dev);
 }
 
@@ -101,6 +127,8 @@ static int batadv_bla_claim_table_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_BLA_CLAIM instead\n");
 	return single_open(file, batadv_bla_claim_table_seq_print_text,
 			   net_dev);
 }
@@ -110,6 +138,8 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_BLA_BACKBONE instead\n");
 	return single_open(file, batadv_bla_backbone_table_seq_print_text,
 			   net_dev);
 }
@@ -128,6 +158,8 @@ static int batadv_dat_cache_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_DAT_CACHE instead\n");
 	return single_open(file, batadv_dat_cache_seq_print_text, net_dev);
 }
 #endif
@@ -136,6 +168,8 @@ static int batadv_transtable_local_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_TRANSTABLE_LOCAL instead\n");
 	return single_open(file, batadv_tt_local_seq_print_text, net_dev);
 }
 
@@ -149,6 +183,7 @@ static int batadv_nc_nodes_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file, "");
 	return single_open(file, batadv_nc_nodes_seq_print_text, net_dev);
 }
 #endif
@@ -165,6 +200,8 @@ static int batadv_mcast_flags_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
 
+	batadv_debugfs_deprecated(file,
+				  "Use genl command BATADV_CMD_GET_MCAST_FLAGS instead\n");
 	return single_open(file, batadv_mcast_flags_seq_print_text, net_dev);
 }
 #endif
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 08a592ff..8de018e5 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -21,12 +21,14 @@
 
 #include "main.h"
 
+struct file;
 struct net_device;
 
 #define BATADV_DEBUGFS_SUBDIR "batman_adv"
 
 #if IS_ENABLED(CONFIG_BATMAN_ADV_DEBUGFS)
 
+void batadv_debugfs_deprecated(struct file *file, const char *alt);
 void batadv_debugfs_init(void);
 void batadv_debugfs_destroy(void);
 int batadv_debugfs_add_meshif(struct net_device *dev);
@@ -38,6 +40,10 @@ void batadv_debugfs_del_hardif(struct batadv_hard_iface *hard_iface);
 
 #else
 
+static inline void batadv_debugfs_deprecated(struct file *file, const char *alt)
+{
+}
+
 static inline void batadv_debugfs_init(void)
 {
 }
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 55c358ad..d70f363c 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -47,6 +47,7 @@
 #include <linux/wait.h>
 #include <uapi/linux/batadv_packet.h>
 
+#include "debugfs.h"
 #include "hard-interface.h"
 #include "log.h"
 #include "originator.h"
@@ -74,6 +75,8 @@ static int batadv_socket_open(struct inode *inode, struct file *file)
 	if (!try_module_get(THIS_MODULE))
 		return -EBUSY;
 
+	batadv_debugfs_deprecated(file, "");
+
 	nonseekable_open(inode, file);
 
 	socket_client = kmalloc(sizeof(*socket_client), GFP_KERNEL);
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 853773e4..1032d84e 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -40,6 +40,8 @@
 #include <linux/wait.h>
 #include <stdarg.h>
 
+#include "debugfs.h"
+
 #define BATADV_LOG_BUFF_MASK (batadv_log_buff_len - 1)
 
 static const int batadv_log_buff_len = BATADV_LOG_BUF_LEN;
@@ -115,6 +117,8 @@ static int batadv_log_open(struct inode *inode, struct file *file)
 	if (!try_module_get(THIS_MODULE))
 		return -EBUSY;
 
+	batadv_debugfs_deprecated(file, "");
+
 	nonseekable_open(inode, file);
 	file->private_data = inode->i_private;
 	return 0;
-- 
2.18.0

