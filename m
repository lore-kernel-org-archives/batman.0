Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Jun 2012 08:54:40 +0200
Message-Id: <1340607284-29950-17-git-send-email-ordex@autistici.org>
In-Reply-To: <1340607284-29950-1-git-send-email-ordex@autistici.org>
References: <1340607284-29950-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 16/20] batman-adv: Prefix originator local
	static functions with batadv_
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/originator.c |   54 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 1cd640e..bf9ec39a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -28,17 +28,17 @@
 #include "soft-interface.h"
 #include "bridge_loop_avoidance.h"
 
-static void purge_orig(struct work_struct *work);
+static void batadv_purge_orig(struct work_struct *work);
 
-static void start_purge_timer(struct bat_priv *bat_priv)
+static void batadv_start_purge_timer(struct bat_priv *bat_priv)
 {
-	INIT_DELAYED_WORK(&bat_priv->orig_work, purge_orig);
+	INIT_DELAYED_WORK(&bat_priv->orig_work, batadv_purge_orig);
 	queue_delayed_work(batadv_event_workqueue,
 			   &bat_priv->orig_work, msecs_to_jiffies(1000));
 }
 
 /* returns 1 if they are the same originator */
-static int compare_orig(const struct hlist_node *node, const void *data2)
+static int batadv_compare_orig(const struct hlist_node *node, const void *data2)
 {
 	const void *data1 = container_of(node, struct orig_node, hash_entry);
 
@@ -55,7 +55,7 @@ int batadv_originator_init(struct bat_priv *bat_priv)
 	if (!bat_priv->orig_hash)
 		goto err;
 
-	start_purge_timer(bat_priv);
+	batadv_start_purge_timer(bat_priv);
 	return 0;
 
 err:
@@ -110,7 +110,7 @@ out:
 	return neigh_node;
 }
 
-static void orig_node_free_rcu(struct rcu_head *rcu)
+static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 {
 	struct hlist_node *node, *node_tmp;
 	struct neigh_node *neigh_node, *tmp_neigh_node;
@@ -149,7 +149,7 @@ static void orig_node_free_rcu(struct rcu_head *rcu)
 void batadv_orig_node_free_ref(struct orig_node *orig_node)
 {
 	if (atomic_dec_and_test(&orig_node->refcount))
-		call_rcu(&orig_node->rcu, orig_node_free_rcu);
+		call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
 void batadv_originator_free(struct bat_priv *bat_priv)
@@ -248,7 +248,7 @@ struct orig_node *batadv_get_orig_node(struct bat_priv *bat_priv,
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
-	hash_added = batadv_hash_add(bat_priv->orig_hash, compare_orig,
+	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
 	if (hash_added != 0)
@@ -264,9 +264,9 @@ free_orig_node:
 	return NULL;
 }
 
-static bool purge_orig_neighbors(struct bat_priv *bat_priv,
-				 struct orig_node *orig_node,
-				 struct neigh_node **best_neigh_node)
+static bool batadv_purge_orig_neighbors(struct bat_priv *bat_priv,
+					struct orig_node *orig_node,
+					struct neigh_node **best_neigh_node)
 {
 	struct hlist_node *node, *node_tmp;
 	struct neigh_node *neigh_node;
@@ -319,8 +319,8 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 	return neigh_purged;
 }
 
-static bool purge_orig_node(struct bat_priv *bat_priv,
-			    struct orig_node *orig_node)
+static bool batadv_purge_orig_node(struct bat_priv *bat_priv,
+				   struct orig_node *orig_node)
 {
 	struct neigh_node *best_neigh_node;
 
@@ -331,8 +331,8 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 			   jiffies_to_msecs(orig_node->last_seen));
 		return true;
 	} else {
-		if (purge_orig_neighbors(bat_priv, orig_node,
-					 &best_neigh_node))
+		if (batadv_purge_orig_neighbors(bat_priv, orig_node,
+						&best_neigh_node))
 			batadv_update_route(bat_priv, orig_node,
 					    best_neigh_node);
 	}
@@ -340,7 +340,7 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 	return false;
 }
 
-static void _purge_orig(struct bat_priv *bat_priv)
+static void _batadv_purge_orig(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
@@ -360,7 +360,7 @@ static void _purge_orig(struct bat_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(orig_node, node, node_tmp,
 					  head, hash_entry) {
-			if (purge_orig_node(bat_priv, orig_node)) {
+			if (batadv_purge_orig_node(bat_priv, orig_node)) {
 				if (orig_node->gw_flags)
 					batadv_gw_node_delete(bat_priv,
 							      orig_node);
@@ -380,20 +380,20 @@ static void _purge_orig(struct bat_priv *bat_priv)
 	batadv_gw_election(bat_priv);
 }
 
-static void purge_orig(struct work_struct *work)
+static void batadv_purge_orig(struct work_struct *work)
 {
 	struct delayed_work *delayed_work =
 		container_of(work, struct delayed_work, work);
 	struct bat_priv *bat_priv =
 		container_of(delayed_work, struct bat_priv, orig_work);
 
-	_purge_orig(bat_priv);
-	start_purge_timer(bat_priv);
+	_batadv_purge_orig(bat_priv);
+	batadv_start_purge_timer(bat_priv);
 }
 
 void batadv_purge_orig_ref(struct bat_priv *bat_priv)
 {
-	_purge_orig(bat_priv);
+	_batadv_purge_orig(bat_priv);
 }
 
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
@@ -483,7 +483,7 @@ out:
 	return ret;
 }
 
-static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
+static int batadv_orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 {
 	void *data_ptr;
 
@@ -528,7 +528,7 @@ int batadv_orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
 			spin_lock_bh(&orig_node->ogm_cnt_lock);
-			ret = orig_node_add_if(orig_node, max_if_num);
+			ret = batadv_orig_node_add_if(orig_node, max_if_num);
 			spin_unlock_bh(&orig_node->ogm_cnt_lock);
 
 			if (ret == -ENOMEM)
@@ -544,8 +544,8 @@ err:
 	return -ENOMEM;
 }
 
-static int orig_node_del_if(struct orig_node *orig_node,
-		     int max_if_num, int del_if_num)
+static int batadv_orig_node_del_if(struct orig_node *orig_node,
+				   int max_if_num, int del_if_num)
 {
 	void *data_ptr = NULL;
 	int chunk_size;
@@ -612,8 +612,8 @@ int batadv_orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
 			spin_lock_bh(&orig_node->ogm_cnt_lock);
-			ret = orig_node_del_if(orig_node, max_if_num,
-					hard_iface->if_num);
+			ret = batadv_orig_node_del_if(orig_node, max_if_num,
+						      hard_iface->if_num);
 			spin_unlock_bh(&orig_node->ogm_cnt_lock);
 
 			if (ret == -ENOMEM)
-- 
1.7.9.4

