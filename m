Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Mar 2015 23:41:18 +0100
Message-Id: <1425768078-15380-2-git-send-email-sven@narfation.org>
In-Reply-To: <1425768078-15380-1-git-send-email-sven@narfation.org>
References: <1425768078-15380-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Add option to the client to
	print extra data information
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

The version of a dataset can be queried using the parameter --verbose/-d. It is
printed as third component of each dataset line when starting the unix client
in request mode.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h     | 1 +
 client.c     | 7 ++++++-
 main.c       | 7 ++++++-
 man/alfred.8 | 3 +++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/alfred.h b/alfred.h
index ef00551..f26c80c 100644
--- a/alfred.h
+++ b/alfred.h
@@ -113,6 +113,7 @@ struct globals {
 	enum clientmode clientmode;
 	int clientmode_arg;
 	int clientmode_version;
+	int verbose;
 
 	int unix_sock;
 	const char *unix_path;
diff --git a/client.c b/client.c
index 32fdd54..42dd4ad 100644
--- a/client.c
+++ b/client.c
@@ -121,7 +121,12 @@ int alfred_client_request_data(struct globals *globals)
 				printf("%c", pos[i]);
 		}
 
-		printf("\" },\n");
+		printf("\"");
+
+		if (globals->verbose)
+			printf(", %u", data->header.version);
+
+		printf(" },\n");
 	}
 
 	unix_sock_close(globals);
diff --git a/main.c b/main.c
index d298d65..65948d3 100644
--- a/main.c
+++ b/main.c
@@ -75,6 +75,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"change-interface",	required_argument,	NULL,	'I'},
 		{"unix-path",		required_argument,	NULL,	'u'},
 		{"version",		no_argument,		NULL,	'v'},
+		{"verbose",		no_argument,		NULL,	'd'},
 		{NULL,			0,			NULL,	0},
 	};
 
@@ -89,10 +90,11 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals->clientmode_version = 0;
 	globals->mesh_iface = "bat0";
 	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
+	globals->verbose = 0;
 
 	time_random_seed();
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:", long_options,
+	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:d", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
@@ -149,6 +151,9 @@ static struct globals *alfred_init(int argc, char *argv[])
 		case 'u':
 			globals->unix_path = optarg;
 			break;
+		case 'd':
+			globals->verbose++;
+			break;
 		case 'v':
 			printf("%s %s\n", argv[0], SOURCE_VERSION);
 			printf("A.L.F.R.E.D. - Almighty Lightweight Remote Fact Exchange Daemon\n");
diff --git a/man/alfred.8 b/man/alfred.8
index 0449189..a8050ab 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -67,6 +67,9 @@ alfred will forget about it (after 10 minutes).
 \fB\-r\fP, \fB\-\-request\fP \fIdata\-type\fP
 Collect data from the network and prints it on the network
 .TP
+\fB\-d\fP, \fB\-\-verbose\fP
+Show extra information in the data output
+.TP
 \fB\-V\fP, \fB\-\-req\-version\fP \fIversion\fP
 Specify the data version set for \fB\-s\fP
 
-- 
2.1.4

