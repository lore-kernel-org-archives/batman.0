Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 26 Jun 2012 22:00:18 +0200
Message-Id: <1340740822-4516-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1340740822-4516-1-git-send-email-ordex@autistici.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: add reference counting for
	type batadv_tt_orig_list_entry
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   19 ++++++++++++++-----
 types.h             |    1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 245cc9a..0f02514 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -152,9 +152,12 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 static void
 batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
 {
-	/* to avoid race conditions, immediately decrease the tt counter */
-	atomic_dec(&orig_entry->orig_node->tt_size);
-	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
+	if (atomic_dec_and_test(&orig_entry->refcount)) {
+		/* to avoid race conditions, immediately decrease the tt counter
+		 */
+		atomic_dec(&orig_entry->orig_node->tt_size);
+		call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
+	}
 }
 
 static void batadv_tt_local_event(struct batadv_priv *bat_priv,
@@ -639,12 +642,17 @@ batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
 	rcu_read_lock();
 	head = &entry->orig_list;
 	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
-		if (tmp_orig_entry->orig_node == orig_node) {
+		if (tmp_orig_entry->orig_node != orig_node)
+			continue;
+		if (!atomic_inc_not_zero(&tmp_orig_entry->refcount))
+			continue;
+
 			found = true;
+			batadv_tt_orig_list_entry_free_ref(tmp_orig_entry);
 			break;
-		}
 	}
 	rcu_read_unlock();
+
 	return found;
 }
 
@@ -663,6 +671,7 @@ batadv_tt_global_add_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 	atomic_inc(&orig_node->tt_size);
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
+	atomic_set(&orig_entry->refcount, 0);
 
 	spin_lock_bh(&tt_global_entry->list_lock);
 	hlist_add_head_rcu(&orig_entry->list,
diff --git a/types.h b/types.h
index 64b4317..82b97c3 100644
--- a/types.h
+++ b/types.h
@@ -281,6 +281,7 @@ struct batadv_tt_global_entry {
 struct batadv_tt_orig_list_entry {
 	struct batadv_orig_node *orig_node;
 	uint8_t ttvn;
+	atomic_t refcount;
 	struct rcu_head rcu;
 	struct hlist_node list;
 };
-- 
1.7.9.4

