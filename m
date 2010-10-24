Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 24 Oct 2010 03:14:23 +0200
Message-Id: <1287882863-11314-8-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201010240313.35215.lindner_marek@yahoo.de>
References: <201010240313.35215.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 8/8] batman-adv: add gateway IPv6 support by
	filtering DHCPv6 messages
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/gateway_client.c |   40 +++++++++++++++++++++++++++++++---------
 1 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index e6cd9ac..128f851 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -25,6 +25,7 @@
 #include "hard-interface.h"
 #include "compat.h"
 #include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 
@@ -404,6 +405,7 @@ int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 {
 	struct ethhdr *ethhdr;
 	struct iphdr *iphdr;
+	struct ipv6hdr *ipv6hdr;
 	struct udphdr *udphdr;
 	unsigned int header_len = 0;
 
@@ -425,17 +427,32 @@ int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	}
 
 	/* check for ip header */
-	if (ntohs(ethhdr->h_proto) != ETH_P_IP)
-		return 0;
+	switch (ntohs(ethhdr->h_proto)) {
+	case ETH_P_IP:
+		if (!pskb_may_pull(skb, header_len + sizeof(struct iphdr)))
+			return 0;
+		iphdr = (struct iphdr *)(skb->data + header_len);
+		header_len += iphdr->ihl * 4;
 
-	if (!pskb_may_pull(skb, header_len + sizeof(struct iphdr)))
-		return 0;
-	iphdr = (struct iphdr *)(skb->data + header_len);
-	header_len += iphdr->ihl * 4;
+		/* check for udp header */
+		if (iphdr->protocol != IPPROTO_UDP)
+			return 0;
+
+		break;
+	case ETH_P_IPV6:
+		if (!pskb_may_pull(skb, header_len + sizeof(struct ipv6hdr)))
+			return 0;
+		ipv6hdr = (struct ipv6hdr *)(skb->data + header_len);
+		header_len += sizeof(struct ipv6hdr);
 
-	/* check for udp header */
-	if (iphdr->protocol != IPPROTO_UDP)
+		/* check for udp header */
+		if (ipv6hdr->nexthdr != IPPROTO_UDP)
+			return 0;
+
+		break;
+	default:
 		return 0;
+	}
 
 	if (!pskb_may_pull(skb, header_len + sizeof(struct udphdr)))
 		return 0;
@@ -443,7 +460,12 @@ int gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	header_len += sizeof(struct udphdr);
 
 	/* check for bootp port */
-	if (ntohs(udphdr->dest) != 67)
+	if ((ntohs(ethhdr->h_proto) == ETH_P_IP) &&
+	     (ntohs(udphdr->dest) != 67))
+		return 0;
+
+	if ((ntohs(ethhdr->h_proto) == ETH_P_IPV6) &&
+	    (ntohs(udphdr->dest) != 547))
 		return 0;
 
 	if (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER)
-- 
1.7.1

