Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  9 Feb 2012 18:02:14 +0800
Message-Id: <1328781734-2792-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1328781734-2792-1-git-send-email-lindner_marek@yahoo.de>
References: <1328781734-2792-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: warn about options that are not
	compiled into batman-adv
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 debug.c     |    4 ----
 functions.c |   24 +++++++++++++++++++++++-
 sys.c       |    3 ---
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/debug.c b/debug.c
index 155f499..928f81d 100644
--- a/debug.c
+++ b/debug.c
@@ -185,9 +185,5 @@ int log_print(char *mesh_iface, int argc, char **argv)
 
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
 	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0);
-
-	if ((res != EXIT_SUCCESS) && (errno == ENOENT))
-		printf("To read the debug log you need to compile the module with debugging enabled (see the README)\n");
-
 	return res;
 }
diff --git a/functions.c b/functions.c
index 69a1385..8ce2419 100644
--- a/functions.c
+++ b/functions.c
@@ -35,11 +35,19 @@
 #include "main.h"
 #include "functions.h"
 #include "bat-hosts.h"
+#include "sys.h"
 
 static struct timeval start_time;
 static char *host_name;
 char *line_ptr = NULL;
 
+const char *sysfs_compile_out_param[] = {
+	SYS_LOG,
+	SYS_LOG_LEVEL,
+	SYS_BRIDGE_LOOP_AVOIDANCE,
+	NULL,
+};
+
 void start_timer(void)
 {
 	gettimeofday(&start_time, NULL);
@@ -125,6 +133,7 @@ int read_file(char *dir, char *fname, int read_opt,
 	struct bat_host *bat_host;
 	int res = EXIT_FAILURE;
 	float last_seen;
+	const char **ptr;
 	char full_path[500], *buff_ptr, *space_ptr, extra_char;
 	size_t len = 0;
 	FILE *fp = NULL;
@@ -145,8 +154,21 @@ open:
 	fp = fopen(full_path, "r");
 
 	if (!fp) {
-		if (!(read_opt & SILENCE_ERRORS))
+		if (!(read_opt & SILENCE_ERRORS)) {
+			for (ptr = sysfs_compile_out_param; *ptr; ptr++) {
+				if (strcmp(*ptr, fname) != 0)
+					continue;
+
+				break;
+			}
+
 			printf("Error - can't open file '%s': %s\n", full_path, strerror(errno));
+			if (*ptr) {
+				printf("The option you called seems not to be compiled into your batman-adv kernel module.\n");
+				printf("Consult the README if you wish to learn more about compiling options into batman-adv.\n");
+			}
+		}
+
 		goto out;
 	}
 
diff --git a/sys.c b/sys.c
index 6cf4714..fbc8762 100644
--- a/sys.c
+++ b/sys.c
@@ -255,9 +255,6 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to bridge loop avoidance", "bla");
 
 out:
-	if (errno == ENOENT)
-		printf("To increase the log level you need to compile the module with debugging enabled (see the README)\n");
-
 	free(path_buff);
 	return res;
 }
-- 
1.7.5.4

