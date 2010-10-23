Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 24 Oct 2010 01:15:46 +0200
Message-Id: <1287875746-7644-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Convert kbuild version check to
	preprocessor check
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

Makefile.kbuild includes a relative unreadable check for a version
number to decide if we should compile bat_printk.c to get out own print
implementations. This can easily be replaced using a simpler
preprocessor check as we know them from compat.h

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/Makefile.kbuild |    6 +++++-
 batman-adv/bat_printk.c    |    6 ++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/batman-adv/Makefile.kbuild b/batman-adv/Makefile.kbuild
index 14e3daa..40ca316 100644
--- a/batman-adv/Makefile.kbuild
+++ b/batman-adv/Makefile.kbuild
@@ -32,4 +32,8 @@ EXTRA_CFLAGS += -DREVISION_VERSION=\"$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
-batman-adv-y := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o unicast.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
+batman-adv-y := aggregation.o bat_debugfs.o bat_sysfs.o bitarray.o \
+				gateway_client.o gateway_common.o hard-interface.o hash.o \
+				icmp_socket.o main.o originator.o ring_buffer.o routing.o \
+				send.o soft-interface.o translation-table.o unicast.o vis.o
+batman-adv-y += bat_printk.o
diff --git a/batman-adv/bat_printk.c b/batman-adv/bat_printk.c
index 4fa3e18..6bbeb8b 100644
--- a/batman-adv/bat_printk.c
+++ b/batman-adv/bat_printk.c
@@ -1,3 +1,7 @@
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
+
 /*
  *  linux/lib/vsprintf.c
  *
@@ -935,3 +939,5 @@ int bat_snprintf(char *buf, size_t size, const char *fmt, ...)
 
 	return i;
 }
+
+#endif /* < KERNEL_VERSION(2, 6, 29) */
-- 
1.7.1

