Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 31 May 2011 01:25:45 +0200
Message-Id: <1306797945-22502-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1306791458-7891-1-git-send-email-ordex@autistici.org>
References: <1306791458-7891-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 2/2] batman-adv: rename and move TT_*
	flags/structs to the proper locations
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

struct tt_change is sent over the wire so need to be in packet.h as well
as all the TT_CHANGE_* flags. TT_GLOBAL/CHANGE_ROAM as been renamed to
TT_CLIENT_ROAM so that both tt_global_entry and tt_change can use the
same same flag.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.h              |   10 +---------
 packet.h            |   11 ++++++++++-
 translation-table.c |   18 +++++++++---------
 types.h             |    5 -----
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/main.h b/main.h
index 582e387..82cf523 100644
--- a/main.h
+++ b/main.h
@@ -42,7 +42,7 @@
  * -> TODO: check influence on TQ_LOCAL_WINDOW_SIZE */
 #define PURGE_TIMEOUT 200
 #define TT_LOCAL_TIMEOUT 3600 /* in seconds */
-#define TT_GLOBAL_ROAM_TIMEOUT 600
+#define TT_CLIENT_ROAM_TIMEOUT 600
 /* sliding packet range of received originator messages in squence numbers
  * (should be a multiple of our word size) */
 #define TQ_LOCAL_WINDOW_SIZE 64
@@ -55,14 +55,6 @@
 
 #define TT_OGM_APPEND_MAX 3 /* number of OGMs sent with the last tt diff */
 
-/* Transtable change flags */
-#define TT_CHANGE_ADD   0x00
-#define TT_CHANGE_DEL   0x01
-#define TT_CHANGE_ROAM  0x02
-
-/* Transtable global entry flags */
-#define TT_GLOBAL_ROAM  0x01
-
 #define ROAMING_MAX_TIME 20 /* Time in which a client can roam at most
 			     * ROAMING_MAX_COUNT times */
 #define ROAMING_MAX_COUNT 5
diff --git a/packet.h b/packet.h
index ae212c7..5e3e778 100644
--- a/packet.h
+++ b/packet.h
@@ -54,11 +54,15 @@
 #define UNI_FRAG_HEAD 0x01
 #define UNI_FRAG_LARGETAIL 0x02
 
-/* TT flags */
+/* TT_QUERY flags */
 #define TT_RESPONSE     0x01
 #define TT_REQUEST      0x02
 #define TT_FULL_TABLE   0x04
 
+/* TT_CHANGE flags */
+#define TT_CHANGE_DEL   0x01
+#define TT_CLIENT_ROAM  0x02
+
 struct batman_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
@@ -180,4 +184,9 @@ struct roam_adv_packet {
 	uint8_t  client[ETH_ALEN];
 } __packed;
 
+struct tt_change {
+	uint8_t flags;
+	uint8_t addr[ETH_ALEN];
+};
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/translation-table.c b/translation-table.c
index 1c50122..bcbd39b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -156,7 +156,7 @@ static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
 
 	tt_change_node->change.flags = op;
 	if (roaming)
-		tt_change_node->change.flags |= TT_GLOBAL_ROAM;
+		tt_change_node->change.flags |= TT_CLIENT_ROAM;
 
 	memcpy(tt_change_node->change.addr, addr, ETH_ALEN);
 
@@ -204,7 +204,7 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	if (!tt_local_entry)
 		goto out;
 
-	tt_local_event(bat_priv, TT_CHANGE_ADD, addr, false);
+	tt_local_event(bat_priv, 0, addr, false);
 
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new local tt entry: %pM (ttvn: %d)\n", addr,
@@ -665,7 +665,7 @@ void tt_global_del(struct bat_priv *bat_priv,
 
 	if (tt_global_entry->orig_node == orig_node) {
 		if (roaming) {
-			tt_global_entry->flags |= TT_GLOBAL_ROAM;
+			tt_global_entry->flags |= TT_CLIENT_ROAM;
 			tt_global_entry->roam_at = jiffies;
 			goto out;
 		}
@@ -724,10 +724,10 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_global_entry, node, node_tmp,
 					  head, hash_entry) {
-			if (!(tt_global_entry->flags & TT_GLOBAL_ROAM))
+			if (!(tt_global_entry->flags & TT_CLIENT_ROAM))
 				continue;
 			if (!is_out_of_time(tt_global_entry->roam_at,
-					    TT_GLOBAL_ROAM_TIMEOUT * 1000))
+					    TT_CLIENT_ROAM_TIMEOUT * 1000))
 				continue;
 
 			bat_dbg(DBG_TT, bat_priv, "Deleting global "
@@ -818,7 +818,7 @@ uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node)
 				 * consistency only. They don't have to be
 				 * taken into account while computing the
 				 * global crc */
-				if (tt_global_entry->flags & TT_GLOBAL_ROAM)
+				if (tt_global_entry->flags & TT_CLIENT_ROAM)
 					continue;
 				total_one = 0;
 				for (j = 0; j < ETH_ALEN; j++)
@@ -943,7 +943,7 @@ static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
 	const struct tt_global_entry *tt_global_entry = entry_ptr;
 	const struct orig_node *orig_node = data_ptr;
 
-	if (tt_global_entry->flags & TT_GLOBAL_ROAM)
+	if (tt_global_entry->flags & TT_CLIENT_ROAM)
 		return 0;
 
 	return (tt_global_entry->orig_node == orig_node);
@@ -999,7 +999,7 @@ static struct sk_buff *tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 				continue;
 
 			memcpy(tt_change->addr, tt_local_entry->addr, ETH_ALEN);
-			tt_change->flags = TT_CHANGE_ADD;
+			tt_change->flags = 0;
 
 			tt_count++;
 			tt_change++;
@@ -1340,7 +1340,7 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 			tt_global_del(bat_priv, orig_node,
 				      (tt_change + i)->addr,
 				      "tt removed by changes",
-				      (tt_change + i)->flags & TT_CHANGE_ROAM);
+				      (tt_change + i)->flags & TT_CLIENT_ROAM);
 		else
 			if (!tt_global_add(bat_priv, orig_node,
 					   (tt_change + i)->addr, ttvn, false))
diff --git a/types.h b/types.h
index 8c9b5da..11e8569 100644
--- a/types.h
+++ b/types.h
@@ -109,11 +109,6 @@ struct orig_node {
 	struct list_head bond_list;
 };
 
-struct tt_change {
-	uint8_t flags;
-	uint8_t addr[ETH_ALEN];
-};
-
 struct gw_node {
 	struct hlist_node list;
 	struct orig_node *orig_node;
-- 
1.7.3.4

