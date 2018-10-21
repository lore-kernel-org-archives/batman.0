Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:54:49 +0200
Message-Id: <20181021225524.8155-4-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 03/38] batctl: Drop legacy vis_* related
 warning messages
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

The vis support code was removed with batman-adv 2014.0.0 (Linux 3.13). All
kernel versions with up to this version are EOL for a while and also batctl
warned now about this problem for nearly 5 years. It should therefore no
(serious) problem to remove these warning messages.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c | 28 ----------------------------
 debug.h |  1 -
 main.c  |  6 ------
 3 files changed, 35 deletions(-)

diff --git a/debug.c b/debug.c
index 63fb633..185e26d 100644
--- a/debug.c
+++ b/debug.c
@@ -269,34 +269,6 @@ int debug_print_routing_algos(void)
 	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
 }
 
-int print_vis_info(char *mesh_iface)
-{
-	char full_path[MAX_PATH+1];
-	char *debugfs_mnt;
-	FILE *fp;
-
-	check_root_or_die("batctl vis_data");
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		return -1;
-	}
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/vis_data", mesh_iface, full_path, sizeof(full_path));
-	fp = fopen(full_path, "r");
-	if (fp) {
-		fclose(fp);
-		fprintf(stderr, "Error - batctl version is newer than kernel module - the kernel module still supports\n"
-				"vis, but later versions will not. The vis functionality has been moved to the userspace\n"
-				"daemon ''alfred''. Please either downgrade to an older (compatible) batctl version or use alfred.\n");
-	} else {
-		fprintf(stderr, "Error - The installed batctl version and kernel module don't have vis support. The vis functionality\n"
-				"has been moved to the userspace daemon ''alfred''.\n");
-	}
-	return 0;
-}
-
 static void log_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] log [parameters]\n");
diff --git a/debug.h b/debug.h
index 9c57aa6..5508eaf 100644
--- a/debug.h
+++ b/debug.h
@@ -59,6 +59,5 @@ extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv);
 int log_print(char *mesh_iface, int argc, char **argv);
 int debug_print_routing_algos(void);
-int print_vis_info(char *mesh_iface);
 
 #endif
diff --git a/main.c b/main.c
index e904a1f..3a6011b 100644
--- a/main.c
+++ b/main.c
@@ -175,12 +175,6 @@ int main(int argc, char **argv)
 
 		ret = log_print(mesh_iface, argc - 1, argv + 1);
 
-        /* vis legacy support */
-	} else if ((strcmp(argv[1], "vis_data") == 0) || (strcmp(argv[1], "vd") == 0) ||
-	           (strcmp(argv[1], "vis_mode") == 0) || (strcmp(argv[1], "vm") == 0)) {
-
-		ret = print_vis_info(mesh_iface);
-
 	} else if ((strcmp(argv[1], "gw_mode") == 0) || (strcmp(argv[1], "gw") == 0)) {
 
 		ret = handle_gw_setting(mesh_iface, argc - 1, argv + 1);
-- 
2.19.1

