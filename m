Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Apr 2011 21:30:11 +0200
Message-Id: <1303068618-27928-2-git-send-email-sven@narfation.org>
In-Reply-To: <1303068618-27928-1-git-send-email-sven@narfation.org>
References: <1303068618-27928-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Move bonding / iface
	alternating router search to own functions
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Linus Lüssing <linus.luessing@web.de>

This decreases the size of find_router() by outsourcing the router
search for the bonding and interface alternating modes to their own sub
functions. This shall make it easier to keep track of the correct
refcounting later.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c |  180 +++++++++++++++++++++++++++-------------------
 1 files changed, 105 insertions(+), 75 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index c172f5d..f212abe 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1092,6 +1092,106 @@ out:
 	return ret;
 }
 
+/* In the bonding case, send the packets in a round
+ * robin fashion over the remaining interfaces.
+ *
+ * This method rotates the bonding list and increases the
+ * returned router's refcount. */
+static struct neigh_node *find_bond_router(struct orig_node *primary_orig,
+					   struct hard_iface *recv_if)
+{
+	struct neigh_node *tmp_neigh_node;
+	struct neigh_node *router = NULL, *first_candidate = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp_neigh_node, &primary_orig->bond_list,
+				bonding_list) {
+		if (!first_candidate)
+			first_candidate = tmp_neigh_node;
+
+		/* recv_if == NULL on the first node. */
+		if (tmp_neigh_node->if_incoming == recv_if)
+			continue;
+
+		if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
+			continue;
+
+		router = tmp_neigh_node;
+		break;
+	}
+
+	/* use the first candidate if nothing was found. */
+	if (!router && first_candidate &&
+	    atomic_inc_not_zero(&first_candidate->refcount))
+		router = first_candidate;
+
+	if (!router)
+		goto out;
+
+	/* selected should point to the next element
+	 * after the current router */
+	spin_lock_bh(&primary_orig->neigh_list_lock);
+	/* this is a list_move(), which unfortunately
+	 * does not exist as rcu version */
+	list_del_rcu(&primary_orig->bond_list);
+	list_add_rcu(&primary_orig->bond_list,
+		     &router->bonding_list);
+	spin_unlock_bh(&primary_orig->neigh_list_lock);
+
+out:
+	rcu_read_unlock();
+	return router;
+}
+
+/* Interface Alternating: Use the best of the
+ * remaining candidates which are not using
+ * this interface.
+ *
+ * Increases the returned router's refcount */
+static struct neigh_node *find_ifalter_router(struct orig_node *primary_orig,
+					      struct hard_iface *recv_if)
+{
+	struct neigh_node *tmp_neigh_node;
+	struct neigh_node *router = NULL, *first_candidate = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp_neigh_node, &primary_orig->bond_list,
+				bonding_list) {
+		if (!first_candidate)
+			first_candidate = tmp_neigh_node;
+
+		/* recv_if == NULL on the first node. */
+		if (tmp_neigh_node->if_incoming == recv_if)
+			continue;
+
+		if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
+			continue;
+
+		/* if we don't have a router yet
+		 * or this one is better, choose it. */
+		if ((!router) ||
+		    (tmp_neigh_node->tq_avg > router->tq_avg)) {
+			/* decrement refcount of
+			 * previously selected router */
+			if (router)
+				neigh_node_free_ref(router);
+
+			router = tmp_neigh_node;
+			atomic_inc_not_zero(&router->refcount);
+		}
+
+		neigh_node_free_ref(tmp_neigh_node);
+	}
+
+	/* use the first candidate if nothing was found. */
+	if (!router && first_candidate &&
+	    atomic_inc_not_zero(&first_candidate->refcount))
+		router = first_candidate;
+
+	rcu_read_unlock();
+	return router;
+}
+
 /* find a suitable router for this originator, and use
  * bonding if possible. increases the found neighbors
  * refcount.*/
@@ -1101,7 +1201,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 {
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
-	struct neigh_node *router, *first_candidate, *tmp_neigh_node;
+	struct neigh_node *router;
 	static uint8_t zero_mac[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 	int bonding_enabled;
 
@@ -1157,82 +1257,12 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	 * in. */
 
 	neigh_node_free_ref(router);
-	first_candidate = NULL;
-	router = NULL;
 
-	if (bonding_enabled) {
-		/* in the bonding case, send the packets in a round
-		 * robin fashion over the remaining interfaces. */
+	if (bonding_enabled)
+		router = find_bond_router(primary_orig_node, recv_if);
+	else
+		router = find_ifalter_router(primary_orig_node, recv_if);
 
-		list_for_each_entry_rcu(tmp_neigh_node,
-				&primary_orig_node->bond_list, bonding_list) {
-			if (!first_candidate)
-				first_candidate = tmp_neigh_node;
-			/* recv_if == NULL on the first node. */
-			if (tmp_neigh_node->if_incoming != recv_if &&
-			    atomic_inc_not_zero(&tmp_neigh_node->refcount)) {
-				router = tmp_neigh_node;
-				break;
-			}
-		}
-
-		/* use the first candidate if nothing was found. */
-		if (!router && first_candidate &&
-		    atomic_inc_not_zero(&first_candidate->refcount))
-			router = first_candidate;
-
-		if (!router) {
-			rcu_read_unlock();
-			return NULL;
-		}
-
-		/* selected should point to the next element
-		 * after the current router */
-		spin_lock_bh(&primary_orig_node->neigh_list_lock);
-		/* this is a list_move(), which unfortunately
-		 * does not exist as rcu version */
-		list_del_rcu(&primary_orig_node->bond_list);
-		list_add_rcu(&primary_orig_node->bond_list,
-				&router->bonding_list);
-		spin_unlock_bh(&primary_orig_node->neigh_list_lock);
-
-	} else {
-		/* if bonding is disabled, use the best of the
-		 * remaining candidates which are not using
-		 * this interface. */
-		list_for_each_entry_rcu(tmp_neigh_node,
-			&primary_orig_node->bond_list, bonding_list) {
-			if (!first_candidate)
-				first_candidate = tmp_neigh_node;
-
-			/* recv_if == NULL on the first node. */
-			if (tmp_neigh_node->if_incoming == recv_if)
-				continue;
-
-			if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
-				continue;
-
-			/* if we don't have a router yet
-			 * or this one is better, choose it. */
-			if ((!router) ||
-			    (tmp_neigh_node->tq_avg > router->tq_avg)) {
-				/* decrement refcount of
-				 * previously selected router */
-				if (router)
-					neigh_node_free_ref(router);
-
-				router = tmp_neigh_node;
-				atomic_inc_not_zero(&router->refcount);
-			}
-
-			neigh_node_free_ref(tmp_neigh_node);
-		}
-
-		/* use the first candidate if nothing was found. */
-		if (!router && first_candidate &&
-		    atomic_inc_not_zero(&first_candidate->refcount))
-			router = first_candidate;
-	}
 return_router:
 	rcu_read_unlock();
 	return router;
-- 
1.7.4.4

