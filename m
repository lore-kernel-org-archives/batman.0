Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 23 Jul 2010 22:49:24 +0200
Message-Id: <1279918164-22878-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1279917512-22144-1-git-send-email-sven.eckelmann@gmx.de>
References: <1279917512-22144-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Directly prepare icmp packets
	in socket buffer
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

It is unnecessary to generate an icmp packet in an extra memory region
and than copying it to a new allocated skb.

This also resolved the problem that we do inform the user that we
couldn't send the packet because we couldn't allocate the socket buffer.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 Return -ENOMEM when dev_alloc_skb fails.

 batman-adv/icmp_socket.c |   60 +++++++++++++++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index 6a014a3..8e4316c 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -156,7 +156,8 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	/* FIXME: each orig_node->batman_if will be attached to a softif */
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct socket_client *socket_client = file->private_data;
-	struct icmp_packet_rr icmp_packet;
+	struct sk_buff *skb;
+	struct icmp_packet_rr *icmp_packet;
 	struct orig_node *orig_node;
 	struct batman_if *batman_if;
 	size_t packet_len = sizeof(struct icmp_packet);
@@ -173,40 +174,53 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (len >= sizeof(struct icmp_packet_rr))
 		packet_len = sizeof(struct icmp_packet_rr);
 
-	if (!access_ok(VERIFY_READ, buff, packet_len))
-		return -EFAULT;
+	skb = dev_alloc_skb(packet_len + sizeof(struct ethhdr));
+	if (!skb)
+		return -ENOMEM;
 
-	if (__copy_from_user(&icmp_packet, buff, packet_len))
-		return -EFAULT;
+	skb_reserve(skb, sizeof(struct ethhdr));
+	icmp_packet = (struct icmp_packet_rr *)skb_put(skb, packet_len);
 
-	if (icmp_packet.packet_type != BAT_ICMP) {
+	if (!access_ok(VERIFY_READ, buff, packet_len)) {
+		len = -EFAULT;
+		goto free_skb;
+	}
+
+	if (__copy_from_user(icmp_packet, buff, packet_len)) {
+		len = -EFAULT;
+		goto free_skb;
+	}
+
+	if (icmp_packet->packet_type != BAT_ICMP) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Error - can't send packet from char device: "
 			"got bogus packet type (expected: BAT_ICMP)\n");
-		return -EINVAL;
+		len = -EINVAL;
+		goto free_skb;
 	}
 
-	if (icmp_packet.msg_type != ECHO_REQUEST) {
+	if (icmp_packet->msg_type != ECHO_REQUEST) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Error - can't send packet from char device: "
 			"got bogus message type (expected: ECHO_REQUEST)\n");
-		return -EINVAL;
+		len = -EINVAL;
+		goto free_skb;
 	}
 
-	icmp_packet.uid = socket_client->index;
+	icmp_packet->uid = socket_client->index;
 
-	if (icmp_packet.version != COMPAT_VERSION) {
-		icmp_packet.msg_type = PARAMETER_PROBLEM;
-		icmp_packet.ttl = COMPAT_VERSION;
-		bat_socket_add_packet(socket_client, &icmp_packet, packet_len);
-		goto out;
+	if (icmp_packet->version != COMPAT_VERSION) {
+		icmp_packet->msg_type = PARAMETER_PROBLEM;
+		icmp_packet->ttl = COMPAT_VERSION;
+		bat_socket_add_packet(socket_client, icmp_packet, packet_len);
+		goto free_skb;
 	}
 
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto dst_unreach;
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
-	orig_node = ((struct orig_node *)hash_find(orig_hash, icmp_packet.dst));
+	orig_node = (struct orig_node *)hash_find(orig_hash, icmp_packet->dst);
 
 	if (!orig_node)
 		goto unlock;
@@ -225,21 +239,23 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (batman_if->if_status != IF_ACTIVE)
 		goto dst_unreach;
 
-	memcpy(icmp_packet.orig, batman_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(icmp_packet->orig, batman_if->net_dev->dev_addr, ETH_ALEN);
 
 	if (packet_len == sizeof(struct icmp_packet_rr))
-		memcpy(icmp_packet.rr, batman_if->net_dev->dev_addr, ETH_ALEN);
+		memcpy(icmp_packet->rr, batman_if->net_dev->dev_addr, ETH_ALEN);
 
-	send_raw_packet((unsigned char *)&icmp_packet,
-			packet_len, batman_if, dstaddr);
+
+	send_skb_packet(skb, batman_if, dstaddr);
 
 	goto out;
 
 unlock:
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 dst_unreach:
-	icmp_packet.msg_type = DESTINATION_UNREACHABLE;
-	bat_socket_add_packet(socket_client, &icmp_packet, packet_len);
+	icmp_packet->msg_type = DESTINATION_UNREACHABLE;
+	bat_socket_add_packet(socket_client, icmp_packet, packet_len);
+free_skb:
+	kfree_skb(skb);
 out:
 	return len;
 }
-- 
1.7.1

