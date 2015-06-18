Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 18 Jun 2015 16:13:06 +0800
Message-Id: <1434615186-14871-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: update kernel doc of
	batadv_tt_global_del_orig_entry()
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

The updated kernel doc & additional comment shall prevent accidental
copy & paste errors or calling the function without the required
precautions.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 translation-table.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index fa122a2..f6ac67c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1630,20 +1630,26 @@ out:
 }
 
 /**
- * batadv_tt_global_del_orig_entry - remove and free an orig_entry
+ * _batadv_tt_global_del_orig_entry - remove and free an orig_entry
  * @tt_global_entry: the global entry to remove the orig_entry from
  * @orig_entry: the orig entry to remove and free
  *
  * Remove an orig_entry from its list in the given tt_global_entry and
  * free this orig_entry afterwards.
+ *
+ * Caller must hold tt_global_entry->list_lock and ensure orig_entry->list is
+ * part of a list.
  */
 static void
-batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
-				struct batadv_tt_orig_list_entry *orig_entry)
+_batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
+				 struct batadv_tt_orig_list_entry *orig_entry)
 {
 	batadv_tt_global_size_dec(orig_entry->orig_node,
 				  tt_global_entry->common.vid);
 	atomic_dec(&tt_global_entry->orig_list_count);
+	/* requires holding tt_global_entry->list_lock and orig_entry->list
+	 * being part of a list
+	 */
 	hlist_del_rcu(&orig_entry->list);
 	batadv_tt_orig_list_entry_free_ref(orig_entry);
 }
@@ -1659,7 +1665,7 @@ batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 	spin_lock_bh(&tt_global_entry->list_lock);
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_safe(orig_entry, safe, head, list)
-		batadv_tt_global_del_orig_entry(tt_global_entry, orig_entry);
+		_batadv_tt_global_del_orig_entry(tt_global_entry, orig_entry);
 	spin_unlock_bh(&tt_global_entry->list_lock);
 }
 
@@ -1694,8 +1700,8 @@ batadv_tt_global_del_orig_node(struct batadv_priv *bat_priv,
 				   orig_node->orig,
 				   tt_global_entry->common.addr,
 				   BATADV_PRINT_VID(vid), message);
-			batadv_tt_global_del_orig_entry(tt_global_entry,
-							orig_entry);
+			_batadv_tt_global_del_orig_entry(tt_global_entry,
+							 orig_entry);
 		}
 	}
 	spin_unlock_bh(&tt_global_entry->list_lock);
-- 
2.1.4

