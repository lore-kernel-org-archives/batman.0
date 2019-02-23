Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 23 Feb 2019 15:09:05 +0100
Message-Id: <20190223140906.28979-2-sven@narfation.org>
In-Reply-To: <20190223140906.28979-1-sven@narfation.org>
References: <20190223140906.28979-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-adv: Reduce tt_local hash refcnt only for
 removed entry
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
Cc: Sven Eckelmann <sven@narfation.org>, Martin Weinelt <martin@linuxlounge.net>, Marek Lindner <mareklindner@neomailbox.ch>

The batadv_hash_remove is a function which searches the hashtable for an
entry using a needle, a hashtable bucket selection function and a compare
function. It will lock the bucket list and delete an entry when the compare
function matches it with the needle. It returns the pointer to the
hlist_node which matches or NULL when no entry matches the needle.

The batadv_tt_local_remove is not itself protected in anyway to avoid that
any other function is modifying the hashtable between the search for the
entry and the call to batadv_hash_remove. It can therefore happen that the
entry either doesn't exist anymore or an entry was deleted which is not the
same object as the needle. In such an situation, the reference counter (for
the reference stored in the hashtable) must not be reduced for the needle.
Instead the reference counter of the actually removed entry has to be
reduced.

Otherwise the reference counter will underflow and the object might be
freed before all its references were dropped. The kref helpers reported
this problem as:

  refcount_t: underflow; use-after-free.

Fixes: af912d77181f ("batman-adv: protect tt_local_entry from concurrent delete events")
Reported-by: Martin Weinelt <martin@linuxlounge.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Marek Lindner <mareklindner@neomailbox.ch>

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f73d79139ae79834a3e429fab82b7d55e8a373d5..b5cfc5068a904d060dee1a1c6cb4b0177198e5d9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1337,9 +1337,10 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid, const char *message,
 			   bool roaming)
 {
+	struct batadv_tt_local_entry *tt_removed_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
 	u16 flags, curr_flags = BATADV_NO_FLAGS;
-	void *tt_entry_exists;
+	struct hlist_node *tt_removed_node;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
@@ -1368,15 +1369,18 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	 */
 	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
 
-	tt_entry_exists = batadv_hash_remove(bat_priv->tt.local_hash,
+	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
 					     batadv_compare_tt,
 					     batadv_choose_tt,
 					     &tt_local_entry->common);
-	if (!tt_entry_exists)
+	if (!tt_removed_node)
 		goto out;
 
-	/* extra call to free the local tt entry */
-	batadv_tt_local_entry_put(tt_local_entry);
+	/* drop reference of remove hash entry */
+	tt_removed_entry = hlist_entry(tt_removed_node,
+				       struct batadv_tt_local_entry,
+				       common.hash_entry);
+	batadv_tt_local_entry_put(tt_removed_entry);
 
 out:
 	if (tt_local_entry)
