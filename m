Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2016 00:15:41 +0200
Message-Id: <1468793741-4606-2-git-send-email-sven@narfation.org>
In-Reply-To: <1468793741-4606-1-git-send-email-sven@narfation.org>
References: <1468793741-4606-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Reject unicast packet for
	zero/mcast recepient
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

An unicast batman-adv packet cannot be transmitted to a multicast or zero
address. So reject incoming packets which still have these classes of
addresses as destination mac address.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b648caf..44e1e80 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -353,8 +353,8 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 	ethhdr = eth_hdr(skb);
 
-	/* packet with unicast indication but broadcast recipient */
-	if (is_broadcast_ether_addr(ethhdr->h_dest))
+	/* packet with unicast indication but non-unicast recipient */
+	if (!is_valid_ether_addr(ethhdr->h_dest))
 		goto out;
 
 	/* packet with invalid sender address */
@@ -445,8 +445,8 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 
 	ethhdr = eth_hdr(skb);
 
-	/* packet with unicast indication but broadcast recipient */
-	if (is_broadcast_ether_addr(ethhdr->h_dest))
+	/* packet with unicast indication but non-unicast recipient */
+	if (!is_valid_ether_addr(ethhdr->h_dest))
 		return -EBADR;
 
 	/* packet with invalid sender address */
-- 
2.8.1

