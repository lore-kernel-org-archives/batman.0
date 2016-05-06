Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  6 May 2016 11:22:47 +0200
Message-Id: <1462526567-10019-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid nullptr derefence in
	batadv_v_neigh_is_sob
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

batadv_neigh_ifinfo_get can return NULL when it cannot find (even when only
temporarily) anymore the neigh_ifinfo in the list neigh->ifinfo_list. This
has to be checked to avoid kernel Oopses when the ifinfo is dereferenced.

This a situation which isn't expected but is already handled by functions
like batadv_v_neigh_cmp. The same kind of warning is therefore used before
the function returns without dereferencing the pointers.

Fixes: b05bbab5e1fc ("batman-adv: B.A.T.M.A.N. V - implement neighbor comparison API calls")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 927d405..f271ae8 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -286,6 +286,9 @@ static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
 	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
 
+	if (WARN_ON(!ifinfo1 || !ifinfo2))
+		return false;
+
 	threshold = ifinfo1->bat_v.throughput / 4;
 	threshold = ifinfo1->bat_v.throughput - threshold;
 
-- 
2.8.1

