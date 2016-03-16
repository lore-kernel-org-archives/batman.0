Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 16 Mar 2016 20:51:12 +0100
Message-Id: <1458157872-15879-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1458157872-15879-1-git-send-email-andrew@lunn.ch>
References: <1458157872-15879-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/2] alfred: Mount debugfs before reducing
	capabilities
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

The debugfs helper code has the ability to mount the debugfs file
system if it is not already mounted. However, it cannot do this
after the capabilities have been dropped. So perform the mount early,
and remove all the other attempts to do the mount.

This is especially important when using network name spaces. Each
namespace has its own /sys, so the mount of debugfs in the global
namespace is not visible in other namespaces.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2: Remove the other calls to mount
---
 batadv_query.c | 17 -----------------
 main.c         |  4 ++++
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/batadv_query.c b/batadv_query.c
index 1b9e631..1a385c9 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -90,16 +90,9 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
 
 int batadv_interface_check(const char *mesh_iface)
 {
-	char *debugfs_mnt;
 	char full_path[MAX_PATH + 1];
 	FILE *f;
 
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Could not find debugfs path\n");
-		return -1;
-	}
-
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL,
 			  mesh_iface, full_path, sizeof(full_path));
 	f = fopen(full_path, "r");
@@ -134,7 +127,6 @@ struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac)
 		tg_originator,
 	} pos;
 	char full_path[MAX_PATH + 1];
-	char *debugfs_mnt;
 	static struct ether_addr in_mac;
 	struct ether_addr *mac_result, *mac_tmp;
 	FILE *f = NULL;
@@ -146,10 +138,6 @@ struct ether_addr *translate_mac(const char *mesh_iface, struct ether_addr *mac)
 	memcpy(&in_mac, mac, sizeof(in_mac));
 	mac_result = &in_mac;
 
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt)
-		goto out;
-
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_TRANSTABLE_GLOBAL,
 			  mesh_iface, full_path, sizeof(full_path));
 
@@ -216,7 +204,6 @@ uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 		orig_tqvalue,
 	} pos;
 	char full_path[MAX_PATH + 1];
-	char *debugfs_mnt;
 	static struct ether_addr in_mac;
 	struct ether_addr *mac_tmp;
 	FILE *f = NULL;
@@ -228,10 +215,6 @@ uint8_t get_tq(const char *mesh_iface, struct ether_addr *mac)
 
 	memcpy(&in_mac, mac, sizeof(in_mac));
 
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt)
-		goto out;
-
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_ORIGINATORS,
 			  mesh_iface, full_path, sizeof(full_path));
 
diff --git a/main.c b/main.c
index 9610398..52dca97 100644
--- a/main.c
+++ b/main.c
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #endif
 #include "alfred.h"
+#include "debugfs.h"
 #include "packet.h"
 #include "list.h"
 
@@ -160,6 +161,9 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{NULL,			0,			NULL,	0},
 	};
 
+	/* We need full capabilities to mount debugfs, so do that now */
+	debugfs_mount(NULL);
+
 	ret = reduce_capabilities();
 	if (ret < 0)
 		return NULL;
-- 
2.7.0.rc3

