Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 17 Jan 2016 13:24:36 +0800
Message-Id: <1453008281-15396-4-git-send-email-a@unstable.cc>
In-Reply-To: <1453008281-15396-1-git-send-email-a@unstable.cc>
References: <1453008281-15396-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: Drop immediate
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
have to use batadv_orig_ifinfo_free_ref.

Fixes: 7351a4822d42 ("batman-adv: split out router from orig_node")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/originator.c | 77 +++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ae6d18cafc5a..6929acc1d61a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -754,19 +754,7 @@ static void batadv_orig_ifinfo_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly free
- *  the orig_ifinfo (without rcu callback)
- * @orig_ifinfo: the orig_ifinfo object to release
- */
-static void
-batadv_orig_ifinfo_free_ref_now(struct batadv_orig_ifinfo *orig_ifinfo)
-{
-	if (atomic_dec_and_test(&orig_ifinfo->refcount))
-		batadv_orig_ifinfo_free_rcu(&orig_ifinfo->rcu);
-}
-
-/**
- * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly free
+ * batadv_orig_ifinfo_free_ref - decrement the refcounter and possibly release
  *  the orig_ifinfo
  * @orig_ifinfo: the orig_ifinfo object to release
  */
@@ -776,36 +764,18 @@ void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo)
 		call_rcu(&orig_ifinfo->rcu, batadv_orig_ifinfo_free_rcu);
 }
 
+/**
+ * batadv_orig_node_free_rcu - free the orig_node
+ * @rcu: rcu pointer of the orig_node
+ */
 static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 {
-	struct hlist_node *node_tmp;
-	struct batadv_neigh_node *neigh_node;
 	struct batadv_orig_node *orig_node;
-	struct batadv_orig_ifinfo *orig_ifinfo;
 
 	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
 
-	spin_lock_bh(&orig_node->neigh_list_lock);
-
-	/* for all neighbors towards this originator ... */
-	hlist_for_each_entry_safe(neigh_node, node_tmp,
-				  &orig_node->neigh_list, list) {
-		hlist_del_rcu(&neigh_node->list);
-		batadv_neigh_node_free_ref_now(neigh_node);
-	}
-
-	hlist_for_each_entry_safe(orig_ifinfo, node_tmp,
-				  &orig_node->ifinfo_list, list) {
-		hlist_del_rcu(&orig_ifinfo->list);
-		batadv_orig_ifinfo_free_ref_now(orig_ifinfo);
-	}
-	spin_unlock_bh(&orig_node->neigh_list_lock);
-
 	batadv_mcast_purge_orig(orig_node);
 
-	/* Free nc_nodes */
-	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
-
 	batadv_frag_purge_orig(orig_node, NULL);
 
 	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
@@ -816,14 +786,47 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 }
 
 /**
+ * batadv_orig_node_release - release orig_node from lists and queue for
+ *  free after rcu grace period
+ * @orig_node: the orig node to free
+ */
+static void batadv_orig_node_release(struct batadv_orig_node *orig_node)
+{
+	struct hlist_node *node_tmp;
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_orig_ifinfo *orig_ifinfo;
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+
+	/* for all neighbors towards this originator ... */
+	hlist_for_each_entry_safe(neigh_node, node_tmp,
+				  &orig_node->neigh_list, list) {
+		hlist_del_rcu(&neigh_node->list);
+		batadv_neigh_node_free_ref(neigh_node);
+	}
+
+	hlist_for_each_entry_safe(orig_ifinfo, node_tmp,
+				  &orig_node->ifinfo_list, list) {
+		hlist_del_rcu(&orig_ifinfo->list);
+		batadv_orig_ifinfo_free_ref(orig_ifinfo);
+	}
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
+	/* Free nc_nodes */
+	batadv_nc_purge_orig(orig_node->bat_priv, orig_node, NULL);
+
+	call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
+}
+
+/**
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
 
 /**
-- 
2.7.0

