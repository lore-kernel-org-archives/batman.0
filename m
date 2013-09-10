Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:11:56 +0200
Message-Id: <1378847522-13776-6-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/11] batctl: Add include guards to avoid
	redundant declarations or include loops
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 allocate.h   | 4 ++--
 bat-hosts.h  | 4 ++--
 bisect_iv.h  | 5 +++++
 debug.h      | 4 ++++
 functions.h  | 5 ++++-
 ioctl.h      | 4 ++++
 main.h       | 5 +++++
 ping.h       | 5 ++++-
 sys.h        | 4 ++++
 tcpdump.h    | 4 ++++
 traceroute.h | 5 ++++-
 translate.h  | 5 ++++-
 12 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/allocate.h b/allocate.h
index 72a41f7..0f335e2 100644
--- a/allocate.h
+++ b/allocate.h
@@ -20,8 +20,8 @@
  */
 
 
-#ifndef _ALLOCATE_H
-#define _ALLOCATE_H 1
+#ifndef _BATCTL_ALLOCATE_H
+#define _BATCTL_ALLOCATE_H
 
 /* debug allocate wrapper to keep hash.c happy */
 
diff --git a/bat-hosts.h b/bat-hosts.h
index 0439a46..74a4ce5 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -21,8 +21,8 @@
 
 
 
-#ifndef _BAT_HOSTS_H
-#define _BAT_HOSTS_H 1
+#ifndef _BATCTL_BAT_HOSTS_H
+#define _BATCTL_BAT_HOSTS_H
 
 #include <netinet/ether.h>
 
diff --git a/bisect_iv.h b/bisect_iv.h
index b2e14f6..c4e6df2 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _BATCTL_BISECT_IV_H
+#define _BATCTL_BISECT_IV_H
+
 #include "list-batman.h"
 
 #define NAME_LEN 18
@@ -95,3 +98,5 @@ struct seqno_trace {
 	char print;
 	struct seqno_trace_neigh seqno_trace_neigh;
 };
+
+#endif
diff --git a/debug.h b/debug.h
index 532c2fe..8d9de08 100644
--- a/debug.h
+++ b/debug.h
@@ -19,6 +19,8 @@
  *
  */
 
+#ifndef _BATCTL_DEBUG_H
+#define _BATCTL_DEBUG_H
 
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
@@ -48,3 +50,5 @@ extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv);
 int log_print(char *mesh_iface, int argc, char **argv);
 int print_vis_info(char *mesh_iface);
+
+#endif
diff --git a/functions.h b/functions.h
index f9c8191..6720a1b 100644
--- a/functions.h
+++ b/functions.h
@@ -19,7 +19,8 @@
  *
  */
 
-
+#ifndef _BATCTL_FUNCTIONS_H
+#define _BATCTL_FUNCTIONS_H
 
 #include <netinet/if_ether.h>
 
@@ -55,3 +56,5 @@ enum {
 	COMPAT_FILTER = 0x80,
 	SKIP_HEADER = 0x100,
 };
+
+#endif
diff --git a/ioctl.h b/ioctl.h
index 3bc20d7..5d62f72 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -19,5 +19,9 @@
  *
  */
 
+#ifndef _BATCTL_IOCTL_H
+#define _BATCTL_IOCTL_H
 
 int ioctl_statistics_get(char *mesh_iface);
+
+#endif
diff --git a/main.h b/main.h
index ad13c2a..350f88b 100644
--- a/main.h
+++ b/main.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _BATCTL_MAIN_H
+#define _BATCTL_MAIN_H
+
 #ifndef SOURCE_VERSION
 #define SOURCE_VERSION "2013.3.0"
 #endif
@@ -45,3 +48,5 @@
 #define BIT(nr)                 (1UL << (nr)) /* linux kernel compat */
 
 extern char module_ver_path[];
+
+#endif
diff --git a/ping.h b/ping.h
index abe7da4..7c91d5d 100644
--- a/ping.h
+++ b/ping.h
@@ -19,6 +19,9 @@
  *
  */
 
-
+#ifndef _BATCTL_PING_H
+#define _BATCTL_PING_H
 
 int ping(char *mesh_iface, int argc, char **argv);
+
+#endif
diff --git a/sys.h b/sys.h
index a588e0b..dfc167a 100644
--- a/sys.h
+++ b/sys.h
@@ -19,6 +19,8 @@
  *
  */
 
+#ifndef _BATCTL_SYS_H
+#define _BATCTL_SYS_H
 
 #define SYS_BATIF_PATH_FMT "/sys/class/net/%s/mesh/"
 #define SYS_LOG_LEVEL "log_level"
@@ -64,3 +66,5 @@ int interface(char *mesh_iface, int argc, char **argv);
 int handle_loglevel(char *mesh_iface, int argc, char **argv);
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
 int handle_gw_setting(char *mesh_iface, int argc, char **argv);
+
+#endif
diff --git a/tcpdump.h b/tcpdump.h
index 3c6657d..2845576 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -19,6 +19,8 @@
  *
  */
 
+#ifndef _BATCTL_TCPDUMP_H
+#define _BATCTL_TCPDUMP_H
 
 #include <netpacket/packet.h>
 #include <net/ethernet.h>
@@ -105,3 +107,5 @@ struct prism_header {
 #define RADIOTAP_HEADER_LEN sizeof(struct radiotap_header)
 
 int tcpdump(int argc, char **argv);
+
+#endif
diff --git a/traceroute.h b/traceroute.h
index 8aae468..5ec1308 100644
--- a/traceroute.h
+++ b/traceroute.h
@@ -19,6 +19,9 @@
  *
  */
 
-
+#ifndef _BATCTL_TRACEROUTE_H
+#define _BATCTL_TRACEROUTE_H
 
 int traceroute(char *mesh_iface, int argc, char **argv);
+
+#endif
diff --git a/translate.h b/translate.h
index 1220a20..320ad0e 100644
--- a/translate.h
+++ b/translate.h
@@ -19,6 +19,9 @@
  *
  */
 
-
+#ifndef _BATCTL_TRANSLATE_H
+#define _BATCTL_TRANSLATE_H
 
 int translate(char *mesh_iface, int argc, char **argv);
+
+#endif
-- 
1.8.4.rc3

