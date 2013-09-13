Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 13 Sep 2013 18:08:10 +0200
Message-Id: <1379088490-2693-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: generalize batman-adv icmp
	packet handling
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Instead of handling icmp packets only up to length of icmp_packet_rr,
the code should handle any icmp length size. Therefore the length
truncating is moved to when the packet is actually sent to userspace
(this does not support lengths longer than icmp_packet_rr yet). Longer
packets are forwarded without truncating.

This patch also cleans up some parts where the icmp header struct could
be used instead of other icmp_packet(_rr) structs to make the code more
readable.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 icmp_socket.c |   38 ++++++++++++++++++++-------
 icmp_socket.h |    2 +-
 routing.c     |   80 +++++++++++++++++++++++++++++++++++----------------------
 3 files changed, 79 insertions(+), 41 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index 82ac647..3c1125e 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -29,7 +29,7 @@
 static struct batadv_socket_client *batadv_socket_client_hash[256];
 
 static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
-				     struct batadv_icmp_packet_rr *icmp_packet,
+				     struct batadv_icmp_header *icmph,
 				     size_t icmp_len);
 
 void batadv_socket_init(void)
@@ -211,7 +211,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	if (icmp_packet->icmph.header.version != BATADV_COMPAT_VERSION) {
 		icmp_packet->icmph.msg_type = BATADV_PARAMETER_PROBLEM;
 		icmp_packet->icmph.header.version = BATADV_COMPAT_VERSION;
-		batadv_socket_add_packet(socket_client, icmp_packet,
+		batadv_socket_add_packet(socket_client, &icmp_packet->icmph,
 					 packet_len);
 		goto free_skb;
 	}
@@ -245,7 +245,8 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 
 dst_unreach:
 	icmp_packet->icmph.msg_type = BATADV_DESTINATION_UNREACHABLE;
-	batadv_socket_add_packet(socket_client, icmp_packet, packet_len);
+	batadv_socket_add_packet(socket_client, &icmp_packet->icmph,
+				 packet_len);
 free_skb:
 	kfree_skb(skb);
 out:
@@ -298,19 +299,32 @@ err:
 	return -ENOMEM;
 }
 
+/**
+ * batadv_socket_receive_packet - schedule an icmp packet to be sent to userspace
+ *  on an icmp socket.
+ * @socket_client: the socket this packet belongs to
+ * @icmph: pointer to the header of the icmp packet
+ * @icmp_len: total length of the icmp packet
+ */
 static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
-				     struct batadv_icmp_packet_rr *icmp_packet,
+				     struct batadv_icmp_header *icmph,
 				     size_t icmp_len)
 {
 	struct batadv_socket_packet *socket_packet;
+	size_t len;
 
 	socket_packet = kmalloc(sizeof(*socket_packet), GFP_ATOMIC);
 
 	if (!socket_packet)
 		return;
 
+	len = icmp_len;
+	/* check the maximum length before filling the buffer */
+	if (len > sizeof(socket_packet->icmp_packet))
+		len = sizeof(socket_packet->icmp_packet);
+
 	INIT_LIST_HEAD(&socket_packet->list);
-	memcpy(&socket_packet->icmp_packet, icmp_packet, icmp_len);
+	memcpy(&socket_packet->icmp_packet, icmph, icmp_len);
 	socket_packet->icmp_len = icmp_len;
 
 	spin_lock_bh(&socket_client->lock);
@@ -318,7 +332,7 @@ static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
 	/* while waiting for the lock the socket_client could have been
 	 * deleted
 	 */
-	if (!batadv_socket_client_hash[icmp_packet->icmph.uid]) {
+	if (!batadv_socket_client_hash[icmph->uid]) {
 		spin_unlock_bh(&socket_client->lock);
 		kfree(socket_packet);
 		return;
@@ -342,12 +356,18 @@ static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
 	wake_up(&socket_client->queue_wait);
 }
 
-void batadv_socket_receive_packet(struct batadv_icmp_packet_rr *icmp_packet,
+/**
+ * batadv_socket_receive_packet - schedule an icmp packet to be received
+ *  locally and sent to userspace.
+ * @icmph: pointer to the header of the icmp packet
+ * @icmp_len: total length of the icmp packet
+ */
+void batadv_socket_receive_packet(struct batadv_icmp_header *icmph,
 				  size_t icmp_len)
 {
 	struct batadv_socket_client *hash;
 
-	hash = batadv_socket_client_hash[icmp_packet->icmph.uid];
+	hash = batadv_socket_client_hash[icmph->uid];
 	if (hash)
-		batadv_socket_add_packet(hash, icmp_packet, icmp_len);
+		batadv_socket_add_packet(hash, icmph, icmp_len);
 }
diff --git a/icmp_socket.h b/icmp_socket.h
index 1fcca37..6665080 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -24,7 +24,7 @@
 
 void batadv_socket_init(void);
 int batadv_socket_setup(struct batadv_priv *bat_priv);
-void batadv_socket_receive_packet(struct batadv_icmp_packet_rr *icmp_packet,
+void batadv_socket_receive_packet(struct batadv_icmp_header *icmph,
 				  size_t icmp_len);
 
 #endif /* _NET_BATMAN_ADV_ICMP_SOCKET_H_ */
diff --git a/routing.c b/routing.c
index 71fba14..eea4c04 100644
--- a/routing.c
+++ b/routing.c
@@ -260,19 +260,30 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 	return true;
 }
 
+/**
+ * batadv_recv_my_icmp_packet - receive an icmp packet locally
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: icmp packet to process
+ *
+ * Returns NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
+ * otherwise.
+ */
 static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
-				      struct sk_buff *skb, size_t icmp_len)
+				      struct sk_buff *skb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_icmp_packet_rr *icmp_packet;
+	struct batadv_icmp_header *icmph;
 	int ret = NET_RX_DROP;
 
-	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
+	icmph = (struct batadv_icmp_header *)skb->data;
 
 	/* add data to device queue */
-	if (icmp_packet->icmph.msg_type != BATADV_ECHO_REQUEST) {
-		batadv_socket_receive_packet(icmp_packet, icmp_len);
+	if (icmph->msg_type != BATADV_ECHO_REQUEST) {
+		if (skb_linearize(skb) < 0)
+			goto out;
+
+		batadv_socket_receive_packet(icmph, skb->len);
 		goto out;
 	}
 
@@ -282,7 +293,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 
 	/* answer echo request (ping) */
 	/* get routing information */
-	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->icmph.orig);
+	orig_node = batadv_orig_hash_find(bat_priv, icmph->orig);
 	if (!orig_node)
 		goto out;
 
@@ -290,13 +301,12 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
 
-	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
+	icmph = (struct batadv_icmp_header *)skb->data;
 
-	memcpy(icmp_packet->icmph.dst, icmp_packet->icmph.orig, ETH_ALEN);
-	memcpy(icmp_packet->icmph.orig, primary_if->net_dev->dev_addr,
-	       ETH_ALEN);
-	icmp_packet->icmph.msg_type = BATADV_ECHO_REPLY;
-	icmp_packet->icmph.header.ttl = BATADV_TTL;
+	memcpy(icmph->dst, icmph->orig, ETH_ALEN);
+	memcpy(icmph->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
+	icmph->msg_type = BATADV_ECHO_REPLY;
+	icmph->header.ttl = BATADV_TTL;
 
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
 		ret = NET_RX_SUCCESS;
@@ -363,16 +373,13 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct batadv_icmp_packet_rr *icmp_packet;
+	struct batadv_icmp_header *icmph;
+	struct batadv_icmp_packet_rr *icmp_packet_rr;
 	struct ethhdr *ethhdr;
 	struct batadv_orig_node *orig_node = NULL;
-	int hdr_size = sizeof(struct batadv_icmp_packet);
+	int hdr_size = sizeof(struct batadv_icmp_header);
 	int ret = NET_RX_DROP;
 
-	/* we truncate all incoming icmp packets if they don't match our size */
-	if (skb->len >= sizeof(struct batadv_icmp_packet_rr))
-		hdr_size = sizeof(struct batadv_icmp_packet_rr);
-
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		goto out;
@@ -391,28 +398,39 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest))
 		goto out;
 
-	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
+	icmph = (struct batadv_icmp_header *)skb->data;
 
 	/* add record route information if not full */
-	if ((icmp_packet->icmph.msg_type == BATADV_ECHO_REPLY ||
-	     icmp_packet->icmph.msg_type == BATADV_ECHO_REQUEST) &&
-	    (hdr_size == sizeof(struct batadv_icmp_packet_rr)) &&
-	    (icmp_packet->rr_cur < BATADV_RR_LEN)) {
-		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur]),
+	if ((icmph->msg_type == BATADV_ECHO_REPLY ||
+	     icmph->msg_type == BATADV_ECHO_REQUEST) &&
+	    (skb->len >= sizeof(struct batadv_icmp_packet_rr))) {
+		if (skb_linearize(skb) < 0)
+			goto out;
+
+		/* create a copy of the skb, if needed, to modify it. */
+		if (skb_cow(skb, ETH_HLEN) < 0)
+			goto out;
+
+		icmph = (struct batadv_icmp_header *)skb->data;
+		icmp_packet_rr = (struct batadv_icmp_packet_rr *)icmph;
+		if (icmp_packet_rr->rr_cur >= BATADV_RR_LEN)
+			goto out;
+
+		memcpy(&(icmp_packet_rr->rr[icmp_packet_rr->rr_cur]),
 		       ethhdr->h_dest, ETH_ALEN);
-		icmp_packet->rr_cur++;
+		icmp_packet_rr->rr_cur++;
 	}
 
 	/* packet for me */
-	if (batadv_is_my_mac(bat_priv, icmp_packet->icmph.dst))
-		return batadv_recv_my_icmp_packet(bat_priv, skb, hdr_size);
+	if (batadv_is_my_mac(bat_priv, icmph->dst))
+		return batadv_recv_my_icmp_packet(bat_priv, skb);
 
 	/* TTL exceeded */
-	if (icmp_packet->icmph.header.ttl < 2)
+	if (icmph->header.ttl < 2)
 		return batadv_recv_icmp_ttl_exceeded(bat_priv, skb);
 
 	/* get routing information */
-	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->icmph.dst);
+	orig_node = batadv_orig_hash_find(bat_priv, icmph->dst);
 	if (!orig_node)
 		goto out;
 
@@ -420,10 +438,10 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
 
-	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
+	icmph = (struct batadv_icmp_header *)skb->data;
 
 	/* decrement ttl */
-	icmp_packet->icmph.header.ttl--;
+	icmph->header.ttl--;
 
 	/* route it */
 	if (batadv_send_skb_to_orig(skb, orig_node, recv_if) != NET_XMIT_DROP)
-- 
1.7.10.4

