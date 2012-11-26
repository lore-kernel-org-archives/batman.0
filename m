Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 26 Nov 2012 12:58:32 +0100
Message-Id: <1353931112-17392-5-git-send-email-sven@narfation.org>
In-Reply-To: <1353931112-17392-1-git-send-email-sven@narfation.org>
References: <1353931112-17392-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 5/5] batman-adv: Allow to use different
	sized hash locks array
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

The amount of locks of a hash directly affects the parallelity when all access
independent parts of the hash. But this also affects the amount of memory used
for each hash. Allowing to decouple the hash size and the lock size allows to
reduce this memory consumption for hashes which don't allow this parallelism.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |   28 ++++++++++++++--------------
 distributed-arp-table.c |   16 ++++++++--------
 distributed-arp-table.h |    6 +++---
 hash.h                  |   19 +++++++++----------
 originator.c            |    6 ++++--
 originator.h            |   13 +++++--------
 translation-table.c     |   22 ++++++++++++++--------
 vis.c                   |    8 ++++----
 8 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 1a78bac..781119f 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -38,7 +38,7 @@ static void batadv_bla_send_announce(struct batadv_priv *bat_priv,
 				     struct batadv_backbone_gw *backbone_gw);
 
 /* return the index of the claim */
-static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
+static inline uint32_t batadv_choose_claim(const void *data)
 {
 	struct batadv_claim *claim = (struct batadv_claim *)data;
 	uint32_t hash;
@@ -46,12 +46,11 @@ static inline uint32_t batadv_choose_claim(const void *data, uint32_t size)
 	hash = jhash(&claim->addr, sizeof(claim->addr), 0);
 	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
 
-	return hash % size;
+	return hash;
 }
 
 /* return the index of the backbone gateway */
-static inline uint32_t batadv_choose_backbone_gw(const void *data,
-						 uint32_t size)
+static inline uint32_t batadv_choose_backbone_gw(const void *data)
 {
 	struct batadv_claim *claim = (struct batadv_claim *)data;
 	uint32_t hash;
@@ -59,7 +58,7 @@ static inline uint32_t batadv_choose_backbone_gw(const void *data,
 	hash = jhash(&claim->addr, sizeof(claim->addr), 0);
 	hash = jhash(&claim->vid, sizeof(claim->vid), hash);
 
-	return hash % size;
+	return hash;
 }
 
 
@@ -136,10 +135,10 @@ static struct batadv_claim *batadv_claim_hash_find(struct batadv_priv *bat_priv,
 	struct hlist_node *node;
 	struct batadv_claim *claim;
 	struct batadv_claim *claim_tmp = NULL;
-	int index;
+	uint32_t index;
 
-	index = batadv_choose_claim(data, ARRAY_SIZE(bat_priv->bla.claim_hash));
-	head = &hash[index];
+	index = batadv_choose_claim(data);
+	head = &hash[index % ARRAY_SIZE(bat_priv->bla.claim_hash)];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(claim, node, head, hash_entry) {
@@ -174,14 +173,13 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 	struct hlist_node *node;
 	struct batadv_backbone_gw search_entry, *backbone_gw;
 	struct batadv_backbone_gw *backbone_gw_tmp = NULL;
-	int index;
-	uint32_t hash_size = ARRAY_SIZE(bat_priv->bla.backbone_hash);
+	uint32_t index;
 
 	memcpy(search_entry.orig, addr, ETH_ALEN);
 	search_entry.vid = vid;
 
-	index = batadv_choose_backbone_gw(&search_entry, hash_size);
-	head = &hash[index];
+	index = batadv_choose_backbone_gw(&search_entry);
+	head = &hash[index % ARRAY_SIZE(bat_priv->bla.backbone_hash)];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
@@ -211,12 +209,13 @@ batadv_bla_del_backbone_claims(struct batadv_backbone_gw *backbone_gw)
 	struct batadv_claim *claim;
 	int i;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->bla.claim_hash_locks);
 
 	hash = bat_priv->bla.claim_hash;
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->bla.claim_hash_locks[i];
+		list_lock = &bat_priv->bla.claim_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(claim, node, node_tmp,
@@ -953,12 +952,13 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	struct hlist_head *hash;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 	int i;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->bla.backbone_hash_locks);
 
 	hash = bat_priv->bla.backbone_hash;
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->bla.backbone_hash_locks[i];
+		list_lock = &bat_priv->bla.backbone_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(backbone_gw, node, node_tmp,
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b4f8eef..8c8dbc5 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -86,10 +86,11 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	uint32_t i;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->dat.hash_locks);
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->dat.hash); i++) {
 		head = &bat_priv->dat.hash[i];
-		list_lock = &bat_priv->dat.hash_locks[i];
+		list_lock = &bat_priv->dat.hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(dat_entry, node, node_tmp, head,
@@ -197,11 +198,10 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, int hdr_size)
 /**
  * batadv_hash_dat - compute the hash value for an IP address
  * @data: data to hash
- * @size: size of the hash table
  *
  * Returns the selected index in the hash table for the given data
  */
-static uint32_t batadv_hash_dat(const void *data, uint32_t size)
+static uint32_t batadv_hash_dat(const void *data)
 {
 	const unsigned char *key = data;
 	uint32_t hash = 0;
@@ -217,7 +217,7 @@ static uint32_t batadv_hash_dat(const void *data, uint32_t size)
 	hash ^= (hash >> 11);
 	hash += (hash << 15);
 
-	return hash % size;
+	return hash;
 }
 
 /**
@@ -237,8 +237,8 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
 	struct hlist_head *hash = bat_priv->dat.hash;
 	uint32_t index;
 
-	index = batadv_hash_dat(&ip, ARRAY_SIZE(bat_priv->dat.hash));
-	head = &hash[index];
+	index = batadv_hash_dat(&ip);
+	head = &hash[index % ARRAY_SIZE(bat_priv->dat.hash)];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, node, head, hash_entry) {
@@ -531,8 +531,8 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;
 
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
-						    BATADV_DAT_ADDR_MAX);
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst);
+	ip_key %= BATADV_DAT_ADDR_MAX;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
 		   "dat_select_candidates(): IP=%pI4 hash(IP)=%u\n", &ip_dst,
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index d060c03..642e28b 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -49,7 +49,7 @@ batadv_dat_init_orig_node_addr(struct batadv_orig_node *orig_node)
 {
 	uint32_t addr;
 
-	addr = batadv_choose_orig(orig_node->orig, BATADV_DAT_ADDR_MAX);
+	addr = batadv_choose_orig(orig_node->orig) % BATADV_DAT_ADDR_MAX;
 	orig_node->dat_addr = (batadv_dat_addr_t)addr;
 }
 
@@ -64,8 +64,8 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 {
 	uint32_t addr;
 
-	addr = batadv_choose_orig(primary_if->net_dev->dev_addr,
-				  BATADV_DAT_ADDR_MAX);
+	addr = batadv_choose_orig(primary_if->net_dev->dev_addr);
+	addr %= BATADV_DAT_ADDR_MAX;
 
 	bat_priv->dat.addr = (batadv_dat_addr_t)addr;
 }
diff --git a/hash.h b/hash.h
index 1cd3ae3..33b0be1 100644
--- a/hash.h
+++ b/hash.h
@@ -37,11 +37,10 @@
 typedef int (*batadv_hashdata_compare_cb)(const struct hlist_node *,
 					  const void *);
 
-/* the hashfunction, should return an index
- * based on the key in the data of the first
- * argument and the size the second
+/* the hashfunction, should return an unmapped index based on the key in the
+ * data of the first argument
  */
-typedef uint32_t (*batadv_hashdata_choose_cb)(const void *, uint32_t);
+typedef uint32_t (*batadv_hashdata_choose_cb)(const void *);
 typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
 
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
@@ -109,9 +108,9 @@ static inline int _batadv_hash_add(struct hlist_head *hash, uint32_t hash_size,
 	if (!hash)
 		goto out;
 
-	index = choose(data, hash_size);
-	head = &hash[index];
-	list_lock = &locks[index];
+	index = choose(data);
+	head = &hash[index % hash_size];
+	list_lock = &locks[index % lock_size];
 
 	spin_lock_bh(list_lock);
 
@@ -155,10 +154,10 @@ static inline void *_batadv_hash_remove(struct hlist_head *hash,
 	struct hlist_head *head;
 	void *data_save = NULL;
 
-	index = choose(data, hash_size);
-	head = &hash[index];
+	index = choose(data);
+	head = &hash[index % hash_size];
 
-	spin_lock_bh(&locks[index]);
+	spin_lock_bh(&locks[index % lock_size]);
 	hlist_for_each(node, head) {
 		if (!compare(node, data))
 			continue;
diff --git a/originator.c b/originator.c
index 2145005..3909862 100644
--- a/originator.c
+++ b/originator.c
@@ -155,12 +155,13 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->orig_hash_locks);
 
 	cancel_delayed_work_sync(&bat_priv->orig_work);
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->orig_hash_locks[i];
+		list_lock = &bat_priv->orig_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node, node_tmp,
@@ -339,11 +340,12 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->orig_hash_locks);
 
 	/* for all origins... */
 	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->orig_hash_locks[i];
+		list_lock = &bat_priv->orig_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node, node_tmp,
diff --git a/originator.h b/originator.h
index 0661479..9d188c0 100644
--- a/originator.h
+++ b/originator.h
@@ -44,12 +44,9 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 /* hashfunction to choose an entry in a hash table of given size
  * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
  */
-static inline uint32_t batadv_choose_orig(const void *data, uint32_t size)
+static inline uint32_t batadv_choose_orig(const void *data)
 {
-	uint32_t hash;
-
-	hash = jhash(data, ETH_ALEN, 0);
-	return hash % size;
+	return jhash(data, ETH_ALEN, 0);
 }
 
 static inline struct batadv_orig_node *
@@ -59,13 +56,13 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_orig_node *orig_node, *orig_node_tmp = NULL;
-	int index;
+	uint32_t index;
 
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, ARRAY_SIZE(bat_priv->orig_hash));
-	head = &hash[index];
+	index = batadv_choose_orig(data);
+	head = &hash[index % ARRAY_SIZE(bat_priv->orig_hash)];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
diff --git a/translation-table.c b/translation-table.c
index dd821ee..50b3a8c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -70,8 +70,8 @@ _batadv_tt_hash_find(struct hlist_head *hash, uint32_t size, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, size);
-	head = &hash[index];
+	index = batadv_choose_orig(data);
+	head = &hash[index % size];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tt_common_entry, node, head, hash_entry) {
@@ -635,10 +635,11 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->tt.local_hash_locks);
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->tt.local_hash_locks[i];
+		list_lock = &bat_priv->tt.local_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		batadv_tt_local_purge_list(bat_priv, head);
@@ -656,12 +657,13 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	uint32_t i;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->tt.local_hash_locks);
 
 	hash = bat_priv->tt.local_hash;
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->tt.local_hash_locks[i];
+		list_lock = &bat_priv->tt.local_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
@@ -1194,10 +1196,11 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	struct hlist_node *node, *safe;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->tt.global_hash_locks);
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->tt.global_hash_locks[i];
+		list_lock = &bat_priv->tt.global_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node, safe,
@@ -1254,10 +1257,11 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	char *msg = NULL;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->tt.global_hash_locks);
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->tt.global_hash_locks[i];
+		list_lock = &bat_priv->tt.global_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node, node_tmp, head,
@@ -1290,12 +1294,13 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	uint32_t i;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->tt.global_hash_locks);
 
 	hash = bat_priv->tt.global_hash;
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->tt.global_hash_locks[i];
+		list_lock = &bat_priv->tt.global_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
@@ -2336,10 +2341,11 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
+	uint32_t locks_size = ARRAY_SIZE(bat_priv->tt.local_hash_locks);
 
 	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
 		head = &hash[i];
-		list_lock = &bat_priv->tt.local_hash_locks[i];
+		list_lock = &bat_priv->tt.local_hash_locks[i % locks_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node, node_tmp, head,
diff --git a/vis.c b/vis.c
index 54401e3..8fd03f0 100644
--- a/vis.c
+++ b/vis.c
@@ -68,7 +68,7 @@ static int batadv_vis_info_cmp(const struct hlist_node *node, const void *data2)
 /* hash function to choose an entry in a hash table of given size
  * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
  */
-static uint32_t batadv_vis_info_choose(const void *data, uint32_t size)
+static uint32_t batadv_vis_info_choose(const void *data)
 {
 	const struct batadv_vis_info *vis_info = data;
 	const struct batadv_vis_packet *packet;
@@ -77,7 +77,7 @@ static uint32_t batadv_vis_info_choose(const void *data, uint32_t size)
 	packet = (struct batadv_vis_packet *)vis_info->skb_packet->data;
 	hash = jhash(&packet->vis_orig, sizeof(packet->vis_orig), 0);
 
-	return hash % size;
+	return hash;
 }
 
 static struct batadv_vis_info *
@@ -89,8 +89,8 @@ batadv_vis_hash_find(struct batadv_priv *bat_priv, const void *data)
 	struct batadv_vis_info *vis_info, *vis_info_tmp = NULL;
 	uint32_t index;
 
-	index = batadv_vis_info_choose(data, ARRAY_SIZE(bat_priv->vis.hash));
-	head = &hash[index];
+	index = batadv_vis_info_choose(data);
+	head = &hash[index % ARRAY_SIZE(bat_priv->vis.hash)];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vis_info, node, head, hash_entry) {
-- 
1.7.10.4

