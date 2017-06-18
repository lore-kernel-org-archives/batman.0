Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Jun 2017 10:12:30 +0200
Message-Id: <20170618081230.31596-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove too short %pM printk
 field width
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

The string representation for a mac address produced by %pM is 16
characters long. Left-aligning the output in a 15 character wide field with
%-15pM is therefore misleading and unnecessary.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This change should be placed near 
https://git.open-mesh.org/batman-adv.git/commit/ea9e7718812648894c2aeca3cd4733d4f29f21e9

 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 8769fa1b..83ba5483 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1279,7 +1279,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	batadv_ogm_packet->tq = combined_tq;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, iface_penalty: %3i, total tq: %3i, if_incoming = %s, if_outgoing = %s\n",
+		   "bidirectional: orig = %pM neigh = %pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, iface_penalty: %3i, total tq: %3i, if_incoming = %s, if_outgoing = %s\n",
 		   orig_node->orig, orig_neigh_node->orig, total_count,
 		   neigh_rq_count, tq_own, tq_asym_penalty, tq_iface_penalty,
 		   batadv_ogm_packet->tq, if_incoming->net_dev->name,
-- 
2.11.0

