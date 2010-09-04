Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:28 +0200
Message-Id: <1283644718-653-12-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 11/21] Staging: batman-adv: Keep header
	writable and unshared
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

my_skb_push provided an easy way to allocate enough headroom in
situation were we don't have enough space left and move the data pointer
to the new position, but we didn't checked wether we are allowed to
write to the new pushed header. This is for example a problem when the
skb was cloned and thus doesn't have a private data part.

my_skb_head_push now replaces my_skb_push by using skb_cow_head to
provide only a large enough, writable header without testing for the
rest of the (maybe shared) data. It will also move the data pointer
using skb_push when skb_cow_head doesn't fail.

This should give us enough flexibility in situation were skbs will be
queued by underlying layers and still doesn't unnecessarily copy the
data in situations when the skb was consumed right away during
dev_queue_xmit.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/send.c           |    2 +-
 drivers/staging/batman-adv/soft-interface.c |   26 ++++++++++++++------------
 drivers/staging/batman-adv/soft-interface.h |    2 +-
 drivers/staging/batman-adv/unicast.c        |    6 +++---
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index e874cae..b39c67b 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -73,7 +73,7 @@ int send_skb_packet(struct sk_buff *skb,
 	}
 
 	/* push to the ethernet header. */
-	if (my_skb_push(skb, sizeof(struct ethhdr)) < 0)
+	if (my_skb_head_push(skb, sizeof(struct ethhdr)) < 0)
 		goto send_skb_err;
 
 	skb_reset_mac_header(skb);
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index d60b1a8..e8be209 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -31,8 +31,6 @@
 
 static uint32_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
 				  * broadcast storms */
-static int32_t skb_packets;
-static int32_t skb_bad_packets;
 
 unsigned char main_if_addr[ETH_ALEN];
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
@@ -59,18 +57,22 @@ void set_main_if_addr(uint8_t *addr)
 	memcpy(main_if_addr, addr, ETH_ALEN);
 }
 
-int my_skb_push(struct sk_buff *skb, unsigned int len)
+int my_skb_head_push(struct sk_buff *skb, unsigned int len)
 {
-	int result = 0;
+	int result;
 
-	skb_packets++;
-	if (skb_headroom(skb) < len) {
-		skb_bad_packets++;
-		result = pskb_expand_head(skb, len, 0, GFP_ATOMIC);
+	/**
+	 * TODO: We must check if we can release all references to non-payload
+	 * data using skb_header_release in our skbs to allow skb_cow_header to
+	 * work optimally. This means that those skbs are not allowed to read
+	 * or write any data which is before the current position of skb->data
+	 * after that call and thus allow other skbs with the same data buffer
+	 * to write freely in that area.
+	 */
+	result = skb_cow_head(skb, len);
 
-		if (result < 0)
-			return result;
-	}
+	if (result < 0)
+		return result;
 
 	skb_push(skb, len);
 	return 0;
@@ -140,7 +142,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	/* ethernet packet should be broadcasted */
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
 
-		if (my_skb_push(skb, sizeof(struct bcast_packet)) < 0)
+		if (my_skb_head_push(skb, sizeof(struct bcast_packet)) < 0)
 			goto dropped;
 
 		bcast_packet = (struct bcast_packet *)skb->data;
diff --git a/drivers/staging/batman-adv/soft-interface.h b/drivers/staging/batman-adv/soft-interface.h
index 6364854..9dbf5fc 100644
--- a/drivers/staging/batman-adv/soft-interface.h
+++ b/drivers/staging/batman-adv/soft-interface.h
@@ -26,7 +26,7 @@ void set_main_if_addr(uint8_t *addr);
 void interface_setup(struct net_device *dev);
 int interface_tx(struct sk_buff *skb, struct net_device *dev);
 void interface_rx(struct sk_buff *skb, int hdr_size);
-int my_skb_push(struct sk_buff *skb, unsigned int len);
+int my_skb_head_push(struct sk_buff *skb, unsigned int len);
 
 extern unsigned char main_if_addr[];
 
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index 153914e..61ebd38 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -163,8 +163,8 @@ static int unicast_send_frag_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + hdr_len);
 	skb_split(skb, frag_skb, data_len / 2);
 
-	if (my_skb_push(frag_skb, hdr_len) < 0 ||
-	    my_skb_push(skb, hdr_len) < 0)
+	if (my_skb_head_push(frag_skb, hdr_len) < 0 ||
+	    my_skb_head_push(skb, hdr_len) < 0)
 		goto drop_frag;
 
 	ucast_frag1 = (struct unicast_frag_packet *)skb->data;
@@ -240,7 +240,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 		return unicast_send_frag_skb(skb, bat_priv, batman_if,
 					     dstaddr, orig_node);
 
-	if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
+	if (my_skb_head_push(skb, sizeof(struct unicast_packet)) < 0)
 		goto dropped;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
-- 
1.7.1

