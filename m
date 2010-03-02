Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed,  3 Mar 2010 06:40:47 +0800
Message-Id: <1267569647-23594-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201003030640.16085.lindner_marek@yahoo.de>
References: <201003030640.16085.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: adding batctl bonding mode
	support
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/main.c       |   37 +++++++++++++++++++++----------------
 batctl/man/batctl.8 |    4 ++++
 batctl/sys.c        |    7 +++++++
 batctl/sys.h        |    1 +
 4 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/batctl/main.c b/batctl/main.c
index 99bfb5b..e0b7f55 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -41,23 +41,24 @@
 void print_usage(void) {
 	printf("Usage: batctl [options] commands \n");
 	printf("commands:\n");
-	printf(" \tinterface|if  [none|interface]  \tdisplay or modify the interface settings\n");
-	printf(" \toriginators|o                   \tdisplay the originator table\n");
-	printf(" \tinterval|it   [orig_interval]   \tdisplay or modify the originator interval in ms\n");
-	printf(" \tloglevel|ll   [level]           \tdisplay or modify the log level\n");
-	printf(" \tlog|l                           \tread the log produced by the kernel module\n");
-	printf(" \tgw_mode|gw    [mode]            \tdisplay or modify the gateway mode\n");
-	printf(" \tgw_srv_list|gwl                 \tdisplay the gateway server list\n");
-	printf(" \ttranslocal|tl                   \tdisplay the local translation table\n");
-	printf(" \ttransglobal|tg                  \tdisplay the global translation table\n");
-	printf(" \tvis_server|vs [enable|disable]  \tdisplay or modify the status of the VIS server\n");
-	printf(" \tvis_data|vd [dot|JSON]          \tdisplay the VIS data in dot or JSON format\n");
-	printf(" \taggregation|ag   [0|1]          \tdisplay or modify the packet aggregation setting\n");
+	printf(" \tinterface|if   [none|interface]  \tdisplay or modify the interface settings\n");
+	printf(" \toriginators|o                    \tdisplay the originator table\n");
+	printf(" \tinterval|it    [orig_interval]   \tdisplay or modify the originator interval in ms\n");
+	printf(" \tloglevel|ll    [level]           \tdisplay or modify the log level\n");
+	printf(" \tlog|l                            \tread the log produced by the kernel module\n");
+	printf(" \tgw_mode|gw     [mode]            \tdisplay or modify the gateway mode\n");
+	printf(" \tgw_srv_list|gwl                  \tdisplay the gateway server list\n");
+	printf(" \ttranslocal|tl                    \tdisplay the local translation table\n");
+	printf(" \ttransglobal|tg                   \tdisplay the global translation table\n");
+	printf(" \tvis_server|vs  [enable|disable]  \tdisplay or modify the status of the VIS server\n");
+	printf(" \tvis_data|vd    [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
+	printf(" \taggregation|ag [0|1]             \tdisplay or modify the packet aggregation setting\n");
+	printf(" \tbonding|b      [0|1]             \tdisplay or modify the bonding mode setting\n");
 	printf("\n");
-	printf(" \tping|p        <destination>     \tping another batman adv host via layer 2\n");
-	printf(" \ttraceroute|tr <destination>     \ttraceroute another batman adv host via layer 2\n");
-	printf(" \ttcpdump|td    <interface>       \ttcpdump layer 2 traffic on the given interface\n");
-	printf(" \tbisect        <file1> .. <fileN>\tanalyze given log files for routing stability\n");
+	printf(" \tping|p         <destination>     \tping another batman adv host via layer 2\n");
+	printf(" \ttraceroute|tr  <destination>     \ttraceroute another batman adv host via layer 2\n");
+	printf(" \ttcpdump|td     <interface>       \ttcpdump layer 2 traffic on the given interface\n");
+	printf(" \tbisect         <file1> .. <fileN>\tanalyze given log files for routing stability\n");
 	printf("options:\n");
 	printf(" \t-h print this help (or 'batctl <command> -h' for the command specific help)\n");
 	printf(" \t-v print version\n");
@@ -144,6 +145,10 @@ int main(int argc, char **argv)
 
 		ret = handle_sys_setting(argc - 1, argv + 1, SYS_AGGR, aggregation_usage);
 
+	} else if ((strcmp(argv[1], "bonding") == 0) || (strcmp(argv[1], "b") == 0)) {
+
+		ret = handle_sys_setting(argc - 1, argv + 1, SYS_BONDING, bonding_usage);
+
 	} else if ((strcmp(argv[1], "bisect") == 0)) {
 
 		ret = bisect(argc - 1, argv + 1);
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 63b5bd4..dcadec4 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -126,6 +126,10 @@ If no parameter is given the current aggregation setting is displayed.
 Otherwise the parameter is used to enable or disable packet
 aggregation.
 .br
+.IP "\fBbonding\fP|\fBb\fP [\fB1\fP|\fB0\fP]"
+If no parameter is given the current bonding mode setting is displayed.
+Otherwise the parameter is used to enable or disable the bonding mode.
+.br
 .IP "\fBping\fP|\fBp\fP [\fB\-c \fP\fIcount\fP][\fB\-i \fP\fIinterval\fP][\fB\-t \fP\fItime\fP] \fIMAC_address\fP|\fIbat\-host_name\fP"
 Layer 2 ping of a MAC address or bat\-host name.  batctl will try to
 find the bat\-host name if the given parameter was not a MAC
diff --git a/batctl/sys.c b/batctl/sys.c
index 8afffc7..5b4a9fa 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -177,6 +177,13 @@ void aggregation_usage(void)
 	printf(" \t -h print this help\n");
 }
 
+void bonding_usage(void)
+{
+	printf("Usage: batctl [options] bonding \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
 int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usage(void))
 {
 	int optchar, res;
diff --git a/batctl/sys.h b/batctl/sys.h
index b7dd975..3560f98 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -28,6 +28,7 @@
 #define SYS_TRANSTABLE_LOCAL "transtable_local"
 #define SYS_TRANSTABLE_GLOBAL "transtable_global"
 #define SYS_AGGR "aggregate_ogm"
+#define SYS_BONDING "bonding"
 
 void originators_usage(void);
 void trans_local_usage(void);
-- 
1.7.0

