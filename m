Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 10 Aug 2013 19:05:01 +0200
Message-Id: <1376154302-1203-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1376154302-1203-1-git-send-email-ordex@autistici.org>
References: <1376154302-1203-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/10] batman-adv: adapt the neighbor purging
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
 originator.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/originator.c b/originator.c
index b3f6910..8f96041 100644
--- a/originator.c
+++ b/originator.c
@@ -380,6 +380,8 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 	bool neigh_purged = false;
 	unsigned long last_seen;
 	struct batadv_hard_iface *if_incoming;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	uint32_t neigh_metric, best_metric;
 
 	*best_neigh_node = NULL;
 
@@ -414,10 +416,13 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 			batadv_bonding_candidate_del(orig_node, neigh_node);
 			batadv_neigh_node_free_ref(neigh_node);
 		} else {
-			if ((!*best_neigh_node) ||
-			    (neigh_node->bat_iv.tq_avg >
-			     (*best_neigh_node)->bat_iv.tq_avg))
+			neigh_metric = bao->bat_metric_get(neigh_node);
+			if (!*best_neigh_node ||
+			    bao->bat_metric_compare(neigh_metric,
+						    best_metric) > 0) {
 				*best_neigh_node = neigh_node;
+				best_metric = bao->bat_metric_get(neigh_node);
+			}
 		}
 	}
 
-- 
1.8.1.5

