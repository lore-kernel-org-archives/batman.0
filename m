Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun,  6 Nov 2011 20:10:00 +0800
Message-Id: <1320581400-8228-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1320581400-8228-1-git-send-email-lindner_marek@yahoo.de>
References: <1320581400-8228-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: remove unused SINGLE_READ flag
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
 functions.h |    2 +-
 sys.c       |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/functions.h b/functions.h
index 90fc831..7e9f68c 100644
--- a/functions.h
+++ b/functions.h
@@ -40,7 +40,7 @@ int write_file(char *dir, char *fname, char *arg1, char *arg2);
 extern char *line_ptr;
 
 enum {
-	SINGLE_READ = 0x00,
+	NO_FLAGS = 0x00,
 	CONT_READ = 0x01,
 	CLR_CONT_READ = 0x02,
 	USE_BAT_HOSTS = 0x04,
diff --git a/sys.c b/sys.c
index 4f2b2c5..14fc577 100644
--- a/sys.c
+++ b/sys.c
@@ -79,7 +79,7 @@ static int print_interfaces(char *mesh_iface)
 
 	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
+		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
 		if (res != EXIT_SUCCESS)
 			continue;
 
@@ -96,7 +96,7 @@ static int print_interfaces(char *mesh_iface)
 		line_ptr = NULL;
 
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
+		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
 		if (res != EXIT_SUCCESS) {
 			printf("<error reading status>\n");
 			continue;
@@ -204,7 +204,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 		goto out;
 	}
 
-	res = read_file(path_buff, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF, 0, 0);
+	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0);
 
 	if (res != EXIT_SUCCESS)
 		goto out;
@@ -300,7 +300,7 @@ int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	if (argc == 1) {
-		res = read_file(path_buff, file_path, SINGLE_READ, 0, 0);
+		res = read_file(path_buff, file_path, NO_FLAGS, 0, 0);
 		goto out;
 	}
 
@@ -355,7 +355,7 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	if (argc == 1) {
-		res = read_file(path_buff, SYS_GW_MODE, SINGLE_READ | USE_READ_BUFF, 0, 0);
+		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0);
 
 		if (res != EXIT_SUCCESS)
 			goto out;
@@ -375,10 +375,10 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 
 		switch (gw_mode) {
 		case GW_MODE_CLIENT:
-			res = read_file(path_buff, SYS_GW_SEL, SINGLE_READ | USE_READ_BUFF, 0, 0);
+			res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0);
 			break;
 		case GW_MODE_SERVER:
-			res = read_file(path_buff, SYS_GW_BW, SINGLE_READ | USE_READ_BUFF, 0, 0);
+			res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0);
 			break;
 		default:
 			printf("off\n");
-- 
1.7.5.4

