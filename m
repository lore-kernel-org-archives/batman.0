Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 11 Aug 2013 14:33:20 +0200
Message-Id: <1376224403-2494-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1376224403-2494-1-git-send-email-ordex@autistici.org>
References: <1376224403-2494-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 6/9] batman-adv: adapt bonding to use the
	new API functions
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
 bat_iv_ogm.c |  2 +-
 routing.c    | 25 +++++++++++++++++--------
 routing.h    |  3 ++-
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 12a9686..956d39b 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -834,7 +834,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		neigh_node->last_ttl = batadv_ogm_packet->header.ttl;
 	}
 
-	batadv_bonding_candidate_add(orig_node, neigh_node);
+	batadv_bonding_candidate_add(bat_priv, orig_node, neigh_node);
 
 	/* if this neighbor already is our next hop there is nothing
 	 * to change
diff --git a/routing.c b/routing.c
index 5b8f087..5672a2d 100644
--- a/routing.c
+++ b/routing.c
@@ -115,11 +115,14 @@ out:
 	return;
 }
 
-void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
+void batadv_bonding_candidate_add(struct batadv_priv *bat_priv,
+				  struct batadv_orig_node *orig_node,
 				  struct batadv_neigh_node *neigh_node)
 {
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct batadv_neigh_node *tmp_neigh_node, *router = NULL;
 	uint8_t interference_candidate = 0;
+	uint32_t router_metric, neigh_metric;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -133,8 +136,9 @@ void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
 		goto candidate_del;
 
 	/* ... and is good enough to be considered */
-	if (neigh_node->bat_iv.tq_avg <
-	    router->bat_iv.tq_avg - BATADV_BONDING_TQ_THRESHOLD)
+	router_metric = bao->bat_metric_get(router);
+	neigh_metric = bao->bat_metric_get(neigh_node);
+	if (bao->bat_metric_is_equiv_or_better(neigh_metric, router_metric))
 		goto candidate_del;
 
 	/* check if we have another candidate with the same mac address or
@@ -486,11 +490,14 @@ out:
  * Increases the returned router's refcount
  */
 static struct batadv_neigh_node *
-batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
+batadv_find_ifalter_router(struct batadv_priv *bat_priv,
+			   struct batadv_orig_node *primary_orig,
 			   const struct batadv_hard_iface *recv_if)
 {
-	struct batadv_neigh_node *tmp_neigh_node;
 	struct batadv_neigh_node *router = NULL, *first_candidate = NULL;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_neigh_node *tmp_neigh_node;
+	uint32_t tmp_metric, router_metric = UINT_MAX;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tmp_neigh_node, &primary_orig->bond_list,
@@ -502,8 +509,8 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 		if (tmp_neigh_node->if_incoming == recv_if)
 			continue;
 
-		if (router &&
-		    tmp_neigh_node->bat_iv.tq_avg <= router->bat_iv.tq_avg)
+		tmp_metric = bao->bat_metric_get(tmp_neigh_node);
+		if (router && (tmp_metric <= router_metric))
 			continue;
 
 		if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
@@ -515,6 +522,7 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 
 		/* we found a better router (or at least one valid router) */
 		router = tmp_neigh_node;
+		router_metric = bao->bat_metric_get(router);
 	}
 
 	/* use the first candidate if nothing was found. */
@@ -637,7 +645,8 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	if (bonding_enabled)
 		router = batadv_find_bond_router(primary_orig_node, recv_if);
 	else
-		router = batadv_find_ifalter_router(primary_orig_node, recv_if);
+		router = batadv_find_ifalter_router(bat_priv, primary_orig_node,
+						    recv_if);
 
 return_router:
 	if (router && router->if_incoming->if_status != BATADV_IF_ACTIVE)
diff --git a/routing.h b/routing.h
index 55d637a..19544dd 100644
--- a/routing.h
+++ b/routing.h
@@ -48,7 +48,8 @@ batadv_find_router(struct batadv_priv *bat_priv,
 		   const struct batadv_hard_iface *recv_if);
 void batadv_bonding_candidate_del(struct batadv_orig_node *orig_node,
 				  struct batadv_neigh_node *neigh_node);
-void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
+void batadv_bonding_candidate_add(struct batadv_priv *bat_priv,
+				  struct batadv_orig_node *orig_node,
 				  struct batadv_neigh_node *neigh_node);
 void batadv_bonding_save_primary(const struct batadv_orig_node *orig_node,
 				 struct batadv_orig_node *orig_neigh_node,
-- 
1.8.1.5

