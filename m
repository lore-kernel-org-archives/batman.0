Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri,  2 Dec 2011 17:38:52 +0100
Message-Id: <1322843932-21385-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: format multi-line if in the
	correct way
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

in an multi-line if statement leading edges should line up to the opening
parenthesis

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/routing.c b/routing.c
index d5ddbd1..4363d19 100644
--- a/routing.c
+++ b/routing.c
@@ -627,8 +627,7 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 			/* Ensure we have all the claimed data */
 			if (unlikely(skb_headlen(skb) <
-					sizeof(struct tt_query_packet) +
-					tt_len))
+				     sizeof(struct tt_query_packet) + tt_len))
 				goto out;
 
 			handle_tt_response(bat_priv, tt_query);
-- 
1.7.3.4

