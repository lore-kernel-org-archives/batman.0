Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Thu,  8 Dec 2011 13:32:41 +0100
Message-Id: <1323347561-10028-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <4EDA4621.905@hundeboll.net>
References: <4EDA4621.905@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Move is_out_of_time() to
	main.h for general use
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Both translation tables and network coding use timeouts to do house
keeping, so we might as well share the function used to compare a
timestamp+timeout with current time.

For readability and simplicity, the function is renamed to
has_timed_out() and uses time_is_before_jiffies() instead of
time_after().

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 main.h              |    5 +++++
 translation-table.c |   32 ++++++++++++--------------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/main.h b/main.h
index 464439f..838bba0 100644
--- a/main.h
+++ b/main.h
@@ -204,6 +204,11 @@ static inline int compare_eth(const void *data1, const void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
+/* Returns true if current time (jiffies) is after timestamp + timeout */
+static inline bool has_timed_out(unsigned long timestamp, unsigned long timeout)
+{
+	return time_is_before_jiffies(timestamp + msecs_to_jiffies(timeout));
+}
 
 #define atomic_dec_not_zero(v)	atomic_add_unless((v), -1, 0)
 
diff --git a/translation-table.c b/translation-table.c
index 20d6628..d542b9d 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -108,14 +108,6 @@ static struct tt_global_entry *tt_global_hash_find(struct bat_priv *bat_priv,
 
 }
 
-static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
-{
-	unsigned long deadline;
-	deadline = starting_time + msecs_to_jiffies(timeout);
-
-	return time_after(jiffies, deadline);
-}
-
 static void tt_local_entry_free_ref(struct tt_local_entry *tt_local_entry)
 {
 	if (atomic_dec_and_test(&tt_local_entry->common.refcount))
@@ -420,8 +412,8 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 			if (tt_local_entry->common.flags & TT_CLIENT_PENDING)
 				continue;
 
-			if (!is_out_of_time(tt_local_entry->last_seen,
-					    TT_LOCAL_TIMEOUT * 1000))
+			if (!has_timed_out(tt_local_entry->last_seen,
+					   TT_LOCAL_TIMEOUT * 1000))
 				continue;
 
 			tt_local_set_pending(bat_priv, tt_local_entry,
@@ -758,8 +750,8 @@ static void tt_global_roam_purge(struct bat_priv *bat_priv)
 						       common);
 			if (!(tt_global_entry->common.flags & TT_CLIENT_ROAM))
 				continue;
-			if (!is_out_of_time(tt_global_entry->roam_at,
-					    TT_CLIENT_ROAM_TIMEOUT * 1000))
+			if (!has_timed_out(tt_global_entry->roam_at,
+					   TT_CLIENT_ROAM_TIMEOUT * 1000))
 				continue;
 
 			bat_dbg(DBG_TT, bat_priv, "Deleting global "
@@ -978,8 +970,8 @@ static void tt_req_purge(struct bat_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->tt_req_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt_req_list, list) {
-		if (is_out_of_time(node->issued_at,
-		    TT_REQUEST_TIMEOUT * 1000)) {
+		if (has_timed_out(node->issued_at,
+				  TT_REQUEST_TIMEOUT * 1000)) {
 			list_del(&node->list);
 			kfree(node);
 		}
@@ -997,8 +989,8 @@ static struct tt_req_node *new_tt_req_node(struct bat_priv *bat_priv,
 	spin_lock_bh(&bat_priv->tt_req_list_lock);
 	list_for_each_entry(tt_req_node_tmp, &bat_priv->tt_req_list, list) {
 		if (compare_eth(tt_req_node_tmp, orig_node) &&
-		    !is_out_of_time(tt_req_node_tmp->issued_at,
-				    TT_REQUEST_TIMEOUT * 1000))
+		    !has_timed_out(tt_req_node_tmp->issued_at,
+				   TT_REQUEST_TIMEOUT * 1000))
 			goto unlock;
 	}
 
@@ -1591,8 +1583,8 @@ static void tt_roam_purge(struct bat_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->tt_roam_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt_roam_list, list) {
-		if (!is_out_of_time(node->first_time,
-				    ROAMING_MAX_TIME * 1000))
+		if (!has_timed_out(node->first_time,
+				   ROAMING_MAX_TIME * 1000))
 			continue;
 
 		list_del(&node->list);
@@ -1619,8 +1611,8 @@ static bool tt_check_roam_count(struct bat_priv *bat_priv,
 		if (!compare_eth(tt_roam_node->addr, client))
 			continue;
 
-		if (is_out_of_time(tt_roam_node->first_time,
-				   ROAMING_MAX_TIME * 1000))
+		if (has_timed_out(tt_roam_node->first_time,
+				  ROAMING_MAX_TIME * 1000))
 			continue;
 
 		if (!atomic_dec_not_zero(&tt_roam_node->counter))
-- 
1.7.8

