Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 26 Dec 2013 18:57:01 +0100
Message-Id: <1388080621-15040-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix NULL pointer deref in
	batadv_find_best_neighbor
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

If there is no best neighbor, don't dereference the NULL pointer. Try to
acquire the neighbor node right in the loop instead. There also was a
logic bug, finding the worst instead of the best neighbor.

Introduced by 9bb33b8d88e318c4879d37d06ad28e3e018b9036 ("batman-adv:
split tq information in neigh_node struct")

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 originator.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/originator.c b/originator.c
index 2243003..4a5d027 100644
--- a/originator.c
+++ b/originator.c
@@ -783,14 +783,19 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(neigh, &orig_node->neigh_list, list)
-		if (!best ||
-		    (bao->bat_neigh_cmp(neigh, if_outgoing,
-					best, if_outgoing) <= 0))
-			best = neigh;
+	hlist_for_each_entry_rcu(neigh, &orig_node->neigh_list, list) {
+		if (best && (bao->bat_neigh_cmp(neigh, if_outgoing,
+						best, if_outgoing) <= 0))
+			continue;
 
-	if (!atomic_inc_not_zero(&best->refcount))
-		best = NULL;
+		if (!atomic_inc_not_zero(&neigh->refcount))
+			continue;
+
+		if (best)
+			batadv_neigh_node_free_ref(best);
+
+		best = neigh;
+	}
 	rcu_read_unlock();
 
 	return best;
-- 
1.7.10.4

