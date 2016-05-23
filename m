Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Mon, 23 May 2016 17:00:34 +0800
Message-Id: <20160523090037.26896-3-a@unstable.cc>
In-Reply-To: <20160523090037.26896-1-a@unstable.cc>
References: <20160523090037.26896-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/5] batman-adv: split routing API data
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
Cc: Antonio Quartulli <a@unstable.cc>

The routing API data structure contains several function
pointers that can easily be grouped together based on the
component they work with.

Split the API in subobjects in order to improve definition readability.

At the same time, remove the "bat_" prefix from the API object and
its fields names. These are batman-adv private structs and there is no
need to always prepend such prefix, which only makes function invocations
much much longer.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_algo.c          |  14 ++---
 net/batman-adv/bat_iv_ogm.c        |  33 +++++-----
 net/batman-adv/bat_v.c             |  30 +++++----
 net/batman-adv/bat_v_elp.c         |   2 +-
 net/batman-adv/bat_v_ogm.c         |   2 +-
 net/batman-adv/hard-interface.c    |  16 ++---
 net/batman-adv/netlink.c           |   2 +-
 net/batman-adv/originator.c        |  49 +++++++--------
 net/batman-adv/routing.c           |   8 +--
 net/batman-adv/sysfs.c             |  15 +++--
 net/batman-adv/translation-table.c |   6 +-
 net/batman-adv/types.h             | 124 +++++++++++++++++++++----------------
 12 files changed, 163 insertions(+), 138 deletions(-)

diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 610d4de..81dbbf5 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -65,12 +65,12 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	}
 
 	/* all algorithms must implement all ops (for now) */
-	if (!bat_algo_ops->bat_iface_enable ||
-	    !bat_algo_ops->bat_iface_disable ||
-	    !bat_algo_ops->bat_iface_update_mac ||
-	    !bat_algo_ops->bat_primary_iface_set ||
-	    !bat_algo_ops->bat_neigh_cmp ||
-	    !bat_algo_ops->bat_neigh_is_similar_or_better) {
+	if (!bat_algo_ops->iface.enable ||
+	    !bat_algo_ops->iface.disable ||
+	    !bat_algo_ops->iface.update_mac ||
+	    !bat_algo_ops->iface.primary_set ||
+	    !bat_algo_ops->neigh.cmp ||
+	    !bat_algo_ops->neigh.is_similar_or_better) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		return -EINVAL;
@@ -90,7 +90,7 @@ int batadv_algo_select(struct batadv_priv *bat_priv, char *name)
 	if (!bat_algo_ops)
 		return -EINVAL;
 
-	bat_priv->bat_algo_ops = bat_algo_ops;
+	bat_priv->algo_ops = bat_algo_ops;
 
 	return 0;
 }
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index e2d8848..19b0abd 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1853,8 +1853,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	/* did we receive a B.A.T.M.A.N. IV OGM packet on an interface
 	 * that does not have B.A.T.M.A.N. IV enabled ?
 	 */
-	if (bat_priv->bat_algo_ops->bat_iface_enable !=
-	    batadv_iv_ogm_iface_enable)
+	if (bat_priv->algo_ops->iface.enable != batadv_iv_ogm_iface_enable)
 		return NET_RX_DROP;
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_RX);
@@ -2120,18 +2119,24 @@ static void batadv_iv_iface_activate(struct batadv_hard_iface *hard_iface)
 
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
+		.activate = batadv_iv_iface_activate,
+		.enable = batadv_iv_ogm_iface_enable,
+		.disable = batadv_iv_ogm_iface_disable,
+		.update_mac = batadv_iv_ogm_iface_update_mac,
+		.primary_set = batadv_iv_ogm_primary_iface_set,
+	},
+	.neigh = {
+		.cmp = batadv_iv_ogm_neigh_cmp,
+		.is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
+		.print = batadv_iv_neigh_print,
+	},
+	.orig = {
+		.print = batadv_iv_ogm_orig_print,
+		.free = batadv_iv_ogm_orig_free,
+		.add_if = batadv_iv_ogm_orig_add_if,
+		.del_if = batadv_iv_ogm_orig_del_if,
+	},
 };
 
 int __init batadv_iv_init(void)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 664e832..3066e59 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -351,19 +351,25 @@ static ssize_t batadv_v_show_sel_class(struct batadv_priv *bat_priv, char *buff)
 
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
+		.activate = batadv_v_iface_activate,
+		.enable = batadv_v_iface_enable,
+		.disable = batadv_v_iface_disable,
+		.update_mac = batadv_v_iface_update_mac,
+		.primary_set = batadv_v_primary_iface_set,
+	},
+	.neigh = {
+		.hardif_init = batadv_v_hardif_neigh_init,
+		.cmp = batadv_v_neigh_cmp,
+		.is_similar_or_better = batadv_v_neigh_is_sob,
+		.print = batadv_v_neigh_print,
+	},
+	.orig = {
+		.print = batadv_v_orig_print,
+	},
 	.gw = {
-		.bat_store_sel_class = batadv_v_store_sel_class,
-		.bat_show_sel_class = batadv_v_show_sel_class,
+		.store_sel_class = batadv_v_store_sel_class,
+		.show_sel_class = batadv_v_show_sel_class,
 	},
 };
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 15cf272..7d17001 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -504,7 +504,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	/* did we receive a B.A.T.M.A.N. V ELP packet on an interface
 	 * that does not have B.A.T.M.A.N. V ELP enabled ?
 	 */
-	if (strcmp(bat_priv->bat_algo_ops->name, "BATMAN_V") != 0)
+	if (strcmp(bat_priv->algo_ops->name, "BATMAN_V") != 0)
 		return NET_RX_DROP;
 
 	elp_packet = (struct batadv_elp_packet *)skb->data;
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 7ac9e0b..6fbba4e 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -754,7 +754,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	/* did we receive a OGM2 packet on an interface that does not have
 	 * B.A.T.M.A.N. V enabled ?
 	 */
-	if (strcmp(bat_priv->bat_algo_ops->name, "BATMAN_V") != 0)
+	if (strcmp(bat_priv->algo_ops->name, "BATMAN_V") != 0)
 		return NET_RX_DROP;
 
 	if (!batadv_check_management_packet(skb, if_incoming, BATADV_OGM2_HLEN))
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 6689656..0229860 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -246,7 +246,7 @@ static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 	if (!new_hard_iface)
 		goto out;
 
-	bat_priv->bat_algo_ops->bat_primary_iface_set(new_hard_iface);
+	bat_priv->algo_ops->iface.primary_set(new_hard_iface);
 	batadv_primary_if_update_addr(bat_priv, curr_hard_iface);
 
 out:
@@ -393,7 +393,7 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	bat_priv->bat_algo_ops->bat_iface_update_mac(hard_iface);
+	bat_priv->algo_ops->iface.update_mac(hard_iface);
 	hard_iface->if_status = BATADV_IF_TO_BE_ACTIVATED;
 
 	/* the first active interface becomes our primary interface or
@@ -408,8 +408,8 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	batadv_update_min_mtu(hard_iface->soft_iface);
 
-	if (bat_priv->bat_algo_ops->bat_iface_activate)
-		bat_priv->bat_algo_ops->bat_iface_activate(hard_iface);
+	if (bat_priv->algo_ops->iface.activate)
+		bat_priv->algo_ops->iface.activate(hard_iface);
 
 out:
 	if (primary_if)
@@ -507,7 +507,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (ret)
 		goto err_dev;
 
-	ret = bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
+	ret = bat_priv->algo_ops->iface.enable(hard_iface);
 	if (ret < 0)
 		goto err_upper;
 
@@ -516,7 +516,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->if_status = BATADV_IF_INACTIVE;
 	ret = batadv_orig_hash_add_if(hard_iface, bat_priv->num_ifaces);
 	if (ret < 0) {
-		bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
+		bat_priv->algo_ops->iface.disable(hard_iface);
 		bat_priv->num_ifaces--;
 		hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 		goto err_upper;
@@ -597,7 +597,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 			batadv_hardif_put(new_if);
 	}
 
-	bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
+	bat_priv->algo_ops->iface.disable(hard_iface);
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
 	/* delete all references to this hard_iface */
@@ -789,7 +789,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		batadv_check_known_mac_addr(hard_iface->net_dev);
 
 		bat_priv = netdev_priv(hard_iface->soft_iface);
-		bat_priv->bat_algo_ops->bat_iface_update_mac(hard_iface);
+		bat_priv->algo_ops->iface.update_mac(hard_iface);
 
 		primary_if = batadv_primary_if_get_selected(bat_priv);
 		if (!primary_if)
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 56e63ce..3d1dcdd 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -89,7 +89,7 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 
 	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
-			   bat_priv->bat_algo_ops->name) ||
+			   bat_priv->algo_ops->name) ||
 	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, soft_iface->ifindex) ||
 	    nla_put_string(msg, BATADV_ATTR_MESH_IFNAME, soft_iface->name) ||
 	    nla_put(msg, BATADV_ATTR_MESH_ADDRESS, ETH_ALEN,
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 8ad17ad..7d1e542 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -534,8 +534,8 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 
 	kref_init(&hardif_neigh->refcount);
 
-	if (bat_priv->bat_algo_ops->bat_hardif_neigh_init)
-		bat_priv->bat_algo_ops->bat_hardif_neigh_init(hardif_neigh);
+	if (bat_priv->algo_ops->neigh.hardif_init)
+		bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
 
 	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
 
@@ -706,17 +706,17 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s %s)]\n",
 		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
 		   primary_if->net_dev->dev_addr, net_dev->name,
-		   bat_priv->bat_algo_ops->name);
+		   bat_priv->algo_ops->name);
 
 	batadv_hardif_put(primary_if);
 
-	if (!bat_priv->bat_algo_ops->bat_neigh_print) {
+	if (!bat_priv->algo_ops->neigh.print) {
 		seq_puts(seq,
 			 "No printing function for this routing protocol\n");
 		return 0;
 	}
 
-	bat_priv->bat_algo_ops->bat_neigh_print(bat_priv, seq);
+	bat_priv->algo_ops->neigh.print(bat_priv, seq);
 	return 0;
 }
 
@@ -767,8 +767,8 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	batadv_frag_purge_orig(orig_node, NULL);
 
-	if (orig_node->bat_priv->bat_algo_ops->bat_orig_free)
-		orig_node->bat_priv->bat_algo_ops->bat_orig_free(orig_node);
+	if (orig_node->bat_priv->algo_ops->orig.free)
+		orig_node->bat_priv->algo_ops->orig.free(orig_node);
 
 	kfree(orig_node->tt_buff);
 	kfree(orig_node);
@@ -1097,12 +1097,12 @@ batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 			  struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_neigh_node *best = NULL, *neigh;
-	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(neigh, &orig_node->neigh_list, list) {
-		if (best && (bao->bat_neigh_cmp(neigh, if_outgoing,
-						best, if_outgoing) <= 0))
+		if (best && (bao->neigh.cmp(neigh, if_outgoing, best,
+					    if_outgoing) <= 0))
 			continue;
 
 		if (!kref_get_unless_zero(&neigh->refcount))
@@ -1254,18 +1254,17 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s %s)]\n",
 		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
 		   primary_if->net_dev->dev_addr, net_dev->name,
-		   bat_priv->bat_algo_ops->name);
+		   bat_priv->algo_ops->name);
 
 	batadv_hardif_put(primary_if);
 
-	if (!bat_priv->bat_algo_ops->bat_orig_print) {
+	if (!bat_priv->algo_ops->orig.print) {
 		seq_puts(seq,
 			 "No printing function for this routing protocol\n");
 		return 0;
 	}
 
-	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq,
-					       BATADV_IF_DEFAULT);
+	bat_priv->algo_ops->orig.print(bat_priv, seq, BATADV_IF_DEFAULT);
 
 	return 0;
 }
@@ -1292,7 +1291,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
-	if (!bat_priv->bat_algo_ops->bat_orig_print) {
+	if (!bat_priv->algo_ops->orig.print) {
 		seq_puts(seq,
 			 "No printing function for this routing protocol\n");
 		goto out;
@@ -1306,9 +1305,9 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s, IF/MAC: %s/%pM (%s %s)]\n",
 		   BATADV_SOURCE_VERSION, hard_iface->net_dev->name,
 		   hard_iface->net_dev->dev_addr,
-		   hard_iface->soft_iface->name, bat_priv->bat_algo_ops->name);
+		   hard_iface->soft_iface->name, bat_priv->algo_ops->name);
 
-	bat_priv->bat_algo_ops->bat_orig_print(bat_priv, seq, hard_iface);
+	bat_priv->algo_ops->orig.print(bat_priv, seq, hard_iface);
 
 out:
 	if (hard_iface)
@@ -1320,7 +1319,7 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
-	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
@@ -1336,9 +1335,8 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
 			ret = 0;
-			if (bao->bat_orig_add_if)
-				ret = bao->bat_orig_add_if(orig_node,
-							   max_if_num);
+			if (bao->orig.add_if)
+				ret = bao->orig.add_if(orig_node, max_if_num);
 			if (ret == -ENOMEM)
 				goto err;
 		}
@@ -1360,7 +1358,7 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 	struct hlist_head *head;
 	struct batadv_hard_iface *hard_iface_tmp;
 	struct batadv_orig_node *orig_node;
-	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	u32 i;
 	int ret;
 
@@ -1373,10 +1371,9 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
 			ret = 0;
-			if (bao->bat_orig_del_if)
-				ret = bao->bat_orig_del_if(orig_node,
-							   max_if_num,
-							   hard_iface->if_num);
+			if (bao->orig.del_if)
+				ret = bao->orig.del_if(orig_node, max_if_num,
+						       hard_iface->if_num);
 			if (ret == -ENOMEM)
 				goto err;
 		}
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b9a500a..b729a8b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -483,7 +483,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
 		   struct batadv_hard_iface *recv_if)
 {
-	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct batadv_neigh_node *first_candidate_router = NULL;
 	struct batadv_neigh_node *next_candidate_router = NULL;
 	struct batadv_neigh_node *router, *cand_router = NULL;
@@ -537,9 +537,9 @@ batadv_find_router(struct batadv_priv *bat_priv,
 		/* alternative candidate should be good enough to be
 		 * considered
 		 */
-		if (!bao->bat_neigh_is_similar_or_better(cand_router,
-							 cand->if_outgoing,
-							 router, recv_if))
+		if (!bao->neigh.is_similar_or_better(cand_router,
+						     cand->if_outgoing, router,
+						     recv_if))
 			goto next;
 
 		/* don't use the same router twice */
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 1fadafb..a8d8ccb 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -412,7 +412,7 @@ static ssize_t batadv_show_bat_algo(struct kobject *kobj,
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 
-	return sprintf(buff, "%s\n", bat_priv->bat_algo_ops->name);
+	return sprintf(buff, "%s\n", bat_priv->algo_ops->name);
 }
 
 static void batadv_post_gw_reselect(struct net_device *net_dev)
@@ -519,9 +519,9 @@ static ssize_t batadv_show_gw_sel_class(struct kobject *kobj,
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 
-	if (bat_priv->bat_algo_ops->gw.bat_show_sel_class)
-		return bat_priv->bat_algo_ops->gw.bat_show_sel_class(bat_priv,
-								     buff);
+	if (bat_priv->algo_ops->gw.show_sel_class)
+		return bat_priv->algo_ops->gw.show_sel_class(bat_priv,
+								 buff);
 
 	return sprintf(buff, "%i\n", atomic_read(&bat_priv->gw.sel_class));
 }
@@ -535,10 +535,9 @@ static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
-	if (bat_priv->bat_algo_ops->gw.bat_store_sel_class)
-		return bat_priv->bat_algo_ops->gw.bat_store_sel_class(bat_priv,
-								      buff,
-								      count);
+	if (bat_priv->algo_ops->gw.store_sel_class)
+		return bat_priv->algo_ops->gw.store_sel_class(bat_priv,
+								  buff, count);
 
 	return __batadv_store_uint_attr(buff, count, 0, BATADV_TQ_MAX_VALUE,
 					batadv_post_gw_reselect, attr,
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9be4ff0..2057cbe 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1550,7 +1550,7 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			    struct batadv_tt_global_entry *tt_global_entry)
 {
 	struct batadv_neigh_node *router, *best_router = NULL;
-	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+	struct batadv_algo_ops *bao = bat_priv->algo_ops;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry, *best_entry = NULL;
 
@@ -1562,8 +1562,8 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			continue;
 
 		if (best_router &&
-		    bao->bat_neigh_cmp(router, BATADV_IF_DEFAULT,
-				       best_router, BATADV_IF_DEFAULT) <= 0) {
+		    bao->neigh.cmp(router, BATADV_IF_DEFAULT, best_router,
+				   BATADV_IF_DEFAULT) <= 0) {
 			batadv_neigh_node_put(router);
 			continue;
 		}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fe2e8f8..ea7ad8c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1016,7 +1016,7 @@ struct batadv_priv_bat_v {
  * @cleanup_work: work queue callback item for soft-interface deinit
  * @primary_if: one of the hard-interfaces assigned to this mesh interface
  *  becomes the primary interface
- * @bat_algo_ops: routing algorithm used by this mesh interface
+ * @algo_ops: routing algorithm used by this mesh interface
  * @softif_vlan_list: a list of softif_vlan structs, one per VLAN created on top
  *  of the mesh interface represented by this object
  * @softif_vlan_list_lock: lock protecting softif_vlan_list
@@ -1074,7 +1074,7 @@ struct batadv_priv {
 	struct delayed_work orig_work;
 	struct work_struct cleanup_work;
 	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer */
-	struct batadv_algo_ops *bat_algo_ops;
+	struct batadv_algo_ops *algo_ops;
 	struct hlist_head softif_vlan_list;
 	spinlock_t softif_vlan_list_lock; /* protects softif_vlan_list */
 #ifdef CONFIG_BATMAN_ADV_BLA
@@ -1388,71 +1388,89 @@ struct batadv_forw_packet {
 };
 
 /**
+ * struct batadv_algo_iface_ops - mesh algorithm callbacks (interface specific)
+ * @activate: start routing mechanisms when hard-interface is brought up
+ * @enable: init routing info when hard-interface is enabled
+ * @disable: de-init routing info when hard-interface is disabled
+ * @update_mac: (re-)init mac addresses of the protocol information
+ *  belonging to this hard-interface
+ * @primary_set: called when primary interface is selected / changed
+ */
+struct batadv_algo_iface_ops {
+	void (*activate)(struct batadv_hard_iface *hard_iface);
+	int (*enable)(struct batadv_hard_iface *hard_iface);
+	void (*disable)(struct batadv_hard_iface *hard_iface);
+	void (*update_mac)(struct batadv_hard_iface *hard_iface);
+	void (*primary_set)(struct batadv_hard_iface *hard_iface);
+};
+
+/**
+ * struct batadv_algo_neigh_ops - mesh algorithm callbacks (neighbour specific)
+ * @hardif_init: called on creation of single hop entry
+ * @cmp: compare the metrics of two neighbors for their respective outgoing
+ *  interfaces
+ * @is_similar_or_better: check if neigh1 is equally similar or better than
+ *  neigh2 for their respective outgoing interface from the metric prospective
+ * @print: print the single hop neighbor list (optional)
+ */
+struct batadv_algo_neigh_ops {
+	void (*hardif_init)(struct batadv_hardif_neigh_node *neigh);
+	int (*cmp)(struct batadv_neigh_node *neigh1,
+		   struct batadv_hard_iface *if_outgoing1,
+		   struct batadv_neigh_node *neigh2,
+		   struct batadv_hard_iface *if_outgoing2);
+	bool (*is_similar_or_better)(struct batadv_neigh_node *neigh1,
+				     struct batadv_hard_iface *if_outgoing1,
+				     struct batadv_neigh_node *neigh2,
+				     struct batadv_hard_iface *if_outgoing2);
+	void (*print)(struct batadv_priv *priv, struct seq_file *seq);
+};
+
+/**
+ * struct batadv_algo_orig_ops - mesh algorithm callbacks (originator specific)
+ * @free: free the resources allocated by the routing algorithm for an orig_node
+ *  object
+ * @add_if: ask the routing algorithm to apply the needed changes to the
+ *  orig_node due to a new hard-interface being added into the mesh
+ * @del_if: ask the routing algorithm to apply the needed changes to the
+ *  orig_node due to an hard-interface being removed from the mesh
+ * @print: print the originator table (optional)
+ */
+struct batadv_algo_orig_ops {
+	void (*free)(struct batadv_orig_node *orig_node);
+	int (*add_if)(struct batadv_orig_node *orig_node, int max_if_num);
+	int (*del_if)(struct batadv_orig_node *orig_node, int max_if_num,
+		      int del_if_num);
+	void (*print)(struct batadv_priv *priv, struct seq_file *seq,
+		      struct batadv_hard_iface *hard_iface);
+};
+
+/**
  * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
- * @bat_store_sel_class: parse and stores a new GW selection class
- * @bat_show_sel_class: prints the current GW selection class
+ * @store_sel_class: parse and stores a new GW selection class
+ * @show_sel_class: prints the current GW selection class
  */
 struct batadv_algo_gw_ops {
-	ssize_t (*bat_store_sel_class)(struct batadv_priv *bat_priv, char *buff,
-				       size_t count);
-	ssize_t (*bat_show_sel_class)(struct batadv_priv *bat_priv, char *buff);
+	ssize_t (*store_sel_class)(struct batadv_priv *bat_priv, char *buff,
+				   size_t count);
+	ssize_t (*show_sel_class)(struct batadv_priv *bat_priv, char *buff);
 };
 
 /**
  * struct batadv_algo_ops - mesh algorithm callbacks
  * @list: list node for the batadv_algo_list
  * @name: name of the algorithm
- * @bat_iface_activate: start routing mechanisms when hard-interface is brought
- *  up
- * @bat_iface_enable: init routing info when hard-interface is enabled
- * @bat_iface_disable: de-init routing info when hard-interface is disabled
- * @bat_iface_update_mac: (re-)init mac addresses of the protocol information
- *  belonging to this hard-interface
- * @bat_primary_iface_set: called when primary interface is selected / changed
- * @bat_hardif_neigh_init: called on creation of single hop entry
- * @bat_neigh_cmp: compare the metrics of two neighbors for their respective
- *  outgoing interfaces
- * @bat_neigh_is_similar_or_better: check if neigh1 is equally similar or
- *  better than neigh2 for their respective outgoing interface from the metric
- *  prospective
- * @bat_neigh_print: print the single hop neighbor list (optional)
- * @bat_orig_print: print the originator table (optional)
- * @bat_orig_free: free the resources allocated by the routing algorithm for an
- *  orig_node object
- * @bat_orig_add_if: ask the routing algorithm to apply the needed changes to
- *  the orig_node due to a new hard-interface being added into the mesh
- * @bat_orig_del_if: ask the routing algorithm to apply the needed changes to
- *  the orig_node due to an hard-interface being removed from the mesh
+ * @iface: callbacks related to interface handling
+ * @neigh: callbacks related to neighbors handling
+ * @orig: callbacks related to originators handling
  * @gw: callbacks related to GW mode
  */
 struct batadv_algo_ops {
 	struct hlist_node list;
 	char *name;
-	void (*bat_iface_activate)(struct batadv_hard_iface *hard_iface);
-	int (*bat_iface_enable)(struct batadv_hard_iface *hard_iface);
-	void (*bat_iface_disable)(struct batadv_hard_iface *hard_iface);
-	void (*bat_iface_update_mac)(struct batadv_hard_iface *hard_iface);
-	void (*bat_primary_iface_set)(struct batadv_hard_iface *hard_iface);
-	/* neigh_node handling API */
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
-	/* orig_node handling API */
-	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
-			       struct batadv_hard_iface *hard_iface);
-	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
-	int (*bat_orig_add_if)(struct batadv_orig_node *orig_node,
-			       int max_if_num);
-	int (*bat_orig_del_if)(struct batadv_orig_node *orig_node,
-			       int max_if_num, int del_if_num);
+	struct batadv_algo_iface_ops iface;
+	struct batadv_algo_neigh_ops neigh;
+	struct batadv_algo_orig_ops orig;
 	struct batadv_algo_gw_ops gw;
 };
 
-- 
2.8.3

