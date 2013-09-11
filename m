Return-Path: <mihail.costea2005@gmail.com>
From: Mihail Costea <mihail.costea2005@gmail.com>
Date: Wed, 11 Sep 2013 15:44:52 +0300
Message-Id: <1378903492-2604-1-git-send-email-mihail.costea90@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Generalize DAT in order to
	support any type of key/value, not only IPv4 and MAC
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

Mades DAT support more types by making its key and value a void* and
by adding type field to dat_entry.
This change is needed in order to make DAT support any type of keys,
like IPv6 too.

Adds generic function for transforming any data to string.
The function is used in order to avoid defining different debug messages
for different DAT key/value types. For example, if we had IPv6 as a DAT key,
then "%pI4" should be "%pI6c", but all the other text of the debug message
would be the same.
Also everything is memorized in a struct in order to avoid further
switch cases for all types.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 compat.c                |    2 +
 distributed-arp-table.c |  219 +++++++++++++++++++++++++++++++++++------------
 distributed-arp-table.h |    2 +
 types.h                 |   32 ++++++-
 4 files changed, 195 insertions(+), 60 deletions(-)

diff --git a/compat.c b/compat.c
index 68c2258..6496c00 100644
--- a/compat.c
+++ b/compat.c
@@ -97,6 +97,8 @@ void batadv_free_rcu_dat_entry(struct rcu_head *rcu)
 	struct batadv_dat_entry *dat_entry;
 
 	dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
+	kfree(dat_entry->value);
+	kfree(dat_entry->key);
 	kfree(dat_entry);
 }
 #endif
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 6c8c393..28e513f 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -33,6 +33,31 @@
 
 static void batadv_dat_purge(struct work_struct *work);
 
+static struct batadv_dat_type_info batadv_dat_types_info[] = {
+	{
+		.key_size = sizeof(__be32),
+		.key_str_fmt = "%pI4",
+		.value_size = ETH_ALEN,
+		.value_str_fmt = "%pM",
+	},
+};
+
+/**
+ * batadv_dat_data_to_str: transforms a given data to a string using str_fmt
+ * @data: the data to transform
+ * @str_fmt: string format
+ * @buf: the buf where the key string is stored
+ * @buf_len: buf length
+ *
+ * Returns buf.
+ */
+static char *batadv_dat_data_to_str(void *data, char *str_fmt,
+				    char *buf, size_t buf_len)
+{
+	snprintf(buf, buf_len, str_fmt, data);
+	return buf;
+}
+
 /**
  * batadv_dat_start_timer - initialise the DAT periodic worker
  * @bat_priv: the bat priv with all the soft interface information
@@ -132,16 +157,24 @@ static void batadv_dat_purge(struct work_struct *work)
 /**
  * batadv_compare_dat - comparing function used in the local DAT hash table
  * @node: node in the local table
- * @data2: second object to compare the node to
+ * @key2: second object to compare the node to
  *
  * Returns 1 if the two entries are the same, 0 otherwise.
  */
-static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
+static int batadv_compare_dat(const struct hlist_node *node, const void *key2)
 {
-	const void *data1 = container_of(node, struct batadv_dat_entry,
-					 hash_entry);
+	const struct batadv_dat_entry *dat_entry1, *dat_entry2;
+	size_t key_size;
 
-	return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
+	dat_entry1 = container_of(node, struct batadv_dat_entry, hash_entry);
+	dat_entry2 = container_of(key2, struct batadv_dat_entry, key);
+
+	if (dat_entry1->type != dat_entry2->type)
+		return 0;
+
+	key_size = batadv_dat_types_info[dat_entry1->type].key_size;
+	return (memcmp(dat_entry1->key, dat_entry2->key, key_size) == 0 ?
+			1 : 0);
 }
 
 /**
@@ -198,7 +231,7 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 }
 
 /**
- * batadv_hash_dat - compute the hash value for an IP address
+ * batadv_hash_dat - compute the hash value for a DAT key
  * @data: data to hash
  * @size: size of the hash table
  *
@@ -209,7 +242,8 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
 	uint32_t hash = 0;
 	const struct batadv_dat_entry *dat = data;
 
-	hash = batadv_hash_bytes(hash, &dat->ip, sizeof(dat->ip));
+	hash = batadv_hash_bytes(hash, dat->key,
+				 batadv_dat_types_info[dat->type].key_size);
 	hash = batadv_hash_bytes(hash, &dat->vid, sizeof(dat->vid));
 
 	hash += (hash << 3);
@@ -223,24 +257,26 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
  * batadv_dat_entry_hash_find - look for a given dat_entry in the local hash
  * table
  * @bat_priv: the bat priv with all the soft interface information
- * @ip: search key
+ * @key: search key
+ * @entry_type: type of the entry
  * @vid: VLAN identifier
  *
  * Returns the dat_entry if found, NULL otherwise.
  */
 static struct batadv_dat_entry *
-batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
-			   unsigned short vid)
+batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *key,
+			   uint8_t entry_type, unsigned short vid)
 {
 	struct hlist_head *head;
 	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp = NULL;
 	struct batadv_hashtable *hash = bat_priv->dat.hash;
-	uint32_t index;
+	uint32_t index, key_size = batadv_dat_types_info[entry_type].key_size;
 
 	if (!hash)
 		return NULL;
 
-	to_find.ip = ip;
+	to_find.key = key;
+	to_find.type = entry_type;
 	to_find.vid = vid;
 
 	index = batadv_hash_dat(&to_find, hash->size);
@@ -248,7 +284,9 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
-		if (dat_entry->ip != ip)
+		if (dat_entry->type != entry_type)
+			continue;
+		if (memcmp(dat_entry->key, key, key_size))
 			continue;
 
 		if (!atomic_inc_not_zero(&dat_entry->refcount))
@@ -265,36 +303,62 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 /**
  * batadv_dat_entry_add - add a new dat entry or update it if already exists
  * @bat_priv: the bat priv with all the soft interface information
- * @ip: ipv4 to add/edit
- * @mac_addr: mac address to assign to the given ipv4
+ * @key: the key to add/edit
+ * @entry_type: type of the key added to DAT
+ * @value: the value to assign to the given key
  * @vid: VLAN identifier
  */
-static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 uint8_t *mac_addr, unsigned short vid)
+static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *key,
+				 uint8_t entry_type, void *value,
+				 unsigned short vid)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
+	char dbg_key[BATADV_DAT_KEY_MAX_LEN];
+	char dbg_value[BATADV_DAT_VALUE_MAX_LEN];
+	size_t key_size = batadv_dat_types_info[entry_type].key_size;
+	size_t value_size = batadv_dat_types_info[entry_type].value_size;
+	char *key_str_fmt = batadv_dat_types_info[entry_type].key_str_fmt;
+	char *value_str_fmt = batadv_dat_types_info[entry_type].value_str_fmt;
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, key, entry_type, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
-		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
-			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
+		if (memcmp(dat_entry->value, value, value_size))
+			memcpy(dat_entry->value, value, value_size);
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM (vid: %d)\n",
-			   &dat_entry->ip, dat_entry->mac_addr,
+			   "Entry updated: %s %s (vid: %d)\n",
+			   batadv_dat_data_to_str(dat_entry->key, key_str_fmt,
+						  dbg_key, sizeof(dbg_key)),
+			   batadv_dat_data_to_str(dat_entry->value,
+						  value_str_fmt,
+						  dbg_value,
+						  sizeof(dbg_value)),
 			   BATADV_PRINT_VID(vid));
 		goto out;
 	}
 
+
 	dat_entry = kmalloc(sizeof(*dat_entry), GFP_ATOMIC);
 	if (!dat_entry)
 		goto out;
 
-	dat_entry->ip = ip;
+	/* Assignment needed for correct free if next allocation fails. */
+	dat_entry->value = NULL;
+	dat_entry->key = kmalloc(key_size, GFP_ATOMIC);
+	if (!dat_entry->key)
+		goto out;
+	memcpy(dat_entry->key, key, key_size);
+
+	dat_entry->value = kmalloc(value_size, GFP_ATOMIC);
+	if (!dat_entry->value)
+		goto out;
+	memcpy(dat_entry->value, value, value_size);
+
+	dat_entry->type = entry_type;
 	dat_entry->vid = vid;
-	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
+
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);
 
@@ -308,8 +372,12 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, BATADV_PRINT_VID(vid));
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %s %s (vid: %d)\n",
+		   batadv_dat_data_to_str(dat_entry->key, key_str_fmt,
+					 dbg_key, sizeof(dbg_key)),
+		   batadv_dat_data_to_str(dat_entry->value, value_str_fmt,
+					   dbg_value, sizeof(dbg_value)),
+		   BATADV_PRINT_VID(vid));
 
 out:
 	if (dat_entry)
@@ -521,7 +589,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * batadv_dat_select_candidates - select the nodes which the DHT message has to
  * be sent to
  * @bat_priv: the bat priv with all the soft interface information
- * @ip_dst: ipv4 to look up in the DHT
+ * @key: key to look up in the DHT
+ * @entry_type: type of the key
  *
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (from the LEFT, with wrap around if needed) then the hash
@@ -530,11 +599,15 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * Returns the candidate array of size BATADV_DAT_CANDIDATE_NUM.
  */
 static struct batadv_dat_candidate *
-batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
+batadv_dat_select_candidates(struct batadv_priv *bat_priv, void *key,
+			     uint8_t entry_type)
 {
 	int select;
-	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
+	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, dat_key;
 	struct batadv_dat_candidate *res;
+	struct batadv_dat_entry to_find;
+	char dbg_key[BATADV_DAT_KEY_MAX_LEN];
+	char *key_str_fmt = batadv_dat_types_info[entry_type].key_str_fmt;
 
 	if (!bat_priv->orig_hash)
 		return NULL;
@@ -543,15 +616,19 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;
 
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
-						    BATADV_DAT_ADDR_MAX);
+	to_find.key = key;
+	to_find.type = entry_type;
+	dat_key = (batadv_dat_addr_t)batadv_hash_dat(&to_find,
+						     BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
-		   ip_key);
+		   "dat_select_candidates(): KEY=%s hash(KEY)=%u\n",
+		   batadv_dat_data_to_str(key, key_str_fmt, dbg_key,
+					  sizeof(dbg_key)),
+		   dat_key);
 
 	for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
-		batadv_choose_next_candidate(bat_priv, res, select, ip_key,
+		batadv_choose_next_candidate(bat_priv, res, select, dat_key,
 					     &last_max);
 
 	return res;
@@ -561,7 +638,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  * batadv_dat_send_data - send a payload to the selected candidates
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
- * @ip: the DHT key
+ * @key: the DHT key
+ * @entry_type: type of the key
  * @packet_subtype: unicast4addr packet subtype to use
  *
  * This function copies the skb with pskb_copy() and is sent as unicast packet
@@ -571,8 +649,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  * otherwise.
  */
 static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
-				 struct sk_buff *skb, __be32 ip,
-				 int packet_subtype)
+				 struct sk_buff *skb, void *key,
+				 uint8_t entry_type, int packet_subtype)
 {
 	int i;
 	bool ret = false;
@@ -580,12 +658,16 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;
+	char dbg_key[BATADV_DAT_KEY_MAX_LEN];
+	char *key_str_fmt = batadv_dat_types_info[entry_type].key_str_fmt;
 
-	cand = batadv_dat_select_candidates(bat_priv, ip);
+	cand = batadv_dat_select_candidates(bat_priv, key, entry_type);
 	if (!cand)
 		goto out;
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %s\n",
+		   batadv_dat_data_to_str(key, key_str_fmt, dbg_key,
+					  sizeof(dbg_key)));
 
 	for (i = 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
 		if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
@@ -755,6 +837,9 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	unsigned long last_seen_jiffies;
 	int last_seen_msecs, last_seen_secs, last_seen_mins;
 	uint32_t i;
+	char dbg_key[BATADV_DAT_KEY_MAX_LEN];
+	char dbg_value[BATADV_DAT_VALUE_MAX_LEN];
+	char *key_str_fmt, *value_str_fmt;
 
 	primary_if = batadv_seq_print_text_primary_if_get(seq);
 	if (!primary_if)
@@ -775,8 +860,20 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;
 
-			seq_printf(seq, " * %15pI4 %14pM %4i %6i:%02i\n",
-				   &dat_entry->ip, dat_entry->mac_addr,
+			key_str_fmt = batadv_dat_types_info[dat_entry->type]
+							.key_str_fmt;
+			value_str_fmt = batadv_dat_types_info[dat_entry->type]
+							.value_str_fmt;
+
+			seq_printf(seq, " * %15s %14s %4i %6i:%02i\n",
+				   batadv_dat_data_to_str(dat_entry->key,
+							  key_str_fmt,
+							  dbg_key,
+							  sizeof(dbg_key)),
+				   batadv_dat_data_to_str(dat_entry->value,
+							  value_str_fmt,
+							  dbg_value,
+							  sizeof(dbg_value)),
 				   BATADV_PRINT_VID(dat_entry->vid),
 				   last_seen_mins, last_seen_secs);
 		}
@@ -929,9 +1026,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4, vid);
 	if (dat_entry) {
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
@@ -940,8 +1038,11 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * Moreover, if the soft-interface is enslaved into a bridge, an
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
+		 *
+		 * Entry value is the same as mac_addr, so it can be used
+		 * directly.
 		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr,
+		if (batadv_is_my_client(bat_priv, dat_entry->value,
 					BATADV_NO_FLAGS)) {
 			ret = true;
 			goto out;
@@ -949,7 +1050,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 
 		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
 				     bat_priv->soft_iface, ip_dst, hw_src,
-				     dat_entry->mac_addr, hw_src);
+				     dat_entry->value, hw_src);
 		if (!skb_new)
 			goto out;
 
@@ -969,7 +1070,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		ret = true;
 	} else {
 		/* Send the request to the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
+		ret = batadv_dat_send_data(bat_priv, skb, &ip_dst,
+					   BATADV_DAT_IPV4,
 					   BATADV_P_DAT_DHT_GET);
 	}
 out:
@@ -1015,15 +1117,17 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
 		       "Parsing incoming ARP REQUEST");
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4, vid);
 	if (!dat_entry)
 		goto out;
 
+	/* Entry value is the same as mac_addr, so it can be used directly. */
 	skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
 			     bat_priv->soft_iface, ip_dst, hw_src,
-			     dat_entry->mac_addr, hw_src);
+			     dat_entry->value, hw_src);
 
 	if (!skb_new)
 		goto out;
@@ -1086,14 +1190,16 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst, vid);
 
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
@@ -1131,8 +1237,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst, vid);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
@@ -1179,7 +1285,8 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 		goto out;
 
 	ip_dst = batadv_arp_ip_dst(forw_packet->skb, hdr_size);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4, vid);
 	/* check if the node already got this entry */
 	if (!dat_entry) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 60d853b..a60619d 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -28,6 +28,8 @@
 #include <linux/if_arp.h>
 
 #define BATADV_DAT_ADDR_MAX ((batadv_dat_addr_t)~(batadv_dat_addr_t)0)
+#define BATADV_DAT_KEY_MAX_LEN 16
+#define BATADV_DAT_VALUE_MAX_LEN 18
 
 void batadv_dat_status_update(struct net_device *net_dev);
 bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
diff --git a/types.h b/types.h
index f323822..239a95e 100644
--- a/types.h
+++ b/types.h
@@ -1031,8 +1031,9 @@ struct batadv_algo_ops {
 /**
  * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
  * is used to stored ARP entries needed for the global DAT cache
- * @ip: the IPv4 corresponding to this DAT/ARP entry
- * @mac_addr: the MAC address associated to the stored IPv4
+ * @key: the key corresponding to this DAT entry
+ * @value: the value corresponding to this DAT entry
+ * @type: the type of the DAT entry
  * @vid: the vlan ID associated to this entry
  * @last_update: time in jiffies when this entry was refreshed last time
  * @hash_entry: hlist node for batadv_priv_dat::hash
@@ -1040,8 +1041,9 @@ struct batadv_algo_ops {
  * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_dat_entry {
-	__be32 ip;
-	uint8_t mac_addr[ETH_ALEN];
+	void *key;
+	void *value;
+	uint8_t type;
 	unsigned short vid;
 	unsigned long last_update;
 	struct hlist_node hash_entry;
@@ -1050,6 +1052,28 @@ struct batadv_dat_entry {
 };
 
 /**
+ * batadv_dat_types - possible types for DAT entries
+ * @BATADV_DAT_IPV4: IPv4 address type
+ */
+enum batadv_dat_types {
+	BATADV_DAT_IPV4 = 0,
+};
+
+/**
+ * batadv_dat_type_info - info needed for a DAT type
+ * @key_size: the size of the DAT entry key
+ * @key_str_fmt: string format used by key
+ * @value_size: the size of the value
+ * @value_str_fmt: string format used by value
+ */
+struct batadv_dat_type_info {
+	size_t key_size;
+	char *key_str_fmt;
+	size_t value_size;
+	char *value_str_fmt;
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4

