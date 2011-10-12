Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 12 Oct 2011 15:10:58 +0200
Message-Id: <1318425058-715-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1318425058-715-1-git-send-email-ordex@autistici.org>
References: <1318425058-715-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: check for tt_reponse real
	length
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
To: b.a.t.m.a.n@lists.open-mesh.org

Before accessing the TT_RESPONSE message payload, we have to ensure that the
real length of the packet reflect the claimed one (contained in
tt_response->tt_data field)

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

corrected skb length check

 routing.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/routing.c b/routing.c
index 20804f4..af55cf7 100644
--- a/routing.c
+++ b/routing.c
@@ -578,6 +578,7 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct tt_query_packet *tt_query;
+	uint16_t tt_len;
 	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
@@ -622,6 +623,18 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 			if (skb_linearize(skb) < 0)
 				goto out;
 
+			if (tt_query->flags & TT_FULL_TABLE)
+				tt_len = tt_query->tt_data * ETH_ALEN;
+			else
+				tt_len = tt_query->tt_data *
+					 sizeof(struct tt_change);
+
+			/* Ensure we have all the claimed data */
+			if (unlikely(skb_headlen(skb) <
+					sizeof(struct tt_query_packet) +
+					tt_len))
+				goto out;
+
 			handle_tt_response(bat_priv, tt_query);
 		} else {
 			bat_dbg(DBG_TT, bat_priv,
-- 
1.7.3.4

