Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jun 2016 18:14:01 +0200
Message-Id: <1465575241-1754-2-git-send-email-sven@narfation.org>
In-Reply-To: <1465575241-1754-1-git-send-email-sven@narfation.org>
References: <1465575241-1754-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: Free tp_meter ack skb when
	it was not consumed
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
Antonio, this is not really tested. Could you please review it and tell me
if I may have missed something.

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
