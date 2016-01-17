Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 17 Jan 2016 13:24:40 +0800
Message-Id: <1453008281-15396-8-git-send-email-a@unstable.cc>
In-Reply-To: <1453008281-15396-1-git-send-email-a@unstable.cc>
References: <1453008281-15396-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 7/8] batman-adv: Drop immediate
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

It is not allowed to free the memory of an object which is part of a list
which is protected by rcu-read-side-critical sections without making sure
that no other context is accessing the object anymore. This usually happens
by removing the references to this object and then waiting until the rcu
grace period is over and no one (allowedly) accesses it anymore.

But the _now functions ignore this completely. They free the object
directly even when a different context still tries to access it. This has
to be avoided and thus these functions must be removed and all functions
have to use batadv_hardif_free_ref.

Fixes: 89652331c00f ("batman-adv: split tq information in neigh_node struct")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/hard-interface.h | 12 ------------
 net/batman-adv/originator.c     | 15 +++++++--------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 5a31420513e1..7b12ea8ea29d 100644
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
index f68333586681..6fdef842ba2a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -215,18 +215,17 @@ void batadv_hardif_neigh_free_ref(struct batadv_hardif_neigh_node *hardif_neigh)
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
@@ -245,9 +244,9 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 	if (bao->bat_neigh_free)
 		bao->bat_neigh_free(neigh_node);
 
-	batadv_hardif_free_ref_now(neigh_node->if_incoming);
+	batadv_hardif_free_ref(neigh_node->if_incoming);
 
-	kfree(neigh_node);
+	kfree_rcu(neigh_node, rcu);
 }
 
 /**
@@ -258,7 +257,7 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
 {
 	if (atomic_dec_and_test(&neigh_node->refcount))
-		call_rcu(&neigh_node->rcu, batadv_neigh_node_free_rcu);
+		batadv_neigh_node_release(neigh_node);
 }
 
 /**
-- 
2.7.0

