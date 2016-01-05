Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:22 +0100
Message-Id: <1451992006-13191-7-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 07/31] batman-adv: Drop immediate
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
To: b.a.t.m.a.n@lists.open-mesh.org

It is not allowed to free the memory of an object which is part of a list
which is protected by rcu-read-side-critical sections without making sure
that no other context is accessing the object anymore. This usually happens
by removing the references to this object and then waiting until the rcu
grace period is over and no one (allowedly) accesses it anymore.

But the _now functions ignore this completely. They free the object
directly even when a different context still tries to access it. This has
to be avoided and thus these functions must be removed and all functions
have to use batadv_neigh_node_free_ref.

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

 net/batman-adv/originator.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index a404005..e2781f0 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -291,20 +291,8 @@ static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
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
@@ -742,24 +730,23 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
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
@@ -770,7 +757,7 @@ static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
 void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo)
 {
 	if (atomic_dec_and_test(&orig_ifinfo->refcount))
-		call_rcu(&orig_ifinfo->rcu, batadv_orig_ifinfo_free_rcu);
+		batadv_orig_ifinfo_release(orig_ifinfo);
 }
 
 /**
-- 
2.6.4

