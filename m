Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:48 +0100
Message-Id: <1450222316-1764-15-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 15/23] batman-adv: Convert
	batadv_orig_node_free_rcu to kref
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

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c        | 11 --------
 net/batman-adv/originator.h        |  1 -
 net/batman-adv/translation-table.c | 54 +++++++++++++++++++++-----------------
 net/batman-adv/types.h             |  2 +-
 4 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index f39a715..0e836bd 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -819,17 +819,6 @@ void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
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
index 0dd1beb..dc5cefa 100644
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
index 3cac667..096804e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -31,6 +31,7 @@
 #include <linux/jhash.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -248,20 +249,6 @@ int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
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
@@ -357,13 +344,31 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
 	batadv_tt_global_size_mod(orig_node, vid, -1);
 }
 
-static void
-batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
+/**
+ * batadv_tt_orig_list_entry_release - release  tt orig entry from lists and
+ *  queue for free after rcu grace period
+ * * @ref: kref pointer of the tt orig entry
+ */
+static void batadv_tt_orig_list_entry_release(struct kref *ref)
 {
-	if (!atomic_dec_and_test(&orig_entry->refcount))
-		return;
+	struct batadv_tt_orig_list_entry *orig_entry;
 
-	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
+	orig_entry = container_of(ref, struct batadv_tt_orig_list_entry,
+				  refcount);
+
+	batadv_orig_node_free_ref(orig_entry->orig_node);
+	kfree_rcu(orig_entry, rcu);
+}
+
+/**
+ * batadv_tt_orig_list_entry_put - decrement the tt orig entry refcounter and
+ *  possibly release it
+ * @orig_entry: tt orig entry to be free'd
+ */
+static void
+batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
+{
+	kref_put(&orig_entry->refcount, batadv_tt_orig_list_entry_release);
 }
 
 /**
@@ -1272,7 +1277,7 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 	hlist_for_each_entry_rcu(tmp_orig_entry, head, list) {
 		if (tmp_orig_entry->orig_node != orig_node)
 			continue;
-		if (!atomic_inc_not_zero(&tmp_orig_entry->refcount))
+		if (!kref_get_unless_zero(&tmp_orig_entry->refcount))
 			continue;
 
 		orig_entry = tmp_orig_entry;
@@ -1303,7 +1308,7 @@ batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
 	orig_entry = batadv_tt_global_orig_entry_find(entry, orig_node);
 	if (orig_entry) {
 		found = true;
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
+		batadv_tt_orig_list_entry_put(orig_entry);
 	}
 
 	return found;
@@ -1333,7 +1338,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	batadv_tt_global_size_inc(orig_node, tt_global->common.vid);
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
-	atomic_set(&orig_entry->refcount, 2);
+	kref_init(&orig_entry->refcount);
+	kref_get(&orig_entry->refcount);
 
 	spin_lock_bh(&tt_global->list_lock);
 	hlist_add_head_rcu(&orig_entry->list,
@@ -1343,7 +1349,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 
 out:
 	if (orig_entry)
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
+		batadv_tt_orig_list_entry_put(orig_entry);
 }
 
 /**
@@ -1709,7 +1715,7 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 	 * being part of a list
 	 */
 	hlist_del_rcu(&orig_entry->list);
-	batadv_tt_orig_list_entry_free_ref(orig_entry);
+	batadv_tt_orig_list_entry_put(orig_entry);
 }
 
 /* deletes the orig list of a tt_global_entry */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 60d304b..58ae09e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1014,7 +1014,7 @@ struct batadv_tt_orig_list_entry {
 	struct batadv_orig_node *orig_node;
 	u8 ttvn;
 	struct hlist_node list;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

