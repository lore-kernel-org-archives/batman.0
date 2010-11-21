Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:45 +0100
Message-Id: <1290383767-32602-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 07/29] Staging: batman-adv: restructure
	fragmentation to handle batman unicast packets
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

The unicast_frag_send_skb() function expected 'raw' packets (without any
batman-adv header) to fragment them. This needs to be changed, so that
this function is able to fragment packets that already traveled inside
the mesh but need to be fragmented now.

Signed-off-by: Andreas Langer <an.langer@gmx.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/unicast.c |   66 ++++++++++++++++++---------------
 1 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index 0459413..58bf2b6 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -152,55 +152,58 @@ void frag_list_free(struct list_head *head)
 	return;
 }
 
-static int unicast_send_frag_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			  struct batman_if *batman_if, uint8_t dstaddr[],
-			  struct orig_node *orig_node)
+static int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			 struct batman_if *batman_if, uint8_t dstaddr[])
 {
-	struct unicast_frag_packet *ucast_frag1, *ucast_frag2;
-	int hdr_len = sizeof(struct unicast_frag_packet);
+	struct unicast_packet tmp_uc, *unicast_packet;
 	struct sk_buff *frag_skb;
+	struct unicast_frag_packet *frag1, *frag2;
+	int uc_hdr_len = sizeof(struct unicast_packet);
+	int ucf_hdr_len = sizeof(struct unicast_frag_packet);
 	int data_len = skb->len;
 
 	if (!bat_priv->primary_if)
 		goto dropped;
 
-	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + hdr_len);
+	unicast_packet = (struct unicast_packet *) skb->data;
+
+	memcpy(&tmp_uc, unicast_packet, uc_hdr_len);
+	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + ucf_hdr_len);
 	skb_split(skb, frag_skb, data_len / 2);
 
-	if (my_skb_head_push(frag_skb, hdr_len) < 0 ||
-	    my_skb_head_push(skb, hdr_len) < 0)
+	if (my_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
+	    my_skb_head_push(frag_skb, ucf_hdr_len) < 0)
 		goto drop_frag;
 
-	ucast_frag1 = (struct unicast_frag_packet *)skb->data;
-	ucast_frag2 = (struct unicast_frag_packet *)frag_skb->data;
+	frag1 = (struct unicast_frag_packet *)skb->data;
+	frag2 = (struct unicast_frag_packet *)frag_skb->data;
 
-	ucast_frag1->version = COMPAT_VERSION;
-	ucast_frag1->packet_type = BAT_UNICAST_FRAG;
-	ucast_frag1->ttl = TTL;
-	memcpy(ucast_frag1->orig,
-	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
-	memcpy(ucast_frag1->dest, orig_node->orig, ETH_ALEN);
+	memcpy(frag1, &tmp_uc, sizeof(struct unicast_packet));
 
-	memcpy(ucast_frag2, ucast_frag1, sizeof(struct unicast_frag_packet));
+	frag1->ttl--;
+	frag1->version = COMPAT_VERSION;
+	frag1->packet_type = BAT_UNICAST_FRAG;
 
-	ucast_frag1->flags |= UNI_FRAG_HEAD;
-	ucast_frag2->flags &= ~UNI_FRAG_HEAD;
+	memcpy(frag1->orig, bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(frag2, frag1, sizeof(struct unicast_frag_packet));
 
-	ucast_frag1->seqno = htons((uint16_t)atomic_inc_return(
-						&batman_if->frag_seqno));
+	frag1->flags |= UNI_FRAG_HEAD;
+	frag2->flags &= ~UNI_FRAG_HEAD;
 
-	ucast_frag2->seqno = htons((uint16_t)atomic_inc_return(
-						&batman_if->frag_seqno));
+	frag1->seqno = htons((uint16_t)atomic_inc_return(
+			     &batman_if->frag_seqno));
+	frag2->seqno = htons((uint16_t)atomic_inc_return(
+			     &batman_if->frag_seqno));
 
 	send_skb_packet(skb, batman_if, dstaddr);
 	send_skb_packet(frag_skb, batman_if, dstaddr);
-	return 0;
+	return NET_RX_SUCCESS;
 
 drop_frag:
 	kfree_skb(frag_skb);
 dropped:
 	kfree_skb(skb);
-	return 1;
+	return NET_RX_DROP;
 }
 
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
@@ -240,11 +243,6 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	if (batman_if->if_status != IF_ACTIVE)
 		goto dropped;
 
-	if (atomic_read(&bat_priv->frag_enabled) &&
-	    data_len + sizeof(struct unicast_packet) > batman_if->net_dev->mtu)
-		return unicast_send_frag_skb(skb, bat_priv, batman_if,
-					     dstaddr, orig_node);
-
 	if (my_skb_head_push(skb, sizeof(struct unicast_packet)) < 0)
 		goto dropped;
 
@@ -258,6 +256,14 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
+	if (atomic_read(&bat_priv->frag_enabled) &&
+	    data_len + sizeof(struct unicast_packet) >
+	    batman_if->net_dev->mtu) {
+		/* send frag skb decreases ttl */
+		unicast_packet->ttl++;
+		return frag_send_skb(skb, bat_priv, batman_if,
+				     dstaddr);
+	}
 	send_skb_packet(skb, batman_if, dstaddr);
 	return 0;
 
-- 
1.7.2.3

