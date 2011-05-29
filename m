Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 30 May 2011 01:05:16 +0200
Message-Id: <1306710316-28187-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: modify TT_RESPONSE-full-table
	format
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

In case of TT_REQUEST for a full table, the related TT_RESPONSE now
carries a set of tt_change structures instead of pure MACs.
This helps to keep the TT_RESPONSE format extensible. In particular, the
flag field can be used for later purposes.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   99 +++++++++++++++++++++++++--------------------------
 1 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index f04ab9b..3f30460 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1012,6 +1012,7 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 	struct neigh_node *neigh_node = NULL;
 	struct hard_iface *primary_if = NULL;
 	struct tt_global_entry *tt_global_entry;
+	struct tt_change *tt_change;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct hashtable_t *hash;
@@ -1086,14 +1087,14 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 		spin_unlock_bh(&req_dst_orig_node->tt_buff_lock);
 	} else {
 		tt_len = (uint16_t)atomic_read(&req_dst_orig_node->tt_size) *
-								ETH_ALEN;
+						sizeof(struct tt_change);
 		if (sizeof(struct tt_query_packet) + tt_len >
 						primary_if->soft_iface->mtu) {
 			tt_len = primary_if->soft_iface->mtu -
 						sizeof(struct tt_query_packet);
-			tt_len -= tt_len % ETH_ALEN;
+			tt_len -= tt_len % sizeof(struct tt_change);
 		}
-		tt_tot = tt_len / ETH_ALEN;
+		tt_tot = tt_len / sizeof(struct tt_change);
 
 		skb = dev_alloc_skb(sizeof(struct tt_query_packet) +
 				    tt_len + ETH_HLEN);
@@ -1106,7 +1107,8 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 		tt_response->ttvn = (uint8_t)
 			atomic_read(&req_dst_orig_node->last_ttvn);
 
-		tt_buff = skb->data + sizeof(struct tt_query_packet);
+		tt_change = (struct tt_change *)(skb->data +
+			  sizeof(struct tt_query_packet));
 		/* Fill the packet with the orig_node's local table */
 		hash = bat_priv->tt_global_hash;
 		tt_count = 0;
@@ -1120,10 +1122,13 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 					break;
 				if (tt_global_entry->orig_node ==
 				    req_dst_orig_node) {
-					memcpy(tt_buff + tt_count * ETH_ALEN,
+					memcpy(tt_change->addr,
 					       tt_global_entry->addr,
 					       ETH_ALEN);
+					tt_change->flags = TT_CHANGE_ADD;
+
 					tt_count++;
+					tt_change++;
 				}
 			}
 		}
@@ -1173,6 +1178,7 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
 	struct tt_local_entry *tt_local_entry;
+	struct tt_change *tt_change;
 	struct hard_iface *primary_if = NULL;
 	struct hlist_node *node;
 	struct hlist_head *head;
@@ -1238,14 +1244,14 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 		spin_unlock_bh(&bat_priv->tt_buff_lock);
 	} else {
 		tt_len = (uint16_t)atomic_read(&bat_priv->num_local_tt) *
-								ETH_ALEN;
+						sizeof(struct tt_change);
 		if (sizeof(struct tt_query_packet) + tt_len >
 				primary_if->soft_iface->mtu) {
 			tt_len = primary_if->soft_iface->mtu -
 				sizeof(struct tt_query_packet);
-			tt_len -= tt_len % ETH_ALEN;
+			tt_len -= tt_len % sizeof(struct tt_change);
 		}
-		tt_tot = tt_len / ETH_ALEN;
+		tt_tot = tt_len / sizeof(struct tt_change);
 
 		skb = dev_alloc_skb(sizeof(struct tt_query_packet) +
 				    tt_len + ETH_HLEN);
@@ -1255,7 +1261,8 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 		skb_reserve(skb, ETH_HLEN);
 		tt_response = (struct tt_query_packet *)skb_put(skb,
 				sizeof(struct tt_query_packet) + tt_len);
-		tt_buff = skb->data + sizeof(struct tt_query_packet);
+		tt_change = (struct tt_change *)(skb->data +
+			    sizeof(struct tt_query_packet));
 		/* Fill the packet with the local table */
 		tt_response->ttvn =
 			(uint8_t)atomic_read(&bat_priv->ttvn);
@@ -1270,10 +1277,12 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 					head, hash_entry) {
 				if (tt_count == tt_tot)
 					break;
-				memcpy(tt_buff + tt_count * ETH_ALEN,
-					tt_local_entry->addr,
-						ETH_ALEN);
+				memcpy(tt_change->addr, tt_local_entry->addr,
+				       ETH_ALEN);
+				tt_change->flags = TT_CHANGE_ADD;
+
 				tt_count++;
+				tt_change++;
 			}
 		}
 		rcu_read_unlock();
@@ -1323,23 +1332,30 @@ bool send_tt_response(struct bat_priv *bat_priv,
 		return send_other_tt_response(bat_priv, tt_request);
 }
 
-/* Substitute the TT response source's table with the newone carried by the
- * packet */
-static void _tt_fill_gtable(struct bat_priv *bat_priv,
-			    struct orig_node *orig_node, unsigned char *tt_buff,
-			    uint16_t table_size, uint8_t ttvn)
+static void _tt_update_changes(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node,
+			       struct tt_change *tt_change,
+			       uint16_t tt_num_changes, uint8_t ttvn)
 {
-	int count;
-	unsigned char *tt_ptr;
-
-	for (count = 0; count < table_size; count++) {
-		tt_ptr = tt_buff + (count * ETH_ALEN);
+	int i;
 
-		/* If we fail to allocate a new entry we return immediatly */
-		if (!tt_global_add(bat_priv, orig_node, tt_ptr, ttvn, false))
-			return;
+	for (i = 0; i < tt_num_changes; i++) {
+		if ((tt_change + i)->flags & TT_CHANGE_DEL)
+			tt_global_del(bat_priv, orig_node,
+				      (tt_change + i)->addr,
+				      "tt removed by changes",
+				      (tt_change + i)->flags & TT_CHANGE_ROAM);
+		else
+			if (!tt_global_add(bat_priv, orig_node,
+					   (tt_change + i)->addr, ttvn, false))
+				/* In case of problem while storing a
+				 * global_entry, we stop the updating
+				 * procedure without committing the
+				 * ttvn change. This will avoid to send
+				 * corrupted data on tt_request
+				 */
+				return;
 	}
-	atomic_set(&orig_node->last_ttvn, ttvn);
 }
 
 static void tt_fill_gtable(struct bat_priv *bat_priv,
@@ -1354,11 +1370,9 @@ static void tt_fill_gtable(struct bat_priv *bat_priv,
 	/* Purge the old table first.. */
 	tt_global_del_orig(bat_priv, orig_node, "Received full table");
 
-	_tt_fill_gtable(bat_priv, orig_node,
-		((unsigned char *)tt_response) +
-		sizeof(struct tt_query_packet),
-		tt_response->tt_data,
-		tt_response->ttvn);
+	_tt_update_changes(bat_priv, orig_node,
+			   (struct tt_change *)(tt_response + 1),
+			   tt_response->tt_data, tt_response->ttvn);
 
 	spin_lock_bh(&orig_node->tt_buff_lock);
 	kfree(orig_node->tt_buff);
@@ -1366,6 +1380,8 @@ static void tt_fill_gtable(struct bat_priv *bat_priv,
 	orig_node->tt_buff = NULL;
 	spin_unlock_bh(&orig_node->tt_buff_lock);
 
+	atomic_set(&orig_node->last_ttvn, tt_response->ttvn);
+
 out:
 	if (orig_node)
 		orig_node_free_ref(orig_node);
@@ -1375,25 +1391,8 @@ void tt_update_changes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		       uint16_t tt_num_changes, uint8_t ttvn,
 		       struct tt_change *tt_change)
 {
-	int i;
-
-	for (i = 0; i < tt_num_changes; i++) {
-		if ((tt_change + i)->flags & TT_CHANGE_DEL)
-			tt_global_del(bat_priv, orig_node,
-				      (tt_change + i)->addr,
-				      "tt removed by changes",
-				      (tt_change + i)->flags & TT_CHANGE_ROAM);
-		else
-			if (!tt_global_add(bat_priv, orig_node,
-					   (tt_change + i)->addr, ttvn, false))
-				/* In case of problem while storing a
-				 * global_entry, we stop the updating
-				 * procedure without committing the
-				 * ttvn change. This will avoid to send
-				 * corrupted data on tt_request
-				 */
-				return;
-	}
+	_tt_update_changes(bat_priv, orig_node, tt_change, tt_num_changes,
+			   ttvn);
 
 	tt_save_orig_buffer(bat_priv, orig_node, (unsigned char *)tt_change,
 			    tt_num_changes);
-- 
1.7.3.4

