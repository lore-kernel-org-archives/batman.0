Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Feb 2010 18:30:23 +0800
Message-Id: <1266316224-32338-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201002161829.19535.lindner_marek@yahoo.de>
References: <201002161829.19535.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: record route for ICMP
	messages
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

The standard layer 3 ping utility can use the record route (RR) option
of IP to collect route data for sent ping messages (ping -R). This
patch introduces comparable functionality for batman-adv ICMP messages.

The patch adds a second batman ICMP packet format (icmp_packet_rr) such
that up to 17 MAC addresses can be recorded (sufficient for up to 8
hops per direction). When no RR is wanted, the old icmp_packet without
the RR overhead can be sent.

Signed-off-by: Daniel Seither <post@tiwoc.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/device.c  |   42 ++++++++++++++++++++++---------------
 batman-adv-kernelland/device.h  |    6 +++-
 batman-adv-kernelland/packet.h  |   17 +++++++++++++++
 batman-adv-kernelland/routing.c |   44 +++++++++++++++++++++++++-------------
 batman-adv-kernelland/types.h   |    3 +-
 5 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/batman-adv-kernelland/device.c b/batman-adv-kernelland/device.c
index df51f1c..0c3c0b3 100644
--- a/batman-adv-kernelland/device.c
+++ b/batman-adv-kernelland/device.c
@@ -163,6 +163,7 @@ ssize_t bat_device_read(struct file *file, char __user *buf, size_t count,
 	struct device_client *device_client =
 		(struct device_client *)file->private_data;
 	struct device_packet *device_packet;
+	size_t packet_len;
 	int error;
 	unsigned long flags;
 
@@ -191,14 +192,15 @@ ssize_t bat_device_read(struct file *file, char __user *buf, size_t count,
 	spin_unlock_irqrestore(&device_client->lock, flags);
 
 	error = __copy_to_user(buf, &device_packet->icmp_packet,
-			       sizeof(struct icmp_packet));
+			       device_packet->icmp_len);
 
+	packet_len = device_packet->icmp_len;
 	kfree(device_packet);
 
 	if (error)
 		return error;
 
-	return sizeof(struct icmp_packet);
+	return packet_len;
 }
 
 ssize_t bat_device_write(struct file *file, const char __user *buff,
@@ -206,9 +208,10 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 {
 	struct device_client *device_client =
 		(struct device_client *)file->private_data;
-	struct icmp_packet icmp_packet;
+	struct icmp_packet_rr icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
+	size_t packet_len = sizeof(struct icmp_packet);
 	uint8_t dstaddr[ETH_ALEN];
 	unsigned long flags;
 
@@ -217,10 +220,13 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
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
@@ -238,7 +244,7 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	if (icmp_packet.version != COMPAT_VERSION) {
 		icmp_packet.msg_type = PARAMETER_PROBLEM;
 		icmp_packet.ttl = COMPAT_VERSION;
-		bat_device_add_packet(device_client, &icmp_packet);
+		bat_device_add_packet(device_client, &icmp_packet, packet_len);
 		goto out;
 	}
 
@@ -265,13 +271,13 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	if (batman_if->if_active != IF_ACTIVE)
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
 
@@ -279,7 +285,7 @@ unlock:
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 dst_unreach:
 	icmp_packet.msg_type = DESTINATION_UNREACHABLE;
-	bat_device_add_packet(device_client, &icmp_packet);
+	bat_device_add_packet(device_client, &icmp_packet, packet_len);
 out:
 	return len;
 }
@@ -298,7 +304,8 @@ unsigned int bat_device_poll(struct file *file, poll_table *wait)
 }
 
 void bat_device_add_packet(struct device_client *device_client,
-			   struct icmp_packet *icmp_packet)
+			   struct icmp_packet_rr *icmp_packet,
+			   size_t icmp_len)
 {
 	struct device_packet *device_packet;
 	unsigned long flags;
@@ -309,8 +316,8 @@ void bat_device_add_packet(struct device_client *device_client,
 		return;
 
 	INIT_LIST_HEAD(&device_packet->list);
-	memcpy(&device_packet->icmp_packet, icmp_packet,
-	       sizeof(struct icmp_packet));
+	memcpy(&device_packet->icmp_packet, icmp_packet, icmp_len);
+	device_packet->icmp_len = icmp_len;
 
 	spin_lock_irqsave(&device_client->lock, flags);
 
@@ -339,10 +346,11 @@ void bat_device_add_packet(struct device_client *device_client,
 	wake_up(&device_client->queue_wait);
 }
 
-void bat_device_receive_packet(struct icmp_packet *icmp_packet)
+void bat_device_receive_packet(struct icmp_packet_rr *icmp_packet,
+			       size_t icmp_len)
 {
 	struct device_client *hash = device_client_hash[icmp_packet->uid];
 
 	if (hash)
-		bat_device_add_packet(hash, icmp_packet);
+		bat_device_add_packet(hash, icmp_packet, icmp_len);
 }
diff --git a/batman-adv-kernelland/device.h b/batman-adv-kernelland/device.h
index 46c0f44..7a9394b 100644
--- a/batman-adv-kernelland/device.h
+++ b/batman-adv-kernelland/device.h
@@ -32,5 +32,7 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 			 size_t len, loff_t *off);
 unsigned int bat_device_poll(struct file *file, poll_table *wait);
 void bat_device_add_packet(struct device_client *device_client,
-			   struct icmp_packet *icmp_packet);
-void bat_device_receive_packet(struct icmp_packet *icmp_packet);
+			   struct icmp_packet_rr *icmp_packet,
+			   size_t icmp_len);
+void bat_device_receive_packet(struct icmp_packet_rr *icmp_packet,
+			       size_t icmp_len);
diff --git a/batman-adv-kernelland/packet.h b/batman-adv-kernelland/packet.h
index 1c8e6c8..c8b973f 100644
--- a/batman-adv-kernelland/packet.h
+++ b/batman-adv-kernelland/packet.h
@@ -71,6 +71,23 @@ struct icmp_packet {
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
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index a3adc7f..47d5757 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -706,10 +706,10 @@ int recv_bat_packet(struct sk_buff *skb,
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
@@ -717,12 +717,12 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 	unsigned long flags;
 	uint8_t dstaddr[ETH_ALEN];
 
-	icmp_packet = (struct icmp_packet *) skb->data;
-	ethhdr = (struct ethhdr *) skb_mac_header(skb);
+	icmp_packet = (struct icmp_packet_rr *)skb->data;
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		bat_device_receive_packet(icmp_packet);
+		bat_device_receive_packet(icmp_packet, icmp_len);
 		return NET_RX_DROP;
 	}
 
@@ -745,12 +745,12 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 
 		/* create a copy of the skb, if needed, to modify it. */
 		skb_old = NULL;
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, icmp_len)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet *) skb->data;
+			icmp_packet = (struct icmp_packet_rr *)skb->data;
 			kfree_skb(skb_old);
 		}
 
@@ -768,7 +768,7 @@ static int recv_my_icmp_packet(struct sk_buff *skb)
 	return ret;
 }
 
-static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
+static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 {
 	struct orig_node *orig_node;
 	struct icmp_packet *icmp_packet;
@@ -806,7 +806,7 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, icmp_len)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
@@ -832,7 +832,7 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 
 int recv_icmp_packet(struct sk_buff *skb)
 {
-	struct icmp_packet *icmp_packet;
+	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct orig_node *orig_node;
 	struct sk_buff *skb_old;
@@ -842,6 +842,12 @@ int recv_icmp_packet(struct sk_buff *skb)
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
@@ -860,15 +866,23 @@ int recv_icmp_packet(struct sk_buff *skb)
 	if (!is_my_mac(ethhdr->h_dest))
 		return NET_RX_DROP;
 
-	icmp_packet = (struct icmp_packet *) skb->data;
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
 
@@ -888,12 +902,12 @@ int recv_icmp_packet(struct sk_buff *skb)
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, sizeof(struct icmp_packet))) {
+		if (!skb_clone_writable(skb, hdr_size)) {
 			skb_old = skb;
 			skb = skb_copy(skb, GFP_ATOMIC);
 			if (!skb)
 				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet *) skb->data;
+			icmp_packet = (struct icmp_packet_rr *)skb->data;
 			kfree_skb(skb_old);
 		}
 
diff --git a/batman-adv-kernelland/types.h b/batman-adv-kernelland/types.h
index d9cb5d1..a82b52d 100644
--- a/batman-adv-kernelland/types.h
+++ b/batman-adv-kernelland/types.h
@@ -106,7 +106,8 @@ struct device_client {
 
 struct device_packet {
 	struct list_head list;
-	struct icmp_packet icmp_packet;
+	size_t icmp_len;
+	struct icmp_packet_rr icmp_packet;
 };
 
 struct hna_local_entry {
-- 
1.6.6.2

