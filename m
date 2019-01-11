Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 11 Jan 2019 22:02:08 +0100
Message-Id: <20190111210208.29139-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Increase purge timeout on DAT
 DHT candidates
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

Currently, the DHT_GET messages of the DAT will likely be left
unanswered due to the following issues:

When a node has a matching DAT Cache entry for a local ARP Request then
this node will answer it directly with the information provided by the
cache. This however, will likely lead to missing ARP Replies from the
original host. Which in turn leads to the DAT cache not being updated.

Then the local DAT cache entry will time out, triggering a unicasted
DHT_GET. However, as the 5min. timeout has passed, the DAT DHT
candidates will likely have purged their entry, too.

So basically this results in an ARP Request broadcast fallback every
five minutes.

A second issue is that it is quite common that a host which has long
gone offline will be tried to be contacted by another one at some remote
period larger than the current 5min. timeout. This too leads to flooded
ARP Requests.

With this patch the purge timeout for local DAT cache entries and
entries submitted via a DHT_PUT message is differentiated:

While the former stays at 5min. the latter is increased to 30min. Which
decreases the rate of broadcasted ARP Requests.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---

Some old investigations and analysis seemed to indicate a potential
reduction of 91.71% of unanswered ARP Requests (45min: 97.95%, 60min:
98.95%):

https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping

This patch is rebased on top of:

"batman-adv: DHCP snooping for DAT"

And it is a follow-up of:

"batman-adv: Increase DHCP snooped DAT entry purge timeout in DHT"
- https://patchwork.open-mesh.org/patch/17364/
---
 net/batman-adv/distributed-arp-table.c | 39 ++++++++++++++++++++++------------
 net/batman-adv/distributed-arp-table.h |  3 ++-
 net/batman-adv/main.h                  |  2 ++
 net/batman-adv/routing.c               |  8 ++++---
 net/batman-adv/types.h                 |  5 +++++
 5 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 899ab051..34898abf 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -152,7 +152,9 @@ static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
 static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 {
 	return batadv_has_timed_out(dat_entry->last_update,
-				    BATADV_DAT_ENTRY_TIMEOUT);
+				    BATADV_DAT_ENTRY_TIMEOUT) &&
+	       batadv_has_timed_out(dat_entry->last_dht_update,
+				    BATADV_DAT_DHT_TIMEOUT);
 }
 
 /**
@@ -369,9 +371,11 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
  * @ip: ipv4 to add/edit
  * @mac_addr: mac address to assign to the given ipv4
  * @vid: VLAN identifier
+ * @extended_timeout: whether this should be cached with an extended timeout
  */
-static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 u8 *mac_addr, unsigned short vid)
+static void
+batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip, u8 *mac_addr,
+		     unsigned short vid, bool extended_timeout)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
@@ -382,6 +386,10 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			ether_addr_copy(dat_entry->mac_addr, mac_addr);
 		dat_entry->last_update = jiffies;
+
+		if (extended_timeout)
+			dat_entry->last_dht_update = jiffies;
+
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
 			   &dat_entry->ip, dat_entry->mac_addr,
@@ -397,6 +405,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->vid = vid;
 	ether_addr_copy(dat_entry->mac_addr, mac_addr);
 	dat_entry->last_update = jiffies;
+	dat_entry->last_dht_update = extended_timeout ? jiffies : 0;
 	kref_init(&dat_entry->refcount);
 
 	kref_get(&dat_entry->refcount);
@@ -1229,7 +1238,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, false);
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
@@ -1322,7 +1331,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 
 	batadv_dbg_arp(bat_priv, skb, hdr_size, "Parsing incoming ARP REQUEST");
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, false);
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (!dat_entry)
@@ -1386,8 +1395,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, false);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid, false);
 
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
@@ -1402,12 +1411,14 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
+ * @is_dht_put: whether this is a BATADV_P_DAT_DHT_PUT message
  *
  * Return: true if the packet was snooped and consumed by DAT. False if the
  * packet has to be delivered to the interface
  */
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
-					 struct sk_buff *skb, int hdr_size)
+					 struct sk_buff *skb, int hdr_size,
+					 bool is_dht_put)
 {
 	struct batadv_dat_entry *dat_entry = NULL;
 	u16 type;
@@ -1450,8 +1461,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, is_dht_put);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid, is_dht_put);
 
 	/* If BLA is enabled, only forward ARP replies if we have claimed the
 	 * source of the ARP reply or if no one else of the same backbone has
@@ -1705,8 +1716,8 @@ static void batadv_dat_put_dhcp(struct batadv_priv *bat_priv, u8 *chaddr,
 
 	skb_set_network_header(skb, ETH_HLEN);
 
-	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid, false);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid, false);
 
 	batadv_dat_send_data(bat_priv, skb, yiaddr, vid, BATADV_P_DAT_DHT_PUT);
 	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
@@ -1827,8 +1838,8 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 	hw_src = ethhdr->h_source;
 	vid = batadv_dat_get_vid(skb, &hdr_size);
 
-	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid);
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, yiaddr, chaddr, vid, false);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid, false);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
 		   "Snooped from incoming DHCPACK (server address): %pI4, %pM (vid: %i)\n",
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 68c0ff32..21dbf285 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -45,7 +45,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb);
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
-					 struct sk_buff *skb, int hdr_size);
+					 struct sk_buff *skb, int hdr_size,
+					 bool is_dht_put);
 void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
 					struct sk_buff *skb,
 					__be16 proto,
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 05cb9080..6c1488f8 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -51,6 +51,8 @@
 #define BATADV_ORIG_WORK_PERIOD 1000 /* 1 second */
 #define BATADV_MCAST_WORK_PERIOD 500 /* 0.5 seconds */
 #define BATADV_DAT_ENTRY_TIMEOUT (5 * 60000) /* 5 mins in milliseconds */
+#define BATADV_DAT_DHT_TIMEOUT (30 * 60000) /* 30 mins in milliseconds */
+
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cae0e5dd..2b5d50ab 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -974,7 +974,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	int check, hdr_size = sizeof(*unicast_packet);
 	enum batadv_subtype subtype;
 	int ret = NET_RX_DROP;
-	bool is4addr, is_gw;
+	bool is4addr, is_gw, is_dht_put = false;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
@@ -1033,6 +1033,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 				orig_addr = unicast_4addr_packet->src;
 				orig_node = batadv_orig_hash_find(bat_priv,
 								  orig_addr);
+			} else if (subtype == BATADV_P_DAT_DHT_PUT) {
+				is_dht_put = true;
 			}
 		}
 
@@ -1040,7 +1042,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							  hdr_size))
 			goto rx_success;
 		if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
-							hdr_size))
+							hdr_size, is_dht_put))
 			goto rx_success;
 
 		batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
@@ -1277,7 +1279,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
 		goto rx_success;
-	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size, false))
 		goto rx_success;
 
 	batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a21b34ed..74801d79 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2280,6 +2280,11 @@ struct batadv_dat_entry {
 	 */
 	unsigned long last_update;
 
+	/**
+	 * @last_dht_update: time in jiffies when a DHT_PUT was last received
+	 */
+	unsigned long last_dht_update;
+
 	/** @hash_entry: hlist node for &batadv_priv_dat.hash */
 	struct hlist_node hash_entry;
 
-- 
2.11.0

