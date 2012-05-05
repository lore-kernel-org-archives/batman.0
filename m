Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 May 2012 13:27:28 +0200
Message-Id: <1336217249-16071-2-git-send-email-sven@narfation.org>
In-Reply-To: <1336217249-16071-1-git-send-email-sven@narfation.org>
References: <1336116752-585-1-git-send-email-sven@narfation.org>
	<1336217249-16071-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Return error codes instead
	of -1 on failures
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_sysfs.c             |    2 +-
 bridge_loop_avoidance.c |    6 +++---
 main.c                  |   27 ++++++++++++++++-----------
 originator.c            |   18 +++++++++---------
 translation-table.c     |   24 ++++++++++++++----------
 vis.c                   |    8 ++++----
 6 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index acb2640..6ba3d89 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -680,7 +680,7 @@ void sysfs_del_hardif(struct kobject **hardif_obj)
 int throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
 		 enum uev_action action, const char *data)
 {
-	int ret = -1;
+	int ret = -ENOMEM;
 	struct hard_iface *primary_if = NULL;
 	struct kobject *bat_kobj;
 	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 48831c2..89e9721 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1164,13 +1164,13 @@ int bla_init(struct bat_priv *bat_priv)
 	bat_priv->bcast_duplist_curr = 0;
 
 	if (bat_priv->claim_hash)
-		return 1;
+		return 0;
 
 	bat_priv->claim_hash = hash_new(128);
 	bat_priv->backbone_hash = hash_new(32);
 
 	if (!bat_priv->claim_hash || !bat_priv->backbone_hash)
-		return -1;
+		return -ENOMEM;
 
 	hash_set_lock_class(bat_priv->claim_hash, &claim_hash_lock_class_key);
 	hash_set_lock_class(bat_priv->backbone_hash,
@@ -1179,7 +1179,7 @@ int bla_init(struct bat_priv *bat_priv)
 	bat_dbg(DBG_BLA, bat_priv, "bla hashes initialized\n");
 
 	bla_start_timer(bat_priv);
-	return 1;
+	return 0;
 }
 
 /**
diff --git a/main.c b/main.c
index 79dd604..805373f 100644
--- a/main.c
+++ b/main.c
@@ -92,6 +92,7 @@ static void __exit batman_exit(void)
 int mesh_init(struct net_device *soft_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+	int ret;
 
 	spin_lock_init(&bat_priv->forw_bat_list_lock);
 	spin_lock_init(&bat_priv->forw_bcast_list_lock);
@@ -110,30 +111,32 @@ int mesh_init(struct net_device *soft_iface)
 	INIT_LIST_HEAD(&bat_priv->tt_req_list);
 	INIT_LIST_HEAD(&bat_priv->tt_roam_list);
 
-	if (originator_init(bat_priv) < 1)
+	ret = originator_init(bat_priv);
+	if (ret < 0)
 		goto err;
 
-	if (tt_init(bat_priv) < 1)
+	ret = tt_init(bat_priv);
+	if (ret < 0)
 		goto err;
 
 	tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
 
-	if (vis_init(bat_priv) < 1)
+	ret = vis_init(bat_priv);
+	if (ret < 0)
 		goto err;
 
-	if (bla_init(bat_priv) < 1)
+	ret = bla_init(bat_priv);
+	if (ret < 0)
 		goto err;
 
 	atomic_set(&bat_priv->gw_reselect, 0);
 	atomic_set(&bat_priv->mesh_state, MESH_ACTIVE);
-	goto end;
+
+	return 0;
 
 err:
 	mesh_free(soft_iface);
-	return -1;
-
-end:
-	return 0;
+	return ret;
 }
 
 void mesh_free(struct net_device *soft_iface)
@@ -321,12 +324,13 @@ static struct bat_algo_ops *bat_algo_get(char *name)
 int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 {
 	struct bat_algo_ops *bat_algo_ops_tmp;
-	int ret = -1;
+	int ret;
 
 	bat_algo_ops_tmp = bat_algo_get(bat_algo_ops->name);
 	if (bat_algo_ops_tmp) {
 		pr_info("Trying to register already registered routing algorithm: %s\n",
 			bat_algo_ops->name);
+		ret = -EEXIST;
 		goto out;
 	}
 
@@ -339,6 +343,7 @@ int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_ogm_emit) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -353,7 +358,7 @@ out:
 int bat_algo_select(struct bat_priv *bat_priv, char *name)
 {
 	struct bat_algo_ops *bat_algo_ops;
-	int ret = -1;
+	int ret = -EINVAL;
 
 	bat_algo_ops = bat_algo_get(name);
 	if (!bat_algo_ops)
diff --git a/originator.c b/originator.c
index 30889c9..61e091d 100644
--- a/originator.c
+++ b/originator.c
@@ -51,7 +51,7 @@ static int compare_orig(const struct hlist_node *node, const void *data2)
 int originator_init(struct bat_priv *bat_priv)
 {
 	if (bat_priv->orig_hash)
-		return 1;
+		return 0;
 
 	bat_priv->orig_hash = hash_new(1024);
 
@@ -59,10 +59,10 @@ int originator_init(struct bat_priv *bat_priv)
 		goto err;
 
 	start_purge_timer(bat_priv);
-	return 1;
+	return 0;
 
 err:
-	return 0;
+	return -ENOMEM;
 }
 
 void neigh_node_free_ref(struct neigh_node *neigh_node)
@@ -489,7 +489,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	data_ptr = kmalloc(max_if_num * sizeof(unsigned long) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr)
-		return -1;
+		return -ENOMEM;
 
 	memcpy(data_ptr, orig_node->bcast_own,
 	       (max_if_num - 1) * sizeof(unsigned long) * NUM_WORDS);
@@ -498,7 +498,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr)
-		return -1;
+		return -ENOMEM;
 
 	memcpy(data_ptr, orig_node->bcast_own_sum,
 	       (max_if_num - 1) * sizeof(uint8_t));
@@ -529,7 +529,7 @@ int orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num)
 			ret = orig_node_add_if(orig_node, max_if_num);
 			spin_unlock_bh(&orig_node->ogm_cnt_lock);
 
-			if (ret == -1)
+			if (ret == -ENOMEM)
 				goto err;
 		}
 		rcu_read_unlock();
@@ -555,7 +555,7 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	chunk_size = sizeof(unsigned long) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr)
-		return -1;
+		return -ENOMEM;
 
 	/* copy first part */
 	memcpy(data_ptr, orig_node->bcast_own, del_if_num * chunk_size);
@@ -574,7 +574,7 @@ free_bcast_own:
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr)
-		return -1;
+		return -ENOMEM;
 
 	memcpy(data_ptr, orig_node->bcast_own_sum,
 	       del_if_num * sizeof(uint8_t));
@@ -613,7 +613,7 @@ int orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num)
 					hard_iface->if_num);
 			spin_unlock_bh(&orig_node->ogm_cnt_lock);
 
-			if (ret == -1)
+			if (ret == -ENOMEM)
 				goto err;
 		}
 		rcu_read_unlock();
diff --git a/translation-table.c b/translation-table.c
index 88c62f1..6743a66 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -181,14 +181,14 @@ int tt_len(int changes_num)
 static int tt_local_init(struct bat_priv *bat_priv)
 {
 	if (bat_priv->tt_local_hash)
-		return 1;
+		return 0;
 
 	bat_priv->tt_local_hash = hash_new(1024);
 
 	if (!bat_priv->tt_local_hash)
-		return 0;
+		return -ENOMEM;
 
-	return 1;
+	return 0;
 }
 
 void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
@@ -491,14 +491,14 @@ static void tt_local_table_free(struct bat_priv *bat_priv)
 static int tt_global_init(struct bat_priv *bat_priv)
 {
 	if (bat_priv->tt_global_hash)
-		return 1;
+		return 0;
 
 	bat_priv->tt_global_hash = hash_new(1024);
 
 	if (!bat_priv->tt_global_hash)
-		return 0;
+		return -ENOMEM;
 
-	return 1;
+	return 0;
 }
 
 static void tt_changes_list_free(struct bat_priv *bat_priv)
@@ -1773,11 +1773,15 @@ out:
 
 int tt_init(struct bat_priv *bat_priv)
 {
-	if (!tt_local_init(bat_priv))
-		return 0;
+	int ret;
 
-	if (!tt_global_init(bat_priv))
-		return 0;
+	ret = tt_local_init(bat_priv);
+	if (ret < 0)
+		return ret;
+
+	ret = tt_global_init(bat_priv);
+	if (ret < 0)
+		return ret;
 
 	tt_start_timer(bat_priv);
 
diff --git a/vis.c b/vis.c
index cec216f..411c0e1 100644
--- a/vis.c
+++ b/vis.c
@@ -626,7 +626,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		best_tq = find_best_vis_server(bat_priv, info);
 
 		if (best_tq < 0)
-			return -1;
+			return best_tq;
 	}
 
 	for (i = 0; i < hash->size; i++) {
@@ -878,7 +878,7 @@ int vis_init(struct bat_priv *bat_priv)
 	int hash_added;
 
 	if (bat_priv->vis_hash)
-		return 1;
+		return 0;
 
 	spin_lock_bh(&bat_priv->vis_hash_lock);
 
@@ -929,7 +929,7 @@ int vis_init(struct bat_priv *bat_priv)
 
 	spin_unlock_bh(&bat_priv->vis_hash_lock);
 	start_vis_timer(bat_priv);
-	return 1;
+	return 0;
 
 free_info:
 	kfree(bat_priv->my_vis_info);
@@ -937,7 +937,7 @@ free_info:
 err:
 	spin_unlock_bh(&bat_priv->vis_hash_lock);
 	vis_quit(bat_priv);
-	return 0;
+	return -ENOMEM;
 }
 
 /* Decrease the reference count on a hash item info */
-- 
1.7.10

