Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  1 Aug 2010 23:20:13 +0200
Message-Id: <1280697613-32001-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1280697613-32001-1-git-send-email-sven.eckelmann@gmx.de>
References: <1280697613-32001-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: Fix wrong memory access in
	gw_is_target
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

gw_is_target tries to access the data in a udp header without checking
if there is enough data available inside the linear skb head.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/gateway_client.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index f50bc41..2ab8b6b 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -399,6 +399,7 @@ bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	struct ethhdr *ethhdr;
 	struct iphdr *iphdr;
 	struct udphdr *udphdr;
+	unsigned int header_len = 0;
 
 	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
 		return false;
@@ -406,22 +407,39 @@ bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	if (!curr_gateway)
 		return false;
 
+	/* check for ethernet header */
+	if (!pskb_may_pull(skb, header_len + ETH_HLEN))
+		return false;
 	ethhdr = (struct ethhdr *)skb->data;
+	header_len += ETH_HLEN;
 
-	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q)
+	/* check for initial vlan header */
+	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
+		if (!pskb_may_pull(skb, header_len + VLAN_HLEN))
+			return false;
 		ethhdr = (struct ethhdr *)(skb->data + VLAN_HLEN);
+		header_len += VLAN_HLEN;
+	}
 
+	/* check for ip header */
 	if (ntohs(ethhdr->h_proto) != ETH_P_IP)
 		return false;
 
-	iphdr = (struct iphdr *)(((unsigned char *)ethhdr) + ETH_HLEN);
+	if (!pskb_may_pull(skb, header_len + sizeof(struct iphdr)))
+		return false;
+	iphdr = (struct iphdr *)(skb->data + header_len);
+	header_len += iphdr->ihl * 4;
 
+	/* check for udp header */
 	if (iphdr->protocol != IPPROTO_UDP)
 		return false;
 
-	udphdr = (struct udphdr *)(((unsigned char *)iphdr) +
-						(iphdr->ihl * 4));
+	if (!pskb_may_pull(skb, header_len + sizeof(struct udphdr)))
+		return false;
+	udphdr = (struct udphdr *)(skb->data + header_len);
+	header_len += sizeof(struct udphdr);
 
+	/* check for bootp port */
 	if (ntohs(udphdr->dest) != 67)
 		return false;
 
-- 
1.7.1

