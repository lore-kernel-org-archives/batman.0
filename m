Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 27 Sep 2011 00:49:57 +0200
Message-Id: <1317077397-15923-1-git-send-email-ordex@autistici.org>
In-Reply-To: <4E80EB52.2010906@wifibot.com>
References: <4E80EB52.2010906@wifibot.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Chichek hunt started! Verbose
	patch
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
 translation-table.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 7de9960..e7bac85 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -258,9 +258,14 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
 	atomic_set(&bat_priv->tt_local_changes, 0);
 
+	printk("TT_BUG Preparing OGM buffer\n");
+
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
 			list) {
 		if (count < tot_changes) {
+			printk("TT_BUG Copying flags: 0x%x addr: %pM\n",
+					entry->change.flags,
+					entry->change.addr);
 			memcpy(buff + tt_len(count),
 			       &entry->change, sizeof(struct tt_change));
 			count++;
@@ -270,6 +275,8 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 	}
 	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
 
+	printk("TT_BUG Copied %d addresses\n", count);
+
 	/* Keep the buffer for possible tt_request */
 	spin_lock_bh(&bat_priv->tt_buff_lock);
 	kfree(bat_priv->tt_buff);
@@ -1407,7 +1414,11 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 {
 	int i;
 
+	printk("TT_BUG Received %d changes\n", tt_num_changes);
+
 	for (i = 0; i < tt_num_changes; i++) {
+		printk("TT_BUG flags: 0x%x %pM\n", (tt_change + i)->flags,
+				(tt_change + i)->addr);
 		if ((tt_change + i)->flags & TT_CLIENT_DEL)
 			tt_global_del(bat_priv, orig_node,
 				      (tt_change + i)->addr,
@@ -1505,12 +1516,16 @@ void handle_tt_response(struct bat_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	if (tt_response->flags & TT_FULL_TABLE)
+	if (tt_response->flags & TT_FULL_TABLE) {
+		printk("TT_BUG Got full table on response\n");
 		tt_fill_gtable(bat_priv, tt_response);
-	else
+	}
+	else{
+		printk("TT_BUG Got diff\n");
 		tt_update_changes(bat_priv, orig_node, tt_response->tt_data,
 				  tt_response->ttvn,
 				  (struct tt_change *)(tt_response + 1));
+	}
 
 	/* Delete the tt_req_node from pending tt_requests list */
 	spin_lock_bh(&bat_priv->tt_req_list_lock);
-- 
1.7.3.4

