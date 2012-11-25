Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Nov 2012 19:23:30 +0100
Message-Id: <1353867811-8452-4-git-send-email-sven@narfation.org>
In-Reply-To: <1353867811-8452-1-git-send-email-sven@narfation.org>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Remove wrapper structure for
	hash tables
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

It is unnecessary to allocate an extra memory region for hashtables and the
corresponding locks. This brings the hashes used in batman-adv slightly in the
direction of the common statically sized hash table implementation. More common
hashtable functionality cannot be used batman-adv wide because the simple
hashtable implementation doesn't provide bucket based locking and its non-locked
access macros don't allow loop-flow control.

A sideeffect of this change is the initialization of each array of locks for
each hashtable with a different lock_class. This allows to correct nesting of
write access to two different hashtables without triggering a lockdep warning.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile.kbuild         |    1 -
 bridge_loop_avoidance.c |  140 ++++++++++++++--------------------------
 distributed-arp-table.c |   51 +++++----------
 hash.c                  |   77 ----------------------
 hash.h                  |   91 +++++++++++++-------------
 originator.c            |   58 ++++++-----------
 originator.h            |    6 +-
 routing.c               |    6 +-
 translation-table.c     |  163 ++++++++++++++++++++---------------------------
 types.h                 |   22 +++++--
 vis.c                   |   68 ++++++++------------
 11 files changed, 247 insertions(+), 436 deletions(-)
 delete mode 100644 hash.c

diff --git a/Makefile.kbuild b/Makefile.kbuild
index e45e3b4..af2e837 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -27,7 +27,6 @@ batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
-batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
 batman-adv-y += originator.o
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 841143d..1a78bac 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -131,18 +131,15 @@ static void batadv_claim_free_ref(struct batadv_claim *claim)
 static struct batadv_claim *batadv_claim_hash_find(struct batadv_priv *bat_priv,
 						   struct batadv_claim *data)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
+	struct hlist_head *hash = bat_priv->bla.claim_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_claim *claim;
 	struct batadv_claim *claim_tmp = NULL;
 	int index;
 
-	if (!hash)
-		return NULL;
-
-	index = batadv_choose_claim(data, 1 << BATADV_BLA_CLAIM_HASH_BITS);
-	head = &hash->table[index];
+	index = batadv_choose_claim(data, ARRAY_SIZE(bat_priv->bla.claim_hash));
+	head = &hash[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(claim, node, head, hash_entry) {
@@ -172,22 +169,19 @@ static struct batadv_backbone_gw *
 batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 			  uint8_t *addr, short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct hlist_head *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_backbone_gw search_entry, *backbone_gw;
 	struct batadv_backbone_gw *backbone_gw_tmp = NULL;
 	int index;
-	uint32_t hash_size =  1 << BATADV_BLA_BACKBONE_HASH_BITS;
-
-	if (!hash)
-		return NULL;
+	uint32_t hash_size = ARRAY_SIZE(bat_priv->bla.backbone_hash);
 
 	memcpy(search_entry.orig, addr, ETH_ALEN);
 	search_entry.vid = vid;
 
 	index = batadv_choose_backbone_gw(&search_entry, hash_size);
-	head = &hash->table[index];
+	head = &hash[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
@@ -210,20 +204,19 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 static void
 batadv_bla_del_backbone_claims(struct batadv_backbone_gw *backbone_gw)
 {
-	struct batadv_hashtable *hash;
+	struct batadv_priv *bat_priv = backbone_gw->bat_priv;
+	struct hlist_head *hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	struct batadv_claim *claim;
 	int i;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 
-	hash = backbone_gw->bat_priv->bla.claim_hash;
-	if (!hash)
-		return;
+	hash = bat_priv->bla.claim_hash;
 
-	for (i = 0; i <  1 << BATADV_BLA_CLAIM_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->bla.claim_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(claim, node, node_tmp,
@@ -392,7 +385,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 	atomic_set(&entry->refcount, 2);
 
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
-				     1 << BATADV_BLA_BACKBONE_HASH_BITS,
+				     bat_priv->bla.backbone_hash_locks,
 				     batadv_compare_backbone_gw,
 				     batadv_choose_backbone_gw, entry,
 				     &entry->hash_entry);
@@ -455,7 +448,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 {
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct hlist_head *hash;
 	struct batadv_claim *claim;
 	struct batadv_backbone_gw *backbone_gw;
 	int i;
@@ -470,8 +463,8 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 		return;
 
 	hash = bat_priv->bla.claim_hash;
-	for (i = 0; i <  1 << BATADV_BLA_CLAIM_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, node, head, hash_entry) {
@@ -571,7 +564,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, vid);
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
-					     1 << BATADV_BLA_CLAIM_HASH_BITS,
+					     bat_priv->bla.claim_hash_locks,
 					     batadv_compare_claim,
 					     batadv_choose_claim, claim,
 					     &claim->hash_entry);
@@ -624,7 +617,7 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 		   mac, vid);
 
 	batadv_hash_remove(bat_priv->bla.claim_hash,
-			   1 << BATADV_BLA_CLAIM_HASH_BITS,
+			   bat_priv->bla.claim_hash_locks,
 			   batadv_compare_claim, batadv_choose_claim, claim);
 	batadv_claim_free_ref(claim); /* reference from the hash is gone */
 
@@ -957,17 +950,15 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	struct batadv_backbone_gw *backbone_gw;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct hlist_head *hash;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 	int i;
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->bla.backbone_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(backbone_gw, node, node_tmp,
@@ -1012,15 +1003,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 	struct batadv_claim *claim;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct hlist_head *hash;
 	int i;
 
 	hash = bat_priv->bla.claim_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i <  1 << BATADV_BLA_CLAIM_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, node, head, hash_entry) {
@@ -1061,7 +1050,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	struct batadv_backbone_gw *backbone_gw;
 	struct hlist_node *node;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct hlist_head *hash;
 	__be16 group;
 	int i;
 
@@ -1076,11 +1065,9 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	}
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
@@ -1122,7 +1109,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_backbone_gw *backbone_gw;
-	struct batadv_hashtable *hash;
+	struct hlist_head *hash;
 	struct batadv_hard_iface *primary_if;
 	int i;
 
@@ -1140,11 +1127,9 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 		goto out;
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		goto out;
 
-	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
@@ -1183,14 +1168,6 @@ out:
 	batadv_bla_start_timer(bat_priv);
 }
 
-/* The hash for claim and backbone hash receive the same key because they
- * are getting initialized by hash_new with the same key. Reinitializing
- * them with to different keys to allow nested locking without generating
- * lockdep warnings
- */
-static struct lock_class_key batadv_claim_hash_lock_class_key;
-static struct lock_class_key batadv_backbone_hash_lock_class_key;
-
 /* initialize all bla structures */
 int batadv_bla_init(struct batadv_priv *bat_priv)
 {
@@ -1199,8 +1176,6 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	struct batadv_hard_iface *primary_if;
 	uint16_t crc;
 	unsigned long entrytime;
-	uint32_t hash_claim_size = 1 << BATADV_BLA_CLAIM_HASH_BITS;
-	uint32_t hash_backbone_size = 1 << BATADV_BLA_BACKBONE_HASH_BITS;
 
 	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1224,21 +1199,10 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 		bat_priv->bla.bcast_duplist[i].entrytime = entrytime;
 	bat_priv->bla.bcast_duplist_curr = 0;
 
-	if (bat_priv->bla.claim_hash)
-		return 0;
-
-	bat_priv->bla.claim_hash = batadv_hash_new(hash_claim_size);
-	bat_priv->bla.backbone_hash = batadv_hash_new(hash_backbone_size);
-
-	if (!bat_priv->bla.claim_hash || !bat_priv->bla.backbone_hash)
-		return -ENOMEM;
-
-	batadv_hash_set_lock_class(bat_priv->bla.claim_hash,
-				   1 << BATADV_BLA_CLAIM_HASH_BITS,
-				   &batadv_claim_hash_lock_class_key);
-	batadv_hash_set_lock_class(bat_priv->bla.backbone_hash,
-				   1 << BATADV_BLA_CLAIM_HASH_BITS,
-				   &batadv_backbone_hash_lock_class_key);
+	batadv_hash_init(bat_priv->bla.claim_hash,
+			 bat_priv->bla.claim_hash_locks);
+	batadv_hash_init(bat_priv->bla.backbone_hash,
+			 bat_priv->bla.backbone_hash_locks);
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hashes initialized\n");
 
@@ -1327,7 +1291,7 @@ out:
  */
 int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct hlist_head *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_backbone_gw *backbone_gw;
@@ -1336,11 +1300,8 @@ int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
 		return 0;
 
-	if (!hash)
-		return 0;
-
-	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
@@ -1409,16 +1370,9 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 	cancel_delayed_work_sync(&bat_priv->bla.work);
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 
-	if (bat_priv->bla.claim_hash) {
-		batadv_bla_purge_claims(bat_priv, primary_if, 1);
-		batadv_hash_destroy(bat_priv->bla.claim_hash);
-		bat_priv->bla.claim_hash = NULL;
-	}
-	if (bat_priv->bla.backbone_hash) {
-		batadv_bla_purge_backbone_gw(bat_priv, 1);
-		batadv_hash_destroy(bat_priv->bla.backbone_hash);
-		bat_priv->bla.backbone_hash = NULL;
-	}
+	batadv_bla_purge_claims(bat_priv, primary_if, 1);
+	batadv_bla_purge_backbone_gw(bat_priv, 1);
+
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 }
@@ -1611,7 +1565,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
+	struct hlist_head *hash = bat_priv->bla.claim_hash;
 	struct batadv_claim *claim;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
@@ -1631,8 +1585,8 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-6s)\n",
 		   "Client", "VID", "Originator", "CRC");
-	for (i = 0; i <  1 << BATADV_BLA_CLAIM_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, node, head, hash_entry) {
@@ -1656,7 +1610,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct hlist_head *hash = bat_priv->bla.backbone_hash;
 	struct batadv_backbone_gw *backbone_gw;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
@@ -1677,8 +1631,8 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s %-9s (%-6s)\n",
 		   "Originator", "VID", "last seen", "CRC");
-	for (i = 0; i <  1 << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index baaec53..b4f8eef 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -87,12 +87,9 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->dat.hash)
-		return;
-
-	for (i = 0; i <  1 << BATADV_DAT_HASH_BITS; i++) {
-		head = &bat_priv->dat.hash->table[i];
-		list_lock = &bat_priv->dat.hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->dat.hash); i++) {
+		head = &bat_priv->dat.hash[i];
+		list_lock = &bat_priv->dat.hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(dat_entry, node, node_tmp, head,
@@ -237,14 +234,11 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip)
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_dat_entry *dat_entry, *dat_entry_tmp = NULL;
-	struct batadv_hashtable *hash = bat_priv->dat.hash;
+	struct hlist_head *hash = bat_priv->dat.hash;
 	uint32_t index;
 
-	if (!hash)
-		return NULL;
-
-	index = batadv_hash_dat(&ip, 1 << BATADV_DAT_HASH_BITS);
-	head = &hash->table[index];
+	index = batadv_hash_dat(&ip, ARRAY_SIZE(bat_priv->dat.hash));
+	head = &hash[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, node, head, hash_entry) {
@@ -296,7 +290,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	atomic_set(&dat_entry->refcount, 2);
 
 	hash_added = batadv_hash_add(bat_priv->dat.hash,
-				     1 << BATADV_DAT_HASH_BITS,
+				     bat_priv->dat.hash_locks,
 				     batadv_compare_dat, batadv_hash_dat,
 				     &dat_entry->ip, &dat_entry->hash_entry);
 
@@ -465,7 +459,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 {
 	batadv_dat_addr_t max = 0, tmp_max = 0;
 	struct batadv_orig_node *orig_node, *max_orig_node = NULL;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	int i;
@@ -478,8 +472,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 	/* iterate over the originator list and find the node with closest
 	 * dat_address which has not been selected yet
 	 */
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
@@ -533,9 +527,6 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
 	struct batadv_dat_candidate *res;
 
-	if (!bat_priv->orig_hash)
-		return NULL;
-
 	res = kmalloc(BATADV_DAT_CANDIDATES_NUM * sizeof(*res), GFP_ATOMIC);
 	if (!res)
 		return NULL;
@@ -635,14 +626,7 @@ out:
  */
 static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 {
-	if (!bat_priv->dat.hash)
-		return;
-
 	__batadv_dat_purge(bat_priv, NULL);
-
-	batadv_hash_destroy(bat_priv->dat.hash);
-
-	bat_priv->dat.hash = NULL;
 }
 
 /**
@@ -651,13 +635,8 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
  */
 int batadv_dat_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->dat.hash)
-		return 0;
-
-	bat_priv->dat.hash = batadv_hash_new(1 << BATADV_DAT_HASH_BITS);
-
-	if (!bat_priv->dat.hash)
-		return -ENOMEM;
+	batadv_hash_init(bat_priv->dat.hash,
+			 bat_priv->dat.hash_locks);
 
 	batadv_dat_start_timer(bat_priv);
 
@@ -684,7 +663,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->dat.hash;
+	struct hlist_head *hash = bat_priv->dat.hash;
 	struct batadv_dat_entry *dat_entry;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_node *node;
@@ -701,8 +680,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
 		   "last-seen");
 
-	for (i = 0; i < 1 << BATADV_DAT_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->dat.hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(dat_entry, node, head, hash_entry) {
diff --git a/hash.c b/hash.c
deleted file mode 100644
index 7c4edfc..0000000
--- a/hash.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/* Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
- *
- * Simon Wunderlich, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- */
-
-#include "main.h"
-#include "hash.h"
-
-/* clears the hash */
-static void batadv_hash_init(struct batadv_hashtable *hash, uint32_t size)
-{
-	uint32_t i;
-
-	for (i = 0; i < size; i++) {
-		INIT_HLIST_HEAD(&hash->table[i]);
-		spin_lock_init(&hash->list_locks[i]);
-	}
-}
-
-/* free only the hashtable and the hash itself. */
-void batadv_hash_destroy(struct batadv_hashtable *hash)
-{
-	kfree(hash->list_locks);
-	kfree(hash->table);
-	kfree(hash);
-}
-
-/* allocates and clears the hash */
-struct batadv_hashtable *batadv_hash_new(uint32_t size)
-{
-	struct batadv_hashtable *hash;
-
-	hash = kmalloc(sizeof(*hash), GFP_ATOMIC);
-	if (!hash)
-		return NULL;
-
-	hash->table = kmalloc(sizeof(*hash->table) * size, GFP_ATOMIC);
-	if (!hash->table)
-		goto free_hash;
-
-	hash->list_locks = kmalloc(sizeof(*hash->list_locks) * size,
-				   GFP_ATOMIC);
-	if (!hash->list_locks)
-		goto free_table;
-
-	batadv_hash_init(hash, size);
-	return hash;
-
-free_table:
-	kfree(hash->table);
-free_hash:
-	kfree(hash);
-	return NULL;
-}
-
-void batadv_hash_set_lock_class(struct batadv_hashtable *hash, uint32_t size,
-				struct lock_class_key *key)
-{
-	uint32_t i;
-
-	for (i = 0; i < size; i++)
-		lockdep_set_class(&hash->list_locks[i], key);
-}
diff --git a/hash.h b/hash.h
index 107c67e..1cd3ae3 100644
--- a/hash.h
+++ b/hash.h
@@ -22,6 +22,15 @@
 
 #include <linux/list.h>
 
+#define batadv_hash_init(hashtable, hashtable_locks) \
+	do { \
+		uint32_t _it; \
+		for (_it = 0; _it < ARRAY_SIZE(hashtable); _it++) \
+			INIT_HLIST_HEAD(&hashtable[_it]); \
+		for (_it = 0; _it < ARRAY_SIZE(hashtable_locks); _it++) \
+			spin_lock_init(&hashtable_locks[_it]); \
+	} while (0)
+
 /* callback to a compare function.  should compare 2 element datas for their
  * keys, return 0 if same and not 0 if not same
  */
@@ -35,38 +44,28 @@ typedef int (*batadv_hashdata_compare_cb)(const struct hlist_node *,
 typedef uint32_t (*batadv_hashdata_choose_cb)(const void *, uint32_t);
 typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
 
-struct batadv_hashtable {
-	struct hlist_head *table;   /* the hashtable itself with the buckets */
-	spinlock_t *list_locks;     /* spinlock for each hash list entry */
-};
-
-/* allocates and clears the hash */
-struct batadv_hashtable *batadv_hash_new(uint32_t size);
-
-/* set class key for all locks */
-void batadv_hash_set_lock_class(struct batadv_hashtable *hash, uint32_t size,
-				struct lock_class_key *key);
-
-/* free only the hashtable and the hash itself. */
-void batadv_hash_destroy(struct batadv_hashtable *hash);
-
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
  * called to remove the elements inside of the hash.  if you don't remove the
  * elements, memory might be leaked.
  */
-static inline void batadv_hash_delete(struct batadv_hashtable *hash,
-				      uint32_t size,
-				      batadv_hashdata_free_cb free_cb,
-				      void *arg)
+#define batadv_hash_delete(hash, locks, free_cb, arg) \
+	_batadv_hash_delete(hash, ARRAY_SIZE(hash), locks, ARRAY_SIZE(locks), \
+			    free_cb, arg)
+
+static inline void _batadv_hash_delete(struct hlist_head *hash,
+				       uint32_t hash_size, spinlock_t *locks,
+				       uint32_t lock_size,
+				       batadv_hashdata_free_cb free_cb,
+				       void *arg)
 {
 	struct hlist_head *head;
 	struct hlist_node *node, *node_tmp;
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	uint32_t i;
 
-	for (i = 0; i < size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < hash_size; i++) {
+		head = &hash[i];
+		list_lock = &locks[i % lock_size];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_safe(node, node_tmp, head) {
@@ -77,14 +76,11 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
 }
 
 /**
  *	batadv_hash_add - adds data to the hashtable
  *	@hash: storage hash table
- *	@size: size of the hashtable
  *	@compare: callback to determine if 2 hash elements are identical
  *	@choose: callback calculating the hash index
  *	@data: data passed to the aforementioned callbacks as argument
@@ -93,12 +89,16 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
  *	Returns 0 on success, 1 if the element already is in the hash
  *	and -1 on error.
  */
-static inline int batadv_hash_add(struct batadv_hashtable *hash,
-				  uint32_t size,
-				  batadv_hashdata_compare_cb compare,
-				  batadv_hashdata_choose_cb choose,
-				  const void *data,
-				  struct hlist_node *data_node)
+#define batadv_hash_add(hash, locks, compare, choose, data, data_node) \
+	_batadv_hash_add(hash, ARRAY_SIZE(hash), locks, ARRAY_SIZE(locks), \
+			 compare, choose, data, data_node)
+
+static inline int _batadv_hash_add(struct hlist_head *hash, uint32_t hash_size,
+				   spinlock_t *locks, uint32_t lock_size,
+				   batadv_hashdata_compare_cb compare,
+				   batadv_hashdata_choose_cb choose,
+				   const void *data,
+				   struct hlist_node *data_node)
 {
 	uint32_t index;
 	int ret = -1;
@@ -109,9 +109,9 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
 	if (!hash)
 		goto out;
 
-	index = choose(data, size);
-	head = &hash->table[index];
-	list_lock = &hash->list_locks[index];
+	index = choose(data, hash_size);
+	head = &hash[index];
+	list_lock = &locks[index];
 
 	spin_lock_bh(list_lock);
 
@@ -139,21 +139,26 @@ out:
  * structure you use with just the key filled, we just need the key for
  * comparing.
  */
-static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
-				       uint32_t size,
-				       batadv_hashdata_compare_cb compare,
-				       batadv_hashdata_choose_cb choose,
-				       void *data)
+#define batadv_hash_remove(hash, locks, compare, choose, data) \
+	_batadv_hash_remove(hash, ARRAY_SIZE(hash), locks, ARRAY_SIZE(locks), \
+			    compare, choose, data)
+
+static inline void *_batadv_hash_remove(struct hlist_head *hash,
+					uint32_t hash_size, spinlock_t *locks,
+					uint32_t lock_size,
+					batadv_hashdata_compare_cb compare,
+					batadv_hashdata_choose_cb choose,
+					void *data)
 {
 	uint32_t index;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	void *data_save = NULL;
 
-	index = choose(data, size);
-	head = &hash->table[index];
+	index = choose(data, hash_size);
+	head = &hash[index];
 
-	spin_lock_bh(&hash->list_locks[index]);
+	spin_lock_bh(&locks[index]);
 	hlist_for_each(node, head) {
 		if (!compare(node, data))
 			continue;
@@ -162,7 +167,7 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 		hlist_del_rcu(node);
 		break;
 	}
-	spin_unlock_bh(&hash->list_locks[index]);
+	spin_unlock_bh(&locks[index]);
 
 	return data_save;
 }
diff --git a/originator.c b/originator.c
index 38ae83c..2145005 100644
--- a/originator.c
+++ b/originator.c
@@ -49,19 +49,11 @@ static int batadv_compare_orig(const struct hlist_node *node, const void *data2)
 
 int batadv_originator_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->orig_hash)
-		return 0;
-
-	bat_priv->orig_hash = batadv_hash_new(1 << BATADV_ORIG_HASH_BITS);
-
-	if (!bat_priv->orig_hash)
-		goto err;
+	batadv_hash_init(bat_priv->orig_hash,
+			 bat_priv->orig_hash_locks);
 
 	batadv_start_purge_timer(bat_priv);
 	return 0;
-
-err:
-	return -ENOMEM;
 }
 
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
@@ -157,23 +149,18 @@ void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
 
 void batadv_originator_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
 	cancel_delayed_work_sync(&bat_priv->orig_work);
 
-	bat_priv->orig_hash = NULL;
-
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->orig_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node, node_tmp,
@@ -184,8 +171,6 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
 }
 
 /* this function finds or creates an originator entry for the given
@@ -252,7 +237,7 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 		goto free_bcast_own;
 
 	hash_added = batadv_hash_add(bat_priv->orig_hash,
-				     1 << BATADV_ORIG_HASH_BITS,
+				     bat_priv->orig_hash_locks,
 				     batadv_compare_orig, batadv_choose_orig,
 				     orig_node, &orig_node->hash_entry);
 	if (hash_added != 0)
@@ -348,20 +333,17 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 
 static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
 	/* for all origins... */
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->orig_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node, node_tmp,
@@ -406,7 +388,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	struct batadv_hard_iface *primary_if;
@@ -429,8 +411,8 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
 		   "Nexthop", "outgoingIF", "Potential nexthops");
 
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
@@ -509,7 +491,7 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -519,8 +501,8 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
@@ -593,7 +575,7 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_hard_iface *hard_iface_tmp;
@@ -604,8 +586,8 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
diff --git a/originator.h b/originator.h
index 1cad364..0661479 100644
--- a/originator.h
+++ b/originator.h
@@ -55,7 +55,7 @@ static inline uint32_t batadv_choose_orig(const void *data, uint32_t size)
 static inline struct batadv_orig_node *
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_orig_node *orig_node, *orig_node_tmp = NULL;
@@ -64,8 +64,8 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, 1 << BATADV_ORIG_HASH_BITS);
-	head = &hash->table[index];
+	index = batadv_choose_orig(data, ARRAY_SIZE(bat_priv->orig_hash));
+	head = &hash[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
diff --git a/routing.c b/routing.c
index 09c40e3..95cd435 100644
--- a/routing.c
+++ b/routing.c
@@ -36,7 +36,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 void batadv_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -45,8 +45,8 @@ void batadv_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	size_t word_index;
 	uint8_t *w;
 
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
diff --git a/translation-table.c b/translation-table.c
index 3ae2e10..28e992c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -79,9 +79,11 @@ static void batadv_tt_start_timer(struct batadv_priv *bat_priv)
 			   msecs_to_jiffies(5000));
 }
 
+#define batadv_tt_hash_find(hash, dat) \
+	_batadv_tt_hash_find(hash, ARRAY_SIZE(hash), data)
+
 static struct batadv_tt_common_entry *
-batadv_tt_hash_find(struct batadv_hashtable *hash, uint32_t size,
-		    const void *data)
+_batadv_tt_hash_find(struct hlist_head *hash, uint32_t size, const void *data)
 {
 	struct hlist_head *head;
 	struct hlist_node *node;
@@ -93,7 +95,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, uint32_t size,
 		return NULL;
 
 	index = batadv_choose_tt(data, size);
-	head = &hash->table[index];
+	head = &hash[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tt_common_entry, node, head, hash_entry) {
@@ -118,7 +120,6 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const void *data)
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 
 	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash,
-					      1 << BATADV_TT_LOCAL_HASH_BITS,
 					      data);
 	if (tt_common_entry)
 		tt_local_entry = container_of(tt_common_entry,
@@ -134,7 +135,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const void *data)
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 
 	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash,
-					      1 << BATADV_TT_GLOBAL_HASH_BITS,
 					      data);
 	if (tt_common_entry)
 		tt_global_entry = container_of(tt_common_entry,
@@ -256,15 +256,8 @@ int batadv_tt_len(int changes_num)
 
 static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 {
-	uint32_t hash_size = 1 << BATADV_TT_LOCAL_HASH_BITS;
-
-	if (bat_priv->tt.local_hash)
-		return 0;
-
-	bat_priv->tt.local_hash = batadv_hash_new(hash_size);
-
-	if (!bat_priv->tt.local_hash)
-		return -ENOMEM;
+	batadv_hash_init(bat_priv->tt.local_hash,
+			 bat_priv->tt.local_hash_locks);
 
 	return 0;
 }
@@ -278,7 +271,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 		   tt_global->common.addr, message);
 
 	batadv_hash_remove(bat_priv->tt.global_hash,
-			   1 << BATADV_TT_GLOBAL_HASH_BITS, batadv_compare_tt,
+			   bat_priv->tt.global_hash_locks, batadv_compare_tt,
 			   batadv_choose_tt, tt_global->common.addr);
 	batadv_tt_global_entry_free_ref(tt_global);
 
@@ -353,7 +346,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash,
-				     1 << BATADV_TT_LOCAL_HASH_BITS,
+				     bat_priv->tt.local_hash_locks,
 				     batadv_compare_tt, batadv_choose_tt,
 				     &tt_local->common,
 				     &tt_local->common.hash_entry);
@@ -502,7 +495,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct hlist_head *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_hard_iface *primary_if;
@@ -524,8 +517,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s %-7s %-10s\n", "Client", "Flags",
 		   "Last seen");
 
-	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry, node,
@@ -662,14 +655,14 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 
 static void batadv_tt_local_purge(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct hlist_head *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->tt.local_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		batadv_tt_local_purge_list(bat_priv, head);
@@ -680,7 +673,7 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv)
 
 static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
+	struct hlist_head *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
@@ -688,14 +681,11 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->tt.local_hash)
-		return;
-
 	hash = bat_priv->tt.local_hash;
 
-	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->tt.local_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
@@ -708,23 +698,12 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
-
-	bat_priv->tt.local_hash = NULL;
 }
 
 static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 {
-	uint32_t hash_size = 1 << BATADV_TT_GLOBAL_HASH_BITS;
-
-	if (bat_priv->tt.global_hash)
-		return 0;
-
-	bat_priv->tt.global_hash = batadv_hash_new(hash_size);
-
-	if (!bat_priv->tt.global_hash)
-		return -ENOMEM;
+	batadv_hash_init(bat_priv->tt.global_hash,
+			 bat_priv->tt.global_hash_locks);
 
 	return 0;
 }
@@ -875,7 +854,7 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 		spin_lock_init(&tt_global_entry->list_lock);
 
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
-					     1 << BATADV_TT_GLOBAL_HASH_BITS,
+					     bat_priv->tt.global_hash_locks,
 					     batadv_compare_tt,
 					     batadv_choose_tt, common,
 					     &common->hash_entry);
@@ -1049,7 +1028,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct hlist_head *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global;
 	struct batadv_hard_iface *primary_if;
@@ -1068,8 +1047,8 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "CRC",
 		   "Flags");
 
-	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry, node,
@@ -1235,17 +1214,14 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	struct batadv_tt_global_entry *tt_global;
 	struct batadv_tt_common_entry *tt_common_entry;
 	uint32_t i;
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct hlist_head *hash = bat_priv->tt.global_hash;
 	struct hlist_node *node, *safe;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 
-	if (!hash)
-		return;
-
-	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->tt.global_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node, safe,
@@ -1294,7 +1270,7 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 
 static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct hlist_head *hash = bat_priv->tt.global_hash;
 	struct hlist_head *head;
 	struct hlist_node *node, *node_tmp;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
@@ -1303,9 +1279,9 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 
-	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->tt.global_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node, node_tmp, head,
@@ -1331,7 +1307,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
+	struct hlist_head *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global;
@@ -1339,14 +1315,11 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->tt.global_hash)
-		return;
-
 	hash = bat_priv->tt.global_hash;
 
-	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->tt.global_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
@@ -1359,10 +1332,6 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
-
-	bat_priv->tt.global_hash = NULL;
 }
 
 static bool
@@ -1428,7 +1397,7 @@ static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 				     struct batadv_orig_node *orig_node)
 {
 	uint16_t total = 0, total_one;
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct hlist_head *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_node *node;
@@ -1436,8 +1405,8 @@ static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	uint32_t i;
 	int j;
 
-	for (i = 0; i < 1 << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, node, head, hash_entry) {
@@ -1481,15 +1450,15 @@ static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 static uint16_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 {
 	uint16_t total = 0, total_one;
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct hlist_head *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
 	int j;
 
-	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, node, head, hash_entry) {
@@ -1623,7 +1592,8 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 
 static struct sk_buff *
 batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
-			      struct batadv_hashtable *hash, uint32_t size,
+			      struct hlist_head *hash, uint32_t hash_size,
+			      spinlock_t *locks, uint32_t lock_size,
 			      struct batadv_hard_iface *primary_if,
 			      int (*valid_cb)(const void *, const void *),
 			      void *cb_data)
@@ -1658,8 +1628,8 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	tt_count = 0;
 
 	rcu_read_lock();
-	for (i = 0; i < size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < hash_size; i++) {
+		head = &hash[i];
 
 		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
@@ -1770,7 +1740,8 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_tt_query_packet *tt_response;
 	uint8_t *packet_pos;
 	size_t len;
-	uint32_t hash_size = 1 << BATADV_TT_GLOBAL_HASH_BITS;
+	spinlock_t *locks; /* hash_locks */
+	uint32_t hash_size, lock_size;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (%pM) [%c]\n",
@@ -1834,10 +1805,14 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		tt_len = (uint16_t)atomic_read(&req_dst_orig_node->tt_size);
 		tt_len *= sizeof(struct batadv_tt_change);
 		ttvn = (uint8_t)atomic_read(&req_dst_orig_node->last_ttvn);
+		locks = bat_priv->tt.global_hash_locks;
+		hash_size = ARRAY_SIZE(bat_priv->tt.global_hash);
+		lock_size = ARRAY_SIZE(bat_priv->tt.global_hash_locks);
 
 		skb = batadv_tt_response_fill_table(tt_len, ttvn,
 						    bat_priv->tt.global_hash,
-						    hash_size, primary_if,
+						    hash_size, locks, lock_size,
+						    primary_if,
 						    batadv_tt_global_valid,
 						    req_dst_orig_node);
 		if (!skb)
@@ -1897,7 +1872,8 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_tt_query_packet *tt_response;
 	uint8_t *packet_pos;
 	size_t len;
-	uint32_t hash_size = 1 << BATADV_TT_LOCAL_HASH_BITS;
+	spinlock_t *locks; /* hash_locks */
+	uint32_t hash_size, lock_size;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (me) [%c]\n",
@@ -1952,10 +1928,14 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 		tt_len = (uint16_t)atomic_read(&bat_priv->tt.local_entry_num);
 		tt_len *= sizeof(struct batadv_tt_change);
 		ttvn = (uint8_t)atomic_read(&bat_priv->tt.vn);
+		locks = bat_priv->tt.local_hash_locks;
+		hash_size = ARRAY_SIZE(bat_priv->tt.local_hash);
+		lock_size = ARRAY_SIZE(bat_priv->tt.local_hash_locks);
 
 		skb = batadv_tt_response_fill_table(tt_len, ttvn,
 						    bat_priv->tt.local_hash,
-						    hash_size, primary_if,
+						    hash_size, locks, lock_size,
+						    primary_if,
 						    batadv_tt_local_valid_entry,
 						    NULL);
 		if (!skb)
@@ -2335,8 +2315,8 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 /* This function will enable or disable the specified flags for all the entries
  * in the given hash table and returns the number of modified entries
  */
-static uint16_t batadv_tt_set_flags(struct batadv_hashtable *hash,
-				    uint32_t size, uint16_t flags, bool enable)
+static uint16_t batadv_tt_set_flags(struct hlist_head *hash, uint32_t size,
+				    uint16_t flags, bool enable)
 {
 	uint32_t i;
 	uint16_t changed_num = 0;
@@ -2348,7 +2328,7 @@ static uint16_t batadv_tt_set_flags(struct batadv_hashtable *hash,
 		goto out;
 
 	for (i = 0; i < size; i++) {
-		head = &hash->table[i];
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry, node,
@@ -2373,7 +2353,7 @@ out:
 /* Purge out all the tt local entries marked with BATADV_TT_CLIENT_PENDING */
 static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct hlist_head *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_local_entry *tt_local;
 	struct hlist_node *node, *node_tmp;
@@ -2381,12 +2361,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	if (!hash)
-		return;
-
-	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i];
+		list_lock = &bat_priv->tt.local_hash_locks[i];
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node, node_tmp, head,
@@ -2420,7 +2397,7 @@ static int batadv_tt_commit_changes(struct batadv_priv *bat_priv,
 		return -ENOENT;
 
 	changed_num = batadv_tt_set_flags(bat_priv->tt.local_hash,
-					  1 << BATADV_TT_LOCAL_HASH_BITS,
+					  ARRAY_SIZE(bat_priv->tt.local_hash),
 					  BATADV_TT_CLIENT_NEW, false);
 
 	/* all reset entries have to be counted as local entries */
diff --git a/types.h b/types.h
index ae9ac9a..a0e115a 100644
--- a/types.h
+++ b/types.h
@@ -206,8 +206,10 @@ struct batadv_priv_tt {
 	atomic_t ogm_append_cnt;
 	atomic_t local_changes;
 	struct list_head changes_list;
-	struct batadv_hashtable *local_hash;
-	struct batadv_hashtable *global_hash;
+	struct hlist_head local_hash[1 << BATADV_TT_LOCAL_HASH_BITS];
+	spinlock_t local_hash_locks[1 << BATADV_TT_LOCAL_HASH_BITS];
+	struct hlist_head global_hash[1 << BATADV_TT_GLOBAL_HASH_BITS];
+	spinlock_t global_hash_locks[1 << BATADV_TT_GLOBAL_HASH_BITS];
 	struct list_head req_list;
 	struct list_head roam_list;
 	spinlock_t changes_list_lock; /* protects changes */
@@ -224,8 +226,10 @@ struct batadv_priv_tt {
 #ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests; /* number of bla requests in flight */
-	struct batadv_hashtable *claim_hash;
-	struct batadv_hashtable *backbone_hash;
+	struct hlist_head claim_hash[1 << BATADV_BLA_CLAIM_HASH_BITS];
+	spinlock_t claim_hash_locks[1 << BATADV_BLA_CLAIM_HASH_BITS];
+	struct hlist_head backbone_hash[1 << BATADV_BLA_BACKBONE_HASH_BITS];
+	spinlock_t backbone_hash_locks[1 << BATADV_BLA_BACKBONE_HASH_BITS];
 	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
 	/* protects bcast_duplist and bcast_duplist_curr */
@@ -244,7 +248,8 @@ struct batadv_priv_gw {
 
 struct batadv_priv_vis {
 	struct list_head send_list;
-	struct batadv_hashtable *hash;
+	struct hlist_head hash[1 << BATADV_VIS_HASH_BITS];
+	spinlock_t hash_locks[1 << BATADV_VIS_HASH_BITS];
 	spinlock_t hash_lock; /* protects hash */
 	spinlock_t list_lock; /* protects info::recv_list */
 	struct delayed_work work;
@@ -255,12 +260,14 @@ struct batadv_priv_vis {
  * struct batadv_priv_dat - per mesh interface DAT private data
  * @addr: node DAT address
  * @hash: hashtable representing the local ARP cache
+ * @hash_lock: locks for each hashtable buckets
  * @work: work queue callback item for cache purging
  */
 #ifdef CONFIG_BATMAN_ADV_DAT
 struct batadv_priv_dat {
 	batadv_dat_addr_t addr;
-	struct batadv_hashtable *hash;
+	struct hlist_head hash[1 << BATADV_DAT_HASH_BITS];
+	spinlock_t hash_locks[1 << BATADV_DAT_HASH_BITS];
 	struct delayed_work work;
 };
 #endif
@@ -293,7 +300,8 @@ struct batadv_priv {
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
-	struct batadv_hashtable *orig_hash;
+	struct hlist_head orig_hash[1 << BATADV_ORIG_HASH_BITS];
+	spinlock_t orig_hash_locks[1 << BATADV_ORIG_HASH_BITS];
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
 	struct delayed_work orig_work;
diff --git a/vis.c b/vis.c
index ecde6a1..54401e3 100644
--- a/vis.c
+++ b/vis.c
@@ -83,17 +83,14 @@ static uint32_t batadv_vis_info_choose(const void *data, uint32_t size)
 static struct batadv_vis_info *
 batadv_vis_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
-	struct batadv_hashtable *hash = bat_priv->vis.hash;
+	struct hlist_head *hash = bat_priv->vis.hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_vis_info *vis_info, *vis_info_tmp = NULL;
 	uint32_t index;
 
-	if (!hash)
-		return NULL;
-
-	index = batadv_vis_info_choose(data, 1 << BATADV_VIS_HASH_BITS);
-	head = &hash->table[index];
+	index = batadv_vis_info_choose(data, ARRAY_SIZE(bat_priv->vis.hash));
+	head = &hash[index];
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(vis_info, node, head, hash_entry) {
@@ -241,7 +238,7 @@ int batadv_vis_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_head *head;
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->vis.hash;
+	struct hlist_head *hash = bat_priv->vis.hash;
 	uint32_t i;
 	int ret = 0;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
@@ -254,8 +251,8 @@ int batadv_vis_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	spin_lock_bh(&bat_priv->vis.hash_lock);
-	for (i = 0; i < 1 << BATADV_VIS_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->vis.hash); i++) {
+		head = &hash[i];
 		batadv_vis_seq_print_text_bucket(seq, head);
 	}
 	spin_unlock_bh(&bat_priv->vis.hash_lock);
@@ -342,9 +339,6 @@ batadv_add_packet(struct batadv_priv *bat_priv,
 	size_t max_entries;
 
 	*is_new = 0;
-	/* sanity check */
-	if (!bat_priv->vis.hash)
-		return NULL;
 
 	/* see if the packet is already in vis_hash */
 	search_elem.skb_packet = dev_alloc_skb(sizeof(*search_packet));
@@ -375,7 +369,7 @@ batadv_add_packet(struct batadv_priv *bat_priv,
 		}
 		/* remove old entry */
 		batadv_hash_remove(bat_priv->vis.hash,
-				   1 << BATADV_VIS_HASH_BITS,
+				   bat_priv->vis.hash_locks,
 				   batadv_vis_info_cmp, batadv_vis_info_choose,
 				   old_info);
 		batadv_send_list_del(old_info);
@@ -418,7 +412,7 @@ batadv_add_packet(struct batadv_priv *bat_priv,
 
 	/* try to add it */
 	hash_added = batadv_hash_add(bat_priv->vis.hash,
-				     1 << BATADV_VIS_HASH_BITS,
+				     bat_priv->vis.hash_locks,
 				     batadv_vis_info_cmp,
 				     batadv_vis_info_choose, info,
 				     &info->hash_entry);
@@ -509,7 +503,7 @@ end:
 static int batadv_find_best_vis_server(struct batadv_priv *bat_priv,
 				       struct batadv_vis_info *info)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct batadv_neigh_node *router;
 	struct hlist_node *node;
 	struct hlist_head *head;
@@ -520,8 +514,8 @@ static int batadv_find_best_vis_server(struct batadv_priv *bat_priv,
 
 	packet = (struct batadv_vis_packet *)info->skb_packet->data;
 
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
@@ -562,7 +556,7 @@ static bool batadv_vis_packet_full(const struct batadv_vis_info *info)
  */
 static int batadv_generate_vis_packet(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -593,8 +587,8 @@ static int batadv_generate_vis_packet(struct batadv_priv *bat_priv)
 			return best_tq;
 	}
 
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
@@ -632,8 +626,8 @@ next:
 
 	hash = bat_priv->tt.local_hash;
 
-	for (i = 0; i < 1 << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry, node, head,
@@ -664,13 +658,13 @@ unlock:
 static void batadv_purge_vis_packets(struct batadv_priv *bat_priv)
 {
 	uint32_t i;
-	struct batadv_hashtable *hash = bat_priv->vis.hash;
+	struct hlist_head *hash = bat_priv->vis.hash;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	struct batadv_vis_info *info;
 
-	for (i = 0; i < 1 << BATADV_VIS_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->vis.hash); i++) {
+		head = &hash[i];
 
 		hlist_for_each_entry_safe(info, node, node_tmp,
 					  head, hash_entry) {
@@ -691,7 +685,7 @@ static void batadv_purge_vis_packets(struct batadv_priv *bat_priv)
 static void batadv_broadcast_vis_packet(struct batadv_priv *bat_priv,
 					struct batadv_vis_info *info)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -703,8 +697,8 @@ static void batadv_broadcast_vis_packet(struct batadv_priv *bat_priv,
 	packet = (struct batadv_vis_packet *)info->skb_packet->data;
 
 	/* send to all routers in range. */
-	for (i = 0; i < 1 << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
@@ -834,16 +828,10 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 	unsigned long first_seen;
 	struct sk_buff *tmp_skb;
 
-	if (bat_priv->vis.hash)
-		return 0;
-
 	spin_lock_bh(&bat_priv->vis.hash_lock);
 
-	bat_priv->vis.hash = batadv_hash_new(1 << BATADV_VIS_HASH_BITS);
-	if (!bat_priv->vis.hash) {
-		pr_err("Can't initialize vis_hash\n");
-		goto err;
-	}
+	batadv_hash_init(bat_priv->vis.hash,
+			 bat_priv->vis.hash_locks);
 
 	bat_priv->vis.my_info = kmalloc(BATADV_MAX_VIS_PACKET_SIZE, GFP_ATOMIC);
 	if (!bat_priv->vis.my_info)
@@ -876,7 +864,7 @@ int batadv_vis_init(struct batadv_priv *bat_priv)
 	INIT_LIST_HEAD(&bat_priv->vis.send_list);
 
 	hash_added = batadv_hash_add(bat_priv->vis.hash,
-				     1 << BATADV_VIS_HASH_BITS,
+				     bat_priv->vis.hash_locks,
 				     batadv_vis_info_cmp,
 				     batadv_vis_info_choose,
 				     bat_priv->vis.my_info,
@@ -914,16 +902,12 @@ static void batadv_free_info_ref(struct hlist_node *node, void *arg)
 /* shutdown vis-server */
 void batadv_vis_quit(struct batadv_priv *bat_priv)
 {
-	if (!bat_priv->vis.hash)
-		return;
-
 	cancel_delayed_work_sync(&bat_priv->vis.work);
 
 	spin_lock_bh(&bat_priv->vis.hash_lock);
 	/* properly remove, kill timers ... */
-	batadv_hash_delete(bat_priv->vis.hash, 1 << BATADV_VIS_HASH_BITS,
+	batadv_hash_delete(bat_priv->vis.hash, bat_priv->vis.hash_locks,
 			   batadv_free_info_ref, NULL);
-	bat_priv->vis.hash = NULL;
 	bat_priv->vis.my_info = NULL;
 	spin_unlock_bh(&bat_priv->vis.hash_lock);
 }
-- 
1.7.10.4

