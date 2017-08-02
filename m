Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  2 Aug 2017 16:23:19 +0200
Message-Id: <20170802142322.13376-4-sw@simonwunderlich.de>
In-Reply-To: <20170802142322.13376-1-sw@simonwunderlich.de>
References: <20170802142322.13376-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: Remove too short %pM printk
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The string representation for a mac address produced by %pM is 17
characters long. Left-aligning the output in a 15 character wide field
width %-15pM is therefore misleading and unnecessary.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a3501173e200..c27001d38574 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1281,7 +1281,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	batadv_ogm_packet->tq = combined_tq;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, iface_penalty: %3i, total tq: %3i, if_incoming = %s, if_outgoing = %s\n",
+		   "bidirectional: orig = %pM neigh = %pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, iface_penalty: %3i, total tq: %3i, if_incoming = %s, if_outgoing = %s\n",
 		   orig_node->orig, orig_neigh_node->orig, total_count,
 		   neigh_rq_count, tq_own, tq_asym_penalty, tq_iface_penalty,
 		   batadv_ogm_packet->tq, if_incoming->net_dev->name,
-- 
2.11.0

