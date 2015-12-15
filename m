Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:37 +0100
Message-Id: <1450222316-1764-4-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/23] batman-adv: Drop immediate free
	functions for batadv_hardif_neigh_node
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

But the _now functions ignore this completely. They delete the entry from
the lists and immediately frees the entry. This has to be avoided and thus
these functions must be removed and all functions have to use instead
batadv_hardif_neigh_put.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 42 +++++-------------------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 18305d3..7735118 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -219,38 +219,6 @@ batadv_hardif_neigh_free(struct batadv_hardif_neigh_node *hardif_neigh)
 }
 
 /**
- * batadv_hardif_neigh_release_now - release hardif neigh node from lists and
- *  free without waiting for rcu grace period
- * @ref: kref pointer of the neigh_node
- */
-static void batadv_hardif_neigh_release_now(struct kref *ref)
-{
-	struct batadv_hardif_neigh_node *hardif_neigh;
-
-	hardif_neigh = container_of(ref, struct batadv_hardif_neigh_node,
-				    refcount);
-
-	spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-	hlist_del_init_rcu(&hardif_neigh->list);
-	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
-
-	batadv_hardif_free_ref_now(hardif_neigh->if_incoming);
-
-	batadv_hardif_neigh_free(hardif_neigh);
-}
-
-/**
- * batadv_hardif_neigh_put_now - decrement the hardif neighbors refcounter
- *  and possibly release it (without rcu callback)
- * @hardif_neigh: hardif neigh neighbor to free
- */
-static void
-batadv_hardif_neigh_put_now(struct batadv_hardif_neigh_node *hardif_neigh)
-{
-	kref_put(&hardif_neigh->refcount, batadv_hardif_neigh_release_now);
-}
-
-/**
  * batadv_hardif_neigh_free_rcu - free the hardif neigh_node
  * @rcu: rcu pointer of the neigh_node
  */
@@ -263,11 +231,11 @@ static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_hardif_neigh_release_rcu - release hardif neigh node from lists and
+ * batadv_hardif_neigh_release - release hardif neigh node from lists and
  *  queue for free after rcu grace period
  * * @ref: kref pointer of the neigh_node
  */
-static void batadv_hardif_neigh_release_rcu(struct kref *ref)
+static void batadv_hardif_neigh_release(struct kref *ref)
 {
 	struct batadv_hardif_neigh_node *hardif_neigh;
 
@@ -290,7 +258,7 @@ static void batadv_hardif_neigh_release_rcu(struct kref *ref)
  */
 void batadv_hardif_neigh_put(struct batadv_hardif_neigh_node *hardif_neigh)
 {
-	kref_put(&hardif_neigh->refcount, batadv_hardif_neigh_release_rcu);
+	kref_put(&hardif_neigh->refcount, batadv_hardif_neigh_release);
 }
 
 /**
@@ -317,8 +285,8 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 					       neigh_node->addr);
 	if (hardif_neigh) {
 		/* batadv_hardif_neigh_get() increases refcount too */
-		batadv_hardif_neigh_put_now(hardif_neigh);
-		batadv_hardif_neigh_put_now(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
+		batadv_hardif_neigh_put(hardif_neigh);
 	}
 
 	if (bao->bat_neigh_free)
-- 
2.6.4

