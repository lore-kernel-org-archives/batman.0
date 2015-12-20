Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 14:17:51 +0100
Message-Id: <1450617490-3544-11-git-send-email-sven@narfation.org>
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 11/30] batman-adv: Add compatibility code
	for kref_get_unless_zero
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 compat-include/linux/kref.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 compat-include/linux/kref.h

diff --git a/compat-include/linux/kref.h b/compat-include/linux/kref.h
new file mode 100644
index 0000000..08b6328
--- /dev/null
+++ b/compat-include/linux/kref.h
@@ -0,0 +1,39 @@
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_
+
+#include <linux/version.h>
+#include_next <linux/kref.h>
+
+#include <linux/atomic.h>
+#include <linux/kernel.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
+
+static inline int __must_check kref_get_unless_zero(struct kref *kref)
+{
+	return atomic_add_unless(&kref->refcount, 1, 0);
+}
+
+#endif /* < KERNEL_VERSION(3, 8, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KREF_H_ */
-- 
2.6.4

