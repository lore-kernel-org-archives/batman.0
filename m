Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 13 May 2013 12:34:55 +0200
Message-Id: <1368441296-3541-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: simplify ICMP packet
	structures
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

the icmp and the icmp_rr packets share the same initial
fields since they use the same code to be processed and
forwarded.

Extract the common fields and put them into a separate
struct so that future ICMP packets can be easily added
without bloating the packet definition.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

This patches are based on top of
"batman-adv: use __constant_htons when possible"

Cheers,


 icmp_socket.c | 22 +++++++++++-----------
 main.c        |  4 ++--
 packet.h      | 34 +++++++++++++++++++++++++---------
 routing.c     | 38 +++++++++++++++++++-------------------
 4 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/icmp_socket.c b/icmp_socket.c
index b27508b..f0f018a 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -191,25 +191,25 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 		goto free_skb;
 	}
 
-	if (icmp_packet->header.packet_type != BATADV_ICMP) {
+	if (icmp_packet->ih.header.packet_type != BATADV_ICMP) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
 		len = -EINVAL;
 		goto free_skb;
 	}
 
-	if (icmp_packet->msg_type != BATADV_ECHO_REQUEST) {
+	if (icmp_packet->ih.msg_type != BATADV_ECHO_REQUEST) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Error - can't send packet from char device: got bogus message type (expected: ECHO_REQUEST)\n");
 		len = -EINVAL;
 		goto free_skb;
 	}
 
-	icmp_packet->uid = socket_client->index;
+	icmp_packet->ih.uid = socket_client->index;
 
-	if (icmp_packet->header.version != BATADV_COMPAT_VERSION) {
-		icmp_packet->msg_type = BATADV_PARAMETER_PROBLEM;
-		icmp_packet->header.version = BATADV_COMPAT_VERSION;
+	if (icmp_packet->ih.header.version != BATADV_COMPAT_VERSION) {
+		icmp_packet->ih.msg_type = BATADV_PARAMETER_PROBLEM;
+		icmp_packet->ih.header.version = BATADV_COMPAT_VERSION;
 		batadv_socket_add_packet(socket_client, icmp_packet,
 					 packet_len);
 		goto free_skb;
@@ -218,7 +218,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dst_unreach;
 
-	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->dst);
+	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->ih.dst);
 	if (!orig_node)
 		goto dst_unreach;
 
@@ -232,7 +232,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	if (neigh_node->if_incoming->if_status != BATADV_IF_ACTIVE)
 		goto dst_unreach;
 
-	memcpy(icmp_packet->orig,
+	memcpy(icmp_packet->ih.orig,
 	       primary_if->net_dev->dev_addr, ETH_ALEN);
 
 	if (packet_len == sizeof(struct batadv_icmp_packet_rr))
@@ -243,7 +243,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	goto out;
 
 dst_unreach:
-	icmp_packet->msg_type = BATADV_DESTINATION_UNREACHABLE;
+	icmp_packet->ih.msg_type = BATADV_DESTINATION_UNREACHABLE;
 	batadv_socket_add_packet(socket_client, icmp_packet, packet_len);
 free_skb:
 	kfree_skb(skb);
@@ -317,7 +317,7 @@ static void batadv_socket_add_packet(struct batadv_socket_client *socket_client,
 	/* while waiting for the lock the socket_client could have been
 	 * deleted
 	 */
-	if (!batadv_socket_client_hash[icmp_packet->uid]) {
+	if (!batadv_socket_client_hash[icmp_packet->ih.uid]) {
 		spin_unlock_bh(&socket_client->lock);
 		kfree(socket_packet);
 		return;
@@ -346,7 +346,7 @@ void batadv_socket_receive_packet(struct batadv_icmp_packet_rr *icmp_packet,
 {
 	struct batadv_socket_client *hash;
 
-	hash = batadv_socket_client_hash[icmp_packet->uid];
+	hash = batadv_socket_client_hash[icmp_packet->ih.uid];
 	if (hash)
 		batadv_socket_add_packet(hash, icmp_packet, icmp_len);
 }
diff --git a/main.c b/main.c
index af89c09..81d496a 100644
--- a/main.c
+++ b/main.c
@@ -344,8 +344,8 @@ static void batadv_recv_handler_init(void)
 	BUILD_BUG_ON(offsetof(struct batadv_unicast_packet, dest) != 4);
 	BUILD_BUG_ON(offsetof(struct batadv_unicast_frag_packet, dest) != 4);
 	BUILD_BUG_ON(offsetof(struct batadv_unicast_tvlv_packet, dst) != 4);
-	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet, dst) != 4);
-	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet_rr, dst) != 4);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet, ih.dst) != 4);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet_rr, ih.dst) != 4);
 
 	/* broadcast packet */
 	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
diff --git a/packet.h b/packet.h
index 7d45890..6f98d02 100644
--- a/packet.h
+++ b/packet.h
@@ -192,28 +192,44 @@ struct batadv_ogm_packet {
 
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
-struct batadv_icmp_packet {
+/**
+ * batadc_icmp_header - common ICMP header
+ * @header: common batman header
+ * @msg_type: ICMP packet type
+ * @dst: address of the destination node
+ * @orig: address of the source node
+ * @seqno: ICMP sequence number
+ * @uid: local ICMP socket identifier
+ */
+struct batadv_icmp_header {
 	struct batadv_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  orig[ETH_ALEN];
 	__be16   seqno;
 	uint8_t  uid;
+};
+
+/**
+ * batadv_icmp_packet - ICMP packet
+ * @ih: common ICMP header
+ * @reserved: not used - useful for alignment
+ */
+struct batadv_icmp_packet {
+	struct batadv_icmp_header ih;
 	uint8_t  reserved;
 };
 
 #define BATADV_RR_LEN 16
 
-/* icmp_packet_rr must start with all fields from imcp_packet
- * as this is assumed by code that handles ICMP packets
+/**
+ * batadv_icmp_packet_rr - ICMP RouteRecord packet
+ * @ih: common ICMP header
+ * @rr_cur: number of entries the rr array
+ * @rr: route record array
  */
 struct batadv_icmp_packet_rr {
-	struct batadv_header header;
-	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  dst[ETH_ALEN];
-	uint8_t  orig[ETH_ALEN];
-	__be16   seqno;
-	uint8_t  uid;
+	struct batadv_icmp_header ih;
 	uint8_t  rr_cur;
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 };
diff --git a/routing.c b/routing.c
index 7c372f1..b448442 100644
--- a/routing.c
+++ b/routing.c
@@ -258,7 +258,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
 
 	/* add data to device queue */
-	if (icmp_packet->msg_type != BATADV_ECHO_REQUEST) {
+	if (icmp_packet->ih.msg_type != BATADV_ECHO_REQUEST) {
 		batadv_socket_receive_packet(icmp_packet, icmp_len);
 		goto out;
 	}
@@ -269,7 +269,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 
 	/* answer echo request (ping) */
 	/* get routing information */
-	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->orig);
+	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->ih.orig);
 	if (!orig_node)
 		goto out;
 
@@ -279,10 +279,10 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
 
-	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-	memcpy(icmp_packet->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
-	icmp_packet->msg_type = BATADV_ECHO_REPLY;
-	icmp_packet->header.ttl = BATADV_TTL;
+	memcpy(icmp_packet->ih.dst, icmp_packet->ih.orig, ETH_ALEN);
+	memcpy(icmp_packet->ih.orig, primary_if->net_dev->dev_addr, ETH_ALEN);
+	icmp_packet->ih.msg_type = BATADV_ECHO_REPLY;
+	icmp_packet->ih.header.ttl = BATADV_TTL;
 
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
 		ret = NET_RX_SUCCESS;
@@ -306,9 +306,9 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet = (struct batadv_icmp_packet *)skb->data;
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
-	if (icmp_packet->msg_type != BATADV_ECHO_REQUEST) {
+	if (icmp_packet->ih.msg_type != BATADV_ECHO_REQUEST) {
 		pr_debug("Warning - can't forward icmp packet from %pM to %pM: ttl exceeded\n",
-			 icmp_packet->orig, icmp_packet->dst);
+			 icmp_packet->ih.orig, icmp_packet->ih.dst);
 		goto out;
 	}
 
@@ -317,7 +317,7 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* get routing information */
-	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->orig);
+	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->ih.orig);
 	if (!orig_node)
 		goto out;
 
@@ -327,10 +327,10 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 
 	icmp_packet = (struct batadv_icmp_packet *)skb->data;
 
-	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-	memcpy(icmp_packet->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
-	icmp_packet->msg_type = BATADV_TTL_EXCEEDED;
-	icmp_packet->header.ttl = BATADV_TTL;
+	memcpy(icmp_packet->ih.dst, icmp_packet->ih.orig, ETH_ALEN);
+	memcpy(icmp_packet->ih.orig, primary_if->net_dev->dev_addr, ETH_ALEN);
+	icmp_packet->ih.msg_type = BATADV_TTL_EXCEEDED;
+	icmp_packet->ih.header.ttl = BATADV_TTL;
 
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
 		ret = NET_RX_SUCCESS;
@@ -379,8 +379,8 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
 
 	/* add record route information if not full */
-	if ((icmp_packet->msg_type == BATADV_ECHO_REPLY ||
-	     icmp_packet->msg_type == BATADV_ECHO_REQUEST) &&
+	if ((icmp_packet->ih.msg_type == BATADV_ECHO_REPLY ||
+	     icmp_packet->ih.msg_type == BATADV_ECHO_REQUEST) &&
 	    (hdr_size == sizeof(struct batadv_icmp_packet_rr)) &&
 	    (icmp_packet->rr_cur < BATADV_RR_LEN)) {
 		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur]),
@@ -389,15 +389,15 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	}
 
 	/* packet for me */
-	if (batadv_is_my_mac(bat_priv, icmp_packet->dst))
+	if (batadv_is_my_mac(bat_priv, icmp_packet->ih.dst))
 		return batadv_recv_my_icmp_packet(bat_priv, skb, hdr_size);
 
 	/* TTL exceeded */
-	if (icmp_packet->header.ttl < 2)
+	if (icmp_packet->ih.header.ttl < 2)
 		return batadv_recv_icmp_ttl_exceeded(bat_priv, skb);
 
 	/* get routing information */
-	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->dst);
+	orig_node = batadv_orig_hash_find(bat_priv, icmp_packet->ih.dst);
 	if (!orig_node)
 		goto out;
 
@@ -408,7 +408,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
 
 	/* decrement ttl */
-	icmp_packet->header.ttl--;
+	icmp_packet->ih.header.ttl--;
 
 	/* route it */
 	if (batadv_send_skb_to_orig(skb, orig_node, recv_if) != NET_XMIT_DROP)
-- 
1.8.1.5

