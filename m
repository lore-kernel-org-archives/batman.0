Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
Date: Mon, 18 Mar 2013 14:07:42 +0200
Message-ID: <CAP5XTDPibzzo_wLjXOsT07JnwNM_YTioxXdwo2bcDuAb0021xA@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [RFCv2] batman-adv: Modified DAT structures and
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

Subject: [RFCv2] batman-adv: Modified DAT structures and functions in order
 to support both IPv4 and IPv6

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>

---

Modified the debug message macro to a function and made it more generic
(in order to support seq_printf too).
Added IPv6 macros in order to NOT add IPv6 dependent code if support
is disabled. Also, removed as many switch-cases as possible to have less
"if defined(IPv6)" tests.
Added call_rcu for kfree dat_entry.
For compare function, test if both data fields have the same type.

 distributed-arp-table.c |  338 +++++++++++++++++++++++++++++++++++++++--------
 types.h                 |   23 +++-
 2 files changed, 301 insertions(+), 60 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 3a3e1d8..30b683e 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -20,6 +20,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <net/arp.h>
+#include <net/ipv6.h>

 #include "main.h"
 #include "hash.h"
@@ -31,6 +32,115 @@
 #include "translation-table.h"
 #include "unicast.h"

+/**
+ * batadv_dat_ip_format_string - construct a generic ip format string
+ * for printing
+ * @ip_type: IPv4 / IPv6 address
+ * @format_prefix: format before IP field
+ * @format_suffix: format after IP field
+ * @width: padding blank spaces for IP field or 0 if none
+ *
+ * format_string is allocated dynamically. It should be kfree when
+ * there is no more need for it.
+ *
+ * Returns the format string with an IP field inside, or NULL
+ * if allocation failed.
+ */
+static char *batadv_dat_ip_format_string(uint8_t ip_type,
+		char *format_prefix, char *format_suffix, int width)
+{
+	char *format_string, *tmp_string;
+	char ipv4[] = "pI4", ipv6[] = "pI6c";
+	int width_length = 0, tmp_witdh = width;
+	int ipv4_len = strlen(ipv4), ipv6_len = strlen(ipv6);
+	int ip_str_size = (ipv4_len > ipv6_len) ? ipv4_len : ipv6_len;
+
+	/* calculate number of chars need for width */
+	if (tmp_witdh < 0) {
+		width_length++;
+		tmp_witdh *= -1;
+	}
+	while (tmp_witdh > 0) {
+		width_length++;
+		tmp_witdh /= 10;
+	}
+
+	/* construct format string */
+	format_string = kmalloc(strlen(format_prefix) + width_length +
+					ip_str_size + strlen(format_suffix) +
+					2, /* "%" and NULL chars */
+				GFP_ATOMIC);
+	if (!format_string)
+		goto out;
+
+	tmp_string = format_string;
+	sprintf(tmp_string, "%s%%", format_prefix);
+	tmp_string += strlen(tmp_string);
+	if (width != 0) {
+		sprintf(tmp_string, "%i", width);
+		tmp_string += strlen(tmp_string);
+	}
+
+	switch (ip_type) {
+	case BATADV_DAT_IPV4:
+		sprintf(tmp_string, "%s%s", ipv4, format_suffix);
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case BATADV_DAT_IPV6:
+		sprintf(tmp_string, "%s%s", ipv6, format_suffix);
+		break;
+#endif
+	default:
+		goto out;
+	}
+
+	return format_string;
+out:
+	kfree(format_string);
+	return NULL;
+}
+
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+
+/* batadv_dat_dbg_ip - print similar debug message for IPv4 and IPv6.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ip_type: IPv4 / IPv6 address
+ * @format_prefix: format before IP field
+ * @format_suffix: format after IP field
+ *
+ * At list one variable parameter should be the IP itself, and it should
+ * be placed correctly based on format prefix and format suffix arguments.
+ */
+static void batadv_dat_dbg_ip(struct batadv_priv *bat_priv,
+			uint8_t ip_type, char *format_prefix,
+			char *format_suffix, ...)
+{
+	va_list arg_va_list;
+	char *format_string;
+
+	va_start(arg_va_list, format_suffix);
+
+	format_string = batadv_dat_ip_format_string(ip_type,
+			format_prefix, format_suffix, 0);
+	if (format_string) {
+		batadv_dbg(BATADV_DBG_DAT, bat_priv, format_string,
+			arg_va_list);
+		kfree(format_string);
+	}
+
+	va_end(arg_va_list);
+}
+
+#else
+
+static void batadv_dat_dbg_ip(struct batadv_priv *bat_priv,
+			uint8_t ip_type, char *format_prefix,
+			char *format_suffix, ...)
+{
+}
+
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+
 static void batadv_dat_purge(struct work_struct *work);

 /**
@@ -45,6 +155,19 @@ static void batadv_dat_start_timer(struct
batadv_priv *bat_priv)
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
+	kfree(dat_entry->ip);
+	kfree(dat_entry);
+}
+
+/**
  * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and possibly
  * free it
  * @dat_entry: the entry to free
@@ -52,7 +175,7 @@ static void batadv_dat_start_timer(struct
batadv_priv *bat_priv)
 static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
 {
 	if (atomic_dec_and_test(&dat_entry->refcount))
-		kfree_rcu(dat_entry, rcu);
+		call_rcu(&dat_entry->rcu, batadv_dat_entry_free_ref_rcu);
 }

 /**
@@ -130,19 +253,62 @@ static void batadv_dat_purge(struct work_struct *work)
 }

 /**
+ * batadv_sizeof_ip - get sizeof IP based on its type (IPv4 / IPv6)
+ * @ip_type: type of IP address
+ *
+ * Returns sizeof IP, or sizeof IPv4 if ip_type is invalid.
+ */
+static size_t batadv_sizeof_ip(uint8_t ip_type)
+{
+	switch (ip_type) {
+	case BATADV_DAT_IPV4:
+		return sizeof(__be32);
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case BATADV_DAT_IPV6:
+		return sizeof(struct in6_addr);
+#endif
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
  * Returns 1 if the two entries are the same, 0 otherwise.
  */
-static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
+static int batadv_compare_dat(const struct hlist_node *node, const void *data2,
+			       uint8_t ip_type)
 {
-	const void *data1 = container_of(node, struct batadv_dat_entry,
-					 hash_entry);
+	struct batadv_dat_entry *dat_entry1 = container_of(node,
+				struct batadv_dat_entry, hash_entry);
+	struct batadv_dat_entry *dat_entry2 = container_of(data2,
+				struct batadv_dat_entry, ip);
+	size_t ip_size;

-	return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
+	if (dat_entry1->type != dat_entry2->type)
+		return 0;
+
+	ip_size = batadv_sizeof_ip(ip_type);
+	return (memcmp(dat_entry1->ip, dat_entry2->ip, ip_size) == 0 ? 1 : 0);
+}
+
+static int batadv_compare_dat_ipv4(const struct hlist_node *node,
+			       const void *data2)
+{
+	return batadv_compare_dat(node, data2, BATADV_DAT_IPV4);
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+static int batadv_compare_dat_ipv6(const struct hlist_node *node,
+			       const void *data2)
+{
+	return batadv_compare_dat(node, data2, BATADV_DAT_IPV6);
 }
+#endif

 /**
  * batadv_arp_hw_src - extract the hw_src field from an ARP packet
@@ -201,16 +367,19 @@ static __be32 batadv_arp_ip_dst(struct sk_buff
*skb, int hdr_size)
  * batadv_hash_dat - compute the hash value for an IP address
  * @data: data to hash
  * @size: size of the hash table
+ * @ip_type: type of IP address
  *
  * Returns the selected index in the hash table for the given data.
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
@@ -223,31 +392,47 @@ static uint32_t batadv_hash_dat(const void
*data, uint32_t size)
 	return hash % size;
 }

+static uint32_t batadv_hash_dat_ipv4(const void *data, uint32_t size)
+{
+	return batadv_hash_dat(data, size, BATADV_DAT_IPV4);
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+static uint32_t batadv_hash_dat_ipv6(const void *data, uint32_t size)
+{
+	return batadv_hash_dat(data, size, BATADV_DAT_IPV6);
+}
+#endif
+
 /**
  * batadv_dat_entry_hash_find - look for a given dat_entry in the local hash
  * table
  * @bat_priv: the bat priv with all the soft interface information
  * @ip: search key
+ * @ip_type: type of IP address
  *
  * Returns the dat_entry if found, NULL otherwise.
  */
 static struct batadv_dat_entry *
-batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
+batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, unsigned char *ip,
+			       uint8_t ip_type)
 {
 	struct hlist_head *head;
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
 	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
-		if (dat_entry->ip != ip)
+		if (memcmp(dat_entry->ip, ip, ip_size))
 			continue;

 		if (!atomic_inc_not_zero(&dat_entry->refcount))
@@ -264,24 +449,26 @@ batadv_dat_entry_hash_find(struct batadv_priv
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

@@ -289,14 +476,34 @@ static void batadv_dat_entry_add(struct
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
+	case BATADV_DAT_IPV4:
+		hash_added = batadv_hash_add(bat_priv->dat.hash,
+				batadv_compare_dat_ipv4, batadv_hash_dat_ipv4,
+				dat_entry->ip, &dat_entry->hash_entry);
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case BATADV_DAT_IPV6:
+		hash_added = batadv_hash_add(bat_priv->dat.hash,
+				batadv_compare_dat_ipv6, batadv_hash_dat_ipv6,
+				dat_entry->ip, &dat_entry->hash_entry);
+		break;
+#endif
+	default:
+		hash_added = 1; /* in order to catch next if */
+		break;
+	}

 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
@@ -304,9 +511,8 @@ static void batadv_dat_entry_add(struct
batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}

-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
-		   &dat_entry->ip, dat_entry->mac_addr);
-
+	batadv_dat_dbg_ip(bat_priv, ip_type, "New entry added: ", " %pM\n",
+			dat_entry->ip, dat_entry->mac_addr);
 out:
 	if (dat_entry)
 		batadv_dat_entry_free_ref(dat_entry);
@@ -513,7 +719,8 @@ static void batadv_choose_next_candidate(struct
batadv_priv *bat_priv,
  * batadv_dat_select_candidates - select the nodes which the DHT message has to
  * be sent to
  * @bat_priv: the bat priv with all the soft interface information
- * @ip_dst: ipv4 to look up in the DHT
+ * @ip_dst: IP to look up in the DHT
+ * @ip_type: type of IP address
  *
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (from the LEFT, with wrap around if needed) then the hash
@@ -522,7 +729,8 @@ static void batadv_choose_next_candidate(struct
batadv_priv *bat_priv,
  * Returns the candidate array of size BATADV_DAT_CANDIDATE_NUM.
  */
 static struct batadv_dat_candidate *
-batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
+batadv_dat_select_candidates(struct batadv_priv *bat_priv,
+				 unsigned char *ip_dst, uint8_t ip_type)
 {
 	int select;
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
@@ -535,12 +743,11 @@ batadv_dat_select_candidates(struct batadv_priv
*bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;

-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
-						    BATADV_DAT_ADDR_MAX);
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat(ip_dst,
+					BATADV_DAT_ADDR_MAX, ip_type);

-	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-		   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
-		   ip_key);
+	batadv_dat_dbg_ip(bat_priv, ip_type, "dat_select_candidates(): IP=",
+			" hash(IP)=%u\n", ip_dst, ip_key);

 	for (select = 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
 		batadv_choose_next_candidate(bat_priv, res, select, ip_key,
@@ -554,6 +761,7 @@ batadv_dat_select_candidates(struct batadv_priv
*bat_priv, __be32 ip_dst)
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @ip: the DHT key
+ * @ip_type: type of IP address
  * @packet_subtype: unicast4addr packet subtype to use
  *
  * This function copies the skb with pskb_copy() and is sent as unicast packet
@@ -563,8 +771,8 @@ batadv_dat_select_candidates(struct batadv_priv
*bat_priv, __be32 ip_dst)
  * otherwise.
  */
 static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
-				 struct sk_buff *skb, __be32 ip,
-				 int packet_subtype)
+				 struct sk_buff *skb, unsigned char *ip,
+				 uint8_t ip_type, int packet_subtype)
 {
 	int i;
 	bool ret = false;
@@ -573,11 +781,11 @@ static bool batadv_dat_send_data(struct
batadv_priv *bat_priv,
 	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;

-	cand = batadv_dat_select_candidates(bat_priv, ip);
+	cand = batadv_dat_select_candidates(bat_priv, ip, ip_type);
 	if (!cand)
 		goto out;

-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
+	batadv_dat_dbg_ip(bat_priv, ip_type, "DHT_SEND for ", "\n", ip);

 	for (i = 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
 		if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
@@ -685,6 +893,7 @@ int batadv_dat_cache_seq_print_text(struct
seq_file *seq, void *offset)
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
 	unsigned long last_seen_jiffies;
+	char *format_string;
 	int last_seen_msecs, last_seen_secs, last_seen_mins;
 	uint32_t i;

@@ -693,8 +902,8 @@ int batadv_dat_cache_seq_print_text(struct
seq_file *seq, void *offset)
 		goto out;

 	seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
-	seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
-		   "last-seen");
+	seq_printf(seq, "                       %-26s %-15s %5s\n",
+		"IPv4/IPv6", "MAC", "last-seen");

 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -707,9 +916,16 @@ int batadv_dat_cache_seq_print_text(struct
seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;

-			seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
-				   &dat_entry->ip, dat_entry->mac_addr,
-				   last_seen_mins, last_seen_secs);
+			format_string =
+				batadv_dat_ip_format_string(dat_entry->type,
+					" * ", " %15pM %6i:%02i\n", -40);
+			if (format_string) {
+				seq_printf(seq, format_string, dat_entry->ip,
+						dat_entry->mac_addr,
+						last_seen_mins,
+						last_seen_secs);
+				kfree(format_string);
+			}
 		}
 		rcu_read_unlock();
 	}
@@ -830,9 +1046,11 @@ bool
batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	hw_src = batadv_arp_hw_src(skb, 0);
 	ip_dst = batadv_arp_ip_dst(skb, 0);

-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_src,
+			BATADV_DAT_IPV4, hw_src);

-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv,
+			(unsigned char *)&ip_dst, BATADV_DAT_IPV4);
 	if (dat_entry) {
 		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
 				     bat_priv->soft_iface, ip_dst, hw_src,
@@ -851,9 +1069,10 @@ bool
batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		batadv_dbg(BATADV_DBG_DAT, bat_priv, "ARP request replied locally\n");
 		ret = true;
 	} else {
-		/* Send the request to the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
-					   BATADV_P_DAT_DHT_GET);
+		/* Send the request on the DHT */
+		ret = batadv_dat_send_data(bat_priv, skb,
+				(unsigned char *)&ip_dst, BATADV_DAT_IPV4,
+				BATADV_P_DAT_DHT_GET);
 	}
 out:
 	if (dat_entry)
@@ -895,9 +1114,11 @@ bool
batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	batadv_dbg_arp(bat_priv, skb, type, hdr_size,
 		       "Parsing incoming ARP REQUEST");

-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_src,
+			BATADV_DAT_IPV4, hw_src);

-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv,
+			(unsigned char *)&ip_dst, BATADV_DAT_IPV4);
 	if (!dat_entry)
 		goto out;

@@ -956,14 +1177,18 @@ void batadv_dat_snoop_outgoing_arp_reply(struct
batadv_priv *bat_priv,
 	hw_dst = batadv_arp_hw_dst(skb, 0);
 	ip_dst = batadv_arp_ip_dst(skb, 0);

-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_src,
+			BATADV_DAT_IPV4, hw_src);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_dst,
+			BATADV_DAT_IPV4, hw_dst);

 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, ip_src, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, (unsigned char *)&ip_src,
+			BATADV_DAT_IPV4, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, (unsigned char *)&ip_dst,
+			BATADV_DAT_IPV4, BATADV_P_DAT_DHT_PUT);
 }
 /**
  * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
@@ -998,8 +1223,10 @@ bool batadv_dat_snoop_incoming_arp_reply(struct
batadv_priv *bat_priv,
 	/* Update our internal cache with both the IP addresses the node got
 	 * within the ARP reply
 	 */
-	batadv_dat_entry_add(bat_priv, ip_src, hw_src);
-	batadv_dat_entry_add(bat_priv, ip_dst, hw_dst);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_src,
+			BATADV_DAT_IPV4, hw_src);
+	batadv_dat_entry_add(bat_priv, (unsigned char *)&ip_dst,
+			BATADV_DAT_IPV4, hw_dst);

 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
@@ -1043,7 +1270,8 @@ bool batadv_dat_drop_broadcast_packet(struct
batadv_priv *bat_priv,
 		goto out;

 	ip_dst = batadv_arp_ip_dst(forw_packet->skb, bcast_len);
-	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst);
+	dat_entry = batadv_dat_entry_hash_find(bat_priv,
+			(unsigned char *)&ip_dst, BATADV_DAT_IPV4);
 	/* check if the node already got this entry */
 	if (!dat_entry) {
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
diff --git a/types.h b/types.h
index 5f542bd..5f8b183 100644
--- a/types.h
+++ b/types.h
@@ -961,17 +961,18 @@ struct batadv_algo_ops {
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
@@ -980,6 +981,18 @@ struct batadv_dat_entry {
 };

 /**
+ * batadv_dat_types - types used in batadv_dat_entry for IP
+ * @BATADV_DAT_IPv4: IPv4 address type
+ * @BATADV_DAT_IPv6: IPv6 address type
+ */
+enum batadv_dat_types {
+	BATADV_DAT_IPV4,
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	BATADV_DAT_IPV6,
+#endif
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4
