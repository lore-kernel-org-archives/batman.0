Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:07 +0100
Message-Id: <20170122122113.29588-3-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 3/9] batctl: Return type of error on
	netlink_get_info error
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

It can happen that netlink_get_info will not return an algo string. This
usually happens because BATADV_CMD_GET_MESH_INFO is not implemented in the
kernel modules. But it is also possible that this happens because the user
didn't have the correct rights to retrieve this type of information.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/netlink.c b/netlink.c
index 9580aa3..7fb1ee1 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1177,11 +1177,12 @@ int netlink_print_originators(char *mesh_iface, char *orig_iface,
 	}
 
 	/* only parse routing algorithm name */
+	last_err = -EINVAL;
 	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_ORIGINATORS, NULL);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
-		return -EOPNOTSUPP;
+		return last_err;
 
 	if (!strcmp("BATMAN_IV", algo_name_buf))
 		header = "   Originator        last-seen (#/255) Nexthop           [outgoingIF]\n";
@@ -1244,11 +1245,12 @@ int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opts,
 	}
 
 	/* only parse routing algorithm name */
+	last_err = -EINVAL;
 	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_ORIGINATORS, NULL);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
-		return -EOPNOTSUPP;
+		return last_err;
 
 	if (!strcmp("BATMAN_IV", algo_name_buf))
 		header = "  Router            ( TQ) Next Hop          [outgoingIf]  Bandwidth\n";
-- 
2.11.0

