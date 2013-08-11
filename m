Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 11 Aug 2013 14:33:22 +0200
Message-Id: <1376224403-2494-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1376224403-2494-1-git-send-email-ordex@autistici.org>
References: <1376224403-2494-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 8/9] batman-adv: provide orig_node routing
	API
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Some operations executed on an orig_node depends on the
current routing algorithm being used. To easily make this
mechanism routing algorithm agnostic add a orig_node
specific API that each algorithm can populate with its own
routines.

Such routines are then invoked by the code when needed,
without knowing which routing algorithm is currently in use

With this patch 3 API functions are added:
- orig_free (to free routing depending internal structs)
- orig_add_if (to change the inner state of an orig_node
  when a new hard interface is added)
- orig_del_if (to change the inner state of an orig_node
  when an hard interface is removed)

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 originator.c | 102 ++++++++-------------------------------------------------
 types.h      |   5 +++
 3 files changed, 123 insertions(+), 88 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 956d39b..2af2017 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -87,6 +87,107 @@ static uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 	return (uint8_t)(sum / count);
 }
 
+static void batadv_iv_ogm_orig_free(struct batadv_orig_node *orig_node)
+{
+	kfree(orig_node->bat_iv.bcast_own);
+	kfree(orig_node->bat_iv.bcast_own_sum);
+}
+
+static int batadv_iv_ogm_orig_add_if(struct batadv_orig_node *orig_node,
+				     int max_if_num)
+{
+	void *data_ptr;
+	size_t data_size, old_size;
+	int ret = -ENOMEM;
+
+	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+
+	data_size = max_if_num * sizeof(unsigned long) * BATADV_NUM_WORDS;
+	old_size = (max_if_num - 1) * sizeof(unsigned long) * BATADV_NUM_WORDS;
+	data_ptr = kmalloc(data_size, GFP_ATOMIC);
+	if (!data_ptr)
+		goto unlock;
+
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own, old_size);
+	kfree(orig_node->bat_iv.bcast_own);
+	orig_node->bat_iv.bcast_own = data_ptr;
+
+	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
+	if (!data_ptr) {
+		kfree(orig_node->bat_iv.bcast_own);
+		goto unlock;
+	}
+
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
+	       (max_if_num - 1) * sizeof(uint8_t));
+	kfree(orig_node->bat_iv.bcast_own_sum);
+	orig_node->bat_iv.bcast_own_sum = data_ptr;
+
+	ret = 0;
+
+unlock:
+	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+
+	return ret;
+}
+
+static int batadv_iv_ogm_orig_del_if(struct batadv_orig_node *orig_node,
+				     int max_if_num, int del_if_num)
+{
+	int chunk_size,  ret = -ENOMEM, if_offset;
+	void *data_ptr = NULL;
+
+	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+
+	/* last interface was removed */
+	if (max_if_num == 0)
+		goto free_bcast_own;
+
+	chunk_size = sizeof(unsigned long) * BATADV_NUM_WORDS;
+	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
+	if (!data_ptr)
+		goto unlock;
+
+	/* copy first part */
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own, del_if_num * chunk_size);
+
+	/* copy second part */
+	memcpy((char *)data_ptr + del_if_num * chunk_size,
+	       orig_node->bat_iv.bcast_own + ((del_if_num + 1) * chunk_size),
+	       (max_if_num - del_if_num) * chunk_size);
+
+free_bcast_own:
+	kfree(orig_node->bat_iv.bcast_own);
+	orig_node->bat_iv.bcast_own = data_ptr;
+
+	if (max_if_num == 0)
+		goto free_own_sum;
+
+	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
+	if (!data_ptr) {
+		kfree(orig_node->bat_iv.bcast_own);
+		goto unlock;
+	}
+
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
+	       del_if_num * sizeof(uint8_t));
+
+	if_offset = ((del_if_num + 1) * sizeof(uint8_t));
+	memcpy((char *)data_ptr + del_if_num * sizeof(uint8_t),
+	       orig_node->bat_iv.bcast_own_sum + if_offset,
+	       (max_if_num - del_if_num) * sizeof(uint8_t));
+
+free_own_sum:
+	kfree(orig_node->bat_iv.bcast_own_sum);
+	orig_node->bat_iv.bcast_own_sum = data_ptr;
+
+	ret = 0;
+unlock:
+	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+
+	return ret;
+}
+
 static struct batadv_orig_node *
 batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
 {
@@ -1481,6 +1582,9 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_metric_get = batadv_iv_ogm_metric_get,
 	.bat_metric_is_equiv_or_better = batadv_iv_ogm_metric_is_eob,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
+	.bat_orig_free = batadv_iv_ogm_orig_free,
+	.bat_orig_add_if = batadv_iv_ogm_orig_add_if,
+	.bat_orig_del_if = batadv_iv_ogm_orig_del_if,
 };
 
 int __init batadv_iv_init(void)
diff --git a/originator.c b/originator.c
index 3ee8806..db1fa16 100644
--- a/originator.c
+++ b/originator.c
@@ -234,9 +234,10 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node, -1,
 				  "originator timed out");
 
+	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
+		orig_node->bat_priv->bat_algo_ops->bat_orig_free(orig_node);
+
 	kfree(orig_node->tt_buff);
-	kfree(orig_node->bat_iv.bcast_own);
-	kfree(orig_node->bat_iv.bcast_own_sum);
 	kfree(orig_node);
 }
 
@@ -533,38 +534,11 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static int batadv_orig_node_add_if(struct batadv_orig_node *orig_node,
-				   int max_if_num)
-{
-	void *data_ptr;
-	size_t data_size, old_size;
-
-	data_size = max_if_num * sizeof(unsigned long) * BATADV_NUM_WORDS;
-	old_size = (max_if_num - 1) * sizeof(unsigned long) * BATADV_NUM_WORDS;
-	data_ptr = kmalloc(data_size, GFP_ATOMIC);
-	if (!data_ptr)
-		return -ENOMEM;
-
-	memcpy(data_ptr, orig_node->bat_iv.bcast_own, old_size);
-	kfree(orig_node->bat_iv.bcast_own);
-	orig_node->bat_iv.bcast_own = data_ptr;
-
-	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
-	if (!data_ptr)
-		return -ENOMEM;
-
-	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
-	       (max_if_num - 1) * sizeof(uint8_t));
-	kfree(orig_node->bat_iv.bcast_own_sum);
-	orig_node->bat_iv.bcast_own_sum = data_ptr;
-
-	return 0;
-}
-
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -579,10 +553,10 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-			ret = batadv_orig_node_add_if(orig_node, max_if_num);
-			spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-
+			ret = 0;
+			if (bao->bat_orig_add_if)
+				ret = bao->bat_orig_add_if(orig_node,
+							   max_if_num);
 			if (ret == -ENOMEM)
 				goto err;
 		}
@@ -596,55 +570,6 @@ err:
 	return -ENOMEM;
 }
 
-static int batadv_orig_node_del_if(struct batadv_orig_node *orig_node,
-				   int max_if_num, int del_if_num)
-{
-	int chunk_size, if_offset;
-	void *data_ptr = NULL;
-
-	/* last interface was removed */
-	if (max_if_num == 0)
-		goto free_bcast_own;
-
-	chunk_size = sizeof(unsigned long) * BATADV_NUM_WORDS;
-	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
-	if (!data_ptr)
-		return -ENOMEM;
-
-	/* copy first part */
-	memcpy(data_ptr, orig_node->bat_iv.bcast_own, del_if_num * chunk_size);
-
-	/* copy second part */
-	memcpy((char *)data_ptr + del_if_num * chunk_size,
-	       orig_node->bat_iv.bcast_own + ((del_if_num + 1) * chunk_size),
-	       (max_if_num - del_if_num) * chunk_size);
-
-free_bcast_own:
-	kfree(orig_node->bat_iv.bcast_own);
-	orig_node->bat_iv.bcast_own = data_ptr;
-
-	if (max_if_num == 0)
-		goto free_own_sum;
-
-	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
-	if (!data_ptr)
-		return -ENOMEM;
-
-	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
-	       del_if_num * sizeof(uint8_t));
-
-	if_offset = ((del_if_num + 1) * sizeof(uint8_t));
-	memcpy((char *)data_ptr + del_if_num * sizeof(uint8_t),
-	       orig_node->bat_iv.bcast_own_sum + if_offset,
-	       (max_if_num - del_if_num) * sizeof(uint8_t));
-
-free_own_sum:
-	kfree(orig_node->bat_iv.bcast_own_sum);
-	orig_node->bat_iv.bcast_own_sum = data_ptr;
-
-	return 0;
-}
-
 int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
@@ -653,6 +578,7 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 	struct hlist_head *head;
 	struct batadv_hard_iface *hard_iface_tmp;
 	struct batadv_orig_node *orig_node;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	uint32_t i;
 	int ret;
 
@@ -664,11 +590,11 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-			ret = batadv_orig_node_del_if(orig_node, max_if_num,
-						      hard_iface->if_num);
-			spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-
+			ret = 0;
+			if (bao->bat_orig_del_if)
+				ret = bao->bat_orig_del_if(orig_node,
+							   max_if_num,
+							   hard_iface->if_num);
 			if (ret == -ENOMEM)
 				goto err;
 		}
diff --git a/types.h b/types.h
index 7a12eef..6333b31 100644
--- a/types.h
+++ b/types.h
@@ -1009,6 +1009,11 @@ struct batadv_algo_ops {
 					      uint32_t new_metric);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
+	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
+	int (*bat_orig_add_if)(struct batadv_orig_node *orig_node,
+			       int max_if_num);
+	int (*bat_orig_del_if)(struct batadv_orig_node *orig_node,
+			       int max_if_num, int del_if_num);
 };
 
 /**
-- 
1.8.1.5

