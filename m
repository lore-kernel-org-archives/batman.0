Return-Path: <mihail.costea2005@gmail.com>
From: mihail.costea2005@gmail.com
Date: Mon,  8 Jul 2013 03:12:40 +0300
Message-Id: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [RFC 1/6] batman-adv: Generalize DAT in order to
	support any type of data, not only IPv4
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

Mades DAT support more types by making its data a void*, adding type field
to dat_entry and adding data_type to necessary functions.
This change is needed in order to make DAT support any type of data, like IPv6 too.

Adds generic function for transforming DAT data to string.
The function is used in order to avoid defining different debug messages
for different DAT data types. For example, if we had IPv6 as a DAT data,
then "%pI4" should be "%pI6c", but all
the other text of the debug message would be the same.
Also everything is memorized in a struct in order to avoid further
switch cases for all types.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---
 distributed-arp-table.c |  197 +++++++++++++++++++++++++++++++++++------------
 distributed-arp-table.h |    1 +
 types.h                 |   24 +++++-
 3 files changed, 169 insertions(+), 53 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index f2543c2..90565d0 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -31,9 +31,32 @@
 #include "types.h"
 #include "translation-table.h"
 
+static struct batadv_dat_type_info batadv_dat_types_info[] = {
+	{
+		.size = sizeof(__be32),
+		.str_fmt = "%pI4",
+	},
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
+	snprintf(buf, buf_len, batadv_dat_types_info[type].str_fmt, data);
+return buf;
+}
+
+/**
  * batadv_dat_start_timer - initialise the DAT periodic worker
  * @bat_priv: the bat priv with all the soft interface information
  */
@@ -45,6 +68,19 @@ static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
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
@@ -52,7 +88,7 @@ static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
 {
 	if (atomic_dec_and_test(&dat_entry->refcount))
-		kfree_rcu(dat_entry, rcu);
+		call_rcu(&dat_entry->rcu, batadv_dat_entry_free_ref_rcu);
 }
 
 /**
@@ -136,12 +172,21 @@ static void batadv_dat_purge(struct work_struct *work)
  *
  * Returns 1 if the two entries are the same, 0 otherwise.
  */
-static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
+static int  batadv_compare_dat(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_dat_entry,
-					 hash_entry);
+	struct batadv_dat_entry *dat_entry1 =
+			container_of(node, struct batadv_dat_entry,
+				     hash_entry);
+	struct batadv_dat_entry *dat_entry2 =
+			container_of(data2,
+				     struct batadv_dat_entry, data);
+	size_t data_size = batadv_dat_types_info[dat_entry1->type].size;
 
-	return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
+	if (dat_entry1->type != dat_entry2->type)
+		return 0;
+
+	return (memcmp(dat_entry1->data, dat_entry2->data,
+			data_size) == 0 ? 1 : 0);
 }
 
 /**
@@ -198,8 +243,9 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 }
 
 /**
- * batadv_hash_dat - compute the hash value for an IP address
+ * batadv_hash_dat - compute the hash value for a DAT data
  * @data: data to hash
+ * @data_type: type of data
  * @size: size of the hash table
  *
  * Returns the selected index in the hash table for the given data.
@@ -209,7 +255,8 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
 	uint32_t hash = 0;
 	const struct batadv_dat_entry *dat = data;
 
-	hash = batadv_hash_bytes(hash, &dat->ip, sizeof(dat->ip));
+	hash = batadv_hash_bytes(hash, dat->data,
+				 batadv_dat_types_info[dat->type].size);
 	hash = batadv_hash_bytes(hash, &dat->vid, sizeof(dat->vid));
 
 	hash += (hash << 3);
@@ -223,32 +270,40 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
  * batadv_dat_entry_hash_find - look for a given dat_entry in the local hash
  * table
  * @bat_priv: the bat priv with all the soft interface information
- * @ip: search key
+ * @data: search key
+ * @data_type: type of data
  * @vid: VLAN identifier
  *
  * Returns the dat_entry if found, NULL otherwise.
  */
 static struct batadv_dat_entry *
-batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
-			   unsigned short vid)
+batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *data,
+			   uint8_t data_type, unsigned short vid)
 {
 	struct hlist_head *head;
 	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp = NULL;
 	struct batadv_hashtable *hash = bat_priv->dat.hash;
-	uint32_t index;
+	uint32_t index, data_size = batadv_dat_types_info[data_type].size;
 
 	if (!hash)
 		return NULL;
 
-	to_find.ip = ip;
+	to_find.data = kmalloc(data_size, GFP_ATOMIC);
+	if (!to_find.data)
+		return NULL;
+	memcpy(to_find.data, data, data_size);
+	to_find.type = data_type;
 	to_find.vid = vid;
 
 	index = batadv_hash_dat(&to_find, hash->size);
 	head = &hash->table[index];
+	kfree(to_find.data);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
-		if (dat_entry->ip != ip)
+		if (dat_entry->type != data_type)
+			continue;
+		if (memcmp(dat_entry->data, data, data_size))
 			continue;
 
 		if (!atomic_inc_not_zero(&dat_entry->refcount))
@@ -265,25 +320,30 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 /**
  * batadv_dat_entry_add - add a new dat entry or update it if already exists
  * @bat_priv: the bat priv with all the soft interface information
- * @ip: ipv4 to add/edit
- * @mac_addr: mac address to assign to the given ipv4
+ * @data: the data to add/edit
+ * @data_type: type of the data added to DAT
+ * @mac_addr: mac address to assign to the given data
  * @vid: VLAN identifier
  */
-static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 uint8_t *mac_addr, unsigned short vid)
+static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *data,
+				 uint8_t data_type, uint8_t *mac_addr,
+				 unsigned short vid)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
+	size_t data_size = batadv_dat_types_info[data_type].size;
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, data, data_type, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
-		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM (vid: %u)\n",
-			   &dat_entry->ip, dat_entry->mac_addr, vid);
+		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Entry updated: %s %pM (vid: %u)\n",
+			   batadv_dat_data_to_str(dat_entry->data, data_type,
+						  dbg_data, sizeof(dbg_data)),
+			   dat_entry->mac_addr, vid);
 		goto out;
 	}
 
@@ -291,7 +351,12 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	if (!dat_entry)
 		goto out;
 
-	dat_entry->ip = ip;
+	dat_entry->data = kmalloc(data_size, GFP_ATOMIC);
+	if (!dat_entry->data)
+		goto out;
+	memcpy(dat_entry->data, data, data_size);
+
+	dat_entry->type = data_type;
 	dat_entry->vid = vid;
 	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 	dat_entry->last_update = jiffies;
@@ -307,8 +372,10 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %u)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, vid);
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %s %pM (vid: %u)\n",
+		   batadv_dat_data_to_str(dat_entry->data, data_type,
+					  dbg_data, sizeof(dbg_data)),
+		   dat_entry->mac_addr, vid);
 
 out:
 	if (dat_entry)
@@ -520,7 +587,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * batadv_dat_select_candidates - select the nodes which the DHT message has to
  * be sent to
  * @bat_priv: the bat priv with all the soft interface information
- * @ip_dst: ipv4 to look up in the DHT
+ * @data: data to look up in the DHT
+ * @data_type: type of data
  *
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (from the LEFT, with wrap around if needed) then the hash
@@ -529,11 +597,15 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
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
+	struct batadv_dat_entry to_find;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
+	size_t data_size = batadv_dat_types_info[data_type].size;
 
 	if (!bat_priv->orig_hash)
 		return NULL;
@@ -542,15 +614,23 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;
 
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
-						    BATADV_DAT_ADDR_MAX);
+	to_find.data = kmalloc(data_size, GFP_ATOMIC);
+	if (!to_find.data)
+		return NULL;
+	memcpy(to_find.data, data, data_size);
+	to_find.type = data_type;
+	data_key = (batadv_dat_addr_t)batadv_hash_dat(&to_find,
+						      BATADV_DAT_ADDR_MAX);
+	kfree(to_find.data);
 
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
@@ -560,7 +640,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  * batadv_dat_send_data - send a payload to the selected candidates
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
- * @ip: the DHT key
+ * @data: the DHT key
+ * @data_type: type of data
  * @packet_subtype: unicast4addr packet subtype to use
  *
  * This function copies the skb with pskb_copy() and is sent as unicast packet
@@ -570,8 +651,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
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
@@ -579,12 +660,15 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
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
@@ -754,6 +838,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	unsigned long last_seen_jiffies;
 	int last_seen_msecs, last_seen_secs, last_seen_mins;
 	uint32_t i;
+	char dbg_data[BATADV_DAT_DATA_MAX_LEN];
 
 	primary_if = batadv_seq_print_text_primary_if_get(seq);
 	if (!primary_if)
@@ -774,8 +859,12 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;
 
-			seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
-				   &dat_entry->ip, dat_entry->mac_addr,
+			seq_printf(seq, " * %15s %14pM %6i:%02i\n",
+				   batadv_dat_data_to_str(dat_entry->data,
+							  dat_entry->type,
+							  dbg_data,
+							  sizeof(dbg_data)),
+				   dat_entry->mac_addr,
 				   last_seen_mins, last_seen_secs);
 		}
 		rcu_read_unlock();
@@ -926,9 +1015,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, 0);
 	ip_dst = batadv_arp_ip_dst(skb, 0);
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4, vid);
 	if (dat_entry) {
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
@@ -962,7 +1052,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		ret = true;
 	} else {
 		/* Send the request to the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
+		ret = batadv_dat_send_data(bat_priv, skb, &ip_dst,
+					   BATADV_DAT_IPV4,
 					   BATADV_P_DAT_DHT_GET);
 	}
 out:
@@ -1008,9 +1099,10 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
 		       "Parsing incoming ARP REQUEST");
 
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
 
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4, vid);
 	if (!dat_entry)
 		goto out;
 
@@ -1074,14 +1166,16 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
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
@@ -1119,8 +1213,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst, vid);
+	batadv_dat_entry_add(bat_priv, &ip_src, BATADV_DAT_IPV4, hw_src, vid);
+	batadv_dat_entry_add(bat_priv, &ip_dst, BATADV_DAT_IPV4, hw_dst, vid);
 
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
@@ -1167,7 +1261,8 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 		goto out;
 
 	ip_dst = batadv_arp_ip_dst(forw_packet->skb, hdr_size);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, &ip_dst,
+					       BATADV_DAT_IPV4, vid);
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
index 20a1bef..69c187e 100644
--- a/types.h
+++ b/types.h
@@ -931,7 +931,8 @@ struct batadv_algo_ops {
 /**
  * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
  * is used to stored ARP entries needed for the global DAT cache
- * @ip: the IPv4 corresponding to this DAT/ARP entry
+ * @data: the data corresponding to this DAT entry
+ * @type: the type corresponding to this DAT entry
  * @mac_addr: the MAC address associated to the stored IPv4
  * @vid: the vlan ID associated to this entry
  * @last_update: time in jiffies when this entry was refreshed last time
@@ -940,7 +941,8 @@ struct batadv_algo_ops {
  * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_dat_entry {
-	__be32 ip;
+	void *data;
+	uint8_t type;
 	uint8_t mac_addr[ETH_ALEN];
 	unsigned short vid;
 	unsigned long last_update;
@@ -950,6 +952,24 @@ struct batadv_dat_entry {
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
+ * batadv_dat_type_info - info needed for a DAT type data
+ * @size: the size of the type data
+ * @str_fmt: string format used by the data
+ */
+struct batadv_dat_type_info {
+	size_t size;
+	char *str_fmt;
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4

