Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sat, 22 Jan 2011 02:21:37 +0100
Message-Id: <1295659302-7171-15-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 14/19] batman-adv: Export broadcast packet
	ethernet header checks
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

We need to check similar things for BAT_MCAST packets later too,
therefore moving them to a seperate function.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 routing.c |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 944dc94..9482db2 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1278,6 +1278,31 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
+static int check_broadcast_packet(struct sk_buff *skb, int hdr_size)
+{
+	struct ethhdr *ethhdr;
+
+	/* drop packet if it has not necessary minimum size */
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
+		return -1;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* packet with broadcast indication but unicast recipient */
+	if (!is_broadcast_ether_addr(ethhdr->h_dest))
+		return -1;
+
+	/* packet with broadcast sender address */
+	if (is_broadcast_ether_addr(ethhdr->h_source))
+		return -1;
+
+	/* ignore broadcasts sent by myself */
+	if (is_my_mac(ethhdr->h_source))
+		return -1;
+
+	return 0;
+}
+
 int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 			 int hdr_size)
 {
@@ -1425,27 +1450,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node = NULL;
 	struct bcast_packet *bcast_packet;
-	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct bcast_packet);
 	int ret = NET_RX_DROP;
 	int32_t seq_diff;
 
-	/* drop packet if it has not necessary minimum size */
-	if (unlikely(!pskb_may_pull(skb, hdr_size)))
-		goto out;
-
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
-
-	/* packet with broadcast indication but unicast recipient */
-	if (!is_broadcast_ether_addr(ethhdr->h_dest))
-		goto out;
-
-	/* packet with broadcast sender address */
-	if (is_broadcast_ether_addr(ethhdr->h_source))
-		goto out;
-
-	/* ignore broadcasts sent by myself */
-	if (is_my_mac(ethhdr->h_source))
+	if (check_broadcast_packet(skb, hdr_size) < 0)
 		goto out;
 
 	bcast_packet = (struct bcast_packet *)skb->data;
-- 
1.7.2.3

