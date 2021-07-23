Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] batman-adv: compat: Add support for linux/kstrtox.h
Date: Fri, 23 Jul 2021 19:23:16 +0200
Message-Id: <20210723172317.323199-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The commit 4c52729377ea ("kernel.h: split out kstrtox() and simple_strtox()
to a separate header") moved the kstrtou64 function to a new header called
linux/kstrtox.h.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/kstrtox.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 compat-include/linux/kstrtox.h

diff --git a/compat-include/linux/kstrtox.h b/compat-include/linux/kstrtox.h
new file mode 100644
index 00000000..cd152e4b
--- /dev/null
+++ b/compat-include/linux/kstrtox.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_KSTRTOX_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_KSTRTOX_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_IS_GEQ(5, 14, 0)
+#include_next <linux/kstrtox.h>
+#else
+#include <linux/kernel.h>
+#endif
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_KSTRTOX_H_ */
-- 
2.30.2

