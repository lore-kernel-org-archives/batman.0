Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Sep 2016 17:58:03 +0200
Message-Id: <20160924155806.9115-4-sven@narfation.org>
In-Reply-To: <20160924155806.9115-1-sven@narfation.org>
References: <20160924155806.9115-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 4/7] batctl: Parse interface arguments
	relative to last parsed option
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

Arguments may be added between "interface" and the subcommands "add" and
"del". Thus is should not be hardcoded which positions of argv the
subcommands start and instead the information from getopt should be used to
calculate the correct position.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rename "new" command to "create" as requested by Linus Luessing and
   John Harrison

 sys.c | 51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/sys.c b/sys.c
index cefd53c..190fd06 100644
--- a/sys.c
+++ b/sys.c
@@ -383,6 +383,8 @@ int interface(char *mesh_iface, int argc, char **argv)
 	unsigned int ifmaster;
 	const char *long_op;
 	unsigned int cnt;
+	int rest_argc;
+	char **rest_argv;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -395,38 +397,41 @@ int interface(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
-	if (argc == 1)
+	rest_argc = argc - optind;
+	rest_argv = &argv[optind];
+
+	if (rest_argc == 0)
 		return print_interfaces(mesh_iface);
 
-	if ((strcmp(argv[1], "add") != 0) && (strcmp(argv[1], "a") != 0) &&
-	    (strcmp(argv[1], "del") != 0) && (strcmp(argv[1], "d") != 0) &&
-	    (strcmp(argv[1], "create") != 0) && (strcmp(argv[1], "c") != 0) &&
-	    (strcmp(argv[1], "destroy") != 0) && (strcmp(argv[1], "D") != 0)) {
-		fprintf(stderr, "Error - unknown argument specified: %s\n", argv[1]);
+	if ((strcmp(rest_argv[0], "add") != 0) && (strcmp(rest_argv[0], "a") != 0) &&
+	    (strcmp(rest_argv[0], "del") != 0) && (strcmp(rest_argv[0], "d") != 0) &&
+	    (strcmp(rest_argv[0], "create") != 0) && (strcmp(rest_argv[0], "c") != 0) &&
+	    (strcmp(rest_argv[0], "destroy") != 0) && (strcmp(rest_argv[0], "D") != 0)) {
+		fprintf(stderr, "Error - unknown argument specified: %s\n", rest_argv[0]);
 		interface_usage();
 		goto err;
 	}
 
-	if (strcmp(argv[1], "destroy") == 0)
-		argv[1][0] = 'D';
+	if (strcmp(rest_argv[0], "destroy") == 0)
+		rest_argv[0][0] = 'D';
 
-	switch (argv[1][0]) {
+	switch (rest_argv[0][0]) {
 	case 'a':
 	case 'd':
-		if (argc == 2) {
+		if (rest_argc == 1) {
 			fprintf(stderr,
 				"Error - missing interface name(s) after '%s'\n",
-				argv[1]);
+				rest_argv[0]);
 			interface_usage();
 			goto err;
 		}
 		break;
 	case 'c':
 	case 'D':
-		if (argc != 2) {
+		if (rest_argc != 1) {
 			fprintf(stderr,
 				"Error - extra parameter after '%s'\n",
-				argv[1]);
+				rest_argv[0]);
 			interface_usage();
 			goto err;
 		}
@@ -435,7 +440,7 @@ int interface(char *mesh_iface, int argc, char **argv)
 		break;
 	}
 
-	switch (argv[1][0]) {
+	switch (rest_argv[0][0]) {
 	case 'c':
 		ret = create_interface(mesh_iface);
 		if (ret < 0) {
@@ -460,7 +465,7 @@ int interface(char *mesh_iface, int argc, char **argv)
 
 	/* get index of batman-adv interface - or try to create it */
 	ifmaster = if_nametoindex(mesh_iface);
-	if (!ifmaster && argv[1][0] == 'a') {
+	if (!ifmaster && rest_argv[0][0] == 'a') {
 		ret = create_interface(mesh_iface);
 		if (ret < 0) {
 			fprintf(stderr,
@@ -486,34 +491,34 @@ int interface(char *mesh_iface, int argc, char **argv)
 		goto err;
 	}
 
-	for (i = 2; i < argc; i++) {
-		ifindex = if_nametoindex(argv[i]);
+	for (i = 1; i < rest_argc; i++) {
+		ifindex = if_nametoindex(rest_argv[i]);
 
 		if (!ifindex) {
-			fprintf(stderr, "Error - interface does not exist: %s\n", argv[i]);
+			fprintf(stderr, "Error - interface does not exist: %s\n", rest_argv[i]);
 			continue;
 		}
 
-		if (argv[1][0] == 'a')
+		if (rest_argv[0][0] == 'a')
 			ifindex = ifmaster;
 		else
 			ifindex = 0;
 
-		ret = set_master_interface(argv[i], ifindex);
+		ret = set_master_interface(rest_argv[i], ifindex);
 		if (ret < 0) {
-			if (argv[1][0] == 'a')
+			if (rest_argv[0][0] == 'a')
 				long_op = "add";
 			else
 				long_op = "delete";
 
 			fprintf(stderr, "Error - failed to %s interface %s: %s\n",
-				long_op, argv[i], strerror(-ret));
+				long_op, rest_argv[i], strerror(-ret));
 			goto err;
 		}
 	}
 
 	/* check if there is no interface left and then destroy mesh_iface */
-	if (argv[1][0] == 'd') {
+	if (rest_argv[0][0] == 'd') {
 		cnt = count_interfaces(mesh_iface);
 		if (cnt == 0)
 			destroy_interface(mesh_iface);
-- 
2.9.3

