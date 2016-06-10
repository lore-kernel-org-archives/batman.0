Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jun 2016 18:14:00 +0200
Message-Id: <1465575241-1754-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: Avoid skb free for
	batadv_send_skb_to_orig < -1
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

The tp_meter code frees the skb when the batadv_send_skb_to_orig returns <
0. But the batadv_send_skb_to_orig only defines -1 as return code for
failed submits with still valid skbs.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Interesting because a patch was submitted to net next to remove NET_XMIT_POLICED
and return -EINPROGRESS instead.

I will maybe later send more patches because the current way of handling
DROPPED/free'd skb/not-freed skb is quite confusing.

 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ed99afb..bf6bffb 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -615,7 +615,7 @@ static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
 	batadv_tp_fill_prerandom(tp_vars, data, data_len);
 
 	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (r < 0)
+	if (r == -1)
 		kfree_skb(skb);
 
 	if (r == NET_XMIT_SUCCESS)
