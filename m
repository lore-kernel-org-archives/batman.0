Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  2 Jun 2018 17:26:35 +0200
Message-Id: <20180602152635.2923-2-sven@narfation.org>
In-Reply-To: <20180602152635.2923-1-sven@narfation.org>
References: <20180602152635.2923-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix bat_v best gw
 refcnt after netlink dump
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
Cc: Sven Eckelmann <sven@narfation.org>, Andreas Ziegler <github@andreas-ziegler.de>

A reference to the best gateway is taken when the list of gateways in the
mesh is sent via netlink. This is necessary to check whether the currently
dumped entry is the currently selected gateway or not. This information is
then transferred as flag BATADV_ATTR_FLAG_BEST.

After the comparison of the current entry is done,
batadv_v_gw_dump_entry() has to decrease the reference counter again.
Otherwise the reference will be held and thus prevents a proper shutdown of
the batman-adv interfaces (and some of the interfaces enslaved in it).

Fixes: 15315a94ad98 ("batman-adv: add B.A.T.M.A.N. V bat_gw_dump implementations")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Andreas Ziegler <github@andreas-ziegler.de>

 net/batman-adv/bat_v.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index ec93337e..6baec4e6 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -927,7 +927,7 @@ static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 {
 	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
 	struct batadv_neigh_node *router;
-	struct batadv_gw_node *curr_gw;
+	struct batadv_gw_node *curr_gw = NULL;
 	int ret = 0;
 	void *hdr;
 
@@ -995,6 +995,8 @@ static int batadv_v_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	ret = 0;
 
 out:
+	if (curr_gw)
+		batadv_gw_node_put(curr_gw);
 	if (router_ifinfo)
 		batadv_neigh_ifinfo_put(router_ifinfo);
 	if (router)
-- 
2.17.0

