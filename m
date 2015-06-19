Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 15:18:54 +0800
Message-Id: <1434698334-9399-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: protect tt_local_entry
	from concurrent delete events
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

The tt_local_entry deletion performed in batadv_tt_local_remove() was neither
protecting against simultaneous deletes nor checking whether the element was
still part of the list before calling hlist_del_rcu().

Replacing the hlist_del_rcu() call with batadv_hash_remove() provides adequate
protection via hash spinlocks as well as an is-element-still-in-hash check to
avoid 'blind' hash removal.

Fixes: 2443ba3 ("batman-adv: roaming handling mechanism redesign")

Reported-by: alfonsname@web.de
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
v3: added 'fixes' section
v2: rebased on master

 translation-table.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index f56b847..a65d10d 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1018,6 +1018,7 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 	struct batadv_tt_local_entry *tt_local_entry;
 	uint16_t flags, curr_flags = BATADV_NO_FLAGS;
 	struct batadv_softif_vlan *vlan;
+	void *tt_entry_exists;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
@@ -1045,7 +1046,15 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 	 * immediately purge it
 	 */
 	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-	hlist_del_rcu(&tt_local_entry->common.hash_entry);
+
+	tt_entry_exists = batadv_hash_remove(bat_priv->tt.local_hash,
+					     batadv_compare_tt,
+					     batadv_choose_tt,
+					     &tt_local_entry->common);
+	if (!tt_entry_exists)
+		goto out;
+
+	/* extra call to free the local tt entry */
 	batadv_tt_local_entry_free_ref(tt_local_entry);
 
 	/* decrease the reference held for this vlan */
-- 
2.1.4

