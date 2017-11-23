Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:41 +0100
Message-Id: <20171123140444.17119-8-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 07/10] batctl: Free nl_sock on
 genl_ctrl_resolve error
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

genl_ctrl_resolve may return NULL on errors. The code must then free the
socket which was used to start the genl_ctrl_resolve and stop the function
with an error code.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 netlink.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/netlink.c b/netlink.c
index b95063a..de81d08 100644
--- a/netlink.c
+++ b/netlink.c
@@ -301,8 +301,10 @@ static char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 	genl_connect(sock);
 
 	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (family < 0)
+	if (family < 0) {
+		nl_socket_free(sock);
 		return NULL;
+	}
 
 	msg = nlmsg_alloc();
 	if (!msg) {
@@ -410,8 +412,10 @@ int netlink_print_routing_algos(void)
 	genl_connect(sock);
 
 	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (family < 0)
-		return -EOPNOTSUPP;
+	if (family < 0) {
+		last_err = -EOPNOTSUPP;
+		goto err_free_sock;
+	}
 
 	msg = nlmsg_alloc();
 	if (!msg) {
@@ -1125,8 +1129,10 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 	genl_connect(sock);
 
 	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (family < 0)
-		return -EOPNOTSUPP;
+	if (family < 0) {
+		last_err = -EOPNOTSUPP;
+		goto err_free_sock;
+	}
 
 	ifindex = if_nametoindex(mesh_iface);
 	if (!ifindex) {
-- 
2.11.0

