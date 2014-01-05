Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun,  5 Jan 2014 23:25:36 +0100
Message-Id: <1388960736-3873-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
References: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv3 next 3/3] batctl: add sys framework for
	VLAN support
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
Cc: Marco Dalla Torre <marco.dallato@gmail.com>, Antonio Quartulli <antonio@meshcoding.com>

From: Marco Dalla Torre <marco.dallato@gmail.com>

Allow the batctl tool to take advantage of changes from commit
e4ff5c153dab054a6cd1c4132f87bc5e77127456 "add sys framework for VLAN"
recently added to batman-adv, so that users can execute commands in
a per VLAN fashion.

If no directory entry corresponding to the user-selected device is found
at the standard location for non VLAN interfaces
(/sys/class/net/${device}/mesh/), 'batctl' now looks into directory:
     /sys/class/net/${base_device}/mesh/vlan${vid}
Information on VLAN devices (base device, vid) necessary to construct the
directory path is acquired by querying the netlink kernel module.
Where:
    -${base_device}: the batman device on top of which the VLAN is sitting
    -${device}: the device interface for the VLAN,
    -${vid}: the identifier assigned to the VLAN.

If the user-selected command is not supported by the VLAN, an appropriate
error is shown.

Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 main.c       |  2 +-
 man/batctl.8 |  4 ++--
 sys.c        | 15 +++++++++++++--
 sys.h        | 22 ++++++++++++----------
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/main.c b/main.c
index aab2e11..a37c0b7 100644
--- a/main.c
+++ b/main.c
@@ -46,7 +46,7 @@ static void print_usage(void)
 
 	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
 	fprintf(stderr, "options:\n");
-	fprintf(stderr, " \t-m mesh interface (default 'bat0')\n");
+	fprintf(stderr, " \t-m mesh interface or VLAN created on top of a mesh interface (default 'bat0')\n");
 	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
 	fprintf(stderr, " \t-v print version\n");
 	fprintf(stderr, "\n");
diff --git a/man/batctl.8 b/man/batctl.8
index fafe735..b3b12bd 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -42,7 +42,7 @@ behaviour or using the B.A.T.M.A.N. advanced protocol.
 .SH OPTIONS
 .TP
 .I \fBoptions:
-\-m     specify mesh interface (default 'bat0')
+\-m     specify mesh interface or VLAN created on top of a mesh interface (default 'bat0')
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
index 2a508e2..5cebf52 100644
--- a/sys.c
+++ b/sys.c
@@ -372,8 +372,8 @@ static void settings_usage(int setting)
 
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 {
-	int optchar, res = EXIT_FAILURE;
-	char *path_buff;
+	int vid, optchar, res = EXIT_FAILURE;
+	char *path_buff, *base_dev = NULL;
 	const char **ptr;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
@@ -387,10 +387,20 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 		}
 	}
 
+	/* prepare the classic path */
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
+	/* if the specified interface is a VLAN then change the path to point
+	 * to the proper "vlan%{vid}" subfolder in the sysfs tree.
+	 */
+	vid = vlan_get_link(mesh_iface, &base_dev);
+	if (vid >= 0) {
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
+		path_buff[PATH_BUFF_LEN - 1] = '\0';
+	}
+
 	if (argc == 1) {
 		res = read_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
 				NO_FLAGS, 0, 0, 0);
@@ -425,6 +435,7 @@ write_file:
 
 out:
 	free(path_buff);
+	free(base_dev);
 	return res;
 }
 
diff --git a/sys.h b/sys.h
index 8934978..2cbbcfb 100644
--- a/sys.h
+++ b/sys.h
@@ -24,16 +24,18 @@
 
 #include "main.h"
 
-#define SYS_BATIF_PATH_FMT "/sys/class/net/%s/mesh/"
-#define SYS_LOG_LEVEL "log_level"
-#define SYS_LOG "log"
-#define SYS_GW_MODE "gw_mode"
-#define SYS_GW_SEL "gw_sel_class"
-#define SYS_GW_BW "gw_bandwidth"
-#define SYS_IFACE_PATH "/sys/class/net"
-#define SYS_IFACE_DIR SYS_IFACE_PATH"/%s/"
-#define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
-#define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
+#define SYS_BATIF_PATH_FMT	"/sys/class/net/%s/mesh/"
+#define SYS_LOG_LEVEL		"log_level"
+#define SYS_LOG			"log"
+#define SYS_GW_MODE		"gw_mode"
+#define SYS_GW_SEL		"gw_sel_class"
+#define SYS_GW_BW		"gw_bandwidth"
+#define SYS_IFACE_PATH		"/sys/class/net"
+#define SYS_IFACE_DIR		SYS_IFACE_PATH"/%s/"
+#define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
+#define SYS_IFACE_STATUS_FMT	SYS_IFACE_PATH"/%s/batman_adv/iface_status"
+#define SYS_VLAN_PATH		SYS_IFACE_PATH"/%s/mesh/vlan%d/"
+#define VLAN_ID_MAX_LEN		4
 
 enum batctl_settings_list {
 	BATCTL_SETTINGS_ORIG_INTERVAL,
-- 
1.8.5.2

