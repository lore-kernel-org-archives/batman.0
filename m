Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 11 Mar 2018 10:20:29 +0100
Message-Id: <20180311092029.15236-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Only provide
 (READ|WRITE)_ONCE when undefined
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
Cc: Sven Eckelmann <sven@narfation.org>, Ralf Jung <post+openmesh@ralfj.de>

The Debian Jessie 3.16.x kernels (3.16.36-1 and later) modified the the
kernel sources to already provide the READ_ONCE and WRITE_ONCE kernel
macros. The batman-adv compat helper defines will conflict on such kernels
and thus prevent the compilation against these downstream kernels.

Reported-by: Ralf Jung <post@ralfj.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Ralf Jung <post+openmesh@ralfj.de>

See https://www.open-mesh.org/issues/350
---
 compat-include/linux/compiler.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
index 62b6a2f9..45cd49fa 100644
--- a/compat-include/linux/compiler.h
+++ b/compat-include/linux/compiler.h
@@ -26,11 +26,15 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 19, 0)
 
+#ifndef READ_ONCE
 #define READ_ONCE(x) ACCESS_ONCE(x)
+#endif
 
+#ifndef WRITE_ONCE
 #define WRITE_ONCE(x, val) ({ \
 	ACCESS_ONCE(x) = (val); \
 })
+#endif
 
 #endif /* < KERNEL_VERSION(3, 19, 0) */
 
-- 
2.16.1

