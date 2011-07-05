Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  5 Jul 2011 17:23:01 +0200
Message-Id: <1309879385-21224-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1309879385-21224-1-git-send-email-ordex@autistici.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: unify
	tt_local/global_free_ref functions
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

Thanks to the unification of the refcount field position inside the
tt_local/global structures, it is now possible to use
tt_local_entry_free_ref() for both the structures

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 06d361d..0f5219e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -131,18 +131,13 @@ static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
 	return time_after(jiffies, deadline);
 }
 
-static void tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
+static void tt_local_entry_free_ref(void *data_ptr)
 {
+	struct tt_local_entry *tt_local_entry = data_ptr;
 	if (atomic_dec_and_test(&tt_local_entry->refcount))
 		kfree_rcu(tt_local_entry, rcu);
 }
 
-static void tt_global_entry_free_ref(struct tt_global_entry *tt_global_entry)
-{
-	if (atomic_dec_and_test(&tt_global_entry->refcount))
-		kfree_rcu(tt_global_entry, rcu);
-}
-
 static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
 			   uint8_t flags)
 {
@@ -236,7 +231,7 @@ out:
 	if (tt_local_entry)
 		tt_local_entry_free_ref(tt_local_entry);
 	if (tt_global_entry)
-		tt_global_entry_free_ref(tt_global_entry);
+		tt_local_entry_free_ref(tt_global_entry);
 }
 
 int tt_changes_fill_buffer(struct bat_priv *bat_priv,
@@ -544,7 +539,7 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	ret = 1;
 out:
 	if (tt_global_entry)
-		tt_global_entry_free_ref(tt_global_entry);
+		tt_local_entry_free_ref(tt_global_entry);
 	return ret;
 }
 
@@ -647,7 +642,7 @@ static void _tt_global_del(struct bat_priv *bat_priv,
 		    tt_global_entry->addr);
 out:
 	if (tt_global_entry)
-		tt_global_entry_free_ref(tt_global_entry);
+		tt_local_entry_free_ref(tt_global_entry);
 }
 
 void tt_global_del(struct bat_priv *bat_priv,
@@ -670,7 +665,7 @@ void tt_global_del(struct bat_priv *bat_priv,
 	}
 out:
 	if (tt_global_entry)
-		tt_global_entry_free_ref(tt_global_entry);
+		tt_local_entry_free_ref(tt_global_entry);
 }
 
 void tt_global_del_orig(struct bat_priv *bat_priv,
@@ -697,7 +692,7 @@ void tt_global_del_orig(struct bat_priv *bat_priv,
 					tt_global_entry->addr,
 					tt_global_entry->orig_node->orig);
 				hlist_del_rcu(node);
-				tt_global_entry_free_ref(tt_global_entry);
+				tt_local_entry_free_ref(tt_global_entry);
 			}
 		}
 		spin_unlock_bh(list_lock);
@@ -732,7 +727,7 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 				tt_global_entry->addr);
 			atomic_dec(&tt_global_entry->orig_node->tt_size);
 			hlist_del_rcu(node);
-			tt_global_entry_free_ref(tt_global_entry);
+			tt_local_entry_free_ref(tt_global_entry);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -761,7 +756,7 @@ static void tt_global_table_free(struct bat_priv *bat_priv)
 		hlist_for_each_entry_safe(tt_global_entry, node, node_tmp,
 					  head, hash_entry) {
 			hlist_del_rcu(node);
-			tt_global_entry_free_ref(tt_global_entry);
+			tt_local_entry_free_ref(tt_global_entry);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -788,7 +783,7 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 	orig_node = tt_global_entry->orig_node;
 
 free_tt:
-	tt_global_entry_free_ref(tt_global_entry);
+	tt_local_entry_free_ref(tt_global_entry);
 out:
 	return orig_node;
 }
-- 
1.7.3.4

