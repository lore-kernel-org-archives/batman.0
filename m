Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 Sep 2010 15:20:51 +0200
Message-Id: <1285766451-22259-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201009291520.13588.lindner_marek@yahoo.de>
References: <201009291520.13588.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv3 2/2] batctl: display soft-interface
	neighbor table
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
 batctl/debug.c      |    9 +++++++++
 batctl/debug.h      |    2 ++
 batctl/main.c       |    6 ++++++
 batctl/man/batctl.8 |    3 +++
 4 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/batctl/debug.c b/batctl/debug.c
index 1dbc204..ea5e1cb 100644
--- a/batctl/debug.c
+++ b/batctl/debug.c
@@ -61,6 +61,15 @@ void trans_global_usage(void)
 	printf(" \t -w [interval] watch mode - refresh the global translation table continuously\n");
 }
 
+void softif_neigh_usage(void)
+{
+	printf("Usage: batctl [options] softif_neigh \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	printf(" \t -w [interval] watch mode - refresh the soft-interface neighbor table continuously\n");
+}
+
 void gateways_usage(void)
 {
 	printf("Usage: batctl [options] gateways \n");
diff --git a/batctl/debug.h b/batctl/debug.h
index 8bed80e..aa5b362 100644
--- a/batctl/debug.h
+++ b/batctl/debug.h
@@ -24,6 +24,7 @@
 #define DEBUG_ORIGINATORS "originators"
 #define DEBUG_TRANSTABLE_LOCAL "transtable_local"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
+#define DEBUG_SOFTIF_NEIGH "softif_neigh"
 #define DEBUG_GATEWAYS "gateways"
 #define DEBUG_VIS_DATA "vis_data"
 #define DEBUG_LOG "log"
@@ -31,6 +32,7 @@
 void originators_usage(void);
 void trans_local_usage(void);
 void trans_global_usage(void);
+void softif_neigh_usage(void);
 void gateways_usage(void);
 int handle_debug_table(char *mesh_iface, int argc, char **argv,
 		       char *file_path, void table_usage(void));
diff --git a/batctl/main.c b/batctl/main.c
index 5e3f5d8..9c1195b 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -52,6 +52,7 @@ void print_usage(void) {
 	printf(" \tgateways|gwl                      \tdisplay the gateway server list\n");
 	printf(" \ttranslocal|tl                     \tdisplay the local translation table\n");
 	printf(" \ttransglobal|tg                    \tdisplay the global translation table\n");
+	printf(" \tsoftif_neigh|sn                   \tdisplay the soft-interface neighbor table\n");
 	printf(" \tvis_mode|vm     [mode]            \tdisplay or modify the status of the VIS server\n");
 	printf(" \tvis_data|vd     [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
 	printf(" \taggregation|ag  [0|1]             \tdisplay or modify the packet aggregation setting\n");
@@ -136,6 +137,11 @@ int main(int argc, char **argv)
 		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
 					 DEBUG_TRANSTABLE_GLOBAL, trans_global_usage);
 
+	} else if ((strcmp(argv[1], "softif_neigh") == 0) || (strcmp(argv[1], "sn") == 0)) {
+
+		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
+					 DEBUG_SOFTIF_NEIGH, softif_neigh_usage);
+
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
 		ret = handle_loglevel(mesh_iface, argc - 1, argv + 1);
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index f98e6ad..13822ef 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -121,6 +121,9 @@ Display the local translation table. batctl will refresh the list every second i
 .IP "\fBtransglobal\fP|\fBtg\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
 Display the global translation table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
 .br
+.IP "\fBsoftif_neigh\fP|\fBsn\fP   [\fB\-w\fP [\fI\interval\fP]][\fB\-n\fP]"
+Display the soft\-interface neighbor table. batctl will refresh the list every second if the "\-w" option was given or add a number to let it refresh at a custom interval in seconds (with optional decimal places). Use "\-n" to let batctl not replace the MAC addresses with bat\-host names in the output.
+.br
 .IP "\fBvis_mode|vm\fP	  [\fBmode\fP]\fP"
 If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
 .br
-- 
1.7.1

