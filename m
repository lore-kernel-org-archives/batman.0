Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 21:50:13 +0100
Message-Id: <20181207205013.25105-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Rename option_watch_interval to
 option_timeout_interval
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

The watch interval is actually a different option for debug tables which
uses the parameter '-w'. The configuration to enable/disable the parameter
to set the timeout for not displaying not seen originators should therefore
use a different name.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c       | 4 ++--
 debug.h       | 2 +-
 originators.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/debug.c b/debug.c
index 316312f..182877a 100644
--- a/debug.c
+++ b/debug.c
@@ -44,7 +44,7 @@ static void debug_table_usage(struct state *state)
 	fprintf(stderr, " \t -H don't show the header\n");
 	fprintf(stderr, " \t -w [interval] watch mode - refresh the table continuously\n");
 
-	if (debug_table->option_watch_interval)
+	if (debug_table->option_timeout_interval)
 		fprintf(stderr, " \t -t timeout interval - don't print originators not seen for x.y seconds \n");
 
 	if (debug_table->option_orig_iface)
@@ -89,7 +89,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			}
 			break;
 		case 't':
-			if (!debug_table->option_watch_interval) {
+			if (!debug_table->option_timeout_interval) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
 				debug_table_usage(state);
 				return EXIT_FAILURE;
diff --git a/debug.h b/debug.h
index 2dac1b7..f1a3fd4 100644
--- a/debug.h
+++ b/debug.h
@@ -43,7 +43,7 @@ struct debug_table_data {
 			 float orig_timeout, float watch_interval);
 	unsigned int option_unicast_only:1;
 	unsigned int option_multicast_only:1;
-	unsigned int option_watch_interval:1;
+	unsigned int option_timeout_interval:1;
 	unsigned int option_orig_iface:1;
 };
 
diff --git a/originators.c b/originators.c
index c29300a..7dc9b4c 100644
--- a/originators.c
+++ b/originators.c
@@ -219,7 +219,7 @@ static struct debug_table_data batctl_debug_table_originators = {
 	.debugfs_name = "originators",
 	.header_lines = 2,
 	.netlink_fn = netlink_print_originators,
-	.option_watch_interval = 1,
+	.option_timeout_interval = 1,
 	.option_orig_iface = 1,
 };
 
-- 
2.19.2

