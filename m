Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 17 Jun 2015 20:09:55 +0800
Message-Id: <1434542995-22376-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: protect tt_local_entry from
	concurrent delete events
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

The tt_local_entry deletion performed batadv_tt_local_remove() was neither
protecting against simultaneous deletes nor checking whether the element
was still part of the list before calling hlist_del_rcu().

Replacing the hlist_del_rcu() with batadv_hash_remove() provides adequate
protection via hash spinlocks as well as a is-element-still-in-hash check.

Reported-by: alfonsname@web.de
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 translation-table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index e95a424..4afeeb5 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1042,7 +1042,8 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 	 * immediately purge it
 	 */
 	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-	hlist_del_rcu(&tt_local_entry->common.hash_entry);
+	batadv_hash_remove(bat_priv->tt.local_hash, batadv_compare_tt,
+			   batadv_choose_tt, &tt_local_entry->common);
 	batadv_tt_local_entry_free_ref(tt_local_entry);
 
 	/* decrease the reference held for this vlan */
-- 
2.1.4

