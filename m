Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  3 May 2011 17:54:56 +0200
Message-Id: <1304438096-19009-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1303940106-1457-1-git-send-email-ordex@autistici.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: protect the local and the
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
 translation-table.c |  266 +++++++++++++++++++++++++++++----------------------
 types.h             |    6 +-
 vis.c               |   13 +--
 4 files changed, 161 insertions(+), 126 deletions(-)

diff --git a/main.c b/main.c
index 31cbecc..a3783f8 100644
--- a/main.c
+++ b/main.c
@@ -81,8 +81,6 @@ int mesh_init(struct net_device *soft_iface)
 
 	spin_lock_init(&bat_priv->forw_bat_list_lock);
 	spin_lock_init(&bat_priv->forw_bcast_list_lock);
-	spin_lock_init(&bat_priv->tt_lhash_lock);
-	spin_lock_init(&bat_priv->tt_ghash_lock);
 	spin_lock_init(&bat_priv->tt_changes_list_lock);
 	spin_lock_init(&bat_priv->tt_req_list_lock);
 	spin_lock_init(&bat_priv->tt_roam_list_lock);
diff --git a/translation-table.c b/translation-table.c
index b533f0a..00d0255 100644
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
@@ -123,6 +129,34 @@ static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
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
 static void tt_local_event(struct bat_priv *bat_priv, uint8_t op, uint8_t *addr)
 {
 	struct tt_change_node *tt_change_node;
@@ -166,22 +200,19 @@ static int tt_local_init(struct bat_priv *bat_priv)
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
 
 	tt_local_event(bat_priv, TT_ADD, addr);
 
@@ -191,6 +222,7 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 
 	memcpy(tt_local_entry->addr, addr, ETH_ALEN);
 	tt_local_entry->last_seen = jiffies;
+	atomic_set(&tt_local_entry->refcount, 2);
 
 	/* the batman interface mac address should never be purged */
 	if (compare_eth(addr, soft_iface->dev_addr))
@@ -200,31 +232,26 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 
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
@@ -306,8 +333,6 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		   "announced via TT (TTVN: %u):\n",
 		   net_dev->name, (uint8_t)atomic_read(&bat_priv->ttvn));
 
-	spin_lock_bh(&bat_priv->tt_lhash_lock);
-
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx\n" */
 	for (i = 0; i < hash->size; i++) {
@@ -321,7 +346,6 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_bh(&bat_priv->tt_lhash_lock);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -341,8 +365,6 @@ int tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_unlock();
 	}
 
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
-
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
 out:
@@ -351,15 +373,6 @@ out:
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
@@ -372,26 +385,28 @@ static void tt_local_del(struct bat_priv *bat_priv,
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
-		if (roaming)
-			tt_local_event(bat_priv, TT_DEL, broadcast_addr);
-		else
-			tt_local_event(bat_priv, TT_DEL, tt_local_entry->addr);
+	if (!tt_local_entry)
+		goto out;
 
-		tt_local_del(bat_priv, tt_local_entry, message);
-	}
-	spin_unlock_bh(&bat_priv->tt_lhash_lock);
+	if (roaming)
+		tt_local_event(bat_priv, TT_DEL, broadcast_addr);
+	else
+		tt_local_event(bat_priv, TT_DEL, tt_local_entry->addr);
+
+	tt_local_del(bat_priv, tt_local_entry, message);
+out:
+	if (tt_local_entry)
+		tt_local_entry_free_ref(tt_local_entry);
 }
 
 static void tt_local_purge(struct bat_priv *bat_priv)
@@ -400,13 +415,14 @@ static void tt_local_purge(struct bat_priv *bat_priv)
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
@@ -417,22 +433,26 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 				continue;
 
 			tt_local_event(bat_priv, TT_DEL, tt_local_entry->addr);
-			tt_local_del(bat_priv, tt_local_entry,
-				     "address timed out");
+			atomic_dec(&bat_priv->num_local_tt);
+			bat_dbg(DBG_ROUTES, bat_priv, "Deleting local "
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
@@ -447,7 +467,7 @@ static void tt_local_table_free(struct bat_priv *bat_priv)
 		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(node);
-			kfree(tt_local_entry);
+			tt_local_entry_free_ref(tt_local_entry);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -492,10 +512,9 @@ int tt_global_add(struct bat_priv *bat_priv,
 		  unsigned char *tt_addr, uint8_t ttvn, bool roaming)
 {
 	struct tt_global_entry *tt_global_entry;
-	struct tt_local_entry *tt_local_entry;
 	struct orig_node *orig_node_tmp;
+	int ret = 0;
 
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	tt_global_entry = tt_global_hash_find(bat_priv, tt_addr);
 
 	if (!tt_global_entry) {
@@ -503,16 +522,19 @@ int tt_global_add(struct bat_priv *bat_priv,
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
@@ -525,25 +547,18 @@ int tt_global_add(struct bat_priv *bat_priv,
 		}
 	}
 
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
 	bat_dbg(DBG_ROUTES, bat_priv,
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
@@ -579,8 +594,6 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "       %-13s %s       %-15s %s\n",
 		   "Client", "(TTVN)", "Originator", "(Curr TTVN)");
 
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
-
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx (ttvn) via
 	 * xx:xx:xx:xx:xx:xx (cur_ttvn)\n"*/
@@ -595,10 +608,10 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_bh(&bat_priv->tt_ghash_lock);
 		ret = -ENOMEM;
 		goto out;
 	}
+
 	buff[0] = '\0';
 	pos = 0;
 
@@ -620,8 +633,6 @@ int tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_unlock();
 	}
 
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
 out:
@@ -635,7 +646,7 @@ static void _tt_global_del(struct bat_priv *bat_priv,
 			   char *message)
 {
 	if (!tt_global_entry)
-		return;
+		goto out;
 
 	bat_dbg(DBG_ROUTES, bat_priv,
 		"Deleting global tt entry %pM (via %pM): %s\n",
@@ -643,25 +654,29 @@ static void _tt_global_del(struct bat_priv *bat_priv,
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
 		   unsigned char *addr, char *message)
 {
-	struct tt_global_entry *tt_global_entry;
+	struct tt_global_entry *tt_global_entry = NULL;
 
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
+	if (!tt_global_entry)
+		goto out;
 
-	if (tt_global_entry && tt_global_entry->orig_node == orig_node) {
-		atomic_dec(&orig_node->tt_size);
+	if (tt_global_entry->orig_node == orig_node)
 		_tt_global_del(bat_priv, tt_global_entry, message);
-	}
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
+out:
+	if (tt_global_entry)
+		tt_global_entry_free_ref(tt_global_entry);
 }
 
 void tt_global_del_orig(struct bat_priv *bat_priv,
@@ -672,38 +687,59 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
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
+				bat_dbg(DBG_ROUTES, bat_priv,
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
 
@@ -712,19 +748,19 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
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
 
@@ -781,7 +817,6 @@ uint16_t tt_local_crc(struct bat_priv *bat_priv)
 						   tt_local_entry->addr[j]);
 			total ^= total_one;
 		}
-
 		rcu_read_unlock();
 	}
 
@@ -1319,7 +1354,7 @@ static void tt_update_changes(struct bat_priv *bat_priv,
 			if (!tt_global_add(bat_priv, orig_node,
 					   (tt_change + i)->addr,
 					   tt_response->ttvn, false))
-				return;
+				goto out;
 	}
 
 	tt_save_orig_buffer(bat_priv, orig_node, (unsigned char *)tt_change,
@@ -1333,15 +1368,17 @@ out:
 
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
@@ -1377,11 +1414,10 @@ void handle_tt_response(struct bat_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
 out:
-	orig_node_free_ref(orig_node);
+	if (orig_node)
+		orig_node_free_ref(orig_node);
 }
 
 int tt_init(struct bat_priv *bat_priv)
diff --git a/types.h b/types.h
index c1e88a4..e831230 100644
--- a/types.h
+++ b/types.h
@@ -193,8 +193,6 @@ struct bat_priv {
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t tt_changes_list_lock; /* protects tt_changes */
-	spinlock_t tt_lhash_lock; /* protects tt_local_hash */
-	spinlock_t tt_ghash_lock; /* protects tt_global_hash */
 	spinlock_t tt_req_list_lock; /* protects tt_req_list */
 	spinlock_t tt_roam_list_lock; /* protects tt_roam_list */
 	spinlock_t gw_list_lock; /* protects gw_list and curr_gw */
@@ -234,6 +232,8 @@ struct tt_local_entry {
 	uint8_t addr[ETH_ALEN];
 	unsigned long last_seen;
 	char never_purge;
+	atomic_t refcount;
+	struct rcu_head rcu;
 	struct hlist_node hash_entry;
 };
 
@@ -241,6 +241,8 @@ struct tt_global_entry {
 	uint8_t addr[ETH_ALEN];
 	struct orig_node *orig_node;
 	uint8_t ttvn;
+	atomic_t refcount;
+	struct rcu_head rcu;
 	/* entry in the global table */
 	struct hlist_node hash_entry;
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

