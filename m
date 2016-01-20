Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Wed, 20 Jan 2016 10:09:41 +0100
Message-Id: <1453280981-3324-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add compat code for
	BUILD_BUG_ON_NOT_POWER_OF_2
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
Cc: Sven Eckelmann <sven@open-mesh.com>

Fixes: 2c2fe0ba9ea5 ("batman-adv: ELP - creating neighbor structures")
Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 compat-include/linux/bug.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/compat-include/linux/bug.h b/compat-include/linux/bug.h
index 124fd28..0c46158 100644
--- a/compat-include/linux/bug.h
+++ b/compat-include/linux/bug.h
@@ -24,6 +24,19 @@
 #include <linux/version.h>
 #include_next <linux/bug.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
+
+#undef BUILD_BUG_ON_NOT_POWER_OF_2
+#ifdef __CHECKER__
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
+#else
+/* Force a compilation error if a constant expression is not a power of 2 */
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n) \
+	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+#endif
+
+#endif /* < KERNEL_VERSION(2, 6, 33) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
 #undef BUILD_BUG_ON
-- 
2.7.0.rc3

