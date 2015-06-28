Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Jun 2015 22:16:06 +0800
Message-Id: <1435500966-2584-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: convert bat_priv->tt.req_list to
	hlist
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Since the list's tail is never accessed using a double linked list head
wastes memory.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/main.c              |  2 +-
 net/batman-adv/translation-table.c | 29 ++++++++++++++++-------------
 net/batman-adv/types.h             |  4 ++--
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 40750cb..d277ba7 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -148,7 +148,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->mcast.want_all_ipv6_list);
 #endif
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
-	INIT_LIST_HEAD(&bat_priv->tt.req_list);
+	INIT_HLIST_HEAD(&bat_priv->tt.req_list);
 	INIT_LIST_HEAD(&bat_priv->tt.roam_list);
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	INIT_HLIST_HEAD(&bat_priv->mcast.mla_list);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1976816..3591d54 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2221,12 +2221,13 @@ static u32 batadv_tt_local_crc(struct batadv_priv *bat_priv,
 
 static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
 {
-	struct batadv_tt_req_node *node, *safe;
+	struct batadv_tt_req_node *node;
+	struct hlist_node *safe;
 
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
 
-	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
-		list_del_init(&node->list);
+	hlist_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
+		hlist_del_init(&node->list);
 		kfree(node);
 	}
 
@@ -2256,13 +2257,14 @@ static void batadv_tt_save_orig_buffer(struct batadv_priv *bat_priv,
 
 static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
 {
-	struct batadv_tt_req_node *node, *safe;
+	struct batadv_tt_req_node *node;
+	struct hlist_node *safe;
 
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
-	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
+	hlist_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
 		if (batadv_has_timed_out(node->issued_at,
 					 BATADV_TT_REQUEST_TIMEOUT)) {
-			list_del_init(&node->list);
+			hlist_del_init(&node->list);
 			kfree(node);
 		}
 	}
@@ -2284,7 +2286,7 @@ batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 	struct batadv_tt_req_node *tt_req_node_tmp, *tt_req_node = NULL;
 
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
-	list_for_each_entry(tt_req_node_tmp, &bat_priv->tt.req_list, list) {
+	hlist_for_each_entry(tt_req_node_tmp, &bat_priv->tt.req_list, list) {
 		if (batadv_compare_eth(tt_req_node_tmp, orig_node) &&
 		    !batadv_has_timed_out(tt_req_node_tmp->issued_at,
 					  BATADV_TT_REQUEST_TIMEOUT))
@@ -2298,7 +2300,7 @@ batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 	ether_addr_copy(tt_req_node->addr, orig_node->orig);
 	tt_req_node->issued_at = jiffies;
 
-	list_add(&tt_req_node->list, &bat_priv->tt.req_list);
+	hlist_add_head(&tt_req_node->list, &bat_priv->tt.req_list);
 unlock:
 	spin_unlock_bh(&bat_priv->tt.req_list_lock);
 	return tt_req_node;
@@ -2549,8 +2551,8 @@ out:
 		batadv_hardif_free_ref(primary_if);
 	if (ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt.req_list_lock);
-		/* list_del_init() verifies tt_req_node still is in the list */
-		list_del_init(&tt_req_node->list);
+		/* hlist_del_init() verifies tt_req_node still is in the list */
+		hlist_del_init(&tt_req_node->list);
 		spin_unlock_bh(&bat_priv->tt.req_list_lock);
 		kfree(tt_req_node);
 	}
@@ -2946,7 +2948,8 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 				      struct batadv_tvlv_tt_data *tt_data,
 				      u8 *resp_src, u16 num_entries)
 {
-	struct batadv_tt_req_node *node, *safe;
+	struct batadv_tt_req_node *node;
+	struct hlist_node *safe;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	u8 *tvlv_ptr = (u8 *)tt_data;
@@ -2984,10 +2987,10 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 
 	/* Delete the tt_req_node from pending tt_requests list */
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
-	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
+	hlist_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
 		if (!batadv_compare_eth(node->addr, resp_src))
 			continue;
-		list_del_init(&node->list);
+		hlist_del_init(&node->list);
 		kfree(node);
 	}
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e298332..0f9bd51 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -537,7 +537,7 @@ struct batadv_priv_tt {
 	struct list_head changes_list;
 	struct batadv_hashtable *local_hash;
 	struct batadv_hashtable *global_hash;
-	struct list_head req_list;
+	struct hlist_head req_list;
 	struct list_head roam_list;
 	spinlock_t changes_list_lock; /* protects changes */
 	spinlock_t req_list_lock; /* protects req_list */
@@ -1006,7 +1006,7 @@ struct batadv_tt_change_node {
 struct batadv_tt_req_node {
 	u8 addr[ETH_ALEN];
 	unsigned long issued_at;
-	struct list_head list;
+	struct hlist_node list;
 };
 
 /**
-- 
2.1.4

