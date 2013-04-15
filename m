Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 15 Apr 2013 20:44:52 +0200
Message-Id: <1366051492-12344-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: avoid race conditions on TT
	global table by counting references
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
is once context) iand destroy the table only when the counter
reaches zero.

In this way the TT global table internal hash cannot be
deleted until all the entries have been destroyed.

CC: Linus Lüssing <linus.luessing@web.de>
CC: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
CC: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch makes ("batman-adv: Fix general protection fault in
batadv_tt_global_del_orig()") obsolete. This is a redesign which is supposed to
make the race condition impossible.

However, I still think we should merge Linus's fix to maint so that we can send
it to net and then proceed with this patch in master.

Cheers,


 translation-table.c | 81 ++++++++++++++++++++++++++++++++++++++++-------------
 types.h             |  4 +++
 2 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 96dfb38..739613e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -117,6 +117,29 @@ batadv_tt_local_entry_free_ref(struct batadv_tt_local_entry *tt_local_entry)
 		kfree_rcu(tt_local_entry, common.rcu);
 }
 
+static void
+batadv_tt_global_table_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_priv_tt *tt_priv;
+
+	tt_priv = container_of(rcu, struct batadv_priv_tt, global_rcu);
+
+	kfree(tt_priv->global_hash);
+	tt_priv->global_hash = NULL;
+}
+
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
@@ -130,13 +153,16 @@ static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
 }
 
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
+	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
+
+	batadv_tt_global_table_free_ref(bat_priv);
 }
 
 static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
@@ -251,7 +277,7 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 
 	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
 			   batadv_choose_orig, tt_global->common.addr);
-	batadv_tt_global_entry_free_ref(tt_global);
+	batadv_tt_global_entry_free_ref(bat_priv, tt_global);
 }
 
 void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
@@ -364,7 +390,7 @@ out:
 	if (tt_local)
 		batadv_tt_local_entry_free_ref(tt_local);
 	if (tt_global)
-		batadv_tt_global_entry_free_ref(tt_global);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global);
 }
 
 static void batadv_tt_realloc_packet_buff(unsigned char **packet_buff,
@@ -687,6 +713,12 @@ static int batadv_tt_global_init(struct batadv_priv *bat_priv)
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
 
@@ -844,7 +876,17 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 
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
@@ -918,7 +960,7 @@ out_remove:
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 	return ret;
@@ -1180,7 +1222,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 	if (local_entry)
 		batadv_tt_local_entry_free_ref(local_entry);
 }
@@ -1219,7 +1261,8 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 					   "Deleting global tt entry %pM: %s\n",
 					   tt_global->common.addr, message);
 				hlist_del_rcu(&tt_common_entry->hash_entry);
-				batadv_tt_global_entry_free_ref(tt_global);
+				batadv_tt_global_entry_free_ref(bat_priv,
+								tt_global);
 			}
 		}
 		spin_unlock_bh(list_lock);
@@ -1280,7 +1323,7 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 
 			hlist_del_rcu(&tt_common->hash_entry);
 
-			batadv_tt_global_entry_free_ref(tt_global);
+			batadv_tt_global_entry_free_ref(bat_priv, tt_global);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -1312,14 +1355,12 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 			tt_global = container_of(tt_common_entry,
 						 struct batadv_tt_global_entry,
 						 common);
-			batadv_tt_global_entry_free_ref(tt_global);
+			batadv_tt_global_entry_free_ref(bat_priv, tt_global);
 		}
 		spin_unlock_bh(list_lock);
 	}
 
-	batadv_hash_destroy(hash);
-
-	bat_priv->tt.global_hash = NULL;
+	batadv_tt_global_table_free_ref(bat_priv);
 }
 
 static bool
@@ -1373,7 +1414,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 
@@ -2433,7 +2474,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
 
 out:
 	if (tt_global_entry)
-		batadv_tt_global_entry_free_ref(tt_global_entry);
+		batadv_tt_global_entry_free_ref(bat_priv, tt_global_entry);
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 	return ret;
@@ -2521,7 +2562,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
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

