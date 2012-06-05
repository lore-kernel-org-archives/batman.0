Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jun 2012 22:31:28 +0200
Message-Id: <1338928292-23085-2-git-send-email-sven@narfation.org>
In-Reply-To: <1338928292-23085-1-git-send-email-sven@narfation.org>
References: <1338928292-23085-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: Prefix hash struct and
	typedef with batadv_
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

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |   20 ++++++++++----------
 hash.c                  |   10 +++++-----
 hash.h                  |   33 ++++++++++++++++++---------------
 originator.c            |   10 +++++-----
 originator.h            |    2 +-
 routing.c               |    2 +-
 translation-table.c     |   30 +++++++++++++++---------------
 types.h                 |   12 ++++++------
 vis.c                   |   12 ++++++------
 9 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index bda92e0..edb5adc 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -133,7 +133,7 @@ static void batadv_claim_free_ref(struct claim *claim)
 static struct claim *batadv_claim_hash_find(struct bat_priv *bat_priv,
 					    struct claim *data)
 {
-	struct hashtable_t *hash = bat_priv->claim_hash;
+	struct batadv_hashtable *hash = bat_priv->claim_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct claim *claim;
@@ -172,7 +172,7 @@ static struct claim *batadv_claim_hash_find(struct bat_priv *bat_priv,
 static struct backbone_gw *batadv_backbone_hash_find(struct bat_priv *bat_priv,
 						     uint8_t *addr, short vid)
 {
-	struct hashtable_t *hash = bat_priv->backbone_hash;
+	struct batadv_hashtable *hash = bat_priv->backbone_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct backbone_gw search_entry, *backbone_gw;
@@ -208,7 +208,7 @@ static struct backbone_gw *batadv_backbone_hash_find(struct bat_priv *bat_priv,
 /* delete all claims for a backbone */
 static void batadv_bla_del_backbone_claims(struct backbone_gw *backbone_gw)
 {
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	struct claim *claim;
@@ -434,7 +434,7 @@ static void batadv_bla_answer_request(struct bat_priv *bat_priv,
 {
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 	struct claim *claim;
 	struct backbone_gw *backbone_gw;
 	int i;
@@ -931,7 +931,7 @@ static void batadv_bla_purge_backbone_gw(struct bat_priv *bat_priv, int now)
 	struct backbone_gw *backbone_gw;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 	int i;
 
@@ -983,7 +983,7 @@ static void batadv_bla_purge_claims(struct bat_priv *bat_priv,
 	struct claim *claim;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 	int i;
 
 	hash = bat_priv->claim_hash;
@@ -1030,7 +1030,7 @@ void batadv_bla_update_orig_address(struct bat_priv *bat_priv,
 	struct backbone_gw *backbone_gw;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 	int i;
 
 	/* reset bridge loop avoidance group id */
@@ -1091,7 +1091,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct backbone_gw *backbone_gw;
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 	struct hard_iface *primary_if;
 	int i;
 
@@ -1262,7 +1262,7 @@ int batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
  */
 int batadv_bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
 {
-	struct hashtable_t *hash = bat_priv->backbone_hash;
+	struct batadv_hashtable *hash = bat_priv->backbone_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct backbone_gw *backbone_gw;
@@ -1534,7 +1534,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	struct hashtable_t *hash = bat_priv->claim_hash;
+	struct batadv_hashtable *hash = bat_priv->claim_hash;
 	struct claim *claim;
 	struct hard_iface *primary_if;
 	struct hlist_node *node;
diff --git a/hash.c b/hash.c
index 4ab46d4..2b16381 100644
--- a/hash.c
+++ b/hash.c
@@ -21,7 +21,7 @@
 #include "hash.h"
 
 /* clears the hash */
-static void batadv_hash_init(struct hashtable_t *hash)
+static void batadv_hash_init(struct batadv_hashtable *hash)
 {
 	uint32_t i;
 
@@ -32,7 +32,7 @@ static void batadv_hash_init(struct hashtable_t *hash)
 }
 
 /* free only the hashtable and the hash itself. */
-void batadv_hash_destroy(struct hashtable_t *hash)
+void batadv_hash_destroy(struct batadv_hashtable *hash)
 {
 	kfree(hash->list_locks);
 	kfree(hash->table);
@@ -40,9 +40,9 @@ void batadv_hash_destroy(struct hashtable_t *hash)
 }
 
 /* allocates and clears the hash */
-struct hashtable_t *batadv_hash_new(uint32_t size)
+struct batadv_hashtable *batadv_hash_new(uint32_t size)
 {
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 
 	hash = kmalloc(sizeof(*hash), GFP_ATOMIC);
 	if (!hash)
@@ -68,7 +68,7 @@ free_hash:
 	return NULL;
 }
 
-void batadv_hash_set_lock_class(struct hashtable_t *hash,
+void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 				struct lock_class_key *key)
 {
 	uint32_t i;
diff --git a/hash.h b/hash.h
index 7ec4e5b..83990e3 100644
--- a/hash.h
+++ b/hash.h
@@ -25,37 +25,39 @@
 /* callback to a compare function.  should compare 2 element datas for their
  * keys, return 0 if same and not 0 if not same
  */
-typedef int (*hashdata_compare_cb)(const struct hlist_node *, const void *);
+typedef int (*batadv_hashdata_compare_cb)(const struct hlist_node *,
+					  const void *);
 
 /* the hashfunction, should return an index
  * based on the key in the data of the first
  * argument and the size the second
  */
-typedef uint32_t (*hashdata_choose_cb)(const void *, uint32_t);
-typedef void (*hashdata_free_cb)(struct hlist_node *, void *);
+typedef uint32_t (*batadv_hashdata_choose_cb)(const void *, uint32_t);
+typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
 
-struct hashtable_t {
+struct batadv_hashtable {
 	struct hlist_head *table;   /* the hashtable itself with the buckets */
 	spinlock_t *list_locks;     /* spinlock for each hash list entry */
 	uint32_t size;		    /* size of hashtable */
 };
 
 /* allocates and clears the hash */
-struct hashtable_t *batadv_hash_new(uint32_t size);
+struct batadv_hashtable *batadv_hash_new(uint32_t size);
 
 /* set class key for all locks */
-void batadv_hash_set_lock_class(struct hashtable_t *hash,
+void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 				struct lock_class_key *key);
 
 /* free only the hashtable and the hash itself. */
-void batadv_hash_destroy(struct hashtable_t *hash);
+void batadv_hash_destroy(struct batadv_hashtable *hash);
 
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
  * called to remove the elements inside of the hash.  if you don't remove the
  * elements, memory might be leaked.
  */
-static inline void batadv_hash_delete(struct hashtable_t *hash,
-				      hashdata_free_cb free_cb, void *arg)
+static inline void batadv_hash_delete(struct batadv_hashtable *hash,
+				      batadv_hashdata_free_cb free_cb,
+				      void *arg)
 {
 	struct hlist_head *head;
 	struct hlist_node *node, *node_tmp;
@@ -89,9 +91,9 @@ static inline void batadv_hash_delete(struct hashtable_t *hash,
  *	Returns 0 on success, 1 if the element already is in the hash
  *	and -1 on error.
  */
-static inline int batadv_hash_add(struct hashtable_t *hash,
-				  hashdata_compare_cb compare,
-				  hashdata_choose_cb choose,
+static inline int batadv_hash_add(struct batadv_hashtable *hash,
+				  batadv_hashdata_compare_cb compare,
+				  batadv_hashdata_choose_cb choose,
 				  const void *data,
 				  struct hlist_node *data_node)
 {
@@ -134,9 +136,10 @@ out:
  * structure you use with just the key filled, we just need the key for
  * comparing.
  */
-static inline void *batadv_hash_remove(struct hashtable_t *hash,
-				       hashdata_compare_cb compare,
-				       hashdata_choose_cb choose, void *data)
+static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
+				       batadv_hashdata_compare_cb compare,
+				       batadv_hashdata_choose_cb choose,
+				       void *data)
 {
 	uint32_t index;
 	struct hlist_node *node;
diff --git a/originator.c b/originator.c
index 4ddea31..dc9c4bf 100644
--- a/originator.c
+++ b/originator.c
@@ -154,7 +154,7 @@ void batadv_orig_node_free_ref(struct orig_node *orig_node)
 
 void batadv_originator_free(struct bat_priv *bat_priv)
 {
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
@@ -343,7 +343,7 @@ static bool batadv_purge_orig_node(struct bat_priv *bat_priv,
 
 static void _batadv_purge_orig(struct bat_priv *bat_priv)
 {
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
@@ -401,7 +401,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	struct hard_iface *primary_if;
@@ -514,7 +514,7 @@ static int batadv_orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 int batadv_orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct orig_node *orig_node;
@@ -597,7 +597,7 @@ free_own_sum:
 int batadv_orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct hard_iface *hard_iface_tmp;
diff --git a/originator.h b/originator.h
index 35f67eb..32e7e28 100644
--- a/originator.h
+++ b/originator.h
@@ -63,7 +63,7 @@ static inline uint32_t batadv_choose_orig(const void *data, uint32_t size)
 static inline struct orig_node *batadv_orig_hash_find(struct bat_priv *bat_priv,
 						      const void *data)
 {
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct orig_node *orig_node, *orig_node_tmp = NULL;
diff --git a/routing.c b/routing.c
index e3859ab..903060f 100644
--- a/routing.c
+++ b/routing.c
@@ -35,7 +35,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 void batadv_slide_own_bcast_window(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct orig_node *orig_node;
diff --git a/translation-table.c b/translation-table.c
index baeead6..32ca899 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -51,8 +51,8 @@ static void batadv_tt_start_timer(struct bat_priv *bat_priv)
 			   msecs_to_jiffies(5000));
 }
 
-static struct tt_common_entry *batadv_tt_hash_find(struct hashtable_t *hash,
-						   const void *data)
+static struct tt_common_entry *
+batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
 {
 	struct hlist_head *head;
 	struct hlist_node *node;
@@ -416,7 +416,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	struct hashtable_t *hash = bat_priv->tt_local_hash;
+	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
 	struct tt_common_entry *tt_common_entry;
 	struct hard_iface *primary_if;
 	struct hlist_node *node;
@@ -537,7 +537,7 @@ static void batadv_tt_local_purge_list(struct bat_priv *bat_priv,
 
 static void batadv_tt_local_purge(struct bat_priv *bat_priv)
 {
-	struct hashtable_t *hash = bat_priv->tt_local_hash;
+	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
@@ -555,7 +555,7 @@ static void batadv_tt_local_purge(struct bat_priv *bat_priv)
 
 static void batadv_tt_local_table_free(struct bat_priv *bat_priv)
 {
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct tt_common_entry *tt_common_entry;
 	struct tt_local_entry *tt_local_entry;
@@ -774,7 +774,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
 	struct tt_common_entry *tt_common_entry;
 	struct tt_global_entry *tt_global_entry;
 	struct hard_iface *primary_if;
@@ -983,7 +983,7 @@ void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
 	struct tt_global_entry *global_entry;
 	struct tt_common_entry *tt_common_entry;
 	uint32_t i;
-	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
 	struct hlist_node *node, *safe;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
@@ -1047,7 +1047,7 @@ static void batadv_tt_global_roam_purge_list(struct bat_priv *bat_priv,
 
 static void batadv_tt_global_roam_purge(struct bat_priv *bat_priv)
 {
-	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
@@ -1065,7 +1065,7 @@ static void batadv_tt_global_roam_purge(struct bat_priv *bat_priv)
 
 static void batadv_tt_global_table_free(struct bat_priv *bat_priv)
 {
-	struct hashtable_t *hash;
+	struct batadv_hashtable *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct tt_common_entry *tt_common_entry;
 	struct tt_global_entry *tt_global_entry;
@@ -1174,7 +1174,7 @@ static uint16_t batadv_tt_global_crc(struct bat_priv *bat_priv,
 				     struct orig_node *orig_node)
 {
 	uint16_t total = 0, total_one;
-	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
 	struct tt_common_entry *tt_common;
 	struct tt_global_entry *tt_global_entry;
 	struct hlist_node *node;
@@ -1221,7 +1221,7 @@ static uint16_t batadv_tt_global_crc(struct bat_priv *bat_priv,
 static uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv)
 {
 	uint16_t total = 0, total_one;
-	struct hashtable_t *hash = bat_priv->tt_local_hash;
+	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
 	struct tt_common_entry *tt_common;
 	struct hlist_node *node;
 	struct hlist_head *head;
@@ -1360,7 +1360,7 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 
 static struct sk_buff *
 batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
-			      struct hashtable_t *hash,
+			      struct batadv_hashtable *hash,
 			      struct hard_iface *primary_if,
 			      int (*valid_cb)(const void *, const void *),
 			      void *cb_data)
@@ -2088,8 +2088,8 @@ void batadv_tt_free(struct bat_priv *bat_priv)
 /* This function will enable or disable the specified flags for all the entries
  * in the given hash table and returns the number of modified entries
  */
-static uint16_t batadv_tt_set_flags(struct hashtable_t *hash, uint16_t flags,
-				    bool enable)
+static uint16_t batadv_tt_set_flags(struct batadv_hashtable *hash,
+				    uint16_t flags, bool enable)
 {
 	uint32_t i;
 	uint16_t changed_num = 0;
@@ -2126,7 +2126,7 @@ out:
 /* Purge out all the tt local entries marked with TT_CLIENT_PENDING */
 static void batadv_tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 {
-	struct hashtable_t *hash = bat_priv->tt_local_hash;
+	struct batadv_hashtable *hash = bat_priv->tt_local_hash;
 	struct tt_common_entry *tt_common;
 	struct tt_local_entry *tt_local_entry;
 	struct hlist_node *node, *node_tmp;
diff --git a/types.h b/types.h
index a3bf40c..beaacae 100644
--- a/types.h
+++ b/types.h
@@ -198,16 +198,16 @@ struct bat_priv {
 	struct hlist_head gw_list;
 	struct list_head tt_changes_list; /* tracks changes in a OGM int */
 	struct list_head vis_send_list;
-	struct hashtable_t *orig_hash;
-	struct hashtable_t *tt_local_hash;
-	struct hashtable_t *tt_global_hash;
+	struct batadv_hashtable *orig_hash;
+	struct batadv_hashtable *tt_local_hash;
+	struct batadv_hashtable *tt_global_hash;
 #ifdef CONFIG_BATMAN_ADV_BLA
-	struct hashtable_t *claim_hash;
-	struct hashtable_t *backbone_hash;
+	struct batadv_hashtable *claim_hash;
+	struct batadv_hashtable *backbone_hash;
 #endif
 	struct list_head tt_req_list; /* list of pending tt_requests */
 	struct list_head tt_roam_list;
-	struct hashtable_t *vis_hash;
+	struct batadv_hashtable *vis_hash;
 #ifdef CONFIG_BATMAN_ADV_BLA
 	struct bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
diff --git a/vis.c b/vis.c
index f5692ee..c1fafa3 100644
--- a/vis.c
+++ b/vis.c
@@ -91,7 +91,7 @@ static uint32_t batadv_vis_info_choose(const void *data, uint32_t size)
 static struct vis_info *batadv_vis_hash_find(struct bat_priv *bat_priv,
 					     const void *data)
 {
-	struct hashtable_t *hash = bat_priv->vis_hash;
+	struct batadv_hashtable *hash = bat_priv->vis_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct vis_info *vis_info, *vis_info_tmp = NULL;
@@ -247,7 +247,7 @@ int batadv_vis_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_head *head;
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	struct hashtable_t *hash = bat_priv->vis_hash;
+	struct batadv_hashtable *hash = bat_priv->vis_hash;
 	uint32_t i;
 	int ret = 0;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
@@ -506,7 +506,7 @@ end:
 static int batadv_find_best_vis_server(struct bat_priv *bat_priv,
 				       struct vis_info *info)
 {
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct neigh_node *router;
 	struct hlist_node *node;
 	struct hlist_head *head;
@@ -559,7 +559,7 @@ static bool batadv_vis_packet_full(const struct vis_info *info)
  */
 static int batadv_generate_vis_packet(struct bat_priv *bat_priv)
 {
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct orig_node *orig_node;
@@ -659,7 +659,7 @@ unlock:
 static void batadv_purge_vis_packets(struct bat_priv *bat_priv)
 {
 	uint32_t i;
-	struct hashtable_t *hash = bat_priv->vis_hash;
+	struct batadv_hashtable *hash = bat_priv->vis_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	struct vis_info *info;
@@ -687,7 +687,7 @@ static void batadv_broadcast_vis_packet(struct bat_priv *bat_priv,
 					struct vis_info *info)
 {
 	struct neigh_node *router;
-	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct orig_node *orig_node;
-- 
1.7.10

