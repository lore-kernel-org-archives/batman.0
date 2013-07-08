Return-Path: <mihail.costea2005@gmail.com>
From: mihail.costea2005@gmail.com
Date: Mon,  8 Jul 2013 03:12:45 +0300
Message-Id: <1373242365-763-6-git-send-email-mihail.costea2005@gmail.com>
In-Reply-To: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC 6/6] batman-adv: Adds snooping of router and
	override flags for NA creation
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

Snoops router and override flags for Neighbor Advertisement in order to
use it in NA creation. This information is stored in a extra member
in the dat entry. This is done separately from normal data,
because data is used for DHT comparison, while this flags can change
their value over time.

Comments:
For now router and override are initialized to the values used in most
case scenarios. This can be changed easily if we want to avoid the
NA creation until we get the flags.
Also, the router flag can be calculated easily using the Router Advertisement.
Any node that sends that package is a router, so there isn't a lot of snooping
in that case. This feature can be added easily.
The problem is that I have no other idea how to get the override flag,
with the exception of the current implemented mechanism.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 distributed-arp-table.c |  139 +++++++++++++++++++++++++++++++++++------------
 types.h                 |   21 ++++++-
 2 files changed, 124 insertions(+), 36 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 1a5749b..ce5c13d 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -39,7 +39,8 @@ static bool batadv_dat_snoop_arp_pkt(struct batadv_priv *bat_priv,
 				     struct sk_buff *skb, int hdr_size,
 				     uint16_t pkt_type, uint8_t pkt_dir_type,
 				     uint8_t **hw_src, void **ip_src,
-				     uint8_t **hw_dst, void **ip_dst);
+				     uint8_t **hw_dst, void **ip_dst,
+				     void **extra_data);
 
 static struct sk_buff *
 batadv_dat_create_arp_reply(struct batadv_priv *bat_priv,
@@ -56,7 +57,8 @@ static bool batadv_dat_snoop_ndisc_pkt(struct batadv_priv *bat_priv,
 				       struct sk_buff *skb, int hdr_size,
 				       uint16_t pkt_type, uint8_t pkt_dir_type,
 				       uint8_t **hw_src, void **ip_src,
-				       uint8_t **hw_dst, void **ip_dst);
+				       uint8_t **hw_dst, void **ip_dst,
+				       void **extra_data);
 
 static struct sk_buff *
 batadv_dat_create_ndisc_na(struct batadv_priv *bat_priv,
@@ -68,6 +70,7 @@ batadv_dat_create_ndisc_na(struct batadv_priv *bat_priv,
 static struct batadv_dat_type_info batadv_dat_types_info[] = {
 	{
 		.size = sizeof(__be32),
+		.extra_size = 0,
 		.str_fmt = "%pI4",
 		.snoop_pkt = batadv_dat_snoop_arp_pkt,
 		.create_skb = batadv_dat_create_arp_reply,
@@ -75,6 +78,7 @@ static struct batadv_dat_type_info batadv_dat_types_info[] = {
 #if IS_ENABLED(CONFIG_IPV6)
 	{
 		.size = sizeof(struct in6_addr),
+		.extra_size = sizeof(struct batadv_dat_ipv6_extra_data),
 		.str_fmt = "%pI6c",
 		.snoop_pkt = batadv_dat_snoop_ndisc_pkt,
 		.create_skb = batadv_dat_create_ndisc_na,
@@ -119,6 +123,7 @@ static void batadv_dat_entry_free_ref_rcu(struct rcu_head *rcu)
 
 	dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
 	kfree(dat_entry->data);
+	kfree(dat_entry->extra_data);
 	kfree(dat_entry);
 }
 
@@ -363,18 +368,20 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *data,
  * batadv_dat_entry_add - add a new dat entry or update it if already exists
  * @bat_priv: the bat priv with all the soft interface information
  * @data: the data to add/edit
+ * @extra_data: the extra data for data param (can be NULL if none)
  * @data_type: type of the data added to DAT
  * @mac_addr: mac address to assign to the given data
  * @vid: VLAN identifier
  */
 static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *data,
-				 uint8_t data_type, uint8_t *mac_addr,
-				 unsigned short vid)
+				 void *extra_data, uint8_t data_type,
+				 uint8_t *mac_addr, unsigned short vid)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
 	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
 	size_t data_size = batadv_dat_types_info[data_type].size;
+	size_t extra_data_size = batadv_dat_types_info[data_type].extra_size;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, data, data_type, vid);
 	/* if this entry is already known, just update it */
@@ -382,22 +389,40 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *data,
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
-		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Entry updated: %s %pM (vid: %u)\n",
+		if (extra_data)
+			memcpy(dat_entry->extra_data, extra_data,
+			       extra_data_size);
+
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+			   "Entry updated: %s %pM (vid: %u)\n",
 			   batadv_dat_data_to_str(dat_entry->data, data_type,
 						  dbg_data, sizeof(dbg_data)),
 			   dat_entry->mac_addr, vid);
 		goto out;
 	}
 
+	/* alloc entry */
 	dat_entry = kmalloc(sizeof(*dat_entry), GFP_ATOMIC);
 	if (!dat_entry)
 		goto out;
+	/* some entries don't have an extra data and useful if allocation for
+	 * data fails */
+	dat_entry->extra_data = NULL;
 
+	/* alloc data */
 	dat_entry->data = kmalloc(data_size, GFP_ATOMIC);
 	if (!dat_entry->data)
 		goto out;
 	memcpy(dat_entry->data, data, data_size);
 
+	/* alloc extra data */
+	if (extra_data) {
+		dat_entry->extra_data = kmalloc(extra_data_size, GFP_ATOMIC);
+		if (!dat_entry->extra_data)
+			goto out;
+		memcpy(dat_entry->extra_data, extra_data, extra_data_size);
+	}
+
 	dat_entry->type = data_type;
 	dat_entry->vid = vid;
 	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
@@ -996,7 +1021,8 @@ static bool batadv_dat_snoop_arp_pkt(struct batadv_priv *bat_priv,
 				     struct sk_buff *skb, int hdr_size,
 				     uint16_t pkt_type, uint8_t pkt_dir_type,
 				     uint8_t **hw_src, void **ip_src,
-				     uint8_t **hw_dst, void **ip_dst)
+				     uint8_t **hw_dst, void **ip_dst,
+				     void **extra_data)
 {
 	if ((pkt_dir_type == BATADV_DAT_OUTGOING_PKT_REQUEST ||
 	     pkt_dir_type == BATADV_DAT_INCOMING_PKT_REQUEST ||
@@ -1371,11 +1397,13 @@ batadv_dat_create_ndisc_na(struct batadv_priv *bat_priv,
 			   struct batadv_dat_entry *dat_entry,
 			   uint8_t *hw_src, void *ip_src, void *ip_dst)
 {
-	/* TODO calculate router and override parameters */
+	struct batadv_dat_ipv6_extra_data *ipv6_extra_data =
+		(struct batadv_dat_ipv6_extra_data *)dat_entry->extra_data;
 	return batadv_ndisc_create_na(bat_priv->soft_iface,
 				      ip_src, ip_dst,
 				      hw_src, dat_entry->mac_addr,
-				      0, 1, 1);
+				      ipv6_extra_data->router, 1,
+				      ipv6_extra_data->override);
 }
 
 /**
@@ -1426,8 +1454,13 @@ static bool batadv_dat_snoop_ndisc_pkt(struct batadv_priv *bat_priv,
 				       struct sk_buff *skb, int hdr_size,
 				       uint16_t pkt_type, uint8_t pkt_dir_type,
 				       uint8_t **hw_src, void **ip_src,
-				       uint8_t **hw_dst, void **ip_dst)
+				       uint8_t **hw_dst, void **ip_dst,
+				       void **extra_data)
 {
+	struct icmp6hdr *icmp6hdr;
+	struct batadv_dat_ipv6_extra_data *ipv6_extra_data;
+	size_t extra_data_size = sizeof(struct batadv_dat_ipv6_extra_data);
+
 	if (batadv_ndisc_is_valid(bat_priv, skb, hdr_size, pkt_type)) {
 		if ((pkt_dir_type == BATADV_DAT_OUTGOING_PKT_REQUEST ||
 		     pkt_dir_type == BATADV_DAT_INCOMING_PKT_REQUEST ||
@@ -1440,11 +1473,27 @@ static bool batadv_dat_snoop_ndisc_pkt(struct batadv_priv *bat_priv,
 							 hw_src, ip_dst))
 				return false;
 
-			if (pkt_dir_type != BATADV_DAT_BROADCAST_FALLBACK)
+			if (pkt_dir_type != BATADV_DAT_BROADCAST_FALLBACK) {
+				/* init extra data
+				 * TODO: this can be NULL if entry should
+				 * be ignored until extra data is updated */
+				*extra_data = kmalloc(extra_data_size,
+						      GFP_ATOMIC);
+				ipv6_extra_data =
+					(struct batadv_dat_ipv6_extra_data *)
+						*extra_data;
+				ipv6_extra_data->router = 0;
+				ipv6_extra_data->override = 1;
+
 				batadv_dbg(BATADV_DBG_DAT, bat_priv,
 					   "Parsing NS = [src: %pM / %pI6c -> "
-						"target: %pM / %pI6c]\n",
-					   *hw_src, *ip_src, *hw_dst, *ip_dst);
+						"target: %pM / %pI6c "
+						"(router: %i, override %i)]\n",
+					   *hw_src, *ip_src, *hw_dst, *ip_dst,
+					   ipv6_extra_data->router,
+					   ipv6_extra_data->override);
+			}
+
 			return true;
 		}
 
@@ -1458,15 +1507,27 @@ static bool batadv_dat_snoop_ndisc_pkt(struct batadv_priv *bat_priv,
 							 hw_src, ip_src))
 				return false;
 
-			batadv_dbg(BATADV_DBG_DAT, bat_priv,
-				   "Parsing NA = [src: %pM / %pI6c -> "
-					"target: %pM / %pI6c]\n",
-				   *hw_src, *ip_src, *hw_dst, *ip_dst);
-			return true;
-
 			/* ignore multicast address for unsolicited NA */
 			if (ipv6_addr_is_multicast(*ip_dst))
 				*ip_dst = NULL;
+
+			/* get extra data */
+			*extra_data = kmalloc(extra_data_size, GFP_ATOMIC);
+			ipv6_extra_data = (struct batadv_dat_ipv6_extra_data *)
+							*extra_data;
+			icmp6hdr = (struct icmp6hdr *)(skb->data + hdr_size +
+					ETH_HLEN + sizeof(struct ipv6hdr));
+			ipv6_extra_data->router = icmp6hdr->icmp6_router;
+			ipv6_extra_data->override = icmp6hdr->icmp6_override;
+
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Parsing NA = [src: %pM / %pI6c -> "
+					"target: %pM / %pI6c "
+					"(router: %i, override %i)]\n",
+				   *hw_src, *ip_src, *hw_dst, *ip_dst,
+				   ipv6_extra_data->router,
+				   ipv6_extra_data->override);
+			return true;
 		}
 	}
 
@@ -1532,6 +1593,7 @@ bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
 	int hdr_size = 0;
 	unsigned short vid;
 	struct batadv_dat_pair_type dat_pair_type;
+	void *extra_data = NULL;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1547,11 +1609,11 @@ bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
 	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
 			bat_priv, skb, hdr_size, dat_pair_type.pkt_type,
 			BATADV_DAT_OUTGOING_PKT_REQUEST,
-			&hw_src, &ip_src, &hw_dst, &ip_dst))
+			&hw_src, &ip_src, &hw_dst, &ip_dst, &extra_data))
 		goto out;
 
-	batadv_dat_entry_add(bat_priv, ip_src, dat_pair_type.data_type,
-			     hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, extra_data,
+			     dat_pair_type.data_type, hw_src, vid);
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst,
 					       dat_pair_type.data_type, vid);
@@ -1596,6 +1658,7 @@ bool batadv_dat_snoop_outgoing_pkt_request(struct batadv_priv *bat_priv,
 out:
 	if (dat_entry)
 		batadv_dat_entry_free_ref(dat_entry);
+	kfree(extra_data);
 	return ret;
 }
 
@@ -1619,6 +1682,7 @@ bool batadv_dat_snoop_incoming_pkt_request(struct batadv_priv *bat_priv,
 	unsigned short vid;
 	int err;
 	struct batadv_dat_pair_type dat_pair_type;
+	void *extra_data = NULL;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1631,11 +1695,11 @@ bool batadv_dat_snoop_incoming_pkt_request(struct batadv_priv *bat_priv,
 	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
 			bat_priv, skb, hdr_size, dat_pair_type.pkt_type,
 			BATADV_DAT_INCOMING_PKT_REQUEST,
-			&hw_src, &ip_src, &hw_dst, &ip_dst))
+			&hw_src, &ip_src, &hw_dst, &ip_dst, &extra_data))
 		goto out;
 
-	batadv_dat_entry_add(bat_priv, ip_src, dat_pair_type.data_type,
-			     hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, extra_data,
+			     dat_pair_type.data_type, hw_src, vid);
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst,
 					       dat_pair_type.data_type, vid);
@@ -1667,6 +1731,7 @@ out:
 		batadv_dat_entry_free_ref(dat_entry);
 	if (ret)
 		kfree_skb(skb);
+	kfree(extra_data);
 	return ret;
 }
 
@@ -1684,6 +1749,7 @@ void batadv_dat_snoop_outgoing_pkt_reply(struct batadv_priv *bat_priv,
 	int hdr_size = 0;
 	unsigned short vid;
 	struct batadv_dat_pair_type dat_pair_type;
+	void *extra_data = NULL;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		return;
@@ -1696,25 +1762,26 @@ void batadv_dat_snoop_outgoing_pkt_reply(struct batadv_priv *bat_priv,
 	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
 			bat_priv, skb, hdr_size, dat_pair_type.pkt_type,
 			BATADV_DAT_OUTGOING_PKT_REPLY,
-			&hw_src, &ip_src, &hw_dst, &ip_dst))
+			&hw_src, &ip_src, &hw_dst, &ip_dst, &extra_data))
 		return;
 
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, dat_pair_type.data_type,
-			     hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, extra_data,
+			     dat_pair_type.data_type, hw_src, vid);
 	batadv_dat_send_data(bat_priv, skb, ip_src, dat_pair_type.data_type,
 			     BATADV_P_DAT_DHT_PUT);
 
 	/* not a solicited advertisement (see snooping mechanism) */
 	if (ip_dst) {
-		batadv_dat_entry_add(bat_priv, ip_dst, dat_pair_type.data_type,
-				     hw_dst, vid);
+		batadv_dat_entry_add(bat_priv, ip_dst, extra_data,
+				     dat_pair_type.data_type, hw_dst, vid);
 		batadv_dat_send_data(bat_priv, skb, ip_dst,
 				     dat_pair_type.data_type,
 				     BATADV_P_DAT_DHT_PUT);
 	}
+	kfree(extra_data);
 }
 
 /**
@@ -1732,6 +1799,7 @@ bool batadv_dat_snoop_incoming_pkt_reply(struct batadv_priv *bat_priv,
 	bool ret = false;
 	unsigned short vid;
 	struct batadv_dat_pair_type dat_pair_type;
+	void *extra_data = NULL;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1744,17 +1812,17 @@ bool batadv_dat_snoop_incoming_pkt_reply(struct batadv_priv *bat_priv,
 	if (!batadv_dat_types_info[dat_pair_type.data_type].snoop_pkt(
 			bat_priv, skb, hdr_size, dat_pair_type.pkt_type,
 			BATADV_DAT_INCOMING_PKT_REPLY,
-			&hw_src, &ip_src, &hw_dst, &ip_dst))
+			&hw_src, &ip_src, &hw_dst, &ip_dst, &extra_data))
 		goto out;
 
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, dat_pair_type.data_type,
-			     hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, extra_data,
+			     dat_pair_type.data_type, hw_src, vid);
 	/* not a solicited advertisement (see snooping mechanism) */
 	if (ip_dst)
-		batadv_dat_entry_add(bat_priv, ip_dst,
+		batadv_dat_entry_add(bat_priv, ip_dst, extra_data,
 				     dat_pair_type.data_type, hw_dst, vid);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
@@ -1764,6 +1832,7 @@ bool batadv_dat_snoop_incoming_pkt_reply(struct batadv_priv *bat_priv,
 out:
 	if (ret)
 		kfree_skb(skb);
+	kfree(extra_data);
 	/* if ret == false -> packet has to be delivered to the interface */
 	return ret;
 }
@@ -1786,6 +1855,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 	unsigned short vid;
 	struct batadv_dat_pair_type dat_pair_type;
 	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
+	void *extra_data = NULL;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1806,7 +1876,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 			bat_priv, forw_packet->skb, hdr_size,
 			dat_pair_type.pkt_type,
 			BATADV_DAT_BROADCAST_FALLBACK,
-			NULL, NULL, NULL, &ip_dst))
+			NULL, NULL, NULL, &ip_dst, &extra_data))
 		goto out;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst,
@@ -1828,5 +1898,6 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 out:
 	if (dat_entry)
 		batadv_dat_entry_free_ref(dat_entry);
+	kfree(extra_data);
 	return ret;
 }
diff --git a/types.h b/types.h
index 6ad4500..5301af1 100644
--- a/types.h
+++ b/types.h
@@ -931,7 +931,9 @@ struct batadv_algo_ops {
 /**
  * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
  * is used to stored ARP entries needed for the global DAT cache
- * @data: the data corresponding to this DAT entry
+ * @data: the data corresponding to this DAT entry; this is used for comparison
+ * between DAT entries
+ * @extra_data: extra data for this DAT entry (NULL if none)
  * @type: the type corresponding to this DAT entry
  * @mac_addr: the MAC address associated to the stored IPv4
  * @vid: the vlan ID associated to this entry
@@ -942,6 +944,7 @@ struct batadv_algo_ops {
  */
 struct batadv_dat_entry {
 	void *data;
+	void *extra_data;
 	uint8_t type;
 	uint8_t mac_addr[ETH_ALEN];
 	unsigned short vid;
@@ -983,6 +986,16 @@ enum batadv_dat_pkt_types {
 };
 
 /**
+ * batadv_dat_ipv6_extra_data - defines extra data for IPv6
+ * @router: entry is router
+ * @override: override flag (see RFC2461)
+ */
+struct batadv_dat_ipv6_extra_data {
+	__u8 router:1,
+	     override:1;
+};
+
+/**
  * batadv_dat_pair_type - types needed for a dat packet
  * @data_type the data type (negative values represents invalid values)
  * @pkt_type: the packet type
@@ -995,11 +1008,13 @@ struct batadv_dat_pair_type {
 /**
  * batadv_dat_type_info - info needed for a DAT type data
  * @size: the size of the type data
+ * @extra_size: the size of the extra data (can be 0 if no extra data)
  * @str_fmt: string format used by the data
  * @snoop_pkt: function used to snoop addresses from a packet
  */
 struct batadv_dat_type_info {
 	size_t size;
+	size_t extra_size;
 	char *str_fmt;
 	/**
 	 * snoop_pkt - snooping mechanism for all packets that participate
@@ -1013,6 +1028,8 @@ struct batadv_dat_type_info {
 	 * @ip_src: source IP
 	 * @hw_dst: destination HW Address
 	 * @ip_dst: destination IP
+	 * @extra_data: extra data that must be snooped; it is either allocated
+	 * dynamically or NULL inside the function; must be freed outside
 	 *
 	 * Any address pointer can be null if there is no need to memorize
 	 * calculate that address.
@@ -1023,7 +1040,7 @@ struct batadv_dat_type_info {
 			  struct sk_buff *skb, int hdr_size,
 			  uint16_t pkt_type, uint8_t pkt_dir_type,
 			  uint8_t **hw_src, void **ip_src,
-			  uint8_t **hw_dst, void **ip_dst);
+			  uint8_t **hw_dst, void **ip_dst, void **extra_data);
 
 	/**
 	 * batadv_dat_create_skb - creates a skb as a reply to a message request
-- 
1.7.10.4

