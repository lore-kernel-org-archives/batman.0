Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:12 +0200
Message-Id: <1400931855-7961-7-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/10] alfred: Use strncpy instead of strcpy
	for string copy
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

The data used in strcpy is partially provided by the user. This can be larger
than the destination buffer and thus overwrite data after the actual string
buffer. This can easily be avoided by using strncpy.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 debugfs.c          |  4 +++-
 gpsd/alfred-gpsd.c | 18 +++++++++++++++---
 unix_sock.c        |  6 ++++--
 vis/vis.c          |  3 ++-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index adada7c..4b8801a 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -78,7 +78,9 @@ static const char *debugfs_find_mountpoint(void)
 	while (*ptr) {
 		if (debugfs_valid_mountpoint(*ptr) == 0) {
 			debugfs_found = 1;
-			strcpy(debugfs_mountpoint, *ptr);
+			strncpy(debugfs_mountpoint, *ptr,
+				sizeof(debugfs_mountpoint));
+			debugfs_mountpoint[sizeof(debugfs_mountpoint) - 1] = 0;
 			return debugfs_mountpoint;
 		}
 		ptr++;
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 089f2af..84a0ded 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -36,7 +36,8 @@ static int alfred_open_sock(struct globals *globals)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_LOCAL;
-	strcpy(addr.sun_path, ALFRED_SOCK_PATH);
+	strncpy(addr.sun_path, ALFRED_SOCK_PATH, sizeof(addr.sun_path));
+	addr.sun_path[sizeof(addr.sun_path) - 1] = '\0';
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
@@ -300,6 +301,10 @@ static void gpsd_read_gpsd(struct globals *globals)
 	size_t cnt;
 	bool eol = false;
 	char buf[4096];
+	const size_t tpv_size = sizeof(*globals->buf) -
+				sizeof(*globals->push) -
+				sizeof(struct alfred_data) -
+				sizeof(*globals->gpsd_data);
 
 	cnt = 0;
 	do {
@@ -328,7 +333,9 @@ static void gpsd_read_gpsd(struct globals *globals)
 
 #define STARTSWITH(str, prefix)	strncmp(str, prefix, sizeof(prefix)-1)==0
 	if (STARTSWITH(buf, "{\"class\":\"TPV\"")) {
-		strcpy(globals->gpsd_data->tpv, buf);
+		strncpy(globals->gpsd_data->tpv, buf, tpv_size);
+		globals->gpsd_data->tpv[tpv_size - 1] = '\0';
+
 		globals->gpsd_data->tpv_len =
 			htonl(strlen(globals->gpsd_data->tpv) + 1);
 	}
@@ -443,6 +450,10 @@ static int gpsd_server(struct globals *globals)
 	int max_fd, ret;
 	const size_t overhead = sizeof(*globals->push) +
 		sizeof(struct alfred_data);
+	const size_t tpv_size = sizeof(*globals->buf) -
+				sizeof(*globals->push) -
+				sizeof(struct alfred_data) -
+				sizeof(*globals->gpsd_data);
 	long interval;
 
 	globals->push = (struct alfred_push_data_v0 *) globals->buf;
@@ -456,7 +467,8 @@ static int gpsd_server(struct globals *globals)
 	globals->push->data->header.type = GPSD_PACKETTYPE;
 	globals->push->data->header.version = GPSD_PACKETVERSION;
 
-	strcpy(globals->gpsd_data->tpv, GPSD_INIT_TPV);
+	strncpy(globals->gpsd_data->tpv, GPSD_INIT_TPV, tpv_size);
+	globals->gpsd_data->tpv[tpv_size - 1] = '\0';
 	globals->gpsd_data->tpv_len =
 		htonl(strlen(globals->gpsd_data->tpv) + 1);
 
diff --git a/unix_sock.c b/unix_sock.c
index 8251c81..4553db5 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -50,7 +50,8 @@ int unix_sock_open_daemon(struct globals *globals, const char *path)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_LOCAL;
-	strcpy(addr.sun_path, path);
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
+	addr.sun_path[sizeof(addr.sun_path) - 1] = '\0';
 
 	if (bind(globals->unix_sock, (struct sockaddr *)&addr,
 		 sizeof(addr)) < 0) {
@@ -81,7 +82,8 @@ int unix_sock_open_client(struct globals *globals, const char *path)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_LOCAL;
-	strcpy(addr.sun_path, path);
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
+	addr.sun_path[sizeof(addr.sun_path) - 1] = '\0';
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
diff --git a/vis/vis.c b/vis/vis.c
index 2928d65..f429942 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -168,7 +168,8 @@ static int alfred_open_sock(struct globals *globals)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_LOCAL;
-	strcpy(addr.sun_path, ALFRED_SOCK_PATH);
+	strncpy(addr.sun_path, ALFRED_SOCK_PATH, sizeof(addr.sun_path));
+	addr.sun_path[sizeof(addr.sun_path) - 1] = '\0';
 
 	if (connect(globals->unix_sock, (struct sockaddr *)&addr,
 		    sizeof(addr)) < 0) {
-- 
2.0.0.rc2

