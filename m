Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun,  6 Nov 2011 20:09:59 +0800
Message-Id: <1320581400-8228-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: version also prints the kernel
	module version if available
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
 main.c       |   15 ++++++++++++++-
 man/batctl.8 |    2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index a1e6f4d..7f6d1a3 100644
--- a/main.c
+++ b/main.c
@@ -36,9 +36,11 @@
 #include "tcpdump.h"
 #include "bisect.h"
 #include "vis.h"
+#include "functions.h"
 #include <err.h>
 
 char mesh_dfl_iface[] = "bat0";
+char module_ver_path[] = "/sys/module/batman_adv/version";
 
 void print_usage(void) {
 	printf("Usage: batctl [options] commands \n");
@@ -96,7 +98,18 @@ int main(int argc, char **argv)
 		goto err;
 
 	if (strcmp(argv[1], "-v") == 0) {
-		printf("batctl %s\n", SOURCE_VERSION);
+		printf("batctl %s [batman-adv: ", SOURCE_VERSION);
+
+		ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
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
 
diff --git a/man/batctl.8 b/man/batctl.8
index b0c6fc6..928c7e3 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -51,7 +51,7 @@ protocol.
 .br
 \-h     print general batctl help
 .br
-\-v     print batctl version
+\-v     print batctl version and batman-adv version (if the module is loaded)
 .br
 .TP
 .I \fBcommands:
-- 
1.7.5.4

