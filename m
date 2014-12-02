Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:28 +0100
Message-Id: <1417519009-20699-11-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/31] batman-adv: hash,
	replace direct hash structure accesses
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Use the hash helper functions instead of directly accessing the hash
struct. This will provide a cleaner interface to the hashtable
implementation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c            |  8 ++---
 bridge_loop_avoidance.c | 57 +++++++++++++++-----------------
 distributed-arp-table.c | 26 +++++++--------
 network-coding.c        | 36 ++++++++++----------
 originator.c            | 28 +++++++---------
 originator.h            |  4 +--
 translation-table.c     | 88 +++++++++++++++++++++----------------------------
 7 files changed, 114 insertions(+), 133 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 20295c5e5121..ee85ea495421 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -873,8 +873,8 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	uint8_t *w;
 	int if_num;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -1813,8 +1813,8 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 		   "Originator", "last-seen", "#", BATADV_TQ_MAX_VALUE,
 		   "Nexthop", "outgoingIF", "Potential nexthops");
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index d93288377f80..6e7692828366 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -151,8 +151,8 @@ static struct batadv_bla_claim
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_claim(data, hash->size);
-	head = &hash->table[index];
+	index = batadv_choose_claim(data, batadv_hash_size(hash));
+	head = batadv_hash_get(hash, index);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -194,8 +194,9 @@ batadv_backbone_hash_find(struct batadv_priv *bat_priv,
 	ether_addr_copy(search_entry.orig, addr);
 	search_entry.vid = vid;
 
-	index = batadv_choose_backbone_gw(&search_entry, hash->size);
-	head = &hash->table[index];
+	index = batadv_choose_backbone_gw(&search_entry,
+					  batadv_hash_size(hash));
+	head = batadv_hash_get(hash, index);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -223,17 +224,15 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 	struct hlist_head *head;
 	struct batadv_bla_claim *claim;
 	int i;
-	spinlock_t *list_lock;	/* protects write access to the hash lists */
 
 	hash = backbone_gw->bat_priv->bla.claim_hash;
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(claim, node_tmp,
 					  head, hash_entry) {
 			if (claim->backbone_gw != backbone_gw)
@@ -242,7 +241,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			batadv_claim_free_ref(claim);
 			hlist_del_rcu(&claim->hash_entry);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 
 	/* all claims gone, intialize CRC */
@@ -481,8 +480,8 @@ static void batadv_bla_answer_request(struct batadv_priv *bat_priv,
 		return;
 
 	hash = bat_priv->bla.claim_hash;
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -996,18 +995,16 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
-	spinlock_t *list_lock;	/* protects write access to the hash lists */
 	int i;
 
 	hash = bat_priv->bla.backbone_hash;
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(backbone_gw, node_tmp,
 					  head, hash_entry) {
 			if (now)
@@ -1030,7 +1027,7 @@ purge_now:
 			hlist_del_rcu(&backbone_gw->hash_entry);
 			batadv_backbone_gw_free_ref(backbone_gw);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 }
 
@@ -1056,8 +1053,8 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -1119,8 +1116,8 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1172,8 +1169,8 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 	if (!hash)
 		goto out;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1369,8 +1366,8 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig,
 	if (!hash)
 		return false;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
@@ -1649,8 +1646,8 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s    %-17s [o] (%-6s)\n",
 		   "Client", "VID", "Originator", "CRC");
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
@@ -1694,8 +1691,8 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 		   ntohs(bat_priv->bla.claim_dest.group));
 	seq_printf(seq, "   %-17s    %-5s %-9s (%-6s)\n",
 		   "Originator", "VID", "last seen", "CRC");
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, head, hash_entry) {
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index e3deff63d393..5855ead2018d 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -81,20 +81,20 @@ static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
 static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 			       bool (*to_purge)(struct batadv_dat_entry *))
 {
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_dat_entry *dat_entry;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
+	struct batadv_hashtable *hash;
 	uint32_t i;
 
-	if (!bat_priv->dat.hash)
+	hash = bat_priv->dat.hash;
+	if (!hash)
 		return;
 
-	for (i = 0; i < bat_priv->dat.hash->size; i++) {
-		head = &bat_priv->dat.hash->table[i];
-		list_lock = &bat_priv->dat.hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(dat_entry, node_tmp, head,
 					  hash_entry) {
 			/* if a helper function has been passed as parameter,
@@ -106,7 +106,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 			hlist_del_rcu(&dat_entry->hash_entry);
 			batadv_dat_entry_free_ref(dat_entry);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 }
 
@@ -243,8 +243,8 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 	to_find.ip = ip;
 	to_find.vid = vid;
 
-	index = batadv_hash_dat(&to_find, hash->size);
-	head = &hash->table[index];
+	index = batadv_hash_dat(&to_find, batadv_hash_size(hash));
+	head = batadv_hash_get(hash, index);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
@@ -481,8 +481,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
 	/* iterate over the originator list and find the node with the closest
 	 * dat_address which has not been selected yet
 	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -767,8 +767,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv4",
 		   "MAC", "VID", "last-seen");
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
diff --git a/network-coding.c b/network-coding.c
index 68b1f9c880cd..cf3783f560a9 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -360,8 +360,8 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 		return;
 
 	/* For each orig_node */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry)
@@ -389,15 +389,13 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	struct hlist_node *node_tmp;
 	struct batadv_nc_path *nc_path;
-	spinlock_t *lock; /* Protects lists in hash */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		/* For each nc_path in this bin */
-		spin_lock_bh(lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(nc_path, node_tmp, head, hash_entry) {
 			/* if an helper function has been passed as parameter,
 			 * ask it if the entry has to be purged or not
@@ -426,7 +424,7 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
 			hlist_del_rcu(&nc_path->hash_entry);
 			batadv_nc_path_free_ref(nc_path);
 		}
-		spin_unlock_bh(lock);
+		batadv_hash_unlock(hash, i);
 	}
 }
 
@@ -513,8 +511,8 @@ batadv_nc_hash_find(struct batadv_hashtable *hash,
 	if (!hash)
 		return NULL;
 
-	index = batadv_nc_hash_choose(data, hash->size);
-	head = &hash->table[index];
+	index = batadv_nc_hash_choose(data, batadv_hash_size(hash));
+	head = batadv_hash_get(hash, index);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(nc_path, head, hash_entry) {
@@ -644,8 +642,8 @@ batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
 		return;
 
 	/* Loop hash table bins */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		/* Loop coding paths */
 		rcu_read_lock();
@@ -1247,11 +1245,12 @@ batadv_nc_path_search(struct batadv_priv *bat_priv,
 	/* Create almost path key */
 	batadv_nc_hash_key_gen(&nc_path_key, in_nc_node->addr,
 			       out_nc_node->addr);
-	idx = batadv_nc_hash_choose(&nc_path_key, hash->size);
+	idx = batadv_nc_hash_choose(&nc_path_key, batadv_hash_size(hash));
 
 	/* Check for coding opportunities in this nc_path */
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, &hash->table[idx], hash_entry) {
+	hlist_for_each_entry_rcu(nc_path, batadv_hash_get(hash, idx),
+				 hash_entry) {
 		if (!batadv_compare_eth(nc_path->prev_hop, in_nc_node->addr))
 			continue;
 
@@ -1726,11 +1725,12 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 	}
 
 	batadv_nc_hash_key_gen(&nc_path_key, source, dest);
-	index = batadv_nc_hash_choose(&nc_path_key, hash->size);
+	index = batadv_nc_hash_choose(&nc_path_key, batadv_hash_size(hash));
 
 	/* Search for matching coding path */
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(nc_path, &hash->table[index], hash_entry) {
+	hlist_for_each_entry_rcu(nc_path, batadv_hash_get(hash, index),
+				 hash_entry) {
 		/* Find matching nc_packet */
 		spin_lock_bh(&nc_path->packet_list_lock);
 		list_for_each_entry(tmp_nc_packet,
@@ -1862,8 +1862,8 @@ int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	/* Traverse list of originators */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		/* For each orig_node in this bin */
 		rcu_read_lock();
diff --git a/originator.c b/originator.c
index 3386ae54ede5..3aee951c5b91 100644
--- a/originator.c
+++ b/originator.c
@@ -608,7 +608,6 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
@@ -619,17 +618,16 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 
 	bat_priv->orig_hash = NULL;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(orig_node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(&orig_node->hash_entry);
 			batadv_orig_node_free_ref(orig_node);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 
 	batadv_hash_destroy(hash);
@@ -960,7 +958,6 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* spinlock to protect write access */
 	struct batadv_orig_node *orig_node;
 	uint32_t i;
 
@@ -968,11 +965,10 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 		return;
 
 	/* for all origins... */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(orig_node, node_tmp,
 					  head, hash_entry) {
 			if (batadv_purge_orig_node(bat_priv, orig_node)) {
@@ -985,7 +981,7 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 			batadv_frag_purge_orig(orig_node,
 					       batadv_frag_check_entry);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 
 	batadv_gw_node_purge(bat_priv);
@@ -1099,8 +1095,8 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
@@ -1136,8 +1132,8 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num
 	 */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/originator.h b/originator.h
index aa4a43696295..5687be7c7378 100644
--- a/originator.h
+++ b/originator.h
@@ -103,8 +103,8 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, hash->size);
-	head = &hash->table[index];
+	index = batadv_choose_orig(data, batadv_hash_size(hash));
+	head = batadv_hash_get(hash, index);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
diff --git a/translation-table.c b/translation-table.c
index 2d0bad466b68..f7a75eaceb89 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -102,8 +102,8 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const uint8_t *addr,
 	ether_addr_copy(to_search.addr, addr);
 	to_search.vid = vid;
 
-	index = batadv_choose_tt(&to_search, hash->size);
-	head = &hash->table[index];
+	index = batadv_choose_tt(&to_search, batadv_hash_size(hash));
+	head = batadv_hash_get(hash, index);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tt, head, hash_entry) {
@@ -928,8 +928,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s  %s %-8s %-9s (%-10s)\n", "Client", "VID",
 		   "Flags", "Last seen", "CRC");
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -1105,23 +1105,20 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		batadv_tt_local_purge_list(bat_priv, head, timeout);
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 }
 
 static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_softif_vlan *vlan;
@@ -1134,11 +1131,10 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 
 	hash = bat_priv->tt.local_hash;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(&tt_common_entry->hash_entry);
@@ -1154,7 +1150,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 
 			batadv_tt_local_entry_free_ref(tt_local);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 
 	batadv_hash_destroy(hash);
@@ -1593,8 +1589,8 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		   "Client", "VID", "(TTVN)", "Originator", "(Curr TTVN)",
 		   "CRC", "Flags");
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -1809,17 +1805,15 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
 	struct hlist_node *safe;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	unsigned short vid;
 
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(tt_common_entry, safe,
 					  head, hash_entry) {
 			/* remove only matching entries */
@@ -1843,7 +1837,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 				batadv_tt_global_entry_free_ref(tt_global);
 			}
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 	orig_node->capa_initialized &= ~BATADV_ORIG_CAPA_HAS_TT;
 }
@@ -1875,17 +1869,15 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
 	struct hlist_head *head;
 	struct hlist_node *node_tmp;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 	char *msg = NULL;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
 			tt_global = container_of(tt_common,
@@ -1905,14 +1897,13 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 			batadv_tt_global_entry_free_ref(tt_global);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 }
 
 static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_node *node_tmp;
@@ -1924,11 +1915,10 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 
 	hash = bat_priv->tt.global_hash;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(&tt_common_entry->hash_entry);
@@ -1937,7 +1927,7 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 						 common);
 			batadv_tt_global_entry_free_ref(tt_global);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 
 	batadv_hash_destroy(hash);
@@ -2059,8 +2049,8 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 	uint8_t flags;
 	__be16 tmp_vid;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
@@ -2134,8 +2124,8 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
 	uint8_t flags;
 	__be16 tmp_vid;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
@@ -2311,8 +2301,8 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_buff;
 
 	rcu_read_lock();
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
@@ -3125,8 +3115,8 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv,
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
@@ -3161,17 +3151,15 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	struct batadv_softif_vlan *vlan;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
 	uint32_t i;
 
 	if (!hash)
 		return;
 
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
+	for (i = 0; i < batadv_hash_size(hash); i++) {
+		head = batadv_hash_get(hash, i);
 
-		spin_lock_bh(list_lock);
+		batadv_hash_lock(hash, i);
 		hlist_for_each_entry_safe(tt_common, node_tmp, head,
 					  hash_entry) {
 			if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
@@ -3195,7 +3183,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 
 			batadv_tt_local_entry_free_ref(tt_local);
 		}
-		spin_unlock_bh(list_lock);
+		batadv_hash_unlock(hash, i);
 	}
 }
 
-- 
2.1.3

