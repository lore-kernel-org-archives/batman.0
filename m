Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:37 +0200
Message-Id: <1283644718-653-21-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 20/21] Staging: batman-adv: Don't inform
	about dropped packets in nodebug
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
Cc: b.a.t.m.a.n@lists.open-mesh.net

Information about dropped packets are usually only interesting for
debugging purposes and otherwise open the possibility to flood the logs
of the target machine with useless information.

pr_debug will not output those information on a nodebug kernel.

Reported-by: Vasiliy Kulikov <segooon@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/routing.c |   15 +++++++--------
 drivers/staging/batman-adv/vis.c     |    2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index eda08b5..e12fd99 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -859,9 +859,9 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		pr_warning("Warning - can't forward icmp packet from %pM to "
-			   "%pM: ttl exceeded\n", icmp_packet->orig,
-			   icmp_packet->dst);
+		pr_debug("Warning - can't forward icmp packet from %pM to "
+			 "%pM: ttl exceeded\n", icmp_packet->orig,
+			 icmp_packet->dst);
 		return NET_RX_DROP;
 	}
 
@@ -1141,9 +1141,9 @@ static int route_unicast_packet(struct sk_buff *skb,
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		pr_warning("Warning - can't forward unicast packet from %pM to "
-			   "%pM: ttl exceeded\n", ethhdr->h_source,
-			   unicast_packet->dest);
+		pr_debug("Warning - can't forward unicast packet from %pM to "
+			 "%pM: ttl exceeded\n", ethhdr->h_source,
+			 unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
@@ -1224,8 +1224,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 			hash_find(bat_priv->orig_hash, unicast_packet->orig));
 
 		if (!orig_node) {
-			pr_warning("couldn't find orig node for "
-				"fragmentation\n");
+			pr_debug("couldn't find orig node for fragmentation\n");
 			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
 					       flags);
 			return NET_RX_DROP;
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 071d3b7..b2cec8e 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -745,7 +745,7 @@ static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 
 	packet = (struct vis_packet *)info->skb_packet->data;
 	if (packet->ttl < 2) {
-		pr_warning("Error - can't send vis packet: ttl exceeded\n");
+		pr_debug("Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
-- 
1.7.1

