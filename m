Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 16 Oct 2011 20:32:02 +0200
Message-Id: <1318789923-29405-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 1/3] batman-adv: linearise the tt_response
	skb only if needed
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

The TT_RESPONSE skb has to be linearised only if the node plans to access the
packet payload (so only if the message is directed to that node). In all the
other cases the node can avoid this memory operation

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/routing.c b/routing.c
index 60ce407..e0e7b7b 100644
--- a/routing.c
+++ b/routing.c
@@ -616,13 +616,14 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 		}
 		break;
 	case TT_RESPONSE:
-		/* packet needs to be linearized to access the TT changes */
-		if (skb_linearize(skb) < 0)
-			goto out;
+		if (is_my_mac(tt_query->dst)) {
+			/* packet needs to be linearized to access the TT
+			 * changes */
+			if (skb_linearize(skb) < 0)
+				goto out;
 
-		if (is_my_mac(tt_query->dst))
 			handle_tt_response(bat_priv, tt_query);
-		else {
+		} else {
 			bat_dbg(DBG_TT, bat_priv,
 				"Routing TT_RESPONSE to %pM [%c]\n",
 				tt_query->dst,
-- 
1.7.3.4

