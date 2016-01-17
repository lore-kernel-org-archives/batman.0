Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jan 2016 11:01:18 +0100
Message-Id: <1453024887-7215-10-git-send-email-sven@narfation.org>
In-Reply-To: <1453024887-7215-1-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 10/19] batman-adv: Rename batadv_gw_node
	*_free_ref function to *_put
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

The batman-adv source code is the only place in the kernel which uses the
*_free_ref naming scheme for the *_put functions. Changing it to *_put
makes it more consistent and makes it easier to understand the connection
to the *_get functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v7:
 - removed patches which are now applied in the branch master
 - split *_get -> *_put rename patches into smaller patches only renaming single
   functions
v6:
 - removed patches which are now applied in the branch next
 - rebased remaining patches on the patch
   "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
   modified by Marek while he applied the patches (this unfortunately made
   some of the remaining patches slightly harder to apply)
v5:
 - add hack which allows to compile against stable kernel like 3.2.44 which
   also added the kref_get_unless_zero function
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

 net/batman-adv/gateway_client.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e14ef5b..346d5f7 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -76,11 +76,10 @@ static void batadv_gw_node_release(struct kref *ref)
 }
 
 /**
- * batadv_gw_node_free_ref - decrement the gw_node refcounter and possibly
- *  release it
+ * batadv_gw_node_put - decrement the gw_node refcounter and possibly release it
  * @gw_node: gateway node to free
  */
-static void batadv_gw_node_free_ref(struct batadv_gw_node *gw_node)
+static void batadv_gw_node_put(struct batadv_gw_node *gw_node)
 {
 	kref_put(&gw_node->refcount, batadv_gw_node_release);
 }
@@ -125,7 +124,7 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	return orig_node;
 }
 
@@ -143,7 +142,7 @@ static void batadv_gw_select(struct batadv_priv *bat_priv,
 	rcu_assign_pointer(bat_priv->gw.curr_gw, new_gw_node);
 
 	if (curr_gw_node)
-		batadv_gw_node_free_ref(curr_gw_node);
+		batadv_gw_node_put(curr_gw_node);
 
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
@@ -204,7 +203,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			    ((tmp_gw_factor == max_gw_factor) &&
 			     (tq_avg > max_tq))) {
 				if (curr_gw)
-					batadv_gw_node_free_ref(curr_gw);
+					batadv_gw_node_put(curr_gw);
 				curr_gw = gw_node;
 				kref_get(&curr_gw->refcount);
 			}
@@ -219,7 +218,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			  */
 			if (tq_avg > max_tq) {
 				if (curr_gw)
-					batadv_gw_node_free_ref(curr_gw);
+					batadv_gw_node_put(curr_gw);
 				curr_gw = gw_node;
 				kref_get(&curr_gw->refcount);
 			}
@@ -232,7 +231,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
 
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 
 next:
 		batadv_neigh_node_put(router);
@@ -273,7 +272,7 @@ void batadv_gw_check_client_stop(struct batadv_priv *bat_priv)
 	 */
 	batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_DEL, NULL);
 
-	batadv_gw_node_free_ref(curr_gw);
+	batadv_gw_node_put(curr_gw);
 }
 
 void batadv_gw_election(struct batadv_priv *bat_priv)
@@ -348,9 +347,9 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 
 out:
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 	if (next_gw)
-		batadv_gw_node_free_ref(next_gw);
+		batadv_gw_node_put(next_gw);
 	if (router)
 		batadv_neigh_node_put(router);
 	if (router_ifinfo)
@@ -548,19 +547,19 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		hlist_del_init_rcu(&gw_node->list);
 		spin_unlock_bh(&bat_priv->gw.list_lock);
 
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 		if (gw_node == curr_gw)
 			batadv_gw_reselect(bat_priv);
 
 		if (curr_gw)
-			batadv_gw_node_free_ref(curr_gw);
+			batadv_gw_node_put(curr_gw);
 	}
 
 out:
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 }
 
 void batadv_gw_node_delete(struct batadv_priv *bat_priv,
@@ -583,7 +582,7 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 	hlist_for_each_entry_safe(gw_node, node_tmp,
 				  &bat_priv->gw.list, list) {
 		hlist_del_init_rcu(&gw_node->list);
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	}
 	spin_unlock_bh(&bat_priv->gw.list_lock);
 }
@@ -620,7 +619,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 	ret = seq_has_overflowed(seq) ? -1 : 0;
 
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 out:
 	if (router_ifinfo)
 		batadv_neigh_ifinfo_put(router_ifinfo);
@@ -880,9 +879,9 @@ out:
 	if (orig_dst_node)
 		batadv_orig_node_put(orig_dst_node);
 	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
+		batadv_gw_node_put(curr_gw);
 	if (gw_node)
-		batadv_gw_node_free_ref(gw_node);
+		batadv_gw_node_put(gw_node);
 	if (neigh_old)
 		batadv_neigh_node_put(neigh_old);
 	if (neigh_curr)
-- 
2.7.0.rc3

