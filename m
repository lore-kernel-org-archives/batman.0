Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2015 15:23:04 +0200
Message-Id: <1434892984-14142-1-git-send-email-sven@narfation.org>
In-Reply-To: <1434890715-14370-1-git-send-email-sven@narfation.org>
References: <1434890715-14370-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 3/3] batman-adv: Add compat code for
	lockdep_assert_held
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
 compat-include/linux/lockdep.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 compat-include/linux/lockdep.h

diff --git a/compat-include/linux/lockdep.h b/compat-include/linux/lockdep.h
new file mode 100644
index 0000000..e646114
--- /dev/null
+++ b/compat-include/linux/lockdep.h
@@ -0,0 +1,33 @@
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_LOCKDEP_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_LOCKDEP_H_
+
+#include <linux/version.h>
+#include_next <linux/lockdep.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 32)
+
+#define lockdep_assert_held(l)	do { (void)(l); } while (0)
+
+#endif /* < KERNEL_VERSION(2, 6, 32) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_LOCKDEP_H_ */
-- 
2.1.4

