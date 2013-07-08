Return-Path: <mihail.costea2005@gmail.com>
From: mihail.costea2005@gmail.com
Date: Mon,  8 Jul 2013 03:12:44 +0300
Message-Id: <1373242365-763-5-git-send-email-mihail.costea2005@gmail.com>
In-Reply-To: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC 5/6] batman-adv: Generalize snooping mechanism
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

From: Mihail Costea <mihail.costea90@gmail.com>

Generalize snooping functions in order to support Neighbor Advertisement
and Neighbor Solicitation too. Adds snooping functions to generic
struct so there won't be a need for switch-cases.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 distributed-arp-table.c |  438 +++++++++++++++++++++++++++++++++++------------
 types.h                 |   69 ++++++++
 2 files changed, 401 insertions(+), 106 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index d0b9e95..1a5749b 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -33,21 +33,55 @@
 #include "types.h"
 #include "translation-table.h"
 
+static void batadv_dat_purge(struct work_struct *work);
+
+static bool batadv_dat_snoop_arp_pkt(struct batadv_priv *bat_priv,
+				     struct sk_buff *skb, int hdr_size,
+				     uint16_t pkt_type, uint8_t pkt_dir_type,
+				     uint8_t **hw_src, void **ip_src,
+				     uint8_t **hw_dst, void **ip_dst);
+
+static struct sk_buff *
+batadv_dat_create_arp_reply(struct batadv_priv *bat_priv,
+			    struct batadv_dat_entry *dat_entry,
+			    uint8_t *hw_src, void *ip_src, void *ip_dst)
+{
+	return arp_create(ARPOP_REPLY, ETH_P_ARP, *(__be32 *)ip_src,
+			  bat_priv->soft_iface, *(__be32 *)ip_dst,
+			  hw_src, dat_entry->mac_addr, hw_src);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static bool batadv_dat_snoop_ndisc_pkt(struct batadv_priv *bat_priv,
+				       struct sk_buff *skb, int hdr_size,
+				       uint16_t pkt_type, uint8_t pkt_dir_type,
+				       uint8_t **hw_src, void **ip_src,
+				       uint8_t **hw_dst, void **ip_dst);
+
+static struct sk_buff *
+batadv_dat_create_ndisc_na(struct batadv_priv *bat_priv,
+			   struct batadv_dat_entry *dat_entry,
+			   uint8_t *hw_src, void *ip_src, void *ip_dst);
+
+#endif
+
 static struct batadv_dat_type_info batadv_dat_types_info[] = {
 	{
 		.size = sizeof(__be32),
 		.str_fmt = "%pI4",
+		.snoop_pkt = batadv_dat_snoop_arp_pkt,
+		.create_skb = batadv_dat_create_arp_reply,
 	},
 #if IS_ENABLED(CONFIG_IPV6)
 	{
 		.size = sizeof(struct in6_addr),
 		.str_fmt = "%pI6c",
+		.snoop_pkt = batadv_dat_snoop_ndisc_pkt,
+		.create_skb = batadv_dat_create_ndisc_na,
 	},
 #endif
 };
 
-static void batadv_dat_purge(struct work_struct *work);
-
 /**
  * batadv_dat_data_to_str: transforms DAT data to string
  * @data: the DAT data
@@ -61,7 +95,7 @@ static char *batadv_dat_data_to_str(void *data, uint8_t type,
 				    char *buf, size_t buf_len)
 {
 	snprintf(buf, buf_len, batadv_dat_types_info[type].str_fmt, data);
-return buf;
+	return buf;
 }
 
 /**
@@ -221,9 +255,9 @@ static uint8_t *batadv_arp_hw_src(struct sk_buff *skb, int hdr_size)
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
@@ -245,9 +279,9 @@ static uint8_t *batadv_arp_hw_dst(struct sk_buff *skb, int hdr_size)
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
@@ -411,8 +445,8 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	if (msg)
 		batadv_dbg(BATADV_DBG_DAT, bat_priv, "%s\n", msg);
 
-	ip_src = batadv_arp_ip_src(skb, hdr_size);
-	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+	ip_src = *batadv_arp_ip_src(skb, hdr_size);
+	ip_dst = *batadv_arp_ip_dst(skb, hdr_size);
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
 		   "ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]\n",
 		   batadv_arp_hw_src(skb, hdr_size), &ip_src,
@@ -867,7 +901,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;
 
-			seq_printf(seq, " * %40s %15pM %6i:%02i\n",
+			seq_printf(seq, " * %-40s %15pM %6i:%02i\n",
 				   batadv_dat_data_to_str(dat_entry->data,
 							  dat_entry->type,
 							  dbg_data,
@@ -933,8 +967,8 @@ static uint16_t batadv_arp_get_type(struct batadv_priv *bat_priv,
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
@@ -958,6 +992,40 @@ out:
 	return type;
 }
 
+static bool batadv_dat_snoop_arp_pkt(struct batadv_priv *bat_priv,
+				     struct sk_buff *skb, int hdr_size,
+				     uint16_t pkt_type, uint8_t pkt_dir_type,
+				     uint8_t **hw_src, void **ip_src,
+				     uint8_t **hw_dst, void **ip_dst)
+{
+	if ((pkt_dir_type == BATADV_DAT_OUTGOING_PKT_REQUEST ||
+	     pkt_dir_type == BATADV_DAT_INCOMING_PKT_REQUEST ||
+	     pkt_dir_type == BATADV_DAT_BROADCAST_FALLBACK) &&
+	    pkt_type != ARPOP_REQUEST)
+		return false;
+	if ((pkt_dir_type == BATADV_DAT_OUTGOING_PKT_REPLY ||
+	     pkt_dir_type == BATADV_DAT_INCOMING_PKT_REPLY) &&
+	    pkt_type != ARPOP_REPLY)
+		return false;
+
+	if (hw_src)
+		*hw_src = batadv_arp_hw_src(skb, hdr_size);
+	if (ip_src)
+		*ip_src = batadv_arp_ip_src(skb, hdr_size);
+	if (hw_dst)
+		*hw_dst = batadv_arp_hw_dst(skb, hdr_size);
+	if (ip_dst)
+		*ip_dst = batadv_arp_ip_dst(skb, hdr_size);
+
+	if (pkt_type == ARPOP_REQUEST)
+		batadv_dbg_arp(bat_priv, skb, pkt_type, hdr_size,
+			       "Parsing ARP REQUEST");
+	else if (pkt_type == ARPOP_REPLY)
+		batadv_dbg_arp(bat_priv, skb, pkt_type, hdr_size,
+			       "Parsing ARP REPLY");
+
+	return true;
+}
 /**
  * batadv_dat_get_vid - extract the VLAN identifier from skb if any
  * @skb: the buffer containing the packet to extract the VID from
@@ -1135,7 +1203,7 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
- * @ndisc_type: type of ndisc packet to check
+ * @type: type of ndisc packet to check
  *
  * Check if all IPs are valid (source, destination, target) and if
  * options hw address is valid too.
@@ -1146,17 +1214,14 @@ out:
  */
 static bool batadv_ndisc_is_valid(struct batadv_priv *bat_priv,
 				  struct sk_buff *skb, int hdr_size,
-				  int ndisc_type)
+				  uint16_t type)
 {
 	uint8_t *hw_target = NULL;
 	struct in6_addr *ipv6_src, *ipv6_dst, *ipv6_target;
-	__u8 type = batadv_ndisc_get_type(bat_priv, skb, hdr_size);
 	int ndisc_hdr_len = hdr_size + ETH_HLEN + sizeof(struct ipv6hdr) +
 			    sizeof(struct icmp6hdr) + sizeof(struct in6_addr) +
 			    8; /* ndisc options length */
 
-	if (type != ndisc_type)
-		return false;
 	if (unlikely(!pskb_may_pull(skb, ndisc_hdr_len)))
 		return false;
 
@@ -1169,6 +1234,8 @@ static bool batadv_ndisc_is_valid(struct batadv_priv *bat_priv,
 	else if (type == NDISC_NEIGHBOUR_ADVERTISEMENT)
 		hw_target = batadv_ndisc_hw_opt(skb, hdr_size,
 						ND_OPT_TARGET_LL_ADDR);
+	else
+		return false;
 
 	if (!hw_target || is_zero_ether_addr(hw_target) ||
 	    is_multicast_ether_addr(hw_target))
@@ -1298,11 +1365,155 @@ sk_buff *batadv_ndisc_create_na(struct net_device *dev,
 
 	return skb;
 }
+
+struct sk_buff *
+batadv_dat_create_ndisc_na(struct batadv_priv *bat_priv,
+			   struct batadv_dat_entry *dat_entry,
+			   uint8_t *hw_src, void *ip_src, void *ip_dst)
+{
+	/* TODO calculate router and override parameters */
+	return batadv_ndisc_create_na(bat_priv->soft_iface,
+				      ip_src, ip_dst,
+				      hw_src, dat_entry->mac_addr,
+				      0, 1, 1);
+}
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
+
+static bool batadv_dat_snoop_ndisc_pkt(struct batadv_priv *bat_priv,
+				       struct sk_buff *skb, int hdr_size,
+				       uint16_t pkt_type, uint8_t pkt_dir_type,
+				       uint8_t **hw_src, void **ip_src,
+				       uint8_t **hw_dst, void **ip_dst)
+{
+	if (batadv_ndisc_is_valid(bat_priv, skb, hdr_size, pkt_type)) {
+		if ((pkt_dir_type == BATADV_DAT_OUTGOING_PKT_REQUEST ||
+		     pkt_dir_type == BATADV_DAT_INCOMING_PKT_REQUEST ||
+		     pkt_dir_type == BATADV_DAT_BROADCAST_FALLBACK) &&
+		    pkt_type == NDISC_NEIGHBOUR_SOLICITATION) {
+			if (!batadv_dat_snoop_ndisc_addr(skb, hdr_size,
+							 ND_OPT_SOURCE_LL_ADDR,
+							 NULL, ip_src,
+							 hw_dst, NULL,
+							 hw_src, ip_dst))
+				return false;
+
+			if (pkt_dir_type != BATADV_DAT_BROADCAST_FALLBACK)
+				batadv_dbg(BATADV_DBG_DAT, bat_priv,
+					   "Parsing NS = [src: %pM / %pI6c -> "
+						"target: %pM / %pI6c]\n",
+					   *hw_src, *ip_src, *hw_dst, *ip_dst);
+			return true;
+		}
+
+		if ((pkt_dir_type == BATADV_DAT_OUTGOING_PKT_REPLY ||
+		     pkt_dir_type == BATADV_DAT_INCOMING_PKT_REPLY) &&
+		    pkt_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
+			if (!batadv_dat_snoop_ndisc_addr(skb, hdr_size,
+							 ND_OPT_TARGET_LL_ADDR,
+							 NULL, NULL,
+							 hw_dst, ip_dst,
+							 hw_src, ip_src))
+				return false;
+
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Parsing NA = [src: %pM / %pI6c -> "
+					"target: %pM / %pI6c]\n",
+				   *hw_src, *ip_src, *hw_dst, *ip_dst);
+			return true;
+
+			/* ignore multicast address for unsolicited NA */
+			if (ipv6_addr_is_multicast(*ip_dst))
+				*ip_dst = NULL;
+		}
+	}
+
+	return false;
+}
+#endif
+
+/**
+ * batadv_dat_get_pair_type : gets packet and data types
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: packet to snoop
+ * @hdr_size: size of the encapsulation header
+ *
+ * Returns the packet and types, or -1 for data_type if invalid.
+ */
+static struct batadv_dat_pair_type
+batadv_dat_get_pair_type(struct batadv_priv *bat_priv,
+			 struct sk_buff *skb, int hdr_size)
+{
+	struct batadv_dat_pair_type pair_type = {
+		.data_type = -1,
+	};
+
+	uint16_t arp_type;
+	__u8 ndisc_type;
+
+	arp_type = batadv_arp_get_type(bat_priv, skb, hdr_size);
+	if (arp_type == ARPOP_REQUEST || arp_type == ARPOP_REPLY) {
+		pair_type.pkt_type = arp_type;
+		pair_type.data_type = BATADV_DAT_IPV4;
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	ndisc_type = batadv_ndisc_get_type(bat_priv, skb, hdr_size);
+	if (ndisc_type == NDISC_NEIGHBOUR_SOLICITATION ||
+	    ndisc_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
+		pair_type.pkt_type = ndisc_type;
+		pair_type.data_type = BATADV_DAT_IPV6;
+	}
 #endif
 
+	return pair_type;
+}
+
 /**
- * batadv_dat_snoop_outgoing_pkt_request - snoop the ARP request and try to
- * answer using DAT
+ * batadv_dat_snoop_outgoing_pkt_request - snoop the ARP request / NS
+ * and try to answer using DAT
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  *
@@ -1313,37 +1524,37 @@ sk_buff *batadv_ndisc_create_na(struct net_device *dev,
 bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
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
 	int hdr_size = 0;
 	unsigned short vid;
+	struct batadv_dat_pair_type dat_pair_type;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
-	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
-	/* If the node gets an ARP_REQUEST it has to send a DHT_GET unicast
+	/* If the node gets an ARP_REQUEST / NS it has to send a DHT_GET unicast
 	 * message to the selected DHT candidates
 	 */
-	if (type != ARPOP_REQUEST)
+	dat_pair_type = batadv_dat_get_pair_type(bat_priv, skb, hdr_size);
+	if (dat_pair_type.data_type < 0)
+		goto out;
+	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
+			bat_priv, skb, hdr_size, dat_pair_type.pkt_type,
+			BATADV_DAT_OUTGOING_PKT_REQUEST,
+			&hw_src, &ip_src, &hw_dst, &ip_dst))
 		goto out;
 
-	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REQUEST");
-
-	ip_src = batadv_arp_ip_src(skb, 0);
-	hw_src = batadv_arp_hw_src(skb, 0);
-	ip_dst = batadv_arp_ip_dst(skb, 0);
-
-	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, dat_pair_type.data_type,
+			     hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
-					       BATADV_DAT_IPV4, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst,
+					       dat_pair_type.data_type, vid);
 	if (dat_entry) {
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
@@ -1359,9 +1570,9 @@ bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
 			goto out;
 		}
 
-		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-				     bat_priv->soft_iface, ip_dst, hw_src,
-				     dat_entry->mac_addr, hw_src);
+		skb_new = batadv_dat_types_info[dat_pair_type.data_type].
+				create_skb(bat_priv, dat_entry,
+					   hw_src, ip_src, ip_dst);
 		if (!skb_new)
 			goto out;
 
@@ -1373,12 +1584,13 @@ bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
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
+		ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
+					   dat_pair_type.data_type,
 					   BATADV_P_DAT_DHT_GET);
 	}
 out:
@@ -1388,8 +1600,8 @@ out:
 }
 
 /**
- * batadv_dat_snoop_incoming_pkt_request - snoop the ARP request and try to
- * answer using the local DAT storage
+ * batadv_dat_snoop_incoming_pkt_request - snoop the ARP request / NS and try
+ * to answer using the local DAT storage
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
@@ -1399,42 +1611,39 @@ out:
 bool batadv_dat_snoop_incoming_pkt_request(struct batadv_priv *bat_priv,
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
 	unsigned short vid;
 	int err;
+	struct batadv_dat_pair_type dat_pair_type;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
-	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
-	if (type != ARPOP_REQUEST)
+	dat_pair_type = batadv_dat_get_pair_type(bat_priv, skb, hdr_size);
+	if (dat_pair_type.data_type < 0)
+		goto out;
+	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
+			bat_priv, skb, hdr_size, dat_pair_type.pkt_type,
+			BATADV_DAT_INCOMING_PKT_REQUEST,
+			&hw_src, &ip_src, &hw_dst, &ip_dst))
 		goto out;
 
-	hw_src = batadv_arp_hw_src(skb, hdr_size);
-	ip_src = batadv_arp_ip_src(skb, hdr_size);
-	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
-
-	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
-		       "Parsing incoming ARP REQUEST");
-
-	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, dat_pair_type.data_type,
+			     hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
-					       BATADV_DAT_IPV4, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst,
+					       dat_pair_type.data_type, vid);
 	if (!dat_entry)
 		goto out;
 
-	skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
-			     bat_priv->soft_iface, ip_dst, hw_src,
-			     dat_entry->mac_addr, hw_src);
-
+	skb_new = batadv_dat_types_info[dat_pair_type.data_type].create_skb(
+			bat_priv, dat_entry, hw_src, ip_src, ip_dst);
 	if (!skb_new)
 		goto out;
 
@@ -1462,49 +1671,55 @@ out:
 }
 
 /**
- * batadv_dat_snoop_outgoing_pkt_reply - snoop the ARP reply and fill the DHT
+ * batadv_dat_snoop_outgoing_pkt_reply - snoop the ARP reply / NA and fill
+ * the DHT
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  */
 void batadv_dat_snoop_outgoing_pkt_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
 {
-	uint16_t type;
-	__be32 ip_src, ip_dst;
+	void *ip_src, *ip_dst;
 	uint8_t *hw_src, *hw_dst;
 	int hdr_size = 0;
 	unsigned short vid;
+	struct batadv_dat_pair_type dat_pair_type;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		return;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
-	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
-	if (type != ARPOP_REPLY)
+	dat_pair_type = batadv_dat_get_pair_type(bat_priv, skb, hdr_size);
+	if (dat_pair_type.data_type < 0)
+		return;
+	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
+			bat_priv, skb, hdr_size, dat_pair_type.pkt_type,
+			BATADV_DAT_OUTGOING_PKT_REPLY,
+			&hw_src, &ip_src, &hw_dst, &ip_dst))
 		return;
-
-	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
-
-	hw_src = batadv_arp_hw_src(skb, hdr_size);
-	ip_src = batadv_arp_ip_src(skb, hdr_size);
-	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
-	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
-
-	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst, vid);
 
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, &ip_src, BATADV_DAT_IPV4,
-			     BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, &ip_dst, BATADV_DAT_IPV4,
+	batadv_dat_entry_add(bat_priv, ip_src, dat_pair_type.data_type,
+			     hw_src, vid);
+	batadv_dat_send_data(bat_priv, skb, ip_src, dat_pair_type.data_type,
 			     BATADV_P_DAT_DHT_PUT);
+
+	/* not a solicited advertisement (see snooping mechanism) */
+	if (ip_dst) {
+		batadv_dat_entry_add(bat_priv, ip_dst, dat_pair_type.data_type,
+				     hw_dst, vid);
+		batadv_dat_send_data(bat_priv, skb, ip_dst,
+				     dat_pair_type.data_type,
+				     BATADV_P_DAT_DHT_PUT);
+	}
 }
+
 /**
- * batadv_dat_snoop_incoming_pkt_reply - snoop the ARP reply and fill the local
- * DAT storage only
+ * batadv_dat_snoop_incoming_pkt_reply - snoop the ARP reply / NA and fill
+ * the local DAT storage only
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
@@ -1512,34 +1727,35 @@ void batadv_dat_snoop_outgoing_pkt_reply(struct batadv_priv *bat_priv,
 bool batadv_dat_snoop_incoming_pkt_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
 {
-	uint16_t type;
-	__be32 ip_src, ip_dst;
+	void *ip_src, *ip_dst;
 	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
 	unsigned short vid;
+	struct batadv_dat_pair_type dat_pair_type;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
-	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
-	if (type != ARPOP_REPLY)
+	dat_pair_type = batadv_dat_get_pair_type(bat_priv, skb, hdr_size);
+	if (dat_pair_type.data_type < 0)
+		goto out;
+	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
+			bat_priv, skb, hdr_size, dat_pair_type.pkt_type,
+			BATADV_DAT_INCOMING_PKT_REPLY,
+			&hw_src, &ip_src, &hw_dst, &ip_dst))
 		goto out;
-
-	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
-		       "Parsing incoming ARP REPLY");
-
-	hw_src = batadv_arp_hw_src(skb, hdr_size);
-	ip_src = batadv_arp_ip_src(skb, hdr_size);
-	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
-	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, dat_pair_type.data_type,
+			     hw_src, vid);
+	/* not a solicited advertisement (see snooping mechanism) */
+	if (ip_dst)
+		batadv_dat_entry_add(bat_priv, ip_dst,
+				     dat_pair_type.data_type, hw_dst, vid);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
@@ -1553,8 +1769,8 @@ out:
 }
 
 /**
- * batadv_dat_drop_broadcast_packet - check if an ARP request has to be dropped
- * (because the node has already obtained the reply via DAT) or not
+ * batadv_dat_drop_broadcast_packet - check if an ARP request / NA has to be
+ * dropped (because the node has already obtained the reply via DAT) or not
  * @bat_priv: the bat priv with all the soft interface information
  * @forw_packet: the broadcast packet
  *
@@ -1563,12 +1779,13 @@ out:
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 				      struct batadv_forw_packet *forw_packet)
 {
-	uint16_t type;
-	__be32 ip_dst;
+	void *ip_dst;
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
 	int hdr_size = sizeof(struct batadv_bcast_packet);
 	unsigned short vid;
+	struct batadv_dat_pair_type dat_pair_type;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1581,22 +1798,31 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 
 	vid = batadv_dat_get_vid(forw_packet->skb, &hdr_size);
 
-	type = batadv_arp_get_type(bat_priv, forw_packet->skb, hdr_size);
-	if (type != ARPOP_REQUEST)
+	dat_pair_type = batadv_dat_get_pair_type(bat_priv, forw_packet->skb,
+						 hdr_size);
+	if (dat_pair_type.data_type < 0)
 		goto out;
+	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
+			bat_priv, forw_packet->skb, hdr_size,
+			dat_pair_type.pkt_type,
+			BATADV_DAT_BROADCAST_FALLBACK,
+			NULL, NULL, NULL, &ip_dst))
+		goto out;
+
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst,
+					       dat_pair_type.data_type, vid);
 
-	ip_dst = batadv_arp_ip_dst(forw_packet->skb, hdr_size);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
-					       BATADV_DAT_IPV4, vid);
 	/* check if the node already got this entry */
+	batadv_dat_data_to_str(ip_dst, dat_pair_type.data_type,
+			       dbg_data, sizeof(dbg_data));
 	if (!dat_entry) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "ARP Request for %pI4: fallback\n", &ip_dst);
+			   "ARP Request for %s: fallback\n", dbg_data);
 		goto out;
 	}
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "ARP Request for %pI4: fallback prevented\n", &ip_dst);
+		   "ARP Request for %s fallback prevented\n", dbg_data);
 	ret = true;
 
 out:
diff --git a/types.h b/types.h
index 60d2d64..6ad4500 100644
--- a/types.h
+++ b/types.h
@@ -964,13 +964,82 @@ enum batadv_dat_types {
 };
 
 /**
+ * batadv_dat_pkt_types - describe generic packet types
+ * @BATADV_DAT_OUTGOING_PKT_REQUEST: an outgoing packet request
+ * @BATADV_DAT_INCOMING_PKT_REQUEST: an incoming packet request
+ * @BATADV_DAT_OUTGOING_PKT_REPLY: an outgoing packet reply
+ * @BATADV_DAT_INCOMING_PKT_REPLY: an incoming packet reply
+ * @BATADV_DAT_BROADCAST_FALLBACK: used for broadcasts fallback;
+ * can any type of request packets
+ *
+ * The packets can be ARP Request / Reply, NS / NA or other packets.
+ */
+enum batadv_dat_pkt_types {
+	BATADV_DAT_OUTGOING_PKT_REQUEST,
+	BATADV_DAT_INCOMING_PKT_REQUEST,
+	BATADV_DAT_OUTGOING_PKT_REPLY,
+	BATADV_DAT_INCOMING_PKT_REPLY,
+	BATADV_DAT_BROADCAST_FALLBACK,
+};
+
+/**
+ * batadv_dat_pair_type - types needed for a dat packet
+ * @data_type the data type (negative values represents invalid values)
+ * @pkt_type: the packet type
+ */
+struct batadv_dat_pair_type {
+	int data_type;
+	uint16_t pkt_type;
+};
+
+/**
  * batadv_dat_type_info - info needed for a DAT type data
  * @size: the size of the type data
  * @str_fmt: string format used by the data
+ * @snoop_pkt: function used to snoop addresses from a packet
  */
 struct batadv_dat_type_info {
 	size_t size;
 	char *str_fmt;
+	/**
+	 * snoop_pkt - snooping mechanism for all packets that participate
+	 * in DAT
+	 * @bat_priv: the bat priv with all the soft interface information
+	 * @skb: packet to snoop
+	 * @hdr_size: size of the encapsulation header
+	 * @pkt_type: the packet type
+	 * @pkt_dir_type: outgoing / incoming message request / reply
+	 * @hw_src: source HW Address
+	 * @ip_src: source IP
+	 * @hw_dst: destination HW Address
+	 * @ip_dst: destination IP
+	 *
+	 * Any address pointer can be null if there is no need to memorize
+	 * calculate that address.
+	 *
+	 * Returns true if snooping was successful.
+	 */
+	bool (*snoop_pkt)(struct batadv_priv *bat_priv,
+			  struct sk_buff *skb, int hdr_size,
+			  uint16_t pkt_type, uint8_t pkt_dir_type,
+			  uint8_t **hw_src, void **ip_src,
+			  uint8_t **hw_dst, void **ip_dst);
+
+	/**
+	 * batadv_dat_create_skb - creates a skb as a reply to a message request
+	 * @bat_priv: the bat priv with all the soft interface information
+	 * @dat_entry: the DAT entry used for destination HW Address
+	 * @hw_src: source HW Address
+	 * @ip_src: source IP
+	 * @ip_dst: destination IP
+	 *
+	 * Returns the newly created skb, or NULL if any error.
+	 */
+	struct sk_buff *(*create_skb)(struct batadv_priv *bat_priv,
+				      struct batadv_dat_entry *dat_entry,
+				      uint8_t *hw_src, void *ip_src,
+				      void *ip_dst);
+
 };
 
 /**
-- 
1.7.10.4

