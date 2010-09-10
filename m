Return-Path: <an.langer@gmx.de>
From: Andreas Langer <an.langer@gmx.de>
Date: Fri, 10 Sep 2010 18:48:20 +0200
Message-Id: <1284137300-26277-1-git-send-email-an.langer@gmx.de>
In-Reply-To: <20100910184706.151a6728@rechenknecht>
References: <20100910184706.151a6728@rechenknecht>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: layer2 unicast packet
	fragmentation enhancements
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

This patch improves the fragmentation by also fragmenting
packets that came in via an interface which does not need
fragmentation. In addition it reassembles fragmented packets
as soon as the interface MTU allows it.

Signed-off-by: Andreas Langer <an.langer at gmx.de>
---
 batman-adv/routing.c |   64 +++++++++---------------
 batman-adv/unicast.c |  130 +++++++++++++++++++++++++++++++++-----------------
 batman-adv/unicast.h |   13 ++----
 3 files changed, 114 insertions(+), 93 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index a2c64a4..e975452 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1142,15 +1142,11 @@ static int route_unicast_packet(struct sk_buff *skb,
 	unsigned long flags;
 	struct unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	int hdr_lenght = sizeof(struct unicast_packet),
+	    uni_diff = sizeof(struct unicast_frag_packet) - hdr_lenght;
 
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
@@ -1184,7 +1180,26 @@ static int route_unicast_packet(struct sk_buff *skb,
 		return NET_RX_DROP;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	if (unicast_packet->packet_type == BAT_UNICAST &&
+	    atomic_read(&bat_priv->frag_enabled) &&
+	    skb->len > batman_if->net_dev->mtu)
+		return frag_send_skb(skb, bat_priv, batman_if,
+				     dstaddr);
+
+	if (unicast_packet->packet_type == BAT_UNICAST_FRAG &&
+	    2 * skb->len - hdr_size <= batman_if->net_dev->mtu) {
+
+		skb = frag_reassemble_skb(skb, bat_priv);
+		if (!skb)
+			return NET_RX_SUCCESS;
+
+		memmove(skb->data + uni_diff, skb->data, hdr_lenght);
+		skb_pull(skb, uni_diff);
+
+		unicast_packet = (struct unicast_packet *)skb->data;
+		unicast_packet->packet_type = BAT_UNICAST;
+	}
 
 	/* decrement ttl */
 	unicast_packet->ttl--;
@@ -1218,10 +1233,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_frag_packet *unicast_packet;
-	struct orig_node *orig_node;
-	struct frag_packet_list_entry *tmp_frag_entry;
 	int hdr_size = sizeof(struct unicast_frag_packet);
-	unsigned long flags;
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
@@ -1231,38 +1243,10 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 
-		spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
-		orig_node = ((struct orig_node *)
-			hash_find(bat_priv->orig_hash, unicast_packet->orig));
-
-		if (!orig_node) {
-			pr_debug("couldn't find orig node for fragmentation\n");
-			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
-					       flags);
-			return NET_RX_DROP;
-		}
-
-		orig_node->last_frag_packet = jiffies;
-
-		if (list_empty(&orig_node->frag_list))
-			create_frag_buffer(&orig_node->frag_list);
+		skb = frag_reassemble_skb(skb, bat_priv);
 
-		tmp_frag_entry =
-			search_frag_packet(&orig_node->frag_list,
-					   unicast_packet);
-
-		if (!tmp_frag_entry) {
-			create_frag_entry(&orig_node->frag_list, skb);
-			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
-					       flags);
-			return NET_RX_SUCCESS;
-		}
-
-		skb = merge_frag_packet(&orig_node->frag_list,
-					tmp_frag_entry, skb);
-		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 		if (!skb)
-			return NET_RX_DROP;
+			return NET_RX_SUCCESS;
 
 		interface_rx(recv_if->soft_iface, skb, hdr_size);
 		return NET_RX_SUCCESS;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 84b204b..5903692 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -30,9 +30,9 @@
 #include "hard-interface.h"
 
 
-struct sk_buff *merge_frag_packet(struct list_head *head,
-				  struct frag_packet_list_entry *tfp,
-				  struct sk_buff *skb)
+static struct sk_buff *frag_merge_packet(struct list_head *head,
+					 struct frag_packet_list_entry *tfp,
+					 struct sk_buff *skb)
 {
 	struct unicast_frag_packet *up =
 		(struct unicast_frag_packet *)skb->data;
@@ -63,7 +63,7 @@ struct sk_buff *merge_frag_packet(struct list_head *head,
 	return skb;
 }
 
-void create_frag_entry(struct list_head *head, struct sk_buff *skb)
+static void frag_create_entry(struct list_head *head, struct sk_buff *skb)
 {
 	struct frag_packet_list_entry *tfp;
 	struct unicast_frag_packet *up =
@@ -79,7 +79,7 @@ void create_frag_entry(struct list_head *head, struct sk_buff *skb)
 	return;
 }
 
-void create_frag_buffer(struct list_head *head)
+static void frag_create_buffer(struct list_head *head)
 {
 	int i;
 	struct frag_packet_list_entry *tfp;
@@ -96,7 +96,7 @@ void create_frag_buffer(struct list_head *head)
 	return;
 }
 
-struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
+static struct frag_packet_list_entry *frag_search_packet(struct list_head *head,
 						 struct unicast_frag_packet *up)
 {
 	struct frag_packet_list_entry *tfp;
@@ -149,55 +149,94 @@ void frag_list_free(struct list_head *head)
 	return;
 }
 
-static int unicast_send_frag_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			  struct batman_if *batman_if, uint8_t dstaddr[],
-			  struct orig_node *orig_node)
+/* if matching fragment found return reassembled skb
+   otherwise buffer the fragment */
+struct sk_buff *frag_reassemble_skb(struct sk_buff *skb,
+				    struct bat_priv *bat_priv)
 {
-	struct unicast_frag_packet *ucast_frag1, *ucast_frag2;
-	int hdr_len = sizeof(struct unicast_frag_packet);
+	unsigned long flags;
+	struct orig_node *orig_node;
+	struct frag_packet_list_entry *tmp_frag_entry;
+	struct sk_buff *ret = NULL;
+
+	struct unicast_frag_packet *unicast_packet =
+		(struct unicast_frag_packet *)skb->data;
+
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	orig_node = ((struct orig_node *)
+		    hash_find(bat_priv->orig_hash, unicast_packet->orig));
+
+	if (!orig_node) {
+		pr_debug("couldn't find originator in orig_hash\n");
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+		return NULL;
+	}
+
+	orig_node->last_frag_packet = jiffies;
+
+	if (list_empty(&orig_node->frag_list))
+		frag_create_buffer(&orig_node->frag_list);
+
+	tmp_frag_entry = frag_search_packet(&orig_node->frag_list,
+					    unicast_packet);
+
+	if (!tmp_frag_entry) {
+		frag_create_entry(&orig_node->frag_list, skb);
+		goto out;
+	}
+
+	ret = frag_merge_packet(&orig_node->frag_list, tmp_frag_entry, skb);
+out:
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+
+	return ret;
+}
+
+int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+		  struct batman_if *batman_if, uint8_t dstaddr[])
+{
+	struct unicast_packet tmp_uc, *unicast_packet;
 	struct sk_buff *frag_skb;
+	struct unicast_frag_packet *frag1, *frag2;
+	int uc_hdr_len = sizeof(struct unicast_packet);
+	int ucf_hdr_len = sizeof(struct unicast_frag_packet);
 	int data_len = skb->len;
 
-	if (!bat_priv->primary_if)
-		goto dropped;
+	unicast_packet = (struct unicast_packet *) skb->data;
 
-	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + hdr_len);
+	memcpy(&tmp_uc, unicast_packet, uc_hdr_len);
+	frag_skb = dev_alloc_skb(data_len - (data_len / 2) + ucf_hdr_len);
 	skb_split(skb, frag_skb, data_len / 2);
 
-	if (my_skb_head_push(frag_skb, hdr_len) < 0 ||
-	    my_skb_head_push(skb, hdr_len) < 0)
-		goto drop_frag;
+	if (my_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
+	    my_skb_head_push(frag_skb, ucf_hdr_len) < 0) {
+		kfree_skb(frag_skb);
+		return NET_RX_DROP;
+	}
 
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
-
-drop_frag:
-	kfree_skb(frag_skb);
-dropped:
-	kfree_skb(skb);
-	return 1;
+	return NET_RX_SUCCESS;
 }
 
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
@@ -240,11 +279,6 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	if (batman_if->if_status != IF_ACTIVE)
 		goto dropped;
 
-	if (atomic_read(&bat_priv->frag_enabled) &&
-	    data_len + sizeof(struct unicast_packet) > batman_if->net_dev->mtu)
-		return unicast_send_frag_skb(skb, bat_priv, batman_if,
-					     dstaddr, orig_node);
-
 	if (my_skb_head_push(skb, sizeof(struct unicast_packet)) < 0)
 		goto dropped;
 
@@ -258,6 +292,14 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
+	if (atomic_read(&bat_priv->frag_enabled) &&
+	    data_len + sizeof(struct unicast_packet) >
+	    batman_if->net_dev->mtu) {
+		/* send frag skb decrease ttl */
+		unicast_packet->ttl++;
+		return frag_send_skb(skb, bat_priv, batman_if,
+				     dstaddr);
+	}
 	send_skb_packet(skb, batman_if, dstaddr);
 	return 0;
 
diff --git a/batman-adv/unicast.h b/batman-adv/unicast.h
index 1d5cbeb..d1a606f 100644
--- a/batman-adv/unicast.h
+++ b/batman-adv/unicast.h
@@ -25,15 +25,10 @@
 #define FRAG_TIMEOUT 10000	/* purge frag list entrys after time in ms */
 #define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
 
-struct sk_buff *merge_frag_packet(struct list_head *head,
-	struct frag_packet_list_entry *tfp,
-	struct sk_buff *skb);
-
-void create_frag_entry(struct list_head *head, struct sk_buff *skb);
-void create_frag_buffer(struct list_head *head);
-struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
-	struct unicast_frag_packet *up);
 void frag_list_free(struct list_head *head);
+struct sk_buff *frag_reassemble_skb(struct sk_buff *skb,
+				    struct bat_priv *bat_priv);
+int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+		  struct batman_if *batman_if, uint8_t dstaddr[]);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
-
 #endif /* _NET_BATMAN_ADV_UNICAST_H_ */
-- 
1.7.0.4

