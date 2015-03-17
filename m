Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Mar 2015 08:50:25 +0100
Message-Id: <1426578625-3113-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Remove manual \0 terminator after
	snprintf
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
Cc: Sven Eckelmann <sven@narfation.org>

snprintf already guarantees \0 terminated strings for size arguments is > 0.

Reported-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c |  4 ----
 debugfs.c   |  1 -
 sys.c       | 14 +-------------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index b748813..fea6358 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -644,7 +644,6 @@ static int print_rt_path_at_seqno(struct bat_node *src_node, struct bat_node *ds
 
 	snprintf(curr_loop_magic, sizeof(curr_loop_magic), "%s%s%lli%lli", src_node->name,
 	         dst_node->name, seqno, seqno_rand);
-	curr_loop_magic[sizeof(curr_loop_magic) - 1] = '\0';
 
 	printf("Path towards %s (seqno %lli ",
 	       get_name_by_macstr(dst_node->name, read_opt), seqno);
@@ -725,7 +724,6 @@ static int find_rt_table_change(struct bat_node *src_node, struct bat_node *dst_
 	snprintf(curr_loop_magic, sizeof(curr_loop_magic), "%s%s%lli%lli",
 	         src_node->name, dst_node->name,
 	         seqno_min_tmp, seqno_rand);
-	curr_loop_magic[sizeof(curr_loop_magic) - 1] = '\0';
 
 	orig_event = orig_event_get_by_ptr(curr_node, dst_node);
 	if (!orig_event)
@@ -982,7 +980,6 @@ static void seqno_trace_print_neigh(struct seqno_trace_neigh *seqno_trace_neigh,
 		         (strlen(head) > 1 ? head : num_sisters == 0 ? " " : head),
 		         (strlen(head) == 1 ? "   " :
 		         num_sisters == 0 ? "    " : "|   "));
-		new_head[sizeof(new_head) - 1] = '\0';
 
 		seqno_trace_print_neigh(seqno_trace_neigh->seqno_trace_neigh[i], seqno_trace_neigh->seqno_event,
 		                        seqno_trace_neigh->num_neighbors - i - 1, new_head, read_opt);
@@ -1028,7 +1025,6 @@ static void seqno_trace_print(struct list_head_first *trace_list, char *trace_or
 
 			snprintf(head, sizeof(head), "%c",
 			         (seqno_trace->seqno_trace_neigh.num_neighbors == i + 1 ? '\\' : '|'));
-			head[sizeof(head) - 1] = '\0';
 
 			seqno_trace_print_neigh(seqno_trace->seqno_trace_neigh.seqno_trace_neigh[i],
 			                        NULL,
diff --git a/debugfs.c b/debugfs.c
index 7b3a4b2..04e47e9 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -54,7 +54,6 @@ int debugfs_make_path(const char *fmt, char *mesh_iface, char *buffer, int size)
 		return len+1;
 
 	snprintf(buffer, size-1, fmt, debugfs_mountpoint, mesh_iface);
-	buffer[size - 1] = '\0';
 	return 0;
 }
 
diff --git a/sys.c b/sys.c
index 676bef1..0d7f55f 100644
--- a/sys.c
+++ b/sys.c
@@ -146,7 +146,6 @@ static int print_interfaces(char *mesh_iface)
 
 	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
-		path_buff[PATH_BUFF_LEN - 1] = '\0';
 		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 		if (res != EXIT_SUCCESS)
 			continue;
@@ -164,7 +163,6 @@ static int print_interfaces(char *mesh_iface)
 		line_ptr = NULL;
 
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
-		path_buff[PATH_BUFF_LEN - 1] = '\0';
 		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 		if (res != EXIT_SUCCESS) {
 			fprintf(stderr, "<error reading status>\n");
@@ -228,11 +226,9 @@ int interface(char *mesh_iface, int argc, char **argv)
 
 	for (i = 2; i < argc; i++) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, argv[i]);
-		path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 		if (!file_exists(path_buff)) {
 			snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_DIR, argv[i]);
-			path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 			if (!file_exists(path_buff)) {
 				fprintf(stderr, "Error - interface does not exist: %s\n", argv[i]);
@@ -303,7 +299,6 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
-	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 	if (argc != 1) {
 		for (i = 1; i < argc; i++) {
@@ -332,7 +327,6 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 		}
 
 		snprintf(str, sizeof(str), "%i", log_level);
-		str[sizeof(str) - 1] = '\0';
 		res = write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
 		goto out;
 	}
@@ -401,16 +395,13 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 	/* prepare the classic path */
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
-	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 	/* if the specified interface is a VLAN then change the path to point
 	 * to the proper "vlan%{vid}" subfolder in the sysfs tree.
 	 */
 	vid = vlan_get_link(mesh_iface, &base_dev);
-	if (vid >= 0) {
+	if (vid >= 0)
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
-		path_buff[PATH_BUFF_LEN - 1] = '\0';
-	}
 
 	if (argc == 1) {
 		res = read_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
@@ -476,7 +467,6 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
-	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 	if (argc == 1) {
 		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
@@ -586,7 +576,6 @@ int check_mesh_iface(char *mesh_iface)
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
 	else
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
-	path_buff[PATH_BUFF_LEN - 1] = '\0';
 
 	/* try to open the mesh sys directory */
 	dir = opendir(path_buff);
@@ -610,7 +599,6 @@ int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface)
 
 	/* check if this device actually belongs to the mesh interface */
 	snprintf(path_buff, sizeof(path_buff), SYS_MESH_IFACE_FMT, hard_iface);
-	path_buff[sizeof(path_buff) - 1] = '\0';
 	res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 	if (res != EXIT_SUCCESS) {
 		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
-- 
2.1.4

