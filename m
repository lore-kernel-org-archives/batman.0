Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue,  3 May 2016 11:00:48 +0200
Message-Id: <1462266049-13531-1-git-send-email-sven@open-mesh.com>
In-Reply-To: <1894217.a7ufKNXfSr@bentobox>
References: <1894217.a7ufKNXfSr@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v3 2/3] batman-adv: use another ICMP packet
	when sending command from userspace
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>, Antonio Quartulli <antonio.quartulli@open-mesh.com>

From: Antonio Quartulli <antonio.quartulli@open-mesh.com>

In the current code a real batadv ICMP packet is used to communicate from
userspace to the module which ICMP operation should be start (the operation
to start depends on the size of the received packet). This worked good so
far because the same packet was used to perform the only two available ICMP
operations and the very same packet received from userspace was also sent
over the wire to perform the operation itself.

As soon as we add new and different ICMP operations this model will not
work well anymore. To improve this feature make the userspace use a proper
packet type to tell the kernel module which operation to start.

The module will then arrange the rest by itself.

Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v3:
 - Rebase on current master version
 - inform batctl about problems finding the remote originator
v2:
 - Rebase on current master version
---
 net/batman-adv/icmp_socket.c | 212 +++++++++++++++++++++++++------------------
 net/batman-adv/icmp_socket.h |   5 +-
 net/batman-adv/packet.h      |  15 +++
 net/batman-adv/types.h       |   2 +
 4 files changed, 140 insertions(+), 94 deletions(-)

diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 777aea1..7284510 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -52,8 +52,7 @@
 static struct batadv_socket_client *batadv_socket_client_hash[256];
 
 static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
-				     struct batadv_icmp_header *icmph,
-				     size_t icmp_len);
+				     void *icmp_buffer, size_t icmp_len);
 
 void batadv_socket_init(void)
 {
@@ -157,7 +156,7 @@ static ssize_t batadv_socket_read(struct file *file, char __user *buf,
 	spin_unlock_bh(&socket_client->lock);
 
 	packet_len = min(count, socket_packet->icmp_len);
-	error = copy_to_user(buf, &socket_packet->icmp_packet, packet_len);
+	error = copy_to_user(buf, &socket_packet->packet, packet_len);
 
 	kfree(socket_packet);
 
@@ -167,73 +166,90 @@ static ssize_t batadv_socket_read(struct file *file, char __user *buf,
 	return packet_len;
 }
 
-static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
-				   size_t len, loff_t *off)
+/**
+ * batadv_socket_write_user - Parse batadv_icmp_user_packet
+ * @bat_priv: the bat priv with all the icmp socket information
+ * @socket_client: layer2 icmp socket client data
+ * @primary_if: the selected primary interface
+ * @buff: buffer of user data
+ * @len: length of the data in buff
+ *
+ * Return: Number of read bytes from buff or < 0 on errors
+ */
+static ssize_t
+batadv_socket_write_user(struct batadv_priv *bat_priv,
+			 struct batadv_socket_client *socket_client,
+			 struct batadv_hard_iface *primary_if,
+			 const char __user *buff, size_t len)
+{
+	struct batadv_icmp_user_packet icmp_user_packet;
+
+	if (copy_from_user(&icmp_user_packet, buff, len))
+		return -EFAULT;
+
+	/* no command supported yet! */
+	len = -EINVAL;
+
+	return len;
+}
+
+/**
+ * batadv_socket_write_raw - Parse batadv_icmp_packet/batadv_icmp_packet_rr
+ * @bat_priv: the bat priv with all the icmp socket information
+ * @socket_client: layer2 icmp socket client data
+ * @primary_if: the selected primary interface
+ * @buff: buffer of user data
+ * @len: length of the data in buff
+ *
+ * Return: Number of read bytes from buff or < 0 on errors
+ */
+static ssize_t
+batadv_socket_write_raw(struct batadv_priv *bat_priv,
+			struct batadv_socket_client *socket_client,
+			struct batadv_hard_iface *primary_if,
+			const char __user *buff, size_t len)
 {
-	struct batadv_socket_client *socket_client = file->private_data;
-	struct batadv_priv *bat_priv = socket_client->bat_priv;
-	struct batadv_hard_iface *primary_if = NULL;
 	struct sk_buff *skb;
-	struct batadv_icmp_packet_rr *icmp_packet_rr;
-	struct batadv_icmp_header *icmp_header;
+	struct batadv_icmp_packet_rr icmp_packet, *icmp_buff;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_neigh_node *neigh_node = NULL;
-	size_t packet_len = sizeof(struct batadv_icmp_packet);
+	size_t packet_len;
 	u8 *addr;
 
-	if (len < sizeof(struct batadv_icmp_header)) {
+	if (len != sizeof(struct batadv_icmp_packet_rr) &&
+	    len != sizeof(struct batadv_icmp_packet)) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Error - can't send packet from char device: invalid packet size\n");
 		return -EINVAL;
 	}
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-
-	if (!primary_if) {
-		len = -EFAULT;
-		goto out;
-	}
-
-	if (len >= BATADV_ICMP_MAX_PACKET_SIZE)
-		packet_len = BATADV_ICMP_MAX_PACKET_SIZE;
-	else
-		packet_len = len;
-
-	skb = netdev_alloc_skb_ip_align(NULL, packet_len + ETH_HLEN);
-	if (!skb) {
-		len = -ENOMEM;
-		goto out;
-	}
+	packet_len = len;
+	if (copy_from_user(&icmp_packet, buff, len))
+		return -EFAULT;
 
-	skb->priority = TC_PRIO_CONTROL;
-	skb_reserve(skb, ETH_HLEN);
-	icmp_header = (struct batadv_icmp_header *)skb_put(skb, packet_len);
+	icmp_packet.uid = socket_client->index;
 
-	if (copy_from_user(icmp_header, buff, packet_len)) {
-		len = -EFAULT;
-		goto free_skb;
+	/* if the compat version does not match, return an error now */
+	if (icmp_packet.version != BATADV_COMPAT_VERSION) {
+		icmp_packet.msg_type = BATADV_PARAMETER_PROBLEM;
+		icmp_packet.version = BATADV_COMPAT_VERSION;
+		batadv_socket_add_packet(socket_client, &icmp_packet,
+					 packet_len);
+		return len;
 	}
 
-	if (icmp_header->packet_type != BATADV_ICMP) {
+	if (icmp_packet.packet_type != BATADV_ICMP) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
-		len = -EINVAL;
-		goto free_skb;
+		return -EINVAL;
 	}
 
-	switch (icmp_header->msg_type) {
+	switch (icmp_packet.msg_type) {
 	case BATADV_ECHO_REQUEST:
-		if (len < sizeof(struct batadv_icmp_packet)) {
-			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-				   "Error - can't send packet from char device: invalid packet size\n");
-			len = -EINVAL;
-			goto free_skb;
-		}
-
 		if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 			goto dst_unreach;
 
-		orig_node = batadv_orig_hash_find(bat_priv, icmp_header->dst);
+		orig_node = batadv_orig_hash_find(bat_priv, icmp_packet.dst);
 		if (!orig_node)
 			goto dst_unreach;
 
@@ -248,47 +264,68 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 		if (neigh_node->if_incoming->if_status != BATADV_IF_ACTIVE)
 			goto dst_unreach;
 
-		icmp_packet_rr = (struct batadv_icmp_packet_rr *)icmp_header;
-		if (packet_len == sizeof(*icmp_packet_rr)) {
-			addr = neigh_node->if_incoming->net_dev->dev_addr;
-			ether_addr_copy(icmp_packet_rr->rr[0], addr);
-		}
-
 		break;
 	default:
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Error - can't send packet from char device: got unknown message type\n");
-		len = -EINVAL;
-		goto free_skb;
+		return -EINVAL;
 	}
 
-	icmp_header->uid = socket_client->index;
+	skb = netdev_alloc_skb_ip_align(NULL, packet_len + ETH_HLEN);
+	if (!skb)
+		return -ENOMEM;
 
-	if (icmp_header->version != BATADV_COMPAT_VERSION) {
-		icmp_header->msg_type = BATADV_PARAMETER_PROBLEM;
-		icmp_header->version = BATADV_COMPAT_VERSION;
-		batadv_socket_add_packet(socket_client, icmp_header,
-					 packet_len);
-		goto free_skb;
-	}
+	skb->priority = TC_PRIO_CONTROL;
+	skb_reserve(skb, ETH_HLEN);
+	icmp_buff = (struct batadv_icmp_packet_rr *)skb_put(skb, packet_len);
+	memcpy(icmp_buff, &icmp_packet, packet_len);
 
-	ether_addr_copy(icmp_header->orig, primary_if->net_dev->dev_addr);
+	ether_addr_copy(icmp_buff->orig, primary_if->net_dev->dev_addr);
+
+	switch (icmp_packet.msg_type) {
+	case BATADV_ECHO_REQUEST:
+		if (len == sizeof(struct batadv_icmp_packet_rr)) {
+			addr = neigh_node->if_incoming->net_dev->dev_addr;
+			ether_addr_copy(icmp_packet.rr[0], addr);
+		}
+		break;
+	}
 
 	batadv_send_unicast_skb(skb, neigh_node);
 	goto out;
 
 dst_unreach:
-	icmp_header->msg_type = BATADV_DESTINATION_UNREACHABLE;
-	batadv_socket_add_packet(socket_client, icmp_header, packet_len);
-free_skb:
-	kfree_skb(skb);
+	icmp_packet.msg_type = BATADV_DESTINATION_UNREACHABLE;
+	batadv_socket_add_packet(socket_client, &icmp_packet, packet_len);
 out:
-	if (primary_if)
-		batadv_hardif_put(primary_if);
 	if (neigh_node)
 		batadv_neigh_node_put(neigh_node);
 	if (orig_node)
 		batadv_orig_node_put(orig_node);
+
+	return len;
+}
+
+static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
+				   size_t len, loff_t *off)
+{
+	struct batadv_socket_client *socket_client = file->private_data;
+	struct batadv_priv *bat_priv = socket_client->bat_priv;
+	struct batadv_hard_iface *primary_if;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		return -EFAULT;
+
+	if (len == sizeof(struct batadv_icmp_user_packet))
+		len = batadv_socket_write_user(bat_priv, socket_client,
+					       primary_if, buff, len);
+	else
+		len = batadv_socket_write_raw(bat_priv, socket_client,
+					      primary_if, buff, len);
+
+	batadv_hardif_put(primary_if);
+
 	return len;
 }
 
@@ -336,36 +373,29 @@ err:
  * batadv_socket_add_packet - schedule an icmp packet to be sent to
  *  userspace on an icmp socket.
  * @socket_client: the socket this packet belongs to
- * @icmph: pointer to the header of the icmp packet
+ * @icmp_buffer: pointer to the icmp packet
  * @icmp_len: total length of the icmp packet
  */
 static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
-				     struct batadv_icmp_header *icmph,
-				     size_t icmp_len)
+				     void *icmp_buffer, size_t icmp_len)
 {
 	struct batadv_socket_packet *socket_packet;
-	size_t len;
-
-	socket_packet = kmalloc(sizeof(*socket_packet), GFP_ATOMIC);
+	struct batadv_icmp_packet *icmp_packet;
 
+	icmp_packet = (struct batadv_icmp_packet *)icmp_buffer;
+	socket_packet = kmalloc(sizeof(*socket_packet) + icmp_len, GFP_ATOMIC);
 	if (!socket_packet)
 		return;
 
-	len = icmp_len;
-	/* check the maximum length before filling the buffer */
-	if (len > sizeof(socket_packet->icmp_packet))
-		len = sizeof(socket_packet->icmp_packet);
-
-	INIT_LIST_HEAD(&socket_packet->list);
-	memcpy(&socket_packet->icmp_packet, icmph, len);
-	socket_packet->icmp_len = len;
+	memcpy(socket_packet->packet, icmp_packet, icmp_len);
+	socket_packet->icmp_len = icmp_len;
 
 	spin_lock_bh(&socket_client->lock);
 
 	/* while waiting for the lock the socket_client could have been
 	 * deleted
 	 */
-	if (!batadv_socket_client_hash[icmph->uid]) {
+	if (!batadv_socket_client_hash[icmp_packet->uid]) {
 		spin_unlock_bh(&socket_client->lock);
 		kfree(socket_packet);
 		return;
@@ -392,15 +422,17 @@ static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
 /**
  * batadv_socket_receive_packet - schedule an icmp packet to be received
  *  locally and sent to userspace.
- * @icmph: pointer to the header of the icmp packet
+ * @icmp_buffer: pointer to the the icmp packet
  * @icmp_len: total length of the icmp packet
  */
-void batadv_socket_receive_packet(struct batadv_icmp_header *icmph,
-				  size_t icmp_len)
+void batadv_socket_receive_packet(void *icmp_buffer, size_t icmp_len)
 {
 	struct batadv_socket_client *hash;
+	struct batadv_icmp_packet *icmp;
+
+	icmp = (struct batadv_icmp_packet *)icmp_buffer;
 
-	hash = batadv_socket_client_hash[icmph->uid];
+	hash = batadv_socket_client_hash[icmp->uid];
 	if (hash)
-		batadv_socket_add_packet(hash, icmph, icmp_len);
+		batadv_socket_add_packet(hash, icmp_buffer, icmp_len);
 }
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 618d5de..0043b44 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -22,13 +22,10 @@
 
 #include <linux/types.h>
 
-struct batadv_icmp_header;
-
 #define BATADV_ICMP_SOCKET "socket"
 
 void batadv_socket_init(void);
 int batadv_socket_setup(struct batadv_priv *bat_priv);
-void batadv_socket_receive_packet(struct batadv_icmp_header *icmph,
-				  size_t icmp_len);
+void batadv_socket_receive_packet(void *icmp_buffer, size_t icmp_len);
 
 #endif /* _NET_BATMAN_ADV_ICMP_SOCKET_H_ */
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 372128d..459836a 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -285,6 +285,21 @@ struct batadv_elp_packet {
 #define BATADV_ELP_HLEN sizeof(struct batadv_elp_packet)
 
 /**
+ * struct batadv_icmp_user_packet - used to start an ICMP operation from
+ *  userspace
+ * @dst: destination node
+ * @version: compat version used by userspace
+ * @cmd_type: the command to start
+ * @arg1: possible argument for the command
+ */
+struct batadv_icmp_user_packet {
+	u8 dst[ETH_ALEN];
+	u8 version;
+	u8 cmd_type;
+	u32 arg1;
+};
+
+/**
  * struct batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 6a577f4..bc9bb9a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -995,11 +995,13 @@ struct batadv_socket_client {
  * @list: list node for batadv_socket_client::queue_list
  * @icmp_len: size of the layer2 icmp packet
  * @icmp_packet: layer2 icmp packet
+ * @packet: payload of layer2 icmp packet
  */
 struct batadv_socket_packet {
 	struct list_head list;
 	size_t icmp_len;
 	u8 icmp_packet[BATADV_ICMP_MAX_PACKET_SIZE];
+	u8 packet[0];
 };
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-- 
2.8.1

