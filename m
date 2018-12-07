Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 22:46:28 +0100
Message-Id: <20181207214629.30307-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Remove check of compiled_out
 files
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

Many files in the sysfs and debugfs of batman-adv can be compiled out. The
debugfs support of batman-adv can currently be disabled completely and
something similar may happen in the future for sysfs. Printing the
information that a file cannot be opened because the feature was disabled
should therefore be printed for read/writes from/to all files when the
caller didn't ask to disable error messages.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |  2 +-
 distributed_arp_table.c |  2 +-
 functions.c             | 36 +++++-------------------------------
 loglevel.c              |  2 ++
 multicast_mode.c        |  2 +-
 network_coding.c        |  2 +-
 sys.h                   |  6 ------
 7 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 0db49f2..04b41e0 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -24,7 +24,7 @@
 #include "sys.h"
 
 static struct settings_data batctl_settings_bridge_loop_avoidance = {
-	.sysfs_name = SYS_BLA,
+	.sysfs_name = "bridge_loop_avoidance",
 	.params = sysfs_param_enable,
 };
 
diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index ba6e5b7..c3595fc 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
@@ -24,7 +24,7 @@
 #include "sys.h"
 
 static struct settings_data batctl_settings_distributed_arp_table = {
-	.sysfs_name = SYS_DAT,
+	.sysfs_name = "distributed_arp_table",
 	.params = sysfs_param_enable,
 };
 
diff --git a/functions.c b/functions.c
index bdede8b..9a130e1 100644
--- a/functions.c
+++ b/functions.c
@@ -66,21 +66,6 @@ static struct timespec start_time;
 static char *host_name;
 char *line_ptr = NULL;
 
-const char *fs_compile_out_param[] = {
-	SYS_LOG,
-	SYS_LOG_LEVEL,
-	SYS_BLA,
-	SYS_DAT,
-	SYS_NETWORK_CODING,
-	SYS_MULTICAST_MODE,
-	DEBUG_DAT_CACHE,
-	DEBUG_BACKBONETABLE,
-	DEBUG_DAT_CACHE,
-	DEBUG_NC_NODES,
-	DEBUG_MCAST_FLAGS,
-	NULL,
-};
-
 void start_timer(void)
 {
 	clock_gettime(CLOCK_MONOTONIC, &start_time);
@@ -147,10 +132,8 @@ int file_exists(const char *fpath)
 	return stat(fpath, &st) == 0;
 }
 
-static void file_open_problem_dbg(const char *dir, const char *fname,
-				  const char *full_path)
+static void file_open_problem_dbg(const char *dir, const char *full_path)
 {
-	const char **ptr;
 	struct stat st;
 
 	if (strstr(dir, "/sys/")) {
@@ -172,18 +155,9 @@ static void file_open_problem_dbg(const char *dir, const char *fname,
 		return;
 	}
 
-	for (ptr = fs_compile_out_param; *ptr; ptr++) {
-		if (strcmp(*ptr, fname) != 0)
-			continue;
-
-		break;
-	}
-
 	fprintf(stderr, "Error - can't open file '%s': %s\n", full_path, strerror(errno));
-	if (*ptr) {
-		fprintf(stderr, "The option you called seems not to be compiled into your batman-adv kernel module.\n");
-		fprintf(stderr, "Consult the README if you wish to learn more about compiling options into batman-adv.\n");
-	}
+	fprintf(stderr, "The option you called seems not to be compiled into your batman-adv kernel module.\n");
+	fprintf(stderr, "Consult the README if you wish to learn more about compiling options into batman-adv.\n");
 }
 
 static int str_is_mcast_addr(char *addr)
@@ -230,7 +204,7 @@ int read_file(const char *dir, const char *fname, int read_opt,
 
 	if (!fp) {
 		if (!(read_opt & SILENCE_ERRORS))
-			file_open_problem_dbg(dir, fname, full_path);
+			file_open_problem_dbg(dir, full_path);
 
 		goto out;
 	}
@@ -366,7 +340,7 @@ int write_file(const char *dir, const char *fname, const char *arg1,
 	fd = open(full_path, O_WRONLY);
 
 	if (fd < 0) {
-		file_open_problem_dbg(dir, fname, full_path);
+		file_open_problem_dbg(dir, full_path);
 		goto out;
 	}
 
diff --git a/loglevel.c b/loglevel.c
index fed70c8..b5bbd0d 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -29,6 +29,8 @@
 #include "main.h"
 #include "sys.h"
 
+#define SYS_LOG_LEVEL		"log_level"
+
 static void log_level_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] loglevel [parameters] [level[ level[ level]]...]\n");
diff --git a/multicast_mode.c b/multicast_mode.c
index 8542928..b65732d 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -24,7 +24,7 @@
 #include "sys.h"
 
 static struct settings_data batctl_settings_multicast_mode = {
-	.sysfs_name = SYS_MULTICAST_MODE,
+	.sysfs_name = "multicast_mode",
 	.params = sysfs_param_enable,
 };
 
diff --git a/network_coding.c b/network_coding.c
index a4c4296..076f4cf 100644
--- a/network_coding.c
+++ b/network_coding.c
@@ -24,7 +24,7 @@
 #include "sys.h"
 
 static struct settings_data batctl_settings_network_coding = {
-	.sysfs_name = SYS_NETWORK_CODING,
+	.sysfs_name = "network_coding",
 	.params = sysfs_param_enable,
 };
 
diff --git a/sys.h b/sys.h
index 20e1934..b493219 100644
--- a/sys.h
+++ b/sys.h
@@ -26,12 +26,6 @@
 #include "main.h"
 
 #define SYS_BATIF_PATH_FMT	"/sys/class/net/%s/mesh/"
-#define SYS_LOG_LEVEL		"log_level"
-#define SYS_LOG			"log"
-#define SYS_BLA			"bridge_loop_avoidance"
-#define SYS_DAT			"distributed_arp_table"
-#define SYS_NETWORK_CODING	"network_coding"
-#define SYS_MULTICAST_MODE	"multicast_mode"
 #define SYS_IFACE_PATH		"/sys/class/net"
 #define SYS_IFACE_DIR		SYS_IFACE_PATH"/%s/"
 #define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
-- 
2.19.2

