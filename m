Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue,  7 Feb 2012 20:05:25 +0100
Message-Id: <1328641525-25759-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add bridge loop avoidance code and
	remove softif_neigh stuff
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

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 debug.c      |    6 +++---
 debug.h      |    4 ++--
 main.c       |   50 ++++++++++++++++++++++++++++----------------------
 man/batctl.8 |    7 +++++--
 sys.c        |   12 ++++++++++++
 sys.h        |    2 ++
 6 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/debug.c b/debug.c
index 6a553ff..155f499 100644
--- a/debug.c
+++ b/debug.c
@@ -61,13 +61,13 @@ void trans_global_usage(void)
 	printf(" \t -w [interval] watch mode - refresh the global translation table continuously\n");
 }
 
-void softif_neigh_usage(void)
+void bla_claim_table_usage(void)
 {
-	printf("Usage: batctl [options] softif_neigh \n");
+	printf("Usage: batctl [options] claimtable \n");
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w [interval] watch mode - refresh the soft-interface neighbor table continuously\n");
+	printf(" \t -w [interval] watch mode - refresh the bridge loop avoidance claim table continuously\n");
 }
 
 void gateways_usage(void)
diff --git a/debug.h b/debug.h
index 939f281..50d0e24 100644
--- a/debug.h
+++ b/debug.h
@@ -24,7 +24,7 @@
 #define DEBUG_ORIGINATORS "originators"
 #define DEBUG_TRANSTABLE_LOCAL "transtable_local"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
-#define DEBUG_SOFTIF_NEIGH "softif_neigh"
+#define DEBUG_BLA_CLAIM_TABLE "bla_claim_table"
 #define DEBUG_GATEWAYS "gateways"
 #define DEBUG_VIS_DATA "vis_data"
 #define DEBUG_LOG "log"
@@ -32,7 +32,7 @@
 void originators_usage(void);
 void trans_local_usage(void);
 void trans_global_usage(void);
-void softif_neigh_usage(void);
+void bla_claim_table_usage(void);
 void gateways_usage(void);
 int handle_debug_table(char *mesh_iface, int argc, char **argv,
 		       char *file_path, void table_usage(void));
diff --git a/main.c b/main.c
index 0dfdb8e..86e2078 100644
--- a/main.c
+++ b/main.c
@@ -45,27 +45,28 @@ char module_ver_path[] = "/sys/module/batman_adv/version";
 void print_usage(void) {
 	printf("Usage: batctl [options] commands \n");
 	printf("commands:\n");
-	printf(" \tinterface|if    [add|del iface(s)]\tdisplay or modify the interface settings\n");
-	printf(" \toriginators|o                     \tdisplay the originator table\n");
-	printf(" \tinterval|it     [orig_interval]   \tdisplay or modify the originator interval (in ms)\n");
-	printf(" \tloglevel|ll     [level]           \tdisplay or modify the log level\n");
-	printf(" \tlog|l                             \tread the log produced by the kernel module\n");
-	printf(" \tgw_mode|gw      [mode]            \tdisplay or modify the gateway mode\n");
-	printf(" \tgateways|gwl                      \tdisplay the gateway server list\n");
-	printf(" \ttranslocal|tl                     \tdisplay the local translation table\n");
-	printf(" \ttransglobal|tg                    \tdisplay the global translation table\n");
-	printf(" \tsoftif_neigh|sn                   \tdisplay the soft-interface neighbor table\n");
-	printf(" \tvis_mode|vm     [mode]            \tdisplay or modify the status of the VIS server\n");
-	printf(" \tvis_data|vd     [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
-	printf(" \taggregation|ag  [0|1]             \tdisplay or modify the packet aggregation setting\n");
-	printf(" \tbonding|b       [0|1]             \tdisplay or modify the bonding mode setting\n");
-	printf(" \tfragmentation|f [0|1]             \tdisplay or modify the fragmentation mode setting\n");
-	printf(" \tap_isolation|ap [0|1]             \tdisplay or modify the ap isolation mode setting\n");
+	printf(" \tinterface|if               [add|del iface(s)]\tdisplay or modify the interface settings\n");
+	printf(" \toriginators|o                                \tdisplay the originator table\n");
+	printf(" \tinterval|it                [orig_interval]   \tdisplay or modify the originator interval (in ms)\n");
+	printf(" \tloglevel|ll                [level]           \tdisplay or modify the log level\n");
+	printf(" \tlog|l                                        \tread the log produced by the kernel module\n");
+	printf(" \tgw_mode|gw                 [mode]            \tdisplay or modify the gateway mode\n");
+	printf(" \tgateways|gwl                                 \tdisplay the gateway server list\n");
+	printf(" \ttranslocal|tl                                \tdisplay the local translation table\n");
+	printf(" \ttransglobal|tg                               \tdisplay the global translation table\n");
+	printf(" \tclaimtable|cl                                \tdisplay the bridge loop avoidance claim table\n");
+	printf(" \tvis_mode|vm                [mode]            \tdisplay or modify the status of the VIS server\n");
+	printf(" \tvis_data|vd                [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
+	printf(" \taggregation|ag             [0|1]             \tdisplay or modify the packet aggregation setting\n");
+	printf(" \tbonding|b                  [0|1]             \tdisplay or modify the bonding mode setting\n");
+	printf(" \tbridge_loop_avoidance|bl   [0|1]             \tdisplay or modify the bridge loop avoidance setting\n");
+	printf(" \tfragmentation|f            [0|1]             \tdisplay or modify the fragmentation mode setting\n");
+	printf(" \tap_isolation|ap            [0|1]             \tdisplay or modify the ap isolation mode setting\n");
 	printf("\n");
-	printf(" \tping|p          <destination>     \tping another batman adv host via layer 2\n");
-	printf(" \ttraceroute|tr   <destination>     \ttraceroute another batman adv host via layer 2\n");
-	printf(" \ttcpdump|td      <interface>       \ttcpdump layer 2 traffic on the given interface\n");
-	printf(" \tbisect          <file1> .. <fileN>\tanalyze given log files for routing stability\n");
+	printf(" \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
+	printf(" \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
+	printf(" \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+	printf(" \tbisect                     <file1> .. <fileN>\tanalyze given log files for routing stability\n");
 	printf("options:\n");
 	printf(" \t-m mesh interface (default 'bat0')\n");
 	printf(" \t-h print this help (or 'batctl <command> -h' for the command specific help)\n");
@@ -151,10 +152,10 @@ int main(int argc, char **argv)
 		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
 					 DEBUG_TRANSTABLE_GLOBAL, trans_global_usage);
 
-	} else if ((strcmp(argv[1], "softif_neigh") == 0) || (strcmp(argv[1], "sn") == 0)) {
+	} else if ((strcmp(argv[1], "claimtable") == 0) || (strcmp(argv[1], "cl") == 0)) {
 
 		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
-					 DEBUG_SOFTIF_NEIGH, softif_neigh_usage);
+					 DEBUG_BLA_CLAIM_TABLE, bla_claim_table_usage);
 
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
@@ -197,6 +198,11 @@ int main(int argc, char **argv)
 		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
 					 SYS_BONDING, bonding_usage, sysfs_param_enable);
 
+	} else if ((strcmp(argv[1], "bridge_loop_avoidance") == 0) || (strcmp(argv[1], "bl") == 0)) {
+
+		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
+					 SYS_BRIDGE_LOOP_AVOIDANCE, bridge_loop_avoidance_usage, sysfs_param_enable);
+
 	} else if ((strcmp(argv[1], "fragmentation") == 0) || (strcmp(argv[1], "f") == 0)) {
 
 		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
diff --git a/man/batctl.8 b/man/batctl.8
index 0cf0a7b..f45a070 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -121,8 +121,8 @@ Display the local translation table. batctl will refresh the list every second i
 .IP "\fBtransglobal\fP|\fBtg\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
 Display the global translation table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
 .br
-.IP "\fBsoftif_neigh\fP|\fBsn\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
-Display the soft\-interface neighbor table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
+.IP "\fBclaimtable\fP|\fBcl\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
+Display the bridge loop avoidance claim table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
 .br
 .IP "\fBvis_mode|vm\fP	  [\fBmode\fP]\fP"
 If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
@@ -149,6 +149,9 @@ If no parameter is given the current aggregation setting is displayed. Otherwise
 .IP "\fBbonding\fP|\fBb\fP        [\fB1\fP|\fB0\fP]"
 If no parameter is given the current bonding mode setting is displayed. Otherwise the parameter is used to enable or disable the bonding mode.
 .br
+.IP "\fBbridge_loop_avoidance\fP|\fBbl\fP        [\fB1\fP|\fB0\fP]"
+If no parameter is given the current bridge loop avoidance setting is displayed. Otherwise the parameter is used to enable or disable the bridge loop avoidance.
+.br
 .IP "\fBfragmentation\fP|\fBf\fP   [\fB1\fP|\fB0\fP]"
 If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or disable fragmentation.
 .br
diff --git a/sys.c b/sys.c
index 0263ae7..6cf4714 100644
--- a/sys.c
+++ b/sys.c
@@ -183,6 +183,7 @@ static void log_level_usage(void)
 	printf(" \t batman  Messages related to routing / flooding / broadcasting\n");
 	printf(" \t routes  Messages related to route added / changed / deleted\n");
 	printf(" \t tt      Messages related to translation table operations\n");
+	printf(" \t bla     Messages related to bridge loop avoidance\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
@@ -221,6 +222,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 				log_level |= (1 << 1);
 			else if (strcmp(argv[i], "tt") == 0)
 				log_level |= (1 << 2);
+			else if (strcmp(argv[i], "bla") == 0)
+				log_level |= (1 << 4);
 			else {
 				log_level_usage();
 				goto out;
@@ -248,6 +251,8 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	       "messages related to route added / changed / deleted", "routes");
 	printf("[%c] %s (%s)\n", (log_level & 4) ? 'x' : ' ',
 	       "messages related to translation table operations", "tt");
+	printf("[%c] %s (%s)\n", (log_level & 8) ? 'x' : ' ',
+	       "messages related to bridge loop avoidance", "bla");
 
 out:
 	if (errno == ENOENT)
@@ -271,6 +276,13 @@ void bonding_usage(void)
 	printf(" \t -h print this help\n");
 }
 
+void bridge_loop_avoidance_usage(void)
+{
+	printf("Usage: batctl [options] bridge_loop_avoidance [0|1]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
 void gw_mode_usage(void)
 {
 	printf("Usage: batctl [options] gw_mode [mode] [sel_class|bandwidth]\n");
diff --git a/sys.h b/sys.h
index 5dafe85..46a1159 100644
--- a/sys.h
+++ b/sys.h
@@ -25,6 +25,7 @@
 #define SYS_LOG "log"
 #define SYS_AGGR "aggregated_ogms"
 #define SYS_BONDING "bonding"
+#define SYS_BRIDGE_LOOP_AVOIDANCE "bridge_loop_avoidance"
 #define SYS_GW_MODE "gw_mode"
 #define SYS_GW_SEL "gw_sel_class"
 #define SYS_GW_BW "gw_bandwidth"
@@ -47,6 +48,7 @@ extern const char *sysfs_param_server[];
 
 void aggregation_usage(void);
 void bonding_usage(void);
+void bridge_loop_avoidance_usage(void);
 void fragmentation_usage(void);
 void ap_isolation_usage(void);
 void gw_mode_usage(void);
-- 
1.7.8.3

