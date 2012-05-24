Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 25 May 2012 00:00:42 +0200
Message-Id: <1337896842-13154-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: clear ADD+DEL (and viceversa)
	events in the same orig-interval
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

During an OGM-interval (time between two different OGM sendings) the same client
could roam away and then roam back to us. In this case the node would add two
events to the events list (that is going to be sent appended to the next OGM). A
DEL one and an ADD one. Obviously they will only increase the overhead (either in
the air and on the receiver side) and eventually trigger wrong states/events
without producing any real effect.

For this reason we can safely delete any ADD event with its related DEL one.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

changes in v3:
- rebased on top of the last patches for code restyling

 translation-table.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index cb1d3a8..2c8266a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -156,7 +156,9 @@ batadv_tt_orig_list_entry_free_ref(struct tt_orig_list_entry *orig_entry)
 static void batadv_tt_local_event(struct bat_priv *bat_priv,
 				  const uint8_t *addr, uint8_t flags)
 {
-	struct tt_change_node *tt_change_node;
+	struct tt_change_node *tt_change_node, *entry, *safe;
+	bool event_removed = false;
+	bool del_op_requested, del_op_entry;
 
 	tt_change_node = kmalloc(sizeof(*tt_change_node), GFP_ATOMIC);
 
@@ -166,13 +168,45 @@ static void batadv_tt_local_event(struct bat_priv *bat_priv,
 	tt_change_node->change.flags = flags;
 	memcpy(tt_change_node->change.addr, addr, ETH_ALEN);
 
+	del_op_requested = flags & TT_CLIENT_DEL;
+
+	/* check for ADD+DEL or DEL+ADD events */
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
+	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
+				 list) {
+		if (!batadv_compare_eth(entry->change.addr, addr))
+			continue;
+
+		/* DEL+ADD in the same orig interval have no effect and can be
+		 * removed to avoid silly behaviour on the receiver side. The
+		 * other way around (ADD+DEL) can happen in case of roaming of
+		 * a client still in the NEW state. Roaming of NEW clients is
+		 * now possible due to automatically recognition of "temporary"
+		 * clients
+		 */
+		del_op_entry = entry->change.flags & TT_CLIENT_DEL;
+		if (!del_op_requested && del_op_entry)
+			goto del;
+		if (del_op_requested && !del_op_entry)
+			goto del;
+		continue;
+del:
+		list_del(&entry->list);
+		kfree(entry);
+		event_removed = true;
+		goto unlock;
+	}
+
 	/* track the change in the OGMinterval list */
 	list_add_tail(&tt_change_node->list, &bat_priv->tt_changes_list);
-	atomic_inc(&bat_priv->tt_local_changes);
+
+unlock:
 	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
 
-	atomic_set(&bat_priv->tt_ogm_append_cnt, 0);
+	if (event_removed)
+		atomic_dec(&bat_priv->tt_local_changes);
+	else
+		atomic_inc(&bat_priv->tt_local_changes);
 }
 
 int batadv_tt_len(int changes_num)
-- 
1.7.9.4

