Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:24 +0100
Message-Id: <1451992006-13191-9-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 09/31] batman-adv: Drop immediate
	neigh_ifinfo free function
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
have to use batadv_neigh_ifinfo_free_ref.

Fixes: 9bb33b8d88e3 ("batman-adv: split tq information in neigh_node struct")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v4:
 - fix function names in commit messages
 - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
 - add extra patch for batadv_claim_free_ref kerneldoc fix
 - change the phrase "free it" in all *_free_ref/*_put functions to "release it"
v3:
 - update copyright year
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/originator.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0fb654d..229651f 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -169,42 +169,28 @@ err:
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
@@ -251,7 +237,7 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
 
 	hlist_for_each_entry_safe(neigh_ifinfo, node_tmp,
 				  &neigh_node->ifinfo_list, list) {
-		batadv_neigh_ifinfo_free_ref_now(neigh_ifinfo);
+		batadv_neigh_ifinfo_free_ref(neigh_ifinfo);
 	}
 
 	hardif_neigh = batadv_hardif_neigh_get(neigh_node->if_incoming,
-- 
2.6.4

