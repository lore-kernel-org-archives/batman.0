Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2016 19:53:27 +0200
Message-Id: <1466445210-17616-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next v2 1/4] batman-adv: Free tp_meter ack
	skb when it was not consumed
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

batadv_send_skb_to_orig can return -1 to signal that the skb was not
consumed. tp_meter has then to free the skb to avoid a memory leak.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased on current master
 - added patch to a common set of related patches

 net/batman-adv/tp_meter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index bf6bffb..2333777 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1206,6 +1206,9 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* send the ack */
 	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (r == -1)
+		kfree_skb(skb);
+
 	if (unlikely(r < 0) || (r == NET_XMIT_DROP)) {
 		ret = BATADV_TP_REASON_DST_UNREACHABLE;
 		goto out;
-- 
2.8.1

