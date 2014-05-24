Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:07 +0200
Message-Id: <1400931855-7961-2-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] alfred: Force null termination of
	string after strncpy
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

strncpy doesn't terminate the string with a '\0' character when the length
of the destination memory location was shorter than the source string.
Accessing it again with string related functions isn't safe after such a
semi-failed copy and the caller has to handle it. The easiest way is to
always set the last character in the destination buffer to '\0' after the
strncpy was called.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 debugfs.c | 1 +
 netsock.c | 1 +
 server.c  | 1 +
 vis/vis.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/debugfs.c b/debugfs.c
index 1e9418d..adada7c 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -154,6 +154,7 @@ char *debugfs_mount(const char *mountpoint)
 
 	/* save the mountpoint */
 	strncpy(debugfs_mountpoint, mountpoint, sizeof(debugfs_mountpoint));
+	debugfs_mountpoint[sizeof(debugfs_mountpoint) - 1] = '\0';
 	debugfs_found = 1;
 
 	return debugfs_mountpoint;
diff --git a/netsock.c b/netsock.c
index 08d2959..8712c11 100644
--- a/netsock.c
+++ b/netsock.c
@@ -59,6 +59,7 @@ int netsock_open(struct globals *globals)
 
 	memset(&ifr, 0, sizeof(ifr));
 	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
+	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
 		fprintf(stderr, "can't get interface: %s\n", strerror(errno));
 		goto err;
diff --git a/server.c b/server.c
index fdd97d4..e4465dc 100644
--- a/server.c
+++ b/server.c
@@ -242,6 +242,7 @@ static void check_if_socket(struct globals *globals)
 
 	memset(&ifr, 0, sizeof(ifr));
 	strncpy(ifr.ifr_name, globals->interface, IFNAMSIZ);
+	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	if (ioctl(sock, SIOCGIFINDEX, &ifr) == -1) {
 		fprintf(stderr, "can't get interface: %s, closing netsock\n",
 			strerror(errno));
diff --git a/vis/vis.c b/vis/vis.c
index b51fede..9031b27 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -102,6 +102,7 @@ static int get_if_mac(char *ifname, uint8_t *mac)
 	int sock, ret;
 
 	strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
+	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 
 	if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
 		fprintf(stderr, "can't get interface: %s\n", strerror(errno));
-- 
2.0.0.rc2

