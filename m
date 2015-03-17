Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Mar 2015 08:47:29 +0100
Message-Id: <1426578449-2780-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Remove manual \0 terminator after
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
 debugfs.c | 1 -
 vis/vis.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index fbf992e..6404b49 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -58,7 +58,6 @@ int debugfs_make_path(const char *fmt, const char *mesh_iface, char *buffer,
 		return len+1;
 
 	snprintf(buffer, size-1, fmt, debugfs_mountpoint, mesh_iface);
-	buffer[size - 1] = '\0';
 	return 0;
 }
 
diff --git a/vis/vis.c b/vis/vis.c
index 4a14e66..c1f8dad 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -274,7 +274,6 @@ static int register_interfaces(struct globals *globals)
 
 	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
-		path_buff[PATH_BUFF_LEN - 1] = '\0';
 		file_content = read_file(path_buff);
 		if (!file_content)
 			continue;
@@ -292,7 +291,6 @@ static int register_interfaces(struct globals *globals)
 		file_content = NULL;
 
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
-		path_buff[PATH_BUFF_LEN - 1] = '\0';
 		file_content = read_file(path_buff);
 		if (!file_content)
 			continue;
@@ -328,7 +326,6 @@ static int parse_orig_list(struct globals *globals)
 	struct vis_list_entry *v_entry;
 
 	snprintf(path, sizeof(path), "/sys/kernel/debug/batman_adv/%s/originators", globals->interface);
-	path[sizeof(path) - 1] = 0;
 	fbuf = read_file(path);
 	if (!fbuf)
 		return -1;
-- 
2.1.4

