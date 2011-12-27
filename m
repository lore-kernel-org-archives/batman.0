Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 27 Dec 2011 17:24:07 +0100
Message-Id: <1325003047-16582-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: convert all times to miliseconds
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

has_timed_out() takes the second argument in miliseconds. The commit
"batman-adv: convert time_after instances to has_timed_out" introduced
some bugs by confusing seconds and miliseconds.

This patch converts all timeouts to miliseconds to be consistent, and
also fixes the previously introduced bugs.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 gateway_client.c    |    2 +-
 main.h              |   13 +++++++------
 translation-table.c |   15 ++++++---------
 vis.h               |    3 ++-
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 24403a7..df5631e 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -396,7 +396,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node, *curr_gw;
 	struct hlist_node *node, *node_tmp;
-	unsigned long timeout = 2 * PURGE_TIMEOUT * HZ;
+	unsigned long timeout = msecs_to_jiffies(2 * PURGE_TIMEOUT);
 	int do_deselect = 0;
 
 	curr_gw = gw_get_selected_gw_node(bat_priv);
diff --git a/main.h b/main.h
index 222c120..d124c28 100644
--- a/main.h
+++ b/main.h
@@ -41,13 +41,14 @@
 
 /* purge originators after time in seconds if no valid packet comes in
  * -> TODO: check influence on TQ_LOCAL_WINDOW_SIZE */
-#define PURGE_TIMEOUT 200
-#define TT_LOCAL_TIMEOUT 3600 /* in seconds */
-#define TT_CLIENT_ROAM_TIMEOUT 600
+#define PURGE_TIMEOUT 200000 /* 200 seconds */
+#define TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
+#define TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size) */
 #define TQ_LOCAL_WINDOW_SIZE 64
-#define TT_REQUEST_TIMEOUT 3 /* seconds we have to keep pending tt_req */
+#define TT_REQUEST_TIMEOUT 3000 /* miliseconds we have to keep
+				 * pending tt_req */
 
 #define TQ_GLOBAL_WINDOW_SIZE 5
 #define TQ_LOCAL_BIDRECT_SEND_MINIMUM 1
@@ -56,8 +57,8 @@
 
 #define TT_OGM_APPEND_MAX 3 /* number of OGMs sent with the last tt diff */
 
-#define ROAMING_MAX_TIME 20 /* Time in which a client can roam at most
-			     * ROAMING_MAX_COUNT times */
+#define ROAMING_MAX_TIME 20000 /* Time in which a client can roam at most
+				* ROAMING_MAX_COUNT times in miliseconds*/
 #define ROAMING_MAX_COUNT 5
 
 #define NO_FLAGS 0
diff --git a/translation-table.c b/translation-table.c
index a1be7ef..9fe38c1 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -413,7 +413,7 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 				continue;
 
 			if (!has_timed_out(tt_local_entry->last_seen,
-					   TT_LOCAL_TIMEOUT * 1000))
+					   TT_LOCAL_TIMEOUT))
 				continue;
 
 			tt_local_set_pending(bat_priv, tt_local_entry,
@@ -753,7 +753,7 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 			if (!(tt_global_entry->common.flags & TT_CLIENT_ROAM))
 				continue;
 			if (!has_timed_out(tt_global_entry->roam_at,
-					   TT_CLIENT_ROAM_TIMEOUT * 1000))
+					   TT_CLIENT_ROAM_TIMEOUT))
 				continue;
 
 			bat_dbg(DBG_TT, bat_priv, "Deleting global "
@@ -972,8 +972,7 @@ static void tt_req_purge(struct bat_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->tt_req_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt_req_list, list) {
-		if (has_timed_out(node->issued_at,
-				  TT_REQUEST_TIMEOUT * 1000)) {
+		if (has_timed_out(node->issued_at, TT_REQUEST_TIMEOUT)) {
 			list_del(&node->list);
 			kfree(node);
 		}
@@ -992,7 +991,7 @@ static struct tt_req_node *new_tt_req_node(struct bat_priv *bat_priv,
 	list_for_each_entry(tt_req_node_tmp, &bat_priv->tt_req_list, list) {
 		if (compare_eth(tt_req_node_tmp, orig_node) &&
 		    !has_timed_out(tt_req_node_tmp->issued_at,
-				   TT_REQUEST_TIMEOUT * 1000))
+				   TT_REQUEST_TIMEOUT))
 			goto unlock;
 	}
 
@@ -1585,8 +1584,7 @@ static void tt_roam_purge(struct bat_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->tt_roam_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt_roam_list, list) {
-		if (!has_timed_out(node->first_time,
-				   ROAMING_MAX_TIME * 1000))
+		if (!has_timed_out(node->first_time, ROAMING_MAX_TIME))
 			continue;
 
 		list_del(&node->list);
@@ -1613,8 +1611,7 @@ static bool tt_check_roam_count(struct bat_priv *bat_priv,
 		if (!compare_eth(tt_roam_node->addr, client))
 			continue;
 
-		if (has_timed_out(tt_roam_node->first_time,
-				  ROAMING_MAX_TIME * 1000))
+		if (has_timed_out(tt_roam_node->first_time, ROAMING_MAX_TIME))
 			continue;
 
 		if (!atomic_dec_not_zero(&tt_roam_node->counter))
diff --git a/vis.h b/vis.h
index 31b820d..851bc4f 100644
--- a/vis.h
+++ b/vis.h
@@ -22,7 +22,8 @@
 #ifndef _NET_BATMAN_ADV_VIS_H_
 #define _NET_BATMAN_ADV_VIS_H_
 
-#define VIS_TIMEOUT		200	/* timeout of vis packets in seconds */
+#define VIS_TIMEOUT		200000	/* timeout of vis packets
+					 * in miliseconds */
 
 int vis_seq_print_text(struct seq_file *seq, void *offset);
 void receive_server_sync_packet(struct bat_priv *bat_priv,
-- 
1.7.7.3

