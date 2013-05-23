Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 23 May 2013 22:15:18 +0200
Message-Id: <1369340122-2660-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1369340122-2660-1-git-send-email-ordex@autistici.org>
References: <1369340122-2660-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/7] batman-adv: print the VID together
	with the TT entries
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

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 translation-table.c | 82 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index c13f5ed..c7709b8 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -317,8 +317,9 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 				  const char *message)
 {
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Deleting global tt entry %pM: %s\n",
-		   tt_global->common.addr, message);
+		   "Deleting global tt entry %pM (vid: %d): %s\n",
+		   tt_global->common.addr,
+		   BATADV_PRINT_VID(tt_global->common.vid), message);
 
 	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
 			   batadv_choose_tt, &tt_global->common);
@@ -352,7 +353,8 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local->last_seen = jiffies;
 		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Re-adding pending client %pM\n", addr);
+				   "Re-adding pending client %pM (vid: %d)\n",
+				   addr, BATADV_PRINT_VID(vid));
 			/* whatever the reason why the PENDING flag was set,
 			 * this is a client which was enqueued to be removed in
 			 * this orig_interval. Since it popped up again, the
@@ -364,8 +366,8 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Roaming client %pM came back to its original location\n",
-				   addr);
+				   "Roaming client %pM (vid: %d) came back to its original location\n",
+				   addr, BATADV_PRINT_VID(vid));
 			/* the ROAM flag is set because this client roamed away
 			 * and the node got a roaming_advertisement message. Now
 			 * that the client popped up again at its original
@@ -382,7 +384,8 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Creating new local tt entry: %pM (ttvn: %d)\n", addr,
+		   "Creating new local tt entry: %pM (vid: %d, ttvn: %d)\n",
+		   addr, BATADV_PRINT_VID(vid),
 		   (uint8_t)atomic_read(&bat_priv->tt.vn));
 
 	memcpy(tt_local->common.addr, addr, ETH_ALEN);
@@ -551,8 +554,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u CRC: %#.8x):\n",
 		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn),
 		   bat_priv->tt.local_crc);
-	seq_printf(seq, "       %-13s %-7s %-10s\n", "Client", "Flags",
-		   "Last seen");
+	seq_printf(seq, "       %-13s  %s %-7s %-10s\n", "Client", "VID",
+		   "Flags", "Last seen");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -570,8 +573,9 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 
 			no_purge = tt_common_entry->flags & np_flag;
 
-			seq_printf(seq, " * %pM [%c%c%c%c%c] %3u.%03u\n",
+			seq_printf(seq, " * %pM %4i [%c%c%c%c%c] %3u.%03u\n",
 				   tt_common_entry->addr,
+				   BATADV_PRINT_VID(tt_common_entry->vid),
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
 				   no_purge ? 'P' : '.',
@@ -606,8 +610,9 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Local tt entry (%pM) pending to be removed: %s\n",
-		   tt_local_entry->common.addr, message);
+		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
+		   tt_local_entry->common.addr,
+		   BATADV_PRINT_VID(tt_local_entry->common.vid), message);
 }
 
 /**
@@ -985,8 +990,9 @@ add_orig_entry:
 	batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn);
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Creating new global tt entry: %pM (via %pM)\n",
-		   common->addr, orig_node->orig);
+		   "Creating new global tt entry: %pM (vid: %d, via %pM)\n",
+		   common->addr, BATADV_PRINT_VID(common->vid),
+		   orig_node->orig);
 	ret = true;
 
 out_remove:
@@ -1066,8 +1072,9 @@ batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 	if (best_entry) {
 		last_ttvn = atomic_read(&best_entry->orig_node->last_ttvn);
 		seq_printf(seq,
-			   " %c %pM  (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c]\n",
+			   " %c %pM %4i   (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c]\n",
 			   '*', tt_global_entry->common.addr,
+			   BATADV_PRINT_VID(tt_global_entry->common.vid),
 			   best_entry->ttvn, best_entry->orig_node->orig,
 			   last_ttvn, best_entry->orig_node->tt_crc,
 			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
@@ -1082,8 +1089,10 @@ batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 			continue;
 
 		last_ttvn = atomic_read(&orig_entry->orig_node->last_ttvn);
-		seq_printf(seq,	" %c %pM  (%3u) via %pM     (%3u)   [%c%c%c]\n",
+		seq_printf(seq,
+			   " %c %pM %4d   (%3u) via %pM     (%3u)   [%c%c%c]\n",
 			   '+', tt_global_entry->common.addr,
+			   BATADV_PRINT_VID(tt_global_entry->common.vid),
 			   orig_entry->ttvn, orig_entry->orig_node->orig,
 			   last_ttvn,
 			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
@@ -1110,9 +1119,9 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Globally announced TT entries received via the mesh %s\n",
 		   net_dev->name);
-	seq_printf(seq, "       %-13s %s       %-15s %s (%-10s) %s\n",
-		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "CRC",
-		   "Flags");
+	seq_printf(seq, "       %-13s  %s  %s       %-15s %s (%-10s) %s\n",
+		   "Client", "VID", "(TTVN)", "Originator", "(Curr TTVN)",
+		   "CRC", "Flags");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1159,15 +1168,18 @@ batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
 	struct hlist_head *head;
 	struct hlist_node *safe;
 	struct batadv_tt_orig_list_entry *orig_entry;
+	unsigned short vid;
 
 	spin_lock_bh(&tt_global_entry->list_lock);
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_safe(orig_entry, safe, head, list) {
 		if (orig_entry->orig_node == orig_node) {
+			vid = tt_global_entry->common.vid;
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Deleting %pM from global tt entry %pM: %s\n",
+				   "Deleting %pM from global tt entry %pM (vid: %d): %s\n",
 				   orig_node->orig,
-				   tt_global_entry->common.addr, message);
+				   tt_global_entry->common.addr,
+				   BATADV_PRINT_VID(vid), message);
 			hlist_del_rcu(&orig_entry->list);
 			batadv_tt_orig_list_entry_free_ref(orig_entry);
 		}
@@ -1292,6 +1304,7 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	struct hlist_node *safe;
 	struct hlist_head *head;
 	spinlock_t *list_lock; /* protects write access to the hash lists */
+	unsigned short vid;
 
 	if (!hash)
 		return;
@@ -1311,9 +1324,11 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 							orig_node, message);
 
 			if (hlist_empty(&tt_global->orig_list)) {
+				vid = tt_global->common.vid;
 				batadv_dbg(BATADV_DBG_TT, bat_priv,
-					   "Deleting global tt entry %pM: %s\n",
-					   tt_global->common.addr, message);
+					   "Deleting global tt entry %pM (vid: %d): %s\n",
+					   tt_global->common.addr,
+					   BATADV_PRINT_VID(vid), message);
 				hlist_del_rcu(&tt_common_entry->hash_entry);
 				batadv_tt_global_entry_free_ref(tt_global);
 			}
@@ -1371,8 +1386,10 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 				continue;
 
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Deleting global tt entry (%pM): %s\n",
-				   tt_global->common.addr, msg);
+				   "Deleting global tt entry %pM (vid: %d): %s\n",
+				   tt_global->common.addr,
+				   BATADV_PRINT_VID(tt_global->common.vid),
+				   msg);
 
 			hlist_del_rcu(&tt_common->hash_entry);
 
@@ -2356,8 +2373,8 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Sending ROAMING_ADV to %pM (client %pM)\n",
-		   orig_node->orig, client);
+		   "Sending ROAMING_ADV to %pM (client %pM, vid: %d)\n",
+		   orig_node->orig, client, BATADV_PRINT_VID(vid));
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_TX);
 
@@ -2470,8 +2487,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 				continue;
 
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Deleting local tt entry (%pM): pending\n",
-				   tt_common->addr);
+				   "Deleting local tt entry (%pM, vid: %d): pending\n",
+				   tt_common->addr,
+				   BATADV_PRINT_VID(tt_common->vid));
 
 			atomic_dec(&bat_priv->tt.local_entry_num);
 			hlist_del_rcu(&tt_common->hash_entry);
@@ -2684,7 +2702,7 @@ out:
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
 					  const unsigned char *addr,
-					  unsigned short vlan)
+					  unsigned short vid)
 {
 	bool ret = false;
 
@@ -2695,14 +2713,14 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
 		goto out;
 
-	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vlan,
+	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vid,
 				  BATADV_TT_CLIENT_TEMP,
 				  atomic_read(&orig_node->last_ttvn)))
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Added temporary global client (addr: %pM orig: %pM)\n",
-		   addr, orig_node->orig);
+		   "Added temporary global client (addr: %pM, vid: %d, orig: %pM)\n",
+		   addr, BATADV_PRINT_VID(vid), orig_node->orig);
 	ret = true;
 out:
 	return ret;
-- 
1.8.1.5

