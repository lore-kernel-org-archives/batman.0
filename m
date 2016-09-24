Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Sep 2016 17:58:06 +0200
Message-Id: <20160924155806.9115-7-sven@narfation.org>
In-Reply-To: <20160924155806.9115-1-sven@narfation.org>
References: <20160924155806.9115-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 7/7] batctl: Move check_mesh_iface* to
	functions.c
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

The check_mesh_iface* functions are not used to modify anything in sysfs.
So they are better placed in the common/shared functions file than in
sys.c.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - no change

 functions.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 functions.h |  2 ++
 sys.c       | 56 --------------------------------------------------------
 sys.h       |  2 --
 4 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/functions.c b/functions.c
index 962efcf..f9feca4 100644
--- a/functions.c
+++ b/functions.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <dirent.h>
 #include <sys/time.h>
 #include <netinet/in.h>
 #include <stdint.h>
@@ -56,6 +57,8 @@
 #include "debugfs.h"
 #include "netlink.h"
 
+#define PATH_BUFF_LEN 200
+
 static struct timeval start_time;
 static char *host_name;
 char *line_ptr = NULL;
@@ -1011,3 +1014,59 @@ err_free_sock:
 
 	return err;
 }
+
+int check_mesh_iface(char *mesh_iface)
+{
+	char *base_dev = NULL;
+	char path_buff[PATH_BUFF_LEN];
+	int ret = -1, vid;
+	DIR *dir;
+
+	/* use the parent interface if this is a VLAN */
+	vid = vlan_get_link(mesh_iface, &base_dev);
+	if (vid >= 0)
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
+	else
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+
+	/* try to open the mesh sys directory */
+	dir = opendir(path_buff);
+	if (!dir)
+		goto out;
+
+	closedir(dir);
+
+	ret = 0;
+out:
+	if (base_dev)
+		free(base_dev);
+
+	return ret;
+}
+
+int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface)
+{
+	char path_buff[PATH_BUFF_LEN];
+	int res;
+
+	/* check if this device actually belongs to the mesh interface */
+	snprintf(path_buff, sizeof(path_buff), SYS_MESH_IFACE_FMT, hard_iface);
+	res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+	if (res != EXIT_SUCCESS) {
+		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
+			path_buff, strerror(errno));
+		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
+		return EXIT_FAILURE;
+	}
+
+	if (line_ptr[strlen(line_ptr) - 1] == '\n')
+		line_ptr[strlen(line_ptr) - 1] = '\0';
+
+	if (strcmp(line_ptr, mesh_iface) != 0) {
+		fprintf(stderr, "Error - interface %s is part of batman network %s, not %s\n",
+			hard_iface, line_ptr, mesh_iface);
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
diff --git a/functions.h b/functions.h
index 4c350f8..e413d6b 100644
--- a/functions.h
+++ b/functions.h
@@ -50,6 +50,8 @@ struct ether_addr *resolve_mac(const char *asc);
 int vlan_get_link(const char *ifname, char **parent);\
 int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg);
 int netlink_simple_request(struct nl_msg *msg);
+int check_mesh_iface(char *mesh_iface);
+int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
 int print_routing_algos(void);
 extern char *line_ptr;
diff --git a/sys.c b/sys.c
index 59cbdae..b524340 100644
--- a/sys.c
+++ b/sys.c
@@ -511,59 +511,3 @@ free_buff:
 out:
 	return res;
 }
-
-int check_mesh_iface(char *mesh_iface)
-{
-	char *base_dev = NULL;
-	char path_buff[PATH_BUFF_LEN];
-	int ret = -1, vid;
-	DIR *dir;
-
-	/* use the parent interface if this is a VLAN */
-	vid = vlan_get_link(mesh_iface, &base_dev);
-	if (vid >= 0)
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
-	else
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
-
-	/* try to open the mesh sys directory */
-	dir = opendir(path_buff);
-	if (!dir)
-		goto out;
-
-	closedir(dir);
-
-	ret = 0;
-out:
-	if (base_dev)
-		free(base_dev);
-
-	return ret;
-}
-
-int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface)
-{
-	char path_buff[PATH_BUFF_LEN];
-	int res;
-
-	/* check if this device actually belongs to the mesh interface */
-	snprintf(path_buff, sizeof(path_buff), SYS_MESH_IFACE_FMT, hard_iface);
-	res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
-	if (res != EXIT_SUCCESS) {
-		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
-			path_buff, strerror(errno));
-		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
-		return EXIT_FAILURE;
-	}
-
-	if (line_ptr[strlen(line_ptr) - 1] == '\n')
-		line_ptr[strlen(line_ptr) - 1] = '\0';
-
-	if (strcmp(line_ptr, mesh_iface) != 0) {
-		fprintf(stderr, "Error - interface %s is part of batman network %s, not %s\n",
-			hard_iface, line_ptr, mesh_iface);
-		return EXIT_FAILURE;
-	}
-
-	return EXIT_SUCCESS;
-}
diff --git a/sys.h b/sys.h
index be9480e..1365e76 100644
--- a/sys.h
+++ b/sys.h
@@ -74,7 +74,5 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv);
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
 int handle_gw_setting(char *mesh_iface, int argc, char **argv);
 int handle_ra_setting(int argc, char **argv);
-int check_mesh_iface(char *mesh_iface);
-int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
 #endif
-- 
2.9.3

