Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:38 +0100
Message-Id: <1450222316-1764-5-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/23] batman-adv: Drop
	batadv_hardif_neigh_free_rcu
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

The refactoring of the batadv_hardif_neigh_node reference counting
function converted batadv_hardif_neigh_free_rcu to basically kfree_rcu.
Drop it and just use kfree_rcu instead.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 7735118..f39a715 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -209,28 +209,6 @@ void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
 }
 
 /**
- * batadv_hardif_neigh_free - remove unreferenced hardif neighbor
- * @hardif_neigh: hardif neigh neighbor to free
- */
-static void
-batadv_hardif_neigh_free(struct batadv_hardif_neigh_node *hardif_neigh)
-{
-	kfree(hardif_neigh);
-}
-
-/**
- * batadv_hardif_neigh_free_rcu - free the hardif neigh_node
- * @rcu: rcu pointer of the neigh_node
- */
-static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_hardif_neigh_node *hardif_neigh;
-
-	hardif_neigh = container_of(rcu, struct batadv_hardif_neigh_node, rcu);
-	batadv_hardif_neigh_free(hardif_neigh);
-}
-
-/**
  * batadv_hardif_neigh_release - release hardif neigh node from lists and
  *  queue for free after rcu grace period
  * * @ref: kref pointer of the neigh_node
@@ -247,8 +225,7 @@ static void batadv_hardif_neigh_release(struct kref *ref)
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
 	batadv_hardif_free_ref(hardif_neigh->if_incoming);
-
-	call_rcu(&hardif_neigh->rcu, batadv_hardif_neigh_free_rcu);
+	kfree_rcu(hardif_neigh, rcu);
 }
 
 /**
-- 
2.6.4

