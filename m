Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 19 Jun 2010 02:51:53 +0200
Message-Id: <1276908713-28365-9-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 8/8] Staging: batman-adv: record route for
	ICMP messages
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
To: Greg KH <greg@kroah.com>
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Daniel Seither <post@tiwoc.de>

The standard layer 3 ping utility can use the record route (RR) option
of IP to collect route data for sent ping messages (ping -R). This
patch introduces comparable functionality for batman-adv ICMP messages.

The patch adds a second batman ICMP packet format (icmp_packet_rr) such
that up to 17 MAC addresses can be recorded (sufficient for up to 8
hops per direction). When no RR is wanted, the old icmp_packet without
the RR overhead can be sent.

Signed-off-by: Daniel Seither <post@tiwoc.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/icmp_socket.c |   45 ++++++++++++++++++------------
 drivers/staging/batman-adv/icmp_socket.h |    3 +-
 drivers/staging/batman-adv/packet.h      |   17 +++++++++++
 drivers/staging/batman-adv/routing.c     |   43 ++++++++++++++++++----------
 drivers/staging/batman-adv/types.h       |    3 +-
 5 files changed, 76 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/batman-adv/icmp_socket.c b/drivers/staging/batman-adv/icmp_socket.c
index d4411cb..08a5f7b 100644
--- a/drivers/staging/batman-adv/icmp_socket.c
+++ b/drivers/staging/batman-adv/icmp_socket.c
@@ -32,7 +32,8 @@
 static struct socket_client *socket_client_hash[256];
 
 static void bat_socket_add_packet(struct socket_client *socket_client,
-				  struct icmp_packet *icmp_packet);
+				  struct icmp_packet_rr *icmp_packet,
+				  size_t icmp_len);
 
 void bat_socket_init(void)
 {
@@ -110,6 +111,7 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 	struct socket_client *socket_client =
 		(struct socket_client *)file->private_data;
 	struct socket_packet *socket_packet;
+	size_t packet_len;
 	int error;
 	unsigned long flags;
 
@@ -138,14 +140,15 @@ static ssize_t bat_socket_read(struct file *file, char __user *buf,
 	spin_unlock_irqrestore(&socket_client->lock, flags);
 
 	error = __copy_to_user(buf, &socket_packet->icmp_packet,
-			       sizeof(struct icmp_packet));
+			       socket_packet->icmp_len);
 
+	packet_len = socket_packet->icmp_len;
 	kfree(socket_packet);
 
 	if (error)
 		return -EFAULT;
 
-	return sizeof(struct icmp_packet);
+	return packet_len;
 }
 
 static ssize_t bat_socket_write(struct file *file, const char __user *buff,
@@ -153,9 +156,10 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 {
 	struct socket_client *socket_client =
 		(struct socket_client *)file->private_data;
-	struct icmp_packet icmp_packet;
+	struct icmp_packet_rr icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
+	size_t packet_len = sizeof(struct icmp_packet);
 	uint8_t dstaddr[ETH_ALEN];
 	unsigned long flags;
 
@@ -166,10 +170,13 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		return -EINVAL;
 	}
 
-	if (!access_ok(VERIFY_READ, buff, sizeof(struct icmp_packet)))
+	if (len >= sizeof(struct icmp_packet_rr))
+		packet_len = sizeof(struct icmp_packet_rr);
+
+	if (!access_ok(VERIFY_READ, buff, packet_len))
 		return -EFAULT;
 
-	if (__copy_from_user(&icmp_packet, buff, sizeof(icmp_packet)))
+	if (__copy_from_user(&icmp_packet, buff, packet_len))
 		return -EFAULT;
 
 	if (icmp_packet.packet_type != BAT_ICMP) {
@@ -191,7 +198,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (icmp_packet.version != COMPAT_VERSION) {
 		icmp_packet.msg_type = PARAMETER_PROBLEM;
 		icmp_packet.ttl = COMPAT_VERSION;
-		bat_socket_add_packet(socket_client, &icmp_packet);
+		bat_socket_add_packet(socket_client, &icmp_packet, packet_len);
 		goto out;
 	}
 
@@ -218,13 +225,13 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (batman_if->if_status != IF_ACTIVE)
 		goto dst_unreach;
 
-	memcpy(icmp_packet.orig,
-	       batman_if->net_dev->dev_addr,
-	       ETH_ALEN);
+	memcpy(icmp_packet.orig, batman_if->net_dev->dev_addr, ETH_ALEN);
+
+	if (packet_len == sizeof(struct icmp_packet_rr))
+		memcpy(icmp_packet.rr, batman_if->net_dev->dev_addr, ETH_ALEN);
 
 	send_raw_packet((unsigned char *)&icmp_packet,
-			sizeof(struct icmp_packet),
-			batman_if, dstaddr);
+			packet_len, batman_if, dstaddr);
 
 	goto out;
 
@@ -232,7 +239,7 @@ unlock:
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 dst_unreach:
 	icmp_packet.msg_type = DESTINATION_UNREACHABLE;
-	bat_socket_add_packet(socket_client, &icmp_packet);
+	bat_socket_add_packet(socket_client, &icmp_packet, packet_len);
 out:
 	return len;
 }
@@ -278,7 +285,8 @@ err:
 }
 
 static void bat_socket_add_packet(struct socket_client *socket_client,
-				  struct icmp_packet *icmp_packet)
+				  struct icmp_packet_rr *icmp_packet,
+				  size_t icmp_len)
 {
 	struct socket_packet *socket_packet;
 	unsigned long flags;
@@ -289,8 +297,8 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 		return;
 
 	INIT_LIST_HEAD(&socket_packet->list);
-	memcpy(&socket_packet->icmp_packet, icmp_packet,
-	       sizeof(struct icmp_packet));
+	memcpy(&socket_packet->icmp_packet, icmp_packet, icmp_len);
+	socket_packet->icmp_len = icmp_len;
 
 	spin_lock_irqsave(&socket_client->lock, flags);
 
@@ -319,10 +327,11 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 	wake_up(&socket_client->queue_wait);
 }
 
-void bat_socket_receive_packet(struct icmp_packet *icmp_packet)
+void bat_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
+			       size_t icmp_len)
 {
 	struct socket_client *hash = socket_client_hash[icmp_packet->uid];
 
 	if (hash)
-		bat_socket_add_packet(hash, icmp_packet);
+		bat_socket_add_packet(hash, icmp_packet, icmp_len);
 }
diff --git a/drivers/staging/batman-adv/icmp_socket.h b/drivers/staging/batman-adv/icmp_socket.h
index 5ad73da..2dc954a 100644
--- a/drivers/staging/batman-adv/icmp_socket.h
+++ b/drivers/staging/batman-adv/icmp_socket.h
@@ -25,4 +25,5 @@
 
 void bat_socket_init(void);
 int bat_socket_setup(struct bat_priv *bat_priv);
-void bat_socket_receive_packet(struct icmp_packet *icmp_packet);
+void bat_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
+			       size_t icmp_len);
diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index d0d35ea..8a04418 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -69,6 +69,23 @@ struct icmp_packet {
 	uint8_t  uid;
 } __attribute__((packed));
 
+#define BAT_RR_LEN 16
+
+/* icmp_packet_rr must start with all fields from imcp_packet
+   as this is assumed by code that handles ICMP packets */
+struct icmp_packet_rr {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  msg_type; /* see ICMP message types above */
+	uint8_t  ttl;
+	uint8_t  dst[6];
+	uint8_t  orig[6];
+	uint16_t seqno;
+	uint8_t  uid;
+	uint8_t  rr_cur;
+	uint8_t  rr[BAT_RR_LEN][ETH_ALEN];
+} __attribute__((packed));
+
 struct unicast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 048795e..acd8f74 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -765,10 +765,10 @@ int recv_bat_packet(struct sk_buff *skb,
 	return NET_RX_SUCCESS;
 }
 
-static int recv_my_icmp_packet(struct sk_buff *skb)
+static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 {
 	struct orig_node *orig_node;
-	struct icmp_packet *icmp_packet;
+	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct sk_buff *skb_old;
 	struct batman_if *batman_if;
@@ -776,12 +776,12 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
 
-	icmp_packet = (struct icmp_packet *)skb->data;
+	icmp_packet = (struct icmp_packet_rr *)skb->data;
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		bat_socket_receive_packet(icmp_packet);
+		bat_socket_receive_packet(icmp_packet, icmp_len);
 		return NET_RX_DROP;
 	}
 
@@ -803,13 +803,12 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 
 		/* create a copy of the skb, if needed, to modify it. */
 		skb_old = NULL;
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, icmp_len)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-
-			icmp_packet = (struct icmp_packet *)skb->data;
+			icmp_packet = (struct icmp_packet_rr *)skb->data;
 			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
@@ -828,7 +827,7 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 	return ret;
 }
 
-static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
+static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 {
 	struct orig_node *orig_node;
 	struct icmp_packet *icmp_packet;
@@ -867,7 +866,7 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, icmp_len)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
@@ -894,7 +893,7 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 
 int recv_icmp_packet(struct sk_buff *skb)
 {
-	struct icmp_packet *icmp_packet;
+	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct orig_node *orig_node;
 	struct sk_buff *skb_old;
@@ -904,6 +903,12 @@ int recv_icmp_packet(struct sk_buff *skb)
 	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
 
+	/**
+	 * we truncate all incoming icmp packets if they don't match our size
+	 */
+	if (skb_headlen(skb) >= sizeof(struct icmp_packet_rr))
+		hdr_size = sizeof(struct icmp_packet_rr);
+
 	/* drop packet if it has not necessary minimum size */
 	if (skb_headlen(skb) < hdr_size)
 		return NET_RX_DROP;
@@ -922,15 +927,23 @@ int recv_icmp_packet(struct sk_buff *skb)
 	if (!is_my_mac(ethhdr->h_dest))
 		return NET_RX_DROP;
 
-	icmp_packet = (struct icmp_packet *)skb->data;
+	icmp_packet = (struct icmp_packet_rr *)skb->data;
+
+	/* add record route information if not full */
+	if ((hdr_size == sizeof(struct icmp_packet_rr)) &&
+	    (icmp_packet->rr_cur < BAT_RR_LEN)) {
+		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur]),
+			ethhdr->h_dest, ETH_ALEN);
+		icmp_packet->rr_cur++;
+	}
 
 	/* packet for me */
 	if (is_my_mac(icmp_packet->dst))
-		return recv_my_icmp_packet(skb);
+		return recv_my_icmp_packet(skb, hdr_size);
 
 	/* TTL exceeded */
 	if (icmp_packet->ttl < 2)
-		return recv_icmp_ttl_exceeded(skb);
+		return recv_icmp_ttl_exceeded(skb, hdr_size);
 
 	ret = NET_RX_DROP;
 
@@ -949,12 +962,12 @@ int recv_icmp_packet(struct sk_buff *skb)
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, hdr_size)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet *)skb->data;
+			icmp_packet = (struct icmp_packet_rr *)skb->data;
 			ethhdr = (struct ethhdr *)skb_mac_header(skb);
 			kfree_skb(skb_old);
 		}
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 84c3f43..e1fc460 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -130,7 +130,8 @@ struct socket_client {
 
 struct socket_packet {
 	struct list_head list;
-	struct icmp_packet icmp_packet;
+	size_t icmp_len;
+	struct icmp_packet_rr icmp_packet;
 };
 
 struct hna_local_entry {
-- 
1.7.1

