Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Jun 2015 09:13:23 +0200
Message-Id: <1434957203-6939-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Replace gw_reselect 64 bit
	div with shift
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

The 64-bit gw_factor is divided by BATADV_TQ_LOCAL_WINDOW_SIZE ** 2 * 64.
But the rest of the calculation has nothing to do with the tq window size
end therefore the calculation is just (tmp_gw_factor / (64 ** 3)).

The problem with 64 bit div is that it doesn't work on systems without
native 64 bit div support. It has to be emulated using do_div or div_u64.
The change in f63c54bba31d ("batman-adv: Avoid u32 overflow during gateway
select") only compiled on such systems because the compiler converted the
div to a (tmp_gw_factor >> 18). Making this explicit avoids having build
problems in the future when BATADV_TQ_LOCAL_WINDOW_SIZE is changed in such
a way that (BATADV_TQ_LOCAL_WINDOW_SIZE ** 2 * 64) is not a power of two.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gateway_client.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 3f32357..0f8d06b 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -134,14 +134,10 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 	struct batadv_neigh_ifinfo *router_ifinfo;
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
 	uint64_t max_gw_factor = 0, tmp_gw_factor = 0;
-	uint32_t gw_divisor;
 	uint8_t max_tq = 0;
 	uint8_t tq_avg;
 	struct batadv_orig_node *orig_node;
 
-	gw_divisor = BATADV_TQ_LOCAL_WINDOW_SIZE * BATADV_TQ_LOCAL_WINDOW_SIZE;
-	gw_divisor *= 64;
-
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
 		if (gw_node->deleted)
@@ -167,7 +163,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			tmp_gw_factor = tq_avg * tq_avg;
 			tmp_gw_factor *= gw_node->bandwidth_down;
 			tmp_gw_factor *= 100 * 100;
-			tmp_gw_factor /= gw_divisor;
+			tmp_gw_factor >>= 18;
 
 			if ((tmp_gw_factor > max_gw_factor) ||
 			    ((tmp_gw_factor == max_gw_factor) &&
-- 
2.1.4

