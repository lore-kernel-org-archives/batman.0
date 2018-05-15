Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Wed, 16 May 2018 01:48:59 +0200
Message-Id: <20180515234859.1167-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Increase DHCP snooped DAT
 entry purge timeout in DHT
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

This patch increases the DAT entry purge timeout in the DHT for DHT_PUT
messages which were triggered by DHCP snooping from 5 to 60 minutes.

DHCP snooping will ensure a timely update in case of a reassignment
of an IP address to a new host in the DHT. This allows us to
increase the DAT entry timeout for entries inserted via an incoming
DHT_PUT message triggered by DHCP snooping without risking
inconsistencies.

To signalize to a remote node that a DHT_PUT message was triggered
by DHCP snooping and that it is suitable for such an extended purge
timeout an according flag in the unicast 4addr header was introduced.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Unverified/untested so far! Expecting:

Reduction of (unanswered) ARP Requests from gateways:

60min: 98.95%

Other potential timeout periods for comparison:

45min: 97.95%
30min: 91.71%

https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping

This patch requires:

"batman-adv: DHCP snooping for DAT"
---
 include/uapi/linux/batadv_packet.h     | 13 ++++-
 net/batman-adv/distributed-arp-table.c | 86 +++++++++++++++++++++++++++-------
 net/batman-adv/main.h                  |  1 +
 net/batman-adv/send.c                  |  9 ++--
 net/batman-adv/send.h                  |  3 +-
 net/batman-adv/types.h                 |  6 +++
 6 files changed, 94 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 6a48f36c..0841ee0e 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -79,6 +79,15 @@ enum batadv_subtype {
 	BATADV_P_DAT_CACHE_REPLY	= 0x04,
 };
 
+/**
+ * enum batadv_dat_dht_put_flags - flags used in DHT_PUT messages
+ * @BATADV_DAT_EXTENDED_TIMEOUT: flag is set when the DHT_PUT receiver should
+ *  store an according DAT entry for an extended period
+ */
+enum batadv_dat_dht_put_flags {
+	BATADV_DAT_EXTENDED_TIMEOUT	= 1UL << 0,
+};
+
 /* this file is included by batctl which needs these defines */
 #define BATADV_COMPAT_VERSION 15
 
@@ -422,13 +431,13 @@ struct batadv_unicast_packet {
  * @u: common unicast packet header
  * @src: address of the source
  * @subtype: packet subtype
- * @reserved: reserved byte for alignment
+ * @flags: unicast 4addr flags
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
 	__u8 src[ETH_ALEN];
 	__u8 subtype;
-	__u8 reserved;
+	__u8 flags;
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 5fa06ef3..7185319a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -109,7 +109,9 @@ static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
 static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 {
 	return batadv_has_timed_out(dat_entry->last_update,
-				    BATADV_DAT_ENTRY_TIMEOUT);
+				    BATADV_DAT_ENTRY_TIMEOUT) &&
+	       batadv_has_timed_out(dat_entry->last_extended_update,
+				    BATADV_DAT_EXT_ENTRY_TIMEOUT);
 }
 
 /**
@@ -326,9 +328,11 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
  * @ip: ipv4 to add/edit
  * @mac_addr: mac address to assign to the given ipv4
  * @vid: VLAN identifier
+ * @extended_timeout: triggered by a DHT_PUT with an extended timeout flag
  */
-static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 u8 *mac_addr, unsigned short vid)
+static void
+batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
+		     u8 *mac_addr, unsigned short vid, bool extended_timeout)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
@@ -338,7 +342,12 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (dat_entry) {
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			ether_addr_copy(dat_entry->mac_addr, mac_addr);
+
 		dat_entry->last_update = jiffies;
+
+		if (extended_timeout)
+			dat_entry->last_extended_update = jiffies;
+
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
 			   &dat_entry->ip, dat_entry->mac_addr,
@@ -354,6 +363,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->vid = vid;
 	ether_addr_copy(dat_entry->mac_addr, mac_addr);
 	dat_entry->last_update = jiffies;
+	dat_entry->last_extended_update = extended_timeout ? jiffies : 0;
 	kref_init(&dat_entry->refcount);
 
 	kref_get(&dat_entry->refcount);
@@ -630,6 +640,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
  * @ip: the DHT key
  * @vid: VLAN identifier
  * @packet_subtype: unicast4addr packet subtype to use
+ * @flags: flags to set in the unicast4addr header
  *
  * This function copies the skb with pskb_copy() and is sent as unicast packet
  * to each of the selected candidates.
@@ -639,7 +650,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
  */
 static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 				 struct sk_buff *skb, __be32 ip,
-				 unsigned short vid, int packet_subtype)
+				 unsigned short vid, int packet_subtype,
+				 u8 flags)
 {
 	int i;
 	bool ret = false;
@@ -666,7 +678,8 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 		tmp_skb = pskb_copy_for_clone(skb, GFP_ATOMIC);
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, tmp_skb,
 							   cand[i].orig_node,
-							   packet_subtype)) {
+							   packet_subtype,
+							   flags)) {
 			kfree_skb(tmp_skb);
 			goto free_neigh;
 		}
@@ -1182,7 +1195,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, false);
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
@@ -1231,7 +1244,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	} else {
 		/* Send the request to the DHT */
 		ret = batadv_dat_send_data(bat_priv, skb, ip_dst, vid,
-					   BATADV_P_DAT_DHT_GET);
+					   BATADV_P_DAT_DHT_GET,
+					   BATADV_NO_FLAGS);
 	}
 out:
 	if (dat_entry)
@@ -1275,7 +1289,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 
 	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing incoming ARP REQUEST");
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, false);
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (!dat_entry)
@@ -1339,14 +1353,42 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, false);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid, false);
 
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT,
+			     BATADV_NO_FLAGS);
+	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT,
+			     BATADV_NO_FLAGS);
+}
+
+/**
+ * batadv_dat_get_dht_put_flags() - retrieves DHT_PUT flags from a 4addr packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: packet to check
+ * @hdr_size: size of the encapsulation header
+ *
+ * Return: The DHT_PUT flags if the provided packet contains a valid DHT_PUT
+ * message, BATADV_NO_FLAGS otherwise.
+ */
+static u8 batadv_dat_get_dht_put_flags(struct batadv_priv *bat_priv,
+				       struct sk_buff *skb, int hdr_size)
+{
+	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
+
+	if (hdr_size < sizeof(struct batadv_unicast_packet))
+		return BATADV_NO_FLAGS;
+
+	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
+
+	if (unicast_4addr_packet->u.packet_type != BATADV_UNICAST_4ADDR ||
+	    unicast_4addr_packet->subtype != BATADV_P_DAT_DHT_PUT)
+		return BATADV_NO_FLAGS;
+
+	return unicast_4addr_packet->flags;
 }
 
 /**
@@ -1363,11 +1405,13 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb, int hdr_size)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
+	bool extended_timeout = false;
 	u16 type;
 	__be32 ip_src, ip_dst;
 	u8 *hw_src, *hw_dst;
 	bool dropped = false;
 	unsigned short vid;
+	u8 dht_put_flags;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1400,11 +1444,15 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 		goto out;
 	}
 
+	dht_put_flags = batadv_dat_get_dht_put_flags(bat_priv, skb, hdr_size);
+	if (dht_put_flags & BATADV_DAT_EXTENDED_TIMEOUT)
+		extended_timeout = true;
+
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, extended_timeout);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid, extended_timeout);
 
 	/* If BLA is enabled, only forward ARP replies if we have claimed the
 	 * source of the ARP reply or if no one else of the same backbone has
@@ -1658,11 +1706,13 @@ static bool batadv_dat_put_pairs(struct batadv_priv *bat_priv, u8 *hw_src,
 	if (type != ARPOP_REPLY)
 		goto err_skip_commit;
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, false);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid, false);
 
-	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT,
+			     BATADV_DAT_EXTENDED_TIMEOUT);
+	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT,
+			     BATADV_DAT_EXTENDED_TIMEOUT);
 
 	ret = true;
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 8da3c933..0227aae0 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -51,6 +51,7 @@
 #define BATADV_ORIG_WORK_PERIOD 1000 /* 1 second */
 #define BATADV_MCAST_WORK_PERIOD 500 /* 0.5 seconds */
 #define BATADV_DAT_ENTRY_TIMEOUT (5 * 60000) /* 5 mins in milliseconds */
+#define BATADV_DAT_EXT_ENTRY_TIMEOUT (60 * 60000) /* 60 mins in milliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 4a35f5c2..edccfa0b 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -289,13 +289,15 @@ static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
  * @skb: the skb containing the payload to encapsulate
  * @orig: the destination node
  * @packet_subtype: the unicast 4addr packet subtype to use
+ * @flags: the unicast 4addr packet flags to set
  *
  * Return: false if the payload could not be encapsulated or true otherwise.
  */
 bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb,
 					   struct batadv_orig_node *orig,
-					   int packet_subtype)
+					   int packet_subtype,
+					   u8 flags)
 {
 	struct batadv_hard_iface *primary_if;
 	struct batadv_unicast_4addr_packet *uc_4addr_packet;
@@ -317,7 +319,7 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 	uc_4addr_packet->u.packet_type = BATADV_UNICAST_4ADDR;
 	ether_addr_copy(uc_4addr_packet->src, primary_if->net_dev->dev_addr);
 	uc_4addr_packet->subtype = packet_subtype;
-	uc_4addr_packet->reserved = 0;
+	uc_4addr_packet->flags = flags;
 
 	ret = true;
 out:
@@ -363,7 +365,8 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	case BATADV_UNICAST_4ADDR:
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, skb,
 							   orig_node,
-							   packet_subtype))
+							   packet_subtype,
+							   BATADV_NO_FLAGS))
 			goto out;
 		break;
 	default:
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 64cce07b..278994af 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -62,7 +62,8 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb,
 					   struct batadv_orig_node *orig_node,
-					   int packet_subtype);
+					   int packet_subtype,
+					   u8 flags);
 int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb, int packet_type,
 			    int packet_subtype,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7d5d9987..2eed2001 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2308,6 +2308,12 @@ struct batadv_dat_entry {
 	 */
 	unsigned long last_update;
 
+	/**
+	 * @last_extended_update: time in jiffies when a DHT_PUT with extended
+	 *  timeout flag was last received
+	 */
+	unsigned long last_extended_update;
+
 	/** @hash_entry: hlist node for &batadv_priv_dat.hash */
 	struct hlist_node hash_entry;
 
-- 
2.11.0

