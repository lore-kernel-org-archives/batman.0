Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 14:17:44 +0100
Message-Id: <1450617490-3544-4-git-send-email-sven@narfation.org>
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 04/30] batman-adv: Drop immediate
	orig_node free function
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

It is not allowed to free the memory of an object which is part of a list
which is protected by rcu-read-side-critical sections without making sure
that no other context is accessing the object anymore. This usually happens
by removing the references to this object and then waiting until the rcu
grace period is over and no one (allowedly) accesses it anymore.

But the _now functions ignore this completely. They free the object
directly even when a different context still tries to access it. This has
to be avoided and thus these functions must be removed and all functions
have to use batadv_orig_node_free_ref.

Fixes: c8bda218468a ("batman-adv: Fix rcu_barrier() miss due to double call_rcu() in TT code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/originator.c        | 11 -----------
 net/batman-adv/originator.h        |  1 -
 net/batman-adv/translation-table.c | 28 +++++++++++++---------------
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 2681c7d..e1eda97 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -835,17 +835,6 @@ void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
 		call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
-/**
- * batadv_orig_node_free_ref_now - decrement the orig node refcounter and
- * possibly free it (without rcu callback)
- * @orig_node: the orig node to free
- */
-void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node)
-{
-	if (atomic_dec_and_test(&orig_node->refcount))
-		batadv_orig_node_free_rcu(&orig_node->rcu);
-}
-
 void batadv_originator_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 2955775..cf07304 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -38,7 +38,6 @@ int batadv_originator_init(struct batadv_priv *bat_priv);
 void batadv_originator_free(struct batadv_priv *bat_priv);
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
 void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
-void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr);
 struct batadv_hardif_neigh_node *
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1ca8831..96c3577 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -248,20 +248,6 @@ int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
 	return count;
 }
 
-static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_tt_orig_list_entry *orig_entry;
-
-	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
-
-	/* We are in an rcu callback here, therefore we cannot use
-	 * batadv_orig_node_free_ref() and its call_rcu():
-	 * An rcu_barrier() wouldn't wait for that to finish
-	 */
-	batadv_orig_node_free_ref_now(orig_entry->orig_node);
-	kfree(orig_entry);
-}
-
 /**
  * batadv_tt_local_size_mod - change the size by v of the local table identified
  *  by vid
@@ -357,13 +343,25 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
 	batadv_tt_global_size_mod(orig_node, vid, -1);
 }
 
+/**
+ * batadv_tt_orig_list_entry_release - release  tt orig entry from lists and
+ *  queue for free after rcu grace period
+ * @orig_entry: tt orig entry to be free'd
+ */
+static void
+batadv_tt_orig_list_entry_release(struct batadv_tt_orig_list_entry *orig_entry)
+{
+	batadv_orig_node_free_ref(orig_entry->orig_node);
+	kfree_rcu(orig_entry, rcu);
+}
+
 static void
 batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
 {
 	if (!atomic_dec_and_test(&orig_entry->refcount))
 		return;
 
-	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
+	batadv_tt_orig_list_entry_release(orig_entry);
 }
 
 /**
-- 
2.6.4

