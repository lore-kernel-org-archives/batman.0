Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  9 May 2011 11:49:11 +0200
Message-Id: <1304934551-3862-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1303940106-1457-1-git-send-email-ordex@autistici.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: protect the local and the
	global trans-tables with rcu
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

The local and the global translation-tables are now lock free and rcu
protected.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c              |    2 -
 routing.c           |    2 -
 translation-table.c |  256 +++++++++++++++++++++++++++++----------------------
 types.h             |    6 +-
 vis.c               |   13 +--
 5 files changed, 155 insertions(+), 124 deletions(-)

diff --git a/main.c b/main.c
index 6e96fd6..5f3cab1 100644
--- a/main.c
+++ b/main.c
@@ -84,8 +84,6 @@ int mesh_init(struct net_device *soft_iface)
 
 	spin_lock_init(&bat_priv->forw_bat_list_lock);
 	spin_lock_init(&bat_priv->forw_bcast_list_lock);
-	spin_lock_init(&bat_priv->tt_lhash_lock);
-	spin_lock_init(&bat_priv->tt_ghash_lock);
 	spin_lock_init(&bat_priv->tt_changes_list_lock);
 	spin_lock_init(&bat_priv->tt_req_list_lock);
 	spin_lock_init(&bat_priv->tt_roam_list_lock);
diff --git a/routing.c b/routing.c
index 00b0dee..b681568 100644
--- a/routing.c
+++ b/routing.c
@@ -89,9 +89,7 @@ static void update_transtable(struct bat_priv *bat_priv,
 		/* Even if we received the crc into the OGM, we prefer
 		 * to recompute it to spot any possible inconsistency
 		 * in the global table */
-		spin_lock_bh(&bat_priv->tt_ghash_lock);
 		orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
-		spin_unlock_bh(&bat_priv->tt_ghash_lock);
 		/* Roaming phase is over: tables are in sync again. I can
 		 * unset the flag */
 		orig_node->tt_poss_change = false;
diff --git a/translation-table.c b/translation-table.c
index d14072f..be4f851 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -78,6 +78,9 @@ static struct tt_local_entry *tt_local_hash_find(struct bat_priv *bat_priv,
 		if (!compare_eth(tt_local_entry, data))
 			continue;
 
+		if (!atomic_inc_not_zero(&tt_local_entry->refcount))
+			continue;
+
 		tt_local_entry_tmp = tt_local_entry;
 		break;
 	}
@@ -107,6 +110,9 @@ static struct tt_global_entry *tt_global_hash_find(struct bat_priv *bat_priv,
 		if (!compare_eth(tt_global_entry, data))
 			continue;
 
+		if (!atomic_inc_not_zero(&tt_global_entry->refcount))
+			continue;
+
 		tt_global_entry_tmp = tt_global_entry;
 		break;
 	}
@@ -123,8 +129,36 @@ static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
 	return time_after(jiffies, deadline);
 }
 
+static void tt_local_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct tt_local_entry *tt_local_entry;
+
+	tt_local_entry = container_of(rcu, struct tt_local_entry, rcu);
+	kfree(tt_local_entry);
+}
+
+static void tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
+{
+	if (atomic_dec_and_test(&tt_local_entry->refcount))
+		call_rcu(&tt_local_entry->rcu, tt_local_entry_free_rcu);
+}
+
+static void tt_global_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct tt_global_entry *tt_global_entry;
+
+	tt_global_entry = container_of(rcu, struct tt_global_entry, rcu);
+	kfree(tt_global_entry);
+}
+
+static void tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
+{
+	if (atomic_dec_and_test(&tt_global_entry->refcount))
+		call_rcu(&tt_global_entry->rcu, tt_global_entry_free_rcu);
+}
+
 static void tt_local_event(struct bat_priv *bat_priv, uint8_t op, uint8_t *addr,
-			   uint8_t roaming)
+			   bool roaming)
 {
 	struct tt_change_node *tt_change_node;
 
@@ -170,22 +204,19 @@ static int tt_local_init(struct bat_priv *bat_priv)
 void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
-	struct tt_local_entry *tt_local_entry;
-	struct tt_global_entry *tt_global_entry;
-	uint8_t roam_addr[ETH_ALEN];
-	struct orig_node *roam_orig_node;
+	struct tt_local_entry *tt_local_entry = NULL;
+	struct tt_global_entry *tt_global_entry = NULL;
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 
 	if (tt_local_entry) {
 		tt_local_entry->last_seen = jiffies;
-		goto unlock;
+		goto out;
 	}
 
 	tt_local_entry = kmalloc(sizeof(struct tt_local_entry), GFP_ATOMIC);
 	if (!tt_local_entry)
-		goto unlock;
+		goto out;
 
 	tt_local_event(bat_priv, TT_CHANGE_ADD, addr, false);
 
@@ -195,6 +226,7 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 
 	memcpy(tt_local_entry->addr, addr, ETH_ALEN);
 	tt_local_entry->last_seen = jiffies;
+	atomic_set(&tt_local_entry->refcount, 2);
 
 	/* the batman interface mac address should never be purged */
 	if (compare_eth(addr, soft_iface->dev_addr))
@@ -204,31 +236,26 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 
 	hash_add(bat_priv->tt_local_hash, compare_ltt, choose_orig,
 		 tt_local_entry, &tt_local_entry->hash_entry);
+
 	atomic_inc(&bat_priv->num_local_tt);
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 
 	/* remove address from global hash if present */
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
-
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
 
 	/* Check whether it is a roaming! */
 	if (tt_global_entry) {
-		memcpy(roam_addr, tt_global_entry->addr, ETH_ALEN);
-		roam_orig_node = tt_global_entry->orig_node;
 		/* This node is probably going to update its tt table */
 		tt_global_entry->orig_node->tt_poss_change = true;
 		_tt_global_del(bat_priv, tt_global_entry,
 			       "local tt received");
-		spin_unlock_bh(&bat_priv->tt_ghash_lock);
 		send_roam_adv(bat_priv, tt_global_entry->addr,
-			tt_global_entry->orig_node);
-	} else
-		spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
-	return;
-unlock:
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
+			      tt_global_entry->orig_node);
+	}
+out:
+	if (tt_local_entry)
+		tt_local_entry_free_ref(tt_local_entry);
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
 }
 
 int tt_changes_fill_buffer(struct bat_priv *bat_priv,
@@ -310,8 +337,6 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		   "announced via TT (TTVN: %u):\n",
 		   net_dev->name, (uint8_t)atomic_read(&bat_priv->ttvn));
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
-
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx\n" */
 	for (i = 0; i < hash->size; i++) {
@@ -325,7 +350,6 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_bh(&bat_priv->tt_lhash_lock);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -345,8 +369,6 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_unlock();
 	}
 
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
-
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
 out:
@@ -355,15 +377,6 @@ out:
 	return ret;
 }
 
-static void tt_local_entry_free(struct hlist_node *node, void *arg)
-{
-	struct bat_priv *bat_priv = (struct bat_priv *)arg;
-	void *data = container_of(node, struct tt_local_entry, hash_entry);
-
-	kfree(data);
-	atomic_dec(&bat_priv->num_local_tt);
-}
-
 static void tt_local_del(struct bat_priv *bat_priv,
 			 struct tt_local_entry *tt_local_entry,
 			 char *message)
@@ -376,23 +389,24 @@ static void tt_local_del(struct bat_priv *bat_priv,
 	hash_remove(bat_priv->tt_local_hash, compare_ltt, choose_orig,
 		    tt_local_entry->addr);
 
-	tt_local_entry_free(&tt_local_entry->hash_entry, bat_priv);
+	tt_local_entry_free_ref(tt_local_entry);
 }
 
 void tt_local_remove(struct bat_priv *bat_priv, uint8_t *addr,
 		     char *message, bool roaming)
 {
-	struct tt_local_entry *tt_local_entry;
+	struct tt_local_entry *tt_local_entry = NULL;
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 
-	if (tt_local_entry) {
-		tt_local_event(bat_priv, TT_CHANGE_DEL, tt_local_entry->addr,
-			       roaming);
-		tt_local_del(bat_priv, tt_local_entry, message);
-	}
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
+	if (!tt_local_entry)
+		goto out;
+
+	tt_local_event(bat_priv, TT_CHANGE_DEL, tt_local_entry->addr, roaming);
+	tt_local_del(bat_priv, tt_local_entry, message);
+out:
+	if (tt_local_entry)
+		tt_local_entry_free_ref(tt_local_entry);
 }
 
 static void tt_local_purge(struct bat_priv *bat_priv)
@@ -401,13 +415,14 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 	struct tt_local_entry *tt_local_entry;
 	struct hlist_node *node, *node_tmp;
 	struct hlist_head *head;
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	int i;
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
-
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
 
+		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
 					  head, hash_entry) {
 			if (tt_local_entry->never_purge)
@@ -419,22 +434,26 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 
 			tt_local_event(bat_priv, TT_CHANGE_DEL,
 				       tt_local_entry->addr, false);
-			tt_local_del(bat_priv, tt_local_entry,
-				     "address timed out");
+			atomic_dec(&bat_priv->num_local_tt);
+			bat_dbg(DBG_TT, bat_priv, "Deleting local "
+				"tt entry (%pM): timed out\n",
+				tt_local_entry->addr);
+			hlist_del_rcu(node);
+			tt_local_entry_free_ref(tt_local_entry);
 		}
+		spin_unlock_bh(list_lock);
 	}
 
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 }
 
 static void tt_local_table_free(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash;
-	int i;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
-	struct hlist_head *head;
-	struct hlist_node *node, *node_tmp;
 	struct tt_local_entry *tt_local_entry;
+	struct hlist_node *node, *node_tmp;
+	struct hlist_head *head;
+	int i;
 
 	if (!bat_priv->tt_local_hash)
 		return;
@@ -449,7 +468,7 @@ static void tt_local_table_free(struct bat_priv *bat_priv)
 		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(node);
-			kfree(tt_local_entry);
+			tt_local_entry_free_ref(tt_local_entry);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -494,10 +513,9 @@ int tt_global_add(struct bat_priv *bat_priv,
 		  unsigned char *tt_addr, uint8_t ttvn, bool roaming)
 {
 	struct tt_global_entry *tt_global_entry;
-	struct tt_local_entry *tt_local_entry;
 	struct orig_node *orig_node_tmp;
+	int ret = 0;
 
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	tt_global_entry = tt_global_hash_find(bat_priv, tt_addr);
 
 	if (!tt_global_entry) {
@@ -505,17 +523,20 @@ int tt_global_add(struct bat_priv *bat_priv,
 			kmalloc(sizeof(struct tt_global_entry),
 				GFP_ATOMIC);
 		if (!tt_global_entry)
-			goto unlock;
+			goto out;
+
 		memcpy(tt_global_entry->addr, tt_addr, ETH_ALEN);
 		/* Assign the new orig_node */
 		atomic_inc(&orig_node->refcount);
 		tt_global_entry->orig_node = orig_node;
 		tt_global_entry->ttvn = ttvn;
 		tt_global_entry->flags = 0x00;
-		atomic_inc(&orig_node->tt_size);
+		atomic_set(&tt_global_entry->refcount, 2);
+
 		hash_add(bat_priv->tt_global_hash, compare_gtt,
 			 choose_orig, tt_global_entry,
 			 &tt_global_entry->hash_entry);
+		atomic_inc(&orig_node->tt_size);
 	} else {
 		if (tt_global_entry->orig_node != orig_node) {
 			atomic_dec(&tt_global_entry->orig_node->tt_size);
@@ -529,25 +550,18 @@ int tt_global_add(struct bat_priv *bat_priv,
 		}
 	}
 
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new global tt entry: %pM (via %pM)\n",
 		tt_global_entry->addr, orig_node->orig);
 
 	/* remove address from local hash if present */
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
-	tt_local_entry = tt_local_hash_find(bat_priv, tt_addr);
-
-	if (tt_local_entry)
-		tt_local_remove(bat_priv, tt_global_entry->addr,
-				"global tt received", roaming);
-
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
-	return 1;
-unlock:
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
-	return 0;
+	tt_local_remove(bat_priv, tt_global_entry->addr,
+			"global tt received", roaming);
+	ret = 1;
+out:
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
+	return ret;
 }
 
 int tt_global_seq_print_text(struct seq_file *seq, void *offset)
@@ -584,8 +598,6 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s %s       %-15s %s\n",
 		   "Client", "(TTVN)", "Originator", "(Curr TTVN)");
 
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
-
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx (ttvn) via
 	 * xx:xx:xx:xx:xx:xx (cur_ttvn)\n"*/
@@ -600,10 +612,10 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_bh(&bat_priv->tt_ghash_lock);
 		ret = -ENOMEM;
 		goto out;
 	}
+
 	buff[0] = '\0';
 	pos = 0;
 
@@ -625,8 +637,6 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_unlock();
 	}
 
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
 out:
@@ -640,7 +650,7 @@ static void _tt_global_del(struct bat_priv *bat_priv,
 			   char *message)
 {
 	if (!tt_global_entry)
-		return;
+		goto out;
 
 	bat_dbg(DBG_TT, bat_priv,
 		"Deleting global tt entry %pM (via %pM): %s\n",
@@ -648,30 +658,34 @@ static void _tt_global_del(struct bat_priv *bat_priv,
 		message);
 
 	atomic_dec(&tt_global_entry->orig_node->tt_size);
+
 	hash_remove(bat_priv->tt_global_hash, compare_gtt, choose_orig,
 		    tt_global_entry->addr);
-	kfree(tt_global_entry);
+out:
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
 }
 
 void tt_global_del(struct bat_priv *bat_priv,
 		   struct orig_node *orig_node,
 		   unsigned char *addr, char *message, bool roaming)
 {
-	struct tt_global_entry *tt_global_entry;
+	struct tt_global_entry *tt_global_entry = NULL;
 
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
+	if (!tt_global_entry)
+		goto out;
 
-	if (tt_global_entry && tt_global_entry->orig_node == orig_node) {
+	if (tt_global_entry->orig_node == orig_node) {
 		if (roaming) {
 			tt_global_entry->flags |= TT_GLOBAL_ROAM;
 			goto out;
 		}
-		atomic_dec(&orig_node->tt_size);
 		_tt_global_del(bat_priv, tt_global_entry, message);
 	}
 out:
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
 }
 
 void tt_global_del_orig(struct bat_priv *bat_priv,
@@ -682,38 +696,59 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 	struct hashtable_t *hash = bat_priv->tt_global_hash;
 	struct hlist_node *node, *safe;
 	struct hlist_head *head;
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 
-	if (!bat_priv->tt_global_hash)
-		return;
-
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
 
+		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_global_entry, node, safe,
 					 head, hash_entry) {
-			if (tt_global_entry->orig_node == orig_node)
-				_tt_global_del(bat_priv, tt_global_entry,
-					       message);
+			if (tt_global_entry->orig_node == orig_node) {
+				bat_dbg(DBG_TT, bat_priv,
+					"Deleting global tt entry %pM "
+					"(via %pM): originator time out\n",
+					tt_global_entry->addr,
+					tt_global_entry->orig_node->orig);
+				hlist_del_rcu(node);
+				tt_global_entry_free_ref(tt_global_entry);
+			}
 		}
+		spin_unlock_bh(list_lock);
 	}
 	atomic_set(&orig_node->tt_size, 0);
-
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
-}
-
-static void tt_global_entry_free(struct hlist_node *node, void *arg)
-{
-	void *data = container_of(node, struct tt_global_entry, hash_entry);
-	kfree(data);
 }
 
 static void tt_global_table_free(struct bat_priv *bat_priv)
 {
+	struct hashtable_t *hash;
+	spinlock_t *list_lock; /* protects write access to the hash lists */
+	struct tt_global_entry *tt_global_entry;
+	struct hlist_node *node, *node_tmp;
+	struct hlist_head *head;
+	int i;
+
 	if (!bat_priv->tt_global_hash)
 		return;
 
-	hash_delete(bat_priv->tt_global_hash, tt_global_entry_free, NULL);
+	hash = bat_priv->tt_global_hash;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
+
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry_safe(tt_global_entry, node, node_tmp,
+					  head, hash_entry) {
+			hlist_del_rcu(node);
+			tt_global_entry_free_ref(tt_global_entry);
+		}
+		spin_unlock_bh(list_lock);
+	}
+
+	hash_destroy(hash);
+
 	bat_priv->tt_global_hash = NULL;
 }
 
@@ -722,19 +757,19 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
 	struct tt_global_entry *tt_global_entry;
 	struct orig_node *orig_node = NULL;
 
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
 
 	if (!tt_global_entry)
 		goto out;
 
 	if (!atomic_inc_not_zero(&tt_global_entry->orig_node->refcount))
-		goto out;
+		goto free_tt;
 
 	orig_node = tt_global_entry->orig_node;
 
+free_tt:
+	tt_global_entry_free_ref(tt_global_entry);
 out:
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
 	return orig_node;
 }
 
@@ -797,7 +832,6 @@ uint16_t tt_local_crc(struct bat_priv *bat_priv)
 						   tt_local_entry->addr[j]);
 			total ^= total_one;
 		}
-
 		rcu_read_unlock();
 	}
 
@@ -1349,15 +1383,17 @@ void tt_update_changes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 
 bool is_my_client(struct bat_priv *bat_priv, uint8_t *addr)
 {
-	struct tt_local_entry *tt_local_entry;
+	struct tt_local_entry *tt_local_entry = NULL;
+	bool ret = false;
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
-
+	if (!tt_local_entry)
+		goto out;
+	ret = true;
+out:
 	if (tt_local_entry)
-		return true;
-	return false;
+		tt_local_entry_free_ref(tt_local_entry);
+	return ret;
 }
 
 void handle_tt_response(struct bat_priv *bat_priv,
@@ -1394,9 +1430,7 @@ void handle_tt_response(struct bat_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt_req_list_lock);
 
 	/* Recalculate the CRC for this orig_node and store it */
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
 	/* Roaming phase is over: tables are in sync again. I can
 	 * unset the flag */
 	orig_node->tt_poss_change = false;
diff --git a/types.h b/types.h
index b148bc3..fdc6993 100644
--- a/types.h
+++ b/types.h
@@ -190,8 +190,6 @@ struct bat_priv {
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t tt_changes_list_lock; /* protects tt_changes */
-	spinlock_t tt_lhash_lock; /* protects tt_local_hash */
-	spinlock_t tt_ghash_lock; /* protects tt_global_hash */
 	spinlock_t tt_req_list_lock; /* protects tt_req_list */
 	spinlock_t tt_roam_list_lock; /* protects tt_roam_list */
 	spinlock_t gw_list_lock; /* protects gw_list and curr_gw */
@@ -232,6 +230,8 @@ struct tt_local_entry {
 	uint8_t addr[ETH_ALEN];
 	unsigned long last_seen;
 	char never_purge;
+	atomic_t refcount;
+	struct rcu_head rcu;
 	struct hlist_node hash_entry;
 };
 
@@ -240,6 +240,8 @@ struct tt_global_entry {
 	struct orig_node *orig_node;
 	uint8_t ttvn;
 	uint8_t flags; /* only TT_GLOBAL_ROAM is used */
+	atomic_t refcount;
+	struct rcu_head rcu;
 	struct hlist_node hash_entry; /* entry in the global table */
 };
 
diff --git a/vis.c b/vis.c
index c39f20c..4c27950 100644
--- a/vis.c
+++ b/vis.c
@@ -680,11 +680,12 @@ next:
 
 	hash = bat_priv->tt_local_hash;
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
-		hlist_for_each_entry(tt_local_entry, node, head, hash_entry) {
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(tt_local_entry, node, head,
+					 hash_entry) {
 			entry = (struct vis_info_entry *)
 					skb_put(info->skb_packet,
 						sizeof(*entry));
@@ -693,14 +694,12 @@ next:
 			entry->quality = 0; /* 0 means TT */
 			packet->entries++;
 
-			if (vis_packet_full(info)) {
-				spin_unlock_bh(&bat_priv->tt_lhash_lock);
-				return 0;
-			}
+			if (vis_packet_full(info))
+				goto unlock;
 		}
+		rcu_read_unlock();
 	}
 
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 	return 0;
 
 unlock:
-- 
1.7.3.4

