Return-Path: <mihail.costea2005@gmail.com>
From: Mihail <mihail.costea2005@gmail.com>
Date: Fri, 26 Apr 2013 16:56:54 +0300
Message-Id: <1366984615-15429-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] Made DAT more generic by adding support to
	any type of data
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

Made DAT support more types by making its data a void*, adding type field
to dat_entry and adding data_type to necessary functions.
This change is needed in order to make DAT support any type of data, like IPv6 too.

Added generic function for transforming DAT data to string.
The function is used in order to avoid defining different debug messages
for different DAT data types. For example, if we had IPv6 as a DAT data,
then "%pI4" should be "%pI6c", but all
the other text of the debug message would be the same.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 distributed-arp-table.c |  229 ++++++++++++++++++++++++++++++++++++-----------
 distributed-arp-table.h |    1 +
 types.h                 |   14 ++-
 3 files changed, 190 insertions(+), 54 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 3a4b577..30af421 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -31,9 +31,29 @@
 #include "translation-table.h"
 #include "unicast.h"
 
+static char *batadv_dat_types_str_fmt[] = {
+	"%pI4",
+};
+
 static void batadv_dat_purge(struct work_struct *work);
 
 /**
+ * batadv_dat_data_to_str: transforms DAT data to string
+ * @data: the DAT data
+ * @type: type of data
+ * @buf: the buf where the data string is stored
+ * @buf_len: buf length
+ *
+ * Returns buf.
+ */
+static char *batadv_dat_data_to_str(void *data, uint8_t type,
+				    char *buf, size_t buf_len)
+{
+	snprintf(buf, buf_len, batadv_dat_types_str_fmt[type], data);
+	return buf;
+}
+
+/**
  * batadv_dat_start_timer - initialise the DAT periodic worker
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -45,6 +65,19 @@ static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_dat_entry_free_ref_rcu - free a dat entry using its rcu
+ * @rcu: the dat entry rcu
+ */
+static void batadv_dat_entry_free_ref_rcu(struct rcu_head *rcu)
+{
+	struct batadv_dat_entry *dat_entry;
+
+	dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
+	kfree(dat_entry->data);
+	kfree(dat_entry);
+}
+
+/**
  * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
  * free it
  * @dat_entry: the entry to free
@@ -52,7 +85,7 @@ static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
 {
 	if (atomic_dec_and_test(&dat_entry->refcount))
-		kfree_rcu(dat_entry, rcu);
+		call_rcu(&dat_entry->rcu, batadv_dat_entry_free_ref_rcu);
 }
 
 /**
@@ -130,6 +163,22 @@ static void batadv_dat_purge(struct work_struct *work)
 }
 
 /**
+ * batadv_sizeof_dat_data - get sizeof DAT data based on its type
+ * @data_type: type of DAT data
+ *
+ * Returns sizeof data, or 0 if invalid.
+ */
+static size_t batadv_sizeof_dat_data(uint8_t data_type)
+{
+	switch (data_type) {
+	case BATADV_DAT_IPV4:
+		return sizeof(__be32);
+	default:
+		return 0;
+	}
+}
+
+/**
  * batadv_compare_dat - comparing function used in the local DAT hash table
  * @node: node in the local table
  * @data2: second object to compare the node to
@@ -138,10 +187,22 @@ static void batadv_dat_purge(struct work_struct *work)
  */
 static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_dat_entry,
-					 hash_entry);
+	struct batadv_dat_entry *dat_entry1 =
+			container_of(node, struct batadv_dat_entry,
+				     hash_entry);
+	struct batadv_dat_entry *dat_entry2 =
+			container_of(data2,
+				     struct batadv_dat_entry, data);
+	size_t data_size;
 
-	return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
+	if (dat_entry1->type != dat_entry2->type)
+		return 0;
+	data_size = batadv_sizeof_dat_data(dat_entry1->type);
+	if (data_size == 0)
+		return 0;
+
+	return (memcmp(dat_entry1->data, dat_entry2->data,
+		       data_size) == 0 ? 1 : 0);
 }
 
 /**
@@ -198,19 +259,25 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 }
 
 /**
- * batadv_hash_dat - compute the hash value for an IP address
+ * batadv_hash_dat - compute the hash value for a DAT data
  * @data: data to hash
+ * @data_type: type of data
  * @size: size of the hash table
  *
  * Returns the selected index in the hash table for the given data.
  */
-static uint32_t batadv_hash_dat(const void *data, uint32_t size)
+static uint32_t batadv_hash_dat(const void *data, uint8_t data_type,
+				uint32_t size)
 {
 	const unsigned char *key = data;
 	uint32_t hash = 0;
-	size_t i;
+	size_t i, data_size;
 
-	for (i = 0; i < 4; i++) {
+	data_size = batadv_sizeof_dat_data(data_type);
+	if (data_size == 0)
+		return 0;
+
+	for (i = 0; i < data_size; i++) {
 		hash += key[i];
 		hash += (hash << 10);
 		hash ^= (hash >> 6);
@@ -223,31 +290,46 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
 	return hash % size;
 }
 
+static uint32_t batadv_hash_dat_ipv4(const void *data, uint32_t size)
+{
+	return batadv_hash_dat(data, BATADV_DAT_IPV4, size);
+}
+
+
 /**
  * batadv_dat_entry_hash_find - look for a given dat_entry in the local hash
  * table
  * @bat_priv: the bat priv with all the soft interface information
- * @ip: search key
+ * @data: search key
+ * @data_type: type of data
  *
  * Returns the dat_entry if found, NULL otherwise.
  */
 static struct batadv_dat_entry *
-batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
+batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *data,
+			   uint8_t data_type)
 {
 	struct hlist_head *head;
 	struct batadv_dat_entry *dat_entry, *dat_entry_tmp = NULL;
 	struct batadv_hashtable *hash = bat_priv->dat.hash;
 	uint32_t index;
+	size_t data_size;
 
 	if (!hash)
 		return NULL;
 
-	index = batadv_hash_dat(&ip, hash->size);
+	data_size = batadv_sizeof_dat_data(data_type);
+	if (data_size == 0)
+		return NULL;
+
+	index = batadv_hash_dat(data, data_type, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
-		if (dat_entry->ip != ip)
+		if (dat_entry->type != data_type)
+			continue;
+		if (memcmp(dat_entry->data, data, data_size))
 			continue;
 
 		if (!atomic_inc_not_zero(&dat_entry->refcount))
@@ -264,23 +346,28 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
 /**
  * batadv_dat_entry_add - add a new dat entry or update it if already exists
  * @bat_priv: the bat priv with all the soft interface information
- * @ip: ipv4 to add/edit
- * @mac_addr: mac address to assign to the given ipv4
+ * @data: the data to add/edit
+ * @data_type: type of the data added to DAT
+ * @mac_addr: mac address to assign to the given data
  */
-static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 uint8_t *mac_addr)
+static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *data,
+				 uint8_t data_type, uint8_t *mac_addr)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
+	size_t data_size;
+	batadv_hashdata_choose_cb choose;
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, data, data_type);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
-		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM\n", &dat_entry->ip,
+		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Entry updated: %s %pM\n",
+			   batadv_dat_data_to_str(dat_entry->data, data_type,
+						  dbg_data, sizeof(dbg_data)),
 			   dat_entry->mac_addr);
 		goto out;
 	}
@@ -289,13 +376,29 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (!dat_entry)
 		goto out;
 
-	dat_entry->ip = ip;
+	data_size = batadv_sizeof_dat_data(data_type);
+	if (data_size == 0)
+		goto out;
+	dat_entry->data = kmalloc(data_size, GFP_ATOMIC);
+	if (!dat_entry->data)
+		goto out;
+	memcpy(dat_entry->data, data, data_size);
+	dat_entry->type = data_type;
+
 	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);
 
+	switch (data_type) {
+	case BATADV_DAT_IPV4:
+		choose = batadv_hash_dat_ipv4;
+		break;
+	default:
+		goto out;
+	}
+
 	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
-				     batadv_hash_dat, &dat_entry->ip,
+				     choose, dat_entry->data,
 				     &dat_entry->hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -304,8 +407,11 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
-		   &dat_entry->ip, dat_entry->mac_addr);
+
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %s %pM\n",
+		   batadv_dat_data_to_str(dat_entry->data, data_type,
+					  dbg_data, sizeof(dbg_data)),
+		   dat_entry->mac_addr);
 
 out:
 	if (dat_entry)
@@ -517,20 +623,23 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * batadv_dat_select_candidates - select the nodes which the DHT message has to
  * be sent to
  * @bat_priv: the bat priv with all the soft interface information
- * @ip_dst: ipv4 to look up in the DHT
+ * @data: data to look up in the DHT
+ * @data_type: type of data
  *
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (from the LEFT, with wrap around if needed) then the hash
- * value of the key. ip_dst is the key.
+ * value of the key. data is the key.
  *
  * Returns the candidate array of size BATADV_DAT_CANDIDATE_NUM.
  */
 static struct batadv_dat_candidate *
-batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
+batadv_dat_select_candidates(struct batadv_priv *bat_priv, void *data,
+			     uint8_t data_type)
 {
 	int select;
-	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
+	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, data_key;
 	struct batadv_dat_candidate *res;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
 
 	if (!bat_priv->orig_hash)
 		return NULL;
@@ -539,15 +648,17 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;
 
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
-						    BATADV_DAT_ADDR_MAX);
+	data_key = (batadv_dat_addr_t)batadv_hash_dat(data, data_type,
+						      BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
-		   ip_key);
+		   "dat_select_candidates(): DATA=%s hash(DATA)=%u\n",
+		   batadv_dat_data_to_str(data, data_type, dbg_data,
+					  sizeof(dbg_data)),
+		   data_key);
 
 	for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
-		batadv_choose_next_candidate(bat_priv, res, select, ip_key,
+		batadv_choose_next_candidate(bat_priv, res, select, data_key,
 					     &last_max);
 
 	return res;
@@ -557,7 +668,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  * batadv_dat_send_data - send a payload to the selected candidates
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
- * @ip: the DHT key
+ * @data: the DHT key
+ * @data_type: type of data
  * @packet_subtype: unicast4addr packet subtype to use
  *
  * This function copies the skb with pskb_copy() and is sent as unicast packet
@@ -567,8 +679,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  * otherwise.
  */
 static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
-				 struct sk_buff *skb, __be32 ip,
-				 int packet_subtype)
+				 struct sk_buff *skb, void *data,
+				 uint8_t data_type, int packet_subtype)
 {
 	int i;
 	bool ret = false;
@@ -576,12 +688,15 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
 
-	cand = batadv_dat_select_candidates(bat_priv, ip);
+	cand = batadv_dat_select_candidates(bat_priv, data, data_type);
 	if (!cand)
 		goto out;
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %s\n",
+		   batadv_dat_data_to_str(data, data_type, dbg_data,
+					  sizeof(dbg_data)));
 
 	for (i = 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
 		if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
@@ -771,9 +886,13 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;
 
-			seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
-				   &dat_entry->ip, dat_entry->mac_addr,
-				   last_seen_mins, last_seen_secs);
+			switch (dat_entry->type) {
+			case BATADV_DAT_IPV4:
+				seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
+					   dat_entry->data, dat_entry->mac_addr,
+					   last_seen_mins, last_seen_secs);
+				break;
+			}
 		}
 		rcu_read_unlock();
 	}
@@ -894,9 +1013,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, 0);
 	ip_dst = batadv_arp_ip_dst(skb, 0);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4);
 	if (dat_entry) {
 		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
 				     bat_priv->soft_iface, ip_dst, hw_src,
@@ -916,7 +1036,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		ret = true;
 	} else {
 		/* Send the request to the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
+		ret = batadv_dat_send_data(bat_priv, skb, &ip_dst,
+					   BATADV_DAT_IPV4,
 					   BATADV_P_DAT_DHT_GET);
 	}
 out:
@@ -959,9 +1080,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
 		       "Parsing incoming ARP REQUEST");
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4);
 	if (!dat_entry)
 		goto out;
 
@@ -1020,14 +1142,16 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, 0);
 	ip_dst = batadv_arp_ip_dst(skb, 0);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
+	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst);
 
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, ip_src, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, &ip_src, BATADV_DAT_IPV4,
+			     BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, &ip_dst, BATADV_DAT_IPV4,
+			     BATADV_P_DAT_DHT_PUT);
 }
 /**
  * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
@@ -1062,8 +1186,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src);
+	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
@@ -1107,7 +1231,8 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 		goto out;
 
 	ip_dst = batadv_arp_ip_dst(forw_packet->skb, bcast_len);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4);
 	/* check if the node already got this entry */
 	if (!dat_entry) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 60d853b..557bab9 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -28,6 +28,7 @@
 #include <linux/if_arp.h>
 
 #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
+#define BATADV_DAT_DATA_MAX_LEN 16
 
 void batadv_dat_status_update(struct net_device *net_dev);
 bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
diff --git a/types.h b/types.h
index 71da448..75c0d87 100644
--- a/types.h
+++ b/types.h
@@ -995,7 +995,8 @@ struct batadv_algo_ops {
 /**
  * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
  * is used to stored ARP entries needed for the global DAT cache
- * @ip: the IPv4 corresponding to this DAT/ARP entry
+ * @data: the data corresponding to this DAT entry
+ * @type: the type corresponding to this DAT entry
  * @mac_addr: the MAC address associated to the stored IPv4
  * @last_update: time in jiffies when this entry was refreshed last time
  * @hash_entry: hlist node for batadv_priv_dat::hash
@@ -1003,7 +1004,8 @@ struct batadv_algo_ops {
  * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_dat_entry {
-	__be32 ip;
+	void *data;
+	uint8_t type;
 	uint8_t mac_addr[ETH_ALEN];
 	unsigned long last_update;
 	struct hlist_node hash_entry;
@@ -1012,6 +1014,14 @@ struct batadv_dat_entry {
 };
 
 /**
+ * batadv_dat_types - types used in batadv_dat_entry for IP
+ * @BATADV_DAT_IPv4: IPv4 address type
+ */
+enum batadv_dat_types {
+	BATADV_DAT_IPV4 = 0,
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4

