Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Dec 2015 14:17:49 +0100
Message-Id: <1450617490-3544-9-git-send-email-sven@narfation.org>
In-Reply-To: <1450617490-3544-1-git-send-email-sven@narfation.org>
References: <1450617490-3544-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 09/30] batman-adv: Drop immediate
	batadv_hard_iface free function
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
have to use batadv_hardif_free_ref.

Fixes: 9bb33b8d88e3 ("batman-adv: split tq information in neigh_node struct")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/hard-interface.h | 12 ------------
 net/batman-adv/originator.c     | 15 +++++++--------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 5a31420..7b12ea8 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -75,18 +75,6 @@ batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
 		call_rcu(&hard_iface->rcu, batadv_hardif_free_rcu);
 }
 
-/**
- * batadv_hardif_free_ref_now - decrement the hard interface refcounter and
- *  possibly free it (without rcu callback)
- * @hard_iface: the hard interface to free
- */
-static inline void
-batadv_hardif_free_ref_now(struct batadv_hard_iface *hard_iface)
-{
-	if (atomic_dec_and_test(&hard_iface->refcount))
-		batadv_hardif_free_rcu(&hard_iface->rcu);
-}
-
 static inline struct batadv_hard_iface *
 batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 {
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 540aa2c..ef82614 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -221,18 +221,17 @@ void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh)
 }
 
 /**
- * batadv_neigh_node_free_rcu - free the neigh_node
- * @rcu: rcu pointer of the neigh_node
+ * batadv_neigh_node_release - release neigh_node from lists and queue for
+ *  free after rcu grace period
+ * @neigh_node: neigh neighbor to free
  */
-static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
+static void batadv_neigh_node_release(struct batadv_neigh_node *neigh_node)
 {
 	struct hlist_node *node_tmp;
-	struct batadv_neigh_node *neigh_node;
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_neigh_ifinfo *neigh_ifinfo;
 	struct batadv_algo_ops *bao;
 
-	neigh_node = container_of(rcu, struct batadv_neigh_node, rcu);
 	bao = neigh_node->orig_node->bat_priv->bat_algo_ops;
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
@@ -251,9 +250,9 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 	if (bao->bat_neigh_free)
 		bao->bat_neigh_free(neigh_node);
 
-	batadv_hardif_free_ref_now(neigh_node->if_incoming);
+	batadv_hardif_free_ref(neigh_node->if_incoming);
 
-	kfree(neigh_node);
+	kfree_rcu(neigh_node, rcu);
 }
 
 /**
@@ -264,7 +263,7 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
 {
 	if (atomic_dec_and_test(&neigh_node->refcount))
-		call_rcu(&neigh_node->rcu, batadv_neigh_node_free_rcu);
+		batadv_neigh_node_release(neigh_node);
 }
 
 /**
-- 
2.6.4

