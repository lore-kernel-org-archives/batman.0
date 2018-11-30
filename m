Return-Path: <wen.yang99@zte.com.cn>
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Fri, 30 Nov 2018 15:00:02 +0800
Message-Id: <1543561202-614-1-git-send-email-wen.yang99@zte.com.cn>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix null pointer dereference in
 batadv_gw_election
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn, wen.yang99@zte.com.cn

This patch fixes a possible null pointer dereference in
batadv_gw_election, detected by the semantic patch
deref_null.cocci, with the following warning:

./net/batman-adv/gateway_client.c:289:15-24: ERROR: next_gw is NULL but dereferenced.
./net/batman-adv/gateway_client.c:290:15-29: ERROR: next_gw is NULL but dereferenced.
./net/batman-adv/gateway_client.c:291:15-29: ERROR: next_gw is NULL but dereferenced.
./net/batman-adv/gateway_client.c:292:15-27: ERROR: next_gw is NULL but dereferenced.
./net/batman-adv/gateway_client.c:293:15-27: ERROR: next_gw is NULL but dereferenced.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
---
 net/batman-adv/gateway_client.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 140c61a..d80ef1c 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -284,14 +284,16 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
 				    gw_addr);
 	} else {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Changing route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, tq: %i)\n",
-			   next_gw->orig_node->orig,
-			   next_gw->bandwidth_down / 10,
-			   next_gw->bandwidth_down % 10,
-			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10,
-			   router_ifinfo->bat_iv.tq_avg);
+		if (next_gw) {
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Changing route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, tq: %i)\n",
+				    next_gw->orig_node->orig,
+				    next_gw->bandwidth_down / 10,
+				    next_gw->bandwidth_down % 10,
+				    next_gw->bandwidth_up / 10,
+				    next_gw->bandwidth_up % 10,
+				    router_ifinfo->bat_iv.tq_avg);
+		}
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_CHANGE,
 				    gw_addr);
 	}
-- 
2.9.5

