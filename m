Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 13:35:10 +0200
Message-Id: <1467545714-20722-5-git-send-email-sven@narfation.org>
In-Reply-To: <1467545714-20722-1-git-send-email-sven@narfation.org>
References: <1467545714-20722-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v10 4/8] batctl: Import alfred version of
	debugfs.*
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

The alfred version of debugfs.c and debugfs.h contains several cleanups
regarding error message output, removal of unused declarations and usage of
const buffers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debugfs.c | 17 ++++++++++-------
 debugfs.h |  4 +---
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 3c58195..fc39322 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -33,6 +33,9 @@
 static int debugfs_premounted;
 static char debugfs_mountpoint[MAX_PATH+1];
 
+static const char *debugfs_find_mountpoint(void);
+static int debugfs_valid_mountpoint(const char *debugfs);
+
 static const char *debugfs_known_mountpoints[] = {
 	"/sys/kernel/debug/",
 	"/debug/",
@@ -40,7 +43,8 @@ static const char *debugfs_known_mountpoints[] = {
 };
 
 /* construct a full path to a debugfs element */
-int debugfs_make_path(const char *fmt, char *mesh_iface, char *buffer, int size)
+int debugfs_make_path(const char *fmt, const char *mesh_iface, char *buffer,
+		      int size)
 {
 	if (strlen(debugfs_mountpoint) == 0) {
 		buffer[0] = '\0';
@@ -53,14 +57,14 @@ int debugfs_make_path(const char *fmt, char *mesh_iface, char *buffer, int size)
 static int debugfs_found;
 
 /* find the path to the mounted debugfs */
-const char *debugfs_find_mountpoint(void)
+static const char *debugfs_find_mountpoint(void)
 {
 	const char **ptr;
 	char type[100];
 	FILE *fp;
 
 	if (debugfs_found)
-		return (const char *) debugfs_mountpoint;
+		return (const char *)debugfs_mountpoint;
 
 	ptr = debugfs_known_mountpoints;
 	while (*ptr) {
@@ -68,7 +72,7 @@ const char *debugfs_find_mountpoint(void)
 			debugfs_found = 1;
 			strncpy(debugfs_mountpoint, *ptr,
 				sizeof(debugfs_mountpoint));
-			debugfs_mountpoint[sizeof(debugfs_mountpoint) - 1] = '\0';
+			debugfs_mountpoint[sizeof(debugfs_mountpoint) - 1] = 0;
 			return debugfs_mountpoint;
 		}
 		ptr++;
@@ -77,8 +81,7 @@ const char *debugfs_find_mountpoint(void)
 	/* give up and parse /proc/mounts */
 	fp = fopen("/proc/mounts", "r");
 	if (fp == NULL) {
-		fprintf(stderr, "Error - can't open /proc/mounts for read: %s\n",
-		       strerror(errno));
+		perror("Error - can't open /proc/mounts for read");
 		return NULL;
 	}
 
@@ -101,7 +104,7 @@ const char *debugfs_find_mountpoint(void)
 
 /* verify that a mountpoint is actually a debugfs instance */
 
-int debugfs_valid_mountpoint(const char *debugfs)
+static int debugfs_valid_mountpoint(const char *debugfs)
 {
 	struct statfs st_fs;
 
diff --git a/debugfs.h b/debugfs.h
index e608902..b4dc6bb 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -30,11 +30,9 @@
 # define STR(x) _STR(x)
 #endif
 
-extern const char *debugfs_find_mountpoint(void);
-extern int debugfs_valid_mountpoint(const char *debugfs);
 extern int debugfs_valid_entry(const char *path);
 extern char *debugfs_mount(const char *mountpoint);
-extern int debugfs_make_path(const char *fmt, char *mesh_iface,
+extern int debugfs_make_path(const char *fmt, const char *mesh_iface,
 			     char *buffer, int size);
 
 #endif /* __DEBUGFS_H__ */
-- 
2.8.1

