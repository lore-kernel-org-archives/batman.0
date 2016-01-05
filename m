Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:21 +0100
Message-Id: <1451992006-13191-6-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 06/31] batman-adv: Drop immediate
	batadv_orig_ifinfo free function
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
have to use batadv_orig_ifinfo_free_ref.

Fixes: de6bcc76ea84 ("batman-adv: split out router from orig_node")
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

 net/batman-adv/originator.c | 59 ++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e1eda97..a404005 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -763,76 +763,79 @@ static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly free
- *  the orig_ifinfo (without rcu callback)
+ * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly release
+ *  the orig_ifinfo
  * @orig_ifinfo: the orig_ifinfo object to release
  */
-static void
-batadv_orig_ifinfo_free_ref_now(struct batadv_orig_ifinfo *orig_ifinfo)
+void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo)
 {
 	if (atomic_dec_and_test(&orig_ifinfo->refcount))
-		batadv_orig_ifinfo_free_rcu(&orig_ifinfo->rcu);
+		call_rcu(&orig_ifinfo->rcu, batadv_orig_ifinfo_free_rcu);
 }
 
 /**
- * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly free
- *  the orig_ifinfo
- * @orig_ifinfo: the orig_ifinfo object to release
+ * batadv_orig_node_free_rcu - free the orig_node
+ * @rcu: rcu pointer of the orig_node
  */
-void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo)
+static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 {
-	if (atomic_dec_and_test(&orig_ifinfo->refcount))
-		call_rcu(&orig_ifinfo->rcu, batadv_orig_ifinfo_free_rcu);
+	struct batadv_orig_node *orig_node;
+
+	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
+
+	batadv_mcast_purge_orig(orig_node);
+
+	batadv_frag_purge_orig(orig_node, NULL);
+
+	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
+		orig_node->bat_priv->bat_algo_ops->bat_orig_free(orig_node);
+
+	kfree(orig_node->tt_buff);
+	kfree(orig_node);
 }
 
-static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
+/**
+ * batadv_orig_node_release - release orig_node from lists and queue for
+ *  free after rcu grace period
+ * @orig_node: the orig node to free
+ */
+static void batadv_orig_node_release(struct batadv_orig_node *orig_node)
 {
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
-	struct batadv_orig_node *orig_node;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 
-	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
-
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node_tmp,
 				  &orig_node->neigh_list, list) {
 		hlist_del_rcu(&neigh_node->list);
-		batadv_neigh_node_free_ref_now(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	}
 
 	hlist_for_each_entry_safe(orig_ifinfo, node_tmp,
 				  &orig_node->ifinfo_list, list) {
 		hlist_del_rcu(&orig_ifinfo->list);
-		batadv_orig_ifinfo_free_ref_now(orig_ifinfo);
+		batadv_orig_ifinfo_free_ref(orig_ifinfo);
 	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
-	batadv_mcast_purge_orig(orig_node);
-
 	/* Free nc_nodes */
 	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
 
-	batadv_frag_purge_orig(orig_node, NULL);
-
-	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
-		orig_node->bat_priv->bat_algo_ops->bat_orig_free(orig_node);
-
-	kfree(orig_node->tt_buff);
-	kfree(orig_node);
+	call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
 /**
  * batadv_orig_node_free_ref - decrement the orig node refcounter and possibly
- * schedule an rcu callback for freeing it
+ *  release it
  * @orig_node: the orig node to free
  */
 void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node)
 {
 	if (atomic_dec_and_test(&orig_node->refcount))
-		call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
+		batadv_orig_node_release(orig_node);
 }
 
 void batadv_originator_free(struct batadv_priv *bat_priv)
-- 
2.6.4

