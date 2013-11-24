Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sun, 24 Nov 2013 14:05:45 +0100
Message-Id: <1385298345-13746-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1385298345-13746-1-git-send-email-sw@simonwunderlich.de>
References: <1385298345-13746-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: fix rcu pointer comparison
	problem
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

sparse complained about:

routing.c:482:64: error: incompatible types in comparison expression
(different address spaces)

This was due to comparing a __rcu pointer with a regular one. Fix that
by adding the missing rcu_dereference call. A temporary variable is used
to comply with the line length limit, use the opportunity to beautify a
few other places.

This problem was introduced in commit
797edd9e87ac838711e03498a4ae795b600191af ("batman-adv: add bonding
again")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 routing.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/routing.c b/routing.c
index 23311f5..7aac5b3 100644
--- a/routing.c
+++ b/routing.c
@@ -430,8 +430,10 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *first_candidate_router = NULL;
 	struct batadv_neigh_node *next_candidate_router = NULL;
 	struct batadv_neigh_node *router, *cand_router = NULL;
+	struct batadv_neigh_node *last_cand_router = NULL;
 	struct batadv_orig_ifinfo *cand, *first_candidate = NULL;
 	struct batadv_orig_ifinfo *next_candidate = NULL;
+	struct batadv_orig_ifinfo *last_candidate;
 	bool last_candidate_found = false;
 
 	if (!orig_node)
@@ -455,6 +457,10 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	 * router - obviously there are no other candidates.
 	 */
 	rcu_read_lock();
+	last_candidate = orig_node->last_bonding_candidate;
+	if (last_candidate)
+		last_cand_router = rcu_dereference(last_candidate->router);
+
 	hlist_for_each_entry_rcu(cand, &orig_node->ifinfo_list, list) {
 		/* acquire some structures and references ... */
 		if (!atomic_inc_not_zero(&cand->refcount))
@@ -478,9 +484,8 @@ batadv_find_router(struct batadv_priv *bat_priv,
 			goto next;
 
 		/* don't use the same router twice */
-		if (orig_node->last_bonding_candidate &&
-		    (orig_node->last_bonding_candidate->router == cand_router))
-				goto next;
+		if (last_cand_router == cand_router)
+			goto next;
 
 		/* mark the first possible candidate */
 		if (!first_candidate) {
@@ -494,14 +499,13 @@ batadv_find_router(struct batadv_priv *bat_priv,
 		 * candidate ... this function should select the next candidate
 		 * AFTER the previously used bonding candidate.
 		 */
-		if (!orig_node->last_bonding_candidate ||
-		    last_candidate_found) {
+		if (!last_candidate || last_candidate_found) {
 			next_candidate = cand;
 			next_candidate_router = cand_router;
 			break;
 		}
 
-		if (orig_node->last_bonding_candidate == cand)
+		if (last_candidate == cand)
 			last_candidate_found = true;
 next:
 		/* free references */
-- 
1.7.10.4

