Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun,  1 Jul 2012 13:36:39 +0200
Message-Id: <1341142599-17704-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: more detailed error messages when
	file can't be opened
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
 functions.c |   75 +++++++++++++++++++++++++++++------------------------------
 sys.c       |   11 ++++++++
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/functions.c b/functions.c
index d08c7a0..c78e408 100644
--- a/functions.c
+++ b/functions.c
@@ -36,15 +36,18 @@
 #include "functions.h"
 #include "bat-hosts.h"
 #include "sys.h"
+#include "debug.h"
 
 static struct timeval start_time;
 static char *host_name;
 char *line_ptr = NULL;
 
-const char *sysfs_compile_out_param[] = {
+const char *fs_compile_out_param[] = {
 	SYS_LOG,
 	SYS_LOG_LEVEL,
 	batctl_settings[BATCTL_SETTINGS_BLA].sysfs_name,
+	batctl_debug_tables[BATCTL_TABLE_BLA_CLAIMS].debugfs_name,
+	batctl_debug_tables[BATCTL_TABLE_BLA_BACKBONES].debugfs_name,
 	NULL,
 };
 
@@ -114,23 +117,42 @@ int file_exists(const char *fpath)
 	return stat(fpath, &st) == 0;
 }
 
-static int check_sys_dir(char *dir)
+static void file_open_problem_dbg(char *dir, char *fname, char *full_path)
 {
+	const char **ptr;
 	struct stat st;
 
-	if (stat("/sys/", &st) != 0) {
-		printf("Error - the folder '/sys/' was not found on the system\n");
-		printf("Please make sure that the sys filesystem is properly mounted\n");
-		return EXIT_FAILURE;
+	if (strstr(dir, "/sys/")) {
+		if (stat("/sys/", &st) != 0) {
+			printf("Error - the folder '/sys/' was not found on the system\n");
+			printf("Please make sure that the sys filesystem is properly mounted\n");
+			return;
+		}
+	}
+
+	if (!file_exists(module_ver_path)) {
+		printf("Error - batman-adv module has not been loaded\n");
+		return;
+	}
+
+	if (!file_exists(dir)) {
+		printf("Error - mesh has not been enabled yet\n");
+		printf("Activate your mesh by adding interfaces to batman-adv\n");
+		return;
 	}
 
-	if (stat(dir, &st) == 0)
-		return EXIT_SUCCESS;
+	for (ptr = fs_compile_out_param; *ptr; ptr++) {
+		if (strcmp(*ptr, fname) != 0)
+			continue;
+
+		break;
+	}
 
-	printf("Error - the folder '%s' was not found within the sys filesystem\n", dir);
-	printf("Please make sure that the batman-adv kernel module is loaded and\n");
-	printf("that you have activated your mesh by adding interfaces to batman-adv\n");
-	return EXIT_FAILURE;
+	printf("Error - can't open file '%s': %s\n", full_path, strerror(errno));
+	if (*ptr) {
+		printf("The option you called seems not to be compiled into your batman-adv kernel module.\n");
+		printf("Consult the README if you wish to learn more about compiling options into batman-adv.\n");
+	}
 }
 
 int read_file(char *dir, char *fname, int read_opt,
@@ -140,7 +162,6 @@ int read_file(char *dir, char *fname, int read_opt,
 	struct bat_host *bat_host;
 	int res = EXIT_FAILURE;
 	float last_seen;
-	const char **ptr;
 	char full_path[500], *buff_ptr, *space_ptr, extra_char;
 	size_t len = 0;
 	FILE *fp = NULL;
@@ -148,11 +169,6 @@ int read_file(char *dir, char *fname, int read_opt,
 	if (read_opt & USE_BAT_HOSTS)
 		bat_hosts_init(read_opt);
 
-	if (strstr(dir, "/sys/")) {
-		if (check_sys_dir(dir) != EXIT_SUCCESS)
-			goto out;
-	}
-
 	strncpy(full_path, dir, strlen(dir));
 	full_path[strlen(dir)] = '\0';
 	strncat(full_path, fname, sizeof(full_path) - strlen(full_path));
@@ -161,20 +177,8 @@ open:
 	fp = fopen(full_path, "r");
 
 	if (!fp) {
-		if (!(read_opt & SILENCE_ERRORS)) {
-			for (ptr = sysfs_compile_out_param; *ptr; ptr++) {
-				if (strcmp(*ptr, fname) != 0)
-					continue;
-
-				break;
-			}
-
-			printf("Error - can't open file '%s': %s\n", full_path, strerror(errno));
-			if (*ptr) {
-				printf("The option you called seems not to be compiled into your batman-adv kernel module.\n");
-				printf("Consult the README if you wish to learn more about compiling options into batman-adv.\n");
-			}
-		}
+		if (!(read_opt & SILENCE_ERRORS))
+			file_open_problem_dbg(dir, fname, full_path);
 
 		goto out;
 	}
@@ -285,11 +289,6 @@ int write_file(char *dir, char *fname, char *arg1, char *arg2)
 	char full_path[500];
 	ssize_t write_len;
 
-	if (strstr(dir, "/sys/")) {
-		if (check_sys_dir(dir) != EXIT_SUCCESS)
-			goto out;
-	}
-
 	strncpy(full_path, dir, strlen(dir));
 	full_path[strlen(dir)] = '\0';
 	strncat(full_path, fname, sizeof(full_path) - strlen(full_path));
@@ -297,7 +296,7 @@ int write_file(char *dir, char *fname, char *arg1, char *arg2)
 	fd = open(full_path, O_WRONLY);
 
 	if (fd < 0) {
-		printf("Error - can't open file '%s': %s\n", full_path, strerror(errno));
+		file_open_problem_dbg(dir, fname, full_path);
 		goto out;
 	}
 
diff --git a/sys.c b/sys.c
index 5b728a8..9787875 100644
--- a/sys.c
+++ b/sys.c
@@ -109,6 +109,11 @@ static int print_interfaces(char *mesh_iface)
 	char *path_buff;
 	int res;
 
+	if (!file_exists(module_ver_path)) {
+		printf("Error - batman-adv module has not been loaded\n");
+		goto err;
+	}
+
 	path_buff = malloc(PATH_BUFF_LEN);
 	if (!path_buff) {
 		printf("Error - could not allocate path buffer: out of memory ?\n");
@@ -191,6 +196,12 @@ int interface(char *mesh_iface, int argc, char **argv)
 		goto err;
 	}
 
+	if (argc == 2) {
+		printf("Error - missing interface name(s) after '%s'\n", argv[1]);
+		interface_usage();
+		goto err;
+	}
+
 	path_buff = malloc(PATH_BUFF_LEN);
 	if (!path_buff) {
 		printf("Error - could not allocate path buffer: out of memory ?\n");
-- 
1.7.9.1

