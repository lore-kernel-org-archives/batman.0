Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 13 Feb 2011 22:39:34 +0100
Message-Id: <1297633174-16410-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201102091918.42080.lindner_marek@yahoo.de>
References: <201102091918.42080.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Correct rcu refcounting for
	orig_node
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

It might be possible that 2 threads access the same data in the same
rcu grace period. The first thread calls call_rcu() to decrement the
refcount and free the data while the second thread increases the
refcount to use the data. To avoid this race condition all refcount
operations have to be atomic.

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/gateway_client.c    |    6 ++++--
 batman-adv/icmp_socket.c       |    2 +-
 batman-adv/originator.c        |   18 ++++++++++++------
 batman-adv/originator.h        |    6 ++++--
 batman-adv/routing.c           |   22 +++++++++++-----------
 batman-adv/translation-table.c |   15 +++++++++------
 batman-adv/types.h             |    3 ++-
 batman-adv/unicast.c           |    6 ++----
 batman-adv/vis.c               |    2 +-
 9 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 3486854..ba6e4f2 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -53,9 +53,11 @@ void *gw_get_selected(struct bat_priv *bat_priv)
 		goto out;
 
 	orig_node = curr_gateway_tmp->orig_node;
+	if (!orig_node)
+		goto out;
 
-	if (orig_node)
-		kref_get(&orig_node->refcount);
+	if (!atomic_inc_not_zero(&orig_node->refcount))
+		orig_node = NULL;
 
 out:
 	rcu_read_unlock();
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index 17792f3..34ce56c 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -263,7 +263,7 @@ out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	return len;
 }
 
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index c9ba013..f6be7a1 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -99,13 +99,13 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 	return neigh_node;
 }
 
-void orig_node_free_ref(struct kref *refcount)
+static void orig_node_free_rcu(struct rcu_head *rcu)
 {
 	struct hlist_node *node, *node_tmp;
 	struct neigh_node *neigh_node, *tmp_neigh_node;
 	struct orig_node *orig_node;
 
-	orig_node = container_of(refcount, struct orig_node, refcount);
+	orig_node = container_of(rcu, struct orig_node, rcu);
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -134,6 +134,12 @@ void orig_node_free_ref(struct kref *refcount)
 	kfree(orig_node);
 }
 
+void orig_node_free_ref(struct orig_node *orig_node)
+{
+	if (atomic_dec_and_test(&orig_node->refcount))
+		call_rcu(&orig_node->rcu, orig_node_free_rcu);
+}
+
 void originator_free(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash = bat_priv->orig_hash;
@@ -159,7 +165,7 @@ void originator_free(struct bat_priv *bat_priv)
 					  head, hash_entry) {
 
 			hlist_del_rcu(node);
-			kref_put(&orig_node->refcount, orig_node_free_ref);
+			orig_node_free_ref(orig_node);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -191,7 +197,9 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
-	kref_init(&orig_node->refcount);
+
+	/* extra reference for return */
+	atomic_set(&orig_node->refcount, 2);
 
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
@@ -224,8 +232,6 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	if (hash_added < 0)
 		goto free_bcast_own_sum;
 
-	/* extra reference for return */
-	kref_get(&orig_node->refcount);
 	return orig_node;
 free_bcast_own_sum:
 	kfree(orig_node->bcast_own_sum);
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index b4b9a09..3d7a39d 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -27,7 +27,7 @@
 int originator_init(struct bat_priv *bat_priv);
 void originator_free(struct bat_priv *bat_priv);
 void purge_orig_ref(struct bat_priv *bat_priv);
-void orig_node_free_ref(struct kref *refcount);
+void orig_node_free_ref(struct orig_node *orig_node);
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr);
 struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   struct orig_node *orig_neigh_node,
@@ -88,8 +88,10 @@ static inline struct orig_node *orig_hash_find(struct bat_priv *bat_priv,
 		if (!compare_eth(orig_node, data))
 			continue;
 
+		if (!atomic_inc_not_zero(&orig_node->refcount))
+			continue;
+
 		orig_node_tmp = orig_node;
-		kref_get(&orig_node_tmp->refcount);
 		break;
 	}
 	rcu_read_unlock();
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index d381cbc..dc24871 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -416,7 +416,7 @@ static void update_orig(struct bat_priv *bat_priv,
 		neigh_node = create_neighbor(orig_node, orig_tmp,
 					     ethhdr->h_source, if_incoming);
 
-		kref_put(&orig_tmp->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_tmp);
 		if (!neigh_node)
 			goto unlock;
 
@@ -600,7 +600,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 
 out:
 	spin_unlock_bh(&orig_node->ogm_cnt_lock);
-	kref_put(&orig_node->refcount, orig_node_free_ref);
+	orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -726,7 +726,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 		bat_dbg(DBG_BATMAN, bat_priv, "Drop packet: "
 			"originator packet from myself (via neighbor)\n");
-		kref_put(&orig_neigh_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_neigh_node);
 		return;
 	}
 
@@ -832,9 +832,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
-		kref_put(&orig_neigh_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_neigh_node);
 out:
-	kref_put(&orig_node->refcount, orig_node_free_ref);
+	orig_node_free_ref(orig_node);
 }
 
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
@@ -935,7 +935,7 @@ out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -1001,7 +1001,7 @@ out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -1097,7 +1097,7 @@ out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -1152,7 +1152,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		if (!primary_orig_node)
 			goto return_router;
 
-		kref_put(&primary_orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(primary_orig_node);
 	}
 
 	/* with less than 2 candidates, we can't do any
@@ -1354,7 +1354,7 @@ out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -1492,7 +1492,7 @@ spin_unlock:
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 out:
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	return ret;
 }
 
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index cd8a583..8d15b48 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -589,17 +589,20 @@ void hna_global_free(struct bat_priv *bat_priv)
 struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
 {
 	struct hna_global_entry *hna_global_entry;
+	struct orig_node *orig_node = NULL;
 
 	spin_lock_bh(&bat_priv->hna_ghash_lock);
 	hna_global_entry = hna_global_hash_find(bat_priv, addr);
 
-	if (hna_global_entry)
-		kref_get(&hna_global_entry->orig_node->refcount);
+	if (!hna_global_entry)
+		goto out;
 
-	spin_unlock_bh(&bat_priv->hna_ghash_lock);
+	if (!atomic_inc_not_zero(&hna_global_entry->orig_node->refcount))
+		goto out;
 
-	if (!hna_global_entry)
-		return NULL;
+	orig_node = hna_global_entry->orig_node;
 
-	return hna_global_entry->orig_node;
+out:
+	spin_unlock_bh(&bat_priv->hna_ghash_lock);
+	return orig_node;
 }
diff --git a/batman-adv/types.h b/batman-adv/types.h
index cc10843..a9bf186 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -84,7 +84,8 @@ struct orig_node {
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
 	spinlock_t neigh_list_lock; /* protects neighbor list */
-	struct kref refcount;
+	atomic_t refcount;
+	struct rcu_head rcu;
 	struct hlist_node hash_entry;
 	struct bat_priv *bat_priv;
 	unsigned long last_frag_packet;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index af81008..6bfb573 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -211,11 +211,9 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	if (*new_skb)
 		ret = NET_RX_SUCCESS;
 
-	goto out;
-
 out:
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -344,7 +342,7 @@ out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	if (ret == 1)
 		kfree_skb(skb);
 	return ret;
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 2e8fc4d..074feba 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -809,7 +809,7 @@ out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
+		orig_node_free_ref(orig_node);
 	return;
 }
 
-- 
1.7.2.3

