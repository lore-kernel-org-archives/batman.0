Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 14 Jul 2012 01:41:43 +0200
Message-Id: <1342222910-20627-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1342222910-20627-1-git-send-email-ordex@autistici.org>
References: <1342222910-20627-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv9 1/8] batman-adv: add UNICAST_4ADDR packet
	type
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

The current unicast packet type does not contain the orig source address. This
patches add a new unicast packet (called UNICAST_4ADDR) which provides two new
fields: the originator source address and the subtype (the type of the data
contained in the packet payload). The former is useful to identify the node
which injected the packet into the network and the latter is useful to avoid
creating new unicast packet types in the future: a macro defining a new subtype
will be enough.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c    |    2 +
 packet.h  |   27 ++++++++----
 routing.c |    8 +++-
 unicast.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 unicast.h |   20 ++++++++-
 5 files changed, 165 insertions(+), 29 deletions(-)

diff --git a/main.c b/main.c
index 2a1f243..ad0d2fe 100644
--- a/main.c
+++ b/main.c
@@ -274,6 +274,8 @@ static void batadv_recv_handler_init(void)
 
 	/* batman icmp packet */
 	batadv_rx_handler[BATADV_ICMP] = batadv_recv_icmp_packet;
+	/* unicast with 4 addresses packet */
+	batadv_rx_handler[BATADV_UNICAST_4ADDR] = batadv_recv_unicast_packet;
 	/* unicast packet */
 	batadv_rx_handler[BATADV_UNICAST] = batadv_recv_unicast_packet;
 	/* fragmented unicast packet */
diff --git a/packet.h b/packet.h
index db21230..e48f066 100644
--- a/packet.h
+++ b/packet.h
@@ -23,14 +23,19 @@
 #define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype */
 
 enum batadv_packettype {
-	BATADV_IV_OGM	    = 0x01,
-	BATADV_ICMP	    = 0x02,
-	BATADV_UNICAST	    = 0x03,
-	BATADV_BCAST	    = 0x04,
-	BATADV_VIS	    = 0x05,
-	BATADV_UNICAST_FRAG = 0x06,
-	BATADV_TT_QUERY	    = 0x07,
-	BATADV_ROAM_ADV	    = 0x08,
+	BATADV_IV_OGM		= 0x01,
+	BATADV_ICMP		= 0x02,
+	BATADV_UNICAST		= 0x03,
+	BATADV_BCAST		= 0x04,
+	BATADV_VIS		= 0x05,
+	BATADV_UNICAST_FRAG	= 0x06,
+	BATADV_TT_QUERY		= 0x07,
+	BATADV_ROAM_ADV		= 0x08,
+	BATADV_UNICAST_4ADDR	= 0x09,
+};
+
+enum batadv_subtype {
+	BATADV_P_DATA		= 0x01,
 };
 
 /* this file is included by batctl which needs these defines */
@@ -161,6 +166,12 @@ struct batadv_unicast_packet {
 	uint8_t  dest[ETH_ALEN];
 } __packed;
 
+struct batadv_unicast_4addr_packet {
+	struct batadv_unicast_packet u;
+	uint8_t src[ETH_ALEN];
+	uint8_t subtype;
+} __packed;
+
 struct batadv_unicast_frag_packet {
 	struct batadv_header header;
 	uint8_t  ttvn; /* destination translation table version number */
diff --git a/routing.c b/routing.c
index b043ef9..191f531 100644
--- a/routing.c
+++ b/routing.c
@@ -1015,14 +1015,18 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_unicast_packet *unicast_packet;
 	int hdr_size = sizeof(*unicast_packet);
 
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+
+	/* the caller function should have already pulled 2 bytes */
+	if (unicast_packet->header.packet_type == BATADV_UNICAST_4ADDR)
+		hdr_size = sizeof(struct batadv_unicast_4addr_packet);
+
 	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
 	if (!batadv_check_unicast_ttvn(bat_priv, skb))
 		return NET_RX_DROP;
 
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-
 	/* packet for me */
 	if (batadv_is_my_mac(unicast_packet->dest)) {
 		batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size,
diff --git a/unicast.c b/unicast.c
index 0016464..3621d99 100644
--- a/unicast.c
+++ b/unicast.c
@@ -288,7 +288,108 @@ out:
 	return ret;
 }
 
-int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv)
+/**
+ * batadv_pull_and_fill_unicast - extends the buffer and initialize the common
+ * fields for unicast packets
+ *
+ * @skb: packet
+ * @hdr_size: amount of bytes to push at the beginning of the
+ * @orig_node: the destination node
+ *
+ * Returns false if the buffer extension was not possible or true otherwise
+ */
+static bool batadv_push_and_fill_unicast(struct sk_buff *skb, int hdr_size,
+					 struct batadv_orig_node *orig_node)
+{
+	struct batadv_unicast_packet *unicast_packet;
+
+	if (batadv_skb_head_push(skb, hdr_size) < 0)
+		return false;
+
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+	unicast_packet->header.version = BATADV_COMPAT_VERSION;
+	/* batman packet type: unicast */
+	unicast_packet->header.packet_type = BATADV_UNICAST;
+	/* set unicast ttl */
+	unicast_packet->header.ttl = BATADV_TTL;
+	/* copy the destination for faster routing */
+	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
+	/* set the destination tt version number */
+	unicast_packet->ttvn =
+		(uint8_t)atomic_read(&orig_node->last_ttvn);
+
+	return true;
+}
+
+/**
+ * batadv_prepare_unicast_packet - encapsulate an skb with a unicast header
+ *
+ * @skb: the skb containing the payload to encapsulate
+ * @orig_node: the destination node
+ *
+ * Returns false if the payload could not be encapsulated or true otherwise
+ */
+static bool batadv_prepare_unicast_packet(struct sk_buff *skb,
+					  struct batadv_orig_node *orig_node)
+{
+	size_t uni_size = sizeof(struct batadv_unicast_packet);
+	return batadv_push_and_fill_unicast(skb, uni_size, orig_node);
+}
+
+/**
+ * batadv_prepare_unicast_packet - encapsulate an skb with a unicast4addr header
+ *
+ * @skb: the skb containing the payload to encapsulate
+ * @orig_node: the destination node
+ *
+ * Returns false if the payload could not be encapsulated or true otherwise
+ */
+static bool batadv_prepare_unicast_4addr_packet(struct batadv_priv *bat_priv,
+						struct sk_buff *skb,
+						struct batadv_orig_node *orig,
+						int packet_subtype)
+{
+	struct batadv_hard_iface *primary_if;
+	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
+	bool ret = false;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	/* pull the header space and fill the unicast_packet substructure.
+	 * We can do that because the first member of the unicast_4addr_packet
+	 * is of type struct unicast_packet
+	 */
+	if (!batadv_push_and_fill_unicast(skb, sizeof(*unicast_4addr_packet),
+					  orig))
+		goto out;
+
+	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
+	unicast_4addr_packet->u.header.packet_type = BATADV_UNICAST_4ADDR;
+	memcpy(unicast_4addr_packet->src, primary_if->net_dev->dev_addr,
+	       ETH_ALEN);
+	unicast_4addr_packet->subtype = packet_subtype;
+
+	ret = true;
+out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+	return ret;
+}
+
+/**
+ * batadv_unicast_generic_send_skb - send an skb as unicast
+ *
+ * @skb: payload to send
+ * @bat_priv: the bat priv with all the soft interface information
+ * @packet_type: the batman unicast packet type to use
+ *
+ * Returns 1 in case of error or 0 otherwise
+ */
+int batadv_unicast_generic_send_skb(struct sk_buff *skb,
+				    struct batadv_priv *bat_priv,
+				    int packet_type, int packet_subtype)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_unicast_packet *unicast_packet;
@@ -310,33 +411,32 @@ int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv)
 	 */
 	orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
 					     ethhdr->h_dest);
-
 find_router:
 	/* find_router():
 	 *  - if orig_node is NULL it returns NULL
 	 *  - increases neigh_nodes refcount if found.
 	 */
 	neigh_node = batadv_find_router(bat_priv, orig_node, NULL);
-
 	if (!neigh_node)
 		goto out;
 
-	if (batadv_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
+	switch (packet_type) {
+	case BATADV_UNICAST:
+		batadv_prepare_unicast_packet(skb, orig_node);
+		break;
+	case BATADV_UNICAST_4ADDR:
+		batadv_prepare_unicast_4addr_packet(bat_priv, skb, orig_node,
+						    packet_subtype);
+		break;
+	default:
+		/* this function supports UNICAST and UNICAST_4ADDR only. It
+		 * should never be invoked with any other packet type
+		 */
 		goto out;
+	}
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
-	unicast_packet->header.version = BATADV_COMPAT_VERSION;
-	/* batman packet type: unicast */
-	unicast_packet->header.packet_type = BATADV_UNICAST;
-	/* set unicast ttl */
-	unicast_packet->header.ttl = BATADV_TTL;
-	/* copy the destination for faster routing */
-	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
-	/* set the destination tt version number */
-	unicast_packet->ttvn =
-		(uint8_t)atomic_read(&orig_node->last_ttvn);
-
 	/* inform the destination node that we are still missing a correct route
 	 * for this client. The destination will receive this packet and will
 	 * try to reroute it because the ttvn contained in the header is less
@@ -346,8 +446,10 @@ find_router:
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
 	dev_mtu = neigh_node->if_incoming->net_dev->mtu;
-	if (atomic_read(&bat_priv->fragmentation) &&
-	    data_len + sizeof(*unicast_packet) > dev_mtu) {
+	/* fragmentation mechanism only works for UNICAST (now) */
+	if (packet_type == BATADV_UNICAST &&
+	    atomic_read(&bat_priv->fragmentation) &&
+	    data_len + dev_mtu) {
 		/* send frag skb decreases ttl */
 		unicast_packet->header.ttl++;
 		ret = batadv_frag_send_skb(skb, bat_priv,
@@ -358,7 +460,6 @@ find_router:
 
 	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
-	goto out;
 
 out:
 	if (neigh_node)
diff --git a/unicast.h b/unicast.h
index 1c46e2e..23d526e 100644
--- a/unicast.h
+++ b/unicast.h
@@ -29,10 +29,28 @@ int batadv_frag_reassemble_skb(struct sk_buff *skb,
 			       struct batadv_priv *bat_priv,
 			       struct sk_buff **new_skb);
 void batadv_frag_list_free(struct list_head *head);
-int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv);
 int batadv_frag_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv,
 			 struct batadv_hard_iface *hard_iface,
 			 const uint8_t dstaddr[]);
+int batadv_unicast_generic_send_skb(struct sk_buff *skb,
+				    struct batadv_priv *bat_priv,
+				    int packet_type, int packet_subtype);
+
+static inline int batadv_unicast_send_skb(struct sk_buff *skb,
+					  struct batadv_priv *bat_priv)
+{
+	return batadv_unicast_generic_send_skb(skb, bat_priv, BATADV_UNICAST,
+					       0);
+}
+
+static inline int batadv_unicast_4addr_send_skb(struct sk_buff *skb,
+						struct batadv_priv *bat_priv,
+						int packet_subtype)
+{
+	return batadv_unicast_generic_send_skb(skb, bat_priv,
+					       BATADV_UNICAST_4ADDR,
+					       packet_subtype);
+}
 
 static inline int batadv_frag_can_reassemble(const struct sk_buff *skb, int mtu)
 {
-- 
1.7.9.4

