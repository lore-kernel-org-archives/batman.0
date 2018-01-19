Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 Jan 2018 09:34:45 +0100
Message-Id: <20180119083445.12832-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix DECLARE_EWMA compat
 with newer kernels
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

Newer kernels removed the ACCESS_ONCE macro and are now using the more
specialized forms READ_ONCE and WRITE_ONCE. The DECLARE_EWMA compat code
used ACCESS_ONCE and fails to build against kernels which include the
commit b899a850431e ("compiler.h: Remove ACCESS_ONCE()").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/average.h  |  8 +++++---
 compat-include/linux/compiler.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)
 create mode 100644 compat-include/linux/compiler.h

diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
index a1e3c254..ce847d5d 100644
--- a/compat-include/linux/average.h
+++ b/compat-include/linux/average.h
@@ -25,6 +25,8 @@
 #include_next <linux/average.h>
 
 #include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/log2.h>
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 3, 0)
 #undef DECLARE_EWMA
@@ -77,7 +79,7 @@
 	static inline void ewma_##name##_add(struct ewma_##name *e,	\
 					     unsigned long val)		\
 	{								\
-		unsigned long internal = ACCESS_ONCE(e->internal);	\
+		unsigned long internal = READ_ONCE(e->internal);	\
 		unsigned long weight_rcp = ilog2(_weight_rcp);		\
 		unsigned long precision = _precision;			\
 									\
@@ -86,10 +88,10 @@
 		BUILD_BUG_ON((_precision) > 30);			\
 		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
 									\
-		ACCESS_ONCE(e->internal) = internal ?			\
+		WRITE_ONCE(e->internal, internal ?			\
 			(((internal << weight_rcp) - internal) +	\
 				(val << precision)) >> weight_rcp :	\
-			(val << precision);				\
+			(val << precision));				\
 	}
 
 #endif /* _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H */
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
new file mode 100644
index 00000000..62b6a2f9
--- /dev/null
+++ b/compat-include/linux/compiler.h
@@ -0,0 +1,37 @@
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_
+
+#include <linux/version.h>
+#include_next <linux/compiler.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 19, 0)
+
+#define READ_ONCE(x) ACCESS_ONCE(x)
+
+#define WRITE_ONCE(x, val) ({ \
+	ACCESS_ONCE(x) = (val); \
+})
+
+#endif /* < KERNEL_VERSION(3, 19, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_COMPILER_H_ */
-- 
2.11.0

