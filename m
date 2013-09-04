Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  4 Sep 2013 18:27:40 +0200
Message-Id: <1378312060-30922-7-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFCv2 6/6] batman-adv: add bonding again
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
 routing.c |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 routing.h |    2 +-
 types.h   |    2 ++
 3 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/routing.c b/routing.c
index 304e44b..013958f 100644
--- a/routing.c
+++ b/routing.c
@@ -407,16 +407,114 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
 struct batadv_neigh_node *
 batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
-		   const struct batadv_hard_iface *recv_if)
+		   struct batadv_hard_iface *recv_if)
 {
-	struct batadv_neigh_node *router;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_neigh_node *router, *cand_router,
+				 *first_candidate_router = NULL,
+				 *next_candidate_router;
+	struct batadv_neigh_node_ifinfo *router_ifinfo, *cand_ifinfo;
+	struct batadv_orig_node_ifinfo *cand, *first_candidate = NULL,
+				       *next_candidate = NULL;
+	bool last_candidate_found = false;
 
 	if (!orig_node)
 		return NULL;
 
 	router = batadv_orig_node_get_router(orig_node, recv_if);
 
-	/* TODO: fill this later with new bonding mechanism */
+	/* only consider bonding for recv_if == NULL (first hop) and if
+	 * activated.
+	 */
+	if (recv_if || !atomic_read(&bat_priv->bonding) || !router)
+		return router;
+
+	/* bonding: loop through the list of possible routers found
+	 * for the various outgoing interfaces and find a candidate after
+	 * the last chosen bonding candidate (next_candidate). If no such
+	 * router is found, use the first candidate found (the last chosen
+	 * bonding candidate might have been the last one in the list).
+	 * If this can't be found either, return the previously choosen
+	 * router - obviously there are no other candidates.
+	 */
+	rcu_read_lock();
+	router_ifinfo = batadv_neigh_node_get_ifinfo(router, recv_if);
+	hlist_for_each_entry_rcu(cand, &orig_node->ifinfo_list, list) {
+		cand_router = rcu_dereference(cand->router);
+		if (!cand_router)
+			continue;
+
+		if (!atomic_inc_not_zero(&cand_router->refcount))
+			continue;
+
+		cand_ifinfo = batadv_neigh_node_get_ifinfo(cand_router,
+							   cand->if_outgoing);
+		if (!cand_ifinfo)
+			goto next;
+
+		/* alternative candidate should be good enough to be
+		 * considered
+		 */
+		if (!bao->bat_neigh_ifinfo_is_equiv_or_better(cand_ifinfo,
+							      router_ifinfo))
+			goto next;
+
+		/* don't use the same router twice */
+		if (orig_node->last_bonding_candidate &&
+		    (orig_node->last_bonding_candidate->router ==
+		     cand_router))
+				goto next;
+
+		/* mark the first possible candidate */
+		if (!first_candidate) {
+			atomic_inc(&cand_router->refcount);
+			first_candidate = cand;
+			first_candidate_router = cand_router;
+		}
+
+		/* check if already passed the next candidate ... this function
+		 * should get the next candidate AFTER the last used bonding
+		 * candidate.
+		 */
+		if (orig_node->last_bonding_candidate) {
+			if (orig_node->last_bonding_candidate == cand) {
+				last_candidate_found = true;
+				goto next;
+			}
+
+			if (!last_candidate_found)
+				goto next;
+		}
+
+		next_candidate = cand;
+		next_candidate_router = cand_router;
+		break;
+next:
+		batadv_neigh_node_free_ref(cand_router);
+	}
+
+	if (next_candidate) {
+		/* found a possible candidate after the last chosen bonding
+		 * candidate, return it.
+		 */
+		batadv_neigh_node_free_ref(router);
+		if (first_candidate)
+			batadv_neigh_node_free_ref(first_candidate_router);
+		router = next_candidate_router;
+		orig_node->last_bonding_candidate = next_candidate;
+	} else if (first_candidate) {
+		/* found no possible candidate after the last candidate, return
+		 * the first candidate if available, or the already selected
+		 * router otherwise.
+		 */
+		batadv_neigh_node_free_ref(router);
+		router = first_candidate_router;
+		orig_node->last_bonding_candidate = first_candidate;
+	} else {
+		orig_node->last_bonding_candidate = NULL;
+	}
+
+	rcu_read_unlock();
 
 	return router;
 }
diff --git a/routing.h b/routing.h
index 7a7c6e9..2c80b6a 100644
--- a/routing.h
+++ b/routing.h
@@ -46,7 +46,7 @@ int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 struct batadv_neigh_node *
 batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
-		   const struct batadv_hard_iface *recv_if);
+		   struct batadv_hard_iface *recv_if);
 int batadv_window_protected(struct batadv_priv *bat_priv, int32_t seq_num_diff,
 			    unsigned long *last_reset);
 
diff --git a/types.h b/types.h
index 7255500..fa58a14 100644
--- a/types.h
+++ b/types.h
@@ -173,6 +173,7 @@ struct batadv_orig_bat_iv {
  * @orig: originator ethernet address
  * @primary_addr: hosts primary interface address
  * @ifinfo_list: list for routers per outgoing interface
+ * @last_bonding_candidate: pointer to last ifinfo of last used router
  * @batadv_dat_addr_t:  address of the orig node in the distributed hash
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
@@ -213,6 +214,7 @@ struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
 	struct hlist_head ifinfo_list;
+	struct batadv_orig_node_ifinfo *last_bonding_candidate;
 #ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dat_addr;
 #endif
-- 
1.7.10.4

