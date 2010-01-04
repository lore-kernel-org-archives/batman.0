Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  4 Jan 2010 23:46:15 +0800
Message-Id: <1262619976-5632-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1262619976-5632-1-git-send-email-lindner_marek@yahoo.de>
References: <201001042344.02273.lindner_marek@yahoo.de>
	<1262619976-5632-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: add support for gateway mode
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

---
 batctl/main.c       |   10 ++++++++++
 batctl/man/batctl.8 |    6 ++++++
 batctl/proc.c       |   16 ++++++++++++++++
 batctl/proc.h       |    8 ++++----
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/batctl/main.c b/batctl/main.c
index 8be1d05..6e4493d 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -46,6 +46,8 @@ void print_usage(void) {
 	printf(" \tinterval|it   [orig_interval]   \tdisplay or modify the originator interval in ms\n");
 	printf(" \tloglevel|ll   [level]           \tdisplay or modify the log level\n");
 	printf(" \tlog|l                           \tread the log produced by the kernel module\n");
+	printf(" \tgw_mode|gw    [mode]            \tdisplay or modify the gateway mode\n");
+	printf(" \tgw_srv_list|gwl                 \tdisplay the gateway server list\n");
 	printf(" \ttranslocal|tl                   \tdisplay the local translation table\n");
 	printf(" \ttransglobal|tg                  \tdisplay the global translation table\n");
 	printf(" \tvis_server|vs [enable|disable]  \tdisplay or modify the status of the VIS server\n");
@@ -130,6 +132,14 @@ int main(int argc, char **argv)
 
 		ret = vis_data(argc - 1, argv + 1);
 
+	} else if ((strcmp(argv[1], "gw_mode") == 0) || (strcmp(argv[1], "gw") == 0)) {
+
+		ret = handle_proc_setting(argc - 1, argv + 1, PROC_GW_MODE, gw_mode_usage);
+
+	} else if ((strcmp(argv[1], "gw_srv_list") == 0) || (strcmp(argv[1], "gwl") == 0)) {
+
+		ret = handle_table(argc - 1, argv + 1, PROC_GW_SRV_LIST, gw_srv_list_usage);
+
 	} else if ((strcmp(argv[1], "aggregation") == 0) || (strcmp(argv[1], "ag") == 0)) {
 
 		ret = handle_proc_setting(argc - 1, argv + 1, PROC_AGGR, aggregation_usage);
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 304168c..61e7958 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -57,6 +57,12 @@ If no parameter is given the current log level settings are displayed otherwise
 .IP "\fBlog|l\fP	"
 Once started batctl will continuously read the log produced by the kernel module (the amount of log message can be influenced by modifying the log level). Whenever there are new log messages sent by the kernel batctl will display it. Use the "\-b" option to let batctl exit after the existing log buffer has been displayed. If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
 .br
+.IP "\fBgw_mode|gw	[off|client|server]\fP"
+If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode.
+.br
+.IP "\fBgw_srv_list|gwl\fP"
+Once started batctl will refresh the displayed gateway server list every second. Use the "\-b" option to let batctl display the list only once (useful for scripts). If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
+.br
 .IP "\fBtranslocal|tl\fP"
 Once started batctl will refresh the displayed local translation table every second. Use the "\-b" option to let batctl display the table only once (useful for scripts). If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
 .br
diff --git a/batctl/proc.c b/batctl/proc.c
index d73a9fa..7ae19b4 100644
--- a/batctl/proc.c
+++ b/batctl/proc.c
@@ -95,6 +95,15 @@ void trans_global_usage(void)
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
 }
 
+void gw_srv_list_usage(void)
+{
+	printf("Usage: batctl [options] gw_srv_list \n");
+	printf("options:\n");
+	printf(" \t -b batch mode - read the gateway server list once and quit\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+}
+
 void orig_interval_usage(void)
 {
 	printf("Usage: batctl [options] interval \n");
@@ -116,6 +125,13 @@ void aggregation_usage(void)
 	printf(" \t -h print this help\n");
 }
 
+void gw_mode_usage(void)
+{
+	printf("Usage: batctl [options] gw_mode [mode]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
 int handle_table(int argc, char **argv, char *file_path, void table_usage(void))
 {
 	int optchar, read_opt = CLR_CONT_READ | USE_BAT_HOSTS;
diff --git a/batctl/proc.h b/batctl/proc.h
index ad00136..d867b78 100644
--- a/batctl/proc.h
+++ b/batctl/proc.h
@@ -19,19 +19,17 @@
  *
  */
 
-
-
 #define PROC_ROOT_PATH "/proc/net/batman-adv/"
 #define PROC_INTERFACES "interfaces"
 #define PROC_ORIGINATORS "originators"
 #define PROC_ORIG_INTERVAL "orig_interval"
-#define PROC_GATEWAYS "gateways"
 #define PROC_TRANSTABLE_LOCAL "transtable_local"
 #define PROC_TRANSTABLE_GLOBAL "transtable_global"
 #define PROC_VIS_SERVER "vis_server"
 #define PROC_VIS_DATA "vis_data"
 #define PROC_AGGR "aggregate_ogm"
-
+#define PROC_GW_MODE "gateway_mode"
+#define PROC_GW_SRV_LIST "gateway_srv_list"
 
 int interface(int argc, char **argv);
 
@@ -41,5 +39,7 @@ void trans_global_usage(void);
 void orig_interval_usage(void);
 void vis_server_usage(void);
 void aggregation_usage(void);
+void gw_mode_usage(void);
+void gw_srv_list_usage(void);
 int handle_table(int argc, char **argv, char *file_path, void table_usage(void));
 int handle_proc_setting(int argc, char **argv, char *file_path, void setting_usage(void));
-- 
1.6.5.7

