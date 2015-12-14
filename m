Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Dec 2015 15:00:47 +0100
Message-Id: <1450101647-9762-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Remove bogus length check in
	debugfs_make_path
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

The length check never used the mesh_iface length in the size calculation.
Instead it used the length of the mountpoint and the format string. But the
length of the format string is not the length of the final string.

Instead remove this check and depend completely on the return value of
snprintf.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debugfs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 04e47e9..3c58195 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -42,19 +42,12 @@ static const char *debugfs_known_mountpoints[] = {
 /* construct a full path to a debugfs element */
 int debugfs_make_path(const char *fmt, char *mesh_iface, char *buffer, int size)
 {
-	int len;
-
 	if (strlen(debugfs_mountpoint) == 0) {
 		buffer[0] = '\0';
 		return -1;
 	}
 
-	len = strlen(debugfs_mountpoint) + strlen(fmt) + 1;
-	if (len >= size)
-		return len+1;
-
-	snprintf(buffer, size-1, fmt, debugfs_mountpoint, mesh_iface);
-	return 0;
+	return snprintf(buffer, size, fmt, debugfs_mountpoint, mesh_iface);
 }
 
 static int debugfs_found;
-- 
2.6.4

