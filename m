Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 26 Jun 2015 13:11:25 +0200
Message-Id: <1435317085-31015-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: remove obsolete deleted
	attribute for gateway node
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

With rcu, the gateway node deleted attribute is not needed anymore. In
fact, it may delay the free of the gateway node and its referenced
structures. Therefore remove it altogether and simplify purging as well.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to PATCH:
 * iterator through list to remove the element when deleting to
   avoid possible double list remove
---
 net/batman-adv/gateway_client.c | 52 +++++++++++++++--------------------------
 net/batman-adv/originator.c     |  1 -
 net/batman-adv/types.h          |  2 --
 3 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 97f7c44..6af5dab 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -165,9 +165,6 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
-		if (gw_node->deleted)
-			continue;
-
 		orig_node = gw_node->orig_node;
 		router = batadv_orig_router_get(orig_node, BATADV_IF_DEFAULT);
 		if (!router)
@@ -475,9 +472,6 @@ batadv_gw_node_get(struct batadv_priv *bat_priv,
 		if (gw_node_tmp->orig_node != orig_node)
 			continue;
 
-		if (gw_node_tmp->deleted)
-			continue;
-
 		if (!atomic_inc_not_zero(&gw_node_tmp->refcount))
 			continue;
 
@@ -500,7 +494,8 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 			   struct batadv_orig_node *orig_node,
 			   struct batadv_tvlv_gateway_data *gateway)
 {
-	struct batadv_gw_node *gw_node, *curr_gw = NULL;
+	struct batadv_gw_node *gw_node, *gw_node_tmp, *curr_gw = NULL;
+	struct hlist_node *node_tmp;
 
 	gw_node = batadv_gw_node_get(bat_priv, orig_node);
 	if (!gw_node) {
@@ -527,9 +522,7 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
 	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
 
-	gw_node->deleted = 0;
 	if (ntohl(gateway->bandwidth_down) == 0) {
-		gw_node->deleted = jiffies;
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Gateway %pM removed from gateway list\n",
 			   orig_node->orig);
@@ -537,14 +530,26 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
 		/* Note: We don't need a NULL check here, since curr_gw never
 		 * gets dereferenced.
 		 */
+		spin_lock_bh(&bat_priv->gw.list_lock);
+		hlist_for_each_entry_safe(gw_node_tmp, node_tmp,
+					  &bat_priv->gw.list, list) {
+			if (gw_node_tmp != gw_node)
+				continue;
+
+			hlist_del_rcu(&gw_node->list);
+			batadv_gw_node_free_ref(gw_node);
+		}
+		spin_unlock_bh(&bat_priv->gw.list_lock);
+
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 		if (gw_node == curr_gw)
 			batadv_gw_reselect(bat_priv);
+
+		if (curr_gw)
+			batadv_gw_node_free_ref(curr_gw);
 	}
 
 out:
-	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
 	if (gw_node)
 		batadv_gw_node_free_ref(gw_node);
 }
@@ -562,37 +567,21 @@ void batadv_gw_node_delete(struct batadv_priv *bat_priv,
 
 void batadv_gw_node_purge(struct batadv_priv *bat_priv)
 {
-	struct batadv_gw_node *gw_node, *curr_gw;
+	struct batadv_gw_node *gw_node;
 	struct hlist_node *node_tmp;
-	unsigned long timeout = msecs_to_jiffies(2 * BATADV_PURGE_TIMEOUT);
-	int do_reselect = 0;
 
-	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE)
+		return;
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
-
 	hlist_for_each_entry_safe(gw_node, node_tmp,
 				  &bat_priv->gw.list, list) {
-		if (((!gw_node->deleted) ||
-		     (time_before(jiffies, gw_node->deleted + timeout))) &&
-		    atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE)
-			continue;
-
-		if (curr_gw == gw_node)
-			do_reselect = 1;
 
 		hlist_del_rcu(&gw_node->list);
 		batadv_gw_node_free_ref(gw_node);
 	}
 
 	spin_unlock_bh(&bat_priv->gw.list_lock);
-
-	/* gw_reselect() needs to acquire the gw_list_lock */
-	if (do_reselect)
-		batadv_gw_reselect(bat_priv);
-
-	if (curr_gw)
-		batadv_gw_node_free_ref(curr_gw);
 }
 
 /* fails if orig_node has no router */
@@ -656,9 +645,6 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
-		if (gw_node->deleted)
-			continue;
-
 		/* fails if orig_node has no router */
 		if (batadv_write_buffer_text(bat_priv, seq, gw_node) < 0)
 			continue;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 4500e3a..016fc20 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1009,7 +1009,6 @@ static void _batadv_purge_orig(struct batadv_priv *bat_priv)
 		spin_unlock_bh(list_lock);
 	}
 
-	batadv_gw_node_purge(bat_priv);
 	batadv_gw_election(bat_priv);
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index da4c738..002bca4 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -328,7 +328,6 @@ enum batadv_orig_capabilities {
  * @orig_node: pointer to corresponding orig node
  * @bandwidth_down: advertised uplink download bandwidth
  * @bandwidth_up: advertised uplink upload bandwidth
- * @deleted: this struct is scheduled for deletion
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
@@ -337,7 +336,6 @@ struct batadv_gw_node {
 	struct batadv_orig_node *orig_node;
 	u32 bandwidth_down;
 	u32 bandwidth_up;
-	unsigned long deleted;
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
-- 
2.1.4

