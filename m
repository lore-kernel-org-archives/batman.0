Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 13 Feb 2011 22:40:01 +0100
Message-Id: <1297633201-16458-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201102091918.42080.lindner_marek@yahoo.de>
References: <201102091918.42080.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: increase refcount in
	create_neighbor to be consistent
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/originator.c |    4 ++-
 batman-adv/routing.c    |   63 ++++++++++++++++++++--------------------------
 2 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index f6be7a1..c2017b2 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -91,7 +91,9 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 	memcpy(neigh_node->addr, neigh, ETH_ALEN);
 	neigh_node->orig_node = orig_neigh_node;
 	neigh_node->if_incoming = if_incoming;
-	atomic_set(&neigh_node->refcount, 1);
+
+	/* extra reference for return */
+	atomic_set(&neigh_node->refcount, 2);
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index dc24871..3cfa2c7 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -146,7 +146,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 				struct batman_if *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	struct neigh_node *neigh_node = NULL, *tmp_neigh_node;
 	struct hlist_node *node;
 	unsigned char total_count;
 	uint8_t orig_eq_count, neigh_rq_count, tq_own;
@@ -157,27 +157,27 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		hlist_for_each_entry_rcu(tmp_neigh_node, node,
 					 &orig_node->neigh_list, list) {
 
-			if (compare_eth(tmp_neigh_node->addr,
-					orig_neigh_node->orig) &&
-			    (tmp_neigh_node->if_incoming == if_incoming))
-				neigh_node = tmp_neigh_node;
+			if (!compare_eth(tmp_neigh_node->addr,
+					 orig_neigh_node->orig))
+				continue;
+
+			if (tmp_neigh_node->if_incoming != if_incoming)
+				continue;
+
+			if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
+				continue;
+
+			neigh_node = tmp_neigh_node;
 		}
+		rcu_read_unlock();
 
 		if (!neigh_node)
 			neigh_node = create_neighbor(orig_node,
 						     orig_neigh_node,
 						     orig_neigh_node->orig,
 						     if_incoming);
-		/* create_neighbor failed, return 0 */
 		if (!neigh_node)
-			goto unlock;
-
-		if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-			neigh_node = NULL;
-			goto unlock;
-		}
-
-		rcu_read_unlock();
+			goto out;
 
 		neigh_node->last_valid = jiffies;
 	} else {
@@ -186,27 +186,27 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		hlist_for_each_entry_rcu(tmp_neigh_node, node,
 					 &orig_neigh_node->neigh_list, list) {
 
-			if (compare_eth(tmp_neigh_node->addr,
-					orig_neigh_node->orig) &&
-			    (tmp_neigh_node->if_incoming == if_incoming))
-				neigh_node = tmp_neigh_node;
+			if (!compare_eth(tmp_neigh_node->addr,
+					 orig_neigh_node->orig))
+				continue;
+
+			if (tmp_neigh_node->if_incoming != if_incoming)
+				continue;
+
+			if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
+				continue;
+
+			neigh_node = tmp_neigh_node;
 		}
+		rcu_read_unlock();
 
 		if (!neigh_node)
 			neigh_node = create_neighbor(orig_neigh_node,
 						     orig_neigh_node,
 						     orig_neigh_node->orig,
 						     if_incoming);
-		/* create_neighbor failed, return 0 */
 		if (!neigh_node)
-			goto unlock;
-
-		if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-			neigh_node = NULL;
-			goto unlock;
-		}
-
-		rcu_read_unlock();
+			goto out;
 	}
 
 	orig_node->last_valid = jiffies;
@@ -261,10 +261,6 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	if (batman_packet->tq >= TQ_TOTAL_BIDRECT_LIMIT)
 		ret = 1;
 
-	goto out;
-
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
@@ -419,11 +415,6 @@ static void update_orig(struct bat_priv *bat_priv,
 		orig_node_free_ref(orig_tmp);
 		if (!neigh_node)
 			goto unlock;
-
-		if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-			neigh_node = NULL;
-			goto unlock;
-		}
 	} else
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Updating existing last-hop neighbor of originator\n");
-- 
1.7.2.3

