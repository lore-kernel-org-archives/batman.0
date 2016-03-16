Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 16 Mar 2016 20:50:11 +0100
Message-Id: <1458157811-15809-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2] batctl: Add support for network namespaces
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

When running within a network namespace, access to files within
debugfs have to take into account the network name space. Each
namespace has its own directory under
/sys/kernel/debug/batman_adv/netns.

Add example how this can be used in the README.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2: README additions
---
 README    | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debug.h   |  2 +-
 debugfs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/README b/README
index f87c551..431c62e 100644
--- a/README
+++ b/README
@@ -520,3 +520,61 @@ where:
 - IPv4 is the IP address of a client in the mesh network
 - MAC is the MAC address associated to that IP
 - last-seen is the amount of time since last refresh of this entry
+
+batctl and network name spaces
+==============================
+
+The batman-adv kernel module is netns aware. Mesh instances can be
+created in name spaces, and interfaces in that name space added to the
+mesh. The mesh interface cannot be moved between name spaces, as is
+typical for virtual interfaces.
+
+The following example creates two network namespaces, and uses veth
+pairs to connect them together into a mesh of three nodes.
+
+EMU1="ip netns exec emu1"
+EMU2="ip netns exec emu2"
+
+ip netns add emu1
+ip netns add emu2
+
+ip link add emu1-veth1 type veth peer name emu2-veth1
+ip link set emu1-veth1 netns emu1
+ip link set emu2-veth1 netns emu2
+
+$EMU1 ip link set emu1-veth1 name veth1
+$EMU2 ip link set emu2-veth1 name veth1
+
+$EMU1 ip link set veth1 up
+$EMU2 ip link set veth1 up
+
+ip link add emu1-veth2 type veth peer name veth2
+ip link set emu1-veth2 netns emu1
+$EMU1 ip link set emu1-veth2 name veth2
+
+$EMU1 ip link set veth2 up
+ip link set veth2 up
+
+$EMU1 batctl if add veth1
+$EMU1 batctl if add veth2
+$EMU1 ip link set bat0 up
+
+$EMU2 batctl if add veth1
+$EMU2 ip link set bat0 up
+
+batctl if add veth2
+ip link set bat0 up
+
+alfred and batadv-vis can also be used with name spaces. In this
+example, only netns has been used, so there are no filesystem name
+spaces. Hence the unix domain socket used by alfred needs to be given
+a unique name per instance.
+
+($EMU1 alfred -m -i bat0 -u /var/run/emu1-alfred.soc) &
+($EMU2 alfred -m -i bat0 -u /var/run/emu2-alfred.soc) &
+alfred -m -i bat0 &
+
+($EMU1 batadv-vis -s -u /var/run/emu1-alfred.soc) &
+($EMU2 batadv-vis -s -u /var/run/emu2-alfred.soc) &
+batadv-vis -s &
+
diff --git a/debug.h b/debug.h
index df65f50..ac7a97b 100644
--- a/debug.h
+++ b/debug.h
@@ -25,7 +25,7 @@
 #include <stddef.h>
 #include "main.h"
 
-#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
+#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s%s"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
 #define DEBUG_LOG "log"
 #define DEBUG_ROUTING_ALGOS "routing_algos"
diff --git a/debugfs.c b/debugfs.c
index 3c58195..a66dbdd 100644
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
@@ -39,15 +43,58 @@ static const char *debugfs_known_mountpoints[] = {
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
 int debugfs_make_path(const char *fmt, char *mesh_iface, char *buffer, int size)
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
-- 
2.7.0.rc3

