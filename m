Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  6 Dec 2018 07:31:59 +0100
Message-Id: <20181206063159.4070-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batctl: Fix parsing of optional debug
 table command parameters
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

The commands which should have no support for -t/-u/-m/-i were allowed to
accept these parameters but commands which should have accepted them were
denying them.

Fixes: cd2b4047ead9 ("batctl: Convert debug table to command infrastructure")
Reported-by: Andreas Ziegler <dev@andreas-ziegler.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/debug.c b/debug.c
index 2979dff..316312f 100644
--- a/debug.c
+++ b/debug.c
@@ -89,7 +89,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			}
 			break;
 		case 't':
-			if (debug_table->option_watch_interval) {
+			if (!debug_table->option_watch_interval) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
 				debug_table_usage(state);
 				return EXIT_FAILURE;
@@ -105,7 +105,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			read_opt |= SKIP_HEADER;
 			break;
 		case 'u':
-			if (debug_table->option_unicast_only) {
+			if (!debug_table->option_unicast_only) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
 				debug_table_usage(state);
 				return EXIT_FAILURE;
@@ -114,7 +114,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			read_opt |= UNICAST_ONLY;
 			break;
 		case 'm':
-			if (debug_table->option_multicast_only) {
+			if (!debug_table->option_multicast_only) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
 				debug_table_usage(state);
 				return EXIT_FAILURE;
@@ -123,7 +123,7 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			read_opt |= MULTICAST_ONLY;
 			break;
 		case 'i':
-			if (debug_table->option_orig_iface) {
+			if (!debug_table->option_orig_iface) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
 				debug_table_usage(state);
 				return EXIT_FAILURE;
-- 
2.19.2

