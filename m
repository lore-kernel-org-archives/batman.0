Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
Date: Fri, 8 Mar 2013 12:50:46 +0200
Message-ID: <CAP5XTDMu4ujnntwCANw1etKK_KYWt22UvR0HBCbama41hViQ9Q@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Added IP enum types for dat and
 generic functions for comparing IPs and calculating hash
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

From d7a67d268ddd4d8788f806872459609994da7586 Mon Sep 17 00:00:00 2001
From: Mihail Costea <mihail.costea90@gmail.com>
Date: Fri, 8 Mar 2013 12:43:16 +0200
Subject: [PATCH] batman-adv: Added IP enum types for dat and generic
functions for
 comparing IPs and calculating hash

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>

---
 distributed-arp-table.c |   54 ++++++++++++++++++++++++++++++++++++++---------
 types.h                 |   10 +++++++++
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 9215caa..d67da0b 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -130,18 +130,44 @@ static void batadv_dat_purge(struct work_struct *work)
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
 }

 /**
@@ -201,16 +227,19 @@ static __be32 batadv_arp_ip_dst(struct sk_buff
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
@@ -223,6 +252,11 @@ static uint32_t batadv_hash_dat(const void *data,
uint32_t size)
 	return hash % size;
 }

+static uint32_t batadv_hash_dat_ipv4(const void *data, uint32_t size)
+{
+	return batadv_hash_dat(data, size, BATADV_DAT_IPv4);
+}
+
 /**
  * batadv_dat_entry_hash_find - looks for a given dat_entry in the local hash
  * table
@@ -243,7 +277,7 @@ batadv_dat_entry_hash_find(struct batadv_priv
*bat_priv, __be32 ip)
 	if (!hash)
 		return NULL;

-	index = batadv_hash_dat(&ip, hash->size);
+	index = batadv_hash_dat_ipv4(&ip, hash->size);
 	head = &hash->table[index];

 	rcu_read_lock();
@@ -295,9 +329,9 @@ static void batadv_dat_entry_add(struct
batadv_priv *bat_priv, __be32 ip,
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);

-	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
-				     batadv_hash_dat, &dat_entry->ip,
-				     &dat_entry->hash_entry);
+	hash_added = batadv_hash_add(bat_priv->dat.hash,
+			batadv_compare_dat_ipv4, batadv_hash_dat_ipv4,
+			&dat_entry->ip, &dat_entry->hash_entry);

 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
@@ -539,7 +573,7 @@ batadv_dat_select_candidates(struct batadv_priv
*bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;

-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat_ipv4(&ip_dst,
 						    BATADV_DAT_ADDR_MAX);

 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
diff --git a/types.h b/types.h
index aba8364..90546ef 100644
--- a/types.h
+++ b/types.h
@@ -978,6 +978,16 @@ struct batadv_dat_entry {
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
