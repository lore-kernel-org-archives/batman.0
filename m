Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 4/4] alfred: Allow start of server without valid interface
Date: Mon, 15 Feb 2021 21:01:26 +0100
Message-Id: <20210215200126.140253-4-sven@narfation.org>
In-Reply-To: <20210215200126.140253-1-sven@narfation.org>
References: <20210215200126.140253-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The alfred server always needs interfaces to operate on. But these
interfaces might not exist at the moment when the daemon process is
started. This caused an error and stopped the process.

But alfred is able to deal with interfaces which disappeared at runtime but
existed at startup. To force a similar behavior for the alfred startup, the
parameter "--force" or "-f" is introduced.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h     | 1 +
 main.c       | 7 ++++++-
 man/alfred.8 | 3 +++
 server.c     | 5 +++--
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/alfred.h b/alfred.h
index c64ff17..ac08253 100644
--- a/alfred.h
+++ b/alfred.h
@@ -117,6 +117,7 @@ struct globals {
 	int clientmode_version;
 	uint8_t verbose:1;
 	uint8_t ipv4mode:1;
+	uint8_t force:1;
 
 	int unix_sock;
 	const char *unix_path;
diff --git a/main.c b/main.c
index f25b6cc..e190d42 100644
--- a/main.c
+++ b/main.c
@@ -164,6 +164,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"version",		no_argument,		NULL,	'v'},
 		{"verbose",		no_argument,		NULL,	'd'},
 		{"sync-period",		required_argument,	NULL,	'p'},
+		{"force",		no_argument,		NULL,	'f'},
 		{NULL,			0,			NULL,	0},
 	};
 
@@ -184,6 +185,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
 	globals->verbose = false;
 	globals->ipv4mode = false;
+	globals->force = false;
 	globals->update_command = NULL;
 	globals->sync_period.tv_sec = ALFRED_INTERVAL;
 	globals->sync_period.tv_nsec = 0;
@@ -191,7 +193,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 
 	time_random_seed();
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:p:4:", long_options,
+	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:p:4:f", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
@@ -273,6 +275,9 @@ static struct globals *alfred_init(int argc, char *argv[])
 			inet_pton(AF_INET, optarg, &alfred_mcast.ipv4);
 			printf(" ** IPv4 Multicast Mode: %x\n", alfred_mcast.ipv4.s_addr);
 			break;
+		case 'f':
+			globals->force = true;
+			break;
 		case 'h':
 		default:
 			alfred_usage();
diff --git a/man/alfred.8 b/man/alfred.8
index 25591be..e965db8 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -72,6 +72,9 @@ Collect data from the network and prints it on the network
 \fB\-d\fP, \fB\-\-verbose\fP
 Show extra information in the data output
 .TP
+\fB\-d\fP, \fB\-\-force\fP
+Start server even when batman-adv or interface(s) are not yet available.
+.TP
 \fB\-V\fP, \fB\-\-req\-version\fP \fIversion\fP
 Specify the data version set for \fB\-s\fP
 
diff --git a/server.c b/server.c
index eb2bc8a..b4925e7 100644
--- a/server.c
+++ b/server.c
@@ -386,14 +386,15 @@ int alfred_server(struct globals *globals)
 	}
 
 	if (strcmp(globals->mesh_iface, "none") != 0 &&
-	    batadv_interface_check(globals->mesh_iface) < 0) {
+	    batadv_interface_check(globals->mesh_iface) < 0 &&
+	    !globals->force) {
 		fprintf(stderr, "Can't start server: batman-adv interface %s not found\n",
 			globals->mesh_iface);
 		return -1;
 	}
 
 	num_socks = netsock_open_all(globals);
-	if (num_socks <= 0) {
+	if (num_socks <= 0 && !globals->force) {
 		fprintf(stderr, "Failed to open interfaces\n");
 		return -1;
 	}
-- 
2.30.0

