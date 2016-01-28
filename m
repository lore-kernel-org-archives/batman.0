Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Jan 2016 04:53:14 +0100
Message-Id: <1453953196-29943-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
References: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] alfred: Add support for network
	namespaces
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

When running within a network namespace, access to files within
debugfs have to take into account the network name space. Each
namespace has its own directory under
/sys/kernel/debug/batman_adv/netns.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 batadv_query.c |  2 +-
 debugfs.c      | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 vis/vis.h      |  2 +-
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index c289b80..fe7c007 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -31,7 +31,7 @@
 #include <sys/types.h>
 #include "debugfs.h"
 
-#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
+#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s%s"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
 #define DEBUG_ORIGINATORS "originators"
 
diff --git a/debugfs.c b/debugfs.c
index fc39322..35c1bdf 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -20,11 +20,15 @@
 
 #include "debugfs.h"
 #include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
 #include <stdio.h>
 #include <string.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/statfs.h>
+#include <sys/types.h>
+#include <unistd.h>
 
 #ifndef DEBUGFS_MAGIC
 #define DEBUGFS_MAGIC          0x64626720
@@ -42,16 +46,59 @@ static const char *debugfs_known_mountpoints[] = {
 	NULL,
 };
 
+/* Return the current net namespace number. 0 is never a valid
+ * namespace, so use it to return that there is no name space
+ * support.
+ */
+
+static unsigned int debugfs_get_netns_inum(void)
+{
+	char net_path[] = "/proc/self/ns/net";
+	struct stat netst;
+	int netns;
+
+	netns = open(net_path, O_RDONLY);
+	if (netns < 0) {
+		if (errno == ENOENT)
+			/* Probably means no netns support in the kernel */
+			return 0;
+
+		fprintf(stderr,
+			"Error - can't open /proc/self/ns/net for read: %s\n",
+			strerror(errno));
+		return 0;
+	}
+
+	if (fstat(netns, &netst) < 0) {
+		fprintf(stderr, "Stat of netns failed: %s\n",
+			strerror(errno));
+		return 0;
+	}
+	close (netns);
+
+	return netst.st_ino;
+}
+
 /* construct a full path to a debugfs element */
 int debugfs_make_path(const char *fmt, const char *mesh_iface, char *buffer,
 		      int size)
 {
+	unsigned int ns =  debugfs_get_netns_inum();
+	char ns_dir[PATH_MAX];
+
 	if (strlen(debugfs_mountpoint) == 0) {
 		buffer[0] = '\0';
 		return -1;
 	}
 
-	return snprintf(buffer, size, fmt, debugfs_mountpoint, mesh_iface);
+	if (ns) {
+		snprintf(ns_dir, PATH_MAX, "netns/%u/", ns);
+		return snprintf(buffer, size, fmt, debugfs_mountpoint, ns_dir,
+				mesh_iface);
+	} else {
+		return snprintf(buffer, size, fmt, debugfs_mountpoint, "",
+				mesh_iface);
+	}
 }
 
 static int debugfs_found;
diff --git a/vis/vis.h b/vis/vis.h
index 969ca33..9e5dc35 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -37,7 +37,7 @@
 #define UPDATE_INTERVAL				10
 
 #define SYS_IFACE_PATH				"/sys/class/net"
-#define DEBUG_BATIF_PATH_FMT			"%s/batman_adv/%s"
+#define DEBUG_BATIF_PATH_FMT			"%s/batman_adv/%s%s"
 #define SYS_MESH_IFACE_FMT			SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT			SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 
-- 
2.7.0.rc3

