Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 Mar 2015 14:15:37 +0100
Message-Id: <1425215737-8387-3-git-send-email-sven@narfation.org>
In-Reply-To: <1425215737-8387-1-git-send-email-sven@narfation.org>
References: <1425215737-8387-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFCv3 3/3] batman-adv: Remove wrapper structure for
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
Cc: "sven@narfation.org" <sven@narfation.org>

From: "sven@narfation.org" <sven@narfation.org>

It is unnecessary to allocate an extra memory region for hashtables and the
corresponding locks. This brings the hashes used in batman-adv slightly in the
direction of the common statically sized hash table implementation. More common
hashtable functionality cannot be used batman-adv wide because the simple
hashtable and rhashtable implementations don't provide bucket based locking.

A sideeffect of this change is the initialization of each array of locks for
each hashtable with a different lock_class. This allows to correct nesting of
write access to two different hashtables without triggering a lockdep warning.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - Rebased on master
 - combine hlist_head and spinlock_t in own mini structure


The only thing I don't like at the moment are these checks whether hash was
initialized/not initialized. Right now they are just removed because this
check doesn't make sense anymore.

 Makefile.kbuild         |   1 -
 bat_iv_ogm.c            |  13 ++--
 bridge_loop_avoidance.c | 139 +++++++++++++--------------------------
 distributed-arp-table.c |  52 ++++-----------
 hash.c                  |  75 ---------------------
 hash.h                  |  87 ++++++++++++-------------
 network-coding.c        | 134 ++++++++++++++------------------------
 originator.c            |  56 +++++-----------
 originator.h            |   9 +--
 translation-table.c     | 168 ++++++++++++++++--------------------------------
 types.h                 |  27 +++++---
 11 files changed, 249 insertions(+), 512 deletions(-)
 delete mode 100644 hash.c

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 6903703..6ee8b04 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -26,7 +26,6 @@ batman-adv-y += fragmentation.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
-batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 7b30cd4..60bb3d7 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -246,7 +246,6 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
 		goto free_orig_node;
 
 	hash_added = batadv_hash_add(bat_priv->orig_hash,
-				     1u << BATADV_ORIG_HASH_BITS,
 				     batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
@@ -864,7 +863,7 @@ static void
 batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
 	unsigned long *word;
@@ -873,8 +872,8 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	uint8_t *w;
 	int if_num;
 
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -1801,7 +1800,7 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 				     struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_neigh_node *neigh_node;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	int last_seen_msecs, last_seen_secs;
 	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_ifinfo *n_ifinfo;
@@ -1814,8 +1813,8 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
 		   "Nexthop", "outgoingIF", "Potential nexthops");
 
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index d19f7c2..7ebedbc 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -133,17 +133,14 @@ static struct batadv_bla_claim
 *batadv_claim_hash_find(struct batadv_priv *bat_priv,
 			struct batadv_bla_claim *data)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
+	struct batadv_bucket *hash = bat_priv->bla.claim_hash;
 	struct hlist_head *head;
 	struct batadv_bla_claim *claim;
 	struct batadv_bla_claim *claim_tmp = NULL;
 	int index;
 
-	if (!hash)
-		return NULL;
-
-	index = batadv_choose_claim(data, 1u << BATADV_BLA_CLAIM_HASH_BITS);
-	head = &hash->table[index];
+	index = batadv_choose_claim(data, ARRAY_SIZE(bat_priv->bla.claim_hash));
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -173,21 +170,18 @@ static struct batadv_bla_backbone_gw *
 batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 			  uint8_t *addr, unsigned short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct batadv_bucket *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
 	struct batadv_bla_backbone_gw search_entry, *backbone_gw;
 	struct batadv_bla_backbone_gw *backbone_gw_tmp = NULL;
 	int index;
-	uint32_t hash_size =  1u << BATADV_BLA_BACKBONE_HASH_BITS;
-
-	if (!hash)
-		return NULL;
+	uint32_t hash_size = ARRAY_SIZE(bat_priv->bla.backbone_hash);
 
 	ether_addr_copy(search_entry.orig, addr);
 	search_entry.vid = vid;
 
 	index = batadv_choose_backbone_gw(&search_entry, hash_size);
-	head = &hash->table[index];
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -210,20 +204,19 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 static void
 batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 {
-	struct batadv_hashtable *hash;
+	struct batadv_priv *bat_priv = backbone_gw->bat_priv;
+	struct batadv_bucket *hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	struct batadv_bla_claim *claim;
 	int i;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 
-	hash = backbone_gw->bat_priv->bla.claim_hash;
-	if (!hash)
-		return;
+	hash = bat_priv->bla.claim_hash;
 
-	for (i = 0; i < 1u << BATADV_BLA_CLAIM_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(claim, node_tmp,
@@ -394,7 +387,6 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, uint8_t *orig,
 	atomic_set(&entry->refcount, 2);
 
 	hash_added = batadv_hash_add(bat_priv->bla.backbone_hash,
-				     1u << BATADV_BLA_BACKBONE_HASH_BITS,
 				     batadv_compare_backbone_gw,
 				     batadv_choose_backbone_gw, entry,
 				     &entry->hash_entry);
@@ -459,7 +451,7 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 				      unsigned short vid)
 {
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct batadv_bucket *hash;
 	struct batadv_bla_claim *claim;
 	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
@@ -474,8 +466,8 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 		return;
 
 	hash = bat_priv->bla.claim_hash;
-	for (i = 0; i < 1u << BATADV_BLA_CLAIM_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -578,7 +570,6 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			   "bla_add_claim(): adding new entry %pM, vid %d to hash ...\n",
 			   mac, BATADV_PRINT_VID(vid));
 		hash_added = batadv_hash_add(bat_priv->bla.claim_hash,
-					     1u << BATADV_BLA_CLAIM_HASH_BITS,
 					     batadv_compare_claim,
 					     batadv_choose_claim, claim,
 					     &claim->hash_entry);
@@ -629,9 +620,8 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_del_claim(): %pM, vid %d\n",
 		   mac, BATADV_PRINT_VID(vid));
 
-	batadv_hash_remove(bat_priv->bla.claim_hash,
-			   1u << BATADV_BLA_CLAIM_HASH_BITS,
-			   batadv_compare_claim, batadv_choose_claim, claim);
+	batadv_hash_remove(bat_priv->bla.claim_hash, batadv_compare_claim,
+			   batadv_choose_claim, claim);
 	batadv_claim_free_ref(claim); /* reference from the hash is gone */
 
 	claim->backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
@@ -990,17 +980,15 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct batadv_bucket *hash;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
 	int i;
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(backbone_gw, node_tmp,
@@ -1044,15 +1032,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 {
 	struct batadv_bla_claim *claim;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct batadv_bucket *hash;
 	int i;
 
 	hash = bat_priv->bla.claim_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i < 1u << BATADV_BLA_CLAIM_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -1092,7 +1078,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct hlist_head *head;
-	struct batadv_hashtable *hash;
+	struct batadv_bucket *hash;
 	__be16 group;
 	int i;
 
@@ -1111,11 +1097,9 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	}
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		return;
 
-	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1146,7 +1130,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	struct batadv_priv_bla *priv_bla;
 	struct hlist_head *head;
 	struct batadv_bla_backbone_gw *backbone_gw;
-	struct batadv_hashtable *hash;
+	struct batadv_bucket *hash;
 	struct batadv_hard_iface *primary_if;
 	int i;
 
@@ -1164,11 +1148,9 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 		goto out;
 
 	hash = bat_priv->bla.backbone_hash;
-	if (!hash)
-		goto out;
 
-	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1208,14 +1190,6 @@ out:
 			   msecs_to_jiffies(BATADV_BLA_PERIOD_LENGTH));
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
@@ -1224,8 +1198,6 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	struct batadv_hard_iface *primary_if;
 	uint16_t crc;
 	unsigned long entrytime;
-	uint32_t hash_claim_size = 1u << BATADV_BLA_CLAIM_HASH_BITS;
-	uint32_t hash_backbone_size = 1u << BATADV_BLA_BACKBONE_HASH_BITS;
 
 	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1249,21 +1221,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
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
-				   1u << BATADV_BLA_CLAIM_HASH_BITS,
-				   &batadv_claim_hash_lock_class_key);
-	batadv_hash_set_lock_class(bat_priv->bla.backbone_hash,
-				   1u << BATADV_BLA_CLAIM_HASH_BITS,
-				   &batadv_backbone_hash_lock_class_key);
+	batadv_hash_init(bat_priv->bla.claim_hash);
+	batadv_hash_init(bat_priv->bla.backbone_hash);
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hashes initialized\n");
 
@@ -1357,7 +1316,7 @@ out:
 bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
 				    unsigned short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct batadv_bucket *hash = bat_priv->bla.backbone_hash;
 	struct hlist_head *head;
 	struct batadv_bla_backbone_gw *backbone_gw;
 	int i;
@@ -1365,11 +1324,8 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
 	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
 		return false;
 
-	if (!hash)
-		return false;
-
-	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1428,16 +1384,9 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
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
@@ -1629,7 +1578,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->bla.claim_hash;
+	struct batadv_bucket *hash = bat_priv->bla.claim_hash;
 	struct batadv_bla_claim *claim;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
@@ -1648,8 +1597,8 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-6s)\n",
 		   "Client", "VID", "Originator", "CRC");
-	for (i = 0; i < 1u << BATADV_BLA_CLAIM_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.claim_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -1673,7 +1622,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->bla.backbone_hash;
+	struct batadv_bucket *hash = bat_priv->bla.backbone_hash;
 	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
@@ -1693,8 +1642,8 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s %-9s (%-6s)\n",
 		   "Originator", "VID", "last seen", "CRC");
-	for (i = 0; i < 1u << BATADV_BLA_BACKBONE_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->bla.backbone_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index a027e75..b40789a 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -85,12 +85,9 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->dat.hash)
-		return;
-
-	for (i = 0; i < 1u << BATADV_DAT_HASH_BITS; i++) {
-		head = &bat_priv->dat.hash->table[i];
-		list_lock = &bat_priv->dat.hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->dat.hash); i++) {
+		head = &bat_priv->dat.hash[i].head;
+		list_lock = &bat_priv->dat.hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(dat_entry, node_tmp, head,
@@ -245,17 +242,14 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 {
 	struct hlist_head *head;
 	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp = NULL;
-	struct batadv_hashtable *hash = bat_priv->dat.hash;
+	struct batadv_bucket *hash = bat_priv->dat.hash;
 	uint32_t index;
 
-	if (!hash)
-		return NULL;
-
 	to_find.ip = ip;
 	to_find.vid = vid;
 
-	index = batadv_hash_dat(&to_find, 1u << BATADV_DAT_HASH_BITS);
-	head = &hash->table[index];
+	index = batadv_hash_dat(&to_find, ARRAY_SIZE(bat_priv->dat.hash));
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
@@ -309,9 +303,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);
 
-	hash_added = batadv_hash_add(bat_priv->dat.hash,
-				     1u << BATADV_DAT_HASH_BITS,
-				     batadv_compare_dat,
+	hash_added = batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
 				     batadv_hash_dat, dat_entry,
 				     &dat_entry->hash_entry);
 
@@ -482,7 +474,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 {
 	batadv_dat_addr_t max = 0, tmp_max = 0;
 	struct batadv_orig_node *orig_node, *max_orig_node = NULL;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	int i;
 
@@ -494,8 +486,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 	/* iterate over the originator list and find the node with the closest
 	 * dat_address which has not been selected yet
 	 */
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -549,9 +541,6 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
 	struct batadv_dat_candidate *res;
 
-	if (!bat_priv->orig_hash)
-		return NULL;
-
 	res = kmalloc_array(BATADV_DAT_CANDIDATES_NUM, sizeof(*res),
 			    GFP_ATOMIC);
 	if (!res)
@@ -708,14 +697,7 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
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
@@ -724,13 +706,7 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
  */
 int batadv_dat_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->dat.hash)
-		return 0;
-
-	bat_priv->dat.hash = batadv_hash_new(1u << BATADV_DAT_HASH_BITS);
-
-	if (!bat_priv->dat.hash)
-		return -ENOMEM;
+	batadv_hash_init(bat_priv->dat.hash);
 
 	batadv_dat_start_timer(bat_priv);
 
@@ -764,7 +740,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->dat.hash;
+	struct batadv_bucket *hash = bat_priv->dat.hash;
 	struct batadv_dat_entry *dat_entry;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
@@ -780,8 +756,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv4",
 		   "MAC", "VID", "last-seen");
 
-	for (i = 0; i < 1u << BATADV_DAT_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->dat.hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
diff --git a/hash.c b/hash.c
deleted file mode 100644
index 8e8d934..0000000
--- a/hash.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
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
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
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
-	hash->table = kmalloc_array(size, sizeof(*hash->table), GFP_ATOMIC);
-	if (!hash->table)
-		goto free_hash;
-
-	hash->list_locks = kmalloc_array(size, sizeof(*hash->list_locks),
-					 GFP_ATOMIC);
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
index c88166b..d6a23bc 100644
--- a/hash.h
+++ b/hash.h
@@ -20,6 +20,15 @@
 
 #include <linux/list.h>
 
+#define batadv_hash_init(hashtable) \
+	do { \
+		uint32_t _it; \
+		for (_it = 0; _it < ARRAY_SIZE(hashtable); _it++) { \
+			INIT_HLIST_HEAD(&hashtable[_it].head); \
+			spin_lock_init(&hashtable[_it].lock); \
+		} \
+	} while (0)
+
 /* callback to a compare function.  should compare 2 element datas for their
  * keys, return 0 if same and not 0 if not same
  */
@@ -33,38 +42,26 @@ typedef int (*batadv_hashdata_compare_cb)(const struct hlist_node *,
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
+#define batadv_hash_delete(hash, free_cb, arg) \
+	_batadv_hash_delete(hash, ARRAY_SIZE(hash), free_cb, arg)
+
+static inline void _batadv_hash_delete(struct batadv_bucket *hash,
+				       uint32_t hash_size,
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
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_safe(node, node_tmp, head) {
@@ -75,14 +72,11 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
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
@@ -91,12 +85,16 @@ static inline void batadv_hash_delete(struct batadv_hashtable *hash,
  *	Returns 0 on success, 1 if the element already is in the hash
  *	and -1 on error.
  */
-static inline int batadv_hash_add(struct batadv_hashtable *hash,
-				  uint32_t size,
-				  batadv_hashdata_compare_cb compare,
-				  batadv_hashdata_choose_cb choose,
-				  const void *data,
-				  struct hlist_node *data_node)
+#define batadv_hash_add(hash, compare, choose, data, data_node) \
+	_batadv_hash_add(hash, ARRAY_SIZE(hash), compare, choose, data, \
+			 data_node)
+
+static inline int _batadv_hash_add(struct batadv_bucket *hash,
+				   uint32_t hash_size,
+				   batadv_hashdata_compare_cb compare,
+				   batadv_hashdata_choose_cb choose,
+				   const void *data,
+				   struct hlist_node *data_node)
 {
 	uint32_t index;
 	int ret = -1;
@@ -107,9 +105,9 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
 	if (!hash)
 		goto out;
 
-	index = choose(data, size);
-	head = &hash->table[index];
-	list_lock = &hash->list_locks[index];
+	index = choose(data, hash_size);
+	head = &hash[index].head;
+	list_lock = &hash[index].lock;
 
 	spin_lock_bh(list_lock);
 
@@ -137,21 +135,24 @@ out:
  * structure you use with just the key filled, we just need the key for
  * comparing.
  */
-static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
-				       uint32_t size,
-				       batadv_hashdata_compare_cb compare,
-				       batadv_hashdata_choose_cb choose,
-				       void *data)
+#define batadv_hash_remove(hash, compare, choose, data) \
+	_batadv_hash_remove(hash, ARRAY_SIZE(hash), compare, choose, data)
+
+static inline void *_batadv_hash_remove(struct batadv_bucket *hash,
+					uint32_t hash_size,
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
+	head = &hash[index].head;
 
-	spin_lock_bh(&hash->list_locks[index]);
+	spin_lock_bh(&hash[index].lock);
 	hlist_for_each(node, head) {
 		if (!compare(node, data))
 			continue;
@@ -160,7 +161,7 @@ static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
 		hlist_del_rcu(node);
 		break;
 	}
-	spin_unlock_bh(&hash->list_locks[index]);
+	spin_unlock_bh(&hash[index].lock);
 
 	return data_save;
 }
diff --git a/network-coding.c b/network-coding.c
index 6f0ceb4..cb0c7ab 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -25,9 +25,6 @@
 #include "hard-interface.h"
 #include "routing.h"
 
-static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
-static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
-
 static void batadv_nc_worker(struct work_struct *work);
 static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
@@ -116,30 +113,12 @@ static void batadv_nc_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
  */
 int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 {
-	uint32_t hash_coding_size = 1u << BATADV_NC_CODING_HASH_BITS;
-	uint32_t hash_decoding_size = 1u << BATADV_NC_DECODING_HASH_BITS;
 
 	bat_priv->nc.timestamp_fwd_flush = jiffies;
 	bat_priv->nc.timestamp_sniffed_purge = jiffies;
 
-	if (bat_priv->nc.coding_hash || bat_priv->nc.decoding_hash)
-		return 0;
-
-	bat_priv->nc.coding_hash = batadv_hash_new(hash_coding_size);
-	if (!bat_priv->nc.coding_hash)
-		goto err;
-
-	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
-				   1u << BATADV_NC_CODING_HASH_BITS,
-				   &batadv_nc_coding_hash_lock_class_key);
-
-	bat_priv->nc.decoding_hash = batadv_hash_new(hash_decoding_size);
-	if (!bat_priv->nc.decoding_hash)
-		goto err;
-
-	batadv_hash_set_lock_class(bat_priv->nc.decoding_hash,
-				   1u << BATADV_NC_DECODING_HASH_BITS,
-				   &batadv_nc_decoding_hash_lock_class_key);
+	batadv_hash_init(bat_priv->nc.coding_hash);
+	batadv_hash_init(bat_priv->nc.decoding_hash);
 
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
 	batadv_nc_start_timer(bat_priv);
@@ -149,9 +128,6 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 	batadv_nc_tvlv_container_update(bat_priv);
 	return 0;
-
-err:
-	return -ENOMEM;
 }
 
 /**
@@ -354,17 +330,14 @@ void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
  */
 static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
 	/* For each orig_node */
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry)
@@ -374,8 +347,11 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 	}
 }
 
+#define batadv_nc_purge_paths(bat_priv, hash, to_purge) \
+	_batadv_nc_purge_paths(bat_priv, hash, ARRAY_SIZE(hash), to_purge)
+
 /**
- * batadv_nc_purge_paths - traverse all nc paths part of the hash and remove
+ * _batadv_nc_purge_paths - traverse all nc paths part of the hash and remove
  *  unused ones
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the nc paths to check
@@ -385,11 +361,11 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
  *	      a boolean value: true is the entry has to be deleted, false
  *	      otherwise
  */
-static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
-				  struct batadv_hashtable *hash,
-				  uint32_t hash_size,
-				  bool (*to_purge)(struct batadv_priv *,
-						   struct batadv_nc_path *))
+static void _batadv_nc_purge_paths(struct batadv_priv *bat_priv,
+				   struct batadv_bucket *hash,
+				   uint32_t hash_size,
+				   bool (*to_purge)(struct batadv_priv *,
+						    struct batadv_nc_path *))
 {
 	struct hlist_head *head;
 	struct hlist_node *node_tmp;
@@ -398,8 +374,8 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 	uint32_t i;
 
 	for (i = 0; i < hash_size; i++) {
-		head = &hash->table[i];
-		lock = &hash->list_locks[i];
+		head = &hash[i].head;
+		lock = &hash[i].lock;
 
 		/* For each nc_path in this bin */
 		spin_lock_bh(lock);
@@ -503,18 +479,15 @@ static int batadv_nc_hash_compare(const struct hlist_node *node,
  * Returns the nc_path if found, NULL otherwise.
  */
 static struct batadv_nc_path *
-batadv_nc_hash_find(struct batadv_hashtable *hash, uint32_t hash_size,
+batadv_nc_hash_find(struct batadv_bucket *hash, uint32_t hash_size,
 		    void *data)
 {
 	struct hlist_head *head;
 	struct batadv_nc_path *nc_path, *nc_path_tmp = NULL;
 	int index;
 
-	if (!hash)
-		return NULL;
-
 	index = batadv_nc_hash_choose(data, hash_size);
-	head = &hash->table[index];
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(nc_path, head, hash_entry) {
@@ -618,9 +591,13 @@ static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
 	return true;
 }
 
+#define batadv_nc_process_nc_paths(bat_priv, hash, process_fn) \
+	_batadv_nc_process_nc_paths(bat_priv, hash, ARRAY_SIZE(hash), \
+				    process_fn)
+
 /**
- * batadv_nc_process_nc_paths - traverse given nc packet pool and free timed out
- *  nc packets
+ * batadv_nc_process_nc_paths - traverse given nc packet pool and free timed
+ *  out nc packets
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: to be processed hash table
  * @hash_size: number of buckets in the hashtable
@@ -629,11 +606,11 @@ static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
  *	        Otherwise the rest of the current queue is skipped.
  */
 static void
-batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
-			   struct batadv_hashtable *hash, uint32_t hash_size,
-			   bool (*process_fn)(struct batadv_priv *,
-					      struct batadv_nc_path *,
-					      struct batadv_nc_packet *))
+_batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
+			    struct batadv_bucket *hash, uint32_t hash_size,
+			    bool (*process_fn)(struct batadv_priv *,
+					       struct batadv_nc_path *,
+					       struct batadv_nc_packet *))
 {
 	struct hlist_head *head;
 	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
@@ -641,12 +618,9 @@ batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
 	bool ret;
 	int i;
 
-	if (!hash)
-		return;
-
 	/* Loop hash table bins */
 	for (i = 0; i < hash_size; i++) {
-		head = &hash->table[i];
+		head = &hash[i].head;
 
 		/* Loop coding paths */
 		rcu_read_lock();
@@ -682,17 +656,14 @@ static void batadv_nc_worker(struct work_struct *work)
 
 	batadv_nc_purge_orig_hash(bat_priv);
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash,
-			      1u << BATADV_NC_CODING_HASH_BITS,
 			      batadv_nc_to_purge_nc_path_coding);
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash,
-			      1u << BATADV_NC_DECODING_HASH_BITS,
 			      batadv_nc_to_purge_nc_path_decoding);
 
 	timeout = bat_priv->nc.max_fwd_delay;
 
 	if (batadv_has_timed_out(bat_priv->nc.timestamp_fwd_flush, timeout)) {
 		batadv_nc_process_nc_paths(bat_priv, bat_priv->nc.coding_hash,
-					   1u << BATADV_NC_CODING_HASH_BITS,
 					   batadv_nc_fwd_flush);
 		bat_priv->nc.timestamp_fwd_flush = jiffies;
 	}
@@ -700,7 +671,6 @@ static void batadv_nc_worker(struct work_struct *work)
 	if (batadv_has_timed_out(bat_priv->nc.timestamp_sniffed_purge,
 				 bat_priv->nc.max_buffer_time)) {
 		batadv_nc_process_nc_paths(bat_priv, bat_priv->nc.decoding_hash,
-					   1u << BATADV_NC_DECODING_HASH_BITS,
 					   batadv_nc_sniffed_purge);
 		bat_priv->nc.timestamp_sniffed_purge = jiffies;
 	}
@@ -921,7 +891,7 @@ out:
  * on error.
  */
 static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
-						 struct batadv_hashtable *hash,
+						 struct batadv_bucket *hash,
 						 uint32_t hash_size,
 						 uint8_t *src,
 						 uint8_t *dst)
@@ -959,9 +929,9 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 		   nc_path->next_hop);
 
 	/* Add nc_path to hash table */
-	hash_added = batadv_hash_add(hash, hash_size, batadv_nc_hash_compare,
-				     batadv_nc_hash_choose, &nc_path_key,
-				     &nc_path->hash_entry);
+	hash_added = _batadv_hash_add(hash, hash_size, batadv_nc_hash_compare,
+				      batadv_nc_hash_choose, &nc_path_key,
+				      &nc_path->hash_entry);
 
 	if (hash_added < 0) {
 		kfree(nc_path);
@@ -1245,21 +1215,18 @@ batadv_nc_path_search(struct batadv_priv *bat_priv,
 	struct batadv_nc_path *nc_path, nc_path_key;
 	struct batadv_nc_packet *nc_packet_out = NULL;
 	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
-	struct batadv_hashtable *hash = bat_priv->nc.coding_hash;
+	struct batadv_bucket *hash = bat_priv->nc.coding_hash;
 	int idx;
 
-	if (!hash)
-		return NULL;
-
 	/* Create almost path key */
 	batadv_nc_hash_key_gen(&nc_path_key, in_nc_node->addr,
 			       out_nc_node->addr);
 	idx = batadv_nc_hash_choose(&nc_path_key,
-				    1u << BATADV_NC_CODING_HASH_BITS);
+				    ARRAY_SIZE(bat_priv->nc.coding_hash));
 
 	/* Check for coding opportunities in this nc_path */
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, &hash->table[idx], hash_entry) {
+	hlist_for_each_entry_rcu(nc_path, &hash[idx].head, hash_entry) {
 		if (!batadv_compare_eth(nc_path->prev_hop, in_nc_node->addr))
 			continue;
 
@@ -1503,7 +1470,7 @@ bool batadv_nc_skb_forward(struct sk_buff *skb,
 	/* Find or create a nc_path for this src-dst pair */
 	nc_path = batadv_nc_get_path(bat_priv,
 				     bat_priv->nc.coding_hash,
-				     1u << BATADV_NC_CODING_HASH_BITS,
+				     ARRAY_SIZE(bat_priv->nc.coding_hash),
 				     ethhdr->h_source,
 				     neigh_node->addr);
 
@@ -1553,7 +1520,7 @@ void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 	/* Find existing nc_path or create a new */
 	nc_path = batadv_nc_get_path(bat_priv,
 				     bat_priv->nc.decoding_hash,
-				     1u << BATADV_NC_DECODING_HASH_BITS,
+				     ARRAY_SIZE(bat_priv->nc.decoding_hash),
 				     ethhdr->h_source,
 				     ethhdr->h_dest);
 
@@ -1715,16 +1682,13 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 			       struct ethhdr *ethhdr,
 			       struct batadv_coded_packet *coded)
 {
-	struct batadv_hashtable *hash = bat_priv->nc.decoding_hash;
+	struct batadv_bucket *hash = bat_priv->nc.decoding_hash;
 	struct batadv_nc_packet *tmp_nc_packet, *nc_packet = NULL;
 	struct batadv_nc_path *nc_path, nc_path_key;
 	uint8_t *dest, *source;
 	__be32 packet_id;
 	int index;
 
-	if (!hash)
-		return NULL;
-
 	/* Select the correct packet id based on the location of our mac-addr */
 	dest = ethhdr->h_source;
 	if (!batadv_is_my_mac(bat_priv, coded->second_dest)) {
@@ -1737,11 +1701,11 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 
 	batadv_nc_hash_key_gen(&nc_path_key, source, dest);
 	index = batadv_nc_hash_choose(&nc_path_key,
-				      1u << BATADV_NC_DECODING_HASH_BITS);
+				      ARRAY_SIZE(bat_priv->nc.decoding_hash));
 
 	/* Search for matching coding path */
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, &hash->table[index], hash_entry) {
+	hlist_for_each_entry_rcu(nc_path, &hash[index].head, hash_entry) {
 		/* Find matching nc_packet */
 		spin_lock_bh(&nc_path->packet_list_lock);
 		list_for_each_entry(tmp_nc_packet,
@@ -1846,12 +1810,8 @@ void batadv_nc_mesh_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_NC, 1);
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 
-	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash,
-			      1u << BATADV_NC_CODING_HASH_BITS, NULL);
-	batadv_hash_destroy(bat_priv->nc.coding_hash);
-	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash,
-			      1u << BATADV_NC_DECODING_HASH_BITS, NULL);
-	batadv_hash_destroy(bat_priv->nc.decoding_hash);
+	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
+	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash, NULL);
 }
 
 /**
@@ -1863,7 +1823,7 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct batadv_hard_iface *primary_if;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -1875,8 +1835,8 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	/* Traverse list of originators */
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		/* For each orig_node in this bin */
 		rcu_read_lock();
diff --git a/originator.c b/originator.c
index 55baa3d..22996ec 100644
--- a/originator.c
+++ b/originator.c
@@ -29,9 +29,6 @@
 #include "fragmentation.h"
 #include "multicast.h"
 
-/* hash class keys */
-static struct lock_class_key batadv_orig_hash_lock_class_key;
-
 static void batadv_purge_orig(struct work_struct *work);
 
 /* returns 1 if they are the same originator */
@@ -127,17 +124,7 @@ void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan)
 
 int batadv_originator_init(struct batadv_priv *bat_priv)
 {
-	if (bat_priv->orig_hash)
-		return 0;
-
-	bat_priv->orig_hash = batadv_hash_new(1u << BATADV_ORIG_HASH_BITS);
-
-	if (!bat_priv->orig_hash)
-		goto err;
-
-	batadv_hash_set_lock_class(bat_priv->orig_hash,
-				   1u << BATADV_ORIG_HASH_BITS,
-				   &batadv_orig_hash_lock_class_key);
+	batadv_hash_init(bat_priv->orig_hash);
 
 	INIT_DELAYED_WORK(&bat_priv->orig_work, batadv_purge_orig);
 	queue_delayed_work(batadv_event_workqueue,
@@ -145,9 +132,6 @@ int batadv_originator_init(struct batadv_priv *bat_priv)
 			   msecs_to_jiffies(BATADV_ORIG_WORK_PERIOD));
 
 	return 0;
-
-err:
-	return -ENOMEM;
 }
 
 /**
@@ -602,23 +586,18 @@ void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node)
 
 void batadv_originator_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct hlist_node *node_tmp;
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
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node_tmp,
@@ -628,8 +607,6 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
 }
 
 /**
@@ -954,20 +931,17 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 
 static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
 	/* for all origins... */
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node_tmp,
@@ -1090,7 +1064,7 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
@@ -1099,8 +1073,8 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -1125,7 +1099,7 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_hard_iface *hard_iface_tmp;
 	struct batadv_orig_node *orig_node;
@@ -1136,8 +1110,8 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < 1u << BATADV_ORIG_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->orig_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/originator.h b/originator.h
index 89b810d..e0eb8fc 100644
--- a/originator.h
+++ b/originator.h
@@ -84,16 +84,13 @@ static inline uint32_t batadv_choose_orig(const void *data, uint32_t size)
 static inline struct batadv_orig_node *
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 {
-	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct batadv_bucket *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node, *orig_node_tmp = NULL;
 	int index;
 
-	if (!hash)
-		return NULL;
-
-	index = batadv_choose_orig(data, 1u << BATADV_ORIG_HASH_BITS);
-	head = &hash->table[index];
+	index = batadv_choose_orig(data, ARRAY_SIZE(bat_priv->orig_hash));
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/translation-table.c b/translation-table.c
index 60be9c6..81a5793 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -28,10 +28,6 @@
 
 #include <linux/crc32c.h>
 
-/* hash class keys */
-static struct lock_class_key batadv_tt_local_hash_lock_class_key;
-static struct lock_class_key batadv_tt_global_hash_lock_class_key;
-
 static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 				 unsigned short vid,
 				 struct batadv_orig_node *orig_node);
@@ -73,8 +69,11 @@ static inline uint32_t batadv_choose_tt(const void *data, uint32_t size)
 	return hash % size;
 }
 
+#define batadv_tt_hash_find(hash, addr, vid) \
+	_batadv_tt_hash_find(hash, ARRAY_SIZE(hash), addr, vid)
+
 /**
- * batadv_tt_hash_find - look for a client in the given hash table
+ * _batadv_tt_hash_find - look for a client in the given hash table
  * @hash: the hash table to search
  * @addr: the mac address of the client to look for
  * @vid: VLAN identifier
@@ -83,21 +82,18 @@ static inline uint32_t batadv_choose_tt(const void *data, uint32_t size)
  * found, NULL otherwise.
  */
 static struct batadv_tt_common_entry *
-batadv_tt_hash_find(struct batadv_hashtable *hash, uint32_t size,
-		    const uint8_t *addr, unsigned short vid)
+_batadv_tt_hash_find(struct batadv_bucket *hash, uint32_t size,
+		     const uint8_t *addr, unsigned short vid)
 {
 	struct hlist_head *head;
 	struct batadv_tt_common_entry to_search, *tt, *tt_tmp = NULL;
 	uint32_t index;
 
-	if (!hash)
-		return NULL;
-
 	ether_addr_copy(to_search.addr, addr);
 	to_search.vid = vid;
 
 	index = batadv_choose_tt(&to_search, size);
-	head = &hash->table[index];
+	head = &hash[index].head;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tt, head, hash_entry) {
@@ -134,9 +130,8 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const uint8_t *addr,
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 
-	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash,
-					      1u << BATADV_TT_LOCAL_HASH_BITS,
-					      addr, vid);
+	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash, addr,
+					      vid);
 	if (tt_common_entry)
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
@@ -160,9 +155,8 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const uint8_t *addr,
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 
-	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash,
-					      1u << BATADV_TT_GLOBAL_HASH_BITS,
-					      addr, vid);
+	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash, addr,
+					      vid);
 	if (tt_common_entry)
 		tt_global_entry = container_of(tt_common_entry,
 					       struct batadv_tt_global_entry,
@@ -462,18 +456,7 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 
 static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 {
-	uint32_t hash_size = 1u << BATADV_TT_LOCAL_HASH_BITS;
-
-	if (bat_priv->tt.local_hash)
-		return 0;
-
-	bat_priv->tt.local_hash = batadv_hash_new(hash_size);
-
-	if (!bat_priv->tt.local_hash)
-		return -ENOMEM;
-
-	batadv_hash_set_lock_class(bat_priv->tt.local_hash, hash_size,
-				   &batadv_tt_local_hash_lock_class_key);
+	batadv_hash_init(bat_priv->tt.local_hash);
 
 	return 0;
 }
@@ -487,8 +470,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 		   tt_global->common.addr,
 		   BATADV_PRINT_VID(tt_global->common.vid), message);
 
-	batadv_hash_remove(bat_priv->tt.global_hash,
-			   1u << BATADV_TT_GLOBAL_HASH_BITS, batadv_compare_tt,
+	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
 			   batadv_choose_tt, &tt_global->common);
 	batadv_tt_global_entry_free_ref(tt_global);
 }
@@ -603,7 +585,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash,
-				     1u << BATADV_TT_LOCAL_HASH_BITS,
 				     batadv_compare_tt, batadv_choose_tt,
 				     &tt_local->common,
 				     &tt_local->common.hash_entry);
@@ -905,7 +886,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_bucket *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_hard_iface *primary_if;
@@ -929,8 +910,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s  %s %-8s %-9s (%-10s)\n", "Client", "VID",
 		   "Flags", "Last seen", "CRC");
 
-	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -1104,14 +1085,14 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 				  int timeout)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_bucket *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		batadv_tt_local_purge_list(bat_priv, head, timeout);
@@ -1121,7 +1102,7 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 
 static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
+	struct batadv_bucket *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
@@ -1130,14 +1111,11 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->tt.local_hash)
-		return;
-
 	hash = bat_priv->tt.local_hash;
 
-	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
@@ -1157,26 +1135,11 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
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
-	uint32_t hash_size = 1u << BATADV_TT_GLOBAL_HASH_BITS;
-
-	if (bat_priv->tt.global_hash)
-		return 0;
-
-	bat_priv->tt.global_hash = batadv_hash_new(hash_size);
-
-	if (!bat_priv->tt.global_hash)
-		return -ENOMEM;
-
-	batadv_hash_set_lock_class(bat_priv->tt.global_hash, hash_size,
-				   &batadv_tt_global_hash_lock_class_key);
+	batadv_hash_init(bat_priv->tt.global_hash);
 
 	return 0;
 }
@@ -1353,7 +1316,6 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 		spin_lock_init(&tt_global_entry->list_lock);
 
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
-					     1u << BATADV_TT_GLOBAL_HASH_BITS,
 					     batadv_compare_tt,
 					     batadv_choose_tt, common,
 					     &common->hash_entry);
@@ -1579,7 +1541,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_bucket *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global;
 	struct batadv_hard_iface *primary_if;
@@ -1597,8 +1559,8 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		   "Client", "VID", "(TTVN)", "Originator", "(Curr TTVN)",
 		   "CRC", "Flags");
 
-	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -1810,18 +1772,15 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	struct batadv_tt_global_entry *tt_global;
 	struct batadv_tt_common_entry *tt_common_entry;
 	uint32_t i;
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_bucket *hash = bat_priv->tt.global_hash;
 	struct hlist_node *safe;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	unsigned short vid;
 
-	if (!hash)
-		return;
-
-	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, safe,
@@ -1876,7 +1835,7 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 
 static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_bucket *hash = bat_priv->tt.global_hash;
 	struct hlist_head *head;
 	struct hlist_node *node_tmp;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
@@ -1885,9 +1844,9 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 
-	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
@@ -1915,7 +1874,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
+	struct batadv_bucket *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global;
@@ -1923,14 +1882,11 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!bat_priv->tt.global_hash)
-		return;
-
 	hash = bat_priv->tt.global_hash;
 
-	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
@@ -1943,10 +1899,6 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 		}
 		spin_unlock_bh(list_lock);
 	}
-
-	batadv_hash_destroy(hash);
-
-	bat_priv->tt.global_hash = NULL;
 }
 
 static bool
@@ -2055,7 +2007,7 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 				     struct batadv_orig_node *orig_node,
 				     unsigned short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
+	struct batadv_bucket *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
@@ -2063,8 +2015,8 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	uint8_t flags;
 	__be16 tmp_vid;
 
-	for (i = 0; i < 1u << BATADV_TT_GLOBAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.global_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
@@ -2131,15 +2083,15 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 				    unsigned short vid)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_bucket *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
 	uint32_t i, crc_tmp, crc = 0;
 	uint8_t flags;
 	__be16 tmp_vid;
 
-	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
@@ -2301,7 +2253,7 @@ static int batadv_tt_global_valid(const void *entry_ptr,
  * @cb_data: data passed to the filter function as argument
  */
 static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
-				    struct batadv_hashtable *hash,
+				    struct batadv_bucket *hash,
 				    uint32_t hash_size, void *tvlv_buff,
 				    uint16_t tt_len,
 				    int (*valid_cb)(const void *, const void *),
@@ -2318,7 +2270,7 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 
 	rcu_read_lock();
 	for (i = 0; i < hash_size; i++) {
-		head = &hash->table[i];
+		head = &hash[i].head;
 
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
@@ -2597,7 +2549,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 
 		/* fill the rest of the tvlv with the real TT entries */
 		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.global_hash,
-					1u << BATADV_TT_GLOBAL_HASH_BITS,
+					ARRAY_SIZE(bat_priv->tt.global_hash),
 					tt_change, tt_len,
 					batadv_tt_global_valid,
 					req_dst_orig_node);
@@ -2727,7 +2679,7 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 
 		/* fill the rest of the tvlv with the real TT entries */
 		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.local_hash,
-					1u << BATADV_TT_LOCAL_HASH_BITS,
+					ARRAY_SIZE(bat_priv->tt.local_hash),
 					tt_change, tt_len,
 					batadv_tt_local_valid, NULL);
 	}
@@ -3124,17 +3076,14 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv,
 				      uint16_t flags, bool enable, bool count)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_bucket *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	uint16_t changed_num = 0;
 	struct hlist_head *head;
 	uint32_t i;
 
-	if (!hash)
-		return;
-
-	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -3163,7 +3112,7 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv,
 /* Purge out all the tt local entries marked with BATADV_TT_CLIENT_PENDING */
 static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_bucket *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_softif_vlan *vlan;
@@ -3172,12 +3121,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	if (!hash)
-		return;
-
-	for (i = 0; i < 1u << BATADV_TT_LOCAL_HASH_BITS; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < ARRAY_SIZE(bat_priv->tt.local_hash); i++) {
+		head = &hash[i].head;
+		list_lock = &hash[i].lock;
 
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
diff --git a/types.h b/types.h
index de09807..60fb1b5 100644
--- a/types.h
+++ b/types.h
@@ -35,6 +35,16 @@
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
 /**
+ * struct batadv_bucket - bucket for concurrent, list based hashtable
+ * @head: pointer to the data of this bucket
+ * @lock: lock protecting writes to this bucket
+ */
+struct batadv_bucket {
+	struct hlist_head head;
+	spinlock_t lock; /* Protects head */
+};
+
+/**
  * enum batadv_dhcp_recipient - dhcp destination
  * @BATADV_DHCP_NO: packet is not a dhcp message
  * @BATADV_DHCP_TO_SERVER: dhcp message is directed to a server
@@ -517,8 +527,8 @@ struct batadv_priv_tt {
 	atomic_t ogm_append_cnt;
 	atomic_t local_changes;
 	struct list_head changes_list;
-	struct batadv_hashtable *local_hash;
-	struct batadv_hashtable *global_hash;
+	struct batadv_bucket local_hash[1u << BATADV_TT_LOCAL_HASH_BITS];
+	struct batadv_bucket global_hash[1u << BATADV_TT_GLOBAL_HASH_BITS];
 	struct list_head req_list;
 	struct list_head roam_list;
 	spinlock_t changes_list_lock; /* protects changes */
@@ -548,8 +558,8 @@ struct batadv_priv_tt {
 #ifdef CONFIG_BATMAN_ADV_BLA
 struct batadv_priv_bla {
 	atomic_t num_requests;
-	struct batadv_hashtable *claim_hash;
-	struct batadv_hashtable *backbone_hash;
+	struct batadv_bucket claim_hash[1u << BATADV_BLA_CLAIM_HASH_BITS];
+	struct batadv_bucket backbone_hash[1u << BATADV_BLA_BACKBONE_HASH_BITS];
 	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
 	/* protects bcast_duplist & bcast_duplist_curr */
@@ -613,12 +623,13 @@ struct batadv_priv_tvlv {
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
+	struct batadv_bucket hash[1u << BATADV_DAT_HASH_BITS];
 	struct delayed_work work;
 };
 #endif
@@ -681,8 +692,8 @@ struct batadv_priv_nc {
 	u32 max_buffer_time;
 	unsigned long timestamp_fwd_flush;
 	unsigned long timestamp_sniffed_purge;
-	struct batadv_hashtable *coding_hash;
-	struct batadv_hashtable *decoding_hash;
+	struct batadv_bucket coding_hash[1u << BATADV_NC_CODING_HASH_BITS];
+	struct batadv_bucket decoding_hash[1u << BATADV_NC_DECODING_HASH_BITS];
 };
 
 /**
@@ -795,7 +806,7 @@ struct batadv_priv {
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
-	struct batadv_hashtable *orig_hash;
+	struct batadv_bucket orig_hash[1u << BATADV_ORIG_HASH_BITS];
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects forw_bcast_list */
 	struct delayed_work orig_work;
-- 
2.1.4

