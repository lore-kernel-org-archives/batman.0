Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 27 Aug 2013 22:57:49 +0200
Message-Id: <1377637071-2498-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1377637071-2498-1-git-send-email-ordex@autistici.org>
References: <1377637071-2498-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 7/9] batman-adv: adapt the neighbor purging
	routine to use the new API functions
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

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 originator.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/originator.c b/originator.c
index 6f80ace..98a0f25 100644
--- a/originator.c
+++ b/originator.c
@@ -385,16 +385,16 @@ free_orig_node:
 static bool
 batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 			    struct batadv_orig_node *orig_node,
-			    struct batadv_neigh_node **best_neigh_node)
+			    struct batadv_neigh_node **best_neigh)
 {
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
 	bool neigh_purged = false;
 	unsigned long last_seen;
 	struct batadv_hard_iface *if_incoming;
-	uint8_t best_metric = 0;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 
-	*best_neigh_node = NULL;
+	*best_neigh = NULL;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -427,11 +427,12 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 			batadv_bonding_candidate_del(orig_node, neigh_node);
 			batadv_neigh_node_free_ref(neigh_node);
 		} else {
-			if ((!*best_neigh_node) ||
-			    (neigh_node->bat_iv.tq_avg > best_metric)) {
-				*best_neigh_node = neigh_node;
-				best_metric = neigh_node->bat_iv.tq_avg;
-			}
+			/* store the best_neighbour if this is the first
+			 * iteration or if a better neighbor has been found
+			 */
+			if (!*best_neigh ||
+			    bao->bat_neigh_cmp(neigh_node, *best_neigh) > 0)
+				*best_neigh = neigh_node;
 		}
 	}
 
-- 
1.8.1.5

