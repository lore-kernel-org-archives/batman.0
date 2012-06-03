Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:19 +0200
Message-Id: <1338754762-28424-13-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 13/16] batman-adv: Prefix hard-interface enum
	with BATADV_
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_iv_ogm.c            |    6 +++---
 bat_sysfs.c             |   27 ++++++++++++++++-----------
 bridge_loop_avoidance.c |    2 +-
 gateway_client.c        |    2 +-
 hard-interface.c        |   40 ++++++++++++++++++++--------------------
 hard-interface.h        |   14 +++++++-------
 icmp_socket.c           |    2 +-
 main.c                  |    4 ++--
 originator.c            |   16 ++++++++--------
 routing.c               |    2 +-
 send.c                  |   10 +++++-----
 translation-table.c     |    4 ++--
 vis.c                   |    2 +-
 13 files changed, 68 insertions(+), 63 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 110e76f..2fd6bee 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -165,7 +165,7 @@ static void batadv_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 	struct batman_ogm_packet *batman_ogm_packet;
 	struct sk_buff *skb;
 
-	if (hard_iface->if_status != IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE)
 		return;
 
 	packet_num = 0;
@@ -238,7 +238,7 @@ static void batadv_iv_ogm_emit(struct forw_packet *forw_packet)
 	soft_iface = forw_packet->if_incoming->soft_iface;
 	bat_priv = netdev_priv(soft_iface);
 
-	if (forw_packet->if_incoming->if_status != IF_ACTIVE)
+	if (forw_packet->if_incoming->if_status != BATADV_IF_ACTIVE)
 		goto out;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -1017,7 +1017,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->if_status != IF_ACTIVE)
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
 		if (hard_iface->soft_iface != if_incoming->soft_iface)
diff --git a/bat_sysfs.c b/bat_sysfs.c
index 2abf7c9..311a327 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -558,12 +558,17 @@ static ssize_t batadv_show_mesh_iface(struct kobject *kobj,
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
 	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	ssize_t length;
+	const char *ifname;
 
 	if (!hard_iface)
 		return 0;
 
-	length = sprintf(buff, "%s\n", hard_iface->if_status == IF_NOT_IN_USE ?
-			 "none" : hard_iface->soft_iface->name);
+	if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
+		ifname =  "none";
+	else
+		ifname = hard_iface->soft_iface->name;
+
+	length = sprintf(buff, "%s\n", ifname);
 
 	batadv_hardif_free_ref(hard_iface);
 
@@ -593,9 +598,9 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 	}
 
 	if (strncmp(buff, "none", 4) == 0)
-		status_tmp = IF_NOT_IN_USE;
+		status_tmp = BATADV_IF_NOT_IN_USE;
 	else
-		status_tmp = IF_I_WANT_YOU;
+		status_tmp = BATADV_IF_I_WANT_YOU;
 
 	if (hard_iface->if_status == status_tmp)
 		goto out;
@@ -609,13 +614,13 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 		goto out;
 	}
 
-	if (status_tmp == IF_NOT_IN_USE) {
+	if (status_tmp == BATADV_IF_NOT_IN_USE) {
 		batadv_hardif_disable_interface(hard_iface);
 		goto unlock;
 	}
 
 	/* if the interface already is in use */
-	if (hard_iface->if_status != IF_NOT_IN_USE)
+	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		batadv_hardif_disable_interface(hard_iface);
 
 	ret = batadv_hardif_enable_interface(hard_iface, buff);
@@ -638,19 +643,19 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 		return 0;
 
 	switch (hard_iface->if_status) {
-	case IF_TO_BE_REMOVED:
+	case BATADV_IF_TO_BE_REMOVED:
 		length = sprintf(buff, "disabling\n");
 		break;
-	case IF_INACTIVE:
+	case BATADV_IF_INACTIVE:
 		length = sprintf(buff, "inactive\n");
 		break;
-	case IF_ACTIVE:
+	case BATADV_IF_ACTIVE:
 		length = sprintf(buff, "active\n");
 		break;
-	case IF_TO_BE_ACTIVATED:
+	case BATADV_IF_TO_BE_ACTIVATED:
 		length = sprintf(buff, "enabling\n");
 		break;
-	case IF_NOT_IN_USE:
+	case BATADV_IF_NOT_IN_USE:
 	default:
 		length = sprintf(buff, "not in use\n");
 		break;
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index ee75fa6..66fd8c1 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1552,7 +1552,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
-	if (primary_if->if_status != IF_ACTIVE) {
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = seq_printf(seq,
 				 "BATMAN mesh %s disabled - primary interface not active\n",
 				 net_dev->name);
diff --git a/gateway_client.c b/gateway_client.c
index 026b181..6a92035 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -475,7 +475,7 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
-	if (primary_if->if_status != IF_ACTIVE) {
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = seq_printf(seq,
 				 "BATMAN mesh %s disabled - primary interface not active\n",
 				 net_dev->name);
diff --git a/hard-interface.c b/hard-interface.c
index a8f5af8..2468e15 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -85,7 +85,7 @@ batadv_hardif_get_active(const struct net_device *soft_iface)
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
-		if (hard_iface->if_status == IF_ACTIVE &&
+		if (hard_iface->if_status == BATADV_IF_ACTIVE &&
 		    atomic_inc_not_zero(&hard_iface->refcount))
 			goto out;
 	}
@@ -157,8 +157,8 @@ static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if ((hard_iface->if_status != IF_ACTIVE) &&
-		    (hard_iface->if_status != IF_TO_BE_ACTIVATED))
+		if ((hard_iface->if_status != BATADV_IF_ACTIVE) &&
+		    (hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED))
 			continue;
 
 		if (hard_iface->net_dev == net_dev)
@@ -189,8 +189,8 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if ((hard_iface->if_status != IF_ACTIVE) &&
-		    (hard_iface->if_status != IF_TO_BE_ACTIVATED))
+		if ((hard_iface->if_status != BATADV_IF_ACTIVE) &&
+		    (hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED))
 			continue;
 
 		if (hard_iface->soft_iface != soft_iface)
@@ -220,13 +220,13 @@ static void batadv_hardif_activate_interface(struct hard_iface *hard_iface)
 	struct bat_priv *bat_priv;
 	struct hard_iface *primary_if = NULL;
 
-	if (hard_iface->if_status != IF_INACTIVE)
+	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	bat_priv->bat_algo_ops->bat_iface_update_mac(hard_iface);
-	hard_iface->if_status = IF_TO_BE_ACTIVATED;
+	hard_iface->if_status = BATADV_IF_TO_BE_ACTIVATED;
 
 	/* the first active interface becomes our primary interface or
 	 * the next active interface after the old primary interface was removed
@@ -247,11 +247,11 @@ out:
 
 static void batadv_hardif_deactivate_interface(struct hard_iface *hard_iface)
 {
-	if ((hard_iface->if_status != IF_ACTIVE) &&
-	    (hard_iface->if_status != IF_TO_BE_ACTIVATED))
+	if ((hard_iface->if_status != BATADV_IF_ACTIVE) &&
+	    (hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED))
 		return;
 
-	hard_iface->if_status = IF_INACTIVE;
+	hard_iface->if_status = BATADV_IF_INACTIVE;
 
 	batadv_info(hard_iface->soft_iface, "Interface deactivated: %s\n",
 		    hard_iface->net_dev->name);
@@ -267,7 +267,7 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
 	int ret;
 
-	if (hard_iface->if_status != IF_NOT_IN_USE)
+	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		goto out;
 
 	if (!atomic_inc_not_zero(&hard_iface->refcount))
@@ -308,7 +308,7 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 
 	hard_iface->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
-	hard_iface->if_status = IF_INACTIVE;
+	hard_iface->if_status = BATADV_IF_INACTIVE;
 	batadv_orig_hash_add_if(hard_iface, bat_priv->num_ifaces);
 
 	hard_iface->batman_adv_ptype.type = ethertype;
@@ -359,10 +359,10 @@ void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct hard_iface *primary_if = NULL;
 
-	if (hard_iface->if_status == IF_ACTIVE)
+	if (hard_iface->if_status == BATADV_IF_ACTIVE)
 		batadv_hardif_deactivate_interface(hard_iface);
 
-	if (hard_iface->if_status != IF_INACTIVE)
+	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
 
 	batadv_info(hard_iface->soft_iface, "Removing interface: %s\n",
@@ -384,7 +384,7 @@ void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 	}
 
 	bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
-	hard_iface->if_status = IF_NOT_IN_USE;
+	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
@@ -428,7 +428,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	hard_iface->if_num = -1;
 	hard_iface->net_dev = net_dev;
 	hard_iface->soft_iface = NULL;
-	hard_iface->if_status = IF_NOT_IN_USE;
+	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 	INIT_LIST_HEAD(&hard_iface->list);
 	/* extra reference for return */
 	atomic_set(&hard_iface->refcount, 2);
@@ -457,13 +457,13 @@ static void batadv_hardif_remove_interface(struct hard_iface *hard_iface)
 	ASSERT_RTNL();
 
 	/* first deactivate interface */
-	if (hard_iface->if_status != IF_NOT_IN_USE)
+	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		batadv_hardif_disable_interface(hard_iface);
 
-	if (hard_iface->if_status != IF_NOT_IN_USE)
+	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		return;
 
-	hard_iface->if_status = IF_TO_BE_REMOVED;
+	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
 	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
 	batadv_hardif_free_ref(hard_iface);
 }
@@ -513,7 +513,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 			batadv_update_min_mtu(hard_iface->soft_iface);
 		break;
 	case NETDEV_CHANGEADDR:
-		if (hard_iface->if_status == IF_NOT_IN_USE)
+		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			goto hardif_put;
 
 		batadv_check_known_mac_addr(hard_iface->net_dev);
diff --git a/hard-interface.h b/hard-interface.h
index d66dabd..4b60d58 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -20,13 +20,13 @@
 #ifndef _NET_BATMAN_ADV_HARD_INTERFACE_H_
 #define _NET_BATMAN_ADV_HARD_INTERFACE_H_
 
-enum hard_if_state {
-	IF_NOT_IN_USE,
-	IF_TO_BE_REMOVED,
-	IF_INACTIVE,
-	IF_ACTIVE,
-	IF_TO_BE_ACTIVATED,
-	IF_I_WANT_YOU
+enum batadv_hard_if_state {
+	BATADV_IF_NOT_IN_USE,
+	BATADV_IF_TO_BE_REMOVED,
+	BATADV_IF_INACTIVE,
+	BATADV_IF_ACTIVE,
+	BATADV_IF_TO_BE_ACTIVATED,
+	BATADV_IF_I_WANT_YOU,
 };
 
 extern struct notifier_block batadv_hard_if_notifier;
diff --git a/icmp_socket.c b/icmp_socket.c
index 319235d..9247d97 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -225,7 +225,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	if (!neigh_node->if_incoming)
 		goto dst_unreach;
 
-	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
+	if (neigh_node->if_incoming->if_status != BATADV_IF_ACTIVE)
 		goto dst_unreach;
 
 	memcpy(icmp_packet->orig,
diff --git a/main.c b/main.c
index df7335c..23f5c8e 100644
--- a/main.c
+++ b/main.c
@@ -179,7 +179,7 @@ int batadv_is_my_mac(const uint8_t *addr)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->if_status != IF_ACTIVE)
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
 		if (batadv_compare_eth(hard_iface->net_dev->dev_addr, addr)) {
@@ -234,7 +234,7 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		goto err_free;
 
 	/* discard frames on not active interfaces */
-	if (hard_iface->if_status != IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE)
 		goto err_free;
 
 	batman_ogm_packet = (struct batman_ogm_packet *)skb->data;
diff --git a/originator.c b/originator.c
index f04f591..9e60cc0 100644
--- a/originator.c
+++ b/originator.c
@@ -286,13 +286,13 @@ static bool batadv_purge_orig_neighbors(struct bat_priv *bat_priv,
 		if_incoming = neigh_node->if_incoming;
 
 		if ((batadv_has_timed_out(last_seen, BATADV_PURGE_TIMEOUT)) ||
-		    (if_incoming->if_status == IF_INACTIVE) ||
-		    (if_incoming->if_status == IF_NOT_IN_USE) ||
-		    (if_incoming->if_status == IF_TO_BE_REMOVED)) {
+		    (if_incoming->if_status == BATADV_IF_INACTIVE) ||
+		    (if_incoming->if_status == BATADV_IF_NOT_IN_USE) ||
+		    (if_incoming->if_status == BATADV_IF_TO_BE_REMOVED)) {
 
-			if ((if_incoming->if_status == IF_INACTIVE) ||
-			    (if_incoming->if_status == IF_NOT_IN_USE) ||
-			    (if_incoming->if_status == IF_TO_BE_REMOVED))
+			if ((if_incoming->if_status == BATADV_IF_INACTIVE) ||
+			    (if_incoming->if_status == BATADV_IF_NOT_IN_USE) ||
+			    (if_incoming->if_status == BATADV_IF_TO_BE_REMOVED))
 				batadv_dbg(DBG_BATMAN, bat_priv,
 					   "neighbor purge: originator %pM, neighbor: %pM, iface: %s\n",
 					   orig_node->orig, neigh_node->addr,
@@ -422,7 +422,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
-	if (primary_if->if_status != IF_ACTIVE) {
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = seq_printf(seq,
 				 "BATMAN mesh %s disabled - primary interface not active\n",
 				 net_dev->name);
@@ -627,7 +627,7 @@ int batadv_orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num)
 	/* renumber remaining batman interfaces _inside_ of orig_hash_lock */
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface_tmp, &batadv_hardif_list, list) {
-		if (hard_iface_tmp->if_status == IF_NOT_IN_USE)
+		if (hard_iface_tmp->if_status == BATADV_IF_NOT_IN_USE)
 			continue;
 
 		if (hard_iface == hard_iface_tmp)
diff --git a/routing.c b/routing.c
index fa0b4ee..8085cb5 100644
--- a/routing.c
+++ b/routing.c
@@ -790,7 +790,7 @@ struct neigh_node *batadv_find_router(struct bat_priv *bat_priv,
 		router = batadv_find_ifalter_router(primary_orig_node, recv_if);
 
 return_router:
-	if (router && router->if_incoming->if_status != IF_ACTIVE)
+	if (router && router->if_incoming->if_status != BATADV_IF_ACTIVE)
 		goto err_unlock;
 
 	rcu_read_unlock();
diff --git a/send.c b/send.c
index 72542cb..8de6e25 100644
--- a/send.c
+++ b/send.c
@@ -37,7 +37,7 @@ int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
 {
 	struct ethhdr *ethhdr;
 
-	if (hard_iface->if_status != IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE)
 		goto send_skb_err;
 
 	if (unlikely(!hard_iface->net_dev))
@@ -80,8 +80,8 @@ void batadv_schedule_bat_ogm(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if ((hard_iface->if_status == IF_NOT_IN_USE) ||
-	    (hard_iface->if_status == IF_TO_BE_REMOVED))
+	if ((hard_iface->if_status == BATADV_IF_NOT_IN_USE) ||
+	    (hard_iface->if_status == BATADV_IF_TO_BE_REMOVED))
 		return;
 
 	/* the interface gets activated here to avoid race conditions between
@@ -90,8 +90,8 @@ void batadv_schedule_bat_ogm(struct hard_iface *hard_iface)
 	 * outdated packets (especially uninitialized mac addresses) in the
 	 * packet queue
 	 */
-	if (hard_iface->if_status == IF_TO_BE_ACTIVATED)
-		hard_iface->if_status = IF_ACTIVE;
+	if (hard_iface->if_status == BATADV_IF_TO_BE_ACTIVATED)
+		hard_iface->if_status = BATADV_IF_ACTIVE;
 
 	bat_priv->bat_algo_ops->bat_ogm_schedule(hard_iface);
 }
diff --git a/translation-table.c b/translation-table.c
index 330a83f..56b714f 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -432,7 +432,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
-	if (primary_if->if_status != IF_ACTIVE) {
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = seq_printf(seq,
 				 "BATMAN mesh %s disabled - primary interface not active\n",
 				 net_dev->name);
@@ -784,7 +784,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 	}
 
-	if (primary_if->if_status != IF_ACTIVE) {
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = seq_printf(seq,
 				 "BATMAN mesh %s disabled - primary interface not active\n",
 				 net_dev->name);
diff --git a/vis.c b/vis.c
index 7418169..c920b4b 100644
--- a/vis.c
+++ b/vis.c
@@ -599,7 +599,7 @@ static int batadv_generate_vis_packet(struct bat_priv *bat_priv)
 			if (!batadv_compare_eth(router->addr, orig_node->orig))
 				goto next;
 
-			if (router->if_incoming->if_status != IF_ACTIVE)
+			if (router->if_incoming->if_status != BATADV_IF_ACTIVE)
 				goto next;
 
 			if (router->tq_avg < 1)
-- 
1.7.10

