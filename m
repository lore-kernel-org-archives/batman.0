Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  3 Apr 2013 11:15:33 +0200
Message-Id: <1364980533-5452-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: refactor batadv_tt_local_event()
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Instead of passing a generic combination of flags as
argument, it is easier to pass the entire tt_common
structure (containing the flags already set) plus a
bitfield of additional flags that will be unified with
the already existing ones before inserting the client
in the event queue.
In this way invocations of the modified function can be
simplified.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 translation-table.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 9322320..3bebdcc 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -158,10 +158,19 @@ batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
 	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
 }
 
+/**
+ * batadv_tt_local_event - store a local TT event (ADD/DEL)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @tt_local_entry: the TT entry involved in the event
+ * @additional_flags: other flag to store in the event structure
+ */
 static void batadv_tt_local_event(struct batadv_priv *bat_priv,
-				  const uint8_t *addr, uint8_t flags)
+				  struct batadv_tt_local_entry *tt_local_entry,
+				  uint8_t additional_flags)
 {
 	struct batadv_tt_change_node *tt_change_node, *entry, *safe;
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	uint8_t flags = common->flags | additional_flags;
 	bool event_removed = false;
 	bool del_op_requested, del_op_entry;
 
@@ -171,7 +180,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		return;
 
 	tt_change_node->change.flags = flags;
-	memcpy(tt_change_node->change.addr, addr, ETH_ALEN);
+	memcpy(tt_change_node->change.addr, common->addr, ETH_ALEN);
 
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
@@ -179,7 +188,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
-		if (!batadv_compare_eth(entry->change.addr, addr))
+		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
 		/* DEL+ADD in the same orig interval have no effect and can be
@@ -327,7 +336,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	}
 
 add_event:
-	batadv_tt_local_event(bat_priv, addr, tt_local->common.flags);
+	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 check_roaming:
 	/* Check whether it is a roaming, but don't do anything if the roaming
@@ -524,8 +533,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 			    struct batadv_tt_local_entry *tt_local_entry,
 			    uint16_t flags, const char *message)
 {
-	batadv_tt_local_event(bat_priv, tt_local_entry->common.addr,
-			      tt_local_entry->common.flags | flags);
+	batadv_tt_local_event(bat_priv, tt_local_entry, flags);
 
 	/* The local client has to be marked as "pending to be removed" but has
 	 * to be kept in the table in order to send it in a full table
@@ -579,8 +587,7 @@ uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
-	batadv_tt_local_event(bat_priv, tt_local_entry->common.addr,
-			      curr_flags | BATADV_TT_CLIENT_DEL);
+	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
 	hlist_del_rcu(&tt_local_entry->common.hash_entry);
 	batadv_tt_local_entry_free_ref(tt_local_entry);
 
-- 
1.8.1.5

