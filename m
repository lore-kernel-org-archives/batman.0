Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 26 Apr 2010 01:24:13 +0200
Message-Id: <1272237853-26242-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Update pointer to ethhdr after
	skb_copy
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

We must ensure that all pointer to a socket buffer are updated when we
copy a socket buffer and free our reference to the old one.
Another part of the kernel could also free its reference which maybe
removes the buffer completely. In that situation we would would feed
wrong information to the routing algorithm after the memory area is
written again by someone else.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/routing.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index d717999..53749d3 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -747,6 +747,7 @@ int recv_bat_packet(struct sk_buff *skb,
 		skb = skb_copy(skb, GFP_ATOMIC);
 		if (!skb)
 			return NET_RX_DROP;
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 		kfree_skb(skb_old);
 	}
 
@@ -805,6 +806,7 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 			if (!skb)
 				return NET_RX_DROP;
 			icmp_packet = (struct icmp_packet_rr *)skb->data;
+			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
 
@@ -865,6 +867,7 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 			if (!skb)
 				return NET_RX_DROP;
 			icmp_packet = (struct icmp_packet *) skb->data;
+			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
 
@@ -960,6 +963,7 @@ int recv_icmp_packet(struct sk_buff *skb)
 			if (!skb)
 				return NET_RX_DROP;
 			icmp_packet = (struct icmp_packet_rr *)skb->data;
+			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
 
@@ -1106,6 +1110,7 @@ int recv_unicast_packet(struct sk_buff *skb)
 		if (!skb)
 			return NET_RX_DROP;
 		unicast_packet = (struct unicast_packet *) skb->data;
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 		kfree_skb(skb_old);
 	}
 
-- 
1.7.0.5

