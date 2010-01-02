Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:39 +0100
Message-Id: <1262428252-26439-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-3-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
	<1262428252-26439-3-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 04/17] Staging: batman-adv: initialize static
	hash iterators
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

instead of dynamically registering hash iterators, calling functions are
changed to register the iterator objects statically. The two advantages are:

 * no memory leaks when aborting from hash_iterate()
 * no calls to kmalloc/kfree, therefore a little faster/safer

Tested with 9 QEMU instances, no obvious regression found.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/hard-interface.c    |    6 ++--
 drivers/staging/batman-adv/hash.c              |   23 ++++++-----------
 drivers/staging/batman-adv/hash.h              |    5 +++
 drivers/staging/batman-adv/originator.c        |    8 +++---
 drivers/staging/batman-adv/proc.c              |   12 ++++----
 drivers/staging/batman-adv/routing.c           |    6 ++--
 drivers/staging/batman-adv/translation-table.c |   24 ++++++++--------
 drivers/staging/batman-adv/vis.c               |   33 +++++++++++------------
 8 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 28d02f6..7c88592 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -318,7 +318,7 @@ int hardif_add_interface(char *dev, int if_num)
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet;
 	struct orig_node *orig_node;
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_KERNEL);
 
@@ -377,8 +377,8 @@ int hardif_add_interface(char *dev, int if_num)
 	 * if_num */
 	spin_lock(&orig_hash_lock);
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (hash_iterate(orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
 		if (resize_orig(orig_node, if_num) == -1) {
 			spin_unlock(&orig_hash_lock);
 			goto out;
diff --git a/drivers/staging/batman-adv/hash.c b/drivers/staging/batman-adv/hash.c
index 61cb4a2..5a2018d 100644
--- a/drivers/staging/batman-adv/hash.c
+++ b/drivers/staging/batman-adv/hash.c
@@ -64,24 +64,18 @@ void hash_destroy(struct hashtable_t *hash)
 	kfree(hash);
 }
 
-/* iterate though the hash. first element is selected with iter_in NULL.  use
- * the returned iterator to access the elements until hash_it_t returns NULL. */
+/* iterate though the hash. First element is selected if an iterator
+ * initialized with HASHIT() is supplied as iter. Use the returned
+ * (or supplied) iterator to access the elements until hash_iterate returns
+ * NULL. */
+
 struct hash_it_t *hash_iterate(struct hashtable_t *hash,
-			       struct hash_it_t *iter_in)
+			       struct hash_it_t *iter)
 {
-	struct hash_it_t *iter;
-
 	if (!hash)
 		return NULL;
-
-	if (iter_in == NULL) {
-		iter = kmalloc(sizeof(struct hash_it_t), GFP_ATOMIC);
-		iter->index = -1;
-		iter->bucket = NULL;
-		iter->prev_bucket = NULL;
-	} else {
-		iter = iter_in;
-	}
+	if (!iter)
+		return NULL;
 
 	/* sanity checks first (if our bucket got deleted in the last
 	 * iteration): */
@@ -139,7 +133,6 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 	}
 
 	/* nothing to iterate over anymore */
-	kfree(iter);
 	return NULL;
 }
 
diff --git a/drivers/staging/batman-adv/hash.h b/drivers/staging/batman-adv/hash.h
index bb60f08..a70d6d6 100644
--- a/drivers/staging/batman-adv/hash.h
+++ b/drivers/staging/batman-adv/hash.h
@@ -21,6 +21,11 @@
 
 #ifndef _BATMAN_HASH_H
 #define _BATMAN_HASH_H
+#define HASHIT(name) struct hash_it_t name = { \
+		.index = -1, .bucket = NULL, \
+		.prev_bucket = NULL, \
+		.first_bucket = NULL }
+
 
 typedef int (*hashdata_compare_cb)(void *, void *);
 typedef int (*hashdata_choose_cb)(void *, int);
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 80106f7..9ac8da3 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -221,16 +221,16 @@ static bool purge_orig_node(struct orig_node *orig_node)
 
 void purge_orig(struct work_struct *work)
 {
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	struct orig_node *orig_node;
 
 	spin_lock(&orig_hash_lock);
 
 	/* for all origins... */
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (hash_iterate(orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
 		if (purge_orig_node(orig_node)) {
-			hash_remove_bucket(orig_hash, hashit);
+			hash_remove_bucket(orig_hash, &hashit);
 			free_orig_node(orig_node);
 		}
 	}
diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index f476d9c..f693a0e 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -186,7 +186,7 @@ static int proc_orig_interval_open(struct inode *inode, struct file *file)
 
 static int proc_originators_read(struct seq_file *seq, void *offset)
 {
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
 	int batman_count = 0;
@@ -215,9 +215,9 @@ static int proc_originators_read(struct seq_file *seq, void *offset)
 	rcu_read_unlock();
 	spin_lock(&orig_hash_lock);
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
+	while (hash_iterate(orig_hash, &hashit)) {
 
-		orig_node = hashit->bucket->data;
+		orig_node = hashit.bucket->data;
 
 		if (!orig_node->router)
 			continue;
@@ -413,7 +413,7 @@ static void proc_vis_read_entry(struct seq_file *seq,
 
 static int proc_vis_read(struct seq_file *seq, void *offset)
 {
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	struct vis_info *info;
 	struct vis_info_entry *entries;
 	struct vis_if_list *if_entries = NULL;
@@ -440,8 +440,8 @@ static int proc_vis_read(struct seq_file *seq, void *offset)
 		seq_printf(seq, "digraph {\n");
 
 	spin_lock(&vis_hash_lock);
-	while (NULL != (hashit = hash_iterate(vis_hash, hashit))) {
-		info = hashit->bucket->data;
+	while (hash_iterate(vis_hash, &hashit)) {
+		info = hashit.bucket->data;
 		entries = (struct vis_info_entry *)
 			((char *)info + sizeof(struct vis_info));
 
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 87d7552..89d7faa 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -40,14 +40,14 @@ static atomic_t data_ready_cond;
 atomic_t exit_cond;
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	struct orig_node *orig_node;
 	TYPE_OF_WORD *word;
 
 	spin_lock(&orig_hash_lock);
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (hash_iterate(orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
 		word = &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
 
 		bit_get_packet(word, 1, 0);
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index c7122da..088715b 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -134,18 +134,18 @@ void hna_local_add(uint8_t *addr)
 int hna_local_fill_buffer(unsigned char *buff, int buff_len)
 {
 	struct hna_local_entry *hna_local_entry;
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	int i = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 
-	while (NULL != (hashit = hash_iterate(hna_local_hash, hashit))) {
+	while (hash_iterate(hna_local_hash, &hashit)) {
 
 		if (buff_len < (i + 1) * ETH_ALEN)
 			break;
 
-		hna_local_entry = hashit->bucket->data;
+		hna_local_entry = hashit.bucket->data;
 		memcpy(buff + (i * ETH_ALEN), hna_local_entry->addr, ETH_ALEN);
 
 		i++;
@@ -163,18 +163,18 @@ int hna_local_fill_buffer(unsigned char *buff, int buff_len)
 int hna_local_fill_buffer_text(unsigned char *buff, int buff_len)
 {
 	struct hna_local_entry *hna_local_entry;
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	int bytes_written = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 
-	while (NULL != (hashit = hash_iterate(hna_local_hash, hashit))) {
+	while (hash_iterate(hna_local_hash, &hashit)) {
 
 		if (buff_len < bytes_written + ETH_STR_LEN + 4)
 			break;
 
-		hna_local_entry = hashit->bucket->data;
+		hna_local_entry = hashit.bucket->data;
 
 		bytes_written += snprintf(buff + bytes_written, ETH_STR_LEN + 4,
 					  " * %02x:%02x:%02x:%02x:%02x:%02x\n",
@@ -214,14 +214,14 @@ static void hna_local_del(struct hna_local_entry *hna_local_entry,
 void hna_local_purge(struct work_struct *work)
 {
 	struct hna_local_entry *hna_local_entry;
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	unsigned long flags;
 	unsigned long timeout;
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 
-	while (NULL != (hashit = hash_iterate(hna_local_hash, hashit))) {
-		hna_local_entry = hashit->bucket->data;
+	while (hash_iterate(hna_local_hash, &hashit)) {
+		hna_local_entry = hashit.bucket->data;
 
 		timeout = hna_local_entry->last_seen +
 			((LOCAL_HNA_TIMEOUT / 1000) * HZ);
@@ -345,17 +345,17 @@ void hna_global_add_orig(struct orig_node *orig_node,
 int hna_global_fill_buffer_text(unsigned char *buff, int buff_len)
 {
 	struct hna_global_entry *hna_global_entry;
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	int bytes_written = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
 
-	while (NULL != (hashit = hash_iterate(hna_global_hash, hashit))) {
+	while (hash_iterate(hna_global_hash, &hashit)) {
 		if (buff_len < bytes_written + (2 * ETH_STR_LEN) + 10)
 			break;
 
-		hna_global_entry = hashit->bucket->data;
+		hna_global_entry = hashit.bucket->data;
 
 		bytes_written += snprintf(buff + bytes_written,
 					  (2 * ETH_STR_LEN) + 10,
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index c26d48c..ac7c7c5 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -266,12 +266,12 @@ end:
  * Must be called with the originator hash locked */
 static int find_best_vis_server(struct vis_info *info)
 {
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	struct orig_node *orig_node;
 	int best_tq = -1;
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (hash_iterate(orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
 		if ((orig_node != NULL) &&
 		    (orig_node->router != NULL) &&
 		    (orig_node->flags & VIS_SERVER) &&
@@ -297,7 +297,8 @@ static bool vis_packet_full(struct vis_info *info)
  * returns 0 on success, -1 if no packet could be generated */
 static int generate_vis_packet(void)
 {
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit_local);
+	HASHIT(hashit_global);
 	struct orig_node *orig_node;
 	struct vis_info *info = (struct vis_info *)my_vis_info;
 	struct vis_info_entry *entry, *entry_array;
@@ -320,13 +321,12 @@ static int generate_vis_packet(void)
 			return -1;
 		}
 	}
-	hashit = NULL;
 
 	entry_array = (struct vis_info_entry *)
 		((char *)info + sizeof(struct vis_info));
 
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (hash_iterate(orig_hash, &hashit_global)) {
+		orig_node = hashit_global.bucket->data;
 		if (orig_node->router != NULL
 			&& compare_orig(orig_node->router->addr, orig_node->orig)
 			&& orig_node->batman_if
@@ -349,10 +349,9 @@ static int generate_vis_packet(void)
 
 	spin_unlock(&orig_hash_lock);
 
-	hashit = NULL;
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
-	while (NULL != (hashit = hash_iterate(hna_local_hash, hashit))) {
-		hna_local_entry = hashit->bucket->data;
+	while (hash_iterate(hna_local_hash, &hashit_local)) {
+		hna_local_entry = hashit_local.bucket->data;
 		entry = &entry_array[info->packet.entries];
 		memset(entry->src, 0, ETH_ALEN);
 		memcpy(entry->dest, hna_local_entry->addr, ETH_ALEN);
@@ -370,16 +369,16 @@ static int generate_vis_packet(void)
 
 static void purge_vis_packets(void)
 {
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	struct vis_info *info;
 
-	while (NULL != (hashit = hash_iterate(vis_hash, hashit))) {
-		info = hashit->bucket->data;
+	while (hash_iterate(vis_hash, &hashit)) {
+		info = hashit.bucket->data;
 		if (info == my_vis_info)	/* never purge own data. */
 			continue;
 		if (time_after(jiffies,
 			       info->first_seen + (VIS_TIMEOUT/1000)*HZ)) {
-			hash_remove_bucket(vis_hash, hashit);
+			hash_remove_bucket(vis_hash, &hashit);
 			free_info(info);
 		}
 	}
@@ -387,14 +386,14 @@ static void purge_vis_packets(void)
 
 static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 {
-	struct hash_it_t *hashit = NULL;
+	HASHIT(hashit);
 	struct orig_node *orig_node;
 
 	spin_lock(&orig_hash_lock);
 
 	/* send to all routers in range. */
-	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
-		orig_node = hashit->bucket->data;
+	while (hash_iterate(orig_hash, &hashit)) {
+		orig_node = hashit.bucket->data;
 
 		/* if it's a vis server and reachable, send it. */
 		if (orig_node &&
-- 
1.6.5.7

