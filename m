Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 30 May 2011 15:46:57 +0200
Message-Id: <1306763217-27752-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1306710316-28187-1-git-send-email-ordex@autistici.org>
References: <1306710316-28187-1-git-send-email-ordex@autistici.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Antonio Quartulli <ordex@autistici.org>

In case of TT_REQUEST for a full table, the related TT_RESPONSE now
carries a set of tt_change structures instead of pure MACs.
This helps to keep the TT_RESPONSE format extensible. In particular, the
flag field can be used for later purposes.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
Merged full table write into a single function.

 translation-table.c |  278 +++++++++++++++++++++++++--------------------------
 1 files changed, 135 insertions(+), 143 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index f04ab9b..8a5df7a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -493,7 +493,7 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
 }
 
-/* caller must hold orig_node recount */
+/* caller must hold orig_node refcount */
 int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming)
 {
@@ -938,6 +938,76 @@ unlock:
 	return tt_req_node;
 }
 
+static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
+{
+	const struct tt_global_entry *tt_global_entry = entry_ptr;
+	const struct orig_node *orig_node = data_ptr;
+
+	return (tt_global_entry->orig_node == orig_node);
+}
+
+static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
+					      struct hashtable_t *hash,
+					      struct hard_iface *primary_if,
+					      int (*valid_cb)(const void *,
+							      const void *),
+					      void *cb_data)
+{
+	struct tt_local_entry *tt_local_entry;
+	struct tt_query_packet *tt_response;
+	struct tt_change *tt_change;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct sk_buff *skb = NULL;
+	uint16_t tt_tot, tt_count;
+	ssize_t tt_query_size = sizeof(struct tt_query_packet);
+	int i;
+
+	if (sizeof(struct tt_query_packet) + tt_len >
+						primary_if->soft_iface->mtu) {
+		tt_len = primary_if->soft_iface->mtu - tt_query_size;
+		tt_len -= tt_len % sizeof(struct tt_change);
+	}
+	tt_tot = tt_len / sizeof(struct tt_change);
+
+	skb = dev_alloc_skb(tt_query_size + tt_len + ETH_HLEN);
+	if (!skb)
+		goto out;
+
+	skb_reserve(skb, ETH_HLEN);
+	tt_response = (struct tt_query_packet *)skb_put(skb,
+						     tt_query_size + tt_len);
+	tt_response->ttvn = ttvn;
+	tt_response->tt_data = htons(tt_tot);
+
+	tt_change = (struct tt_change *)(skb->data + tt_query_size);
+	tt_count = 0;
+
+	rcu_read_lock();
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		hlist_for_each_entry_rcu(tt_local_entry, node,
+					 head, hash_entry) {
+			if (tt_count == tt_tot)
+				break;
+
+			if ((valid_cb) && (!valid_cb(tt_local_entry, cb_data)))
+				continue;
+
+			memcpy(tt_change->addr, tt_local_entry->addr, ETH_ALEN);
+			tt_change->flags = TT_CHANGE_ADD;
+
+			tt_count++;
+			tt_change++;
+		}
+	}
+	rcu_read_unlock();
+
+out:
+	return skb;
+}
+
 int send_tt_request(struct bat_priv *bat_priv, struct orig_node *dst_orig_node,
 		    uint8_t ttvn, uint16_t tt_crc, bool full_table)
 {
@@ -1006,20 +1076,16 @@ out:
 }
 
 static bool send_other_tt_response(struct bat_priv *bat_priv,
-				  struct tt_query_packet *tt_request)
+				   struct tt_query_packet *tt_request)
 {
 	struct orig_node *req_dst_orig_node = NULL, *res_dst_orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
 	struct hard_iface *primary_if = NULL;
-	struct tt_global_entry *tt_global_entry;
-	struct hlist_node *node;
-	struct hlist_head *head;
-	struct hashtable_t *hash;
-	uint8_t orig_ttvn, req_ttvn;
-	int i, ret = false;
+	uint8_t orig_ttvn, req_ttvn, ttvn;
+	int ret = false;
 	unsigned char *tt_buff;
 	bool full_table;
-	uint16_t tt_len, tt_tot, tt_count;
+	uint16_t tt_len, tt_tot;
 	struct sk_buff *skb = NULL;
 	struct tt_query_packet *tt_response;
 
@@ -1077,6 +1143,7 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 		tt_response = (struct tt_query_packet *)skb_put(skb,
 				sizeof(struct tt_query_packet) + tt_len);
 		tt_response->ttvn = req_ttvn;
+		tt_response->tt_data = htons(tt_tot);
 
 		tt_buff = skb->data + sizeof(struct tt_query_packet);
 		/* Copy the last orig_node's OGM buffer */
@@ -1086,48 +1153,17 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 		spin_unlock_bh(&req_dst_orig_node->tt_buff_lock);
 	} else {
 		tt_len = (uint16_t)atomic_read(&req_dst_orig_node->tt_size) *
-								ETH_ALEN;
-		if (sizeof(struct tt_query_packet) + tt_len >
-						primary_if->soft_iface->mtu) {
-			tt_len = primary_if->soft_iface->mtu -
-						sizeof(struct tt_query_packet);
-			tt_len -= tt_len % ETH_ALEN;
-		}
-		tt_tot = tt_len / ETH_ALEN;
+						sizeof(struct tt_change);
+		ttvn = (uint8_t)atomic_read(&req_dst_orig_node->last_ttvn);
 
-		skb = dev_alloc_skb(sizeof(struct tt_query_packet) +
-				    tt_len + ETH_HLEN);
+		skb = tt_response_fill_table(tt_len, ttvn,
+					     bat_priv->tt_global_hash,
+					     primary_if, tt_global_valid_entry,
+					     req_dst_orig_node);
 		if (!skb)
 			goto out;
 
-		skb_reserve(skb, ETH_HLEN);
-		tt_response = (struct tt_query_packet *)skb_put(skb,
-				sizeof(struct tt_query_packet) + tt_len);
-		tt_response->ttvn = (uint8_t)
-			atomic_read(&req_dst_orig_node->last_ttvn);
-
-		tt_buff = skb->data + sizeof(struct tt_query_packet);
-		/* Fill the packet with the orig_node's local table */
-		hash = bat_priv->tt_global_hash;
-		tt_count = 0;
-		rcu_read_lock();
-		for (i = 0; i < hash->size; i++) {
-			head = &hash->table[i];
-
-			hlist_for_each_entry_rcu(tt_global_entry, node,
-					head, hash_entry) {
-				if (tt_count == tt_tot)
-					break;
-				if (tt_global_entry->orig_node ==
-				    req_dst_orig_node) {
-					memcpy(tt_buff + tt_count * ETH_ALEN,
-					       tt_global_entry->addr,
-					       ETH_ALEN);
-					tt_count++;
-				}
-			}
-		}
-		rcu_read_unlock();
+		tt_response = (struct tt_query_packet *)skb->data;
 	}
 
 	tt_response->packet_type = BAT_TT_QUERY;
@@ -1135,7 +1171,6 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 	tt_response->ttl = TTL;
 	memcpy(tt_response->src, req_dst_orig_node->orig, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
-	tt_response->tt_data = htons(tt_tot);
 	tt_response->flags = TT_RESPONSE;
 
 	if (full_table)
@@ -1168,20 +1203,16 @@ out:
 
 }
 static bool send_my_tt_response(struct bat_priv *bat_priv,
-			       struct tt_query_packet *tt_request)
+				struct tt_query_packet *tt_request)
 {
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
-	struct tt_local_entry *tt_local_entry;
 	struct hard_iface *primary_if = NULL;
-	struct hlist_node *node;
-	struct hlist_head *head;
-	struct hashtable_t *hash;
-	uint8_t my_ttvn, req_ttvn;
-	int i, ret = false;
+	uint8_t my_ttvn, req_ttvn, ttvn;
+	int ret = false;
 	unsigned char *tt_buff;
 	bool full_table;
-	uint16_t tt_len, tt_tot, tt_count;
+	uint16_t tt_len, tt_tot;
 	struct sk_buff *skb = NULL;
 	struct tt_query_packet *tt_response;
 
@@ -1231,6 +1262,7 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 		tt_response = (struct tt_query_packet *)skb_put(skb,
 				sizeof(struct tt_query_packet) + tt_len);
 		tt_response->ttvn = req_ttvn;
+		tt_response->tt_data = htons(tt_tot);
 
 		tt_buff = skb->data + sizeof(struct tt_query_packet);
 		memcpy(tt_buff, bat_priv->tt_buff,
@@ -1238,45 +1270,16 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 		spin_unlock_bh(&bat_priv->tt_buff_lock);
 	} else {
 		tt_len = (uint16_t)atomic_read(&bat_priv->num_local_tt) *
-								ETH_ALEN;
-		if (sizeof(struct tt_query_packet) + tt_len >
-				primary_if->soft_iface->mtu) {
-			tt_len = primary_if->soft_iface->mtu -
-				sizeof(struct tt_query_packet);
-			tt_len -= tt_len % ETH_ALEN;
-		}
-		tt_tot = tt_len / ETH_ALEN;
+						sizeof(struct tt_change);
+		ttvn = (uint8_t)atomic_read(&bat_priv->ttvn);
 
-		skb = dev_alloc_skb(sizeof(struct tt_query_packet) +
-				    tt_len + ETH_HLEN);
+		skb = tt_response_fill_table(tt_len, ttvn,
+					     bat_priv->tt_local_hash,
+					     primary_if, NULL, NULL);
 		if (!skb)
 			goto out;
 
-		skb_reserve(skb, ETH_HLEN);
-		tt_response = (struct tt_query_packet *)skb_put(skb,
-				sizeof(struct tt_query_packet) + tt_len);
-		tt_buff = skb->data + sizeof(struct tt_query_packet);
-		/* Fill the packet with the local table */
-		tt_response->ttvn =
-			(uint8_t)atomic_read(&bat_priv->ttvn);
-
-		hash = bat_priv->tt_local_hash;
-		tt_count = 0;
-		rcu_read_lock();
-		for (i = 0; i < hash->size; i++) {
-			head = &hash->table[i];
-
-			hlist_for_each_entry_rcu(tt_local_entry, node,
-					head, hash_entry) {
-				if (tt_count == tt_tot)
-					break;
-				memcpy(tt_buff + tt_count * ETH_ALEN,
-					tt_local_entry->addr,
-						ETH_ALEN);
-				tt_count++;
-			}
-		}
-		rcu_read_unlock();
+		tt_response = (struct tt_query_packet *)skb->data;
 	}
 
 	tt_response->packet_type = BAT_TT_QUERY;
@@ -1284,7 +1287,6 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 	tt_response->ttl = TTL;
 	memcpy(tt_response->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
-	tt_response->tt_data = htons(tt_tot);
 	tt_response->flags = TT_RESPONSE;
 
 	if (full_table)
@@ -1323,57 +1325,10 @@ bool send_tt_response(struct bat_priv *bat_priv,
 		return send_other_tt_response(bat_priv, tt_request);
 }
 
-/* Substitute the TT response source's table with the newone carried by the
- * packet */
-static void _tt_fill_gtable(struct bat_priv *bat_priv,
-			    struct orig_node *orig_node, unsigned char *tt_buff,
-			    uint16_t table_size, uint8_t ttvn)
-{
-	int count;
-	unsigned char *tt_ptr;
-
-	for (count = 0; count < table_size; count++) {
-		tt_ptr = tt_buff + (count * ETH_ALEN);
-
-		/* If we fail to allocate a new entry we return immediatly */
-		if (!tt_global_add(bat_priv, orig_node, tt_ptr, ttvn, false))
-			return;
-	}
-	atomic_set(&orig_node->last_ttvn, ttvn);
-}
-
-static void tt_fill_gtable(struct bat_priv *bat_priv,
-			   struct tt_query_packet *tt_response)
-{
-	struct orig_node *orig_node = NULL;
-
-	orig_node = orig_hash_find(bat_priv, tt_response->src);
-	if (!orig_node)
-		goto out;
-
-	/* Purge the old table first.. */
-	tt_global_del_orig(bat_priv, orig_node, "Received full table");
-
-	_tt_fill_gtable(bat_priv, orig_node,
-		((unsigned char *)tt_response) +
-		sizeof(struct tt_query_packet),
-		tt_response->tt_data,
-		tt_response->ttvn);
-
-	spin_lock_bh(&orig_node->tt_buff_lock);
-	kfree(orig_node->tt_buff);
-	orig_node->tt_buff_len = 0;
-	orig_node->tt_buff = NULL;
-	spin_unlock_bh(&orig_node->tt_buff_lock);
-
-out:
-	if (orig_node)
-		orig_node_free_ref(orig_node);
-}
-
-void tt_update_changes(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		       uint16_t tt_num_changes, uint8_t ttvn,
-		       struct tt_change *tt_change)
+static void _tt_update_changes(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node,
+			       struct tt_change *tt_change,
+			       uint16_t tt_num_changes, uint8_t ttvn)
 {
 	int i;
 
@@ -1394,6 +1349,43 @@ void tt_update_changes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 				 */
 				return;
 	}
+}
+
+static void tt_fill_gtable(struct bat_priv *bat_priv,
+			   struct tt_query_packet *tt_response)
+{
+	struct orig_node *orig_node = NULL;
+
+	orig_node = orig_hash_find(bat_priv, tt_response->src);
+	if (!orig_node)
+		goto out;
+
+	/* Purge the old table first.. */
+	tt_global_del_orig(bat_priv, orig_node, "Received full table");
+
+	_tt_update_changes(bat_priv, orig_node,
+			   (struct tt_change *)(tt_response + 1),
+			   tt_response->tt_data, tt_response->ttvn);
+
+	spin_lock_bh(&orig_node->tt_buff_lock);
+	kfree(orig_node->tt_buff);
+	orig_node->tt_buff_len = 0;
+	orig_node->tt_buff = NULL;
+	spin_unlock_bh(&orig_node->tt_buff_lock);
+
+	atomic_set(&orig_node->last_ttvn, tt_response->ttvn);
+
+out:
+	if (orig_node)
+		orig_node_free_ref(orig_node);
+}
+
+void tt_update_changes(struct bat_priv *bat_priv, struct orig_node *orig_node,
+		       uint16_t tt_num_changes, uint8_t ttvn,
+		       struct tt_change *tt_change)
+{
+	_tt_update_changes(bat_priv, orig_node, tt_change, tt_num_changes,
+			   ttvn);
 
 	tt_save_orig_buffer(bat_priv, orig_node, (unsigned char *)tt_change,
 			    tt_num_changes);
-- 
1.7.2.3

