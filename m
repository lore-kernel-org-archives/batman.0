Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:39 +0100
Message-Id: <20171123140444.17119-6-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 05/10] batctl: Handle nl_socket_alloc errors
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

nl_socket_alloc may return NULL on errors. The processing has to be aborted
when this happens.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 netlink.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/netlink.c b/netlink.c
index e3d7892..d7aeb9a 100644
--- a/netlink.c
+++ b/netlink.c
@@ -295,6 +295,9 @@ static char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 	};
 
 	sock = nl_socket_alloc();
+	if (!sock)
+		return NULL;
+
 	genl_connect(sock);
 
 	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
@@ -397,6 +400,9 @@ int netlink_print_routing_algos(void)
 	};
 
 	sock = nl_socket_alloc();
+	if (!sock)
+		return -ENOMEM;
+
 	genl_connect(sock);
 
 	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
@@ -1104,6 +1110,9 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 	int family;
 
 	sock = nl_socket_alloc();
+	if (!sock)
+		return -ENOMEM;
+
 	genl_connect(sock);
 
 	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-- 
2.11.0

