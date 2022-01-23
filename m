Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: compat: Fix linux/build_bug.h include for Linux
 4.9.297
Date: Sun, 23 Jan 2022 13:39:41 +0100
Message-Id: <20220123123941.132618-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Linux 4.9.297 doesn't provide BUILD_BUG_ON anymore in linux/bug.h also
identified itself with the version number 4.9.255 when decoding the
LINUX_VERSION_CODE. So we have to try to guess now if we need to include
linux/build_bug.h based on whether BUILD_BUG_ON is defined or not after
including linux/bug.h.

If not doing this, the build will fail with errors like:

  net/batman-adv/bat_algo.c:146:1: error: undefined identifier 'BUILD_BUG_ON_ZERO'
  net/batman-adv/bat_algo.c:146:1: error: undefined identifier 'BUILD_BUG_ON_ZERO'
  net/batman-adv/bat_algo.c:146:1: error: undefined identifier 'BUILD_BUG_ON_ZERO'
  net/batman-adv/bat_algo.c:146:1: error: undefined identifier 'BUILD_BUG_ON_ZERO'
  net/batman-adv/bat_algo.c:146:1: error: undefined identifier 'BUILD_BUG_ON_ZERO'
  net/batman-adv/bat_algo.c:146:1: error: undefined identifier 'BUILD_BUG_ON_ZERO'
  In file included from ./arch/x86/include/asm/cpufeatures.h:5,
                   from ./arch/x86/include/asm/cmpxchg.h:5,
                   from ./arch/x86/include/asm/atomic.h:7,
                   from ./include/linux/atomic.h:4,
                   from net/batman-adv/main.h:207,
                   from net/batman-adv/bat_algo.c:7:
  ./arch/x86/include/asm/qspinlock.h: In function ‘virt_spin_lock’:
  ./arch/x86/include/asm/required-features.h:104:29: error: implicit declaration of function ‘BUILD_BUG_ON_ZERO’ [-Werror=implicit-function-declaration]

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/build_bug.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/compat-include/linux/build_bug.h b/compat-include/linux/build_bug.h
index 0eecc688..1002431d 100644
--- a/compat-include/linux/build_bug.h
+++ b/compat-include/linux/build_bug.h
@@ -15,6 +15,17 @@
 #include_next <linux/build_bug.h>
 #else
 #include <linux/bug.h>
+
+/* Linux 4.9.297 doesn't provide BUILD_BUG_ON anymore in linux/bug.h
+ * also identified itself with the version number 4.9.255 when decoding the
+ * LINUX_VERSION_CODE. So we have to try to guess now if we need to include
+ * linux/build_bug.h based on whether BUILD_BUG_ON is defined  or not after
+ * including linux/bug.h
+ */
+#ifndef BUILD_BUG_ON
+#include_next <linux/build_bug.h>
+#endif
+
 #endif
 
 #endif /* _NET_BATMAN_ADV_COMPAT_LINUX_BUILD_BUG_H_ */
-- 
2.30.2

