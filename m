Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 12 Mar 2014 17:04:47 +0100
Message-Id: <1394640288-1611-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-next v3 1/2] batctl: check for batman
	interface
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Check if the interface supplied by -m (or bat0 by default) is actually a
batman interface. The check is performed by testing if the sysfs path
is available.

This change is required since debugfs now contains originator tables per
hard interface. This might be confusing for users as batctl -m eth0 o
will now (accidently) print these tables without eth0 beeing a batman
interface, assuming eth0 is a hard interface used by batman-adv.

Some reordering of commands were required to first allow commands which
don't depend on a (correctly set up) mesh interface, like bisect or
interface.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to PATCHv2:

 * fix VLAN check, this is now similar to the sysfs handling code
---
 main.c |   32 +++++++++++++++++---------------
 sys.c  |   30 ++++++++++++++++++++++++++++++
 sys.h  |    1 +
 3 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/main.c b/main.c
index a37c0b7..44cf49b 100644
--- a/main.c
+++ b/main.c
@@ -137,7 +137,23 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	if ((strcmp(argv[1], "ping") == 0) || (strcmp(argv[1], "p") == 0)) {
+	if ((strcmp(argv[1], "interface") == 0) || (strcmp(argv[1], "if") == 0)) {
+
+		ret = interface(mesh_iface, argc - 1, argv + 1);
+
+	} else if ((strcmp(argv[1], "tcpdump") == 0) || (strcmp(argv[1], "td") == 0)) {
+
+		ret = tcpdump(argc - 1, argv + 1);
+
+#ifdef BATCTL_BISECT
+	} else if ((strcmp(argv[1], "bisect_iv") == 0)) {
+
+		ret = bisect_iv(argc - 1, argv + 1);
+#endif
+	} else if (check_mesh_iface(mesh_iface) < 0) {
+		fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
+		exit(EXIT_FAILURE);
+	} else if ((strcmp(argv[1], "ping") == 0) || (strcmp(argv[1], "p") == 0)) {
 
 		ret = ping(mesh_iface, argc - 1, argv + 1);
 
@@ -145,14 +161,6 @@ int main(int argc, char **argv)
 
 		ret = traceroute(mesh_iface, argc - 1, argv + 1);
 
-	} else if ((strcmp(argv[1], "tcpdump") == 0) || (strcmp(argv[1], "td") == 0)) {
-
-		ret = tcpdump(argc - 1, argv + 1);
-
-	} else if ((strcmp(argv[1], "interface") == 0) || (strcmp(argv[1], "if") == 0)) {
-
-		ret = interface(mesh_iface, argc - 1, argv + 1);
-
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
 		ret = handle_loglevel(mesh_iface, argc - 1, argv + 1);
@@ -179,12 +187,6 @@ int main(int argc, char **argv)
 
 		ret = translate(mesh_iface, argc - 1, argv + 1);
 
-#ifdef BATCTL_BISECT
-	} else if ((strcmp(argv[1], "bisect_iv") == 0)) {
-
-		ret = bisect_iv(argc - 1, argv + 1);
-#endif
-
 	} else {
 
 		for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
diff --git a/sys.c b/sys.c
index fd6e107..0b98d82 100644
--- a/sys.c
+++ b/sys.c
@@ -566,3 +566,33 @@ out:
 	free(path_buff);
 	return res;
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
+	path_buff[PATH_BUFF_LEN - 1] = '\0';
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
diff --git a/sys.h b/sys.h
index 5633822..5aec020 100644
--- a/sys.h
+++ b/sys.h
@@ -71,5 +71,6 @@ int interface(char *mesh_iface, int argc, char **argv);
 int handle_loglevel(char *mesh_iface, int argc, char **argv);
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
 int handle_gw_setting(char *mesh_iface, int argc, char **argv);
+int check_mesh_iface(char *mesh_iface);
 
 #endif
-- 
1.7.10.4

