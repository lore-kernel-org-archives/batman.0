Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:54:58 +0200
Message-Id: <20181021225524.8155-13-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 12/38] batctl: Use getopt to parse main
 options
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

The handwritten option parser is rather fragile and doesn't support all
features of a normal commandline option parser. Instead use getopt to
handle the most critical parts and keep it more flexible.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 95 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 39 deletions(-)

diff --git a/main.c b/main.c
index fa4371c..f5df477 100644
--- a/main.c
+++ b/main.c
@@ -22,6 +22,7 @@
 
 
 
+#include <getopt.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -87,6 +88,25 @@ static void print_usage(void)
 #endif
 }
 
+static void version(void)
+{
+	int ret;
+
+	printf("batctl %s [batman-adv: ", SOURCE_VERSION);
+
+	ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+	if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
+		line_ptr[strlen(line_ptr) - 1] = '\0';
+
+	if (ret == EXIT_SUCCESS)
+		printf("%s]\n", line_ptr);
+	else
+		printf("module not loaded]\n");
+
+	free(line_ptr);
+	exit(EXIT_SUCCESS);
+}
+
 static const struct command *find_command(const char *name)
 {
 	const struct command **p;
@@ -109,53 +129,48 @@ int main(int argc, char **argv)
 	const struct command *cmd;
 	int i, ret = EXIT_FAILURE;
 	char *mesh_iface = mesh_dfl_iface;
-
-	if ((argc > 1) && (strcmp(argv[1], "-m") == 0)) {
-		if (argc < 3) {
-			fprintf(stderr, "Error - the option '-m' needs a parameter\n");
+	int opt;
+
+	while ((opt = getopt(argc, argv, "+hm:v")) != -1) {
+		switch (opt) {
+		case 'h':
+			print_usage();
+			exit(EXIT_SUCCESS);
+			break;
+		case 'm':
+			if (mesh_iface != mesh_dfl_iface) {
+				fprintf(stderr,
+					"Error - multiple mesh interfaces specified\n");
+				goto err;
+			}
+
+			mesh_iface = argv[2];
+			break;
+		case 'v':
+			version();
+			break;
+		default:
 			goto err;
 		}
-
-		mesh_iface = argv[2];
-
-		argv += 2;
-		argc -= 2;
 	}
 
-	if (argc < 2) {
+	if (optind >= argc) {
 		fprintf(stderr, "Error - no command specified\n");
 		goto err;
 	}
 
-	if (strcmp(argv[1], "-h") == 0) {
-		print_usage();
-		exit(EXIT_SUCCESS);
-	}
-
-	if (strcmp(argv[1], "-v") == 0) {
-		printf("batctl %s [batman-adv: ", SOURCE_VERSION);
-
-		ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
-		if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
-			line_ptr[strlen(line_ptr) - 1] = '\0';
-
-		if (ret == EXIT_SUCCESS)
-			printf("%s]\n", line_ptr);
-		else
-			printf("module not loaded]\n");
-
-		free(line_ptr);
-		exit(EXIT_SUCCESS);
-	}
+	argv += optind;
+	argc -= optind;
+	optind = 0;
 
-	if ((cmd = find_command(argv[1]))) {
+	if ((cmd = find_command(argv[0]))) {
 		if (cmd->flags & COMMAND_FLAG_MESH_IFACE &&
 		    check_mesh_iface(mesh_iface) < 0) {
 			fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
 			exit(EXIT_FAILURE);
 		}
 
-		ret = cmd->handler(mesh_iface, argc - 1, argv + 1);
+		ret = cmd->handler(mesh_iface, argc, argv);
 	} else {
 		if (check_mesh_iface(mesh_iface) < 0) {
 			fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
@@ -163,24 +178,26 @@ int main(int argc, char **argv)
 		}
 
 		for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
-			if ((strcmp(argv[1], batctl_settings[i].opt_long) != 0) &&
-			    (strcmp(argv[1], batctl_settings[i].opt_short) != 0))
+			if ((strcmp(argv[0], batctl_settings[i].opt_long) != 0) &&
+			    (strcmp(argv[0], batctl_settings[i].opt_short) != 0))
 				continue;
 
-			ret = handle_sys_setting(mesh_iface, i, argc - 1, argv + 1);
+			ret = handle_sys_setting(mesh_iface, i, argc, argv);
 			goto out;
 		}
 
 		for (i = 0; i < BATCTL_TABLE_NUM; i++) {
-			if ((strcmp(argv[1], batctl_debug_tables[i].opt_long) != 0) &&
-			    (strcmp(argv[1], batctl_debug_tables[i].opt_short) != 0))
+			if ((strcmp(argv[0], batctl_debug_tables[i].opt_long) != 0) &&
+			    (strcmp(argv[0], batctl_debug_tables[i].opt_short) != 0))
 				continue;
 
-			ret = handle_debug_table(mesh_iface, i, argc - 1, argv + 1);
+			ret = handle_debug_table(mesh_iface, i, argc, argv);
 			goto out;
 		}
 
-		fprintf(stderr, "Error - no valid command or debug table specified: %s\n", argv[1]);
+		fprintf(stderr,
+			"Error - no valid command or debug table specified: %s\n",
+			argv[0]);
 		print_usage();
 	}
 
-- 
2.19.1

