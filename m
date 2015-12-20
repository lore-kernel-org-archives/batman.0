Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 14:17:47 +0100
Message-Id: <1450617490-3544-7-git-send-email-sven@narfation.org>
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 07/30] batman-adv: Drop immediate
	batadv_hardif_neigh_node free function
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

It is not allowed to free the memory of an object which is part of a list
which is protected by rcu-read-side-critical sections without making sure
that no other context is accessing the object anymore. This usually happens
by removing the references to this object and then waiting until the rcu
grace period is over and no one (allowedly) accesses it anymore.

But the _now functions ignore this completely. They free the object
directly even when a different context still tries to access it. This has
to be avoided and thus these functions must be removed and all functions
have to use batadv_hardif_neigh_free_ref.

Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors per hard-interface")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/originator.c | 44 ++++++++++++--------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b1bbe0d..38da601 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -208,34 +208,19 @@ void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
 }
 
 /**
- * batadv_hardif_neigh_free_rcu - free the hardif neigh_node
- * @rcu: rcu pointer of the neigh_node
- */
-static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_hardif_neigh_node *hardif_neigh;
-
-	hardif_neigh = container_of(rcu, struct batadv_hardif_neigh_node, rcu);
-
-	batadv_hardif_free_ref_now(hardif_neigh->if_incoming);
-	kfree(hardif_neigh);
-}
-
-/**
- * batadv_hardif_neigh_free_now - decrement the hardif neighbors refcounter
- *  and possibly free it (without rcu callback)
+ * batadv_hardif_neigh_release - release hardif neigh node from lists and
+ *  queue for free after rcu grace period
  * @hardif_neigh: hardif neigh neighbor to free
  */
 static void
-batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh)
+batadv_hardif_neigh_release(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	if (atomic_dec_and_test(&hardif_neigh->refcount)) {
-		spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-		hlist_del_init_rcu(&hardif_neigh->list);
-		spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+	spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
+	hlist_del_init_rcu(&hardif_neigh->list);
+	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
-		batadv_hardif_neigh_free_rcu(&hardif_neigh->rcu);
-	}
+	batadv_hardif_free_ref(hardif_neigh->if_incoming);
+	kfree_rcu(hardif_neigh, rcu);
 }
 
 /**
@@ -245,13 +230,8 @@ batadv_hardif_neigh_free_now(struct batadv_hardif_neigh_node *hardif_neigh)
  */
 void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	if (atomic_dec_and_test(&hardif_neigh->refcount)) {
-		spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-		hlist_del_init_rcu(&hardif_neigh->list);
-		spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-
-		call_rcu(&hardif_neigh->rcu, batadv_hardif_neigh_free_rcu);
-	}
+	if (atomic_dec_and_test(&hardif_neigh->refcount))
+		batadv_hardif_neigh_release(hardif_neigh);
 }
 
 /**
@@ -278,8 +258,8 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 					       neigh_node->addr);
 	if (hardif_neigh) {
 		/* batadv_hardif_neigh_get() increases refcount too */
-		batadv_hardif_neigh_free_now(hardif_neigh);
-		batadv_hardif_neigh_free_now(hardif_neigh);
+		batadv_hardif_neigh_free_ref(hardif_neigh);
+		batadv_hardif_neigh_free_ref(hardif_neigh);
 	}
 
 	if (bao->bat_neigh_free)
-- 
2.6.4

