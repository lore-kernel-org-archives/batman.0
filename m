Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 16:09:22 +0100
Message-Id: <1457190564-11419-7-git-send-email-sven@narfation.org>
In-Reply-To: <1457190564-11419-1-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 7/9] batman-adv: Use kref_get for
	batadv_gw_select
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

batadv_gw_select requires that the caller already has a valid reference for
new_gw_node. It is therefore not possible that it has an reference counter
of 0 and was still given to this function

The kref_get function instead WARNs (with debug information) when the
reference counter would still be 0. This makes a bug in batman-adv better
visible because kref_get_unless_zero would have ignored this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index c59aff5..bb1c4f3 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -135,8 +135,8 @@ static void batadv_gw_select(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
 
-	if (new_gw_node && !kref_get_unless_zero(&new_gw_node->refcount))
-		new_gw_node = NULL;
+	if (new_gw_node)
+		kref_get(&new_gw_node->refcount);
 
 	curr_gw_node = rcu_dereference_protected(bat_priv->gw.curr_gw, 1);
 	rcu_assign_pointer(bat_priv->gw.curr_gw, new_gw_node);
-- 
2.7.0

