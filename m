Return-Path: <mihail.costea2005@gmail.com>
From: Mihail <mihail.costea2005@gmail.com>
Date: Fri, 17 May 2013 15:27:52 +0300
Message-Id: <1368793673-27539-4-git-send-email-mihail.costea2005@gmail.com>
In-Reply-To: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC 4/4] batman-adv: generalize snooping mechanism
	in order to suport NDP too
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

From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>

Generalized snooping functions in order to support Neighbor Advertisement
and Neighbor Solicitation too.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 distributed-arp-table.c |  459 +++++++++++++++++++++++++++++++++++------------
 types.h                 |   16 ++
 2 files changed, 360 insertions(+), 115 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index bd69b89..9bac6cb 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -235,9 +235,9 @@ static uint8_t *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
  *
  * Returns the value of the ip_src field in the ARP packet.
  */
-static __be32 batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
+static __be32 *batadv_arp_ip_src(struct sk_buff *skb, int hdr_size)
 {
-	return *(__be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN);
+	return (__be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN);
 }
 
 /**
@@ -259,9 +259,9 @@ static uint8_t *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
  *
  * Returns the value of the ip_dst field in the ARP packet.
  */
-static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
+static __be32 *batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 {
-	return *(__be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN * 2 + 4);
+	return (__be32 *)(batadv_arp_hw_src(skb, hdr_size) + ETH_ALEN * 2 + 4);
 }
 
 /**
@@ -456,8 +456,8 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (msg)
 		batadv_dbg(BATADV_DBG_DAT, bat_priv, "%s\n", msg);
 
-	ip_src = batadv_arp_ip_src(skb, hdr_size);
-	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+	ip_src = *batadv_arp_ip_src(skb, hdr_size);
+	ip_dst = *batadv_arp_ip_dst(skb, hdr_size);
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
 		   "ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]\n",
 		   batadv_arp_hw_src(skb, hdr_size), &ip_src,
@@ -976,8 +976,8 @@ static uint16_t batadv_arp_get_type(struct batadv_priv *bat_priv,
 	/* Check for bad reply/request. If the ARP message is not sane, DAT
 	 * will simply ignore it
 	 */
-	ip_src = batadv_arp_ip_src(skb, hdr_size);
-	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+	ip_src = *batadv_arp_ip_src(skb, hdr_size);
+	ip_dst = *batadv_arp_ip_dst(skb, hdr_size);
 	if (ipv4_is_loopback(ip_src) || ipv4_is_multicast(ip_src) ||
 	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst) ||
 	    ipv4_is_zeronet(ip_src) || ipv4_is_lbcast(ip_src) ||
@@ -1319,11 +1319,237 @@ sk_buff *batadv_ndisc_create_na(struct net_device *dev,
 
 	return skb;
 }
+
+/**
+ * batadv_dat_snoop_ndisc_addr - snoop addresses from NA / NS messages
+ * @skb: packet to snoop
+ * @hdr_size: size of the encapsulation header
+ * @target_address_type: type of target address
+ * (ND_OPT_SOURCE_LL_ADDR or ND_OPT_TARGET_LL_ADDR)
+ * @hw_src: source HW Address
+ * @ipv6_src: source IPv6
+ * @hw_dst: destination HW Address
+ * @ipv6_dst: destination IPv6
+ * @hw_target: target HW Address
+ * @ipv6_target: target IPv6
+ *
+ * If an address parameter is NULL, then the correspondent field is not
+ * snooped. The fields might be different depending on packet type (NS / NA).
+ *
+ * Return true if snooping was successful.
+ */
+static bool batadv_dat_snoop_ndisc_addr(struct sk_buff *skb, int hdr_size,
+					uint8_t target_address_type,
+					uint8_t **hw_src, void **ipv6_src,
+					uint8_t **hw_dst, void **ipv6_dst,
+					uint8_t **hw_target, void **ipv6_target)
+{
+	if (hw_src)
+		*hw_src = batadv_ndisc_hw_src(skb, hdr_size);
+	if (ipv6_src)
+		*ipv6_src = batadv_ndisc_ipv6_src(skb, hdr_size);
+	if (hw_dst)
+		*hw_dst = batadv_ndisc_hw_dst(skb, hdr_size);
+	if (ipv6_dst)
+		*ipv6_dst = batadv_ndisc_ipv6_dst(skb, hdr_size);
+	if (hw_target) {
+		*hw_target = batadv_ndisc_hw_opt(skb, hdr_size,
+						 target_address_type);
+		if (!*hw_target)
+			return false;
+	}
+	if (ipv6_target)
+		*ipv6_target = batadv_ndisc_ipv6_target(skb, hdr_size);
+
+	return true;
+}
+#endif
+
+/**
+ * batadv_dat_snoop_arp_addr - snoop addresses from ARP Request / Reply
+ * @skb: packet to snoop
+ * @hdr_size: size of the encapsulation header
+ * @hw_src: source HW Address
+ * @ip_src: source IPv4
+ * @hw_dst: destination HW Address
+ * @ip_dst: destination IPv4
+ */
+static void batadv_dat_snoop_arp_addr(struct sk_buff *skb, int hdr_size,
+				      uint8_t **hw_src, void **ip_src,
+				      uint8_t **hw_dst, void **ip_dst)
+{
+	*hw_src = batadv_arp_hw_src(skb, hdr_size);
+	*ip_src = batadv_arp_ip_src(skb, hdr_size);
+	*hw_dst = batadv_arp_hw_dst(skb, hdr_size);
+	*ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+}
+
+/**
+ * batadv_dat_snoop_msg_addresses - snooping mechanism for all packets that
+ * participate in DAT
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: packet to snoop
+ * @hdr_size: size of the encapsulation header
+ * @msg_type: outgoing / incoming message request / reply
+ * @hw_src: source HW Address
+ * @ip_src: source IP
+ * @hw_dst: destination HW Address
+ * @ip_dst: destination IP
+ *
+ * Returns a batadv_dat_types data type.
+ */
+static int batadv_dat_snoop_msg(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, int hdr_size,
+				uint8_t msg_type,
+				uint8_t **hw_src, void **ip_src,
+				uint8_t **hw_dst, void **ip_dst)
+{
+	uint16_t type;
+	int data_type = -1;
+
+	/* parse message requests */
+	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
+	if (msg_type == BATADV_DAT_OUTGOING_MSG_REQUEST ||
+	    msg_type == BATADV_DAT_INCOMING_MSG_REQUEST) {
+		if (type == ARPOP_REQUEST) {
+			batadv_dat_snoop_arp_addr(skb, hdr_size, hw_src, ip_src,
+						  hw_dst, ip_dst);
+			batadv_dbg_arp(bat_priv, skb, type, hdr_size,
+				       "Parsing ARP REQUEST");
+			data_type = BATADV_DAT_IPV4;
+			goto out;
+		}
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (batadv_ndisc_is_valid(bat_priv, skb, hdr_size,
+					  NDISC_NEIGHBOUR_SOLICITATION)) {
+			if (!batadv_dat_snoop_ndisc_addr(skb, hdr_size,
+							 ND_OPT_SOURCE_LL_ADDR,
+							 NULL, ip_src,
+							 hw_dst, NULL,
+							 hw_src, ip_dst))
+				goto out;
+
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Parsing NS = [src: %pM / %pI6c -> "
+					"target: %pM / %pI6c]\n",
+				   *hw_src, *ip_src, *hw_dst, *ip_dst);
+			data_type = BATADV_DAT_IPV6;
+			goto out;
+		}
+#endif
+	}
+
+	/* parse message replies */
+	if (msg_type == BATADV_DAT_OUTGOING_MSG_REPLY ||
+	    msg_type == BATADV_DAT_INCOMING_MSG_REPLY) {
+		if (type == ARPOP_REPLY) {
+			batadv_dat_snoop_arp_addr(skb, hdr_size, hw_src, ip_src,
+						  hw_dst, ip_dst);
+			batadv_dbg_arp(bat_priv, skb, type, hdr_size,
+				       "Parsing ARP REPLY");
+			data_type = BATADV_DAT_IPV4;
+			goto out;
+		}
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (batadv_ndisc_is_valid(bat_priv, skb, hdr_size,
+					  NDISC_NEIGHBOUR_ADVERTISEMENT)) {
+			if (!batadv_dat_snoop_ndisc_addr(skb, hdr_size,
+							 ND_OPT_TARGET_LL_ADDR,
+							 NULL, NULL,
+							 hw_dst, ip_dst,
+							 hw_src, ip_src))
+				goto out;
+
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Parsing NA = [src: %pM / %pI6c -> "
+					"target: %pM / %pI6c]\n",
+				   *hw_src, *ip_src, *hw_dst, *ip_dst);
+
+			data_type = BATADV_DAT_IPV6;
+			goto out;
+		}
+#endif
+	}
+
+out:
+	return data_type;
+}
+
+/**
+ * batadv_dat_snoop_ip_dst - snoops only destination IP from skb
+ * (useful for broadcast check)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: packet to snoop
+ * @hdr_size: size of the encapsulation header
+ * @ip_dst: destination IP
+ *
+ * Returns a batadv_dat_types data type.
+ */
+static int batadv_dat_snoop_ip_dst(struct batadv_priv *bat_priv,
+				   struct sk_buff *skb, int hdr_size,
+				   void **ip_dst)
+{
+	int data_type = -1;
+
+	if (batadv_arp_get_type(bat_priv, skb, hdr_size) == ARPOP_REQUEST) {
+		*ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+		data_type = BATADV_DAT_IPV4;
+		goto out;
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (batadv_ndisc_is_valid(bat_priv, skb, hdr_size,
+				  NDISC_NEIGHBOUR_SOLICITATION)) {
+		*ip_dst = batadv_ndisc_ipv6_target(skb, hdr_size);
+		data_type = BATADV_DAT_IPV6;
+		goto out;
+	}
+#endif
+
+out:
+	return data_type;
+}
+
+/**
+ * batadv_dat_create_skb - creates a skb as a reply to a message request
+ * (useful for broadcast check)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @dat_entry: the DAT entry used for destination HW Address
+ * @hdr_size: size of the encapsulation header
+ * @hw_src: source HW Address
+ * @ip_src: source IP
+ * @ip_dst: destination IP
+ *
+ * Returns the newly created skb, or NULL if any error.
+ */
+struct sk_buff *batadv_dat_create_skb(struct batadv_priv *bat_priv,
+				      struct batadv_dat_entry *dat_entry,
+				      uint8_t *hw_src, void *ip_src,
+				      void *ip_dst)
+{
+	switch (dat_entry->type) {
+	case BATADV_DAT_IPV4:
+		return arp_create(ARPOP_REPLY, ETH_P_ARP, *(__be32 *)ip_src,
+				  bat_priv->soft_iface, *(__be32 *)ip_dst,
+				  hw_src, dat_entry->mac_addr, hw_src);
+#if IS_ENABLED(CONFIG_IPV6)
+	case BATADV_DAT_IPV6:
+		/* TODO calculate router and override parameters */
+		return batadv_ndisc_create_na(bat_priv->soft_iface,
+					      ip_src, ip_dst,
+					      hw_src, dat_entry->mac_addr,
+					      0, 1, 1);
 #endif
+	default:
+		return NULL;
+	}
+}
 
 /**
- * batadv_dat_snoop_outgoing_msg_request - snoop the ARP request and try to
- * answer using DAT
+ * batadv_dat_snoop_outgoing_msg_request - snoop the ARP request / NS
+ * and try to answer using DAT
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  *
@@ -1334,50 +1560,33 @@ sk_buff *batadv_ndisc_create_na(struct net_device *dev,
 bool batadv_dat_snoop_outgoing_msg_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
 {
-	uint16_t type = 0;
-	__be32 ip_dst, ip_src;
-	uint8_t *hw_src;
+	void *ip_src, *ip_dst;
+	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
 	struct batadv_dat_entry *dat_entry = NULL;
 	struct sk_buff *skb_new;
+	int data_type;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
-	type = batadv_arp_get_type(bat_priv, skb, 0);
-	/* If the node gets an ARP_REQUEST it has to send a DHT_GET unicast
+	/* If the node gets an ARP_REQUEST / NS it has to send a DHT_GET unicast
 	 * message to the selected DHT candidates
 	 */
-	if (type != ARPOP_REQUEST)
+	data_type = batadv_dat_snoop_msg(bat_priv, skb, 0,
+					 BATADV_DAT_OUTGOING_MSG_REQUEST,
+					 &hw_src, &ip_src,
+					 &hw_dst, &ip_dst);
+	if (data_type < 0)
 		goto out;
 
-	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REQUEST");
+	batadv_dat_entry_add(bat_priv, ip_src, data_type, hw_src);
 
-	ip_src = batadv_arp_ip_src(skb, 0);
-	hw_src = batadv_arp_hw_src(skb, 0);
-	ip_dst = batadv_arp_ip_dst(skb, 0);
-
-	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
-
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
-					       BATADV_DAT_IPV4);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst,
+					       data_type);
 	if (dat_entry) {
-		/* If the ARP request is destined for a local client the local
-		 * client will answer itself. DAT would only generate a
-		 * duplicate packet.
-		 *
-		 * Moreover, if the soft-interface is enslaved into a bridge, an
-		 * additional DAT answer may trigger kernel warnings about
-		 * a packet coming from the wrong port.
-		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr)) {
-			ret = true;
-			goto out;
-		}
-
-		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-				     bat_priv->soft_iface, ip_dst, hw_src,
-				     dat_entry->mac_addr, hw_src);
+		skb_new = batadv_dat_create_skb(bat_priv, dat_entry,
+						hw_src, ip_src, ip_dst);
 		if (!skb_new)
 			goto out;
 
@@ -1389,12 +1598,12 @@ bool batadv_dat_snoop_outgoing_msg_request(struct batadv_priv *bat_priv,
 		bat_priv->soft_iface->last_rx = jiffies;
 
 		netif_rx(skb_new);
-		batadv_dbg(BATADV_DBG_DAT, bat_priv, "ARP request replied locally\n");
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "ARP request / NS replied locally\n");
 		ret = true;
 	} else {
 		/* Send the request to the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, &ip_dst,
-					   BATADV_DAT_IPV4,
+		ret = batadv_dat_send_data(bat_priv, skb, ip_dst, data_type,
 					   BATADV_P_DAT_DHT_GET);
 	}
 out:
@@ -1404,7 +1613,7 @@ out:
 }
 
 /**
- * batadv_dat_snoop_incoming_msg_request - snoop the ARP request and try to
+ * batadv_dat_snoop_incoming_msg_request - snoop the ARP request / NS and try to
  * answer using the local DAT storage
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
@@ -1415,39 +1624,31 @@ out:
 bool batadv_dat_snoop_incoming_msg_request(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb, int hdr_size)
 {
-	uint16_t type;
-	__be32 ip_src, ip_dst;
-	uint8_t *hw_src;
+	void *ip_src, *ip_dst;
+	uint8_t *hw_src, *hw_dst;
 	struct sk_buff *skb_new;
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
-	int err;
+	int err, data_type;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
-	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
-	if (type != ARPOP_REQUEST)
+	data_type = batadv_dat_snoop_msg(bat_priv, skb, hdr_size,
+					 BATADV_DAT_INCOMING_MSG_REQUEST,
+					 &hw_src, &ip_src,
+					 &hw_dst, &ip_dst);
+	if (data_type < 0)
 		goto out;
 
-	hw_src = batadv_arp_hw_src(skb, hdr_size);
-	ip_src = batadv_arp_ip_src(skb, hdr_size);
-	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+	batadv_dat_entry_add(bat_priv, ip_src, data_type, hw_src);
 
-	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
-		       "Parsing incoming ARP REQUEST");
-
-	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
-
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
-					       BATADV_DAT_IPV4);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, data_type);
 	if (!dat_entry)
 		goto out;
 
-	skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-			     bat_priv->soft_iface, ip_dst, hw_src,
-			     dat_entry->mac_addr, hw_src);
-
+	skb_new = batadv_dat_create_skb(bat_priv, dat_entry,
+					hw_src, ip_src, ip_dst);
 	if (!skb_new)
 		goto out;
 
@@ -1474,45 +1675,50 @@ out:
 }
 
 /**
- * batadv_dat_snoop_outgoing_msg_reply - snoop the ARP reply and fill the DHT
+ * batadv_dat_snoop_outgoing_msg_reply - snoop the ARP reply / NA and fill
+ * the DHT
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  */
 void batadv_dat_snoop_outgoing_msg_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
 {
-	uint16_t type;
-	__be32 ip_src, ip_dst;
+	void *ip_src, *ip_dst;
 	uint8_t *hw_src, *hw_dst;
+	int data_type;
+	bool add_entry = true;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		return;
 
-	type = batadv_arp_get_type(bat_priv, skb, 0);
-	if (type != ARPOP_REPLY)
+	data_type = batadv_dat_snoop_msg(bat_priv, skb, 0,
+					 BATADV_DAT_OUTGOING_MSG_REPLY,
+					 &hw_src, &ip_src,
+					 &hw_dst, &ip_dst);
+	if (data_type < 0)
 		return;
 
-	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
-
-	hw_src = batadv_arp_hw_src(skb, 0);
-	ip_src = batadv_arp_ip_src(skb, 0);
-	hw_dst = batadv_arp_hw_dst(skb, 0);
-	ip_dst = batadv_arp_ip_dst(skb, 0);
-
-	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
-	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst);
-
-	/* Send the ARP reply to the candidates for both the IP addresses that
-	 * the node obtained from the ARP reply
+	batadv_dat_entry_add(bat_priv, ip_src, data_type, hw_src);
+	/* Send the ARP reply / NA to the candidates for both the IP addresses
+	 * that the node obtained from the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, &ip_src, BATADV_DAT_IPV4,
-			     BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, &ip_dst, BATADV_DAT_IPV4,
+	batadv_dat_send_data(bat_priv, skb, ip_src, data_type,
 			     BATADV_P_DAT_DHT_PUT);
+
+	/* not a solicited advertisement */
+#if IS_ENABLED(CONFIG_IPV6)
+	if (data_type == BATADV_DAT_IPV6 && ipv6_addr_is_multicast(ip_dst))
+		add_entry = false;
+#endif
+	if (add_entry) {
+		batadv_dat_entry_add(bat_priv, ip_dst, data_type, hw_dst);
+		batadv_dat_send_data(bat_priv, skb, ip_dst, data_type,
+				     BATADV_P_DAT_DHT_PUT);
+	}
 }
 /**
- * batadv_dat_snoop_incoming_msg_reply - snoop the ARP reply and fill the local
- * DAT storage only
+ * batadv_dat_snoop_incoming_msg_reply - snoop the ARP reply / NA and fill the
+ * local DAT storage only
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
@@ -1520,31 +1726,33 @@ void batadv_dat_snoop_outgoing_msg_reply(struct batadv_priv *bat_priv,
 bool batadv_dat_snoop_incoming_msg_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
 {
-	uint16_t type;
-	__be32 ip_src, ip_dst;
+	void *ip_src, *ip_dst;
 	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
+	int data_type;
+	bool add_entry = true;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
-	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
-	if (type != ARPOP_REPLY)
+	data_type = batadv_dat_snoop_msg(bat_priv, skb, hdr_size,
+					 BATADV_DAT_INCOMING_MSG_REPLY,
+					 &hw_src, &ip_src,
+					 &hw_dst, &ip_dst);
+	if (data_type < 0)
 		goto out;
 
-	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
-		       "Parsing incoming ARP REPLY");
-
-	hw_src = batadv_arp_hw_src(skb, hdr_size);
-	ip_src = batadv_arp_ip_src(skb, hdr_size);
-	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
-	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
-
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
-	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst);
+	batadv_dat_entry_add(bat_priv, ip_src, data_type, hw_src);
+	/* not a solicited advertisement */
+#if IS_ENABLED(CONFIG_IPV6)
+	if (data_type == BATADV_DAT_IPV6 && ipv6_addr_is_multicast(ip_dst))
+		add_entry = false;
+#endif
+	if (add_entry)
+		batadv_dat_entry_add(bat_priv, ip_dst, data_type, hw_dst);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
@@ -1558,8 +1766,8 @@ out:
 }
 
 /**
- * batadv_dat_drop_broadcast_packet - check if an ARP request has to be dropped
- * (because the node has already obtained the reply via DAT) or not
+ * batadv_dat_drop_broadcast_packet - check if an ARP request / NS has to be
+ * dropped (because the node has already obtained the reply via DAT) or not
  * @bat_priv: the bat priv with all the soft interface information
  * @forw_packet: the broadcast packet
  *
@@ -1568,37 +1776,58 @@ out:
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				      struct batadv_forw_packet *forw_packet)
 {
-	uint16_t type;
-	__be32 ip_dst;
+	void *ip_dst;
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
 	const size_t bcast_len = sizeof(struct batadv_bcast_packet);
+	int data_type;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
-	/* If this packet is an ARP_REQUEST and the node already has the
+	/* If this packet is an ARP_REQUEST / NS and the node already has the
 	 * information that it is going to ask, then the packet can be dropped
 	 */
 	if (forw_packet->num_packets)
 		goto out;
 
-	type = batadv_arp_get_type(bat_priv, forw_packet->skb, bcast_len);
-	if (type != ARPOP_REQUEST)
+	data_type = batadv_dat_snoop_ip_dst(bat_priv, forw_packet->skb,
+					    bcast_len, &ip_dst);
+	if (data_type < 0)
 		goto out;
 
-	ip_dst = batadv_arp_ip_dst(forw_packet->skb, bcast_len);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
-					       BATADV_DAT_IPV4);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, data_type);
 	/* check if the node already got this entry */
 	if (!dat_entry) {
-		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "ARP Request for %pI4: fallback\n", &ip_dst);
+		switch (data_type) {
+		case BATADV_DAT_IPV4:
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "ARP Request for %pI4: fallback\n", ip_dst);
+			break;
+#if IS_ENABLED(CONFIG_IPV6)
+		case BATADV_DAT_IPV6:
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "NS for %pI6c: fallback\n", ip_dst);
+			break;
+#endif
+		}
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "ARP Request for %pI4: fallback prevented\n", &ip_dst);
+	switch (data_type) {
+	case BATADV_DAT_IPV4:
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "ARP Request for %pI4: fallback prevented\n",
+			   ip_dst);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case BATADV_DAT_IPV6:
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "NS for %pI6c: fallback prevented\n", ip_dst);
+		break;
+	}
+#endif
+
 	ret = true;
 
 out:
diff --git a/types.h b/types.h
index 74c7091..ac85d4a 100644
--- a/types.h
+++ b/types.h
@@ -942,6 +942,22 @@ enum batadv_dat_types {
 };
 
 /**
+ * batadv_dat_msg_types - describe generic message types
+ * @BATADV_DAT_OUTGOING_MSG_REQUEST: an outgoing message request
+ * @BATADV_DAT_INCOMING_MSG_REQUEST: an incoming message request
+ * @BATADV_DAT_OUTGOING_MSG_REPLY: an outgoing message reply
+ * @BATADV_DAT_INCOMING_MSG_REPLY: an incoming message reply
+ *
+ * The messages can be ARP Request / Reply, NS / NA or other packets.
+ */
+enum batadv_dat_msg_types {
+	BATADV_DAT_OUTGOING_MSG_REQUEST,
+	BATADV_DAT_INCOMING_MSG_REQUEST,
+	BATADV_DAT_OUTGOING_MSG_REPLY,
+	BATADV_DAT_INCOMING_MSG_REPLY,
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4

