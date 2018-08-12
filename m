Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Aug 2018 21:04:44 +0200
Message-Id: <20180812190445.28013-5-sven@narfation.org>
In-Reply-To: <20180812190445.28013-1-sven@narfation.org>
References: <20180812190445.28013-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Prevent duplicated global TT
 entry
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

The function batadv_tt_global_orig_entry_add is responsible for adding new
tt_orig_list_entry to the orig_list. It first checks whether the entry
already is in the list or not. If it is, then the creation of a new entry
is aborted.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: c5eb5bb30321 ("batman-adv: add reference counting for type batadv_tt_orig_list_entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 12a2b7d2..d21624c4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1613,6 +1613,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 
+	spin_lock_bh(&tt_global->list_lock);
+
 	orig_entry = batadv_tt_global_orig_entry_find(tt_global, orig_node);
 	if (orig_entry) {
 		/* refresh the ttvn: the current value could be a bogus one that
@@ -1635,11 +1637,9 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	orig_entry->flags = flags;
 	kref_init(&orig_entry->refcount);
 
-	spin_lock_bh(&tt_global->list_lock);
 	kref_get(&orig_entry->refcount);
 	hlist_add_head_rcu(&orig_entry->list,
 			   &tt_global->orig_list);
-	spin_unlock_bh(&tt_global->list_lock);
 	atomic_inc(&tt_global->orig_list_count);
 
 sync_flags:
@@ -1647,6 +1647,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 out:
 	if (orig_entry)
 		batadv_tt_orig_list_entry_put(orig_entry);
+
+	spin_unlock_bh(&tt_global->list_lock);
 }
 
 /**
-- 
2.18.0

