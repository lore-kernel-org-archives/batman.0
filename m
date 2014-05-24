Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 14:16:41 +0200
Message-Id: <1400933804-9661-3-git-send-email-sven@narfation.org>
In-Reply-To: <1400933804-9661-1-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batctl: Use strncpy instead of strcpy
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
 debugfs.c | 4 +++-
 ioctl.c   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 8dd78b1..7bac044 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -74,7 +74,9 @@ const char *debugfs_find_mountpoint(void)
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
diff --git a/ioctl.c b/ioctl.c
index 1f827e8..d3d182f 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -105,7 +105,8 @@ int ioctl_statistics_get(char *mesh_iface)
 	int fd = -1, ret = EXIT_FAILURE;
 
 	memset(&ifr, 0, sizeof(ifr));
-	strcpy(ifr.ifr_name, mesh_iface);
+	strncpy(ifr.ifr_name, mesh_iface, sizeof(ifr.ifr_name));
+	ifr.ifr_name[sizeof(ifr.ifr_name) - 1] = '\0';
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
 	if (fd < 0) {
-- 
2.0.0.rc2

