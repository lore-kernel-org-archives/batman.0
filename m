Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jul 2011 10:42:51 +0200
Message-Id: <1309855371-9389-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Replace version info instead of
	appending them
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

The version number of modules build outside of the tree can get revision
numbers added. This is useful to give hints about the revision of a
distribution package and the used patchset. The prepended source number or
branch name doesn't add any additional information which would help to identify
problems and can therefore be omitted.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile         |    2 +-
 Makefile.kbuild  |    2 +-
 gateway_client.c |    5 ++---
 main.c           |    9 ++-------
 main.h           |   11 +++--------
 originator.c     |    5 ++---
 6 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index 84828ea..5762721 100644
--- a/Makefile
+++ b/Makefile
@@ -30,7 +30,7 @@ endif
 export KERNELPATH
 
 REVISION= $(shell	if [ -d .git ]; then \
-				echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); \
+				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 
 NUM_CPUS = $(shell nproc 2> /dev/null || echo 1)
diff --git a/Makefile.kbuild b/Makefile.kbuild
index d469668..4dda02b 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -28,7 +28,7 @@ endif
 # EXTRA_CFLAGS += -DCONFIG_BATMAN_ADV_DEBUG
 
 ifneq ($(REVISION),)
-EXTRA_CFLAGS += -DREVISION_VERSION=\"$(REVISION)\"
+EXTRA_CFLAGS += -DSOURCE_VERSION=\"$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
diff --git a/gateway_client.c b/gateway_client.c
index 8b25b52..056180e 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -487,10 +487,9 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "      %-12s (%s/%i) %17s [%10s]: gw_class ... "
-		   "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%pM (%s)]\n",
+		   "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
 		   "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
-		   "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
-		   primary_if->net_dev->name,
+		   "outgoingIF", SOURCE_VERSION, primary_if->net_dev->name,
 		   primary_if->net_dev->dev_addr, net_dev->name);
 
 	rcu_read_lock();
diff --git a/main.c b/main.c
index e367e69..b0f9068 100644
--- a/main.c
+++ b/main.c
@@ -58,9 +58,8 @@ static int __init batman_init(void)
 
 	register_netdevice_notifier(&hard_if_notifier);
 
-	pr_info("B.A.T.M.A.N. advanced %s%s (compatibility version %i) "
-		"loaded\n", SOURCE_VERSION, REVISION_VERSION_STR,
-		COMPAT_VERSION);
+	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) "
+		"loaded\n", SOURCE_VERSION, COMPAT_VERSION);
 
 	return 0;
 }
@@ -184,8 +183,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_SUPPORTED_DEVICE(DRIVER_DEVICE);
-#ifdef REVISION_VERSION
-MODULE_VERSION(SOURCE_VERSION "-" REVISION_VERSION);
-#else
 MODULE_VERSION(SOURCE_VERSION);
-#endif
diff --git a/main.h b/main.h
index 175c9c9..16da679 100644
--- a/main.h
+++ b/main.h
@@ -27,8 +27,9 @@
 #define DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define DRIVER_DEVICE "batman-adv"
 
-#define SOURCE_VERSION "next"
-
+#ifndef SOURCE_VERSION
+#define SOURCE_VERSION "2011.2.0"
+#endif
 
 /* B.A.T.M.A.N. parameters */
 
@@ -146,12 +147,6 @@ enum dbg_level {
 
 #include "types.h"
 
-#ifndef REVISION_VERSION
-#define REVISION_VERSION_STR ""
-#else
-#define REVISION_VERSION_STR " "REVISION_VERSION
-#endif
-
 extern struct list_head hardif_list;
 
 extern unsigned char broadcast_addr[];
diff --git a/originator.c b/originator.c
index 338b3c5..4cc94d4 100644
--- a/originator.c
+++ b/originator.c
@@ -430,9 +430,8 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
-	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%pM (%s)]\n",
-		   SOURCE_VERSION, REVISION_VERSION_STR,
-		   primary_if->net_dev->name,
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
+		   SOURCE_VERSION, primary_if->net_dev->name,
 		   primary_if->net_dev->dev_addr, net_dev->name);
 	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
-- 
1.7.5.4

