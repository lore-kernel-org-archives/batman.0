Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:09 +0100
Message-Id: <1392122903-805-10-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 09/23] batman-adv: OGMv2 - purge obsolete
	potential routers
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

If a neighbor is not forwarding OGMs since OGM_SEQ_RANGE
sequence numbers then it can be considered obsolete and
removed from the potential routers list. This may lead to a
route switch.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v_ogm.c  | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 main.h       |  3 ++
 originator.c | 63 +++++++++++++++++++++++------------------
 originator.h |  2 ++
 types.h      |  2 ++
 5 files changed, 131 insertions(+), 31 deletions(-)

diff --git a/bat_v_ogm.c b/bat_v_ogm.c
index 4981d7c..5876164 100644
--- a/bat_v_ogm.c
+++ b/bat_v_ogm.c
@@ -79,8 +79,6 @@ batadv_v_ogm_neigh_new(struct batadv_priv *bat_priv,
 		return NULL;
 	}
 
-	neigh_node->bat_v.elp_neigh = elp_neigh;
-
 	spin_lock_bh(&orig_node->neigh_list_lock);
 	tmp_neigh_node = batadv_neigh_node_get(orig_node, hard_iface, addr);
 	if (!tmp_neigh_node) {
@@ -98,6 +96,8 @@ batadv_v_ogm_neigh_new(struct batadv_priv *bat_priv,
 			   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
 			   addr, orig_node->orig, hard_iface->net_dev->name);
 
+	neigh_node->bat_v.elp_neigh = elp_neigh;
+
 	return neigh_node;
 }
 
@@ -235,6 +235,86 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 	rcu_read_unlock();
 }
 
+static bool batadv_ogm_deselect_router(struct batadv_priv *bat_priv,
+				       struct batadv_orig_node *orig_node,
+				       struct batadv_neigh_node *neigh)
+{
+	struct batadv_hard_iface *if_outgoing;
+	struct batadv_neigh_node *router;
+	bool removed = false;
+
+	router = batadv_orig_router_get(orig_node, BATADV_IF_DEFAULT);
+	if (router == neigh)
+		batadv_update_route(bat_priv, orig_node, BATADV_IF_DEFAULT,
+				    NULL);
+	if (router)
+		batadv_neigh_node_free_ref(router);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(if_outgoing, &batadv_hardif_list, list) {
+		if (if_outgoing->if_status != BATADV_IF_ACTIVE)
+			continue;
+
+		if (if_outgoing->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		router = batadv_orig_router_get(orig_node, if_outgoing);
+		/* if this is the current router, unset it */
+		if (router == neigh) {
+			batadv_update_route(bat_priv, orig_node, if_outgoing,
+					    NULL);
+			removed = true;
+		}
+		if (router)
+			batadv_neigh_node_free_ref(router);
+	}
+	rcu_read_unlock();
+
+	return removed;
+}
+
+/**
+ * batadv_v_ogm_purge_neighs - purge obsolete potential routers
+ * @bat_priv:
+ * @orig_node:
+ * @seqno:
+ *
+ * Purge routers from which this node did not receive at least
+ * BATADV_OGM_SEQ_RANGE OGMs
+ */
+static void batadv_v_ogm_purge_neighs(struct batadv_priv *bat_priv,
+				      struct batadv_orig_node *orig_node,
+				      uint32_t seqno)
+{
+	struct batadv_neigh_node *neigh;
+	struct hlist_node *node_tmp;
+	int32_t diff;
+
+	rcu_read_lock();
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	hlist_for_each_entry_safe(neigh, node_tmp, &orig_node->neigh_list,
+				  list) {
+		diff = seqno - neigh->bat_v.last_recv_seqno;
+		if (diff < BATADV_OGM_SEQ_RANGE)
+			continue;
+
+		hlist_del_rcu(&neigh->list);
+		batadv_neigh_node_free_ref(neigh);
+	}
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
+	/* check if this neighbour is a router for any outgoing
+	 * interface and possibly deselect it
+	 */
+	if (batadv_ogm_deselect_router(bat_priv, orig_node, neigh))
+		goto out;
+
+	batadv_router_selection(bat_priv, orig_node);
+out:
+	rcu_read_unlock();
+	return;
+}
+
 static void
 batadv_v_ogm_orig_update(struct batadv_priv *bat_priv,
 			 struct batadv_orig_node *orig_node,
@@ -262,7 +342,7 @@ batadv_v_ogm_orig_update(struct batadv_priv *bat_priv,
 	batadv_orig_ifinfo_free_ref(orig_ifinfo);
 
 	/* if this neighbor already is our next hop there is nothing
-	 * to change
+	 * to change. The router may have been changed by the purge routine
 	 */
 	router = batadv_orig_router_get(orig_node, if_outgoing);
 	if (router == neigh_node)
@@ -547,6 +627,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 
 	/* update the neigh_node information */
 	neigh_node->last_seen = jiffies;
+	neigh_node->bat_v.last_recv_seqno = ntohl(ogm2->seqno);
 
 	/* update the received metric to match the node topology: if this node
 	 * is the first hop traversed by the OGM, then the metric is substituted
@@ -579,6 +660,11 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	}
 	rcu_read_unlock();
 
+	/* purge potential neighs not forwarding OGMs anymore.
+	 * This may lead to a router change
+	 */
+	batadv_v_ogm_purge_neighs(bat_priv, orig_node, ntohl(ogm2->seqno));
+
 	ret = NET_RX_SUCCESS;
 	consume_skb(skb);
 
diff --git a/main.h b/main.h
index 4badd01..47fb9ed 100644
--- a/main.h
+++ b/main.h
@@ -62,6 +62,9 @@
 /* number of OGMs sent with the last tt diff */
 #define BATADV_TT_OGM_APPEND_MAX 3
 
+/* number of missing OGMs to wait before considering a router unusable */
+#define BATADV_OGM_SEQ_RANGE	5
+
 /* Time in which a client can roam at most ROAMING_MAX_COUNT times in
  * milliseconds
  */
diff --git a/originator.c b/originator.c
index 9f2da37..447f417 100644
--- a/originator.c
+++ b/originator.c
@@ -837,6 +837,40 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 	return best;
 }
 
+void batadv_router_selection(struct batadv_priv *bat_priv,
+				    struct batadv_orig_node *orig_node)
+{
+	struct batadv_neigh_node *best_neigh_node;
+	struct batadv_hard_iface *hard_iface;
+
+	 /* First for the default routing table ... */
+	best_neigh_node = batadv_find_best_neighbor(bat_priv, orig_node,
+						    BATADV_IF_DEFAULT);
+	batadv_update_route(bat_priv, orig_node, BATADV_IF_DEFAULT,
+			    best_neigh_node);
+	if (best_neigh_node)
+		batadv_neigh_node_free_ref(best_neigh_node);
+
+	/* ... then for all other outgoing interfaces. */
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
+			continue;
+
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		best_neigh_node = batadv_find_best_neighbor(bat_priv,
+							    orig_node,
+							    hard_iface);
+		batadv_update_route(bat_priv, orig_node, hard_iface,
+				    best_neigh_node);
+		if (best_neigh_node)
+			batadv_neigh_node_free_ref(best_neigh_node);
+	}
+	rcu_read_unlock();
+}
+
 /**
  * batadv_purge_orig_node - purges obsolete information from an orig_node
  * @bat_priv: the bat priv with all the soft interface information
@@ -850,8 +884,6 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node)
 {
-	struct batadv_neigh_node *best_neigh_node;
-	struct batadv_hard_iface *hard_iface;
 	bool changed;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
@@ -868,32 +900,7 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 	if (!changed)
 		return false;
 
-	/* first for NULL ... */
-	best_neigh_node = batadv_find_best_neighbor(bat_priv, orig_node,
-						    BATADV_IF_DEFAULT);
-	batadv_update_route(bat_priv, orig_node, BATADV_IF_DEFAULT,
-			    best_neigh_node);
-	if (best_neigh_node)
-		batadv_neigh_node_free_ref(best_neigh_node);
-
-	/* ... then for all other interfaces. */
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->if_status != BATADV_IF_ACTIVE)
-			continue;
-
-		if (hard_iface->soft_iface != bat_priv->soft_iface)
-			continue;
-
-		best_neigh_node = batadv_find_best_neighbor(bat_priv,
-							    orig_node,
-							    hard_iface);
-		batadv_update_route(bat_priv, orig_node, hard_iface,
-				    best_neigh_node);
-		if (best_neigh_node)
-			batadv_neigh_node_free_ref(best_neigh_node);
-	}
-	rcu_read_unlock();
+	batadv_router_selection(bat_priv, orig_node);
 
 	return false;
 }
diff --git a/originator.h b/originator.h
index db3a9ed..62e8e68 100644
--- a/originator.h
+++ b/originator.h
@@ -55,6 +55,8 @@ struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing);
 void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo);
+void batadv_router_selection(struct batadv_priv *bat_priv,
+				    struct batadv_orig_node *orig_node);
 
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
diff --git a/types.h b/types.h
index e9149d1..28f2b85 100644
--- a/types.h
+++ b/types.h
@@ -358,9 +358,11 @@ struct batadv_elp_neigh_node {
 /**
  * batadv_neigh_node_bat_v - B.A.T.M.A.N. V private neighbor information
  * @elp_neigh: ELP private neighbour data
+ * @last_recv_seqno: last OGM seqno received through this neighbour
  */
 struct batadv_neigh_node_bat_v {
 	struct batadv_elp_neigh_node *elp_neigh;
+	uint32_t last_recv_seqno;
 };
 
 /**
-- 
1.8.5.3

