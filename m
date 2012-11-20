Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 20 Nov 2012 20:59:36 +0100
Message-Id: <1353441576-4081-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH batctl-next] Revert "batctl: Print compat
	version when querying the version"
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

This reverts commit a88e6b7b938ae201deba074e819b299ebb1c165f.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

Thanks Sven!



 main.c | 53 ++++++++++++-----------------------------------------
 1 file changed, 12 insertions(+), 41 deletions(-)

diff --git a/main.c b/main.c
index e239b2a..5d85d8b 100644
--- a/main.c
+++ b/main.c
@@ -31,7 +31,6 @@
 #include "main.h"
 #include "sys.h"
 #include "debug.h"
-#include "debugfs.h"
 #include "ping.h"
 #include "translate.h"
 #include "traceroute.h"
@@ -44,7 +43,6 @@
 
 char mesh_dfl_iface[] = "bat0";
 char module_ver_path[] = "/sys/module/batman_adv/version";
-char module_compat_ver_file[] = "batman_adv/compat_version";
 
 void print_usage(void)
 {
@@ -94,44 +92,6 @@ void print_usage(void)
 #endif
 }
 
-static void print_version(void)
-{
-	int ret;
-	char *debugfs_mnt;
-
-	printf("batctl %s [", SOURCE_VERSION);
-
-	ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
-	if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
-		line_ptr[strlen(line_ptr) - 1] = '\0';
-
-	if (ret == EXIT_SUCCESS) {
-		printf("batman-adv: %s", line_ptr);
-	} else {
-		printf("module not loaded");
-		goto out;
-	}
-
-	free(line_ptr);
-	line_ptr = NULL;
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt)
-		goto out;
-
-	ret = read_file(debugfs_mnt, module_compat_ver_file, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
-	if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
-		line_ptr[strlen(line_ptr) - 1] = '\0';
-
-	if (ret == EXIT_SUCCESS)
-		printf(", compat: %s", line_ptr);
-
-out:
-	free(line_ptr);
-	line_ptr = NULL;
-	printf("]\n");
-}
-
 int main(int argc, char **argv)
 {
 	int i, ret = EXIT_FAILURE;
@@ -158,7 +118,18 @@ int main(int argc, char **argv)
 		goto err;
 
 	if (strcmp(argv[1], "-v") == 0) {
-		print_version();
+		printf("batctl %s [batman-adv: ", SOURCE_VERSION);
+
+		ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+		if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
+			line_ptr[strlen(line_ptr) - 1] = '\0';
+
+		if (ret == EXIT_SUCCESS)
+			printf("%s]\n", line_ptr);
+		else
+			printf("module not loaded]\n");
+
+		free(line_ptr);
 		exit(EXIT_SUCCESS);
 	}
 
-- 
1.8.0

