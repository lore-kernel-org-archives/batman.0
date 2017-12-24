Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 24 Dec 2017 15:30:23 +0100
Message-Id: <20171224143023.4209-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: annotate ->poll() instances
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

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[sven@narfation.org: add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
The patch is already in
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=for-next
---
 compat-include/linux/types.h | 38 ++++++++++++++++++++++++++++++++++++++
 net/batman-adv/icmp_socket.c |  2 +-
 net/batman-adv/log.c         |  2 +-
 3 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 compat-include/linux/types.h

diff --git a/compat-include/linux/types.h b/compat-include/linux/types.h
new file mode 100644
index 00000000..f33f2bb2
--- /dev/null
+++ b/compat-include/linux/types.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_TYPES_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_TYPES_H_
+
+#include <linux/version.h>
+#include_next <linux/types.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 16, 0)
+
+#ifdef __CHECK_POLL
+typedef unsigned __bitwise __poll_t;
+#else
+typedef unsigned __poll_t;
+#endif
+
+#endif /* < KERNEL_VERSION(4, 16, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_TYPES_H_ */
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 8041cf10..581375d0 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -297,7 +297,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	return len;
 }
 
-static unsigned int batadv_socket_poll(struct file *file, poll_table *wait)
+static __poll_t batadv_socket_poll(struct file *file, poll_table *wait)
 {
 	struct batadv_socket_client *socket_client = file->private_data;
 
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index da004980..9be74a44 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -185,7 +185,7 @@ static ssize_t batadv_log_read(struct file *file, char __user *buf,
 	return error;
 }
 
-static unsigned int batadv_log_poll(struct file *file, poll_table *wait)
+static __poll_t batadv_log_poll(struct file *file, poll_table *wait)
 {
 	struct batadv_priv *bat_priv = file->private_data;
 	struct batadv_priv_debug_log *debug_log = bat_priv->debug_log;
-- 
2.11.0

