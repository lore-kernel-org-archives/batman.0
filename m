Return-Path: <xrb@kalrong.net>
Message-ID: <4F8C0CBD.1000907@kalrong.net>
Date: Mon, 16 Apr 2012 14:12:45 +0200
From: Xabier R B <xrb@kalrong.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030006080609030608000605"
Subject: [B.A.T.M.A.N.] [PATCH] Add options for network coding managment.
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is a multi-part message in MIME format.
--------------030006080609030608000605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Signed-off-by: Xabier Rodriguez <xrb@kalrong.net>
---
 main.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 sys.c  |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 sys.h  |   10 ++++++++++
 3 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/main.c b/main.c
index 86e2078..2a62c03 100644
--- a/main.c
+++ b/main.c
@@ -63,6 +63,8 @@ void print_usage(void) {
 	printf(" \tfragmentation|f            [0|1]             \tdisplay or
modify the fragmentation mode setting\n");
 	printf(" \tap_isolation|ap            [0|1]             \tdisplay or
modify the ap isolation mode setting\n");
 	printf("\n");
+        printf(" \tnetwork_coding|nc          [command]
\tdisplay the network coding commands\n");
+	printf("\n");
 	printf(" \tping|p                     <destination>     \tping another
batman adv host via layer 2\n");
 	printf(" \ttraceroute|tr              <destination>     \ttraceroute
another batman adv host via layer 2\n");
 	printf(" \ttcpdump|td                 <interface>       \ttcpdump
layer 2 traffic on the given interface\n");
@@ -73,6 +75,16 @@ void print_usage(void) {
 	printf(" \t-v print version\n");
 }
 +void print_usage_nc(void) {
+
+	printf("Usage: batctl nc [options] commands \n");
+	printf("commands:\n");
+	printf("\tstatus|st		[0|1]			\tdisplay or modify network coding
status\n");
+	printf("\tmin_tq|mtq		[1-254]			\tdisplay or modify minimum tq value\n");
+	printf("\thold|hd			[>10]			\tdisplay or modify hold value\n");
+	printf("\tpurge|pg		[>10]			\tdisplay or modify purge value\n");
+}
+
 int main(int argc, char **argv)
 {
 	int ret = EXIT_FAILURE;
@@ -217,7 +229,41 @@ int main(int argc, char **argv)
  		ret = bisect(argc - 1, argv + 1);
 +	} else if ((strcmp(argv[1], "network_coding") == 0) ||
(strcmp(argv[1], "nc") == 0)) {
+
+		if (argc>2) {
+
+			if ((strcmp(argv[2], "status") == 0) || (strcmp(argv[2], "st") == 0)){
+
+				ret = handle_sys_setting(mesh_iface, argc - 2, argv + 2,
+					SYS_NETWORK_CODING, network_coding_usage, sysfs_param_enable);
+
+			} else if ((strcmp(argv[2], "min_tq") == 0) || (strcmp(argv[2],
"mtq") == 0)) {
+
+				ret = handle_sys_setting(mesh_iface, argc - 2, argv + 2,
+					SYS_NC_MIN_TQ, nc_min_tq_usage, sysfs_param_range);
+
+			} else if ((strcmp(argv[2], "hold") == 0) || (strcmp(argv[2], "hd")
== 0)) {
+
+				ret = handle_sys_setting(mesh_iface, argc - 2, argv + 2,
+					SYS_NC_HOLD, nc_hold_usage, sysfs_param_one_range);
+
+			} else if ((strcmp(argv[2], "purge") == 0) || (strcmp(argv[2], "pg")
== 0)) {
+
+				ret = handle_sys_setting(mesh_iface, argc - 2, argv + 2,
+					SYS_NC_PURGE, nc_purge_usage, sysfs_param_one_range);
+
+			}
+
+		} else {
+
+			printf("Error - no command specified\n");
+			print_usage_nc();
+
+		     }
+
 	} else {
+
 		printf("Error - no command specified\n");
 		print_usage();
 	}
diff --git a/sys.c b/sys.c
index d3bf7fa..e8077d9 100644
--- a/sys.c
+++ b/sys.c
@@ -49,6 +49,17 @@ const char *sysfs_param_server[] = {
 	NULL,
 };
 +const char *sysfs_param_range[] = {
+	"1",
+	"254",
+	NULL,
+};
+
+const char *sysfs_param_one_range[] = {
+	"10",
+	NULL,
+};
+
 static void interface_usage(void)
 {
 	printf("Usage: batctl interface [options] [add|del iface(s)] \n");
@@ -320,6 +331,34 @@ void ap_isolation_usage(void)
 	printf(" \t -h print this help\n");
 }
 +void network_coding_usage(void)
+{
+	printf("Usage: batctl [options] nc status [0|1]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
+void nc_min_tq_usage(void)
+{
+	printf("Usage: batctl [options] nc min_tq [1-254]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
+void nc_hold_usage(void)
+{
+	printf("Usage: batctl [options] nc hold [>10]\n");
+	printf("options:\n");
+	printf("\t -h print this help\n");
+}
+
+void nc_purge_usage(void)
+{
+	printf("Usage: batctl [options] nc purge [>10]\n");
+	printf("options\n");
+	printf("\t -h print this help\n");
+}
+
 int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 		       char *file_path, void setting_usage(void),
 		       const char *sysfs_param[])
@@ -351,6 +390,19 @@ int handle_sys_setting(char *mesh_iface, int argc,
char **argv,
 		goto write_file;
  	ptr = sysfs_param;
+
+	if (ptr[1]==NULL){
+
+		if (atoi(ptr[0]) <= atoi(argv[1]))
+			goto write_file;
+
+	}else{
+
+		if (atoi(ptr[0]) <= atoi(argv[1]) && atoi(ptr[1]) >= atoi(argv[1]))
+			goto write_file;
+
+	}
+
 	while (*ptr) {
 		if (strcmp(*ptr, argv[1]) == 0)
 			goto write_file;
diff --git a/sys.h b/sys.h
index 46a1159..317309f 100644
--- a/sys.h
+++ b/sys.h
@@ -36,6 +36,10 @@
 #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 #define SYS_FRAG "fragmentation"
 #define SYS_AP_ISOLA "ap_isolation"
+#define SYS_NETWORK_CODING "network_coding"
+#define SYS_NC_MIN_TQ "nc_min_tq"
+#define SYS_NC_HOLD "nc_hold"
+#define SYS_NC_PURGE "nc_purge"
  enum gw_modes {
 	GW_MODE_OFF,
@@ -45,6 +49,8 @@ enum gw_modes {
  extern const char *sysfs_param_enable[];
 extern const char *sysfs_param_server[];
+extern const char *sysfs_param_range[];
+extern const char *sysfs_param_one_range[];
  void aggregation_usage(void);
 void bonding_usage(void);
@@ -54,6 +60,10 @@ void ap_isolation_usage(void);
 void gw_mode_usage(void);
 void vis_mode_usage(void);
 void orig_interval_usage(void);
+void network_coding_usage(void);
+void nc_min_tq_usage(void);
+void nc_hold_usage(void);
+void nc_purge_usage(void);
 int interface(char *mesh_iface, int argc, char **argv);
 int handle_loglevel(char *mesh_iface, int argc, char **argv);
 int handle_sys_setting(char *mesh_iface, int argc, char **argv,
-- 
1.7.9.1


--------------030006080609030608000605
Content-Type: text/plain;
 name="Parte del mensaje adjunto"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Parte del mensaje adjunto"


--------------030006080609030608000605--
