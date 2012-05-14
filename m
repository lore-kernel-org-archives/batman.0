Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 May 2012 09:17:31 +0200
Message-Id: <1336979858-13928-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1336979858-13928-1-git-send-email-ordex@autistici.org>
References: <1336979858-13928-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: avoid skb_linearise() if not
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Whenever we want to access headers only, we do not need to linearise the whole
packet. Instead we can use pskb_may_pull()

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/routing.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 7ed9d8f..4c6467d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -916,8 +916,9 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
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
1.7.9.4

