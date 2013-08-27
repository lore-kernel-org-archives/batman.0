Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 27 Aug 2013 22:57:48 +0200
Message-Id: <1377637071-2498-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1377637071-2498-1-git-send-email-ordex@autistici.org>
References: <1377637071-2498-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 6/9] batman-adv: adapt bonding to use the
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
 routing.c    | 42 +++++++++++++++++++++++++++++-------------
 routing.h    |  3 ++-
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index a2091af..d033ba4 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -843,7 +843,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		neigh_node->last_ttl = batadv_ogm_packet->header.ttl;
 	}
 
-	batadv_bonding_candidate_add(orig_node, neigh_node);
+	batadv_bonding_candidate_add(bat_priv, orig_node, neigh_node);
 
 	/* if this neighbor already is our next hop there is nothing
 	 * to change
diff --git a/routing.c b/routing.c
index 513fdef..4a7934f 100644
--- a/routing.c
+++ b/routing.c
@@ -115,11 +115,21 @@ out:
 	return;
 }
 
-void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
+/**
+ * batadv_bonding_candidate_add - consider a new link for bonding mode towards
+ *  the given originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: the target node
+ * @neigh_node: the neighbor representing the new link to consider for bonding
+ *  mode
+ */
+void batadv_bonding_candidate_add(struct batadv_priv *bat_priv,
+				  struct batadv_orig_node *orig_node,
 				  struct batadv_neigh_node *neigh_node)
 {
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct batadv_neigh_node *tmp_neigh_node, *router = NULL;
-	uint8_t interference_candidate = 0, tq;
+	uint8_t interference_candidate = 0;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -134,8 +144,7 @@ void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
 
 
 	/* ... and is good enough to be considered */
-	tq = router->bat_iv.tq_avg - BATADV_BONDING_TQ_THRESHOLD;
-	if (neigh_node->bat_iv.tq_avg < tq)
+	if (bao->bat_neigh_is_equiv_or_better(neigh_node, router))
 		goto candidate_del;
 
 	/* check if we have another candidate with the same mac address or
@@ -480,18 +489,25 @@ out:
 	return router;
 }
 
-/* Interface Alternating: Use the best of the
- * remaining candidates which are not using
- * this interface.
+/**
+ * batadv_find_ifalter_router - find the best of the remaining candidates which
+ *  are not using this interface
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_orig: the destination
+ * @recv_if: the interface that the router returned by this function has to not
+ *  use
  *
- * Increases the returned router's refcount
+ * Returns the best candidate towards primary_orig that is not using recv_if.
+ * Increases the returned neighbor's refcount
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
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tmp_neigh_node, &primary_orig->bond_list,
@@ -503,8 +519,7 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 		if (tmp_neigh_node->if_incoming == recv_if)
 			continue;
 
-		if (router &&
-		    tmp_neigh_node->bat_iv.tq_avg <= router->bat_iv.tq_avg)
+		if (router && bao->bat_neigh_cmp(tmp_neigh_node, router))
 			continue;
 
 		if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
@@ -638,7 +653,8 @@ batadv_find_router(struct batadv_priv *bat_priv,
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

