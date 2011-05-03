Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  3 May 2011 22:38:32 +0200
Message-Id: <1304455112-16291-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC/PATCH] batman-adv: Add compatibility code for
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
This is pure speculation and only to show how ugly it is... It is currently
not used in Linus' tree

 ~~~~~~~~~~~~~~~~~~~~ DONT APPLY THIS PATCH ~~~~~~~~~~~~~~~~~~~~

 Makefile.kbuild |    1 +
 compat.c        |   41 +++++++++++++++++++++++++++++++++++++++++
 compat.h        |   28 ++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 compat.c

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 0a35006..be0cbd9 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -50,4 +50,5 @@ batman-adv-y += soft-interface.o
 batman-adv-y += translation-table.o
 batman-adv-y += unicast.o
 batman-adv-y += vis.o
+batman-adv-y += compat.o
 batman-adv-y += bat_printk.o
diff --git a/compat.c b/compat.c
new file mode 100644
index 0000000..0a8075e
--- /dev/null
+++ b/compat.c
@@ -0,0 +1,41 @@
+#include <linux/sysfs.h>
+#include <linux/netdevice.h>
+#include "compat.h"
+
+#define RCU_DEFINITION0(n, x) void bat_kfree_rcu_##n(struct rcu_head *head) \
+	{\
+		unsigned long offset = (unsigned long)(x);\
+		kfree((void *)head - offset);\
+	}
+
+#define RCU_DEFINITION1(n,x) RCU_DEFINITION0(z##n,x) RCU_DEFINITION0(o##n,x+1)
+#define RCU_DEFINITION2(n,x) RCU_DEFINITION1(z##n,x) RCU_DEFINITION1(o##n,x+2)
+#define RCU_DEFINITION3(n,x) RCU_DEFINITION2(z##n,x) RCU_DEFINITION2(o##n,x+4)
+#define RCU_DEFINITION4(n,x) RCU_DEFINITION3(z##n,x) RCU_DEFINITION3(o##n,x+8)
+#define RCU_DEFINITION5(n,x) RCU_DEFINITION4(z##n,x) RCU_DEFINITION4(o##n,x+16)
+#define RCU_DEFINITION6(n,x) RCU_DEFINITION5(z##n,x) RCU_DEFINITION5(o##n,x+32)
+#define RCU_DEFINITION7(n,x) RCU_DEFINITION6(z##n,x) RCU_DEFINITION6(o##n,x+64)
+#define RCU_DEFINITION8(n,x) RCU_DEFINITION7(z##n,x) RCU_DEFINITION7(o##n,x+128)
+#define RCU_DEFINITION9(n,x) RCU_DEFINITION8(z##n,x) RCU_DEFINITION8(o##n,x+256)
+#define RCU_DEFINITION10(n,x) RCU_DEFINITION9(z##n,x) RCU_DEFINITION9(o##n,x+512)
+#define RCU_DEFINITION11(n,x) RCU_DEFINITION10(z##n,x) RCU_DEFINITION10(o##n,x+1024)
+#define RCU_DEFINITION12(n,x) RCU_DEFINITION11(z##n,x) RCU_DEFINITION11(o##n,x+2048)
+
+RCU_DEFINITION12(s, 0)
+
+#define RCU_DECLARATION0(n) &bat_kfree_rcu_##n
+#define RCU_DECLARATION1(n) RCU_DECLARATION0(z##n), RCU_DECLARATION0(o##n)
+#define RCU_DECLARATION2(n) RCU_DECLARATION1(z##n), RCU_DECLARATION1(o##n)
+#define RCU_DECLARATION3(n) RCU_DECLARATION2(z##n), RCU_DECLARATION2(o##n)
+#define RCU_DECLARATION4(n) RCU_DECLARATION3(z##n), RCU_DECLARATION3(o##n)
+#define RCU_DECLARATION5(n) RCU_DECLARATION4(z##n), RCU_DECLARATION4(o##n)
+#define RCU_DECLARATION6(n) RCU_DECLARATION5(z##n), RCU_DECLARATION5(o##n)
+#define RCU_DECLARATION7(n) RCU_DECLARATION6(z##n), RCU_DECLARATION6(o##n)
+#define RCU_DECLARATION8(n) RCU_DECLARATION7(z##n), RCU_DECLARATION7(o##n)
+#define RCU_DECLARATION9(n) RCU_DECLARATION8(z##n), RCU_DECLARATION8(o##n)
+#define RCU_DECLARATION10(n) RCU_DECLARATION9(z##n), RCU_DECLARATION9(o##n)
+#define RCU_DECLARATION11(n) RCU_DECLARATION10(z##n), RCU_DECLARATION10(o##n)
+#define RCU_DECLARATION12(n) RCU_DECLARATION11(z##n), RCU_DECLARATION11(o##n)
+
+bat_rcu_callback bat_kfree_rcu_offset[_BAT_MAX_KFREE_RCU_OFFSET] = {RCU_DECLARATION12(s)};
+
diff --git a/compat.h b/compat.h
index 0c5ad82..a297b0d 100644
--- a/compat.h
+++ b/compat.h
@@ -288,4 +288,32 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 1234)
+
+#define _BAT_MAX_KFREE_RCU_OFFSET 4096
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

