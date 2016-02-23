Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Tue, 23 Feb 2016 14:08:23 +0800
Message-Id: <1456207703-903-21-git-send-email-a@unstable.cc>
In-Reply-To: <1456207703-903-1-git-send-email-a@unstable.cc>
References: <1456207703-903-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 20/20] batman-adv: Rename
	batadv_tt_orig_list_entry *_free_ref function to *_put
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

The batman-adv source code is the only place in the kernel which uses the
*_free_ref naming scheme for the *_put functions. Changing it to *_put
makes it more consistent and makes it easier to understand the connection
to the *_get functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/translation-table.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7f65a8f17f52..0b43e86328a5 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -397,12 +397,12 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 }
 
 /**
- * batadv_tt_orig_list_entry_free_ref - decrement the tt orig entry refcounter
- *  and possibly release it
+ * batadv_tt_orig_list_entry_put - decrement the tt orig entry refcounter and
+ *  possibly release it
  * @orig_entry: tt orig entry to be free'd
  */
 static void
-batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
+batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
 {
 	kref_put(&orig_entry->refcount, batadv_tt_orig_list_entry_release);
 }
@@ -1345,7 +1345,7 @@ batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
 	orig_entry = batadv_tt_global_orig_entry_find(entry, orig_node);
 	if (orig_entry) {
 		found = true;
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
+		batadv_tt_orig_list_entry_put(orig_entry);
 	}
 
 	return found;
@@ -1386,7 +1386,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 
 out:
 	if (orig_entry)
-		batadv_tt_orig_list_entry_free_ref(orig_entry);
+		batadv_tt_orig_list_entry_put(orig_entry);
 }
 
 /**
@@ -1753,7 +1753,7 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 	 * being part of a list
 	 */
 	hlist_del_rcu(&orig_entry->list);
-	batadv_tt_orig_list_entry_free_ref(orig_entry);
+	batadv_tt_orig_list_entry_put(orig_entry);
 }
 
 /* deletes the orig list of a tt_global_entry */
-- 
2.7.1

