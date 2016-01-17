Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 17 Jan 2016 13:24:37 +0800
Message-Id: <1453008281-15396-5-git-send-email-a@unstable.cc>
In-Reply-To: <1453008281-15396-1-git-send-email-a@unstable.cc>
References: <1453008281-15396-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] batman-adv: Drop immediate
	batadv_neigh_node free function
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
have to use batadv_neigh_node_free_ref.

Fixes: 89652331c00f ("batman-adv: split tq information in neigh_node struct")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/originator.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 6929acc1d61a..78fd4eab2169 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -285,20 +285,8 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_neigh_node_free_ref_now - decrement the neighbors refcounter
- *  and possibly free it (without rcu callback)
- * @neigh_node: neigh neighbor to free
- */
-static void
-batadv_neigh_node_free_ref_now(struct batadv_neigh_node *neigh_node)
-{
-	if (atomic_dec_and_test(&neigh_node->refcount))
-		batadv_neigh_node_free_rcu(&neigh_node->rcu);
-}
-
-/**
  * batadv_neigh_node_free_ref - decrement the neighbors refcounter
- *  and possibly free it
+ *  and possibly release it
  * @neigh_node: neigh neighbor to free
  */
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
@@ -733,24 +721,23 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 }
 
 /**
- * batadv_orig_ifinfo_free_rcu - free the orig_ifinfo object
- * @rcu: rcu pointer of the orig_ifinfo object
+ * batadv_orig_ifinfo_release - release orig_ifinfo from lists and queue for
+ *  free after rcu grace period
+ * @orig_ifinfo: the orig_ifinfo object to release
  */
-static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
+static void batadv_orig_ifinfo_release(struct batadv_orig_ifinfo *orig_ifinfo)
 {
-	struct batadv_orig_ifinfo *orig_ifinfo;
 	struct batadv_neigh_node *router;
 
-	orig_ifinfo = container_of(rcu, struct batadv_orig_ifinfo, rcu);
-
 	if (orig_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
-		batadv_hardif_free_ref_now(orig_ifinfo->if_outgoing);
+		batadv_hardif_free_ref(orig_ifinfo->if_outgoing);
 
 	/* this is the last reference to this object */
 	router = rcu_dereference_protected(orig_ifinfo->router, true);
 	if (router)
-		batadv_neigh_node_free_ref_now(router);
-	kfree(orig_ifinfo);
+		batadv_neigh_node_free_ref(router);
+
+	kfree_rcu(orig_ifinfo, rcu);
 }
 
 /**
@@ -761,7 +748,7 @@ static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
 void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo)
 {
 	if (atomic_dec_and_test(&orig_ifinfo->refcount))
-		call_rcu(&orig_ifinfo->rcu, batadv_orig_ifinfo_free_rcu);
+		batadv_orig_ifinfo_release(orig_ifinfo);
 }
 
 /**
-- 
2.7.0

