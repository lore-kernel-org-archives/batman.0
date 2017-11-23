Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:42 +0100
Message-Id: <20171123140444.17119-9-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 08/10] batctl: Free nl_sock when
 if_nametoindex failed
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

The if_nametoindex can return an error. The code must then free the
previously allocated nl_sock and stop the function with an error code.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/netlink.c b/netlink.c
index de81d08..7b97809 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1137,7 +1137,8 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 	ifindex = if_nametoindex(mesh_iface);
 	if (!ifindex) {
 		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
-		return -ENODEV;
+		last_err = -ENODEV;
+		goto err_free_sock;
 	}
 
 	if (orig_iface) {
@@ -1145,7 +1146,8 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 		if (!hardifindex) {
 			fprintf(stderr, "Interface %s is unknown\n",
 				orig_iface);
-			return -ENODEV;
+			last_err = -ENODEV;
+			goto err_free_sock;
 		}
 	}
 
-- 
2.11.0

