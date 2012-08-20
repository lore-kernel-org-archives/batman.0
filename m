Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon, 20 Aug 2012 13:48:12 +0200
Message-Id: <1345463292-19712-6-git-send-email-martin@hundeboll.net>
In-Reply-To: <1345463292-19712-1-git-send-email-martin@hundeboll.net>
References: <1345463292-19712-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 5/5] batman-adv: Limit local translation table
	max packet size
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

The size of the local translation table should not increase the maximum
packet size, which is determined by the lowest MTU of hard interfaces
and the maximum number of fragments.

This patch adds a check before adding new entries to the table and a new
check to remove entries if the MTU decreases.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 fragmentation.h     |  22 +++++++
 hard-interface.c    |  26 +++++---
 soft-interface.c    |   8 ++-
 translation-table.c | 186 +++++++++++++++++++++++++++++++++++++++++++---------
 translation-table.h |   3 +-
 types.h             |   3 +
 6 files changed, 205 insertions(+), 43 deletions(-)

diff --git a/fragmentation.h b/fragmentation.h
index ed85d97..0b95008 100644
--- a/fragmentation.h
+++ b/fragmentation.h
@@ -31,4 +31,26 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 			     struct batadv_orig_node *orig_node,
 			     struct batadv_neigh_node *neigh_node);
 
+/**
+ * batadv_frag_max_packet_size() - Get maximum packet size with fragmentation.
+ * @bat_priv: Batman-adv private data.
+ *
+ * Returns the maximum size of one unicast packet if fragmentation is disabled
+ * or maximum size of one fragmented packet if fragmentation is enabled.
+ */
+static inline int batadv_frag_max_packet_size(struct batadv_priv *bat_priv)
+{
+	int mtu = atomic_read(&bat_priv->min_mtu);
+
+	/* Return mtu for one packet if fragmentation is disabled. */
+	if (!atomic_read(&bat_priv->fragmentation))
+		return mtu - ETH_HLEN;
+
+	/* Determine max size with multiple fragments */
+	mtu = min_t(int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
+	mtu -= sizeof(struct batadv_frag_packet);
+	mtu -= ETH_HLEN;
+	return mtu*BATADV_FRAG_MAX_FRAGMENTS;
+}
+
 #endif /* _NET_BATMAN_ADV_FRAGMENTATION_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index d112fd6..80b9465 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -180,16 +180,11 @@ static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 
 int batadv_hardif_min_mtu(struct net_device *soft_iface)
 {
-	const struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	const struct batadv_hard_iface *hard_iface;
-	/* allow big frames if all devices are capable to do so
-	 * (have MTU > 1500 + BAT_HEADER_LEN)
-	 */
 	int min_mtu = ETH_DATA_LEN;
 
-	if (atomic_read(&bat_priv->fragmentation))
-		goto out;
-
+	/* Check if any interface has lower MTU than the current minimum MTU. */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if ((hard_iface->if_status != BATADV_IF_ACTIVE) &&
@@ -204,8 +199,16 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 				min_mtu);
 	}
 	rcu_read_unlock();
-out:
-	return min_mtu;
+
+	/* Update current minimum MTU. */
+	atomic_set(&bat_priv->min_mtu, min_mtu);
+
+	if (atomic_read(&bat_priv->fragmentation))
+		/* Allow big frames if fragmentation is enabled. */
+		return ETH_DATA_LEN;
+	else
+		/* Limit frame size if fragmentation is disabled. */
+		return min_mtu;
 }
 
 /* adjusts the MTU if a new interface with a smaller MTU appeared. */
@@ -216,6 +219,11 @@ void batadv_update_min_mtu(struct net_device *soft_iface)
 	min_mtu = batadv_hardif_min_mtu(soft_iface);
 	if (soft_iface->mtu != min_mtu)
 		soft_iface->mtu = min_mtu;
+
+	/* Check if the local translate table should be cleaned up to match a
+	 * new (and smaller) MTU.
+	 */
+	batadv_tt_check_mtu(soft_iface);
 }
 
 static void
diff --git a/soft-interface.c b/soft-interface.c
index c21f1fc..4a9dfbd 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -171,8 +171,10 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_bla_tx(bat_priv, skb, vid))
 		goto dropped;
 
-	/* Register the client MAC in the transtable */
-	batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
+	/* Register the client MAC in the transtable. Drop packet if the entry
+	 * wasn't added. */
+	if (!batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif))
+		goto dropped;
 
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
@@ -422,12 +424,14 @@ struct net_device *batadv_softif_create(const char *name)
 	atomic_set(&bat_priv->fragmentation, 1);
 	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
+	atomic_set(&bat_priv->min_mtu, ETH_DATA_LEN);
 
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 	atomic_set(&bat_priv->bcast_seqno, 1);
 	atomic_set(&bat_priv->tt.vn, 0);
 	atomic_set(&bat_priv->tt.local_changes, 0);
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
+	atomic_set(&bat_priv->tt.reduced_table, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
 #endif
diff --git a/translation-table.c b/translation-table.c
index 2cee8b2..2b6c42b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -26,6 +26,7 @@
 #include "originator.h"
 #include "routing.h"
 #include "bridge_loop_avoidance.h"
+#include "fragmentation.h"
 
 #include <linux/crc16.h>
 
@@ -237,7 +238,7 @@ static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
-void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
+bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 			 int ifindex)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
@@ -246,7 +247,8 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct batadv_tt_orig_list_entry *orig_entry;
-	int hash_added;
+	int hash_added, size = sizeof(struct batadv_tt_query_packet);
+	bool ret = false;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
 
@@ -254,6 +256,19 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local_entry->last_seen = jiffies;
 		/* possibly unset the BATADV_TT_CLIENT_PENDING flag */
 		tt_local_entry->common.flags &= ~BATADV_TT_CLIENT_PENDING;
+		ret = true;
+		goto out;
+	}
+
+	/* Ignore it if we cannot send it in a full table response. */
+	size += batadv_tt_len(atomic_read(&bat_priv->tt.local_entry_num) + 1);
+	if (size > batadv_frag_max_packet_size(bat_priv)) {
+		if (!net_ratelimit())
+			goto out;
+
+		batadv_info(soft_iface,
+			    "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
+			    size, batadv_frag_max_packet_size(bat_priv), addr);
 		goto out;
 	}
 
@@ -318,11 +333,16 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_global_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
 		tt_global_entry->roam_at = jiffies;
 	}
+
+	ret = true;
+
 out:
 	if (tt_local_entry)
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
+
+	return ret;
 }
 
 static void batadv_tt_realloc_packet_buff(unsigned char **packet_buff,
@@ -520,8 +540,9 @@ out:
 		batadv_tt_local_entry_free_ref(tt_local_entry);
 }
 
-static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
-				       struct hlist_head *head)
+static void
+batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
+			   struct hlist_head *head)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct batadv_tt_common_entry *tt_common_entry;
@@ -544,7 +565,8 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 			continue;
 
 		batadv_tt_local_set_pending(bat_priv, tt_local_entry,
-					    BATADV_TT_CLIENT_DEL, "timed out");
+					    BATADV_TT_CLIENT_DEL,
+					    "timed out");
 	}
 }
 
@@ -1448,7 +1470,6 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 static struct sk_buff *
 batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 			      struct batadv_hashtable *hash,
-			      struct batadv_hard_iface *primary_if,
 			      int (*valid_cb)(const void *, const void *),
 			      void *cb_data)
 {
@@ -1458,17 +1479,11 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct sk_buff *skb = NULL;
-	uint16_t tt_tot, tt_count;
+	uint16_t tt_count = 0;
 	ssize_t tt_query_size = sizeof(struct batadv_tt_query_packet);
 	uint32_t i;
 	size_t len;
 
-	if (tt_query_size + tt_len > primary_if->soft_iface->mtu) {
-		tt_len = primary_if->soft_iface->mtu - tt_query_size;
-		tt_len -= tt_len % sizeof(struct batadv_tt_change);
-	}
-	tt_tot = tt_len / sizeof(struct batadv_tt_change);
-
 	len = tt_query_size + tt_len;
 	skb = dev_alloc_skb(len + ETH_HLEN);
 	if (!skb)
@@ -1479,7 +1494,6 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	tt_response->ttvn = ttvn;
 
 	tt_change = (struct batadv_tt_change *)(skb->data + tt_query_size);
-	tt_count = 0;
 
 	rcu_read_lock();
 	for (i = 0; i < hash->size; i++) {
@@ -1487,9 +1501,6 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 
 		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
-			if (tt_count == tt_tot)
-				break;
-
 			if ((valid_cb) && (!valid_cb(tt_common_entry, cb_data)))
 				continue;
 
@@ -1582,9 +1593,9 @@ static bool
 batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 			      struct batadv_tt_query_packet *tt_request)
 {
+	struct batadv_hard_iface *iface;
 	struct batadv_orig_node *req_dst_orig_node = NULL;
 	struct batadv_orig_node *res_dst_orig_node = NULL;
-	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t orig_ttvn, req_ttvn, ttvn;
 	int ret = false;
 	unsigned char *tt_buff;
@@ -1609,8 +1620,8 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if)
+	iface = batadv_primary_if_get_selected(bat_priv);
+	if (!iface)
 		goto out;
 
 	orig_ttvn = (uint8_t)atomic_read(&req_dst_orig_node->last_ttvn);
@@ -1658,9 +1669,20 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		tt_len *= sizeof(struct batadv_tt_change);
 		ttvn = (uint8_t)atomic_read(&req_dst_orig_node->last_ttvn);
 
+		/* Don't send the response, if larger than fragmented packet. */
+		len = sizeof(*tt_response) + tt_len;
+		if (len > batadv_frag_max_packet_size(bat_priv)) {
+			if (!net_ratelimit())
+				goto out;
+
+			batadv_info(iface->soft_iface,
+				    "Ignoring TT_REQUEST from %pM; Response size exceeds max packet size.\n",
+				    res_dst_orig_node->orig);
+			goto out;
+		}
+
 		skb = batadv_tt_response_fill_table(tt_len, ttvn,
 						    bat_priv->tt.global_hash,
-						    primary_if,
 						    batadv_tt_global_valid,
 						    req_dst_orig_node);
 		if (!skb)
@@ -1697,8 +1719,6 @@ out:
 		batadv_orig_node_free_ref(res_dst_orig_node);
 	if (req_dst_orig_node)
 		batadv_orig_node_free_ref(req_dst_orig_node);
-	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
 	if (!ret)
 		kfree_skb(skb);
 	return ret;
@@ -1775,9 +1795,14 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 		tt_len *= sizeof(struct batadv_tt_change);
 		ttvn = (uint8_t)atomic_read(&bat_priv->tt.vn);
 
+		/* If we have an inconsistent table due to reduced MTU, we
+		 * increase ttvn temporarily.
+		 * */
+		if (atomic_read(&bat_priv->tt.reduced_table))
+			ttvn++;
+
 		skb = batadv_tt_response_fill_table(tt_len, ttvn,
 						    bat_priv->tt.local_hash,
-						    primary_if,
 						    batadv_tt_local_valid_entry,
 						    NULL);
 		if (!skb)
@@ -2195,8 +2220,73 @@ out:
 	return changed_num;
 }
 
+/**
+ * batadv_tt_local_test_pending() - Callback to test pending flag of an entry.
+ * @bat_priv: Batman-adv private data.
+ * @entry: Local entry to be deleted.
+ * @data: Not used
+ *
+ * This callback is made to be passed as a purge function to
+ * batadv_tt_local_purge_pending(), where it is called with every entry. It
+ * checks if the entry is flagged as pending and frees it if so.
+ */
+static int batadv_tt_local_test_pending(struct batadv_priv *bat_priv,
+					void *entry, void *data)
+{
+	struct batadv_tt_common_entry *tt_common_entry = entry;
+
+	if (!(tt_common_entry->flags & BATADV_TT_CLIENT_PENDING))
+		return 0;
+
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
+		   "Deleting local tt entry (%pM): pending\n",
+		   tt_common_entry->addr);
+
+	return 1;
+}
+
+/**
+ * batadv_tt_local_test_timeout() - Callback to test timeout of an entry.
+ * @bat_priv: Batman-adv private data.
+ * @entry: Local entry to be deleted.
+ * @data: Pointer to timeout in milliseconds to check the entry with.
+ *
+ * This callback is made to be passed as a purge function to
+ * batadv_tt_local_purge_pending(), where it is called with every entry. It
+ * checks if the entry is timed out and frees it immediately, instead of
+ * flagging it as pending, and then adds the removal to the changeset.
+ */
+static int batadv_tt_local_test_timeout(struct batadv_priv *bat_priv,
+					void *entry, void *data)
+{
+	struct batadv_tt_common_entry *tt_common_entry = entry;
+	struct batadv_tt_local_entry *tt_local_entry;
+	int *timeout = data;
+
+	if (tt_common_entry->flags & BATADV_TT_CLIENT_PENDING)
+		return 0;
+
+	tt_local_entry = container_of(tt_common_entry,
+				      struct batadv_tt_local_entry, common);
+
+	if (!batadv_has_timed_out(tt_local_entry->last_seen, *timeout))
+		return 0;
+
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
+		   "Deleting local tt entry (%pM): forced\n",
+		   tt_common_entry->addr);
+
+	batadv_tt_local_event(bat_priv, tt_local_entry->common.addr,
+			      BATADV_TT_CLIENT_DEL);
+
+	return 1;
+}
+
 /* Purge out all the tt local entries marked with BATADV_TT_CLIENT_PENDING */
-static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
+static void batadv_tt_local_purge_pending(struct batadv_priv *bat_priv,
+					  int (test)(struct batadv_priv *,
+						     void *, void *),
+					  void *data)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
@@ -2216,13 +2306,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common, node, node_tmp, head,
 					  hash_entry) {
-			if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING))
+			if (!test(bat_priv, tt_common, data))
 				continue;
 
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Deleting local tt entry (%pM): pending\n",
-				   tt_common->addr);
-
 			atomic_dec(&bat_priv->tt.local_entry_num);
 			hlist_del_rcu(node);
 			tt_local = container_of(tt_common,
@@ -2249,11 +2335,13 @@ static int batadv_tt_commit_changes(struct batadv_priv *bat_priv,
 
 	/* all reset entries have to be counted as local entries */
 	atomic_add(changed_num, &bat_priv->tt.local_entry_num);
-	batadv_tt_local_purge_pending_clients(bat_priv);
+	batadv_tt_local_purge_pending(bat_priv,
+				      batadv_tt_local_test_pending, NULL);
 	bat_priv->tt.local_crc = batadv_tt_local_crc(bat_priv);
 
 	/* Increment the TTVN only once per OGM interval */
 	atomic_inc(&bat_priv->tt.vn);
+	atomic_set(&bat_priv->tt.reduced_table, 0);
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local changes committed, updating to ttvn %u\n",
 		   (uint8_t)atomic_read(&bat_priv->tt.vn));
@@ -2430,3 +2518,39 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 out:
 	return ret;
 }
+
+/**
+ * batadv_tt_check_mtu() - Make local table fit a fragmented packet.
+ * @bat_priv: Private data
+ * @mtu: Lowest MTU of local interfaces.
+ *
+ * Remove entries older than 'timeout' and half timeout if more entries needs
+ * to be removed.
+ */
+void batadv_tt_check_mtu(struct net_device *soft_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	int max_size = batadv_frag_max_packet_size(bat_priv);
+	int num = atomic_read(&bat_priv->tt.local_entry_num);
+	int hdr_size = sizeof(struct batadv_tt_query_packet);
+	int table_size = hdr_size + batadv_tt_len(num);
+	int timeout = BATADV_TT_LOCAL_TIMEOUT/2;
+
+	while (table_size > max_size) {
+		batadv_tt_local_purge_pending(bat_priv,
+					      batadv_tt_local_test_timeout,
+					      &timeout);
+
+		num = atomic_read(&bat_priv->tt.local_entry_num);
+		table_size = hdr_size + batadv_tt_len(num);
+		timeout /= 2;
+		atomic_set(&bat_priv->tt.reduced_table, 1);
+
+		if (!net_ratelimit())
+			continue;
+
+		batadv_info(soft_iface,
+			    "Forced to purge local tt entries to fit new fragment MTU (%i)\n",
+			    max_size);
+	}
+}
diff --git a/translation-table.h b/translation-table.h
index 811fffd..380ad86 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -22,7 +22,7 @@
 
 int batadv_tt_len(int changes_num);
 int batadv_tt_init(struct batadv_priv *bat_priv);
-void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
+bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 			 int ifindex);
 void batadv_tt_local_remove(struct batadv_priv *bat_priv,
 			    const uint8_t *addr, const char *message,
@@ -62,5 +62,6 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
 					  const unsigned char *addr);
+void batadv_tt_check_mtu(struct net_device *soft_iface);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index 0450b57..fa17288 100644
--- a/types.h
+++ b/types.h
@@ -211,6 +211,7 @@ enum batadv_counters {
  * @changes_list: tracks tt local changes within an originator interval
  * @req_list: list of pending tt_requests
  * @local_crc: Checksum of the local table, recomputed before sending a new OGM
+ * @reduced_table: Flag to make own tt_responses carry an increased ttvn.
  */
 struct batadv_priv_tt {
 	atomic_t vn;
@@ -231,6 +232,7 @@ struct batadv_priv_tt {
 	int16_t last_changeset_len;
 	spinlock_t last_changeset_lock; /* protects last_changeset */
 	struct delayed_work work;
+	atomic_t reduced_table;
 };
 
 #ifdef CONFIG_BATMAN_ADV_BLA
@@ -281,6 +283,7 @@ struct batadv_priv {
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
+	atomic_t min_mtu;
 	char num_ifaces;
 	struct batadv_debug_log *debug_log;
 	struct kobject *mesh_obj;
-- 
1.7.11.5

