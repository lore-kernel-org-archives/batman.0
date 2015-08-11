Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Aug 2015 18:35:39 +0200
Message-Id: <1439310948-32426-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1439310948-32426-1-git-send-email-antonio@meshcoding.com>
References: <1439310948-32426-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: Replace gw_reselect
	divisor with simple shift
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The gw_factor is divided by BATADV_TQ_LOCAL_WINDOW_SIZE ** 2 * 64. But the
rest of the calculation has nothing to do with the tq window size and
therefore the calculation is just (tmp_gw_factor / (64 ** 3)).

Replace it with a simple shift to avoid a costly 64-bit divide when the
max_gw_factor is changed from u32 to u64. This type change is necessary
to avoid an overflow bug.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/gateway_client.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index bb015862..e1e1f31 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -154,14 +154,10 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 	struct batadv_neigh_ifinfo *router_ifinfo;
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
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
@@ -187,7 +183,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			tmp_gw_factor = tq_avg * tq_avg;
 			tmp_gw_factor *= gw_node->bandwidth_down;
 			tmp_gw_factor *= 100 * 100;
-			tmp_gw_factor /= gw_divisor;
+			tmp_gw_factor >>= 18;
 
 			if ((tmp_gw_factor > max_gw_factor) ||
 			    ((tmp_gw_factor == max_gw_factor) &&
-- 
2.5.0

