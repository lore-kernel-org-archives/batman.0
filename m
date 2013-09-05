Return-Path: <marco.dallato@gmail.com>
From: Marco Dalla Torre <marco.dallato@gmail.com>
Date: Thu,  5 Sep 2013 14:16:47 +0200
Message-Id: <1378383407-13460-1-git-send-email-marco.dallato@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCHv6] batctl: add sys framework for VLAN support
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

Allow the batctl tool to take advantage of changes from commit
e4ff5c153dab054a6cd1c4132f87bc5e77127456 "add sys framework for VLAN"
recently added to batman-adv, so that users can execute commands in
a per VLAN fashion.

If no directory entry corresponding to the user-selected device is found
at the standard location for non VLAN interfaces
(/sys/class/net/${device}/mesh/), 'batctl' now looks into directory:
     /sys/devices/virtual/net/${base_device}/mesh/vlan${vid}
Information on VLAN devices (base device, vid) necessary to construct the
directory path is acquired by parsing /proc/net/vlan/${device}.
Where:
    -${base_device}: the batman device on top of which the VLAN is sitting
    -${device}: the device interface for the VLAN,
    -${vid}: the identifier assigned to the VLAN.

If the user-selected command is not supported by the VLAN, an appropriate
error is shown.

Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
---
Notable changes in V6
-fixed error in string length computation
-moved some more variable declarations at the beginning of functions 

Notable changes in V5
-fixed use of sizeof instead of strlen to compute length of string
-use of getline instead of fgets
-avoid using fixed-size buffer in 'get_basedev_vid'
-moved constant string declarations, local to functions 'get_basedev_vid'
 and 'handle_sys_setting', from sys.c to sys.h. Now uses #define like
 other path declarations.
-fixed scanf error condition check
-fixed malloc error condition check
-moved variable declarations at the beginning of functions

 functions.c  |  3 ++
 main.c       |  2 +-
 man/batctl.8 |  4 +--
 sys.c        | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 sys.h        |  3 ++
 5 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/functions.c b/functions.c
index cc05a48..ed010ea 100644
--- a/functions.c
+++ b/functions.c
@@ -135,6 +135,9 @@ static void file_open_problem_dbg(char *dir, char *fname, char *full_path)
 			fprintf(stderr, "Error - the folder '/sys/' was not found on the system\n");
 			fprintf(stderr, "Please make sure that the sys filesystem is properly mounted\n");
 			return;
+		} else if (strstr(dir, "/sys/devices/virtual/")) {
+			fprintf(stderr, "The selected feature '%s' is not supported for vlans\n", fname);
+			return;
 		}
 	}
 
diff --git a/main.c b/main.c
index 24d42fb..bac37ca 100644
--- a/main.c
+++ b/main.c
@@ -49,7 +49,7 @@ void print_usage(void)
 
 	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
 	fprintf(stderr, "options:\n");
-	fprintf(stderr, " \t-m mesh interface (default 'bat0')\n");
+	fprintf(stderr, " \t-m mesh interface or mesh-based VLAN interface (default 'bat0')\n");
 	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
 	fprintf(stderr, " \t-v print version\n");
 	fprintf(stderr, "\n");
diff --git a/man/batctl.8 b/man/batctl.8
index d04385b..b45cccf 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -42,7 +42,7 @@ behaviour or using the B.A.T.M.A.N. advanced protocol.
 .SH OPTIONS
 .TP
 .I \fBoptions:
-\-m     specify mesh interface (default 'bat0')
+\-m     specify mesh interface or a mesh-based VLAN interface (default 'bat0')
 .br
 \-h     print general batctl help
 .br
@@ -61,7 +61,7 @@ originator interval. The interval is in units of milliseconds.
 .br
 .IP "\fBap_isolation\fP|\fBap\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current ap isolation setting is displayed. Otherwise the parameter is used to enable or
-disable ap isolation.
+disable ap isolation. This command can be used in conjunction with "-m" option to target per VLAN configurations.
 .br
 .IP "\fBbridge_loop_avoidance\fP|\fBbl\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current bridge loop avoidance setting is displayed. Otherwise the parameter is used to enable
diff --git a/sys.c b/sys.c
index b1d7ea8..6f23fb2 100644
--- a/sys.c
+++ b/sys.c
@@ -371,11 +371,64 @@ static void settings_usage(int setting)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
+/**
+ * get_basedev_vid - given a valid VLAN interface, identifies the batman device
+ *	on top of which the VLAN is sitting and its VLAN ID
+ * @mesh_iface: name of the VLAN network interface
+ * @base_dev: output argument, pointer to the base device name
+ * @vid: output argument, pointer to the VLAN ID number
+ *
+ * Returns 0 if execution is successful, -1 if an error occurred
+ */
+static int get_basedev_vid(const char *mesh_iface, char **base_dev, unsigned short *vid)
+{
+	char *vdev;
+	char *line_ptr;
+	size_t len;
+	FILE *fp;
+	char *fpath;
+
+	int size = strlen(PROC_VLAN_PATH) + strlen(mesh_iface) + 1;
+	fpath = malloc(size);
+	if (!fpath) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return EXIT_FAILURE;
+	}
+	/* prepare path file path: /proc/net/vlan/$mesh_iface*/
+	snprintf(fpath, size, "%s%s", PROC_VLAN_PATH, mesh_iface);
+
+	fp = fopen(fpath, "r");
+	if (!fp) {
+		fprintf(stderr, "Error - could not open file '%s': %s\n",
+			fpath, strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	if (fscanf(fp, "%ms %*s %hu %*s %*d %*s %*d", &vdev, vid) != 2)
+		return EXIT_FAILURE;
+
+	*base_dev = NULL;
+	while (getline(&line_ptr, &len, fp) != -1) {
+		if (sscanf(line_ptr, "Device: %ms", base_dev) == 1)
+			break;
+	}
+	fclose(fp);
+	free(line_ptr);
+	/* handle base device not found case */
+	if (*base_dev == NULL)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
 	char *path_buff;
 	const char **ptr;
+	unsigned short vid;
+	char *base_dev;
+	ssize_t path_length;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -388,10 +441,40 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 		}
 	}
 
-	path_buff = malloc(PATH_BUFF_LEN);
-	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
-	path_buff[PATH_BUFF_LEN - 1] = '\0';
+	path_length = strlen(SYS_BATIF_PATH_FMT) + strlen(mesh_iface) + 1;
+	path_buff = malloc(path_length);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return EXIT_FAILURE;
+	}
+	snprintf(path_buff, path_length, SYS_BATIF_PATH_FMT, mesh_iface);
 
+	if (access(path_buff, F_OK) != 0) {
+		if (errno == ENOENT) {
+			/* path does not exist, no lan interface: check vlan */
+			if (get_basedev_vid(mesh_iface, &base_dev, &vid) == EXIT_SUCCESS) {
+				/* free for previous allocation */
+				free(path_buff);
+				path_length = strlen(SYS_VLAN_PATH)
+					+ strlen(base_dev)
+					+ VLAN_ID_MAX_LEN + 1;
+				path_buff = malloc(path_length);
+				if (!path_buff) {
+					fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+					return EXIT_FAILURE;
+				}
+				snprintf(path_buff, path_length, SYS_VLAN_PATH,
+					base_dev, vid);
+			} else {
+				return EXIT_FAILURE;
+			}
+		} else if (errno == ENOTDIR) {
+			/* not a directory, something wrong here */
+			fprintf(stderr, "Error - expected directory at '%s'\n",
+				path_buff);
+			return EXIT_FAILURE;
+		}
+	}
 	if (argc == 1) {
 		res = read_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
 				NO_FLAGS, 0, 0, 0);
diff --git a/sys.h b/sys.h
index a588e0b..f5df845 100644
--- a/sys.h
+++ b/sys.h
@@ -30,6 +30,9 @@
 #define SYS_IFACE_DIR SYS_IFACE_PATH"/%s/"
 #define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
+#define PROC_VLAN_PATH "/proc/net/vlan/"
+#define SYS_VLAN_PATH "/sys/devices/virtual/net/%s/mesh/vlan%d/"
+#define VLAN_ID_MAX_LEN 4
 
 enum batctl_settings_list {
 	BATCTL_SETTINGS_ORIG_INTERVAL,
-- 
1.8.3.2

