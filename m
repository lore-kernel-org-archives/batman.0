Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  4 May 2011 10:06:30 +0200
Message-Id: <1304496393-16405-3-git-send-email-sven@narfation.org>
In-Reply-To: <1304496393-16405-1-git-send-email-sven@narfation.org>
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Add compatibility code for
	kfree_rcu
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.c |   37 +++++++++++++++++++++++++++++++++++++
 compat.h |   28 ++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/compat.c b/compat.c
index f4561c3..881420f 100644
--- a/compat.c
+++ b/compat.c
@@ -1,4 +1,7 @@
 #include <linux/version.h>
+#include <linux/sysfs.h>
+#include <linux/netdevice.h>
+#include "compat.h"
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
 
@@ -959,3 +962,37 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...)
 }
 
 #endif /* < KERNEL_VERSION(2, 6, 29) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 1234)
+
+#define BAT_KFREE_RCU0(n, x) \
+	static void bat_kfree_rcu_##n(struct rcu_head *head) \
+	{\
+		unsigned long offset = (unsigned long)(x);\
+		kfree((void *)head - offset);\
+	}
+
+#define BAT_KFREE_RCU1(n,x) BAT_KFREE_RCU0(n##z,x) BAT_KFREE_RCU0(n##o,x+1UL)
+#define BAT_KFREE_RCU2(n,x) BAT_KFREE_RCU1(n##z,x) BAT_KFREE_RCU1(n##o,x+2UL)
+#define BAT_KFREE_RCU3(n,x) BAT_KFREE_RCU2(n##z,x) BAT_KFREE_RCU2(n##o,x+4UL)
+#define BAT_KFREE_RCU4(n,x) BAT_KFREE_RCU3(n##z,x) BAT_KFREE_RCU3(n##o,x+8UL)
+#define BAT_KFREE_RCU5(n,x) BAT_KFREE_RCU4(n##z,x) BAT_KFREE_RCU4(n##o,x+16UL)
+#define BAT_KFREE_RCU6(n,x) BAT_KFREE_RCU5(n##z,x) BAT_KFREE_RCU5(n##o,x+32UL)
+#define BAT_KFREE_RCU7(n,x) BAT_KFREE_RCU6(n##z,x) BAT_KFREE_RCU6(n##o,x+64UL)
+#define BAT_KFREE_RCU8(n,x) BAT_KFREE_RCU7(n##z,x) BAT_KFREE_RCU7(n##o,x+128UL)
+
+BAT_KFREE_RCU8(s, 0UL)
+
+#define LKRCU0(n) &bat_kfree_rcu_##n
+#define LKRCU1(n) LKRCU0(n##z), LKRCU0(n##o)
+#define LKRCU2(n) LKRCU1(n##z), LKRCU1(n##o)
+#define LKRCU3(n) LKRCU2(n##z), LKRCU2(n##o)
+#define LKRCU4(n) LKRCU3(n##z), LKRCU3(n##o)
+#define LKRCU5(n) LKRCU4(n##z), LKRCU4(n##o)
+#define LKRCU6(n) LKRCU5(n##z), LKRCU5(n##o)
+#define LKRCU7(n) LKRCU6(n##z), LKRCU6(n##o)
+#define LKRCU8(n) LKRCU7(n##z), LKRCU7(n##o)
+
+bat_rcu_callback bat_kfree_rcu_offset[_BAT_MAX_KFREE_RCU_OFFSET] = {LKRCU8(s)};
+
+#endif /* < KERNEL_VERSION(2, 6, 1234) */
diff --git a/compat.h b/compat.h
index 0c5ad82..59bd752 100644
--- a/compat.h
+++ b/compat.h
@@ -288,4 +288,32 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 1234)
+
+#define _BAT_MAX_KFREE_RCU_OFFSET 256
+typedef void (*bat_rcu_callback)(struct rcu_head *);
+extern bat_rcu_callback bat_kfree_rcu_offset[_BAT_MAX_KFREE_RCU_OFFSET];
+
+static __always_inline bool __is_kfree_rcu_offset(unsigned long offset)
+{
+	return offset < _BAT_MAX_KFREE_RCU_OFFSET;
+}
+
+static __always_inline
+void __kfree_rcu(struct rcu_head *head, unsigned long offset)
+{
+	BUILD_BUG_ON(!__builtin_constant_p(offset));
+	BUILD_BUG_ON(!__is_kfree_rcu_offset(offset));
+
+	call_rcu(head, (bat_rcu_callback)bat_kfree_rcu_offset[offset]);
+}
+
+extern void kfree(const void *);
+
+#define kfree_rcu(ptr, rcu_head)					\
+	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
+
+
+#endif /* < KERNEL_VERSION(2, 6, 1234) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.4.4

