Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  3 Oct 2012 19:31:15 +0200
Message-Id: <1349285475-9782-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Print compat version when querying
	the version
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c |   53 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/main.c b/main.c
index 01a435b..eaaec0a 100644
--- a/main.c
+++ b/main.c
@@ -31,6 +31,7 @@
 #include "main.h"
 #include "sys.h"
 #include "debug.h"
+#include "debugfs.h"
 #include "ping.h"
 #include "traceroute.h"
 #include "tcpdump.h"
@@ -42,6 +43,7 @@
 
 char mesh_dfl_iface[] = "bat0";
 char module_ver_path[] = "/sys/module/batman_adv/version";
+char module_compat_ver_file[] = "batman_adv/compat_version";
 
 void print_usage(void)
 {
@@ -90,6 +92,44 @@ void print_usage(void)
 #endif
 }
 
+static void print_version(void)
+{
+	int ret;
+	char *debugfs_mnt;
+
+	printf("batctl %s [", SOURCE_VERSION);
+
+	ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
+	if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
+		line_ptr[strlen(line_ptr) - 1] = '\0';
+
+	if (ret == EXIT_SUCCESS) {
+		printf("batman-adv: %s", line_ptr);
+	} else {
+		printf("module not loaded");
+		goto out;
+	}
+
+	free(line_ptr);
+	line_ptr = NULL;
+
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt)
+		goto out;
+
+	ret = read_file(debugfs_mnt, module_compat_ver_file, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
+	if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
+		line_ptr[strlen(line_ptr) - 1] = '\0';
+
+	if (ret == EXIT_SUCCESS)
+		printf(", compat: %s", line_ptr);
+
+out:
+	free(line_ptr);
+	line_ptr = NULL;
+	printf("]\n");
+}
+
 int main(int argc, char **argv)
 {
 	int i, ret = EXIT_FAILURE;
@@ -116,18 +156,7 @@ int main(int argc, char **argv)
 		goto err;
 
 	if (strcmp(argv[1], "-v") == 0) {
-		printf("batctl %s [batman-adv: ", SOURCE_VERSION);
-
-		ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
-		if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
-			line_ptr[strlen(line_ptr) - 1] = '\0';
-
-		if (ret == EXIT_SUCCESS)
-			printf("%s]\n", line_ptr);
-		else
-			printf("module not loaded]\n");
-
-		free(line_ptr);
+		print_version();
 		exit(EXIT_SUCCESS);
 	}
 
-- 
1.7.10.4

