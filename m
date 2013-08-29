Return-Path: <marco.dallato@gmail.com>
From: Marco Dalla Torre <marco.dallato@gmail.com>
Date: Thu, 29 Aug 2013 20:43:34 +0200
Message-Id: <1377801814-28182-1-git-send-email-marco.dallato@gmail.com>
In-Reply-To: <201308292018.28480.lindner_marek@yahoo.de>
References: <201308292018.28480.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv3] batctl: add sys framework for VLAN support
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


*sorry for messing up format in previous message, re-sending*

Allow the batctl tool to take advantage of changes from commit
e4ff5c153dab054a6cd1c4132f87bc5e77127456 ("add sys framework for VLAN")
recently added to batman-adv, so that users can execute commands in
a per VLAN fashion.

If no directory entry corresponding to the user-selected device is found
at the standard location for non VLAN interfaces
(/sys/class/net/${base_device}), 'batctl' now looks into directory:
     /sys/devices/virtual/net/${base_device}/mesh/vlan${vid}
Where:
    -${base_device}: the batman device on top of which the VLAN is sitting
    -${device}: the device interface for the VLAN,
    -${vid}: the identifier assigned to the VLAN.

Information on VLAN devices (base device, vid) necessary to construct the
directory path is acquired by parsing /proc/net/vlan/${device}.

If the user-selected command is not supported by the VLAN, an appropriate
error is shown.

Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
---
 functions.c  |  3 +++
 main.c       |  2 +-
 man/batctl.8 |  2 +-
 sys.c        | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)

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
index d04385b..7fd324d 100644
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
diff --git a/sys.c b/sys.c
index b1d7ea8..00d2ed1 100644
--- a/sys.c
+++ b/sys.c
@@ -371,6 +371,37 @@ static void settings_usage(int setting)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
+int get_basedev_vid(char *mesh_iface, char **base_dev, unsigned short *vid)
+{
+	char *vdev;
+	char line[100];
+	const char path[] = "/proc/net/vlan/";
+	int size = sizeof(path) + sizeof(mesh_iface);
+	FILE *fp = NULL;
+
+	char *fpath = malloc(size);
+	strcpy(fpath, path);
+	/* prepare path file path: /proc/net/vlan/$mesh_iface*/
+	strcat(fpath, mesh_iface);
+
+	fp = fopen(fpath, "r");
+	if (fp == NULL)
+		return 1;
+
+	if (fscanf(fp, "%ms %*s %hu %*s %*d %*s %*d", &vdev, vid) == 0)
+		return 0;
+
+	while (fgets(line, sizeof(line), fp) != NULL) {
+		if (sscanf(line, "Device: %ms", base_dev) == 1)
+			break;
+	}
+	/* handle base device not found case */
+	if (*base_dev == NULL)
+		return 0;
+
+	return 1;
+}
+
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
@@ -392,6 +423,26 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
+	if (access(path_buff, F_OK) != 0) {
+		if (errno == ENOENT) {
+			/* path does not exist, no lan interface: check vlan */
+			unsigned short vid = 0;
+			char *base_dev = NULL;
+			if (get_basedev_vid(mesh_iface, &base_dev, &vid) == 1) {
+				free(path_buff);
+				char sys_vlan_path[] =
+					"/sys/devices/virtual/net/%s/mesh/vlan%d/";
+				int size = sizeof(sys_vlan_path) + sizeof(base_dev);
+				path_buff = malloc(size);
+				sprintf(path_buff, sys_vlan_path, base_dev, vid);
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
-- 
1.8.3.2

