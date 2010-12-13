Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 13 Dec 2010 01:18:52 +0100
Message-Id: <1292199536-4644-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201012130118.14949.lindner_marek@yahoo.de>
References: <201012130118.14949.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: protect neigh_nodes used
	outside of rcu_locks with refcounting
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
 batman-adv/routing.c |   40 +++++++++++++++++++++++++++++++---------
 1 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index abce1ae..7e9499f 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -152,6 +152,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	struct hlist_node *node;
 	unsigned char total_count;
+	int ret = 0;
 
 	if (orig_node == orig_neigh_node) {
 		rcu_read_lock();
@@ -163,7 +164,6 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 			    (tmp_neigh_node->if_incoming == if_incoming))
 				neigh_node = tmp_neigh_node;
 		}
-		rcu_read_unlock();
 
 		if (!neigh_node)
 			neigh_node = create_neighbor(orig_node,
@@ -172,7 +172,10 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 						     if_incoming);
 		/* create_neighbor failed, return 0 */
 		if (!neigh_node)
-			return 0;
+			goto unlock;
+
+		kref_get(&neigh_node->refcount);
+		rcu_read_unlock();
 
 		neigh_node->last_valid = jiffies;
 	} else {
@@ -186,7 +189,6 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 			    (tmp_neigh_node->if_incoming == if_incoming))
 				neigh_node = tmp_neigh_node;
 		}
-		rcu_read_unlock();
 
 		if (!neigh_node)
 			neigh_node = create_neighbor(orig_neigh_node,
@@ -195,7 +197,10 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 						     if_incoming);
 		/* create_neighbor failed, return 0 */
 		if (!neigh_node)
-			return 0;
+			goto unlock;
+
+		kref_get(&neigh_node->refcount);
+		rcu_read_unlock();
 	}
 
 	orig_node->last_valid = jiffies;
@@ -251,9 +256,16 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 	/* if link has the minimum required transmission quality
 	 * consider it bidirectional */
 	if (batman_packet->tq >= TQ_TOTAL_BIDRECT_LIMIT)
-		return 1;
+		ret = 1;
 
-	return 0;
+	goto out;
+
+unlock:
+	rcu_read_unlock();
+out:
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	return ret;
 }
 
 static void update_orig(struct bat_priv *bat_priv,
@@ -288,23 +300,25 @@ static void update_orig(struct bat_priv *bat_priv,
 		tmp_neigh_node->tq_avg =
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
 	}
-	rcu_read_unlock();
 
 	if (!neigh_node) {
 		struct orig_node *orig_tmp;
 
 		orig_tmp = get_orig_node(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
-			return;
+			goto unlock;
 
 		neigh_node = create_neighbor(orig_node, orig_tmp,
 					     ethhdr->h_source, if_incoming);
 		if (!neigh_node)
-			return;
+			goto unlock;
 	} else
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Updating existing last-hop neighbor of originator\n");
 
+	kref_get(&neigh_node->refcount);
+	rcu_read_unlock();
+
 	orig_node->flags = batman_packet->flags;
 	neigh_node->last_valid = jiffies;
 
@@ -358,6 +372,14 @@ update_gw:
 	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_CLIENT) &&
 	    (atomic_read(&bat_priv->gw_sel_class) > 2))
 		gw_check_election(bat_priv, orig_node);
+
+	goto out;
+
+unlock:
+	rcu_read_unlock();
+out:
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
 }
 
 /* checks whether the host restarted and is in the protection time.
-- 
1.7.2.3

