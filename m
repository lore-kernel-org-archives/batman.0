Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  8 Jan 2019 09:16:21 +0100
Message-Id: <20190108081621.15102-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove 'type' argument from
 access_ok() function
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Nobody has actually used the type (VERIFY_READ vs VERIFY_WRITE) argument
of the user address range verification function since we got rid of the
old racy i386-only code to walk page tables by hand.

It existed because the original 80386 would not honor the write protect
bit when in kernel mode, so you had to do COW by hand before doing any
user access.  But we haven't supported that in a long time, and these
days the 'type' argument is a purely historical artifact.

A discussion about extending 'user_access_begin()' to do the range
checking resulted this patch, because there is no way we're going to
move the old VERIFY_xyz interface to that model.  And it's best done at
the end of the merge window when I've done most of my merges, so let's
just get this done once and for all.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[sven@narfation.org: Added compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Original commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96d4f267e40f9509e8a66e2b39e8b95655617693

 compat-include/linux/uaccess.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/icmp_socket.c   |  2 +-
 net/batman-adv/log.c           |  2 +-
 3 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 compat-include/linux/uaccess.h

diff --git a/compat-include/linux/uaccess.h b/compat-include/linux/uaccess.h
new file mode 100644
index 00000000..0cd56a60
--- /dev/null
+++ b/compat-include/linux/uaccess.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_UACCESS_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_UACCESS_H_
+
+#include <linux/version.h>
+#include_next <linux/uaccess.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 0, 0)
+
+static inline int batadv_access_ok(int type, const void __user *p,
+				   unsigned long size)
+{
+	return access_ok(type, p, size);
+}
+
+#ifdef access_ok
+#undef access_ok
+#endif
+
+#define access_ok(addr, size)	batadv_access_ok(VERIFY_WRITE, (addr), (size))
+
+#endif /* < KERNEL_VERSION(5, 0, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_UACCESS_H_ */
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index d34bb79e..9859abab 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -147,7 +147,7 @@ static ssize_t batadv_socket_read(struct file *file, char __user *buf,
 	if (!buf || count < sizeof(struct batadv_icmp_packet))
 		return -EINVAL;
 
-	if (!access_ok(VERIFY_WRITE, buf, count))
+	if (!access_ok(buf, count))
 		return -EFAULT;
 
 	error = wait_event_interruptible(socket_client->queue_wait,
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index f97849a8..3e610df8 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -136,7 +136,7 @@ static ssize_t batadv_log_read(struct file *file, char __user *buf,
 	if (count == 0)
 		return 0;
 
-	if (!access_ok(VERIFY_WRITE, buf, count))
+	if (!access_ok(buf, count))
 		return -EFAULT;
 
 	error = wait_event_interruptible(debug_log->queue_wait,
-- 
2.11.0

