Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Jun 2012 03:39:41 +0800
Message-Id: <1339789181-27122-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: check interface support and print
	corresponding error message
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
 functions.c |    7 +++++++
 functions.h |    1 +
 main.h      |    2 ++
 sys.c       |   17 +++++++++++++++++
 sys.h       |    1 +
 5 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/functions.c b/functions.c
index 8ce2419..36a4d40 100644
--- a/functions.c
+++ b/functions.c
@@ -107,6 +107,13 @@ char *get_name_by_macstr(char *mac_str, int read_opt)
 	return get_name_by_macaddr(mac_addr, read_opt);
 }
 
+int file_exists(const char *fpath)
+{
+	struct stat st;
+
+	return stat(fpath, &st) == 0;
+}
+
 static int check_sys_dir(char *dir)
 {
 	struct stat st;
diff --git a/functions.h b/functions.h
index fe03dc0..92d6ae5 100644
--- a/functions.h
+++ b/functions.h
@@ -33,6 +33,7 @@ double end_timer(void);
 char *ether_ntoa_long(const struct ether_addr *addr);
 char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
+int file_exists(const char *fpath);
 int read_file(char *dir, char *path, int read_opt,
 	      float orig_timeout, float watch_interval);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
diff --git a/main.h b/main.h
index 872a2fe..4819cf4 100644
--- a/main.h
+++ b/main.h
@@ -28,3 +28,5 @@
 #define EXIT_NOSUCCESS 2
 
 #define __packed __attribute((packed))   /* linux kernel compat */
+
+extern char module_ver_path[];
diff --git a/sys.c b/sys.c
index 0b4cac3..5702c6c 100644
--- a/sys.c
+++ b/sys.c
@@ -154,6 +154,23 @@ int interface(char *mesh_iface, int argc, char **argv)
 	for (i = 2; i < argc; i++) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, argv[i]);
 
+		if (!file_exists(path_buff)) {
+			snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_DIR, argv[i]);
+
+			if (!file_exists(path_buff)) {
+				printf("Error - interface does not exist: %s\n", argv[i]);
+				continue;
+			}
+
+			if (!file_exists(module_ver_path)) {
+				printf("Error - batman-adv module has not been loaded\n");
+				goto err;
+			}
+
+			printf("Error - interface type not supported by batman-adv: %s\n", argv[i]);
+			continue;
+		}
+
 		if (argv[1][0] == 'a')
 			res = write_file("", path_buff, mesh_iface, NULL);
 		else
diff --git a/sys.h b/sys.h
index 46a1159..f48902e 100644
--- a/sys.h
+++ b/sys.h
@@ -32,6 +32,7 @@
 #define SYS_VIS_MODE "vis_mode"
 #define SYS_ORIG_INTERVAL "orig_interval"
 #define SYS_IFACE_PATH "/sys/class/net"
+#define SYS_IFACE_DIR SYS_IFACE_PATH"/%s/"
 #define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 #define SYS_FRAG "fragmentation"
-- 
1.7.9.1

