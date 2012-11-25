Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Nov 2012 19:23:29 +0100
Message-Id: <1353867811-8452-3-git-send-email-sven@narfation.org>
In-Reply-To: <1353867811-8452-1-git-send-email-sven@narfation.org>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Remove size information from
	hash table
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

The size of an hashtable is known by the user of the hash and doesn't have to
be stored inside the batadv_hashtable structure. This is an intermediate step
before the size information is extracted by the compiler instead of manually
added by the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |   32 +++++++++++++++-----------
 distributed-arp-table.c |   15 ++++++------
 hash.c                  |   11 ++++-----
 hash.h                  |   13 +++++++----
 originator.c            |   17 +++++++-------
 originator.h            |    2 +-
 routing.c               |    2 +-
 translation-table.c     |   58 ++++++++++++++++++++++++++++-------------------
 vis.c                   |   31 +++++++++++++++----------
 9 files changed, 105 insertions(+), 76 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 2fd5f09..841143d 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -141,7 +141,7 @@ static struct batadv_claim *batadv_claim_hash_find(struct batadv_priv *bat_priv,
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_claim(data, hash->size);
+	index = batadv_choose_claim(data, 1 << BATADV_BLA_CLAIM_HASH_BITS);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -178,6 +178,7 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 	struct batadv_backbone_gw search_entry, *backbone_gw;
 	struct batadv_backbone_gw *backbone_gw_tmp = NULL;
 	int index;
+	uint32_t hash_size =  1 << BATADV_BLA_BACKBONE_HASH_BITS;
 
 	if (!hash)
 		return NULL;
@@ -185,7 +186,7 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 	memcpy(search_entry.orig, addr, ETH_ALEN);
 	search_entry.vid = vid;
 
-	index = batadv_choose_backbone_gw(&search_entry, hash->size);
+	index = batadv_choose_backbone_gw(&search_entry, hash_size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -220,7 +221,7 @@ batadv_bla_del_backbone_claims(struct batadv_backbone_gw *backbone_gw)
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_CLAIM_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -391,6 +392,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 	atomic_set(&entry->refcount, 2);
 
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
+				     1 << BATADV_BLA_BACKBONE_HASH_BITS,
 				     batadv_compare_backbone_gw,
 				     batadv_choose_backbone_gw, entry,
 				     &entry->hash_entry);
@@ -468,7 +470,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 		return;
 
 	hash = bat_priv->bla.claim_hash;
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_CLAIM_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -569,6 +571,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, vid);
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
+					     1 << BATADV_BLA_CLAIM_HASH_BITS,
 					     batadv_compare_claim,
 					     batadv_choose_claim, claim,
 					     &claim->hash_entry);
@@ -620,8 +623,9 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %d\n",
 		   mac, vid);
 
-	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
-			   batadv_choose_claim, claim);
+	batadv_hash_remove(bat_priv->bla.claim_hash,
+			   1 << BATADV_BLA_CLAIM_HASH_BITS,
+			   batadv_compare_claim, batadv_choose_claim, claim);
 	batadv_claim_free_ref(claim); /* reference from the hash is gone */
 
 	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
@@ -961,7 +965,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1015,7 +1019,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_CLAIM_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1075,7 +1079,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1139,7 +1143,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	if (!hash)
 		goto out;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1230,8 +1234,10 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 		return -ENOMEM;
 
 	batadv_hash_set_lock_class(bat_priv->bla.claim_hash,
+				   1 << BATADV_BLA_CLAIM_HASH_BITS,
 				   &batadv_claim_hash_lock_class_key);
 	batadv_hash_set_lock_class(bat_priv->bla.backbone_hash,
+				   1 << BATADV_BLA_CLAIM_HASH_BITS,
 				   &batadv_backbone_hash_lock_class_key);
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hashes initialized\n");
@@ -1333,7 +1339,7 @@ int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 	if (!hash)
 		return 0;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1625,7 +1631,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-6s)\n",
 		   "Client", "VID", "Originator", "CRC");
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_CLAIM_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1671,7 +1677,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s %-9s (%-6s)\n",
 		   "Originator", "VID", "last seen", "CRC");
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 7285496..baaec53 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -90,7 +90,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 	if (!bat_priv->dat.hash)
 		return;
 
-	for (i = 0; i < bat_priv->dat.hash->size; i++) {
+	for (i = 0; i <  1 << BATADV_DAT_HASH_BITS; i++) {
 		head = &bat_priv->dat.hash->table[i];
 		list_lock = &bat_priv->dat.hash->list_locks[i];
 
@@ -243,7 +243,7 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
 	if (!hash)
 		return NULL;
 
-	index = batadv_hash_dat(&ip, hash->size);
+	index = batadv_hash_dat(&ip, 1 << BATADV_DAT_HASH_BITS);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -295,9 +295,10 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);
 
-	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
-				     batadv_hash_dat, &dat_entry->ip,
-				     &dat_entry->hash_entry);
+	hash_added = batadv_hash_add(bat_priv->dat.hash,
+				     1 << BATADV_DAT_HASH_BITS,
+				     batadv_compare_dat, batadv_hash_dat,
+				     &dat_entry->ip, &dat_entry->hash_entry);
 
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
@@ -477,7 +478,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 	/* iterate over the originator list and find the node with closest
 	 * dat_address which has not been selected yet
 	 */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -700,7 +701,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
 		   "last-seen");
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_DAT_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
diff --git a/hash.c b/hash.c
index 15a849c..7c4edfc 100644
--- a/hash.c
+++ b/hash.c
@@ -21,11 +21,11 @@
 #include "hash.h"
 
 /* clears the hash */
-static void batadv_hash_init(struct batadv_hashtable *hash)
+static void batadv_hash_init(struct batadv_hashtable *hash, uint32_t size)
 {
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < size; i++) {
 		INIT_HLIST_HEAD(&hash->table[i]);
 		spin_lock_init(&hash->list_locks[i]);
 	}
@@ -57,8 +57,7 @@ struct batadv_hashtable *batadv_hash_new(uint32_t size)
 	if (!hash->list_locks)
 		goto free_table;
 
-	hash->size = size;
-	batadv_hash_init(hash);
+	batadv_hash_init(hash, size);
 	return hash;
 
 free_table:
@@ -68,11 +67,11 @@ free_hash:
 	return NULL;
 }
 
-void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
+void batadv_hash_set_lock_class(struct batadv_hashtable *hash, uint32_t size,
 				struct lock_class_key *key)
 {
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++)
+	for (i = 0; i < size; i++)
 		lockdep_set_class(&hash->list_locks[i], key);
 }
diff --git a/hash.h b/hash.h
index 977de9c..107c67e 100644
--- a/hash.h
+++ b/hash.h
@@ -38,14 +38,13 @@ typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
 struct batadv_hashtable {
 	struct hlist_head *table;   /* the hashtable itself with the buckets */
 	spinlock_t *list_locks;     /* spinlock for each hash list entry */
-	uint32_t size;		    /* size of hashtable */
 };
 
 /* allocates and clears the hash */
 struct batadv_hashtable *batadv_hash_new(uint32_t size);
 
 /* set class key for all locks */
-void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
+void batadv_hash_set_lock_class(struct batadv_hashtable *hash, uint32_t size,
 				struct lock_class_key *key);
 
 /* free only the hashtable and the hash itself. */
@@ -56,6 +55,7 @@ void batadv_hash_destroy(struct batadv_hashtable *hash);
  * elements, memory might be leaked.
  */
 static inline void batadv_hash_delete(struct batadv_hashtable *hash,
+				      uint32_t size,
 				      batadv_hashdata_free_cb free_cb,
 				      void *arg)
 {
@@ -64,7 +64,7 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -84,6 +84,7 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
 /**
  *	batadv_hash_add - adds data to the hashtable
  *	@hash: storage hash table
+ *	@size: size of the hashtable
  *	@compare: callback to determine if 2 hash elements are identical
  *	@choose: callback calculating the hash index
  *	@data: data passed to the aforementioned callbacks as argument
@@ -93,6 +94,7 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
  *	and -1 on error.
  */
 static inline int batadv_hash_add(struct batadv_hashtable *hash,
+				  uint32_t size,
 				  batadv_hashdata_compare_cb compare,
 				  batadv_hashdata_choose_cb choose,
 				  const void *data,
@@ -107,7 +109,7 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
 	if (!hash)
 		goto out;
 
-	index = choose(data, hash->size);
+	index = choose(data, size);
 	head = &hash->table[index];
 	list_lock = &hash->list_locks[index];
 
@@ -138,6 +140,7 @@ out:
  * comparing.
  */
 static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
+				       uint32_t size,
 				       batadv_hashdata_compare_cb compare,
 				       batadv_hashdata_choose_cb choose,
 				       void *data)
@@ -147,7 +150,7 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 	struct hlist_head *head;
 	void *data_save = NULL;
 
-	index = choose(data, hash->size);
+	index = choose(data, size);
 	head = &hash->table[index];
 
 	spin_lock_bh(&hash->list_locks[index]);
diff --git a/originator.c b/originator.c
index bd3f5d2..38ae83c 100644
--- a/originator.c
+++ b/originator.c
@@ -171,7 +171,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 
 	bat_priv->orig_hash = NULL;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -251,9 +251,10 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
-	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
-				     batadv_choose_orig, orig_node,
-				     &orig_node->hash_entry);
+	hash_added = batadv_hash_add(bat_priv->orig_hash,
+				     1 << BATADV_ORIG_HASH_BITS,
+				     batadv_compare_orig, batadv_choose_orig,
+				     orig_node, &orig_node->hash_entry);
 	if (hash_added != 0)
 		goto free_bcast_own_sum;
 
@@ -358,7 +359,7 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 		return;
 
 	/* for all origins... */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -428,7 +429,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
 		   "Nexthop", "outgoingIF", "Potential nexthops");
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -518,7 +519,7 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -603,7 +604,7 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
diff --git a/originator.h b/originator.h
index 1311d39..1cad364 100644
--- a/originator.h
+++ b/originator.h
@@ -64,7 +64,7 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, hash->size);
+	index = batadv_choose_orig(data, 1 << BATADV_ORIG_HASH_BITS);
 	head = &hash->table[index];
 
 	rcu_read_lock();
diff --git a/routing.c b/routing.c
index 1aa1722..09c40e3 100644
--- a/routing.c
+++ b/routing.c
@@ -45,7 +45,7 @@ void batadv_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	size_t word_index;
 	uint8_t *w;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
diff --git a/translation-table.c b/translation-table.c
index 7128576..3ae2e10 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -80,7 +80,8 @@ static void batadv_tt_start_timer(struct batadv_priv *bat_priv)
 }
 
 static struct batadv_tt_common_entry *
-batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
+batadv_tt_hash_find(struct batadv_hashtable *hash, uint32_t size,
+		    const void *data)
 {
 	struct hlist_head *head;
 	struct hlist_node *node;
@@ -91,7 +92,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_tt(data, hash->size);
+	index = batadv_choose_tt(data, size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -116,7 +117,9 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const void *data)
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 
-	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash, data);
+	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash,
+					      1 << BATADV_TT_LOCAL_HASH_BITS,
+					      data);
 	if (tt_common_entry)
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
@@ -130,7 +133,9 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const void *data)
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 
-	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash, data);
+	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash,
+					      1 << BATADV_TT_GLOBAL_HASH_BITS,
+					      data);
 	if (tt_common_entry)
 		tt_global_entry = container_of(tt_common_entry,
 					       struct batadv_tt_global_entry,
@@ -272,7 +277,8 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 		   "Deleting global tt entry %pM: %s\n",
 		   tt_global->common.addr, message);
 
-	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
+	batadv_hash_remove(bat_priv->tt.global_hash,
+			   1 << BATADV_TT_GLOBAL_HASH_BITS, batadv_compare_tt,
 			   batadv_choose_tt, tt_global->common.addr);
 	batadv_tt_global_entry_free_ref(tt_global);
 
@@ -346,8 +352,10 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	if (batadv_compare_eth(addr, soft_iface->dev_addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
-	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-				     batadv_choose_tt, &tt_local->common,
+	hash_added = batadv_hash_add(bat_priv->tt.local_hash,
+				     1 << BATADV_TT_LOCAL_HASH_BITS,
+				     batadv_compare_tt, batadv_choose_tt,
+				     &tt_local->common,
 				     &tt_local->common.hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -516,7 +524,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s %-7s %-10s\n", "Client", "Flags",
 		   "Last seen");
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -659,7 +667,7 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv)
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -685,7 +693,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 
 	hash = bat_priv->tt.local_hash;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -867,6 +875,7 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 		spin_lock_init(&tt_global_entry->list_lock);
 
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
+					     1 << BATADV_TT_GLOBAL_HASH_BITS,
 					     batadv_compare_tt,
 					     batadv_choose_tt, common,
 					     &common->hash_entry);
@@ -1059,7 +1068,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "CRC",
 		   "Flags");
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1234,7 +1243,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1294,7 +1303,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1335,7 +1344,7 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 
 	hash = bat_priv->tt.global_hash;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1427,7 +1436,7 @@ static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	uint32_t i;
 	int j;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1479,7 +1488,7 @@ static uint16_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 	uint32_t i;
 	int j;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1614,7 +1623,7 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 
 static struct sk_buff *
 batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
-			      struct batadv_hashtable *hash,
+			      struct batadv_hashtable *hash, uint32_t size,
 			      struct batadv_hard_iface *primary_if,
 			      int (*valid_cb)(const void *, const void *),
 			      void *cb_data)
@@ -1649,7 +1658,7 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	tt_count = 0;
 
 	rcu_read_lock();
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < size; i++) {
 		head = &hash->table[i];
 
 		hlist_for_each_entry_rcu(tt_common_entry, node,
@@ -1761,6 +1770,7 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_tt_query_packet *tt_response;
 	uint8_t *packet_pos;
 	size_t len;
+	uint32_t hash_size = 1 << BATADV_TT_GLOBAL_HASH_BITS;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (%pM) [%c]\n",
@@ -1827,7 +1837,7 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 
 		skb = batadv_tt_response_fill_table(tt_len, ttvn,
 						    bat_priv->tt.global_hash,
-						    primary_if,
+						    hash_size, primary_if,
 						    batadv_tt_global_valid,
 						    req_dst_orig_node);
 		if (!skb)
@@ -1887,6 +1897,7 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_tt_query_packet *tt_response;
 	uint8_t *packet_pos;
 	size_t len;
+	uint32_t hash_size = 1 << BATADV_TT_LOCAL_HASH_BITS;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (me) [%c]\n",
@@ -1944,7 +1955,7 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 
 		skb = batadv_tt_response_fill_table(tt_len, ttvn,
 						    bat_priv->tt.local_hash,
-						    primary_if,
+						    hash_size, primary_if,
 						    batadv_tt_local_valid_entry,
 						    NULL);
 		if (!skb)
@@ -2325,7 +2336,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  * in the given hash table and returns the number of modified entries
  */
 static uint16_t batadv_tt_set_flags(struct batadv_hashtable *hash,
-				    uint16_t flags, bool enable)
+				    uint32_t size, uint16_t flags, bool enable)
 {
 	uint32_t i;
 	uint16_t changed_num = 0;
@@ -2336,7 +2347,7 @@ static uint16_t batadv_tt_set_flags(struct batadv_hashtable *hash,
 	if (!hash)
 		goto out;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < size; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -2373,7 +2384,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -2409,6 +2420,7 @@ static int batadv_tt_commit_changes(struct batadv_priv *bat_priv,
 		return -ENOENT;
 
 	changed_num = batadv_tt_set_flags(bat_priv->tt.local_hash,
+					  1 << BATADV_TT_LOCAL_HASH_BITS,
 					  BATADV_TT_CLIENT_NEW, false);
 
 	/* all reset entries have to be counted as local entries */
diff --git a/vis.c b/vis.c
index 30e1405..ecde6a1 100644
--- a/vis.c
+++ b/vis.c
@@ -92,7 +92,7 @@ batadv_vis_hash_find(struct batadv_priv *bat_priv, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_vis_info_choose(data, hash->size);
+	index = batadv_vis_info_choose(data, 1 << BATADV_VIS_HASH_BITS);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -254,7 +254,7 @@ int batadv_vis_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	spin_lock_bh(&bat_priv->vis.hash_lock);
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_VIS_HASH_BITS; i++) {
 		head = &hash->table[i];
 		batadv_vis_seq_print_text_bucket(seq, head);
 	}
@@ -374,8 +374,10 @@ batadv_add_packet(struct batadv_priv *bat_priv,
 			}
 		}
 		/* remove old entry */
-		batadv_hash_remove(bat_priv->vis.hash, batadv_vis_info_cmp,
-				   batadv_vis_info_choose, old_info);
+		batadv_hash_remove(bat_priv->vis.hash,
+				   1 << BATADV_VIS_HASH_BITS,
+				   batadv_vis_info_cmp, batadv_vis_info_choose,
+				   old_info);
 		batadv_send_list_del(old_info);
 		kref_put(&old_info->refcount, batadv_free_info);
 	}
@@ -415,7 +417,9 @@ batadv_add_packet(struct batadv_priv *bat_priv,
 	batadv_recv_list_add(bat_priv, &info->recv_list, packet->sender_orig);
 
 	/* try to add it */
-	hash_added = batadv_hash_add(bat_priv->vis.hash, batadv_vis_info_cmp,
+	hash_added = batadv_hash_add(bat_priv->vis.hash,
+				     1 << BATADV_VIS_HASH_BITS,
+				     batadv_vis_info_cmp,
 				     batadv_vis_info_choose, info,
 				     &info->hash_entry);
 	if (hash_added != 0) {
@@ -516,7 +520,7 @@ static int batadv_find_best_vis_server(struct batadv_priv *bat_priv,
 
 	packet = (struct batadv_vis_packet *)info->skb_packet->data;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -589,7 +593,7 @@ static int batadv_generate_vis_packet(struct batadv_priv *bat_priv)
 			return best_tq;
 	}
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -628,7 +632,7 @@ next:
 
 	hash = bat_priv->tt.local_hash;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -665,7 +669,7 @@ static void batadv_purge_vis_packets(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	struct batadv_vis_info *info;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_VIS_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		hlist_for_each_entry_safe(info, node, node_tmp,
@@ -699,7 +703,7 @@ static void batadv_broadcast_vis_packet(struct batadv_priv *bat_priv,
 	packet = (struct batadv_vis_packet *)info->skb_packet->data;
 
 	/* send to all routers in range. */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -871,7 +875,9 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 
 	INIT_LIST_HEAD(&bat_priv->vis.send_list);
 
-	hash_added = batadv_hash_add(bat_priv->vis.hash, batadv_vis_info_cmp,
+	hash_added = batadv_hash_add(bat_priv->vis.hash,
+				     1 << BATADV_VIS_HASH_BITS,
+				     batadv_vis_info_cmp,
 				     batadv_vis_info_choose,
 				     bat_priv->vis.my_info,
 				     &bat_priv->vis.my_info->hash_entry);
@@ -915,7 +921,8 @@ void batadv_vis_quit(struct batadv_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->vis.hash_lock);
 	/* properly remove, kill timers ... */
-	batadv_hash_delete(bat_priv->vis.hash, batadv_free_info_ref, NULL);
+	batadv_hash_delete(bat_priv->vis.hash, 1 << BATADV_VIS_HASH_BITS,
+			   batadv_free_info_ref, NULL);
 	bat_priv->vis.hash = NULL;
 	bat_priv->vis.my_info = NULL;
 	spin_unlock_bh(&bat_priv->vis.hash_lock);
-- 
1.7.10.4

