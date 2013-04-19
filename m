Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 19 Apr 2013 14:54:43 +0200
Message-Id: <1366376083-4452-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: use CRC32C instead of CRC16 in
	TT code
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
Cc: Antonio Quartulli <ordex@autistici.org>

CRC32C has to be preferred to CRC16 because of its possible
HW native support and because of its less likely probability
of collision. With this change the Translation Table
component now uses CRC32C to compute the Local and Global
Table checksum.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v3:
- added kernel doc

 packet.h            |  4 +--
 translation-table.c | 71 ++++++++++++++++++++++++++++-------------------------
 types.h             |  4 +--
 3 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/packet.h b/packet.h
index 27424e1..e24daa6 100644
--- a/packet.h
+++ b/packet.h
@@ -360,12 +360,12 @@ struct batadv_tvlv_long {
  * struct tvlv_tt_data - tt data propagated through the tt tvlv container
  * @flags: translation table flags (see batadv_tt_data_flags)
  * @ttvn: translation table version number
- * @crc: crc16 checksum of the local translation table
+ * @crc: crc32 checksum of the local translation table
  */
 struct batadv_tvlv_tt_data {
 	uint8_t flags;
 	uint8_t ttvn;
-	__be16  crc;
+	__be32  crc;
 };
 
 /**
diff --git a/translation-table.c b/translation-table.c
index 76aef1a..5545f55 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -27,7 +27,7 @@
 #include "routing.h"
 #include "bridge_loop_avoidance.h"
 
-#include <linux/crc16.h>
+#include <linux/crc32c.h>
 
 /* hash class keys */
 static struct lock_class_key batadv_tt_local_hash_lock_class_key;
@@ -409,7 +409,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 
 	tt_data->flags = BATADV_TT_OGM_DIFF;
 	tt_data->ttvn = atomic_read(&bat_priv->tt.vn);
-	tt_data->crc = htons(bat_priv->tt.local_crc);
+	tt_data->crc = htonl(bat_priv->tt.local_crc);
 
 	if (tt_diff_len == 0)
 		goto container_register;
@@ -481,7 +481,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq,
-		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u CRC: %#.4x):\n",
+		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u CRC: %#.8x):\n",
 		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn),
 		   bat_priv->tt.local_crc);
 	seq_printf(seq, "       %-13s %-7s %-10s\n", "Client", "Flags",
@@ -978,7 +978,7 @@ batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 	if (best_entry) {
 		last_ttvn = atomic_read(&best_entry->orig_node->last_ttvn);
 		seq_printf(seq,
-			   " %c %pM  (%3u) via %pM     (%3u)   (%#.4x) [%c%c%c]\n",
+			   " %c %pM  (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c]\n",
 			   '*', tt_global_entry->common.addr,
 			   best_entry->ttvn, best_entry->orig_node->orig,
 			   last_ttvn, best_entry->orig_node->tt_crc,
@@ -1022,7 +1022,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq,
 		   "Globally announced TT entries received via the mesh %s\n",
 		   net_dev->name);
-	seq_printf(seq, "       %-13s %s       %-15s %s (%-6s) %s\n",
+	seq_printf(seq, "       %-13s %s       %-15s %s (%-10s) %s\n",
 		   "Client", "(TTVN)", "Originator", "(Curr TTVN)", "CRC",
 		   "Flags");
 
@@ -1379,17 +1379,19 @@ out:
 	return orig_node;
 }
 
-/* Calculates the checksum of the local table of a given orig_node */
-static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
+/**
+ * batadv_tt_global_crc - calculates the checksum of the local table of a
+ * given orig_node
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 				     struct batadv_orig_node *orig_node)
 {
-	uint16_t total = 0, total_one;
 	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct batadv_tt_global_entry *tt_global;
 	struct hlist_head *head;
-	uint32_t i;
-	int j;
+	uint32_t i, crc = 0;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1420,27 +1422,24 @@ static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 							     orig_node))
 				continue;
 
-			total_one = 0;
-			for (j = 0; j < ETH_ALEN; j++)
-				total_one = crc16_byte(total_one,
-						       tt_common->addr[j]);
-			total ^= total_one;
+			crc ^= crc32c(0, tt_common->addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
 	}
 
-	return total;
+	return crc;
 }
 
-/* Calculates the checksum of the local table */
-static uint16_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
+/**
+ * batadv_tt_local_crc - calculates the checksum of the local table
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 {
-	uint16_t total = 0, total_one;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
 	struct hlist_head *head;
-	uint32_t i;
-	int j;
+	uint32_t i, crc = 0;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1452,16 +1451,13 @@ static uint16_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 			 */
 			if (tt_common->flags & BATADV_TT_CLIENT_NEW)
 				continue;
-			total_one = 0;
-			for (j = 0; j < ETH_ALEN; j++)
-				total_one = crc16_byte(total_one,
-						       tt_common->addr[j]);
-			total ^= total_one;
+
+			crc ^= crc32c(0, tt_common->addr, ETH_ALEN);
 		}
 		rcu_read_unlock();
 	}
 
-	return total;
+	return crc;
 }
 
 static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
@@ -1647,9 +1643,18 @@ out:
 	return tvlv_tt_data;
 }
 
+/**
+ * batadv_send_tt_request - send a TT Request message to a given node
+ * @bat_priv: the bat priv with all the soft interface information
+ * @dst_orig_node: the destination of the message
+ * @ttvn: the version number that the source of the message is looking for
+ * @tt_crc: the CRC associated with the version number
+ * @full_table: ask for the entire translation table if true, while only for the
+ *	last TT diff otherwise
+ */
 static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *dst_orig_node,
-				  uint8_t ttvn, uint16_t tt_crc,
+				  uint8_t ttvn, uint32_t tt_crc,
 				  bool full_table)
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
@@ -1674,7 +1679,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 
 	tvlv_tt_data->flags = BATADV_TT_REQUEST;
 	tvlv_tt_data->ttvn = ttvn;
-	tvlv_tt_data->crc = htons(tt_crc);
+	tvlv_tt_data->crc = htonl(tt_crc);
 
 	if (full_table)
 		tvlv_tt_data->flags |= BATADV_TT_FULL_TABLE;
@@ -1741,7 +1746,7 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 
 	/* this node doesn't have the requested data */
 	if (orig_ttvn != req_ttvn ||
-	    tt_data->crc != htons(req_dst_orig_node->tt_crc))
+	    tt_data->crc != htonl(req_dst_orig_node->tt_crc))
 		goto out;
 
 	/* If the full table has been explicitly requested */
@@ -2394,7 +2399,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *orig_node,
 				  const unsigned char *tt_buff,
 				  uint8_t tt_num_changes,
-				  uint8_t ttvn, uint16_t tt_crc)
+				  uint8_t ttvn, uint32_t tt_crc)
 {
 	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 	bool full_table = true;
@@ -2448,7 +2453,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 		    orig_node->tt_crc != tt_crc) {
 request_table:
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "TT inconsistency for %pM. Need to retrieve the correct information (ttvn: %u last_ttvn: %u crc: %#.4x last_crc: %#.4x num_changes: %u)\n",
+				   "TT inconsistency for %pM. Need to retrieve the correct information (ttvn: %u last_ttvn: %u crc: %#.8x last_crc: %#.8x num_changes: %u)\n",
 				   orig_node->orig, ttvn, orig_ttvn, tt_crc,
 				   orig_node->tt_crc, tt_num_changes);
 			batadv_send_tt_request(bat_priv, orig_node, ttvn,
@@ -2556,7 +2561,7 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	batadv_tt_update_orig(bat_priv, orig,
 			      (unsigned char *)(tt_data + 1),
-			      num_entries, tt_data->ttvn, ntohs(tt_data->crc));
+			      num_entries, tt_data->ttvn, ntohl(tt_data->crc));
 }
 
 /**
diff --git a/types.h b/types.h
index 1548372..0c77d67 100644
--- a/types.h
+++ b/types.h
@@ -152,7 +152,7 @@ struct batadv_orig_node {
 	uint8_t flags;
 	uint8_t capabilities;
 	atomic_t last_ttvn;
-	uint16_t tt_crc;
+	uint32_t tt_crc;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
 	spinlock_t tt_buff_lock; /* protects tt_buff & tt_buff_len */
@@ -375,7 +375,7 @@ struct batadv_priv_tt {
 	spinlock_t req_list_lock; /* protects req_list */
 	spinlock_t roam_list_lock; /* protects roam_list */
 	atomic_t local_entry_num;
-	uint16_t local_crc;
+	uint32_t local_crc;
 	unsigned char *last_changeset;
 	int16_t last_changeset_len;
 	/* protects last_changeset & last_changeset_len */
-- 
1.8.1.5

