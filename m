Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  8 Aug 2015 02:46:45 +0200
Message-Id: <1438994805-5174-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark
	batadv_hardif_neigh_free_now as static
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

batadv_hardif_neigh_free_now is not used outside of originator.c and should
thus be marked as static.

Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors per hard-interface")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 3 ++-
 net/batman-adv/originator.h | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 06f2d1978640..3c782a33bdac 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -224,7 +224,8 @@ static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
  *  and possibly free it (without rcu callback)
  * @hardif_neigh: hardif neigh neighbor to free
  */
-void batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh)
+static void
+batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	if (atomic_dec_and_test(&hardif_neigh->refcount))
 		batadv_hardif_neigh_free_rcu(&hardif_neigh->rcu);
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 8436eb971800..29557753d552 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -46,8 +46,6 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr);
 void
 batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh);
-void
-batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh);
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_orig_node *orig_node,
 		      struct batadv_hard_iface *hard_iface,
-- 
2.5.0

