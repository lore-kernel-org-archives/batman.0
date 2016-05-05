Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Fri,  6 May 2016 02:46:40 +0800
Message-Id: <1462474003-25279-4-git-send-email-a@unstable.cc>
In-Reply-To: <1462474003-25279-1-git-send-email-a@unstable.cc>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: split routing API data
	structure in subobjects
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
Cc: Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch

The routing API data structure contains several function
pointers that can easily be grouped together based on the
component they work with.

Split the API in subobjects in order to improve definition readability.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_iv_ogm.c        | 32 ++++++++-------
 net/batman-adv/bat_v.c             | 26 ++++++++-----
 net/batman-adv/gateway_client.c    |  8 ++--
 net/batman-adv/hard-interface.c    | 16 ++++----
 net/batman-adv/main.c              | 12 +++---
 net/batman-adv/originator.c        | 30 +++++++-------
 net/batman-adv/routing.c           |  2 +-
 net/batman-adv/translation-table.c |  2 +-
 net/batman-adv/types.h             | 80 +++++++++++++++++++++-----------------
 9 files changed, 114 insertions(+), 94 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 67bdba1..f2db86b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1849,7 +1849,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	/* did we receive a B.A.T.M.A.N. IV OGM packet on an interface
 	 * that does not have B.A.T.M.A.N. IV enabled ?
 	 */
-	if (bat_priv->bat_algo_ops->bat_iface_enable !=
+	if (bat_priv->bat_algo_ops->iface.bat_enable !=
 	    batadv_iv_ogm_iface_enable)
 		return NET_RX_DROP;
 
@@ -2116,18 +2116,24 @@ static void batadv_iv_iface_activate(struct batadv_hard_iface *hard_iface)
 
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
-	.bat_iface_activate = batadv_iv_iface_activate,
-	.bat_iface_enable = batadv_iv_ogm_iface_enable,
-	.bat_iface_disable = batadv_iv_ogm_iface_disable,
-	.bat_iface_update_mac = batadv_iv_ogm_iface_update_mac,
-	.bat_primary_iface_set = batadv_iv_ogm_primary_iface_set,
-	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
-	.bat_neigh_is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
-	.bat_neigh_print = batadv_iv_neigh_print,
-	.bat_orig_print = batadv_iv_ogm_orig_print,
-	.bat_orig_free = batadv_iv_ogm_orig_free,
-	.bat_orig_add_if = batadv_iv_ogm_orig_add_if,
-	.bat_orig_del_if = batadv_iv_ogm_orig_del_if,
+	.iface = {
+		.bat_activate = batadv_iv_iface_activate,
+		.bat_enable = batadv_iv_ogm_iface_enable,
+		.bat_disable = batadv_iv_ogm_iface_disable,
+		.bat_update_mac = batadv_iv_ogm_iface_update_mac,
+		.bat_primary_set = batadv_iv_ogm_primary_iface_set,
+	},
+	.neigh = {
+		.bat_cmp = batadv_iv_ogm_neigh_cmp,
+		.bat_is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
+		.bat_print = batadv_iv_neigh_print,
+	},
+	.orig = {
+		.bat_print = batadv_iv_ogm_orig_print,
+		.bat_free = batadv_iv_ogm_orig_free,
+		.bat_add_if = batadv_iv_ogm_orig_add_if,
+		.bat_del_if = batadv_iv_ogm_orig_del_if,
+	},
 };
 
 int __init batadv_iv_init(void)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 932cd56..c6e4bf3 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -322,16 +322,22 @@ static ssize_t batadv_v_show_sel_class(struct batadv_priv *bat_priv, char *buff)
 
 static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.name = "BATMAN_V",
-	.bat_iface_activate = batadv_v_iface_activate,
-	.bat_iface_enable = batadv_v_iface_enable,
-	.bat_iface_disable = batadv_v_iface_disable,
-	.bat_iface_update_mac = batadv_v_iface_update_mac,
-	.bat_primary_iface_set = batadv_v_primary_iface_set,
-	.bat_hardif_neigh_init = batadv_v_hardif_neigh_init,
-	.bat_orig_print = batadv_v_orig_print,
-	.bat_neigh_cmp = batadv_v_neigh_cmp,
-	.bat_neigh_is_similar_or_better = batadv_v_neigh_is_sob,
-	.bat_neigh_print = batadv_v_neigh_print,
+	.iface = {
+		.bat_activate = batadv_v_iface_activate,
+		.bat_enable = batadv_v_iface_enable,
+		.bat_disable = batadv_v_iface_disable,
+		.bat_update_mac = batadv_v_iface_update_mac,
+		.bat_primary_set = batadv_v_primary_iface_set,
+	},
+	.neigh = {
+		.bat_hardif_init = batadv_v_hardif_neigh_init,
+		.bat_cmp = batadv_v_neigh_cmp,
+		.bat_is_similar_or_better = batadv_v_neigh_is_sob,
+		.bat_print = batadv_v_neigh_print,
+	},
+	.orig = {
+		.bat_print = batadv_v_orig_print,
+	},
 	.gw = {
 		.bat_store_sel_class = batadv_v_store_sel_class,
 		.bat_show_sel_class = batadv_v_show_sel_class,
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 31ba24e..acf85b1 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -638,10 +638,10 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq,
-		   "      %-12s (%s/%i) %17s [%10s]: advertised uplink bandwidth ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
-		   "Gateway", "#", BATADV_TQ_MAX_VALUE, "Nexthop", "outgoingIF",
-		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
-		   primary_if->net_dev->dev_addr, net_dev->name);
+		   "      Gateway      (#/%i)           Nexthop [outgoingIF]: advertised uplink bandwidth ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
+		   BATADV_TQ_MAX_VALUE, BATADV_SOURCE_VERSION,
+		   primary_if->net_dev->name, primary_if->net_dev->dev_addr,
+		   net_dev->name);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index db2009d..72bd43f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -245,7 +245,7 @@ static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 	if (!new_hard_iface)
 		goto out;
 
-	bat_priv->bat_algo_ops->bat_primary_iface_set(new_hard_iface);
+	bat_priv->bat_algo_ops->iface.bat_primary_set(new_hard_iface);
 	batadv_primary_if_update_addr(bat_priv, curr_hard_iface);
 
 out:
@@ -392,7 +392,7 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	bat_priv->bat_algo_ops->bat_iface_update_mac(hard_iface);
+	bat_priv->bat_algo_ops->iface.bat_update_mac(hard_iface);
 	hard_iface->if_status = BATADV_IF_TO_BE_ACTIVATED;
 
 	/* the first active interface becomes our primary interface or
@@ -407,8 +407,8 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	batadv_update_min_mtu(hard_iface->soft_iface);
 
-	if (bat_priv->bat_algo_ops->bat_iface_activate)
-		bat_priv->bat_algo_ops->bat_iface_activate(hard_iface);
+	if (bat_priv->bat_algo_ops->iface.bat_activate)
+		bat_priv->bat_algo_ops->iface.bat_activate(hard_iface);
 
 out:
 	if (primary_if)
@@ -506,7 +506,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (ret)
 		goto err_dev;
 
-	ret = bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
+	ret = bat_priv->bat_algo_ops->iface.bat_enable(hard_iface);
 	if (ret < 0)
 		goto err_upper;
 
@@ -515,7 +515,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->if_status = BATADV_IF_INACTIVE;
 	ret = batadv_orig_hash_add_if(hard_iface, bat_priv->num_ifaces);
 	if (ret < 0) {
-		bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
+		bat_priv->bat_algo_ops->iface.bat_disable(hard_iface);
 		bat_priv->num_ifaces--;
 		hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 		goto err_upper;
@@ -596,7 +596,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 			batadv_hardif_put(new_if);
 	}
 
-	bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
+	bat_priv->bat_algo_ops->iface.bat_disable(hard_iface);
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
 	/* delete all references to this hard_iface */
@@ -779,7 +779,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		batadv_check_known_mac_addr(hard_iface->net_dev);
 
 		bat_priv = netdev_priv(hard_iface->soft_iface);
-		bat_priv->bat_algo_ops->bat_iface_update_mac(hard_iface);
+		bat_priv->bat_algo_ops->iface.bat_update_mac(hard_iface);
 
 		primary_if = batadv_primary_if_get_selected(bat_priv);
 		if (!primary_if)
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 627d14e..ce66b96 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -565,12 +565,12 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	}
 
 	/* all algorithms must implement all ops (for now) */
-	if (!bat_algo_ops->bat_iface_enable ||
-	    !bat_algo_ops->bat_iface_disable ||
-	    !bat_algo_ops->bat_iface_update_mac ||
-	    !bat_algo_ops->bat_primary_iface_set ||
-	    !bat_algo_ops->bat_neigh_cmp ||
-	    !bat_algo_ops->bat_neigh_is_similar_or_better) {
+	if (!bat_algo_ops->iface.bat_enable ||
+	    !bat_algo_ops->iface.bat_disable ||
+	    !bat_algo_ops->iface.bat_update_mac ||
+	    !bat_algo_ops->iface.bat_primary_set ||
+	    !bat_algo_ops->neigh.bat_cmp ||
+	    !bat_algo_ops->neigh.bat_is_similar_or_better) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		return -EINVAL;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 076d258..366d7da 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -532,8 +532,8 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 
 	kref_init(&hardif_neigh->refcount);
 
-	if (bat_priv->bat_algo_ops->bat_hardif_neigh_init)
-		bat_priv->bat_algo_ops->bat_hardif_neigh_init(hardif_neigh);
+	if (bat_priv->bat_algo_ops->neigh.bat_hardif_init)
+		bat_priv->bat_algo_ops->neigh.bat_hardif_init(hardif_neigh);
 
 	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
 
@@ -708,13 +708,13 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 
 	batadv_hardif_put(primary_if);
 
-	if (!bat_priv->bat_algo_ops->bat_neigh_print) {
+	if (!bat_priv->bat_algo_ops->neigh.bat_print) {
 		seq_puts(seq,
 			 "No printing function for this routing protocol\n");
 		return 0;
 	}
 
-	bat_priv->bat_algo_ops->bat_neigh_print(bat_priv, seq);
+	bat_priv->bat_algo_ops->neigh.bat_print(bat_priv, seq);
 	return 0;
 }
 
@@ -765,8 +765,8 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	batadv_frag_purge_orig(orig_node, NULL);
 
-	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
-		orig_node->bat_priv->bat_algo_ops->bat_orig_free(orig_node);
+	if (orig_node->bat_priv->bat_algo_ops->orig.bat_free)
+		orig_node->bat_priv->bat_algo_ops->orig.bat_free(orig_node);
 
 	kfree(orig_node->tt_buff);
 	kfree(orig_node);
@@ -1099,7 +1099,7 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(neigh, &orig_node->neigh_list, list) {
-		if (best && (bao->bat_neigh_cmp(neigh, if_outgoing,
+		if (best && (bao->neigh.bat_cmp(neigh, if_outgoing,
 						best, if_outgoing) <= 0))
 			continue;
 
@@ -1256,13 +1256,13 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 
 	batadv_hardif_put(primary_if);
 
-	if (!bat_priv->bat_algo_ops->bat_orig_print) {
+	if (!bat_priv->bat_algo_ops->orig.bat_print) {
 		seq_puts(seq,
 			 "No printing function for this routing protocol\n");
 		return 0;
 	}
 
-	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq,
+	bat_priv->bat_algo_ops->orig.bat_print(bat_priv, seq,
 					       BATADV_IF_DEFAULT);
 
 	return 0;
@@ -1290,7 +1290,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
-	if (!bat_priv->bat_algo_ops->bat_orig_print) {
+	if (!bat_priv->bat_algo_ops->orig.bat_print) {
 		seq_puts(seq,
 			 "No printing function for this routing protocol\n");
 		goto out;
@@ -1306,7 +1306,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 		   hard_iface->net_dev->dev_addr,
 		   hard_iface->soft_iface->name, bat_priv->bat_algo_ops->name);
 
-	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq, hard_iface);
+	bat_priv->bat_algo_ops->orig.bat_print(bat_priv, seq, hard_iface);
 
 out:
 	if (hard_iface)
@@ -1334,8 +1334,8 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
 			ret = 0;
-			if (bao->bat_orig_add_if)
-				ret = bao->bat_orig_add_if(orig_node,
+			if (bao->orig.bat_add_if)
+				ret = bao->orig.bat_add_if(orig_node,
 							   max_if_num);
 			if (ret == -ENOMEM)
 				goto err;
@@ -1371,8 +1371,8 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
 			ret = 0;
-			if (bao->bat_orig_del_if)
-				ret = bao->bat_orig_del_if(orig_node,
+			if (bao->orig.bat_del_if)
+				ret = bao->orig.bat_del_if(orig_node,
 							   max_if_num,
 							   hard_iface->if_num);
 			if (ret == -ENOMEM)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index ae850f2..71a3ae5 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -522,7 +522,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 		/* alternative candidate should be good enough to be
 		 * considered
 		 */
-		if (!bao->bat_neigh_is_similar_or_better(cand_router,
+		if (!bao->neigh.bat_is_similar_or_better(cand_router,
 							 cand->if_outgoing,
 							 router, recv_if))
 			goto next;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index feaf492..79b0cdf 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1558,7 +1558,7 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			continue;
 
 		if (best_router &&
-		    bao->bat_neigh_cmp(router, BATADV_IF_DEFAULT,
+		    bao->neigh.bat_cmp(router, BATADV_IF_DEFAULT,
 				       best_router, BATADV_IF_DEFAULT) <= 0) {
 			batadv_neigh_node_put(router);
 			continue;
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index d4ca4c0..2f7ca46 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1262,26 +1262,26 @@ struct batadv_forw_packet {
  * struct batadv_algo_ops - mesh algorithm callbacks
  * @list: list node for the batadv_algo_list
  * @name: name of the algorithm
- * @bat_iface_activate: start routing mechanisms when hard-interface is brought
+ * @iface.bat_activate: start routing mechanisms when hard-interface is brought
  *  up
- * @bat_iface_enable: init routing info when hard-interface is enabled
- * @bat_iface_disable: de-init routing info when hard-interface is disabled
- * @bat_iface_update_mac: (re-)init mac addresses of the protocol information
+ * @iface.bat_enable: init routing info when hard-interface is enabled
+ * @iface.bat_disable: de-init routing info when hard-interface is disabled
+ * @iface.bat_update_mac: (re-)init mac addresses of the protocol information
  *  belonging to this hard-interface
- * @bat_primary_iface_set: called when primary interface is selected / changed
- * @bat_hardif_neigh_init: called on creation of single hop entry
- * @bat_neigh_cmp: compare the metrics of two neighbors for their respective
+ * @iface.bat_primary_set: called when primary interface is selected / changed
+ * @neigh.bat_hardif_init: called on creation of single hop entry
+ * @neigh.bat_cmp: compare the metrics of two neighbors for their respective
  *  outgoing interfaces
- * @bat_neigh_is_similar_or_better: check if neigh1 is equally similar or
+ * @neigh.bat_is_similar_or_better: check if neigh1 is equally similar or
  *  better than neigh2 for their respective outgoing interface from the metric
  *  prospective
- * @bat_neigh_print: print the single hop neighbor list (optional)
- * @bat_orig_print: print the originator table (optional)
- * @bat_orig_free: free the resources allocated by the routing algorithm for an
+ * @neigh.bat_print: print the single hop neighbor list (optional)
+ * @orig.bat_print: print the originator table (optional)
+ * @orig.bat_free: free the resources allocated by the routing algorithm for an
  *  orig_node object
- * @bat_orig_add_if: ask the routing algorithm to apply the needed changes to
+ * @orig.bat_add_if: ask the routing algorithm to apply the needed changes to
  *  the orig_node due to a new hard-interface being added into the mesh
- * @bat_orig_del_if: ask the routing algorithm to apply the needed changes to
+ * @orig.bat_del_if: ask the routing algorithm to apply the needed changes to
  *  the orig_node due to an hard-interface being removed from the mesh
  * @gw.bat_store_sel_class: parse and stores a new GW selection class
  * @gw.bat_show_sel_class: prints the current GW selection class
@@ -1289,31 +1289,39 @@ struct batadv_forw_packet {
 struct batadv_algo_ops {
 	struct hlist_node list;
 	char *name;
-	void (*bat_iface_activate)(struct batadv_hard_iface *hard_iface);
-	int (*bat_iface_enable)(struct batadv_hard_iface *hard_iface);
-	void (*bat_iface_disable)(struct batadv_hard_iface *hard_iface);
-	void (*bat_iface_update_mac)(struct batadv_hard_iface *hard_iface);
-	void (*bat_primary_iface_set)(struct batadv_hard_iface *hard_iface);
+	struct {
+		void (*bat_activate)(struct batadv_hard_iface *hard_iface);
+		int (*bat_enable)(struct batadv_hard_iface *hard_iface);
+		void (*bat_disable)(struct batadv_hard_iface *hard_iface);
+		void (*bat_update_mac)(struct batadv_hard_iface *hard_iface);
+		void (*bat_primary_set)(struct batadv_hard_iface *hard_iface);
+	} iface;
 	/* neigh_node handling API */
-	void (*bat_hardif_neigh_init)(struct batadv_hardif_neigh_node *neigh);
-	int (*bat_neigh_cmp)(struct batadv_neigh_node *neigh1,
-			     struct batadv_hard_iface *if_outgoing1,
-			     struct batadv_neigh_node *neigh2,
-			     struct batadv_hard_iface *if_outgoing2);
-	bool (*bat_neigh_is_similar_or_better)
-		(struct batadv_neigh_node *neigh1,
-		 struct batadv_hard_iface *if_outgoing1,
-		 struct batadv_neigh_node *neigh2,
-		 struct batadv_hard_iface *if_outgoing2);
-	void (*bat_neigh_print)(struct batadv_priv *priv, struct seq_file *seq);
+	struct {
+		void (*bat_hardif_init)(struct batadv_hardif_neigh_node *neigh);
+		int (*bat_cmp)(struct batadv_neigh_node *neigh1,
+			       struct batadv_hard_iface *if_outgoing1,
+			       struct batadv_neigh_node *neigh2,
+			       struct batadv_hard_iface *if_outgoing2);
+		bool (*bat_is_similar_or_better)
+			(struct batadv_neigh_node *neigh1,
+			 struct batadv_hard_iface *if_outgoing1,
+			 struct batadv_neigh_node *neigh2,
+			 struct batadv_hard_iface *if_outgoing2);
+		void (*bat_print)(struct batadv_priv *priv,
+				  struct seq_file *seq);
+	} neigh;
 	/* orig_node handling API */
-	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
-			       struct batadv_hard_iface *hard_iface);
-	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
-	int (*bat_orig_add_if)(struct batadv_orig_node *orig_node,
-			       int max_if_num);
-	int (*bat_orig_del_if)(struct batadv_orig_node *orig_node,
-			       int max_if_num, int del_if_num);
+	struct {
+		void (*bat_print)(struct batadv_priv *priv,
+				  struct seq_file *seq,
+				  struct batadv_hard_iface *hard_iface);
+		void (*bat_free)(struct batadv_orig_node *orig_node);
+		int (*bat_add_if)(struct batadv_orig_node *orig_node,
+				  int max_if_num);
+		int (*bat_del_if)(struct batadv_orig_node *orig_node,
+				  int max_if_num, int del_if_num);
+	} orig;
 	struct {
 		ssize_t (*bat_store_sel_class)(struct batadv_priv *bat_priv,
 					       char *buff, size_t count);
-- 
2.8.2

