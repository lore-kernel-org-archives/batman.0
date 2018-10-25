Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:05 +0200
Message-Id: <20181025162245.19389-3-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 02/42] batctl: Use common code
 organization for statistics
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

Most commands have a separate file which is called like command itself.
They also tend to share the same function signature to make it easier to
use. Do the same for the ethtool statistics to make it easier to find.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                | 2 +-
 main.c                  | 4 ++--
 ioctl.c => statistics.c | 6 ++++--
 ioctl.h => statistics.h | 6 +++---
 4 files changed, 10 insertions(+), 8 deletions(-)
 rename ioctl.c => statistics.c (95%)
 rename ioctl.h => statistics.h (88%)

diff --git a/Makefile b/Makefile
index 4b417d5..6f620be 100755
--- a/Makefile
+++ b/Makefile
@@ -34,10 +34,10 @@ OBJ += genl.o
 OBJ += hash.o
 OBJ += icmp_helper.o
 OBJ += interface.o
-OBJ += ioctl.o
 OBJ += main.o
 OBJ += netlink.o
 OBJ += ping.o
+OBJ += statistics.o
 OBJ += sys.o
 OBJ += tcpdump.o
 OBJ += tp_meter.o
diff --git a/main.c b/main.c
index d5504e0..e904a1f 100644
--- a/main.c
+++ b/main.c
@@ -37,7 +37,7 @@
 #include "tcpdump.h"
 #include "tp_meter.h"
 #include "bisect_iv.h"
-#include "ioctl.h"
+#include "statistics.h"
 #include "functions.h"
 
 char mesh_dfl_iface[] = "bat0";
@@ -187,7 +187,7 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "statistics") == 0) || (strcmp(argv[1], "s") == 0)) {
 
-		ret = ioctl_statistics_get(mesh_iface);
+		ret = statistics(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "translate") == 0) || (strcmp(argv[1], "t") == 0)) {
 
diff --git a/ioctl.c b/statistics.c
similarity index 95%
rename from ioctl.c
rename to statistics.c
index 6f9a056..8a889ca 100644
--- a/ioctl.c
+++ b/statistics.c
@@ -34,7 +34,8 @@
 #include <linux/ethtool.h>
 #include <stdint.h>
 
-#include "ioctl.h"
+#include "main.h"
+#include "statistics.h"
 
 void check_root_or_die(const char *cmd);
 
@@ -102,7 +103,8 @@ static int statistics_custom_get(int fd, struct ifreq *ifr)
 	return ret;
 }
 
-int ioctl_statistics_get(char *mesh_iface)
+int statistics(char *mesh_iface, int argc __maybe_unused,
+	       char **argv __maybe_unused)
 {
 	struct ifreq ifr;
 	int fd = -1, ret = EXIT_FAILURE;
diff --git a/ioctl.h b/statistics.h
similarity index 88%
rename from ioctl.h
rename to statistics.h
index 1b216c0..3737a48 100644
--- a/ioctl.h
+++ b/statistics.h
@@ -20,9 +20,9 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
-#ifndef _BATCTL_IOCTL_H
-#define _BATCTL_IOCTL_H
+#ifndef _BATCTL_STATISTICS_H
+#define _BATCTL_STATISTICS_H
 
-int ioctl_statistics_get(char *mesh_iface);
+int statistics(char *mesh_iface, int argc, char **argv);
 
 #endif
-- 
2.11.0

