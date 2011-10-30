Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 30 Oct 2011 12:17:33 +0100
Message-Id: <1319973453-24753-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: create a common substructure for
	tt_global/local_entry
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

Several functions in the translation table management code assume that the
tt_global_entry and tt_local_entry structures have the same initial fields such
as 'addr' and 'hash_entry'. To improve the code readability and to avoid
mistakes in later changes, a common substructure that substitute the shared
fields has been introduced (struct tt_common_entry).

Thanks to this modification, it has also been possible to slightly reduce the
code length by merging some functions like compare_ltt/gtt() and
tt_local/global_hash_find()

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.c            |    5 +-
 translation-table.c |  287 ++++++++++++++++++++++++++++-----------------------
 types.h             |   14 ++--
 vis.c               |    6 +-
 4 files changed, 171 insertions(+), 141 deletions(-)

diff --git a/compat.c b/compat.c
index 1793904..855360e 100644
--- a/compat.c
+++ b/compat.c
@@ -30,9 +30,12 @@ void free_rcu_softif_neigh(struct rcu_head *rcu)
 
 void free_rcu_tt_local_entry(struct rcu_head *rcu)
 {
+	struct tt_common_entry *tt_common_entry;
 	struct tt_local_entry *tt_local_entry;
 
-	tt_local_entry = container_of(rcu, struct tt_local_entry, rcu);
+	tt_common_entry = container_of(rcu, struct tt_common_entry, rcu);
+	tt_local_entry = container_of(tt_common_entry, struct tt_local_entry,
+				      common);
 	kfree(tt_local_entry);
 }
 
diff --git a/translation-table.c b/translation-table.c
index 78b9528..76134bc 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -36,18 +36,9 @@ static void _tt_global_del(struct bat_priv *bat_priv,
 static void tt_purge(struct work_struct *work);
 
 /* returns 1 if they are the same mac addr */
-static int compare_ltt(const struct hlist_node *node, const void *data2)
+static int compare_tt(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct tt_local_entry,
-					 hash_entry);
-
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
-}
-
-/* returns 1 if they are the same mac addr */
-static int compare_gtt(const struct hlist_node *node, const void *data2)
-{
-	const void *data1 = container_of(node, struct tt_global_entry,
+	const void *data1 = container_of(node, struct tt_common_entry,
 					 hash_entry);
 
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
@@ -60,13 +51,12 @@ static void tt_start_timer(struct bat_priv *bat_priv)
 			   msecs_to_jiffies(5000));
 }
 
-static struct tt_local_entry *tt_local_hash_find(struct bat_priv *bat_priv,
-						 const void *data)
+static struct tt_common_entry *tt_hash_find(struct hashtable_t *hash,
+					    const void *data)
 {
-	struct hashtable_t *hash = bat_priv->tt_local_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct tt_local_entry *tt_local_entry, *tt_local_entry_tmp = NULL;
+	struct tt_common_entry *tt_common_entry, *tt_common_entry_tmp = NULL;
 	uint32_t index;
 
 	if (!hash)
@@ -76,51 +66,46 @@ static struct tt_local_entry *tt_local_hash_find(struct bat_priv *bat_priv,
 	head = &hash->table[index];
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(tt_local_entry, node, head, hash_entry) {
-		if (!compare_eth(tt_local_entry, data))
+	hlist_for_each_entry_rcu(tt_common_entry, node, head, hash_entry) {
+		if (!compare_eth(tt_common_entry, data))
 			continue;
 
-		if (!atomic_inc_not_zero(&tt_local_entry->refcount))
+		if (!atomic_inc_not_zero(&tt_common_entry->refcount))
 			continue;
 
-		tt_local_entry_tmp = tt_local_entry;
+		tt_common_entry_tmp = tt_common_entry;
 		break;
 	}
 	rcu_read_unlock();
 
-	return tt_local_entry_tmp;
+	return tt_common_entry_tmp;
 }
 
-static struct tt_global_entry *tt_global_hash_find(struct bat_priv *bat_priv,
-						   const void *data)
+static struct tt_local_entry *tt_local_hash_find(struct bat_priv *bat_priv,
+						 const void *data)
 {
-	struct hashtable_t *hash = bat_priv->tt_global_hash;
-	struct hlist_head *head;
-	struct hlist_node *node;
-	struct tt_global_entry *tt_global_entry;
-	struct tt_global_entry *tt_global_entry_tmp = NULL;
-	uint32_t index;
-
-	if (!hash)
-		return NULL;
-
-	index = choose_orig(data, hash->size);
-	head = &hash->table[index];
+	struct tt_common_entry *tt_common_entry;
+	struct tt_local_entry *tt_local_entry = NULL;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(tt_global_entry, node, head, hash_entry) {
-		if (!compare_eth(tt_global_entry, data))
-			continue;
+	tt_common_entry = tt_hash_find(bat_priv->tt_local_hash, data);
+	if (tt_common_entry)
+		tt_local_entry = container_of(tt_common_entry,
+					      struct tt_local_entry, common);
+	return tt_local_entry;
+}
 
-		if (!atomic_inc_not_zero(&tt_global_entry->refcount))
-			continue;
+static struct tt_global_entry *tt_global_hash_find(struct bat_priv *bat_priv,
+						   const void *data)
+{
+	struct tt_common_entry *tt_common_entry;
+	struct tt_global_entry *tt_global_entry = NULL;
 
-		tt_global_entry_tmp = tt_global_entry;
-		break;
-	}
-	rcu_read_unlock();
+	tt_common_entry = tt_hash_find(bat_priv->tt_global_hash, data);
+	if (tt_common_entry)
+		tt_global_entry = container_of(tt_common_entry,
+					       struct tt_global_entry, common);
+	return tt_global_entry;
 
-	return tt_global_entry_tmp;
 }
 
 static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
@@ -133,15 +118,18 @@ static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
 
 static void tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
 {
-	if (atomic_dec_and_test(&tt_local_entry->refcount))
-		kfree_rcu(tt_local_entry, rcu);
+	if (atomic_dec_and_test(&tt_local_entry->common.refcount))
+		kfree_rcu(tt_local_entry, common.rcu);
 }
 
 static void tt_global_entry_free_rcu(struct rcu_head *rcu)
 {
+	struct tt_common_entry *tt_common_entry;
 	struct tt_global_entry *tt_global_entry;
 
-	tt_global_entry = container_of(rcu, struct tt_global_entry, rcu);
+	tt_common_entry = container_of(rcu, struct tt_common_entry, rcu);
+	tt_global_entry = container_of(tt_common_entry, struct tt_global_entry,
+				       common);
 
 	if (tt_global_entry->orig_node)
 		orig_node_free_ref(tt_global_entry->orig_node);
@@ -151,8 +139,9 @@ static void tt_global_entry_free_rcu(struct rcu_head *rcu)
 
 static void tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
 {
-	if (atomic_dec_and_test(&tt_global_entry->refcount))
-		call_rcu(&tt_global_entry->rcu, tt_global_entry_free_rcu);
+	if (atomic_dec_and_test(&tt_global_entry->common.refcount))
+		call_rcu(&tt_global_entry->common.rcu,
+			 tt_global_entry_free_rcu);
 }
 
 static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
@@ -217,26 +206,26 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		"Creating new local tt entry: %pM (ttvn: %d)\n", addr,
 		(uint8_t)atomic_read(&bat_priv->ttvn));
 
-	memcpy(tt_local_entry->addr, addr, ETH_ALEN);
-	tt_local_entry->last_seen = jiffies;
-	tt_local_entry->flags = NO_FLAGS;
+	memcpy(tt_local_entry->common.addr, addr, ETH_ALEN);
+	tt_local_entry->common.flags = NO_FLAGS;
 	if (is_wifi_iface(ifindex))
-		tt_local_entry->flags |= TT_CLIENT_WIFI;
-	atomic_set(&tt_local_entry->refcount, 2);
+		tt_local_entry->common.flags |= TT_CLIENT_WIFI;
+	atomic_set(&tt_local_entry->common.refcount, 2);
+	tt_local_entry->last_seen = jiffies;
 
 	/* the batman interface mac address should never be purged */
 	if (compare_eth(addr, soft_iface->dev_addr))
-		tt_local_entry->flags |= TT_CLIENT_NOPURGE;
+		tt_local_entry->common.flags |= TT_CLIENT_NOPURGE;
 
-	tt_local_event(bat_priv, addr, tt_local_entry->flags);
+	tt_local_event(bat_priv, addr, tt_local_entry->common.flags);
 
 	/* The local entry has to be marked as NEW to avoid to send it in
 	 * a full table response going out before the next ttvn increment
 	 * (consistency check) */
-	tt_local_entry->flags |= TT_CLIENT_NEW;
+	tt_local_entry->common.flags |= TT_CLIENT_NEW;
 
-	hash_add(bat_priv->tt_local_hash, compare_ltt, choose_orig,
-		 tt_local_entry, &tt_local_entry->hash_entry);
+	hash_add(bat_priv->tt_local_hash, compare_tt, choose_orig,
+		 &tt_local_entry->common, &tt_local_entry->common.hash_entry);
 
 	/* remove address from global hash if present */
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
@@ -247,8 +236,8 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_global_entry->orig_node->tt_poss_change = true;
 		/* The global entry has to be marked as PENDING and has to be
 		 * kept for consistency purpose */
-		tt_global_entry->flags |= TT_CLIENT_PENDING;
-		send_roam_adv(bat_priv, tt_global_entry->addr,
+		tt_global_entry->common.flags |= TT_CLIENT_PENDING;
+		send_roam_adv(bat_priv, tt_global_entry->common.addr,
 			      tt_global_entry->orig_node);
 	}
 out:
@@ -310,7 +299,7 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
-	struct tt_local_entry *tt_local_entry;
+	struct tt_common_entry *tt_common_entry;
 	struct hard_iface *primary_if;
 	struct hlist_node *node;
 	struct hlist_head *head;
@@ -340,19 +329,19 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		head = &hash->table[i];
 
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_local_entry, node,
+		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
 			seq_printf(seq, " * %pM [%c%c%c%c%c]\n",
-					tt_local_entry->addr,
-					(tt_local_entry->flags &
+					tt_common_entry->addr,
+					(tt_common_entry->flags &
 					 TT_CLIENT_ROAM ? 'R' : '.'),
-					(tt_local_entry->flags &
+					(tt_common_entry->flags &
 					 TT_CLIENT_NOPURGE ? 'P' : '.'),
-					(tt_local_entry->flags &
+					(tt_common_entry->flags &
 					 TT_CLIENT_NEW ? 'N' : '.'),
-					(tt_local_entry->flags &
+					(tt_common_entry->flags &
 					 TT_CLIENT_PENDING ? 'X' : '.'),
-					(tt_local_entry->flags &
+					(tt_common_entry->flags &
 					 TT_CLIENT_WIFI ? 'W' : '.'));
 		}
 		rcu_read_unlock();
@@ -367,13 +356,13 @@ static void tt_local_set_pending(struct bat_priv *bat_priv,
 				 struct tt_local_entry *tt_local_entry,
 				 uint16_t flags)
 {
-	tt_local_event(bat_priv, tt_local_entry->addr,
-		       tt_local_entry->flags | flags);
+	tt_local_event(bat_priv, tt_local_entry->common.addr,
+		       tt_local_entry->common.flags | flags);
 
 	/* The local client has to be marked as "pending to be removed" but has
 	 * to be kept in the table in order to send it in a full table
 	 * response issued before the net ttvn increment (consistency check) */
-	tt_local_entry->flags |= TT_CLIENT_PENDING;
+	tt_local_entry->common.flags |= TT_CLIENT_PENDING;
 }
 
 void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
@@ -389,7 +378,7 @@ void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 			     (roaming ? TT_CLIENT_ROAM : NO_FLAGS));
 
 	bat_dbg(DBG_TT, bat_priv, "Local tt entry (%pM) pending to be removed: "
-		"%s\n", tt_local_entry->addr, message);
+		"%s\n", tt_local_entry->common.addr, message);
 out:
 	if (tt_local_entry)
 		tt_local_entry_free_ref(tt_local_entry);
@@ -399,6 +388,7 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
 	struct tt_local_entry *tt_local_entry;
+	struct tt_common_entry *tt_common_entry;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
@@ -409,13 +399,16 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
+		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
 					  head, hash_entry) {
-			if (tt_local_entry->flags & TT_CLIENT_NOPURGE)
+			tt_local_entry = container_of(tt_common_entry,
+						      struct tt_local_entry,
+						      common);
+			if (tt_local_entry->common.flags & TT_CLIENT_NOPURGE)
 				continue;
 
 			/* entry already marked for deletion */
-			if (tt_local_entry->flags & TT_CLIENT_PENDING)
+			if (tt_local_entry->common.flags & TT_CLIENT_PENDING)
 				continue;
 
 			if (!is_out_of_time(tt_local_entry->last_seen,
@@ -426,7 +419,7 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 					     TT_CLIENT_DEL);
 			bat_dbg(DBG_TT, bat_priv, "Local tt entry (%pM) "
 				"pending to be removed: timed out\n",
-				tt_local_entry->addr);
+				tt_local_entry->common.addr);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -437,6 +430,7 @@ static void tt_local_table_free(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
+	struct tt_common_entry *tt_common_entry;
 	struct tt_local_entry *tt_local_entry;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
@@ -452,9 +446,12 @@ static void tt_local_table_free(struct bat_priv *bat_priv)
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
+		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(node);
+			tt_local_entry = container_of(tt_common_entry,
+						      struct tt_local_entry,
+						      common);
 			tt_local_entry_free_ref(tt_local_entry);
 		}
 		spin_unlock_bh(list_lock);
@@ -512,18 +509,18 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		if (!tt_global_entry)
 			goto out;
 
-		memcpy(tt_global_entry->addr, tt_addr, ETH_ALEN);
+		memcpy(tt_global_entry->common.addr, tt_addr, ETH_ALEN);
+		tt_global_entry->common.flags = NO_FLAGS;
+		atomic_set(&tt_global_entry->common.refcount, 2);
 		/* Assign the new orig_node */
 		atomic_inc(&orig_node->refcount);
 		tt_global_entry->orig_node = orig_node;
 		tt_global_entry->ttvn = ttvn;
-		tt_global_entry->flags = NO_FLAGS;
 		tt_global_entry->roam_at = 0;
-		atomic_set(&tt_global_entry->refcount, 2);
 
-		hash_add(bat_priv->tt_global_hash, compare_gtt,
-			 choose_orig, tt_global_entry,
-			 &tt_global_entry->hash_entry);
+		hash_add(bat_priv->tt_global_hash, compare_tt,
+			 choose_orig, &tt_global_entry->common,
+			 &tt_global_entry->common.hash_entry);
 		atomic_inc(&orig_node->tt_size);
 	} else {
 		if (tt_global_entry->orig_node != orig_node) {
@@ -534,20 +531,20 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 			orig_node_free_ref(orig_node_tmp);
 			atomic_inc(&orig_node->tt_size);
 		}
+		tt_global_entry->common.flags = NO_FLAGS;
 		tt_global_entry->ttvn = ttvn;
-		tt_global_entry->flags = NO_FLAGS;
 		tt_global_entry->roam_at = 0;
 	}
 
 	if (wifi)
-		tt_global_entry->flags |= TT_CLIENT_WIFI;
+		tt_global_entry->common.flags |= TT_CLIENT_WIFI;
 
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new global tt entry: %pM (via %pM)\n",
-		tt_global_entry->addr, orig_node->orig);
+		tt_global_entry->common.addr, orig_node->orig);
 
 	/* remove address from local hash if present */
-	tt_local_remove(bat_priv, tt_global_entry->addr,
+	tt_local_remove(bat_priv, tt_global_entry->common.addr,
 			"global tt received", roaming);
 	ret = 1;
 out:
@@ -561,6 +558,7 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct tt_common_entry *tt_common_entry;
 	struct tt_global_entry *tt_global_entry;
 	struct hard_iface *primary_if;
 	struct hlist_node *node;
@@ -593,20 +591,24 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		head = &hash->table[i];
 
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_global_entry, node,
+		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
+			tt_global_entry = container_of(tt_common_entry,
+						       struct tt_global_entry,
+						       common);
 			seq_printf(seq, " * %pM  (%3u) via %pM     (%3u)   "
-					"[%c%c%c]\n", tt_global_entry->addr,
+					"[%c%c%c]\n",
+					tt_global_entry->common.addr,
 					tt_global_entry->ttvn,
 					tt_global_entry->orig_node->orig,
 					(uint8_t) atomic_read(
 						&tt_global_entry->orig_node->
 						last_ttvn),
-					(tt_global_entry->flags &
+					(tt_global_entry->common.flags &
 					 TT_CLIENT_ROAM ? 'R' : '.'),
-					(tt_global_entry->flags &
+					(tt_global_entry->common.flags &
 					 TT_CLIENT_PENDING ? 'X' : '.'),
-					(tt_global_entry->flags &
+					(tt_global_entry->common.flags &
 					 TT_CLIENT_WIFI ? 'W' : '.'));
 		}
 		rcu_read_unlock();
@@ -626,13 +628,13 @@ static void _tt_global_del(struct bat_priv *bat_priv,
 
 	bat_dbg(DBG_TT, bat_priv,
 		"Deleting global tt entry %pM (via %pM): %s\n",
-		tt_global_entry->addr, tt_global_entry->orig_node->orig,
+		tt_global_entry->common.addr, tt_global_entry->orig_node->orig,
 		message);
 
 	atomic_dec(&tt_global_entry->orig_node->tt_size);
 
-	hash_remove(bat_priv->tt_global_hash, compare_gtt, choose_orig,
-		    tt_global_entry->addr);
+	hash_remove(bat_priv->tt_global_hash, compare_tt, choose_orig,
+		    tt_global_entry->common.addr);
 out:
 	if (tt_global_entry)
 		tt_global_entry_free_ref(tt_global_entry);
@@ -650,7 +652,7 @@ void tt_global_del(struct bat_priv *bat_priv,
 
 	if (tt_global_entry->orig_node == orig_node) {
 		if (roaming) {
-			tt_global_entry->flags |= TT_CLIENT_ROAM;
+			tt_global_entry->common.flags |= TT_CLIENT_ROAM;
 			tt_global_entry->roam_at = jiffies;
 			goto out;
 		}
@@ -665,6 +667,7 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node, const char *message)
 {
 	struct tt_global_entry *tt_global_entry;
+	struct tt_common_entry *tt_common_entry;
 	uint32_t i;
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
 	struct hlist_node *node, *safe;
@@ -679,13 +682,16 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(tt_global_entry, node, safe,
+		hlist_for_each_entry_safe(tt_common_entry, node, safe,
 					 head, hash_entry) {
+			tt_global_entry = container_of(tt_common_entry,
+						       struct tt_global_entry,
+						       common);
 			if (tt_global_entry->orig_node == orig_node) {
 				bat_dbg(DBG_TT, bat_priv,
 					"Deleting global tt entry %pM "
 					"(via %pM): %s\n",
-					tt_global_entry->addr,
+					tt_global_entry->common.addr,
 					tt_global_entry->orig_node->orig,
 					message);
 				hlist_del_rcu(node);
@@ -700,6 +706,7 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 static void tt_global_roam_purge(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct tt_common_entry *tt_common_entry;
 	struct tt_global_entry *tt_global_entry;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
@@ -711,9 +718,12 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(tt_global_entry, node, node_tmp,
+		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
 					  head, hash_entry) {
-			if (!(tt_global_entry->flags & TT_CLIENT_ROAM))
+			tt_global_entry = container_of(tt_common_entry,
+						       struct tt_global_entry,
+						       common);
+			if (!(tt_global_entry->common.flags & TT_CLIENT_ROAM))
 				continue;
 			if (!is_out_of_time(tt_global_entry->roam_at,
 					    TT_CLIENT_ROAM_TIMEOUT * 1000))
@@ -721,7 +731,7 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 
 			bat_dbg(DBG_TT, bat_priv, "Deleting global "
 				"tt entry (%pM): Roaming timeout\n",
-				tt_global_entry->addr);
+				tt_global_entry->common.addr);
 			atomic_dec(&tt_global_entry->orig_node->tt_size);
 			hlist_del_rcu(node);
 			tt_global_entry_free_ref(tt_global_entry);
@@ -735,6 +745,7 @@ static void tt_global_table_free(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
+	struct tt_common_entry *tt_common_entry;
 	struct tt_global_entry *tt_global_entry;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
@@ -750,9 +761,12 @@ static void tt_global_table_free(struct bat_priv *bat_priv)
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(tt_global_entry, node, node_tmp,
+		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(node);
+			tt_global_entry = container_of(tt_common_entry,
+						       struct tt_global_entry,
+						       common);
 			tt_global_entry_free_ref(tt_global_entry);
 		}
 		spin_unlock_bh(list_lock);
@@ -768,8 +782,8 @@ static bool _is_ap_isolated(struct tt_local_entry *tt_local_entry,
 {
 	bool ret = false;
 
-	if (tt_local_entry->flags & TT_CLIENT_WIFI &&
-	    tt_global_entry->flags & TT_CLIENT_WIFI)
+	if (tt_local_entry->common.flags & TT_CLIENT_WIFI &&
+	    tt_global_entry->common.flags & TT_CLIENT_WIFI)
 		ret = true;
 
 	return ret;
@@ -802,7 +816,7 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 
 	/* A global client marked as PENDING has already moved from that
 	 * originator */
-	if (tt_global_entry->flags & TT_CLIENT_PENDING)
+	if (tt_global_entry->common.flags & TT_CLIENT_PENDING)
 		goto out;
 
 	orig_node = tt_global_entry->orig_node;
@@ -821,6 +835,7 @@ uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
 	uint16_t total = 0, total_one;
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
+	struct tt_common_entry *tt_common_entry;
 	struct tt_global_entry *tt_global_entry;
 	struct hlist_node *node;
 	struct hlist_head *head;
@@ -831,20 +846,23 @@ uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node)
 		head = &hash->table[i];
 
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_global_entry, node,
+		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
+			tt_global_entry = container_of(tt_common_entry,
+						       struct tt_global_entry,
+						       common);
 			if (compare_eth(tt_global_entry->orig_node,
 					orig_node)) {
 				/* Roaming clients are in the global table for
 				 * consistency only. They don't have to be
 				 * taken into account while computing the
 				 * global crc */
-				if (tt_global_entry->flags & TT_CLIENT_ROAM)
+				if (tt_common_entry->flags & TT_CLIENT_ROAM)
 					continue;
 				total_one = 0;
 				for (j = 0; j < ETH_ALEN; j++)
 					total_one = crc16_byte(total_one,
-						tt_global_entry->addr[j]);
+						tt_common_entry->addr[j]);
 				total ^= total_one;
 			}
 		}
@@ -859,7 +877,7 @@ uint16_t tt_local_crc(struct bat_priv *bat_priv)
 {
 	uint16_t total = 0, total_one;
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
-	struct tt_local_entry *tt_local_entry;
+	struct tt_common_entry *tt_common_entry;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	uint32_t i;
@@ -869,16 +887,16 @@ uint16_t tt_local_crc(struct bat_priv *bat_priv)
 		head = &hash->table[i];
 
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_local_entry, node,
+		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
 			/* not yet committed clients have not to be taken into
 			 * account while computing the CRC */
-			if (tt_local_entry->flags & TT_CLIENT_NEW)
+			if (tt_common_entry->flags & TT_CLIENT_NEW)
 				continue;
 			total_one = 0;
 			for (j = 0; j < ETH_ALEN; j++)
 				total_one = crc16_byte(total_one,
-						   tt_local_entry->addr[j]);
+						   tt_common_entry->addr[j]);
 			total ^= total_one;
 		}
 		rcu_read_unlock();
@@ -967,21 +985,25 @@ unlock:
 /* data_ptr is useless here, but has to be kept to respect the prototype */
 static int tt_local_valid_entry(const void *entry_ptr, const void *data_ptr)
 {
-	const struct tt_local_entry *tt_local_entry = entry_ptr;
+	const struct tt_common_entry *tt_common_entry = entry_ptr;
 
-	if (tt_local_entry->flags & TT_CLIENT_NEW)
+	if (tt_common_entry->flags & TT_CLIENT_NEW)
 		return 0;
 	return 1;
 }
 
 static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
 {
-	const struct tt_global_entry *tt_global_entry = entry_ptr;
+	const struct tt_common_entry *tt_common_entry = entry_ptr;
+	const struct tt_global_entry *tt_global_entry;
 	const struct orig_node *orig_node = data_ptr;
 
-	if (tt_global_entry->flags & TT_CLIENT_ROAM)
+	if (tt_common_entry->flags & TT_CLIENT_ROAM)
 		return 0;
 
+	tt_global_entry = container_of(tt_common_entry, struct tt_global_entry,
+				       common);
+
 	return (tt_global_entry->orig_node == orig_node);
 }
 
@@ -992,7 +1014,7 @@ static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 							      const void *),
 					      void *cb_data)
 {
-	struct tt_local_entry *tt_local_entry;
+	struct tt_common_entry *tt_common_entry;
 	struct tt_query_packet *tt_response;
 	struct tt_change *tt_change;
 	struct hlist_node *node;
@@ -1024,15 +1046,16 @@ static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
-		hlist_for_each_entry_rcu(tt_local_entry, node,
+		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
 			if (tt_count == tt_tot)
 				break;
 
-			if ((valid_cb) && (!valid_cb(tt_local_entry, cb_data)))
+			if ((valid_cb) && (!valid_cb(tt_common_entry, cb_data)))
 				continue;
 
-			memcpy(tt_change->addr, tt_local_entry->addr, ETH_ALEN);
+			memcpy(tt_change->addr, tt_common_entry->addr,
+			       ETH_ALEN);
 			tt_change->flags = NO_FLAGS;
 
 			tt_count++;
@@ -1449,7 +1472,7 @@ bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
 		goto out;
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose) */
-	if (tt_local_entry->flags & TT_CLIENT_PENDING)
+	if (tt_local_entry->common.flags & TT_CLIENT_PENDING)
 		goto out;
 	ret = true;
 out:
@@ -1681,7 +1704,7 @@ static void tt_local_reset_flags(struct bat_priv *bat_priv, uint16_t flags)
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct tt_local_entry *tt_local_entry;
+	struct tt_common_entry *tt_common_entry;
 
 	if (!hash)
 		return;
@@ -1690,11 +1713,11 @@ static void tt_local_reset_flags(struct bat_priv *bat_priv, uint16_t flags)
 		head = &hash->table[i];
 
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_local_entry, node,
+		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
-			if (!(tt_local_entry->flags & flags))
+			if (!(tt_common_entry->flags & flags))
 				continue;
-			tt_local_entry->flags &= ~flags;
+			tt_common_entry->flags &= ~flags;
 			atomic_inc(&bat_priv->num_local_tt);
 		}
 		rcu_read_unlock();
@@ -1706,6 +1729,7 @@ static void tt_local_reset_flags(struct bat_priv *bat_priv, uint16_t flags)
 static void tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
+	struct tt_common_entry *tt_common_entry;
 	struct tt_local_entry *tt_local_entry;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
@@ -1720,16 +1744,19 @@ static void tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
+		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
 					  head, hash_entry) {
-			if (!(tt_local_entry->flags & TT_CLIENT_PENDING))
+			if (!(tt_common_entry->flags & TT_CLIENT_PENDING))
 				continue;
 
 			bat_dbg(DBG_TT, bat_priv, "Deleting local tt entry "
-				"(%pM): pending\n", tt_local_entry->addr);
+				"(%pM): pending\n", tt_common_entry->addr);
 
 			atomic_dec(&bat_priv->num_local_tt);
 			hlist_del_rcu(node);
+			tt_local_entry = container_of(tt_common_entry,
+						      struct tt_local_entry,
+						      common);
 			tt_local_entry_free_ref(tt_local_entry);
 		}
 		spin_unlock_bh(list_lock);
diff --git a/types.h b/types.h
index ab8d0fe..e9eb043 100644
--- a/types.h
+++ b/types.h
@@ -222,24 +222,24 @@ struct socket_packet {
 	struct icmp_packet_rr icmp_packet;
 };
 
-struct tt_local_entry {
+struct tt_common_entry {
 	uint8_t addr[ETH_ALEN];
 	struct hlist_node hash_entry;
-	unsigned long last_seen;
 	uint16_t flags;
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
 
+struct tt_local_entry {
+	struct tt_common_entry common;
+	unsigned long last_seen;
+};
+
 struct tt_global_entry {
-	uint8_t addr[ETH_ALEN];
-	struct hlist_node hash_entry; /* entry in the global table */
+	struct tt_common_entry common;
 	struct orig_node *orig_node;
 	uint8_t ttvn;
-	uint16_t flags; /* only TT_GLOBAL_ROAM is used */
 	unsigned long roam_at; /* time at which TT_GLOBAL_ROAM was set */
-	atomic_t refcount;
-	struct rcu_head rcu;
 };
 
 struct tt_change_node {
diff --git a/vis.c b/vis.c
index 7445413..cc3b9f2 100644
--- a/vis.c
+++ b/vis.c
@@ -609,7 +609,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	struct vis_info *info = bat_priv->my_vis_info;
 	struct vis_packet *packet = (struct vis_packet *)info->skb_packet->data;
 	struct vis_info_entry *entry;
-	struct tt_local_entry *tt_local_entry;
+	struct tt_common_entry *tt_common_entry;
 	int best_tq = -1;
 	uint32_t i;
 
@@ -672,13 +672,13 @@ next:
 		head = &hash->table[i];
 
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_local_entry, node, head,
+		hlist_for_each_entry_rcu(tt_common_entry, node, head,
 					 hash_entry) {
 			entry = (struct vis_info_entry *)
 					skb_put(info->skb_packet,
 						sizeof(*entry));
 			memset(entry->src, 0, ETH_ALEN);
-			memcpy(entry->dest, tt_local_entry->addr, ETH_ALEN);
+			memcpy(entry->dest, tt_common_entry->addr, ETH_ALEN);
 			entry->quality = 0; /* 0 means TT */
 			packet->entries++;
 
-- 
1.7.3.4

