Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 16 Apr 2013 12:46:28 +0200
Message-Id: <1366109189-17384-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: avoid race conditions on
	TT global table by counting references
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

To avoid race conditions on TT global table clean up keep
track of the number of active contexts (each tt_global_entry
in the hash table is an active context) and destroy the
table only when the counter reaches zero.

In this way the TT global table internal hash cannot be
deleted until all the entries have been destroyed.

CC: Linus Lüssing <linus.luessing@web.de>
CC: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
CC: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- RCU callbacks reworking
- split the patch in 2 pieces

Cheers,


 soft-interface.c    |   7 +++
 translation-table.c | 126 +++++++++++++++++++++++++++++++++-------------------
 types.h             |   4 ++
 3 files changed, 92 insertions(+), 45 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 403b8c4..e2acf76 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -582,6 +582,13 @@ static void batadv_softif_free(struct net_device *dev)
 {
 	batadv_debugfs_del_meshif(dev);
 	batadv_mesh_free(dev);
+
+	/* at this point there are some RCU tasks scheduled (TT free) which
+	 * requires the bat_priv struct to exist. Wait for the tasks to be
+	 * finished before freeing bat_priv
+	 */
+	rcu_barrier();
+
 	free_netdev(dev);
 }
 
diff --git a/translation-table.c b/translation-table.c
index 96dfb38..bf8b7fa 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -42,6 +42,9 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 struct batadv_orig_node *orig_node,
 				 const unsigned char *addr,
 				 const char *message, bool roaming);
+static void
+batadv_tt_global_entry_free_ref(struct batadv_priv *bat_priv,
+				struct batadv_tt_global_entry *tt_global_entry);
 
 /* returns 1 if they are the same mac addr */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
@@ -117,6 +120,41 @@ batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
 		kfree_rcu(tt_local_entry, common.rcu);
 }
 
+/**
+ * batadv_tt_global_table_free_rcu - purge the tt global table
+ * @rcu: RCU object handling the context of the callback
+ *
+ * Free the hash. This function is invoked only when the hash table is empty
+ * and this is guaranteed by the fact that its refcounter reached zero.
+ */
+static void
+batadv_tt_global_table_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_priv_tt *tt_priv;
+
+	tt_priv = container_of(rcu, struct batadv_priv_tt, global_rcu);
+
+	batadv_hash_destroy(tt_priv->global_hash);
+	tt_priv->global_hash = NULL;
+}
+
+/**
+ * batadv_tt_global_table_free_ref - decrement the global table refcounter and
+ * possibly schedule its clean up
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void
+batadv_tt_global_table_free_ref(struct batadv_priv *bat_priv)
+{
+	/* test if this was the last reference to the global table. If so,
+	 * destroy the table as well
+	 */
+	if (!atomic_dec_and_test(&bat_priv->tt.global_refcount))
+		return;
+
+	call_rcu(&bat_priv->tt.global_rcu, batadv_tt_global_table_free_rcu);
+}
+
 static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
@@ -129,14 +167,23 @@ static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
 	kfree(tt_global_entry);
 }
 
+/**
+ * batadv_tt_global_entry_free_ref - decrement the global entry refcounter and
+ * possibly schedule its clean up
+ * @bat_priv: the bat priv with all the soft interface information
+ * @tt_global_entry: the entry which refcounter has to be decremented
+ */
 static void
-batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
+batadv_tt_global_entry_free_ref(struct batadv_priv *bat_priv,
+				struct batadv_tt_global_entry *tt_global_entry)
 {
-	if (atomic_dec_and_test(&tt_global_entry->common.refcount)) {
-		batadv_tt_global_del_orig_list(tt_global_entry);
-		call_rcu(&tt_global_entry->common.rcu,
-			 batadv_tt_global_entry_free_rcu);
-	}
+	if (!atomic_dec_and_test(&tt_global_entry->common.refcount))
+		return;
+
+	batadv_tt_global_del_orig_list(tt_global_entry);
+	batadv_tt_global_table_free_ref(bat_priv);
+
+	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
 }
 
 static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
@@ -251,7 +298,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 
 	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
 			   batadv_choose_orig, tt_global->common.addr);
-	batadv_tt_global_entry_free_ref(tt_global);
+	batadv_tt_global_entry_free_ref(bat_priv, tt_global);
 }
 
 void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
@@ -364,7 +411,7 @@ out:
 	if (tt_local)
 		batadv_tt_local_entry_free_ref(tt_local);
 	if (tt_global)
-		batadv_tt_global_entry_free_ref(tt_global);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global);
 }
 
 static void batadv_tt_realloc_packet_buff(unsigned char **packet_buff,
@@ -687,6 +734,12 @@ static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->tt.global_hash)
 		return -ENOMEM;
 
+	/* initialise the refcount to 1 meaning that the global table is used by
+	 * the TT component. This is balanced by tt_global_table_free_ref() in
+	 * tt_global_table_free()
+	 */
+	atomic_set(&bat_priv->tt.global_refcount, 1);
+
 	batadv_hash_set_lock_class(bat_priv->tt.global_hash,
 				   &batadv_tt_global_hash_lock_class_key);
 
@@ -844,7 +897,17 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 		if (unlikely(hash_added != 0)) {
 			/* remove the reference for the hash */
-			batadv_tt_global_entry_free_ref(tt_global_entry);
+			batadv_tt_global_entry_free_ref(bat_priv,
+							tt_global_entry);
+			goto out_remove;
+		}
+
+		/* increase the refcounter for this new "reference to the global
+		 * table represented by the global entry. If the increment
+		 * fails remove the entry from the hash
+		 */
+		if (!atomic_inc_not_zero(&bat_priv->tt.global_refcount)) {
+			hlist_del_rcu(&tt_global_entry->common.hash_entry);
 			goto out_remove;
 		}
 	} else {
@@ -918,7 +981,7 @@ out_remove:
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 	return ret;
@@ -1180,7 +1243,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 	if (local_entry)
 		batadv_tt_local_entry_free_ref(local_entry);
 }
@@ -1219,7 +1282,8 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 					   "Deleting global tt entry %pM: %s\n",
 					   tt_global->common.addr, message);
 				hlist_del_rcu(&tt_common_entry->hash_entry);
-				batadv_tt_global_entry_free_ref(tt_global);
+				batadv_tt_global_entry_free_ref(bat_priv,
+								tt_global);
 			}
 		}
 		spin_unlock_bh(list_lock);
@@ -1280,7 +1344,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 			hlist_del_rcu(&tt_common->hash_entry);
 
-			batadv_tt_global_entry_free_ref(tt_global);
+			batadv_tt_global_entry_free_ref(bat_priv, tt_global);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1288,38 +1352,10 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_hashtable *hash;
-	spinlock_t *list_lock; /* protects write access to the hash lists */
-	struct batadv_tt_common_entry *tt_common_entry;
-	struct batadv_tt_global_entry *tt_global;
-	struct hlist_node *node_tmp;
-	struct hlist_head *head;
-	uint32_t i;
-
 	if (!bat_priv->tt.global_hash)
 		return;
 
-	hash = bat_priv->tt.global_hash;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
-
-		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
-					  head, hash_entry) {
-			hlist_del_rcu(&tt_common_entry->hash_entry);
-			tt_global = container_of(tt_common_entry,
-						 struct batadv_tt_global_entry,
-						 common);
-			batadv_tt_global_entry_free_ref(tt_global);
-		}
-		spin_unlock_bh(list_lock);
-	}
-
-	batadv_hash_destroy(hash);
-
-	bat_priv->tt.global_hash = NULL;
+	batadv_tt_global_table_free_ref(bat_priv);
 }
 
 static bool
@@ -1373,7 +1409,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 
@@ -2433,7 +2469,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 	return ret;
@@ -2521,7 +2557,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 		goto out;
 
 	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
-	batadv_tt_global_entry_free_ref(tt_global_entry);
+	batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 out:
 	return ret;
 }
diff --git a/types.h b/types.h
index 5f542bd..a293a9b 100644
--- a/types.h
+++ b/types.h
@@ -337,6 +337,8 @@ enum batadv_counters {
  * @changes_list: tracks tt local changes within an originator interval
  * @local_hash: local translation table hash table
  * @global_hash: global translation table hash table
+ * @global_refcount: number of context where the global_hash table is used
+ * @global_rcu: object used to free the global table
  * @req_list: list of pending & unanswered tt_requests
  * @roam_list: list of the last roaming events of each client limiting the
  *  number of roaming events to avoid route flapping
@@ -357,6 +359,8 @@ struct batadv_priv_tt {
 	struct list_head changes_list;
 	struct batadv_hashtable *local_hash;
 	struct batadv_hashtable *global_hash;
+	atomic_t global_refcount;
+	struct rcu_head global_rcu;
 	struct list_head req_list;
 	struct list_head roam_list;
 	spinlock_t changes_list_lock; /* protects changes */
-- 
1.8.1.5

