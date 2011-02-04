Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri,  4 Feb 2011 16:21:33 +0100
Message-Id: <1296832896-30081-5-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201102031802.52134.lindner_marek@yahoo.de>
References: <201102031802.52134.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: Correct rcu refcounting for
	neigh_node
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

From: Sven Eckelmann <sven@narfation.org>

It might be possible that 2 threads access the same data in the same
rcu grace period. The first thread calls call_rcu() to decrement the
refcount and free the data while the second thread increases the
refcount to use the data. To avoid this race condition all refcount
operations have to be atomic.

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 icmp_socket.c |    7 ++--
 originator.c  |   26 ++++---------
 originator.h  |    3 +-
 routing.c     |  111 +++++++++++++++++++++++++++++++++++++++++----------------
 types.h       |    3 +-
 unicast.c     |    2 +-
 vis.c         |    8 +++-
 7 files changed, 101 insertions(+), 59 deletions(-)

diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index fc812e1..4465a1a 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -229,10 +229,11 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	kref_get(&orig_node->refcount);
 	neigh_node = orig_node->router;
 
-	if (!neigh_node)
+	if (!neigh_node || !atomic_inc_not_zero(&neigh_node->refcount)) {
+		neigh_node = NULL;
 		goto unlock;
+	}
 
-	kref_get(&neigh_node->refcount);
 	rcu_read_unlock();
 
 	if (!neigh_node->if_incoming)
@@ -260,7 +261,7 @@ free_skb:
 	kfree_skb(skb);
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return len;
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index e8a8473..bde9778 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -56,28 +56,18 @@ err:
 	return 0;
 }
 
-void neigh_node_free_ref(struct kref *refcount)
-{
-	struct neigh_node *neigh_node;
-
-	neigh_node = container_of(refcount, struct neigh_node, refcount);
-	kfree(neigh_node);
-}
-
 static void neigh_node_free_rcu(struct rcu_head *rcu)
 {
 	struct neigh_node *neigh_node;
 
 	neigh_node = container_of(rcu, struct neigh_node, rcu);
-	kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	kfree(neigh_node);
 }
 
-void neigh_node_free_rcu_bond(struct rcu_head *rcu)
+void neigh_node_free_ref(struct neigh_node *neigh_node)
 {
-	struct neigh_node *neigh_node;
-
-	neigh_node = container_of(rcu, struct neigh_node, rcu_bond);
-	kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	if (atomic_dec_and_test(&neigh_node->refcount))
+		call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
 }
 
 struct neigh_node *create_neighbor(struct orig_node *orig_node,
@@ -101,7 +91,7 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
 	neigh_node->orig_node = orig_neigh_node;
 	neigh_node->if_incoming = if_incoming;
-	kref_init(&neigh_node->refcount);
+	atomic_set(&neigh_node->refcount, 1);
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
@@ -123,14 +113,14 @@ void orig_node_free_ref(struct kref *refcount)
 	list_for_each_entry_safe(neigh_node, tmp_neigh_node,
 				 &orig_node->bond_list, bonding_list) {
 		list_del_rcu(&neigh_node->bonding_list);
-		call_rcu(&neigh_node->rcu_bond, neigh_node_free_rcu_bond);
+		neigh_node_free_ref(neigh_node);
 	}
 
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 				  &orig_node->neigh_list, list) {
 		hlist_del_rcu(&neigh_node->list);
-		call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
+		neigh_node_free_ref(neigh_node);
 	}
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
@@ -311,7 +301,7 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 
 			hlist_del_rcu(&neigh_node->list);
 			bonding_candidate_del(orig_node, neigh_node);
-			call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
+			neigh_node_free_ref(neigh_node);
 		} else {
 			if ((!*best_neigh_node) ||
 			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index 360dfd1..84d96e2 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -26,13 +26,12 @@ int originator_init(struct bat_priv *bat_priv);
 void originator_free(struct bat_priv *bat_priv);
 void purge_orig_ref(struct bat_priv *bat_priv);
 void orig_node_free_ref(struct kref *refcount);
-void neigh_node_free_rcu_bond(struct rcu_head *rcu);
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr);
 struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   struct orig_node *orig_neigh_node,
 				   uint8_t *neigh,
 				   struct batman_if *if_incoming);
-void neigh_node_free_ref(struct kref *refcount);
+void neigh_node_free_ref(struct neigh_node *neigh_node);
 int orig_seq_print_text(struct seq_file *seq, void *offset);
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num);
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index b792df4..a2b770a 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -117,12 +117,12 @@ static void update_route(struct bat_priv *bat_priv,
 			orig_node->router->addr);
 	}
 
-	if (neigh_node)
-		kref_get(&neigh_node->refcount);
+	if (neigh_node && !atomic_inc_not_zero(&neigh_node->refcount))
+		neigh_node = NULL;
 	neigh_node_tmp = orig_node->router;
 	orig_node->router = neigh_node;
 	if (neigh_node_tmp)
-		kref_put(&neigh_node_tmp->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node_tmp);
 }
 
 
@@ -174,7 +174,11 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		if (!neigh_node)
 			goto unlock;
 
-		kref_get(&neigh_node->refcount);
+		if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+			neigh_node = NULL;
+			goto unlock;
+		}
+
 		rcu_read_unlock();
 
 		neigh_node->last_valid = jiffies;
@@ -199,7 +203,11 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		if (!neigh_node)
 			goto unlock;
 
-		kref_get(&neigh_node->refcount);
+		if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+			neigh_node = NULL;
+			goto unlock;
+		}
+
 		rcu_read_unlock();
 	}
 
@@ -261,7 +269,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 	return ret;
 }
 
@@ -274,8 +282,8 @@ void bonding_candidate_del(struct orig_node *orig_node,
 		goto out;
 
 	list_del_rcu(&neigh_node->bonding_list);
-	call_rcu(&neigh_node->rcu_bond, neigh_node_free_rcu_bond);
 	INIT_LIST_HEAD(&neigh_node->bonding_list);
+	neigh_node_free_ref(neigh_node);
 	atomic_dec(&orig_node->bond_candidates);
 
 out:
@@ -336,8 +344,10 @@ static void bonding_candidate_add(struct orig_node *orig_node,
 	if (!list_empty(&neigh_node->bonding_list))
 		goto out;
 
+	if (!atomic_inc_not_zero(&neigh_node->refcount))
+		goto out;
+
 	list_add_rcu(&neigh_node->bonding_list, &orig_node->bond_list);
-	kref_get(&neigh_node->refcount);
 	atomic_inc(&orig_node->bond_candidates);
 	goto out;
 
@@ -381,7 +391,10 @@ static void update_orig(struct bat_priv *bat_priv,
 	hlist_for_each_entry_rcu(tmp_neigh_node, node,
 				 &orig_node->neigh_list, list) {
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
-		    (tmp_neigh_node->if_incoming == if_incoming)) {
+		    (tmp_neigh_node->if_incoming == if_incoming) &&
+		     atomic_inc_not_zero(&tmp_neigh_node->refcount)) {
+			if (neigh_node)
+				neigh_node_free_ref(neigh_node);
 			neigh_node = tmp_neigh_node;
 			continue;
 		}
@@ -408,11 +421,15 @@ static void update_orig(struct bat_priv *bat_priv,
 		kref_put(&orig_tmp->refcount, orig_node_free_ref);
 		if (!neigh_node)
 			goto unlock;
+
+		if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+			neigh_node = NULL;
+			goto unlock;
+		}
 	} else
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Updating existing last-hop neighbor of originator\n");
 
-	kref_get(&neigh_node->refcount);
 	rcu_read_unlock();
 
 	orig_node->flags = batman_packet->flags;
@@ -489,7 +506,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 }
 
 /* checks whether the host restarted and is in the protection time.
@@ -893,7 +910,11 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	if (!neigh_node)
 		goto unlock;
 
-	kref_get(&neigh_node->refcount);
+	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+		neigh_node = NULL;
+		goto unlock;
+	}
+
 	rcu_read_unlock();
 
 	/* create a copy of the skb, if needed, to modify it. */
@@ -916,7 +937,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
@@ -957,7 +978,11 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	if (!neigh_node)
 		goto unlock;
 
-	kref_get(&neigh_node->refcount);
+	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+		neigh_node = NULL;
+		goto unlock;
+	}
+
 	rcu_read_unlock();
 
 	/* create a copy of the skb, if needed, to modify it. */
@@ -980,7 +1005,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
@@ -1053,7 +1078,11 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (!neigh_node)
 		goto unlock;
 
-	kref_get(&neigh_node->refcount);
+	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+		neigh_node = NULL;
+		goto unlock;
+	}
+
 	rcu_read_unlock();
 
 	/* create a copy of the skb, if needed, to modify it. */
@@ -1074,7 +1103,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
@@ -1107,12 +1136,11 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	/* select default router to output */
 	router = orig_node->router;
 	router_orig = orig_node->router->orig_node;
-	if (!router_orig) {
+	if (!router_orig || !atomic_inc_not_zero(&router->refcount)) {
 		rcu_read_unlock();
 		return NULL;
 	}
 
-
 	if ((!recv_if) && (!bonding_enabled))
 		goto return_router;
 
@@ -1145,6 +1173,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	 * is is not on the interface where the packet came
 	 * in. */
 
+	neigh_node_free_ref(router);
 	first_candidate = NULL;
 	router = NULL;
 
@@ -1157,16 +1186,23 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 			if (!first_candidate)
 				first_candidate = tmp_neigh_node;
 			/* recv_if == NULL on the first node. */
-			if (tmp_neigh_node->if_incoming != recv_if) {
+			if (tmp_neigh_node->if_incoming != recv_if &&
+			    atomic_inc_not_zero(&tmp_neigh_node->refcount)) {
 				router = tmp_neigh_node;
 				break;
 			}
 		}
 
 		/* use the first candidate if nothing was found. */
-		if (!router)
+		if (!router && first_candidate &&
+		    atomic_inc_not_zero(&first_candidate->refcount))
 			router = first_candidate;
 
+		if (!router) {
+			rcu_read_unlock();
+			return NULL;
+		}
+
 		/* selected should point to the next element
 		 * after the current router */
 		spin_lock_bh(&primary_orig_node->neigh_list_lock);
@@ -1187,21 +1223,34 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 				first_candidate = tmp_neigh_node;
 
 			/* recv_if == NULL on the first node. */
-			if (tmp_neigh_node->if_incoming != recv_if)
-				/* if we don't have a router yet
-				 * or this one is better, choose it. */
-				if ((!router) ||
-				(tmp_neigh_node->tq_avg > router->tq_avg)) {
-					router = tmp_neigh_node;
-				}
+			if (tmp_neigh_node->if_incoming == recv_if)
+				continue;
+
+			if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
+				continue;
+
+			/* if we don't have a router yet
+			 * or this one is better, choose it. */
+			if ((!router) ||
+			    (tmp_neigh_node->tq_avg > router->tq_avg)) {
+				/* decrement refcount of
+				 * previously selected router */
+				if (router)
+					neigh_node_free_ref(router);
+
+				router = tmp_neigh_node;
+				atomic_inc_not_zero(&router->refcount);
+			}
+
+			neigh_node_free_ref(tmp_neigh_node);
 		}
 
 		/* use the first candidate if nothing was found. */
-		if (!router)
+		if (!router && first_candidate &&
+		    atomic_inc_not_zero(&first_candidate->refcount))
 			router = first_candidate;
 	}
 return_router:
-	kref_get(&router->refcount);
 	rcu_read_unlock();
 	return router;
 }
@@ -1314,7 +1363,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 317ede8..ee77d48 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -119,9 +119,8 @@ struct neigh_node {
 	struct list_head bonding_list;
 	unsigned long last_valid;
 	unsigned long real_bits[NUM_WORDS];
-	struct kref refcount;
+	atomic_t refcount;
 	struct rcu_head rcu;
-	struct rcu_head rcu_bond;
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
 };
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 6a9ab61..580b547 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -363,7 +363,7 @@ find_router:
 
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
 	if (ret == 1)
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 191401b..c1c3258 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -776,7 +776,11 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 	if (!neigh_node)
 		goto unlock;
 
-	kref_get(&neigh_node->refcount);
+	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+		neigh_node = NULL;
+		goto unlock;
+	}
+
 	rcu_read_unlock();
 
 	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
@@ -790,7 +794,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+		neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return;
-- 
1.7.2.3

