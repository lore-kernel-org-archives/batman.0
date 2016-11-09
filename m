Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  9 Nov 2016 23:26:04 +0100
Message-Id: <20161109222606.29039-16-sw@simonwunderlich.de>
In-Reply-To: <20161109222606.29039-1-sw@simonwunderlich.de>
References: <20161109222606.29039-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 15/17] batman-adv: Disallow mcast src address
	for data frames
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

The routing checks are validating the source mac address of the outer
ethernet header. They reject every source mac address which is a broadcast
address. But they also have to reject any multicast mac addresses.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
[sw@simonwunderlich.de: fix commit message typo]
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 105d4fc..c02897b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -368,8 +368,8 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		goto free_skb;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with broadcast/multicast sender address */
+	if (is_multicast_ether_addr(ethhdr->h_source))
 		goto free_skb;
 
 	/* not for me */
@@ -466,8 +466,8 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
 		return -EBADR;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with broadcast/multicast sender address */
+	if (is_multicast_ether_addr(ethhdr->h_source))
 		return -EBADR;
 
 	/* not for me */
@@ -1159,8 +1159,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		goto free_skb;
 
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
+	/* packet with broadcast/multicast sender address */
+	if (is_multicast_ether_addr(ethhdr->h_source))
 		goto free_skb;
 
 	/* ignore broadcasts sent by myself */
-- 
2.10.1

