Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 Jul 2014 11:51:59 +0200
Message-Id: <1406281919-25318-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Make unix socket path configurable
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
Cc: Sven Eckelmann <sven@narfation.org>

The path to the socket used for client-server communication is currently
hardcoded in alfred and its complimentary daemons. This makes it hard to run
two instances of alfred on the same machine without any kind of virtualization
or containers.

An user may still want to use two alfred instances to create a test setup or
connect a single machine two separated alfred data clouds without exchanging
data between them.

Reported-by: Tobias Hachmer <tobias@hachmer.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h               |  7 ++++---
 client.c               |  6 +++---
 gpsd/alfred-gpsd.c     |  9 +++++++--
 gpsd/alfred-gpsd.h     |  3 ++-
 gpsd/man/alfred-gpsd.8 |  3 +++
 main.c                 |  8 +++++++-
 man/alfred.8           |  3 +++
 server.c               |  2 +-
 unix_sock.c            | 10 +++++-----
 vis/man/batadv-vis.8   |  3 +++
 vis/vis.c              | 10 ++++++++--
 vis/vis.h              |  3 ++-
 12 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/alfred.h b/alfred.h
index f0dbb6d..35ac4dd 100644
--- a/alfred.h
+++ b/alfred.h
@@ -35,7 +35,7 @@
 #define ALFRED_REQUEST_TIMEOUT		10
 #define ALFRED_SERVER_TIMEOUT		60
 #define ALFRED_DATA_TIMEOUT		600
-#define ALFRED_SOCK_PATH		"/var/run/alfred.sock"
+#define ALFRED_SOCK_PATH_DEFAULT	"/var/run/alfred.sock"
 #define NO_FILTER			-1
 
 enum data_source {
@@ -102,6 +102,7 @@ struct globals {
 
 	int netsock;
 	int unix_sock;
+	const char *unix_path;
 
 	struct timespec if_check;
 
@@ -144,8 +145,8 @@ ssize_t send_alfred_packet(struct globals *globals, const struct in6_addr *dest,
 			   void *buf, int length);
 /* unix_sock.c */
 int unix_sock_read(struct globals *globals);
-int unix_sock_open_daemon(struct globals *globals, const char *path);
-int unix_sock_open_client(struct globals *globals, const char *path);
+int unix_sock_open_daemon(struct globals *globals);
+int unix_sock_open_client(struct globals *globals);
 int unix_sock_close(struct globals *globals);
 int unix_sock_req_data_finish(struct globals *globals,
 			      struct transaction_head *head);
diff --git a/client.c b/client.c
index cbc6867..b868719 100644
--- a/client.c
+++ b/client.c
@@ -40,7 +40,7 @@ int alfred_client_request_data(struct globals *globals)
 	int ret, len, data_len, i;
 	const size_t buf_data_len = sizeof(buf) - sizeof(*push) - sizeof(*data);
 
-	if (unix_sock_open_client(globals, ALFRED_SOCK_PATH))
+	if (unix_sock_open_client(globals))
 		return -1;
 
 	request = (struct alfred_request_v0 *)buf;
@@ -146,7 +146,7 @@ int alfred_client_set_data(struct globals *globals)
 	struct alfred_data *data;
 	int ret, len;
 
-	if (unix_sock_open_client(globals, ALFRED_SOCK_PATH))
+	if (unix_sock_open_client(globals))
 		return -1;
 
 	push = (struct alfred_push_data_v0 *)buf;
@@ -187,7 +187,7 @@ int alfred_client_modeswitch(struct globals *globals)
 	struct alfred_modeswitch_v0 *modeswitch;
 	int ret, len;
 
-	if (unix_sock_open_client(globals, ALFRED_SOCK_PATH))
+	if (unix_sock_open_client(globals))
 		return -1;
 
 	modeswitch = (struct alfred_modeswitch_v0 *)buf;
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 87943bd..06c0680 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -36,7 +36,7 @@ static int alfred_open_sock(struct globals *globals)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_LOCAL;
-	strncpy(addr.sun_path, ALFRED_SOCK_PATH, sizeof(addr.sun_path));
+	strncpy(addr.sun_path, globals->unix_path, sizeof(addr.sun_path));
 	addr.sun_path[sizeof(addr.sun_path) - 1] = '\0';
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
@@ -399,6 +399,7 @@ static struct globals *gpsd_init(int argc, char *argv[])
 		{"server",	no_argument,		NULL,	's'},
 		{"location",    required_argument,	NULL,	'l'},
 		{"gpsd",	required_argument,	NULL,	'g'},
+		{"unix-path", 	required_argument,	NULL,	'u'},
 		{"help",	no_argument,		NULL,	'h'},
 		{"version",	no_argument,		NULL,	'v'},
 		{NULL,		0,			NULL,	0},
@@ -410,8 +411,9 @@ static struct globals *gpsd_init(int argc, char *argv[])
 	globals->opmode = OPMODE_CLIENT;
 	globals->source = SOURCE_GPSD;
 	globals->gpsd_format = FORMAT_JSON;
+	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
 
-	while ((opt = getopt_long(argc, argv, "shl:g:v", long_options,
+	while ((opt = getopt_long(argc, argv, "shl:g:vu:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 's':
@@ -425,6 +427,9 @@ static struct globals *gpsd_init(int argc, char *argv[])
 			gpsd_source_spec(optarg, &globals->gpsdsource);
 			have_source = true;
 			break;
+		case 'u':
+			globals->unix_path = optarg;
+			break;
 		case 'v':
 			printf("%s %s\n", argv[0], SOURCE_VERSION);
 			printf("GPSD alfred client\n");
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index 68da875..a8382ea 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -41,7 +41,7 @@
 #define SOURCE_VERSION				"2014.4.0"
 #endif
 
-#define ALFRED_SOCK_PATH			"/var/run/alfred.sock"
+#define ALFRED_SOCK_PATH_DEFAULT		"/var/run/alfred.sock"
 #define PATH_BUFF_LEN				200
 #define GPSD_PACKETTYPE				2
 #define	GPSD_PACKETVERSION			1
@@ -95,6 +95,7 @@ struct globals {
 
 	float lat, lon, alt;
 	int unix_sock;
+	const char *unix_path;
 
 	struct fixsource_t gpsdsource;
 	struct gps_data_t gpsdata;
diff --git a/gpsd/man/alfred-gpsd.8 b/gpsd/man/alfred-gpsd.8
index fa5cb1f..3799293 100644
--- a/gpsd/man/alfred-gpsd.8
+++ b/gpsd/man/alfred-gpsd.8
@@ -43,6 +43,9 @@ Print the version
 \fB\-h\fP, \fB\-\-help\fP
 Display a brief help message.
 .TP
+\fB\-u\fP, \fB\-\-unix-path\fP \fIpath\fP
+path to unix socket used for alfred server communication.
+.TP
 \fB\-s\fP, \fB\-\-server\fP
 Start up in server mode. This server will read the current location
 from gpsd and set it in alfred via unix socket. The alfred server must
diff --git a/main.c b/main.c
index d848589..0a79e08 100644
--- a/main.c
+++ b/main.c
@@ -49,6 +49,7 @@ static void alfred_usage(void)
 	printf("                              accepts data from slaves and synces it with\n");
 	printf("                              other masters\n");
 	printf("\n");
+	printf("  -u, --unix-path [path]      path to unix socket used for client-server communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
 	printf("  -v, --version               print the version\n");
 	printf("  -h, --help                  this help\n");
 	printf("\n");
@@ -66,6 +67,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"help",	no_argument,		NULL,	'h'},
 		{"req-version", required_argument,	NULL,	'V'},
 		{"modeswitch",  required_argument,	NULL,	'M'},
+		{"unix-path", 	required_argument,	NULL,	'u'},
 		{"version",	no_argument,		NULL,	'v'},
 		{NULL,		0,			NULL,	0},
 	};
@@ -79,10 +81,11 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals->best_server = NULL;
 	globals->clientmode_version = 0;
 	globals->mesh_iface = "bat0";
+	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
 
 	time_random_seed();
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:", long_options,
+	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:u:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
@@ -132,6 +135,9 @@ static struct globals *alfred_init(int argc, char *argv[])
 			}
 			globals->clientmode = CLIENT_MODESWITCH;
 			break;
+		case 'u':
+			globals->unix_path = optarg;
+			break;
 		case 'v':
 			printf("%s %s\n", argv[0], SOURCE_VERSION);
 			printf("A.L.F.R.E.D. - Almighty Lightweight Remote Fact Exchange Daemon\n");
diff --git a/man/alfred.8 b/man/alfred.8
index e77acc3..c90caa8 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -50,6 +50,9 @@ Print the version
 .TP
 \fB\-h\fP, \fB\-\-help\fP
 Display a brief help message.
+.TP
+\fB\-u\fP, \fB\-\-unix-path\fP \fIpath\fP
+path to unix socket used for client-server communication.
 .
 .SH CLIENT OPTIONS
 .TP
diff --git a/server.c b/server.c
index e4465dc..b060d55 100644
--- a/server.c
+++ b/server.c
@@ -285,7 +285,7 @@ int alfred_server(struct globals *globals)
 	if (create_hashes(globals))
 		return -1;
 
-	if (unix_sock_open_daemon(globals, ALFRED_SOCK_PATH))
+	if (unix_sock_open_daemon(globals))
 		return -1;
 
 	if (!globals->interface) {
diff --git a/unix_sock.c b/unix_sock.c
index 3915553..fb7e391 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -35,11 +35,11 @@
 #include "hash.h"
 #include "packet.h"
 
-int unix_sock_open_daemon(struct globals *globals, const char *path)
+int unix_sock_open_daemon(struct globals *globals)
 {
 	struct sockaddr_un addr;
 
-	unlink(path);
+	unlink(globals->unix_path);
 
 	globals->unix_sock = socket(AF_LOCAL, SOCK_STREAM, 0);
 	if (globals->unix_sock < 0) {
@@ -50,7 +50,7 @@ int unix_sock_open_daemon(struct globals *globals, const char *path)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_LOCAL;
-	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
+	strncpy(addr.sun_path, globals->unix_path, sizeof(addr.sun_path));
 	addr.sun_path[sizeof(addr.sun_path) - 1] = '\0';
 
 	if (bind(globals->unix_sock, (struct sockaddr *)&addr,
@@ -69,7 +69,7 @@ int unix_sock_open_daemon(struct globals *globals, const char *path)
 	return 0;
 }
 
-int unix_sock_open_client(struct globals *globals, const char *path)
+int unix_sock_open_client(struct globals *globals)
 {
 	struct sockaddr_un addr;
 
@@ -82,7 +82,7 @@ int unix_sock_open_client(struct globals *globals, const char *path)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_LOCAL;
-	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
+	strncpy(addr.sun_path, globals->unix_path, sizeof(addr.sun_path));
 	addr.sun_path[sizeof(addr.sun_path) - 1] = '\0';
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
diff --git a/vis/man/batadv-vis.8 b/vis/man/batadv-vis.8
index 9b7c05c..20dead7 100644
--- a/vis/man/batadv-vis.8
+++ b/vis/man/batadv-vis.8
@@ -42,6 +42,9 @@ Print the version
 \fB\-h\fP, \fB\-\-help\fP
 Display a brief help message.
 .TP
+\fB\-u\fP, \fB\-\-unix-path\fP \fIpath\fP
+path to unix socket used for alfred server communication.
+.TP
 \fB\-i\fP, \fB\-\-interface\fP \fIiface\fP
 Specify the batman-adv interface configured on the system (default: bat0)
 .TP
diff --git a/vis/vis.c b/vis/vis.c
index 55c2dad..0cc4981 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -169,7 +169,7 @@ static int alfred_open_sock(struct globals *globals)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_LOCAL;
-	strncpy(addr.sun_path, ALFRED_SOCK_PATH, sizeof(addr.sun_path));
+	strncpy(addr.sun_path, globals->unix_path, sizeof(addr.sun_path));
 	addr.sun_path[sizeof(addr.sun_path) - 1] = '\0';
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
@@ -818,6 +818,7 @@ static void vis_usage(void)
 	printf("  -i, --interface             specify the batman-adv interface configured on the system (default: bat0)\n");
 	printf("  -s, --server                start up in server mode, which regularly updates vis data from batman-adv\n");
 	printf("  -f, --format <format>       specify the output format for client mode (either \"json\", \"jsondoc\" or \"dot\")\n");
+	printf("  -u, --unix-path <path>      path to unix socket used for alfred server communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
 	printf("  -v, --version               print the version\n");
 	printf("  -h, --help                  this help\n");
 	printf("\n");
@@ -831,6 +832,7 @@ static struct globals *vis_init(int argc, char *argv[])
 		{"server",	no_argument,		NULL,	's'},
 		{"interface",	required_argument,	NULL,	'i'},
 		{"format",	required_argument,	NULL,	'f'},
+		{"unix-path", 	required_argument,	NULL,	'u'},
 		{"help",	no_argument,		NULL,	'h'},
 		{"version",	no_argument,		NULL,	'v'},
 		{NULL,		0,			NULL,	0},
@@ -842,8 +844,9 @@ static struct globals *vis_init(int argc, char *argv[])
 	globals->opmode = OPMODE_CLIENT;
 	globals->interface = "bat0";
 	globals->vis_format = FORMAT_DOT;
+	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
 
-	while ((opt = getopt_long(argc, argv, "shf:i:v", long_options,
+	while ((opt = getopt_long(argc, argv, "shf:i:vu:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 's':
@@ -864,6 +867,9 @@ static struct globals *vis_init(int argc, char *argv[])
 		case 'i':
 			globals->interface = strdup(optarg);
 			break;
+		case 'u':
+			globals->unix_path = optarg;
+			break;
 		case 'v':
 			printf("%s %s\n", argv[0], SOURCE_VERSION);
 			printf("VIS alfred client\n");
diff --git a/vis/vis.h b/vis/vis.h
index 3f71970..468bfc4 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -30,7 +30,7 @@
 #define SOURCE_VERSION				"2014.4.0"
 #endif
 
-#define ALFRED_SOCK_PATH			"/var/run/alfred.sock"
+#define ALFRED_SOCK_PATH_DEFAULT		"/var/run/alfred.sock"
 #define PATH_BUFF_LEN				200
 #define VIS_PACKETTYPE				1
 #define	VIS_PACKETVERSION			1
@@ -105,6 +105,7 @@ struct globals {
 	struct list_head entry_list;
 
 	int unix_sock;
+	const char *unix_path;
 };
 
 
-- 
2.0.1

