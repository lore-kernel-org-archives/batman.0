Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 18 Jun 2012 22:39:06 +0200
Message-Id: <1340051963-14836-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1340051963-14836-1-git-send-email-ordex@autistici.org>
References: <1340051963-14836-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/19] batman-adv: fix skb->data assignment
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org

skb_linearize(skb) possibly rearranges the skb internal data and then changes
the skb->data pointer value. For this reason any other pointer in the code that
was assigned skb->data before invoking skb_linearise(skb) must be re-assigned.

In the current tt_query message handling code this is not done and therefore, in
case of skb linearization, the pointer used to handle the packet header ends up
in pointing to poisoned memory. The packet is then dropped but the
translation-table mechanism is corrupted.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 840e2c6..015471d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -617,6 +617,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 			 * changes */
 			if (skb_linearize(skb) < 0)
 				goto out;
+			/* skb_linearize() possibly changed skb->data */
+			tt_query = (struct tt_query_packet *)skb->data;
 
 			tt_len = tt_query->tt_data * sizeof(struct tt_change);
 
-- 
1.7.9.4

