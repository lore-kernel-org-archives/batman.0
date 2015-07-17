Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 17 Jul 2015 22:50:03 +0800
Message-Id: <1437144603-29020-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: list supported and configured
	routing algorithms
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

With this patch, batctl is able to:
 * list supported routing algorithms
 * list batX interfaces with their configured routing algorithm
 * view and alter the selected routing algorithm

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
v2: man page entry added

 debug.c      | 14 ++++++++++
 debug.h      |  2 ++
 main.c       |  5 ++++
 man/batctl.8 |  8 +++++-
 sys.c        | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sys.h        |  3 ++
 6 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/debug.c b/debug.c
index a050345..c3959db 100644
--- a/debug.c
+++ b/debug.c
@@ -219,6 +219,20 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 			 batctl_debug_tables[debug_table].header_lines);
 }
 
+int print_routing_algos(void) {
+	char full_path[MAX_PATH+1];
+	char *debugfs_mnt;
+
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
+		return -1;
+	}
+
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT, "", full_path, sizeof(full_path));
+	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
+}
+
 int print_vis_info(char *mesh_iface)
 {
 	char full_path[MAX_PATH+1];
diff --git a/debug.h b/debug.h
index 2bc0ff9..8287b54 100644
--- a/debug.h
+++ b/debug.h
@@ -28,6 +28,7 @@
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
 #define DEBUG_LOG "log"
+#define DEBUG_ROUTING_ALGOS "routing_algos"
 
 enum batctl_debug_tables {
 	BATCTL_TABLE_ORIGINATORS,
@@ -52,6 +53,7 @@ extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv);
 int log_print(char *mesh_iface, int argc, char **argv);
+int print_routing_algos(void);
 int print_vis_info(char *mesh_iface);
 
 #endif
diff --git a/main.c b/main.c
index d127cdc..96aea4d 100644
--- a/main.c
+++ b/main.c
@@ -70,6 +70,7 @@ static void print_usage(void)
 	fprintf(stderr, " \tloglevel|ll                [level]           \tdisplay or modify the log level\n");
 	fprintf(stderr, " \tlog|l                                        \tread the log produced by the kernel module\n");
 	fprintf(stderr, " \tgw_mode|gw                 [mode]            \tdisplay or modify the gateway mode\n");
+	fprintf(stderr, " \trouting_algo|ra            [mode]            \tdisplay or modify the routing algorithm\n");
 	fprintf(stderr, "\n");
 
 	fprintf(stderr, "debug tables:                                   \tdisplay the corresponding debug table\n");
@@ -150,6 +151,10 @@ int main(int argc, char **argv)
 
 		ret = bisect_iv(argc - 1, argv + 1);
 #endif
+	} else if ((strcmp(argv[1], "routing_algo") == 0) || (strcmp(argv[1], "ra") == 0)) {
+
+		ret = handle_ra_setting(argc - 1, argv + 1);
+
 	} else if (check_mesh_iface(mesh_iface) < 0) {
 		fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
 		exit(EXIT_FAILURE);
diff --git a/man/batctl.8 b/man/batctl.8
index bc190c0..d1acd44 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -2,7 +2,7 @@
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
 .\" other parameters are allowed: see man(7), man(1)
-.TH "BATCTL" "8" "Jan 06, 2013" "Linux" "B.A.T.M.A.N. Advanced Control Tool"
+.TH "BATCTL" "8" "July 17, 2015" "Linux" "B.A.T.M.A.N. Advanced Control Tool"
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
@@ -155,6 +155,12 @@ least XX TQ better than the currently selected gateway (XX has to be a number be
 .RE
 .RE
 .br
+.IP "\fBrouting_algo\fP|\fBra\fP [\fBalgorithm\fP]\fP"
+If no parameter is given the current routing algorithm configuration as well as
+supported routing algorithms are displayed.
+Otherwise the parameter is used to select the routing algorithm for the following
+batX interface to be created.
+.br
 .IP "\fBisolation_mark\fP|\fBmark\fP"
 If no parameter is given the current isolation mark value is displayed.
 Otherwise the parameter is used to set or unset the isolation mark used by the
diff --git a/sys.c b/sys.c
index 81b8faf..838fcd8 100644
--- a/sys.c
+++ b/sys.c
@@ -30,6 +30,7 @@
 #include "main.h"
 #include "sys.h"
 #include "functions.h"
+#include "debug.h"
 
 #define PATH_BUFF_LEN 200
 
@@ -563,6 +564,96 @@ out:
 	return res;
 }
 
+static void ra_mode_usage(void)
+{
+	fprintf(stderr, "Usage: batctl [options] routing_algo [algorithm]\n");
+	fprintf(stderr, "options:\n");
+	fprintf(stderr, " \t -h print this help\n");
+}
+
+int handle_ra_setting(int argc, char **argv)
+{
+	DIR *iface_base_dir;
+	struct dirent *iface_dir;
+	int optchar;
+	char *path_buff;
+	int res = EXIT_FAILURE;
+	int first_iface = 1;
+
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			ra_mode_usage();
+			return EXIT_SUCCESS;
+		default:
+			ra_mode_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (argc == 2) {
+		res = write_file(SYS_SELECTED_RA_PATH, "", argv[1], NULL);
+		goto out;
+	}
+
+	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		goto out;
+	}
+
+	iface_base_dir = opendir(SYS_IFACE_PATH);
+	if (!iface_base_dir) {
+		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
+			SYS_IFACE_PATH, strerror(errno));
+		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
+		goto free_buff;
+	}
+
+	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name);
+		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+		if (res != EXIT_SUCCESS)
+			continue;
+
+		if (line_ptr[strlen(line_ptr) - 1] == '\n')
+			line_ptr[strlen(line_ptr) - 1] = '\0';
+
+		if (first_iface) {
+			first_iface = 0;
+			printf("Active routing protocol configuration:\n");
+		}
+
+		printf(" * %s: %s\n", iface_dir->d_name, line_ptr);
+
+		free(line_ptr);
+		line_ptr = NULL;
+	}
+
+	closedir(iface_base_dir);
+	free(path_buff);
+
+	if (!first_iface)
+		printf("\n");
+
+	res = read_file("", SYS_SELECTED_RA_PATH, USE_READ_BUFF, 0, 0, 0);
+	if (res != EXIT_SUCCESS)
+		return EXIT_FAILURE;
+
+	printf("Selected routing algorithm (used when next batX interface is created):\n");
+	printf(" => %s\n", line_ptr);
+	free(line_ptr);
+	line_ptr = NULL;
+
+	print_routing_algos();
+	return EXIT_SUCCESS;
+
+free_buff:
+	free(path_buff);
+out:
+	return res;
+}
+
 int check_mesh_iface(char *mesh_iface)
 {
 	char *base_dev = NULL;
diff --git a/sys.h b/sys.h
index 9addd90..13c164e 100644
--- a/sys.h
+++ b/sys.h
@@ -35,6 +35,8 @@
 #define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT	SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 #define SYS_VLAN_PATH		SYS_IFACE_PATH"/%s/mesh/vlan%d/"
+#define SYS_ROUTING_ALGO_FMT	SYS_IFACE_PATH"/%s/mesh/routing_algo"
+#define SYS_SELECTED_RA_PATH	"/sys/module/batman_adv/parameters/routing_algo"
 #define VLAN_ID_MAX_LEN		4
 
 enum batctl_settings_list {
@@ -72,6 +74,7 @@ int interface(char *mesh_iface, int argc, char **argv);
 int handle_loglevel(char *mesh_iface, int argc, char **argv);
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
 int handle_gw_setting(char *mesh_iface, int argc, char **argv);
+int handle_ra_setting(int argc, char **argv);
 int check_mesh_iface(char *mesh_iface);
 int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
-- 
2.1.4

