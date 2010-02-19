Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 19 Feb 2010 16:18:06 +0100
Message-Id: <1266592691-13090-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1266592691-13090-2-git-send-email-andrew@lunn.ch>
References: <1266592691-13090-1-git-send-email-andrew@lunn.ch>
	<1266592691-13090-2-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 3/8] Staging: batman-adv: avoid having the
	same error message more than once
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
To: gregkh@suse.de
Cc: devel@linuxdriverproject.org, b.a.t.m.a.n@lists.open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

The routing code has 2 sections which warn about ttl exceeded. The
corresponding warnings were identical which makes it hard to debug. In
addition, batman-adv does not need to warn about ttl exceeded in case
we encountered an echo request as this is commonly used to generate
traceroute graphs.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/routing.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 09917e5..8abaa61 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -655,14 +655,15 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
 
-	icmp_packet = (struct icmp_packet *) skb->data;
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
-
-	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %pM to %pM: ttl exceeded\n", icmp_packet->orig, icmp_packet->dst);
+	icmp_packet = (struct icmp_packet *)skb->data;
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
-	if (icmp_packet->msg_type != ECHO_REQUEST)
+	if (icmp_packet->msg_type != ECHO_REQUEST) {
+		printk(KERN_WARNING "batman-adv:Warning - can't forward icmp packet from %pM to %pM: ttl exceeded\n",
+			icmp_packet->orig, icmp_packet->dst);
 		return NET_RX_DROP;
+	}
 
 	/* get routing information */
 	spin_lock_irqsave(&orig_hash_lock, flags);
@@ -825,7 +826,8 @@ int recv_unicast_packet(struct sk_buff *skb)
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		printk(KERN_WARNING "batman-adv:Warning - can't send packet from %pM to %pM: ttl exceeded\n", ethhdr->h_source, unicast_packet->dest);
+		printk(KERN_WARNING "batman-adv:Warning - can't forward unicast packet from %pM to %pM: ttl exceeded\n",
+		       ethhdr->h_source, unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
-- 
1.6.6.2

