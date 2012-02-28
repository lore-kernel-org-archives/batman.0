Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Feb 2012 11:13:45 +0100
Message-Id: <1330424025-3210-1-git-send-email-sven@narfation.org>
In-Reply-To: <1330422936-1668-1-git-send-email-sven@narfation.org>
References: <1330422936-1668-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix indentation of multiline
	statements
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

79b67f7add9982115e801e99fcfa92f27ff7bb12 and
0591c25abca985273be2aa47d128df0648184abd introduced a regression of the
indentation of multiline statements.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is for *master* after next (with the last patch) was merged into
master. I can also push both patches (the merge is not conflict free).

 distributed-arp-table.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index a22bcda..8a20961 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -298,6 +298,7 @@ static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb,
 {
 	struct arphdr *arphdr;
 	struct ethhdr *ethhdr;
+	uint32_t ip_src, ip_dst;
 	uint16_t type = 0;
 
 	/* pull the ethernet header */
@@ -332,10 +333,10 @@ static uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb,
 
 	/* Check for bad reply/request. If the ARP message is not sane, DAT
 	 * will simply ignore it */
-	if (ipv4_is_loopback(ARP_IP_SRC(skb, hdr_size)) ||
-	    ipv4_is_multicast(ARP_IP_SRC(skb, hdr_size)) ||
-	    ipv4_is_loopback(ARP_IP_DST(skb, hdr_size)) ||
-	    ipv4_is_multicast(ARP_IP_DST(skb, hdr_size)))
+	ip_src = ARP_IP_SRC(skb, hdr_size);
+	ip_dst = ARP_IP_DST(skb, hdr_size);
+	if (ipv4_is_loopback(ip_src) || ipv4_is_multicast(ip_src) ||
+	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst))
 		goto out;
 
 	type = ntohs(arphdr->ar_op);
@@ -538,9 +539,8 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 	/* If this packet is an ARP_REQUEST and we already have the information
 	 * that it is going to ask, we can drop the packet */
 	if (!forw_packet->num_packets &&
-			(arp_get_type(bat_priv, forw_packet->skb,
-				      sizeof(struct bcast_packet)) ==
-							ARPOP_REQUEST)) {
+	    (ARPOP_REQUEST == arp_get_type(bat_priv, forw_packet->skb,
+					   sizeof(struct bcast_packet)))) {
 		n = neigh_lookup(&arp_tbl,
 				 &ARP_IP_DST(forw_packet->skb,
 					     sizeof(struct bcast_packet)),
-- 
1.7.9

