Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 31 Oct 2012 10:52:29 +0100
Message-Id: <1351677149-6045-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Guarantee delimiter after snprintf
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

snprintf doesn't add a \0 delimiter when the size of the buffer is not big
enough. The caller has to fix it manually to avoid crashes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c |   10 ++++++----
 debugfs.c   |    1 +
 sys.c       |    8 ++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index c4c06c2..09171fb 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -639,9 +639,9 @@ static int print_rt_path_at_seqno(struct bat_node *src_node, struct bat_node *ds
 	struct rt_hist *rt_hist;
 	char curr_loop_magic[LOOP_MAGIC_LEN];
 
-	memset(curr_loop_magic, 0, LOOP_MAGIC_LEN);
-	snprintf(curr_loop_magic, LOOP_MAGIC_LEN, "%s%s%lli%lli", src_node->name,
+	snprintf(curr_loop_magic, sizeof(curr_loop_magic), "%s%s%lli%lli", src_node->name,
 	         dst_node->name, seqno, seqno_rand);
+	curr_loop_magic[sizeof(curr_loop_magic) - 1] = '\0';
 
 	printf("Path towards %s (seqno %lli ",
 	       get_name_by_macstr(dst_node->name, read_opt), seqno);
@@ -719,10 +719,10 @@ static int find_rt_table_change(struct bat_node *src_node, struct bat_node *dst_
 		return 0;
 	}
 
-	memset(curr_loop_magic, 0, LOOP_MAGIC_LEN);
-	snprintf(curr_loop_magic, LOOP_MAGIC_LEN, "%s%s%lli%lli",
+	snprintf(curr_loop_magic, sizeof(curr_loop_magic), "%s%s%lli%lli",
 	         src_node->name, dst_node->name,
 	         seqno_min_tmp, seqno_rand);
+	curr_loop_magic[sizeof(curr_loop_magic) - 1] = '\0';
 
 	orig_event = orig_event_get_by_ptr(curr_node, dst_node);
 	if (!orig_event)
@@ -979,6 +979,7 @@ static void seqno_trace_print_neigh(struct seqno_trace_neigh *seqno_trace_neigh,
 		         (strlen(head) > 1 ? head : num_sisters == 0 ? " " : head),
 		         (strlen(head) == 1 ? "   " :
 		         num_sisters == 0 ? "    " : "|   "));
+		new_head[sizeof(new_head) - 1] = '\0';
 
 		seqno_trace_print_neigh(seqno_trace_neigh->seqno_trace_neigh[i], seqno_trace_neigh->seqno_event,
 		                        seqno_trace_neigh->num_neighbors - i - 1, new_head, read_opt);
@@ -1024,6 +1025,7 @@ static void seqno_trace_print(struct list_head_first *trace_list, char *trace_or
 
 			snprintf(head, sizeof(head), "%c",
 			         (seqno_trace->seqno_trace_neigh.num_neighbors == i + 1 ? '\\' : '|'));
+			head[sizeof(head) - 1] = '\0';
 
 			seqno_trace_print_neigh(seqno_trace->seqno_trace_neigh.seqno_trace_neigh[i],
 			                        NULL,
diff --git a/debugfs.c b/debugfs.c
index 549546c..9fc6f42 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -56,6 +56,7 @@ int debugfs_make_path(const char *fmt, char *mesh_iface, char *buffer, int size)
 		return len+1;
 
 	snprintf(buffer, size-1, fmt, debugfs_mountpoint, mesh_iface);
+	buffer[size - 1] = '\0';
 	return 0;
 }
 
diff --git a/sys.c b/sys.c
index 9591416..e4112b7 100644
--- a/sys.c
+++ b/sys.c
@@ -136,6 +136,7 @@ static int print_interfaces(char *mesh_iface)
 
 	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
+		path_buff[PATH_BUFF_LEN - 1] = '\0';
 		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 		if (res != EXIT_SUCCESS)
 			continue;
@@ -153,6 +154,7 @@ static int print_interfaces(char *mesh_iface)
 		line_ptr = NULL;
 
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
+		path_buff[PATH_BUFF_LEN - 1] = '\0';
 		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 		if (res != EXIT_SUCCESS) {
 			printf("<error reading status>\n");
@@ -216,9 +218,11 @@ int interface(char *mesh_iface, int argc, char **argv)
 
 	for (i = 2; i < argc; i++) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, argv[i]);
+		path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 		if (!file_exists(path_buff)) {
 			snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_DIR, argv[i]);
+			path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 			if (!file_exists(path_buff)) {
 				printf("Error - interface does not exist: %s\n", argv[i]);
@@ -288,6 +292,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 	if (argc != 1) {
 		for (i = 1; i < argc; i++) {
@@ -314,6 +319,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 		}
 
 		snprintf(str, sizeof(str), "%i", log_level);
+		str[sizeof(str) - 1] = '\0';
 		res = write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
 		goto out;
 	}
@@ -379,6 +385,7 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 	if (argc == 1) {
 		res = read_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
@@ -443,6 +450,7 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 	if (argc == 1) {
 		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
-- 
1.7.10.4

