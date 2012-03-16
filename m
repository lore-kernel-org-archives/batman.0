Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 16 Mar 2012 11:52:31 +0100
Message-Id: <1331895151-22510-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: avoid skb_linearise() if not
	needed
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

Whenever we want to access headers only, we do not need to linearise the whole
packet. Instead we can use pskb_may_pull()

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 routing.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/routing.c b/routing.c
index 962a315..576ffb1 100644
--- a/routing.c
+++ b/routing.c
@@ -915,8 +915,9 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
 	/* Check whether I have to reroute the packet */
 	if (seq_before(unicast_packet->ttvn, curr_ttvn) || tt_poss_change) {
-		/* Linearize the skb before accessing it */
-		if (skb_linearize(skb) < 0)
+		/* check if there is enough data before accessing it */
+		if (pskb_may_pull(skb, sizeof(struct unicast_packet) +
+				  ETH_HLEN) < 0)
 			return 0;
 
 		ethhdr = (struct ethhdr *)(skb->data +
-- 
1.7.3.4

