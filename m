Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 15 Jun 2012 11:46:02 +0200
Message-Id: <1339753563-313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <20120615084751.GA32430@pandem0nium>
References: <20120615084751.GA32430@pandem0nium>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add support for the bla backbone
	table in debugfs
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 debug.c |   10 ++++++++++
 debug.h |    2 ++
 main.c  |    6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/debug.c b/debug.c
index 928f81d..5dca633 100644
--- a/debug.c
+++ b/debug.c
@@ -70,6 +70,16 @@ void bla_claim_table_usage(void)
 	printf(" \t -w [interval] watch mode - refresh the bridge loop avoidance claim table continuously\n");
 }
 
+void bla_backbone_table_usage(void)
+{
+	printf("Usage: batctl [options] backbone table\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	printf(" \t -w [interval] watch mode - refresh the bridge loop avoidance backbone table continuously\n");
+}
+
+
 void gateways_usage(void)
 {
 	printf("Usage: batctl [options] gateways \n");
diff --git a/debug.h b/debug.h
index 50d0e24..2c6d24c 100644
--- a/debug.h
+++ b/debug.h
@@ -25,6 +25,7 @@
 #define DEBUG_TRANSTABLE_LOCAL "transtable_local"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
 #define DEBUG_BLA_CLAIM_TABLE "bla_claim_table"
+#define DEBUG_BLA_BACKBONE_TABLE "bla_backbone_table"
 #define DEBUG_GATEWAYS "gateways"
 #define DEBUG_VIS_DATA "vis_data"
 #define DEBUG_LOG "log"
@@ -33,6 +34,7 @@ void originators_usage(void);
 void trans_local_usage(void);
 void trans_global_usage(void);
 void bla_claim_table_usage(void);
+void bla_backbone_table_usage(void);
 void gateways_usage(void);
 int handle_debug_table(char *mesh_iface, int argc, char **argv,
 		       char *file_path, void table_usage(void));
diff --git a/main.c b/main.c
index 72b1ea4..929b762 100644
--- a/main.c
+++ b/main.c
@@ -56,6 +56,7 @@ void print_usage(void) {
 	printf(" \ttranslocal|tl                                \tdisplay the local translation table\n");
 	printf(" \ttransglobal|tg                               \tdisplay the global translation table\n");
 	printf(" \tclaimtable|cl                                \tdisplay the bridge loop avoidance claim table\n");
+	printf(" \tbackbonetable|bbl                            \tdisplay the bridge loop avoidance backbone table\n");
 	printf(" \tvis_mode|vm                [mode]            \tdisplay or modify the status of the VIS server\n");
 	printf(" \tvis_data|vd                [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
 	printf(" \taggregation|ag             [0|1]             \tdisplay or modify the packet aggregation setting\n");
@@ -158,6 +159,11 @@ int main(int argc, char **argv)
 
 		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
 					 DEBUG_BLA_CLAIM_TABLE, bla_claim_table_usage);
+	} else if ((strcmp(argv[1], "backbonetable") == 0) || (strcmp(argv[1], "bbl") == 0)) {
+
+		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
+					 DEBUG_BLA_BACKBONE_TABLE,
+					 bla_backbone_table_usage);
 
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
-- 
1.7.10

