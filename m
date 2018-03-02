Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:51:38 +0100
Message-Id: <20180302175142.11838-4-sw@simonwunderlich.de>
In-Reply-To: <20180302175142.11838-1-sw@simonwunderlich.de>
References: <20180302175142.11838-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] batman-adv: Ignore invalid batadv_iv_gw
 during netlink send
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@openmesh.com>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

The function batadv_iv_gw_dump stops the processing loop when
batadv_iv_gw_dump_entry returns a non-0 return code. This should only
happen when the buffer is full. Otherwise, an empty message may be
returned by batadv_gw_dump. This empty message will then stop the netlink
dumping of gateway entries. At worst, not a single entry is returned to
userspace even when plenty of possible gateways exist.

Fixes: efb766af06e3 ("batman-adv: add B.A.T.M.A.N. IV bat_gw_dump implementations")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 79e326383726..8f64439647e3 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2729,7 +2729,7 @@ static int batadv_iv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	struct batadv_neigh_node *router;
 	struct batadv_gw_node *curr_gw;
-	int ret = -EINVAL;
+	int ret = 0;
 	void *hdr;
 
 	router = batadv_orig_router_get(gw_node->orig_node, BATADV_IF_DEFAULT);
-- 
2.11.0

