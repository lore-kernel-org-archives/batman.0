Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 May 2013 21:43:07 +0200
Message-Id: <1369683792-531-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1369683792-531-1-git-send-email-ordex@autistici.org>
References: <1369683792-531-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 07/12] batman-adv: make the Distributed ARP
	Table vlan aware
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

The same IP subnet can be used on different VLANs, therefore
DAT has to differentiate whether the IP to resolve belongs
to one or the other virtual LAN.
To accomplish this task DAT has to deal with the VLAN tag
and store it together with each ARP entry.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 distributed-arp-table.c | 122 ++++++++++++++++++++++++++++++++----------------
 types.h                 |   2 +
 2 files changed, 85 insertions(+), 39 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 1b590f0..a365e14 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -19,6 +19,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
+#include <linux/if_vlan.h>
 #include <net/arp.h>
 
 #include "main.h"
@@ -205,15 +206,11 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
  */
 static uint32_t batadv_hash_dat(const void *data, uint32_t size)
 {
-	const unsigned char *key = data;
 	uint32_t hash = 0;
-	size_t i;
+	const struct batadv_dat_entry *dat = data;
 
-	for (i = 0; i < 4; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
+	hash = batadv_hash_bytes(hash, &dat->ip, sizeof(dat->ip));
+	hash = batadv_hash_bytes(hash, &dat->vid, sizeof(dat->vid));
 
 	hash += (hash << 3);
 	hash ^= (hash >> 11);
@@ -227,21 +224,26 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
  * table
  * @bat_priv: the bat priv with all the soft interface information
  * @ip: search key
+ * @vid: VLAN identifier
  *
  * Returns the dat_entry if found, NULL otherwise.
  */
 static struct batadv_dat_entry *
-batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
+batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
+			   unsigned short vid)
 {
 	struct hlist_head *head;
-	struct batadv_dat_entry *dat_entry, *dat_entry_tmp = NULL;
+	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp = NULL;
 	struct batadv_hashtable *hash = bat_priv->dat.hash;
 	uint32_t index;
 
 	if (!hash)
 		return NULL;
 
-	index = batadv_hash_dat(&ip, hash->size);
+	to_find.ip = ip;
+	to_find.vid = vid;
+
+	index = batadv_hash_dat(&to_find, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -267,20 +269,20 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
  * @mac_addr: mac address to assign to the given ipv4
  */
 static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 uint8_t *mac_addr)
+				 uint8_t *mac_addr, unsigned short vid)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM\n", &dat_entry->ip,
-			   dat_entry->mac_addr);
+			   "Entry updated: %pI4 %pM (vid: %u)\n",
+			   &dat_entry->ip, dat_entry->mac_addr, vid);
 		goto out;
 	}
 
@@ -289,12 +291,13 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 
 	dat_entry->ip = ip;
+	dat_entry->vid = vid;
 	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);
 
 	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
-				     batadv_hash_dat, &dat_entry->ip,
+				     batadv_hash_dat, dat_entry,
 				     &dat_entry->hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -303,8 +306,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
-		   &dat_entry->ip, dat_entry->mac_addr);
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %u)\n",
+		   &dat_entry->ip, dat_entry->mac_addr, vid);
 
 out:
 	if (dat_entry)
@@ -858,6 +861,31 @@ out:
 }
 
 /**
+ * batadv_dat_get_vid - extract the VLAN identifier from skb if any
+ * @skb: the buffer containing the packet to extract the VID from
+ * @hdr_size: the size of the batman-adv header encapsulating the packet
+ *
+ * If the packet contained in skb is vlan tagged then this function returns the
+ * VID with the BATADV_VLAN_HAS_TAG flag. Otherwise returns BATADV_NO_FLAGS
+ */
+static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
+{
+	unsigned short vid;
+
+	vid = batadv_get_vid(skb, *hdr_size);
+
+	/* ARP parsing functions jump forward of hdr_size + ETH_HLEN.
+	 * If the header contained in the packet is a VLAN one (which is longer)
+	 * hdr_size is updated so that the functions will still jump the
+	 * correct amount of bytes
+	 */
+	if (vid & BATADV_VLAN_HAS_TAG)
+		*hdr_size += VLAN_HLEN;
+
+	return vid;
+}
+
+/**
  * batadv_dat_snoop_outgoing_arp_request - snoop the ARP request and try to
  * answer using DAT
  * @bat_priv: the bat priv with all the soft interface information
@@ -876,11 +904,15 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	bool ret = false;
 	struct batadv_dat_entry *dat_entry = NULL;
 	struct sk_buff *skb_new;
+	int hdr_size = 0;
+	unsigned short vid;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
-	type = batadv_arp_get_type(bat_priv, skb, 0);
+	vid = batadv_dat_get_vid(skb, &hdr_size);
+
+	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	/* If the node gets an ARP_REQUEST it has to send a DHT_GET unicast
 	 * message to the selected DHT candidates
 	 */
@@ -893,9 +925,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, 0);
 	ip_dst = batadv_arp_ip_dst(skb, 0);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
@@ -956,11 +988,14 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	struct sk_buff *skb_new;
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
+	unsigned short vid;
 	int err;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
+	vid = batadv_dat_get_vid(skb, &hdr_size);
+
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REQUEST)
 		goto out;
@@ -972,9 +1007,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
 		       "Parsing incoming ARP REQUEST");
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (!dat_entry)
 		goto out;
 
@@ -992,10 +1027,9 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (hdr_size == sizeof(struct batadv_unicast_4addr_packet))
 		err = batadv_send_skb_unicast_4addr(bat_priv, skb_new,
 						    BATADV_P_DAT_CACHE_REPLY,
-						    BATADV_NO_FLAGS);
+						    vid);
 	else
-		err = batadv_send_skb_unicast(bat_priv, skb_new,
-					      BATADV_NO_FLAGS);
+		err = batadv_send_skb_unicast(bat_priv, skb_new, vid);
 
 	if (!err) {
 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
@@ -1020,23 +1054,27 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	uint16_t type;
 	__be32 ip_src, ip_dst;
 	uint8_t *hw_src, *hw_dst;
+	int hdr_size = 0;
+	unsigned short vid;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		return;
 
-	type = batadv_arp_get_type(bat_priv, skb, 0);
+	vid = batadv_dat_get_vid(skb, &hdr_size);
+
+	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REPLY)
 		return;
 
 	batadv_dbg_arp(bat_priv, skb, type, 0, "Parsing outgoing ARP REPLY");
 
-	hw_src = batadv_arp_hw_src(skb, 0);
-	ip_src = batadv_arp_ip_src(skb, 0);
-	hw_dst = batadv_arp_hw_dst(skb, 0);
-	ip_dst = batadv_arp_ip_dst(skb, 0);
+	hw_src = batadv_arp_hw_src(skb, hdr_size);
+	ip_src = batadv_arp_ip_src(skb, hdr_size);
+	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
+	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
@@ -1058,10 +1096,13 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	__be32 ip_src, ip_dst;
 	uint8_t *hw_src, *hw_dst;
 	bool ret = false;
+	unsigned short vid;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
 
+	vid = batadv_dat_get_vid(skb, &hdr_size);
+
 	type = batadv_arp_get_type(bat_priv, skb, hdr_size);
 	if (type != ARPOP_REPLY)
 		goto out;
@@ -1077,13 +1118,13 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
+	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
 	 */
-	ret = !batadv_is_my_client(bat_priv, hw_dst, BATADV_NO_FLAGS);
+	ret = !batadv_is_my_client(bat_priv, hw_dst, vid);
 out:
 	if (ret)
 		kfree_skb(skb);
@@ -1106,7 +1147,8 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 	__be32 ip_dst;
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
-	const size_t bcast_len = sizeof(struct batadv_bcast_packet);
+	int hdr_size = sizeof(struct batadv_bcast_packet);
+	unsigned short vid;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1117,12 +1159,14 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 	if (forw_packet->num_packets)
 		goto out;
 
-	type = batadv_arp_get_type(bat_priv, forw_packet->skb, bcast_len);
+	vid = batadv_dat_get_vid(forw_packet->skb, &hdr_size);
+
+	type = batadv_arp_get_type(bat_priv, forw_packet->skb, hdr_size);
 	if (type != ARPOP_REQUEST)
 		goto out;
 
-	ip_dst = batadv_arp_ip_dst(forw_packet->skb, bcast_len);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	ip_dst = batadv_arp_ip_dst(forw_packet->skb, hdr_size);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	/* check if the node already got this entry */
 	if (!dat_entry) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
diff --git a/types.h b/types.h
index 8841a1a..736f822 100644
--- a/types.h
+++ b/types.h
@@ -940,6 +940,7 @@ struct batadv_algo_ops {
  * is used to stored ARP entries needed for the global DAT cache
  * @ip: the IPv4 corresponding to this DAT/ARP entry
  * @mac_addr: the MAC address associated to the stored IPv4
+ * @vid: the vlan ID associated to this entry
  * @last_update: time in jiffies when this entry was refreshed last time
  * @hash_entry: hlist node for batadv_priv_dat::hash
  * @refcount: number of contexts the object is used
@@ -948,6 +949,7 @@ struct batadv_algo_ops {
 struct batadv_dat_entry {
 	__be32 ip;
 	uint8_t mac_addr[ETH_ALEN];
+	unsigned short vid;
 	unsigned long last_update;
 	struct hlist_node hash_entry;
 	atomic_t refcount;
-- 
1.8.1.5

