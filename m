Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:48 +0100
Message-Id: <1290383767-32602-11-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/29] Staging: batman-adv: remove redundant
	is_my_mac() check in route_unicast_packet
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

From: Andreas Langer <an.langer@gmx.de>

Callers should check the if the received packet is for us before it
calls route_unicast_packet.

Signed-off-by: Andreas Langer <an.langer@gmx.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/routing.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index d36c3f9..9b61d6b 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -1131,12 +1131,6 @@ static int route_unicast_packet(struct sk_buff *skb,
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	/* packet for me */
-	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(recv_if->soft_iface, skb, hdr_size);
-		return NET_RX_SUCCESS;
-	}
-
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
 		pr_debug("Warning - can't forward unicast packet from %pM to "
@@ -1170,7 +1164,6 @@ static int route_unicast_packet(struct sk_buff *skb,
 		return NET_RX_DROP;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* decrement ttl */
 	unicast_packet->ttl--;
-- 
1.7.2.3

