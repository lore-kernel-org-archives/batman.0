Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 24 Oct 2010 03:14:21 +0200
Message-Id: <1287882863-11314-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201010240313.35215.lindner_marek@yahoo.de>
References: <201010240313.35215.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] batctl: support new gateway sysfs API
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
 batctl/main.c       |    3 +-
 batctl/man/batctl.8 |    4 +-
 batctl/sys.c        |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 batctl/sys.h        |    9 ++++
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/batctl/main.c b/batctl/main.c
index 9c1195b..850959a 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -166,8 +166,7 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "gw_mode") == 0) || (strcmp(argv[1], "gw") == 0)) {
 
-		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
-					 SYS_GW_MODE, gw_mode_usage, sysfs_param_server);
+		ret = handle_gw_setting(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "gateways") == 0) || (strcmp(argv[1], "gwl") == 0)) {
 
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 13822ef..ba2d32d 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -70,8 +70,8 @@ If no parameter is given the current log level settings are displayed otherwise
 .IP "\fBlog\fP|\fBl\fP            [\fB\-n\fP]\fP"
 batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
 .br
-.IP "\fBgw_mode|gw\fP       [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBgw_class\fP]\fP"
-If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The second (optional) argument specifies the gateway class. Its function depends on whether the node is a server or a client. If the node is a server this parameter is used to inform other nodes in the network about this node's internet connection bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the batman-adv module will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload rate and the module will assume an upload of download / 5.
+.IP "\fBgw_mode|gw\fP       [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBsel_class|bandwidth\fP]\fP"
+If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The second (optional) argument specifies the selection class (if 'client' was the first argument) or the gateway bandwidth (if 'server' was the first argument). If the node is a server this parameter is used to inform other nodes in the network about this node's internet connection bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the batman-adv module will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload rate and the module will assume an upload of download / 5.
 .RS 17
 default: 2000 \-> gateway class 20
 .RE
diff --git a/batctl/sys.c b/batctl/sys.c
index 79d9612..bb976c0 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -241,7 +241,7 @@ void bonding_usage(void)
 
 void gw_mode_usage(void)
 {
-	printf("Usage: batctl [options] gw_mode [mode]\n");
+	printf("Usage: batctl [options] gw_mode [mode] [sel_class|bandwidth]\n");
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 }
@@ -323,3 +323,118 @@ out:
 	free(path_buff);
 	return res;
 }
+
+int handle_gw_setting(char *mesh_iface, int argc, char **argv)
+{
+	int optchar, res = EXIT_FAILURE;
+	char *path_buff, gw_mode;
+	const char **ptr;
+
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			gw_mode_usage();
+			return EXIT_SUCCESS;
+		default:
+			gw_mode_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	path_buff = malloc(PATH_BUFF_LEN);
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+
+	if (argc == 1) {
+		res = read_file(path_buff, SYS_GW_MODE, SINGLE_READ | USE_READ_BUFF, 0, 0);
+
+		if (res != EXIT_SUCCESS)
+			goto out;
+
+		if (line_ptr[strlen(line_ptr) - 1] == '\n')
+			line_ptr[strlen(line_ptr) - 1] = '\0';
+
+		if (strcmp(line_ptr, "client") == 0)
+			gw_mode = GW_MODE_CLIENT;
+		else if (strcmp(line_ptr, "server") == 0)
+			gw_mode = GW_MODE_SERVER;
+		else
+			gw_mode = GW_MODE_OFF;
+
+		free(line_ptr);
+		line_ptr = NULL;
+
+		switch (gw_mode) {
+		case GW_MODE_CLIENT:
+			res = read_file(path_buff, SYS_GW_SEL, SINGLE_READ | USE_READ_BUFF, 0, 0);
+			break;
+		case GW_MODE_SERVER:
+			res = read_file(path_buff, SYS_GW_BW, SINGLE_READ | USE_READ_BUFF, 0, 0);
+			break;
+		default:
+			printf("off\n");
+			goto out;
+		}
+
+		if (res != EXIT_SUCCESS)
+			goto out;
+
+		if (line_ptr[strlen(line_ptr) - 1] == '\n')
+			line_ptr[strlen(line_ptr) - 1] = '\0';
+
+		switch (gw_mode) {
+		case GW_MODE_CLIENT:
+			printf("client (selection class: %s)\n", line_ptr);
+			break;
+		case GW_MODE_SERVER:
+			printf("server (announced bw: %s)\n", line_ptr);
+			break;
+		default:
+			goto out;
+		}
+
+		free(line_ptr);
+		line_ptr = NULL;
+		goto out;
+	}
+
+	if (strcmp(argv[1], "client") == 0)
+		gw_mode = GW_MODE_CLIENT;
+	else if (strcmp(argv[1], "server") == 0)
+		gw_mode = GW_MODE_SERVER;
+	else if (strcmp(argv[1], "off") == 0)
+		gw_mode = GW_MODE_OFF;
+	else
+		goto opt_err;
+
+	res = write_file(path_buff, SYS_GW_MODE, argv[1], NULL);
+	if (res != EXIT_SUCCESS)
+		goto out;
+
+	if (argc == 2)
+		goto out;
+
+	switch (gw_mode) {
+	case GW_MODE_CLIENT:
+		res = write_file(path_buff, SYS_GW_SEL, argv[2], NULL);
+		break;
+	case GW_MODE_SERVER:
+		res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
+		break;
+	default:
+		goto out;
+	}
+
+opt_err:
+	printf("Error - the supplied argument is invalid: %s\n", argv[1]);
+	printf("The following values are allowed:\n");
+
+	ptr = sysfs_param_server;
+	while (*ptr) {
+		printf(" * %s\n", *ptr);
+		ptr++;
+	}
+
+out:
+	free(path_buff);
+	return res;
+}
diff --git a/batctl/sys.h b/batctl/sys.h
index 71362f1..066b8bd 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -26,6 +26,8 @@
 #define SYS_AGGR "aggregated_ogms"
 #define SYS_BONDING "bonding"
 #define SYS_GW_MODE "gw_mode"
+#define SYS_GW_SEL "gw_sel_class"
+#define SYS_GW_BW "gw_bandwidth"
 #define SYS_VIS_MODE "vis_mode"
 #define SYS_ORIG_INTERVAL "orig_interval"
 #define SYS_IFACE_PATH "/sys/class/net"
@@ -33,6 +35,12 @@
 #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 #define SYS_FRAG "fragmentation"
 
+enum gw_modes {
+	GW_MODE_OFF,
+	GW_MODE_CLIENT,
+	GW_MODE_SERVER,
+};
+
 extern const char *sysfs_param_enable[];
 extern const char *sysfs_param_server[];
 
@@ -47,3 +55,4 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv);
 int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 		       char *file_path, void setting_usage(void),
 		       const char *sysfs_param[]);
+int handle_gw_setting(char *mesh_iface, int argc, char **argv);
-- 
1.7.1

