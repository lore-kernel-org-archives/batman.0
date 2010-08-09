Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  9 Aug 2010 23:56:41 +0200
Message-Id: <1281391002-21577-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281391002-21577-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] Staging: batman-adv: always reply batman
	icmp packets with primary mac
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

From: Marek Lindner <lindner_marek@yahoo.de>

When receiving an batman icmp echo request or in case of a time-to-live
exceeded batman would reply with the mac address of the outgoing
interface which might be a secondary interface. Because secondary
interfaces are not globally known this might lead to confusion.
Now, replies are sent with the mac address of the primary interface.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/routing.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 066cc91..032195e 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -783,6 +783,8 @@ int recv_bat_packet(struct sk_buff *skb,
 
 static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct orig_node *orig_node;
 	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
@@ -801,6 +803,9 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 		return NET_RX_DROP;
 	}
 
+	if (!bat_priv->primary_if)
+		return NET_RX_DROP;
+
 	/* answer echo request (ping) */
 	/* get routing information */
 	spin_lock_irqsave(&orig_hash_lock, flags);
@@ -830,7 +835,8 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 		}
 
 		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-		memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
+		memcpy(icmp_packet->orig,
+		       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 		icmp_packet->msg_type = ECHO_REPLY;
 		icmp_packet->ttl = TTL;
 
@@ -845,6 +851,8 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 
 static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct orig_node *orig_node;
 	struct icmp_packet *icmp_packet;
 	struct ethhdr *ethhdr;
@@ -865,6 +873,9 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 		return NET_RX_DROP;
 	}
 
+	if (!bat_priv->primary_if)
+		return NET_RX_DROP;
+
 	/* get routing information */
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
@@ -892,7 +903,8 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 		}
 
 		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-		memcpy(icmp_packet->orig, ethhdr->h_dest, ETH_ALEN);
+		memcpy(icmp_packet->orig,
+		       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 		icmp_packet->msg_type = TTL_EXCEEDED;
 		icmp_packet->ttl = TTL;
 
-- 
1.7.1

