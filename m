Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 19:50:33 +0100
Message-Id: <1457895034-13823-5-git-send-email-sven@narfation.org>
In-Reply-To: <3465881.llCNFeNLl4@sven-edge>
References: <3465881.llCNFeNLl4@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v3 5/6] batman-adv: Add compatibility header
	for linux/ns_common.h
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

linux/ns_common.h was added with 3.19. All older kernels should not include
this header to avoid compile errors.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/ns_common.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 compat-include/linux/ns_common.h

diff --git a/compat-include/linux/ns_common.h b/compat-include/linux/ns_common.h
new file mode 100644
index 0000000..a60a77f
--- /dev/null
+++ b/compat-include/linux/ns_common.h
@@ -0,0 +1,29 @@
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NS_COMMON_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_NS_COMMON_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
+#include_next <linux/ns_common.h>
+#endif /* >= KERNEL_VERSION(3, 19, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NS_COMMON_H_ */
-- 
2.7.0

