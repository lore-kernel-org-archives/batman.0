Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  9 Oct 2010 14:16:40 +0200
Message-Id: <1286626600-23439-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1286626600-23439-1-git-send-email-sven.eckelmann@gmx.de>
References: <1286626600-23439-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: Rewrite hash using hlist_*
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The hash implementation is a complete implementation of a hash using
buckets as hash entries and overflow buckets attached to them.

The kernel already provides datastructures hlist_head and hlist_node
which can be used to implement an hash using lists as hash buckets. So
it is better to implement heavily used functionality on top of those
instead of providing a full hash implementation.

The rewrite changes the behavior of some functions slightly:
 * hash_add add elements to the front instead of the tail
 * hash_iterate doesn't provide pointer to access bucket->data directly,
   but it can be accessed using hlist_entry

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/hash.c              |   14 ++--
 batman-adv/hash.h              |  172 ++++++++++++++++------------------------
 batman-adv/originator.c        |   17 +++-
 batman-adv/routing.c           |    4 +-
 batman-adv/translation-table.c |   16 +++-
 batman-adv/vis.c               |   29 +++++--
 6 files changed, 122 insertions(+), 130 deletions(-)

diff --git a/batman-adv/hash.c b/batman-adv/hash.c
index bfe943c..8605e2f 100644
--- a/batman-adv/hash.c
+++ b/batman-adv/hash.c
@@ -30,7 +30,7 @@ static void hash_init(struct hashtable_t *hash)
 	hash->elements = 0;
 
 	for (i = 0 ; i < hash->size; i++)
-		hash->table[i] = NULL;
+		INIT_HLIST_HEAD(&hash->table[i]);
 }
 
 /* free only the hashtable and the hash itself. */
@@ -70,15 +70,13 @@ struct hashtable_t *hash_new(int size)
 void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
 {
 	void *data_save;
+	struct element_t *bucket;
 
-	data_save = hash_it_t->bucket->data;
+	bucket = hlist_entry(hash_it_t->walk, struct element_t, hlist);
+	data_save = bucket->data;
 
-	if (hash_it_t->prev_bucket != NULL)
-		hash_it_t->prev_bucket->next = hash_it_t->bucket->next;
-	else if (hash_it_t->first_bucket != NULL)
-		(*hash_it_t->first_bucket) = hash_it_t->bucket->next;
-
-	kfree(hash_it_t->bucket);
+	hlist_del(hash_it_t->walk);
+	kfree(bucket);
 	hash->elements--;
 
 	return data_save;
diff --git a/batman-adv/hash.h b/batman-adv/hash.h
index a8e4dd1..d42cfd2 100644
--- a/batman-adv/hash.h
+++ b/batman-adv/hash.h
@@ -22,10 +22,11 @@
 #ifndef _NET_BATMAN_ADV_HASH_H_
 #define _NET_BATMAN_ADV_HASH_H_
 
+#include <linux/list.h>
+
 #define HASHIT(name) struct hash_it_t name = { \
-		.index = -1, .bucket = NULL, \
-		.prev_bucket = NULL, \
-		.first_bucket = NULL }
+		.index = 0, .walk = NULL, \
+		.safe = NULL, .head = NULL }
 
 /* callback to a compare function.  should
  * compare 2 element datas for their keys,
@@ -41,18 +42,18 @@ typedef void (*hashdata_free_cb)(void *, void *);
 
 struct element_t {
 	void *data;		/* pointer to the data */
-	struct element_t *next;	/* overflow bucket pointer */
+	struct hlist_node hlist;	/* bucket list pointer */
 };
 
 struct hash_it_t {
-	int index;
-	struct element_t *bucket;
-	struct element_t *prev_bucket;
-	struct element_t **first_bucket;
+	size_t index;
+	struct hlist_node *walk;
+	struct hlist_head *head;
+	struct hlist_node *safe;
 };
 
 struct hashtable_t {
-	struct element_t **table;   /* the hashtable itself, with the buckets */
+	struct hlist_head *table;   /* the hashtable itself, with the buckets */
 	int elements;		    /* number of elements registered */
 	int size;		    /* size of hashtable */
 };
@@ -75,19 +76,21 @@ void hash_destroy(struct hashtable_t *hash);
 static inline void hash_delete(struct hashtable_t *hash,
 			       hashdata_free_cb free_cb, void *arg)
 {
-	struct element_t *bucket, *last_bucket;
+	struct hlist_head *head;
+	struct hlist_node *walk, *safe;
+	struct element_t *bucket;
 	int i;
 
 	for (i = 0; i < hash->size; i++) {
-		bucket = hash->table[i];
+		head = &hash->table[i];
 
-		while (bucket != NULL) {
+		hlist_for_each_safe(walk, safe, head) {
+			bucket = hlist_entry(walk, struct element_t, hlist);
 			if (free_cb != NULL)
 				free_cb(bucket->data, arg);
 
-			last_bucket = bucket;
-			bucket = bucket->next;
-			kfree(last_bucket);
+			hlist_del(walk);
+			kfree(bucket);
 		}
 	}
 
@@ -100,36 +103,30 @@ static inline int hash_add(struct hashtable_t *hash,
 			   hashdata_choose_cb choose, void *data)
 {
 	int index;
-	struct element_t *bucket, *prev_bucket = NULL;
+	struct hlist_head *head;
+	struct hlist_node *walk, *safe;
+	struct element_t *bucket;
 
 	if (!hash)
 		return -1;
 
 	index = choose(data, hash->size);
-	bucket = hash->table[index];
+	head = &hash->table[index];
 
-	while (bucket != NULL) {
+	hlist_for_each_safe(walk, safe, head) {
+		bucket = hlist_entry(walk, struct element_t, hlist);
 		if (compare(bucket->data, data))
 			return -1;
-
-		prev_bucket = bucket;
-		bucket = bucket->next;
 	}
 
-	/* found the tail of the list, add new element */
+	/* no duplicate found in list, add new element */
 	bucket = kmalloc(sizeof(struct element_t), GFP_ATOMIC);
 
 	if (bucket == NULL)
 		return -1;
 
 	bucket->data = data;
-	bucket->next = NULL;
-
-	/* and link it */
-	if (prev_bucket == NULL)
-		hash->table[index] = bucket;
-	else
-		prev_bucket->next = bucket;
+	hlist_add_head(&bucket->hlist, head);
 
 	hash->elements++;
 	return 0;
@@ -144,22 +141,15 @@ static inline void *hash_remove(struct hashtable_t *hash,
 				hashdata_choose_cb choose, void *data)
 {
 	struct hash_it_t hash_it_t;
+	struct element_t *bucket;
 
 	hash_it_t.index = choose(data, hash->size);
-	hash_it_t.bucket = hash->table[hash_it_t.index];
-	hash_it_t.prev_bucket = NULL;
+	hash_it_t.head = &hash->table[hash_it_t.index];
 
-	while (hash_it_t.bucket != NULL) {
-		if (compare(hash_it_t.bucket->data, data)) {
-			hash_it_t.first_bucket =
-				(hash_it_t.bucket ==
-				 hash->table[hash_it_t.index] ?
-				 &hash->table[hash_it_t.index] : NULL);
+	hlist_for_each(hash_it_t.walk, hash_it_t.head) {
+		bucket = hlist_entry(hash_it_t.walk, struct element_t, hlist);
+		if (compare(bucket->data, data))
 			return hash_remove_bucket(hash, &hash_it_t);
-		}
-
-		hash_it_t.prev_bucket = hash_it_t.bucket;
-		hash_it_t.bucket = hash_it_t.bucket->next;
 	}
 
 	return NULL;
@@ -172,19 +162,20 @@ static inline void *hash_find(struct hashtable_t *hash,
 			      hashdata_choose_cb choose, void *keydata)
 {
 	int index;
+	struct hlist_head *head;
+	struct hlist_node *walk;
 	struct element_t *bucket;
 
 	if (!hash)
 		return NULL;
 
 	index = choose(keydata , hash->size);
-	bucket = hash->table[index];
+	head = &hash->table[index];
 
-	while (bucket != NULL) {
+	hlist_for_each(walk, head) {
+		bucket = hlist_entry(walk, struct element_t, hlist);
 		if (compare(bucket->data, keydata))
 			return bucket->data;
-
-		bucket = bucket->next;
 	}
 
 	return NULL;
@@ -198,8 +189,10 @@ static inline struct hashtable_t *hash_resize(struct hashtable_t *hash,
 					      int size)
 {
 	struct hashtable_t *new_hash;
+	struct hlist_head *head, *new_head;
+	struct hlist_node *walk, *safe;
 	struct element_t *bucket;
-	int i;
+	int i, new_index;
 
 	/* initialize a new hash with the new size */
 	new_hash = hash_new(size);
@@ -209,17 +202,20 @@ static inline struct hashtable_t *hash_resize(struct hashtable_t *hash,
 
 	/* copy the elements */
 	for (i = 0; i < hash->size; i++) {
-		bucket = hash->table[i];
+		head = &hash->table[i];
 
-		while (bucket != NULL) {
-			hash_add(new_hash, compare, choose, bucket->data);
-			bucket = bucket->next;
+		hlist_for_each_safe(walk, safe, head) {
+			bucket = hlist_entry(walk, struct element_t, hlist);
+
+			new_index = choose(bucket->data, size);
+			new_head = &new_hash->table[new_index];
+
+			hlist_del(walk);
+			hlist_add_head(walk, new_head);
 		}
 	}
 
-	/* remove hash and eventual overflow buckets but not the content
-	 * itself. */
-	hash_delete(hash, NULL, NULL);
+	hash_destroy(hash);
 
 	return new_hash;
 }
@@ -236,63 +232,29 @@ static inline struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 	if (!iter)
 		return NULL;
 
-	/* sanity checks first (if our bucket got deleted in the last
-	 * iteration): */
-	if (iter->bucket != NULL) {
-		if (iter->first_bucket != NULL) {
-			/* we're on the first element and it got removed after
-			 * the last iteration. */
-			if ((*iter->first_bucket) != iter->bucket) {
-				/* there are still other elements in the list */
-				if ((*iter->first_bucket) != NULL) {
-					iter->prev_bucket = NULL;
-					iter->bucket = (*iter->first_bucket);
-					iter->first_bucket =
-						&hash->table[iter->index];
-					return iter;
-				} else {
-					iter->bucket = NULL;
-				}
+	iter->walk = iter->safe;
+
+	/* we search for the next head with list entries */
+	if (!iter->walk) {
+		while (iter->index < hash->size) {
+			if (hlist_empty(&hash->table[iter->index]))
+				iter->index++;
+			else {
+				iter->walk = hash->table[iter->index].first;
+
+				/* search next time */
+				++iter->index;
+				break;
 			}
-		} else if (iter->prev_bucket != NULL) {
-			/*
-			* we're not on the first element, and the bucket got
-			* removed after the last iteration.  the last bucket's
-			* next pointer is not pointing to our actual bucket
-			* anymore.  select the next.
-			*/
-			if (iter->prev_bucket->next != iter->bucket)
-				iter->bucket = iter->prev_bucket;
 		}
 	}
 
-	/* now as we are sane, select the next one if there is some */
-	if (iter->bucket != NULL) {
-		if (iter->bucket->next != NULL) {
-			iter->prev_bucket = iter->bucket;
-			iter->bucket = iter->bucket->next;
-			iter->first_bucket = NULL;
-			return iter;
-		}
-	}
-
-	/* if not returned yet, we've reached the last one on the index and have
-	 * to search forward */
-	iter->index++;
-	/* go through the entries of the hash table */
-	while (iter->index < hash->size) {
-		if ((hash->table[iter->index]) != NULL) {
-			iter->prev_bucket = NULL;
-			iter->bucket = hash->table[iter->index];
-			iter->first_bucket = &hash->table[iter->index];
-			return iter;
-		} else {
-			iter->index++;
-		}
-	}
+	/* return iter when we found bucket otherwise null */
+	if (!iter->walk)
+		return NULL;
 
-	/* nothing to iterate over anymore */
-	return NULL;
+	iter->safe = iter->walk->next;
+	return iter;
 }
 
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 0927119..67d9821 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -274,6 +274,7 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 static void _purge_orig(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit);
+	struct element_t *bucket;
 	struct orig_node *orig_node;
 	unsigned long flags;
 
@@ -281,7 +282,8 @@ static void _purge_orig(struct bat_priv *bat_priv)
 
 	/* for all origins... */
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		orig_node = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
 
 		if (purge_orig_node(bat_priv, orig_node)) {
 			if (orig_node->gw_flags)
@@ -322,6 +324,7 @@ void purge_orig_ref(struct bat_priv *bat_priv)
 int orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	HASHIT(hashit);
+	struct element_t *bucket;
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct orig_node *orig_node;
@@ -355,8 +358,8 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-
-		orig_node = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
 
 		if (!orig_node->router)
 			continue;
@@ -430,13 +433,15 @@ int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 	struct orig_node *orig_node;
 	unsigned long flags;
 	HASHIT(hashit);
+	struct element_t *bucket;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		orig_node = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
 
 		if (orig_node_add_if(orig_node, max_if_num) == -1)
 			goto err;
@@ -509,6 +514,7 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 	struct orig_node *orig_node;
 	unsigned long flags;
 	HASHIT(hashit);
+	struct element_t *bucket;
 	int ret;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
@@ -516,7 +522,8 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		orig_node = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
 
 		ret = orig_node_del_if(orig_node, max_if_num,
 				       batman_if->if_num);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index bdb8460..797ccd1 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -40,6 +40,7 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	HASHIT(hashit);
+	struct element_t *bucket;
 	struct orig_node *orig_node;
 	TYPE_OF_WORD *word;
 	unsigned long flags;
@@ -47,7 +48,8 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		orig_node = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
 		word = &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
 
 		bit_get_packet(bat_priv, word, 1, 0);
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index 20e1a74..66b7b08 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -142,6 +142,7 @@ int hna_local_fill_buffer(struct bat_priv *bat_priv,
 			  unsigned char *buff, int buff_len)
 {
 	struct hna_local_entry *hna_local_entry;
+	struct element_t *bucket;
 	HASHIT(hashit);
 	int i = 0;
 	unsigned long flags;
@@ -153,7 +154,8 @@ int hna_local_fill_buffer(struct bat_priv *bat_priv,
 		if (buff_len < (i + 1) * ETH_ALEN)
 			break;
 
-		hna_local_entry = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		hna_local_entry = bucket->data;
 		memcpy(buff + (i * ETH_ALEN), hna_local_entry->addr, ETH_ALEN);
 
 		i++;
@@ -174,6 +176,7 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
 	HASHIT(hashit_count);
+	struct element_t *bucket;
 	unsigned long flags;
 	size_t buf_size, pos;
 	char *buff;
@@ -204,7 +207,8 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 	pos = 0;
 
 	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
-		hna_local_entry = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		hna_local_entry = bucket->data;
 
 		pos += snprintf(buff + pos, 22, " * %pM\n",
 				hna_local_entry->addr);
@@ -263,13 +267,15 @@ static void hna_local_purge(struct work_struct *work)
 		container_of(delayed_work, struct bat_priv, hna_work);
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
+	struct element_t *bucket;
 	unsigned long flags;
 	unsigned long timeout;
 
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
 	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
-		hna_local_entry = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		hna_local_entry = bucket->data;
 
 		timeout = hna_local_entry->last_seen + LOCAL_HNA_TIMEOUT * HZ;
 
@@ -405,6 +411,7 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 	struct hna_global_entry *hna_global_entry;
 	HASHIT(hashit);
 	HASHIT(hashit_count);
+	struct element_t *bucket;
 	unsigned long flags;
 	size_t buf_size, pos;
 	char *buff;
@@ -434,7 +441,8 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 	pos = 0;
 
 	while (hash_iterate(bat_priv->hna_global_hash, &hashit)) {
-		hna_global_entry = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		hna_global_entry = bucket->data;
 
 		pos += snprintf(buff + pos, 44,
 				" * %pM via %pM\n", hna_global_entry->addr,
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 88402c9..9e41f81 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -183,6 +183,7 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 {
 	HASHIT(hashit);
 	HASHIT(hashit_count);
+	struct element_t *bucket;
 	struct vis_info *info;
 	struct vis_packet *packet;
 	struct vis_info_entry *entries;
@@ -206,7 +207,9 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	/* Estimate length */
 	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
 	while (hash_iterate(bat_priv->vis_hash, &hashit_count)) {
-		info = hashit_count.bucket->data;
+		bucket = hlist_entry(hashit_count.walk, struct element_t,
+				     hlist);
+		info = bucket->data;
 		packet = (struct vis_packet *)info->skb_packet->data;
 		entries = (struct vis_info_entry *)
 			  ((char *)packet + sizeof(struct vis_packet));
@@ -244,7 +247,8 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	buff_pos = 0;
 
 	while (hash_iterate(bat_priv->vis_hash, &hashit)) {
-		info = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		info = bucket->data;
 		packet = (struct vis_packet *)info->skb_packet->data;
 		entries = (struct vis_info_entry *)
 			  ((char *)packet + sizeof(struct vis_packet));
@@ -523,6 +527,7 @@ static int find_best_vis_server(struct bat_priv *bat_priv,
 				struct vis_info *info)
 {
 	HASHIT(hashit);
+	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct vis_packet *packet;
 	int best_tq = -1;
@@ -530,7 +535,8 @@ static int find_best_vis_server(struct bat_priv *bat_priv,
 	packet = (struct vis_packet *)info->skb_packet->data;
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		orig_node = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
 		if ((orig_node) && (orig_node->router) &&
 		    (orig_node->flags & VIS_SERVER) &&
 		    (orig_node->router->tq_avg > best_tq)) {
@@ -559,6 +565,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit_local);
 	HASHIT(hashit_global);
+	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct vis_info *info = (struct vis_info *)bat_priv->my_vis_info;
 	struct vis_packet *packet = (struct vis_packet *)info->skb_packet->data;
@@ -588,7 +595,9 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	}
 
 	while (hash_iterate(bat_priv->orig_hash, &hashit_global)) {
-		orig_node = hashit_global.bucket->data;
+		bucket = hlist_entry(hashit_global.walk, struct element_t,
+				     hlist);
+		orig_node = bucket->data;
 
 		if (!orig_node->router)
 			continue;
@@ -623,7 +632,9 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 	while (hash_iterate(bat_priv->hna_local_hash, &hashit_local)) {
-		hna_local_entry = hashit_local.bucket->data;
+		bucket = hlist_entry(hashit_local.walk, struct element_t,
+				     hlist);
+		hna_local_entry = bucket->data;
 		entry = (struct vis_info_entry *)skb_put(info->skb_packet,
 							 sizeof(*entry));
 		memset(entry->src, 0, ETH_ALEN);
@@ -647,10 +658,12 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 static void purge_vis_packets(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit);
+	struct element_t *bucket;
 	struct vis_info *info;
 
 	while (hash_iterate(bat_priv->vis_hash, &hashit)) {
-		info = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		info = bucket->data;
 
 		/* never purge own data. */
 		if (info == bat_priv->my_vis_info)
@@ -669,6 +682,7 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 				 struct vis_info *info)
 {
 	HASHIT(hashit);
+	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct vis_packet *packet;
 	struct sk_buff *skb;
@@ -682,7 +696,8 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 
 	/* send to all routers in range. */
 	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		orig_node = hashit.bucket->data;
+		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
+		orig_node = bucket->data;
 
 		/* if it's a vis server and reachable, send it. */
 		if ((!orig_node) || (!orig_node->router))
-- 
1.7.2.3

