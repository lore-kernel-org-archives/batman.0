Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:46:59 +0200
Message-Id: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/10] alfred: vis: Fix parsing of
	iface_status
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

The content of batman_adv/iface_status ends with a newline. Thus
register_interfaces has to make sure that it only compares the first line
without the \n when comparing with the status string.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/vis.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/vis/vis.c b/vis/vis.c
index 4d494bc..7eab781 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -257,6 +257,7 @@ static int register_interfaces(struct globals *globals)
 	DIR *iface_base_dir;
 	struct dirent *iface_dir;
 	char *path_buff, *file_content;
+	char *content_newline;
 
 	path_buff = malloc(PATH_BUFF_LEN);
 	if (!path_buff) {
@@ -295,6 +296,10 @@ static int register_interfaces(struct globals *globals)
 		if (!file_content)
 			continue;
 
+		content_newline = strstr(file_content, "\n");
+		if (content_newline)
+			*content_newline = '\0';
+
 		if (strcmp(file_content, "active") == 0)
 			get_if_index(globals, iface_dir->d_name);
 
-- 
2.8.1

