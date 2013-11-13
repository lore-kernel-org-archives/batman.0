Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Nov 2013 19:14:50 +0100
Message-Id: <1384366492-27310-7-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv3 6/8] batman-adv: add bonding again
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

With the new interface alternating, the first hop may send packets
in a round robin fashion to it's neighbors because it has multiple
valid routes built by the multi interface optimization. This patch
enables the feature if bonding is selected. Note that unlike the
bonding implemented before, this version is much simpler and may
even enable multi path routing to a certain degree.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to PATCH:
 * use new references for orig_ifinfo in the bonding code
 * fix/beautify comments

Changes to RFCv2:
 * style changes (allo variables on one line
 * use new bat_neigh_is_equiv_or_better parameters
 * simplify last candidate lookup (Antonios suggestion)
 * remove last_bonding_candidate pointer when purging
---
 originator.c |    4 +++
 routing.c    |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 routing.h    |    2 +-
 types.h      |    2 ++
 4 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/originator.c b/originator.c
index b485f1c..9f0ae77 100644
--- a/originator.c
+++ b/originator.c
@@ -698,6 +698,10 @@ batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
 
 		hlist_del_rcu(&orig_ifinfo->list);
 		batadv_orig_ifinfo_free_ref(orig_ifinfo);
+		if (orig_node->last_bonding_candidate == orig_ifinfo) {
+			orig_node->last_bonding_candidate = NULL;
+			batadv_orig_ifinfo_free_ref(orig_ifinfo);
+		}
 	}
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
diff --git a/routing.c b/routing.c
index 760692d..69620e0 100644
--- a/routing.c
+++ b/routing.c
@@ -424,16 +424,123 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 struct batadv_neigh_node *
 batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
-		   const struct batadv_hard_iface *recv_if)
+		   struct batadv_hard_iface *recv_if)
 {
-	struct batadv_neigh_node *router;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_neigh_node *first_candidate_router = NULL;
+	struct batadv_neigh_node *next_candidate_router;
+	struct batadv_neigh_node *router, *cand_router = NULL;
+	struct batadv_orig_ifinfo *cand, *first_candidate = NULL;
+	struct batadv_orig_ifinfo *next_candidate = NULL;
+	bool last_candidate_found = false;
 
 	if (!orig_node)
 		return NULL;
 
 	router = batadv_orig_router_get(orig_node, recv_if);
 
-	/* TODO: fill this later with new bonding mechanism */
+	/* only consider bonding for recv_if == BATADV_IF_DEFAULT (first hop)
+	 * and if activated.
+	 */
+	if (recv_if == BATADV_IF_DEFAULT || !atomic_read(&bat_priv->bonding) ||
+	    !router)
+		return router;
+
+	/* bonding: loop through the list of possible routers found
+	 * for the various outgoing interfaces and find a candidate after
+	 * the last chosen bonding candidate (next_candidate). If no such
+	 * router is found, use the first candidate found (the previously
+	 * chosen bonding candidate might have been the last one in the list).
+	 * If this can't be found either, return the previously choosen
+	 * router - obviously there are no other candidates.
+	 */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(cand, &orig_node->ifinfo_list, list) {
+		/* acquire some structures and references ... */
+		if (!atomic_inc_not_zero(&cand->refcount))
+			continue;
+
+		cand_router = rcu_dereference(cand->router);
+		if (!cand_router)
+			goto next;
+
+		if (!atomic_inc_not_zero(&cand_router->refcount)) {
+			cand_router = NULL;
+			goto next;
+		}
+
+		/* alternative candidate should be good enough to be
+		 * considered
+		 */
+		if (!bao->bat_neigh_is_equiv_or_better(cand_router,
+						       cand->if_outgoing,
+						       router, recv_if))
+			goto next;
+
+		/* don't use the same router twice */
+		if (orig_node->last_bonding_candidate &&
+		    (orig_node->last_bonding_candidate->router == cand_router))
+				goto next;
+
+		/* mark the first possible candidate */
+		if (!first_candidate) {
+			atomic_inc(&cand_router->refcount);
+			atomic_inc(&cand->refcount);
+			first_candidate = cand;
+			first_candidate_router = cand_router;
+		}
+
+		/* check if the loop has already passed the previously selected
+		 * candidate ... this function should select the next candidate
+		 * AFTER the previously used bonding candidate.
+		 */
+		if (!orig_node->last_bonding_candidate ||
+		    last_candidate_found) {
+			next_candidate = cand;
+			next_candidate_router = cand_router;
+			break;
+		}
+
+		if (orig_node->last_bonding_candidate == cand)
+			last_candidate_found = true;
+next:
+		/* free references */
+		if (cand_router) {
+			batadv_neigh_node_free_ref(cand_router);
+			cand_router = NULL;
+		}
+		batadv_orig_ifinfo_free_ref(cand);
+	}
+	rcu_read_unlock();
+
+	/* last_bonding_candidate is reset below, remove the old reference. */
+	if (orig_node->last_bonding_candidate)
+		batadv_orig_ifinfo_free_ref(orig_node->last_bonding_candidate);
+
+	/* After finding candidates, handle the three cases:
+	 * 1) there is a next candidate, use that
+	 * 2) there is no next candidate, use the first of the list
+	 * 3) there is no candidate at all, return the default router
+	 */
+	if (next_candidate) {
+		batadv_neigh_node_free_ref(router);
+
+		/* remove references to first candidate, we don't need it. */
+		if (first_candidate) {
+			batadv_neigh_node_free_ref(first_candidate_router);
+			batadv_orig_ifinfo_free_ref(first_candidate);
+		}
+		router = next_candidate_router;
+		orig_node->last_bonding_candidate = next_candidate;
+	} else if (first_candidate) {
+		batadv_neigh_node_free_ref(router);
+
+		/* refcounting has already been done in the loop above. */
+		router = first_candidate_router;
+		orig_node->last_bonding_candidate = first_candidate;
+	} else {
+		orig_node->last_bonding_candidate = NULL;
+	}
 
 	return router;
 }
diff --git a/routing.h b/routing.h
index e1e36db..4143898 100644
--- a/routing.h
+++ b/routing.h
@@ -41,7 +41,7 @@ int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 struct batadv_neigh_node *
 batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
-		   const struct batadv_hard_iface *recv_if);
+		   struct batadv_hard_iface *recv_if);
 int batadv_window_protected(struct batadv_priv *bat_priv, int32_t seq_num_diff,
 			    unsigned long *last_reset);
 
diff --git a/types.h b/types.h
index 9a127b6..245a547 100644
--- a/types.h
+++ b/types.h
@@ -195,6 +195,7 @@ struct batadv_orig_bat_iv {
  * @orig: originator ethernet address
  * @primary_addr: hosts primary interface address
  * @ifinfo_list: list for routers per outgoing interface
+ * @last_bonding_candidate: pointer to last ifinfo of last used router
  * @batadv_dat_addr_t:  address of the orig node in the distributed hash
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
@@ -235,6 +236,7 @@ struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
 	struct hlist_head ifinfo_list;
+	struct batadv_orig_ifinfo *last_bonding_candidate;
 #ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dat_addr;
 #endif
-- 
1.7.10.4

