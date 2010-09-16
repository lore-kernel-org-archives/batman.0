Return-Path: <an.langer@gmx.de>
From: Andreas Langer <an.langer@gmx.de>
Date: Fri, 17 Sep 2010 00:43:24 +0200
Message-Id: <1284677004-16895-1-git-send-email-an.langer@gmx.de>
In-Reply-To: <1284674410-15477-6-git-send-email-an.langer@gmx.de>
References: <1284674410-15477-6-git-send-email-an.langer@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: reassemble fragmented skb if
	mtu allows it
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

Signed-off-by: Andreas Langer <an.langer at gmx.de>
---
 batman-adv/routing.c |   21 ++++++++++++++++++++-
 batman-adv/unicast.c |    8 ++++++++
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index c763121..236ce96 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1142,6 +1142,8 @@ static int route_unicast_packet(struct sk_buff *skb,
 	unsigned long flags;
 	struct unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	int ret;
+	struct sk_buff *new_skb;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
@@ -1185,6 +1187,22 @@ static int route_unicast_packet(struct sk_buff *skb,
 		return frag_send_skb(skb, bat_priv, batman_if,
 				     dstaddr);
 
+	if (unicast_packet->packet_type == BAT_UNICAST_FRAG &&
+	    2 * skb->len - hdr_size <= batman_if->net_dev->mtu) {
+
+		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
+
+		if (ret == NET_RX_DROP)
+			return NET_RX_DROP;
+
+		/* packet was buffered for late merge */
+		if (!new_skb)
+			return NET_RX_SUCCESS;
+
+		skb = new_skb;
+		unicast_packet = (struct unicast_packet *) skb->data;
+	}
+
 	/* decrement ttl */
 	unicast_packet->ttl--;
 
@@ -1238,7 +1256,8 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		if (!new_skb)
 			return NET_RX_SUCCESS;
 
-		interface_rx(recv_if->soft_iface, new_skb, hdr_size);
+		interface_rx(recv_if->soft_iface, new_skb,
+			     sizeof(struct unicast_packet));
 		return NET_RX_SUCCESS;
 	}
 
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 25284d8..bca69f6 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -37,6 +37,9 @@ static struct sk_buff *frag_merge_packet(struct list_head *head,
 	struct unicast_frag_packet *up =
 		(struct unicast_frag_packet *)skb->data;
 	struct sk_buff *tmp_skb;
+	struct unicast_packet *unicast_packet;
+	int hdr_len = sizeof(struct unicast_packet),
+	    uni_diff = sizeof(struct unicast_frag_packet) - hdr_len;
 
 	/* set skb to the first part and tmp_skb to the second part */
 	if (up->flags & UNI_FRAG_HEAD) {
@@ -60,6 +63,11 @@ static struct sk_buff *frag_merge_packet(struct list_head *head,
 
 	memcpy(skb_put(skb, tmp_skb->len), tmp_skb->data, tmp_skb->len);
 	kfree_skb(tmp_skb);
+
+	memmove(skb->data + uni_diff, skb->data, hdr_len);
+	unicast_packet = (struct unicast_packet *) skb_pull(skb, uni_diff);
+	unicast_packet->packet_type = BAT_UNICAST;
+
 	return skb;
 }
 
-- 
1.7.0.4

