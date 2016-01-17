Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 17 Jan 2016 13:24:39 +0800
Message-Id: <1453008281-15396-7-git-send-email-a@unstable.cc>
In-Reply-To: <1453008281-15396-1-git-send-email-a@unstable.cc>
References: <1453008281-15396-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] batman-adv: Drop immediate neigh_ifinfo
	free function
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
have to use batadv_neigh_ifinfo_free_ref.

Fixes: 89652331c00f ("batman-adv: split tq information in neigh_node struct")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/originator.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0b7ab38e74fc..f68333586681 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -163,42 +163,28 @@ err:
 }
 
 /**
- * batadv_neigh_ifinfo_free_rcu - free the neigh_ifinfo object
- * @rcu: rcu pointer of the neigh_ifinfo object
- */
-static void batadv_neigh_ifinfo_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_neigh_ifinfo *neigh_ifinfo;
-
-	neigh_ifinfo = container_of(rcu, struct batadv_neigh_ifinfo, rcu);
-
-	if (neigh_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
-		batadv_hardif_free_ref_now(neigh_ifinfo->if_outgoing);
-
-	kfree(neigh_ifinfo);
-}
-
-/**
- * batadv_neigh_ifinfo_free_now - decrement the refcounter and possibly free
- *  the neigh_ifinfo (without rcu callback)
+ * batadv_neigh_ifinfo_release - release neigh_ifinfo from lists and queue for
+ *  free after rcu grace period
  * @neigh_ifinfo: the neigh_ifinfo object to release
  */
 static void
-batadv_neigh_ifinfo_free_ref_now(struct batadv_neigh_ifinfo *neigh_ifinfo)
+batadv_neigh_ifinfo_release(struct batadv_neigh_ifinfo *neigh_ifinfo)
 {
-	if (atomic_dec_and_test(&neigh_ifinfo->refcount))
-		batadv_neigh_ifinfo_free_rcu(&neigh_ifinfo->rcu);
+	if (neigh_ifinfo->if_outgoing != BATADV_IF_DEFAULT)
+		batadv_hardif_free_ref(neigh_ifinfo->if_outgoing);
+
+	kfree_rcu(neigh_ifinfo, rcu);
 }
 
 /**
- * batadv_neigh_ifinfo_free_ref - decrement the refcounter and possibly free
+ * batadv_neigh_ifinfo_free_ref - decrement the refcounter and possibly release
  *  the neigh_ifinfo
  * @neigh_ifinfo: the neigh_ifinfo object to release
  */
 void batadv_neigh_ifinfo_free_ref(struct batadv_neigh_ifinfo *neigh_ifinfo)
 {
 	if (atomic_dec_and_test(&neigh_ifinfo->refcount))
-		call_rcu(&neigh_ifinfo->rcu, batadv_neigh_ifinfo_free_rcu);
+		batadv_neigh_ifinfo_release(neigh_ifinfo);
 }
 
 /**
@@ -245,7 +231,7 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
 				  &neigh_node->ifinfo_list, list) {
-		batadv_neigh_ifinfo_free_ref_now(neigh_ifinfo);
+		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
 	}
 
 	hardif_neigh = batadv_hardif_neigh_get(neigh_node->if_incoming,
-- 
2.7.0

