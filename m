Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
Date: Sat, 9 Mar 2013 19:40:48 +0200
Message-ID: <CAP5XTDM0KWS4c=0Z_KO=AdFh9rBDo_AOz553bstFk0FQRuWA0Q@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Modified DAT structures and
 functions in order to support both IPv4 and IPv6
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Subject: [RFC] batman-adv: Modified DAT structures and functions in order
 to support both IPv4 and IPv6

In order to support DHT for IPv6 there was needed a general implementation for
the IP field in distributed-arp-table.c (now the IP is __be32 and this patch
will transform it to unsigned char *). Distinction between types is done
using a new enum.

Also all functions were changed to support this.

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>

---
 distributed-arp-table.c |  234 ++++++++++++++++++++++++++++++++++++-----------
 types.h                 |   21 ++++-
 2 files changed, 197 insertions(+), 58 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 9215caa..ed6e817 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -20,6 +20,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <net/arp.h>
+#include <net/ipv6.h>

 #include "main.h"
 #include "hash.h"
@@ -31,6 +32,36 @@
 #include "translation-table.h"
 #include "unicast.h"

+/* Prints similar debug message for IPv4 and IPv6.
+ * At list one variable parameter should be the IP itself, and it should
+ * be placed correctly based on format prefix and format suffix arguments.
+ */
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
+#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
+			       format_suffix, ...) \
+		{ \
+		switch (ip_type) { \
+		case BATADV_DAT_IPv4: \
+			batadv_dbg(BATADV_DBG_DAT, bat_priv, \
+				   format_prefix "%pI4" format_suffix, \
+					__VA_ARGS__); \
+			break; \
+		case BATADV_DAT_IPv6: \
+			batadv_dbg(BATADV_DBG_DAT, bat_priv, \
+				   format_prefix "%pI6c" format_suffix, \
+					__VA_ARGS__); \
+			break; \
+		} \
+		}
+
+#else
+
+#define batadv_dat_dbg_ip(bat_priv, ip_type, format_prefix, \
+			       format_suffix, ...) /* do nothing */
+
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+
 static void batadv_dat_purge(struct work_struct *work);

 /**
@@ -47,12 +78,14 @@ static void batadv_dat_start_timer(struct
batadv_priv *bat_priv)
 /**
  * batadv_dat_entry_free_ref - decrements the dat_entry refcounter and possibly
  * free it
- * @dat_entry: the oentry to free
+ * @dat_entry: the entry to free
  */
 static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
 {
-	if (atomic_dec_and_test(&dat_entry->refcount))
+	if (atomic_dec_and_test(&dat_entry->refcount)) {
+		kfree(dat_entry->ip);
 		kfree_rcu(dat_entry, rcu);
+	}
 }

 /**
@@ -130,18 +163,50 @@ static void batadv_dat_purge(struct work_struct *work)
 }

 /**
+ * batadv_sizeof_ip - gets sizeof IP based on its type (IPv4 / IPv6)
+ * @ip_type: type of IP address
+ *
+ * Returns sizeof IP, or sizeof IPv4 if @ip_type is invalid
+ */
+static size_t batadv_sizeof_ip(uint8_t ip_type)
+{
+	switch (ip_type) {
+	case BATADV_DAT_IPv4:
+		return sizeof(__be32);
+	case BATADV_DAT_IPv6:
+		return sizeof(struct in6_addr);
+	default:
+		return sizeof(__be32); /* fallback to IPv4 */
+	}
+}
+
+/**
  * batadv_compare_dat - comparing function used in the local DAT hash table
  * @node: node in the local table
  * @data2: second object to compare the node to
+ * @ip_type: type of IP address
  *
  * Returns 1 if the two entry are the same, 0 otherwise
  */
-static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
+static int batadv_compare_dat(const struct hlist_node *node, const void *data2,
+			       uint8_t ip_type)
 {
 	const void *data1 = container_of(node, struct batadv_dat_entry,
 					 hash_entry);
+	size_t ip_size = batadv_sizeof_ip(ip_type);
+	return (memcmp(data1, data2, ip_size) == 0 ? 1 : 0);
+}

-	return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
+static int batadv_compare_dat_ipv4(const struct hlist_node *node,
+			       const void *data2)
+{
+	return batadv_compare_dat(node, data2, BATADV_DAT_IPv4);
+}
+
+static int batadv_compare_dat_ipv6(const struct hlist_node *node,
+			       const void *data2)
+{
+	return batadv_compare_dat(node, data2, BATADV_DAT_IPv6);
 }

 /**
@@ -201,16 +266,19 @@ static __be32 batadv_arp_ip_dst(struct sk_buff
*skb, int hdr_size)
  * batadv_hash_dat - compute the hash value for an IP address
  * @data: data to hash
  * @size: size of the hash table
+ * @type: type of IP address
  *
  * Returns the selected index in the hash table for the given data
  */
-static uint32_t batadv_hash_dat(const void *data, uint32_t size)
+static uint32_t batadv_hash_dat(const void *data, uint32_t size,
+			       uint8_t ip_type)
 {
 	const unsigned char *key = data;
 	uint32_t hash = 0;
-	size_t i;
+	size_t i, ip_size;

-	for (i = 0; i < 4; i++) {
+	ip_size = batadv_sizeof_ip(ip_type);
+	for (i = 0; i < ip_size; i++) {
 		hash += key[i];
 		hash += (hash << 10);
 		hash ^= (hash >> 6);
@@ -223,32 +291,46 @@ static uint32_t batadv_hash_dat(const void
*data, uint32_t size)
 	return hash % size;
 }

+static uint32_t batadv_hash_dat_ipv4(const void *data, uint32_t size)
+{
+	return batadv_hash_dat(data, size, BATADV_DAT_IPv4);
+}
+
+static uint32_t batadv_hash_dat_ipv6(const void *data, uint32_t size)
+{
+	return batadv_hash_dat(data, size, BATADV_DAT_IPv6);
+}
+
 /**
  * batadv_dat_entry_hash_find - looks for a given dat_entry in the local hash
  * table
  * @bat_priv: the bat priv with all the soft interface information
  * @ip: search key
+ * @type: type of IP address
  *
  * Returns the dat_entry if found, NULL otherwise
  */
 static struct batadv_dat_entry *
-batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
+batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, unsigned char *ip,
+			       uint8_t ip_type)
 {
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_dat_entry *dat_entry, *dat_entry_tmp = NULL;
 	struct batadv_hashtable *hash = bat_priv->dat.hash;
 	uint32_t index;
+	size_t ip_size;

 	if (!hash)
 		return NULL;

-	index = batadv_hash_dat(&ip, hash->size);
+	ip_size = batadv_sizeof_ip(ip_type);
+	index = batadv_hash_dat(ip, hash->size, ip_type);
 	head = &hash->table[index];

 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, node, head, hash_entry) {
-		if (dat_entry->ip != ip)
+		if (memcmp(dat_entry->ip, ip, ip_size))
 			continue;

 		if (!atomic_inc_not_zero(&dat_entry->refcount))
@@ -265,24 +347,26 @@ batadv_dat_entry_hash_find(struct batadv_priv
*bat_priv, __be32 ip)
 /**
  * batadv_dat_entry_add - add a new dat entry or update it if already exists
  * @bat_priv: the bat priv with all the soft interface information
- * @ip: ipv4 to add/edit
+ * @ip: IP to add/edit
+ * @ip_type: type of IP address
  * @mac_addr: mac address to assign to the given ipv4
  */
-static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
-				 uint8_t *mac_addr)
+static void batadv_dat_entry_add(struct batadv_priv *bat_priv,
+			unsigned char *ip, uint8_t ip_type, uint8_t *mac_addr)
 {
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
+	size_t ip_size;

-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, ip_type);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
 		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
-		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM\n", &dat_entry->ip,
-			   dat_entry->mac_addr);
+
+		batadv_dat_dbg_ip(bat_priv, ip_type, "Entry updated: ",
+			" %pM\n", dat_entry->ip, dat_entry->mac_addr);
 		goto out;
 	}

@@ -290,14 +374,32 @@ static void batadv_dat_entry_add(struct
batadv_priv *bat_priv, __be32 ip,
 	if (!dat_entry)
 		goto out;

-	dat_entry->ip = ip;
+	ip_size = batadv_sizeof_ip(ip_type);
+	dat_entry->ip = kmalloc(ip_size, GFP_ATOMIC);
+	if (!dat_entry->ip)
+		goto out;
+	memcpy(dat_entry->ip, ip, ip_size);
+	dat_entry->type = ip_type;
+
 	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);

-	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
-				     batadv_hash_dat, &dat_entry->ip,
-				     &dat_entry->hash_entry);
+	switch (ip_type) {
+	case BATADV_DAT_IPv4:
+		hash_added = batadv_hash_add(bat_priv->dat.hash,
+				batadv_compare_dat_ipv4, batadv_hash_dat_ipv4,
+				dat_entry->ip, &dat_entry->hash_entry);
+		break;
+	case BATADV_DAT_IPv6:
+		hash_added = batadv_hash_add(bat_priv->dat.hash,
+				batadv_compare_dat_ipv6, batadv_hash_dat_ipv6,
+				dat_entry->ip, &dat_entry->hash_entry);
+		break;
+	default:
+		hash_added = 1; /* In order to catch next if */
+		break;
+	}

 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
@@ -305,8 +407,8 @@ static void batadv_dat_entry_add(struct
batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}

-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
-		   &dat_entry->ip, dat_entry->mac_addr);
+	batadv_dat_dbg_ip(bat_priv, ip_type, "New entry added: ", " %pM\n",
+			dat_entry->ip, dat_entry->mac_addr);

 out:
 	if (dat_entry)
@@ -517,7 +619,8 @@ static void batadv_choose_next_candidate(struct
batadv_priv *bat_priv,
  * batadv_dat_select_candidates - selects the nodes which the DHT
message has to
  * be sent to
  * @bat_priv: the bat priv with all the soft interface information
- * @ip_dst: ipv4 to look up in the DHT
+ * @ip_dst: IP to look up in the DHT
+ * @ip_type: type of IP address
  *
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (from the LEFT, with wrap around if needed) then the hash
@@ -526,7 +629,8 @@ static void batadv_choose_next_candidate(struct
batadv_priv *bat_priv,
  * Returns the candidate array of size BATADV_DAT_CANDIDATE_NUM
  */
 static struct batadv_dat_candidate *
-batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
+batadv_dat_select_candidates(struct batadv_priv *bat_priv,
+					 unsigned char *ip_dst, uint8_t ip_type)
 {
 	int select;
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
@@ -539,12 +643,11 @@ batadv_dat_select_candidates(struct batadv_priv
*bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;

-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
-						    BATADV_DAT_ADDR_MAX);
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat(ip_dst,
+			BATADV_DAT_ADDR_MAX, ip_type);

-	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
-		   ip_key);
+	batadv_dat_dbg_ip(bat_priv, ip_type, "dat_select_candidates(): IP=",
+			" hash(IP)=%u\n", ip_dst, ip_key);

 	for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
 		batadv_choose_next_candidate(bat_priv, res, select, ip_key,
@@ -558,6 +661,7 @@ batadv_dat_select_candidates(struct batadv_priv
*bat_priv, __be32 ip_dst)
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @ip: the DHT key
+ * @ip_type: type of IP address
  * @packet_subtype: unicast4addr packet subtype to use
  *
  * In this function the skb is copied by means of pskb_copy() and is sent as
@@ -566,8 +670,8 @@ batadv_dat_select_candidates(struct batadv_priv
*bat_priv, __be32 ip_dst)
  * Returns true if the packet is sent to at least one candidate,
false otherwise
  */
 static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
-				 struct sk_buff *skb, __be32 ip,
-				 int packet_subtype)
+				 struct sk_buff *skb, unsigned char *ip,
+				 uint8_t ip_type, int packet_subtype)
 {
 	int i;
 	bool ret = false;
@@ -576,11 +680,12 @@ static bool batadv_dat_send_data(struct
batadv_priv *bat_priv,
 	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;

-	cand = batadv_dat_select_candidates(bat_priv, ip);
+	cand = batadv_dat_select_candidates(bat_priv, (unsigned char *)ip,
+			ip_type);
 	if (!cand)
 		goto out;

-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
+	batadv_dat_dbg_ip(bat_priv, ip_type, "DHT_SEND for ", "\n", ip);

 	for (i = 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
 		if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
@@ -697,8 +802,8 @@ int batadv_dat_cache_seq_print_text(struct
seq_file *seq, void *offset)
 		goto out;

 	seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
-	seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
-		   "last-seen");
+	seq_printf(seq, "                       %-26s %-15s %5s\n",
+		"IPv4/IPv6", "MAC", "last-seen");

 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -711,9 +816,18 @@ int batadv_dat_cache_seq_print_text(struct
seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;

-			seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
-				   &dat_entry->ip, dat_entry->mac_addr,
-				   last_seen_mins, last_seen_secs);
+			switch (dat_entry->type) {
+			case BATADV_DAT_IPv4:
+				seq_printf(seq, " * %-40pI4 %15pM %6i:%02i\n",
+					   dat_entry->ip, dat_entry->mac_addr,
+					   last_seen_mins, last_seen_secs);
+				break;
+			case BATADV_DAT_IPv6:
+				seq_printf(seq, " * %-40pI6c %15pM %6i:%02i\n",
+					   dat_entry->ip, dat_entry->mac_addr,
+					   last_seen_mins, last_seen_secs);
+				break;
+			}
 		}
 		rcu_read_unlock();
 	}
@@ -836,9 +950,12 @@ bool batadv_dat_snoop_outgoing_arp_request(struct
batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, 0);
 	ip_dst = batadv_arp_ip_dst(skb, 0);

-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_src,
+			BATADV_DAT_IPv4, hw_src);

-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv,
+			(unsigned char *)&ip_dst,
+			BATADV_DAT_IPv4);
 	if (dat_entry) {
 		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
 				     bat_priv->soft_iface, ip_dst, hw_src,
@@ -854,12 +971,14 @@ bool
batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		bat_priv->soft_iface->last_rx = jiffies;

 		netif_rx(skb_new);
-		batadv_dbg(BATADV_DBG_DAT, bat_priv, "ARP request replied locally\n");
+		batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				"ARP request replied locally\n");
 		ret = true;
 	} else {
 		/* Send the request on the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
-					   BATADV_P_DAT_DHT_GET);
+		ret = batadv_dat_send_data(bat_priv, skb,
+				(unsigned char *)&ip_dst, BATADV_DAT_IPv4,
+				BATADV_P_DAT_DHT_GET);
 	}
 out:
 	if (dat_entry)
@@ -901,9 +1020,11 @@ bool
batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
 		       "Parsing incoming ARP REQUEST");

-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_src,
+			BATADV_DAT_IPv4, hw_src);

-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv,
+			(unsigned char *)&ip_dst, BATADV_DAT_IPv4);
 	if (!dat_entry)
 		goto out;

@@ -963,14 +1084,18 @@ void batadv_dat_snoop_outgoing_arp_reply(struct
batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, 0);
 	ip_dst = batadv_arp_ip_dst(skb, 0);

-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_src,
+			BATADV_DAT_IPv4, hw_src);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_dst,
+			BATADV_DAT_IPv4, hw_dst);

 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node got within the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, ip_src, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, (unsigned char *)&ip_src,
+			BATADV_DAT_IPv4, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, (unsigned char *)&ip_dst,
+			BATADV_DAT_IPv4, BATADV_P_DAT_DHT_PUT);
 }
 /**
  * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
@@ -1005,8 +1130,10 @@ bool batadv_dat_snoop_incoming_arp_reply(struct
batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_src,
+			BATADV_DAT_IPv4, hw_src);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_dst,
+			BATADV_DAT_IPv4, hw_dst);

 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
@@ -1050,7 +1177,8 @@ bool batadv_dat_drop_broadcast_packet(struct
batadv_priv *bat_priv,
 		goto out;

 	ip_dst = batadv_arp_ip_dst(forw_packet->skb, bcast_len);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv,
+			(unsigned char *)&ip_dst, BATADV_DAT_IPv4);
 	/* check if the node already got this entry */
 	if (!dat_entry) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
diff --git a/types.h b/types.h
index aba8364..cbc4220 100644
--- a/types.h
+++ b/types.h
@@ -959,17 +959,18 @@ struct batadv_algo_ops {
 };

 /**
- * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
- * is used to stored ARP entries needed for the global DAT cache
- * @ip: the IPv4 corresponding to this DAT/ARP entry
- * @mac_addr: the MAC address associated to the stored IPv4
+ * struct batadv_dat_entry - it is a single entry of batman-adv
ARP/NDP backend. It
+ * is used to stored ARP/NDP entries needed for the global DAT cache
+ * @ip: the IPv4 / IPv6 corresponding to this DAT ARP/NDP entry
+ * @mac_addr: the MAC address associated to the stored @ip
  * @last_update: time in jiffies when this entry was refreshed last time
  * @hash_entry: hlist node for batadv_priv_dat::hash
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
 struct batadv_dat_entry {
-	__be32 ip;
+	unsigned char *ip;
+	uint8_t type;
 	uint8_t mac_addr[ETH_ALEN];
 	unsigned long last_update;
 	struct hlist_node hash_entry;
@@ -978,6 +979,16 @@ struct batadv_dat_entry {
 };

 /**
+ * batadv_dat_types - types used in batadv_dat_entry for IP
+ * @BATADV_DAT_IPv4: IPv4 address type
+ * @BATADV_DAT_IPv6: IPv6 address type
+ */
+enum batadv_dat_types {
+	BATADV_DAT_IPv4,
+	BATADV_DAT_IPv6,
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4
