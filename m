Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 12 Oct 2011 15:10:57 +0200
Message-Id: <1318425058-715-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: linearise the tt_response
	only if needed
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

The TT_RESPONSE message can be linearised only if we plan to access the tt
payload (only if the message is directed to me). In all the other cases we can
avoid this memory operation

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

corrected typo in the commit message

 routing.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/routing.c b/routing.c
index f961cc5..20804f4 100644
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

