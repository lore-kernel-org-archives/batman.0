Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:27 +0200
Message-Id: <1273261651-21378-23-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 22/26] Staging: batman-adv: Update pointer to
	ethhdr after skb_copy
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Sven Eckelmann <sven.eckelmann@gmx.de>

We must ensure that all pointer to a socket buffer are updated when we
copy a socket buffer and free our reference to the old one.
Another part of the kernel could also free its reference which maybe
removes the buffer completely. In that situation we would would feed
wrong information to the routing algorithm after the memory area is
written again by someone else.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/routing.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index bf67059..919a4f8 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -614,6 +614,7 @@ int recv_bat_packet(struct sk_buff *skb,
 		skb = skb_copy(skb, GFP_ATOMIC);
 		if (!skb)
 			return NET_RX_DROP;
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 		kfree_skb(skb_old);
 	}
 
@@ -639,8 +640,8 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
 
-	icmp_packet = (struct icmp_packet *) skb->data;
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
+	icmp_packet = (struct icmp_packet *)skb->data;
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
@@ -671,7 +672,9 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet *) skb->data;
+
+			icmp_packet = (struct icmp_packet *)skb->data;
+			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
 
@@ -732,6 +735,7 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 			if (!skb)
 				return NET_RX_DROP;
 			icmp_packet = (struct icmp_packet *) skb->data;
+			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
 
@@ -780,7 +784,7 @@ int recv_icmp_packet(struct sk_buff *skb)
 	if (!is_my_mac(ethhdr->h_dest))
 		return NET_RX_DROP;
 
-	icmp_packet = (struct icmp_packet *) skb->data;
+	icmp_packet = (struct icmp_packet *)skb->data;
 
 	/* packet for me */
 	if (is_my_mac(icmp_packet->dst))
@@ -812,7 +816,8 @@ int recv_icmp_packet(struct sk_buff *skb)
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet *) skb->data;
+			icmp_packet = (struct icmp_packet *)skb->data;
+			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
 
@@ -895,7 +900,8 @@ int recv_unicast_packet(struct sk_buff *skb)
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-			unicast_packet = (struct unicast_packet *) skb->data;
+			unicast_packet = (struct unicast_packet *)skb->data;
+			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
 		/* decrement ttl */
-- 
1.7.1

