Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 Mar 2015 14:15:36 +0100
Message-Id: <1425215737-8387-2-git-send-email-sven@narfation.org>
In-Reply-To: <1425215737-8387-1-git-send-email-sven@narfation.org>
References: <1425215737-8387-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFCv3 2/3] batman-adv: Remove size information from
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
Cc: Sven Eckelmann <sven@narfation.org>

The size of an hashtable is known by the user of the hash and doesn't have to
be stored inside the batadv_hashtable structure. This is an intermediate step
before the size information is extracted by the compiler instead of manually
added by the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - Rebased on master

 bat_iv_ogm.c            |  8 ++++---
 bridge_loop_avoidance.c | 32 +++++++++++++++-----------
 distributed-arp-table.c | 12 +++++-----
 hash.c                  | 11 +++++----
 hash.h                  | 13 ++++++-----
 network-coding.c        | 44 +++++++++++++++++++++++++-----------
 originator.c            |  9 ++++----
 originator.h            |  2 +-
 translation-table.c     | 60 ++++++++++++++++++++++++++++---------------------
 9 files changed, 116 insertions(+), 75 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 554e0e0..7b30cd4 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -245,7 +245,9 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
 	if (!orig_node->bat_iv.bcast_own_sum)
 		goto free_orig_node;
 
-	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
+	hash_added = batadv_hash_add(bat_priv->orig_hash,
+				     1u << BATADV_ORIG_HASH_BITS,
+				     batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
 	if (hash_added != 0)
@@ -871,7 +873,7 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	uint8_t *w;
 	int if_num;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1812,7 +1814,7 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
 		   "Nexthop", "outgoingIF", "Potential nexthops");
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index c999d6b..d19f7c2 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -142,7 +142,7 @@ static struct batadv_bla_claim
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_claim(data, hash->size);
+	index = batadv_choose_claim(data, 1u << BATADV_BLA_CLAIM_HASH_BITS);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -178,6 +178,7 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 	struct batadv_bla_backbone_gw search_entry, *backbone_gw;
 	struct batadv_bla_backbone_gw *backbone_gw_tmp = NULL;
 	int index;
+	uint32_t hash_size =  1u << BATADV_BLA_BACKBONE_HASH_BITS;
 
 	if (!hash)
 		return NULL;
@@ -185,7 +186,7 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 	ether_addr_copy(search_entry.orig, addr);
 	search_entry.vid = vid;
 
-	index = batadv_choose_backbone_gw(&search_entry, hash->size);
+	index = batadv_choose_backbone_gw(&search_entry, hash_size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -220,7 +221,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_CLAIM_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -393,6 +394,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 	atomic_set(&entry->refcount, 2);
 
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
+				     1u << BATADV_BLA_BACKBONE_HASH_BITS,
 				     batadv_compare_backbone_gw,
 				     batadv_choose_backbone_gw, entry,
 				     &entry->hash_entry);
@@ -472,7 +474,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 		return;
 
 	hash = bat_priv->bla.claim_hash;
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_CLAIM_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -576,6 +578,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, BATADV_PRINT_VID(vid));
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
+					     1u << BATADV_BLA_CLAIM_HASH_BITS,
 					     batadv_compare_claim,
 					     batadv_choose_claim, claim,
 					     &claim->hash_entry);
@@ -626,8 +629,9 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %d\n",
 		   mac, BATADV_PRINT_VID(vid));
 
-	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
-			   batadv_choose_claim, claim);
+	batadv_hash_remove(bat_priv->bla.claim_hash,
+			   1u << BATADV_BLA_CLAIM_HASH_BITS,
+			   batadv_compare_claim, batadv_choose_claim, claim);
 	batadv_claim_free_ref(claim); /* reference from the hash is gone */
 
 	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
@@ -994,7 +998,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1047,7 +1051,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_CLAIM_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1110,7 +1114,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1163,7 +1167,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	if (!hash)
 		goto out;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1255,8 +1259,10 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 		return -ENOMEM;
 
 	batadv_hash_set_lock_class(bat_priv->bla.claim_hash,
+				   1u << BATADV_BLA_CLAIM_HASH_BITS,
 				   &batadv_claim_hash_lock_class_key);
 	batadv_hash_set_lock_class(bat_priv->bla.backbone_hash,
+				   1u << BATADV_BLA_CLAIM_HASH_BITS,
 				   &batadv_backbone_hash_lock_class_key);
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hashes initialized\n");
@@ -1362,7 +1368,7 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
 	if (!hash)
 		return false;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1642,7 +1648,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-6s)\n",
 		   "Client", "VID", "Originator", "CRC");
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_CLAIM_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1687,7 +1693,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s %-9s (%-6s)\n",
 		   "Originator", "VID", "last seen", "CRC");
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 87ab637..a027e75 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -88,7 +88,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 	if (!bat_priv->dat.hash)
 		return;
 
-	for (i = 0; i < bat_priv->dat.hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_DAT_HASH_BITS; i++) {
 		head = &bat_priv->dat.hash->table[i];
 		list_lock = &bat_priv->dat.hash->list_locks[i];
 
@@ -254,7 +254,7 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 	to_find.ip = ip;
 	to_find.vid = vid;
 
-	index = batadv_hash_dat(&to_find, hash->size);
+	index = batadv_hash_dat(&to_find, 1u << BATADV_DAT_HASH_BITS);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -309,7 +309,9 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);
 
-	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
+	hash_added = batadv_hash_add(bat_priv->dat.hash,
+				     1u << BATADV_DAT_HASH_BITS,
+				     batadv_compare_dat,
 				     batadv_hash_dat, dat_entry,
 				     &dat_entry->hash_entry);
 
@@ -492,7 +494,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 	/* iterate over the originator list and find the node with the closest
 	 * dat_address which has not been selected yet
 	 */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -778,7 +780,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv4",
 		   "MAC", "VID", "last-seen");
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_DAT_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
diff --git a/hash.c b/hash.c
index 7c1c630..8e8d934 100644
--- a/hash.c
+++ b/hash.c
@@ -19,11 +19,11 @@
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
@@ -55,8 +55,7 @@ struct batadv_hashtable *batadv_hash_new(uint32_t size)
 	if (!hash->list_locks)
 		goto free_table;
 
-	hash->size = size;
-	batadv_hash_init(hash);
+	batadv_hash_init(hash, size);
 	return hash;
 
 free_table:
@@ -66,11 +65,11 @@ free_hash:
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
index a1d0980..c88166b 100644
--- a/hash.h
+++ b/hash.h
@@ -36,14 +36,13 @@ typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
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
@@ -54,6 +53,7 @@ void batadv_hash_destroy(struct batadv_hashtable *hash);
  * elements, memory might be leaked.
  */
 static inline void batadv_hash_delete(struct batadv_hashtable *hash,
+				      uint32_t size,
 				      batadv_hashdata_free_cb free_cb,
 				      void *arg)
 {
@@ -62,7 +62,7 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < size; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -82,6 +82,7 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
 /**
  *	batadv_hash_add - adds data to the hashtable
  *	@hash: storage hash table
+ *	@size: size of the hashtable
  *	@compare: callback to determine if 2 hash elements are identical
  *	@choose: callback calculating the hash index
  *	@data: data passed to the aforementioned callbacks as argument
@@ -91,6 +92,7 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
  *	and -1 on error.
  */
 static inline int batadv_hash_add(struct batadv_hashtable *hash,
+				  uint32_t size,
 				  batadv_hashdata_compare_cb compare,
 				  batadv_hashdata_choose_cb choose,
 				  const void *data,
@@ -105,7 +107,7 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
 	if (!hash)
 		goto out;
 
-	index = choose(data, hash->size);
+	index = choose(data, size);
 	head = &hash->table[index];
 	list_lock = &hash->list_locks[index];
 
@@ -136,6 +138,7 @@ out:
  * comparing.
  */
 static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
+				       uint32_t size,
 				       batadv_hashdata_compare_cb compare,
 				       batadv_hashdata_choose_cb choose,
 				       void *data)
@@ -145,7 +148,7 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 	struct hlist_head *head;
 	void *data_save = NULL;
 
-	index = choose(data, hash->size);
+	index = choose(data, size);
 	head = &hash->table[index];
 
 	spin_lock_bh(&hash->list_locks[index]);
diff --git a/network-coding.c b/network-coding.c
index b70c34e..6f0ceb4 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -130,6 +130,7 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 		goto err;
 
 	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
+				   1u << BATADV_NC_CODING_HASH_BITS,
 				   &batadv_nc_coding_hash_lock_class_key);
 
 	bat_priv->nc.decoding_hash = batadv_hash_new(hash_decoding_size);
@@ -137,6 +138,7 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 		goto err;
 
 	batadv_hash_set_lock_class(bat_priv->nc.decoding_hash,
+				   1u << BATADV_NC_DECODING_HASH_BITS,
 				   &batadv_nc_decoding_hash_lock_class_key);
 
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
@@ -361,7 +363,7 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 		return;
 
 	/* For each orig_node */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -377,6 +379,7 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
  *  unused ones
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the nc paths to check
+ * @hash_size: number of buckets in the hashtable
  * @to_purge: function in charge to decide whether an entry has to be purged or
  *	      not. This function takes the nc node as argument and has to return
  *	      a boolean value: true is the entry has to be deleted, false
@@ -384,6 +387,7 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
  */
 static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 				  struct batadv_hashtable *hash,
+				  uint32_t hash_size,
 				  bool (*to_purge)(struct batadv_priv *,
 						   struct batadv_nc_path *))
 {
@@ -393,7 +397,7 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 	spinlock_t *lock; /* Protects lists in hash */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < hash_size; i++) {
 		head = &hash->table[i];
 		lock = &hash->list_locks[i];
 
@@ -493,12 +497,13 @@ static int batadv_nc_hash_compare(const struct hlist_node *node,
 /**
  * batadv_nc_hash_find - search for an existing nc path and return it
  * @hash: hash table containing the nc path
+ * @hash_size: number of buckets in the hashtable
  * @data: search key
  *
  * Returns the nc_path if found, NULL otherwise.
  */
 static struct batadv_nc_path *
-batadv_nc_hash_find(struct batadv_hashtable *hash,
+batadv_nc_hash_find(struct batadv_hashtable *hash, uint32_t hash_size,
 		    void *data)
 {
 	struct hlist_head *head;
@@ -508,7 +513,7 @@ batadv_nc_hash_find(struct batadv_hashtable *hash,
 	if (!hash)
 		return NULL;
 
-	index = batadv_nc_hash_choose(data, hash->size);
+	index = batadv_nc_hash_choose(data, hash_size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -618,13 +623,14 @@ static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
  *  nc packets
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: to be processed hash table
+ * @hash_size: number of buckets in the hashtable
  * @process_fn: Function called to process given nc packet. Should return true
  *	        to encourage this function to proceed with the next packet.
  *	        Otherwise the rest of the current queue is skipped.
  */
 static void
 batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
-			   struct batadv_hashtable *hash,
+			   struct batadv_hashtable *hash, uint32_t hash_size,
 			   bool (*process_fn)(struct batadv_priv *,
 					      struct batadv_nc_path *,
 					      struct batadv_nc_packet *))
@@ -639,7 +645,7 @@ batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
 		return;
 
 	/* Loop hash table bins */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < hash_size; i++) {
 		head = &hash->table[i];
 
 		/* Loop coding paths */
@@ -676,14 +682,17 @@ static void batadv_nc_worker(struct work_struct *work)
 
 	batadv_nc_purge_orig_hash(bat_priv);
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash,
+			      1u << BATADV_NC_CODING_HASH_BITS,
 			      batadv_nc_to_purge_nc_path_coding);
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash,
+			      1u << BATADV_NC_DECODING_HASH_BITS,
 			      batadv_nc_to_purge_nc_path_decoding);
 
 	timeout = bat_priv->nc.max_fwd_delay;
 
 	if (batadv_has_timed_out(bat_priv->nc.timestamp_fwd_flush, timeout)) {
 		batadv_nc_process_nc_paths(bat_priv, bat_priv->nc.coding_hash,
+					   1u << BATADV_NC_CODING_HASH_BITS,
 					   batadv_nc_fwd_flush);
 		bat_priv->nc.timestamp_fwd_flush = jiffies;
 	}
@@ -691,6 +700,7 @@ static void batadv_nc_worker(struct work_struct *work)
 	if (batadv_has_timed_out(bat_priv->nc.timestamp_sniffed_purge,
 				 bat_priv->nc.max_buffer_time)) {
 		batadv_nc_process_nc_paths(bat_priv, bat_priv->nc.decoding_hash,
+					   1u << BATADV_NC_DECODING_HASH_BITS,
 					   batadv_nc_sniffed_purge);
 		bat_priv->nc.timestamp_sniffed_purge = jiffies;
 	}
@@ -903,6 +913,7 @@ out:
  * batadv_nc_get_path - get existing nc_path or allocate a new one
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the nc path
+ * @hash_size: number of buckets in the hashtable
  * @src: ethernet source address - first half of the nc path search key
  * @dst: ethernet destination address - second half of the nc path search key
  *
@@ -911,6 +922,7 @@ out:
  */
 static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 						 struct batadv_hashtable *hash,
+						 uint32_t hash_size,
 						 uint8_t *src,
 						 uint8_t *dst)
 {
@@ -920,7 +932,7 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 	batadv_nc_hash_key_gen(&nc_path_key, src, dst);
 
 	/* Search for existing nc_path */
-	nc_path = batadv_nc_hash_find(hash, (void *)&nc_path_key);
+	nc_path = batadv_nc_hash_find(hash, hash_size, (void *)&nc_path_key);
 
 	if (nc_path) {
 		/* Set timestamp to delay removal of nc_path */
@@ -947,7 +959,7 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 		   nc_path->next_hop);
 
 	/* Add nc_path to hash table */
-	hash_added = batadv_hash_add(hash, batadv_nc_hash_compare,
+	hash_added = batadv_hash_add(hash, hash_size, batadv_nc_hash_compare,
 				     batadv_nc_hash_choose, &nc_path_key,
 				     &nc_path->hash_entry);
 
@@ -1242,7 +1254,8 @@ batadv_nc_path_search(struct batadv_priv *bat_priv,
 	/* Create almost path key */
 	batadv_nc_hash_key_gen(&nc_path_key, in_nc_node->addr,
 			       out_nc_node->addr);
-	idx = batadv_nc_hash_choose(&nc_path_key, hash->size);
+	idx = batadv_nc_hash_choose(&nc_path_key,
+				    1u << BATADV_NC_CODING_HASH_BITS);
 
 	/* Check for coding opportunities in this nc_path */
 	rcu_read_lock();
@@ -1490,6 +1503,7 @@ bool batadv_nc_skb_forward(struct sk_buff *skb,
 	/* Find or create a nc_path for this src-dst pair */
 	nc_path = batadv_nc_get_path(bat_priv,
 				     bat_priv->nc.coding_hash,
+				     1u << BATADV_NC_CODING_HASH_BITS,
 				     ethhdr->h_source,
 				     neigh_node->addr);
 
@@ -1539,6 +1553,7 @@ void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 	/* Find existing nc_path or create a new */
 	nc_path = batadv_nc_get_path(bat_priv,
 				     bat_priv->nc.decoding_hash,
+				     1u << BATADV_NC_DECODING_HASH_BITS,
 				     ethhdr->h_source,
 				     ethhdr->h_dest);
 
@@ -1721,7 +1736,8 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 	}
 
 	batadv_nc_hash_key_gen(&nc_path_key, source, dest);
-	index = batadv_nc_hash_choose(&nc_path_key, hash->size);
+	index = batadv_nc_hash_choose(&nc_path_key,
+				      1u << BATADV_NC_DECODING_HASH_BITS);
 
 	/* Search for matching coding path */
 	rcu_read_lock();
@@ -1830,9 +1846,11 @@ void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_NC, 1);
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 
-	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
+	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash,
+			      1u << BATADV_NC_CODING_HASH_BITS, NULL);
 	batadv_hash_destroy(bat_priv->nc.coding_hash);
-	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash, NULL);
+	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash,
+			      1u << BATADV_NC_DECODING_HASH_BITS, NULL);
 	batadv_hash_destroy(bat_priv->nc.decoding_hash);
 }
 
@@ -1857,7 +1875,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	/* Traverse list of originators */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		/* For each orig_node in this bin */
diff --git a/originator.c b/originator.c
index 34ca176..55baa3d 100644
--- a/originator.c
+++ b/originator.c
@@ -136,6 +136,7 @@ int batadv_originator_init(struct batadv_priv *bat_priv)
 		goto err;
 
 	batadv_hash_set_lock_class(bat_priv->orig_hash,
+				   1u << BATADV_ORIG_HASH_BITS,
 				   &batadv_orig_hash_lock_class_key);
 
 	INIT_DELAYED_WORK(&bat_priv->orig_work, batadv_purge_orig);
@@ -615,7 +616,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 
 	bat_priv->orig_hash = NULL;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -964,7 +965,7 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 		return;
 
 	/* for all origins... */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1098,7 +1099,7 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1135,7 +1136,7 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
diff --git a/originator.h b/originator.h
index a179c03..89b810d 100644
--- a/originator.h
+++ b/originator.h
@@ -92,7 +92,7 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, hash->size);
+	index = batadv_choose_orig(data, 1u << BATADV_ORIG_HASH_BITS);
 	head = &hash->table[index];
 
 	rcu_read_lock();
diff --git a/translation-table.c b/translation-table.c
index 1562e26..60be9c6 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -83,8 +83,8 @@ static inline uint32_t batadv_choose_tt(const void *data, uint32_t size)
  * found, NULL otherwise.
  */
 static struct batadv_tt_common_entry *
-batadv_tt_hash_find(struct batadv_hashtable *hash, const uint8_t *addr,
-		    unsigned short vid)
+batadv_tt_hash_find(struct batadv_hashtable *hash, uint32_t size,
+		    const uint8_t *addr, unsigned short vid)
 {
 	struct hlist_head *head;
 	struct batadv_tt_common_entry to_search, *tt, *tt_tmp = NULL;
@@ -96,7 +96,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const uint8_t *addr,
 	ether_addr_copy(to_search.addr, addr);
 	to_search.vid = vid;
 
-	index = batadv_choose_tt(&to_search, hash->size);
+	index = batadv_choose_tt(&to_search, size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
@@ -134,8 +134,9 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const uint8_t *addr,
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 
-	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash, addr,
-					      vid);
+	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash,
+					      1u << BATADV_TT_LOCAL_HASH_BITS,
+					      addr, vid);
 	if (tt_common_entry)
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
@@ -159,8 +160,9 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const uint8_t *addr,
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 
-	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash, addr,
-					      vid);
+	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash,
+					      1u << BATADV_TT_GLOBAL_HASH_BITS,
+					      addr, vid);
 	if (tt_common_entry)
 		tt_global_entry = container_of(tt_common_entry,
 					       struct batadv_tt_global_entry,
@@ -470,7 +472,7 @@ static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->tt.local_hash)
 		return -ENOMEM;
 
-	batadv_hash_set_lock_class(bat_priv->tt.local_hash,
+	batadv_hash_set_lock_class(bat_priv->tt.local_hash, hash_size,
 				   &batadv_tt_local_hash_lock_class_key);
 
 	return 0;
@@ -485,7 +487,8 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 		   tt_global->common.addr,
 		   BATADV_PRINT_VID(tt_global->common.vid), message);
 
-	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
+	batadv_hash_remove(bat_priv->tt.global_hash,
+			   1u << BATADV_TT_GLOBAL_HASH_BITS, batadv_compare_tt,
 			   batadv_choose_tt, &tt_global->common);
 	batadv_tt_global_entry_free_ref(tt_global);
 }
@@ -599,8 +602,10 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	    is_multicast_ether_addr(addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
-	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-				     batadv_choose_tt, &tt_local->common,
+	hash_added = batadv_hash_add(bat_priv->tt.local_hash,
+				     1u << BATADV_TT_LOCAL_HASH_BITS,
+				     batadv_compare_tt, batadv_choose_tt,
+				     &tt_local->common,
 				     &tt_local->common.hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -924,7 +929,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s  %s %-8s %-9s (%-10s)\n", "Client", "VID",
 		   "Flags", "Last seen", "CRC");
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1104,7 +1109,7 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1130,7 +1135,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 
 	hash = bat_priv->tt.local_hash;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1170,7 +1175,7 @@ static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->tt.global_hash)
 		return -ENOMEM;
 
-	batadv_hash_set_lock_class(bat_priv->tt.global_hash,
+	batadv_hash_set_lock_class(bat_priv->tt.global_hash, hash_size,
 				   &batadv_tt_global_hash_lock_class_key);
 
 	return 0;
@@ -1348,6 +1353,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		spin_lock_init(&tt_global_entry->list_lock);
 
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
+					     1u << BATADV_TT_GLOBAL_HASH_BITS,
 					     batadv_compare_tt,
 					     batadv_choose_tt, common,
 					     &common->hash_entry);
@@ -1591,7 +1597,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		   "Client", "VID", "(TTVN)", "Originator", "(Curr TTVN)",
 		   "CRC", "Flags");
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -1813,7 +1819,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1879,7 +1885,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -1922,7 +1928,7 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 
 	hash = bat_priv->tt.global_hash;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
@@ -2057,7 +2063,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	uint8_t flags;
 	__be16 tmp_vid;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -2132,7 +2138,7 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	uint8_t flags;
 	__be16 tmp_vid;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -2288,6 +2294,7 @@ static int batadv_tt_global_valid(const void *entry_ptr,
  *  specified tt hash
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the tt entries
+ * @hash_size: number of buckets in the hashtable
  * @tt_len: expected tvlv tt data buffer length in number of bytes
  * @tvlv_buff: pointer to the buffer to fill with the TT data
  * @valid_cb: function to filter tt change entries
@@ -2295,7 +2302,8 @@ static int batadv_tt_global_valid(const void *entry_ptr,
  */
 static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 				    struct batadv_hashtable *hash,
-				    void *tvlv_buff, uint16_t tt_len,
+				    uint32_t hash_size, void *tvlv_buff,
+				    uint16_t tt_len,
 				    int (*valid_cb)(const void *, const void *),
 				    void *cb_data)
 {
@@ -2309,7 +2317,7 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_buff;
 
 	rcu_read_lock();
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < hash_size; i++) {
 		head = &hash->table[i];
 
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -2589,6 +2597,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 
 		/* fill the rest of the tvlv with the real TT entries */
 		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.global_hash,
+					1u << BATADV_TT_GLOBAL_HASH_BITS,
 					tt_change, tt_len,
 					batadv_tt_global_valid,
 					req_dst_orig_node);
@@ -2718,6 +2727,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 
 		/* fill the rest of the tvlv with the real TT entries */
 		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.local_hash,
+					1u << BATADV_TT_LOCAL_HASH_BITS,
 					tt_change, tt_len,
 					batadv_tt_local_valid, NULL);
 	}
@@ -3123,7 +3133,7 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
@@ -3165,7 +3175,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
+	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
-- 
2.1.4

