Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:11 +0200
Message-Id: <20181025162245.19389-9-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 08/42] batctl: Rename tp_meter to
 throughputmeter
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

The command itself is called throughputmeter but the file and function is
called tp_meter. Use "throughputmeter" for both to make it easier to
identify the correct source file.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                        | 2 +-
 main.c                          | 4 ++--
 tp_meter.c => throughputmeter.c | 4 ++--
 tp_meter.h => throughputmeter.h | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)
 rename tp_meter.c => throughputmeter.c (99%)
 rename tp_meter.h => throughputmeter.h (83%)

diff --git a/Makefile b/Makefile
index 9ff4fe4..b4777b7 100755
--- a/Makefile
+++ b/Makefile
@@ -44,7 +44,7 @@ OBJ += routing_algo.o
 OBJ += statistics.o
 OBJ += sys.o
 OBJ += tcpdump.o
-OBJ += tp_meter.o
+OBJ += throughputmeter.o
 OBJ += traceroute.o
 OBJ += translate.o
 OBJ_BISECT = bisect_iv.o
diff --git a/main.c b/main.c
index 4abee13..34f5a62 100644
--- a/main.c
+++ b/main.c
@@ -35,7 +35,7 @@
 #include "translate.h"
 #include "traceroute.h"
 #include "tcpdump.h"
-#include "tp_meter.h"
+#include "throughputmeter.h"
 #include "bisect_iv.h"
 #include "statistics.h"
 #include "loglevel.h"
@@ -165,7 +165,7 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "throughputmeter") == 0) || (strcmp(argv[1], "tp") == 0)) {
 
-		ret = tp_meter (mesh_iface, argc -1, argv + 1);
+		ret = throughputmeter(mesh_iface, argc -1, argv + 1);
 
 	} else if ((strcmp(argv[1], "traceroute") == 0) || (strcmp(argv[1], "tr") == 0)) {
 
diff --git a/tp_meter.c b/throughputmeter.c
similarity index 99%
rename from tp_meter.c
rename to throughputmeter.c
index c790485..bb53d56 100644
--- a/tp_meter.c
+++ b/throughputmeter.c
@@ -21,7 +21,7 @@
  */
 
 #include "main.h"
-#include "tp_meter.h"
+#include "throughputmeter.h"
 
 #include <netinet/ether.h>
 #include <netinet/in.h>
@@ -389,7 +389,7 @@ static void tp_meter_usage(void)
 	fprintf(stderr, "\t -n don't convert addresses to bat-host names\n");
 }
 
-int tp_meter(char *mesh_iface, int argc, char **argv)
+int throughputmeter(char *mesh_iface, int argc, char **argv)
 {
 	struct bat_host *bat_host;
 	uint64_t throughput;
diff --git a/tp_meter.h b/throughputmeter.h
similarity index 83%
rename from tp_meter.h
rename to throughputmeter.h
index 72006ba..2c04c12 100644
--- a/tp_meter.h
+++ b/throughputmeter.h
@@ -20,9 +20,9 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
-#ifndef _BATCTL_TP_METER_H
-#define _BATCTL_TP_METER_H
+#ifndef _BATCTL_THROUGHPUTMETER_H
+#define _BATCTL_THROUGHPUTMETER_H
 
-int tp_meter(char *mesh_iface, int argc, char **argv);
+int throughputmeter(char *mesh_iface, int argc, char **argv);
 
-#endif /* _BATCTL_TP_METER_H */
+#endif /* _BATCTL_THROUGHPUTMETER_H */
-- 
2.11.0

