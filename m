Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 24 Jul 2010 17:16:54 +0200
Message-Id: <1279984615-1144-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201007241716.07250.lindner_marek@yahoo.de>
References: <201007241716.07250.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: multiple mesh clouds
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

This patch removes all remaining global variables and includes the
necessary bits into the bat_priv structure. It is the last
remaining piece to allow multiple concurrent mesh clouds on the
same device.
A few global variables have been rendered obsolete during the process
and have been removed entirely.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/aggregation.c       |   18 ++--
 batman-adv/bat_sysfs.c         |    2 +-
 batman-adv/gateway_client.c    |  101 +++++++--------
 batman-adv/gateway_client.h    |    8 +-
 batman-adv/gateway_common.c    |    4 +-
 batman-adv/hard-interface.c    |   42 +++---
 batman-adv/icmp_socket.c       |   11 +-
 batman-adv/main.c              |   77 ++++++------
 batman-adv/main.h              |   22 +---
 batman-adv/originator.c        |  122 ++++++++++-------
 batman-adv/originator.h        |    6 +-
 batman-adv/routing.c           |  113 +++++++++-------
 batman-adv/routing.h           |    5 +-
 batman-adv/send.c              |  111 +++++++++-------
 batman-adv/send.h              |    3 +-
 batman-adv/soft-interface.c    |   61 +++++----
 batman-adv/soft-interface.h    |    3 -
 batman-adv/translation-table.c |  219 ++++++++++++++++---------------
 batman-adv/translation-table.h |   17 +--
 batman-adv/types.h             |   85 +++++++++---
 batman-adv/vis.c               |  288 ++++++++++++++++++++++------------------
 batman-adv/vis.h               |   27 +----
 22 files changed, 705 insertions(+), 640 deletions(-)

diff --git a/batman-adv/aggregation.c b/batman-adv/aggregation.c
index 853a74c..57f30a4 100644
--- a/batman-adv/aggregation.c
+++ b/batman-adv/aggregation.c
@@ -104,9 +104,9 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 			   struct batman_if *if_incoming,
 			   int own_packet)
 {
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct forw_packet *forw_packet_aggr;
 	unsigned long flags;
-	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 
 	/* own packet should always be scheduled */
 	if (!own_packet) {
@@ -152,9 +152,9 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 		forw_packet_aggr->direct_link_flags |= 1;
 
 	/* add new packet to packet list */
-	spin_lock_irqsave(&forw_bat_list_lock, flags);
-	hlist_add_head(&forw_packet_aggr->list, &forw_bat_list);
-	spin_unlock_irqrestore(&forw_bat_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
+	hlist_add_head(&forw_packet_aggr->list, &bat_priv->forw_bat_list);
+	spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
@@ -198,11 +198,11 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 	unsigned long flags;
 
 	/* find position for the packet in the forward queue */
-	spin_lock_irqsave(&forw_bat_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
 	/* own packets are not to be aggregated */
 	if ((atomic_read(&bat_priv->aggregation_enabled)) && (!own_packet)) {
-		hlist_for_each_entry(forw_packet_pos, tmp_node, &forw_bat_list,
-				     list) {
+		hlist_for_each_entry(forw_packet_pos, tmp_node,
+				     &bat_priv->forw_bat_list, list) {
 			if (can_aggregate_with(batman_packet,
 					       packet_len,
 					       send_time,
@@ -219,7 +219,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 	 * suitable aggregation packet found */
 	if (forw_packet_aggr == NULL) {
 		/* the following section can run without the lock */
-		spin_unlock_irqrestore(&forw_bat_list_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
 
 		/**
 		 * if we could not aggregate this packet with one of the others
@@ -237,7 +237,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 		aggregate(forw_packet_aggr,
 			  packet_buff, packet_len,
 			  direct_link);
-		spin_unlock_irqrestore(&forw_bat_list_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
 	}
 }
 
diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index 422cf52..1331a02 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -459,7 +459,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 
 	return sprintf(buff, "%s\n",
 		       batman_if->if_status == IF_NOT_IN_USE ?
-							"none" : "bat0");
+					"none" : batman_if->soft_iface->name);
 }
 
 static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index d2de0e1..dddb175 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -28,18 +28,9 @@
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 
-static LIST_HEAD(gw_list);
-static DEFINE_SPINLOCK(curr_gw_lock);
-static DEFINE_SPINLOCK(gw_list_lock);
-static struct gw_node *curr_gateway;
-
-void *gw_get_selected(void)
+void *gw_get_selected(struct bat_priv *bat_priv)
 {
-	struct gw_node *curr_gateway_tmp = NULL;
-
-	spin_lock(&curr_gw_lock);
-	curr_gateway_tmp = curr_gateway;
-	spin_unlock(&curr_gw_lock);
+	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
 
 	if (!curr_gateway_tmp)
 		return NULL;
@@ -47,15 +38,14 @@ void *gw_get_selected(void)
 	return curr_gateway_tmp->orig_node;
 }
 
-void gw_deselect(void)
+void gw_deselect(struct bat_priv *bat_priv)
 {
-	spin_lock(&curr_gw_lock);
-	curr_gateway = NULL;
-	spin_unlock(&curr_gw_lock);
+	bat_priv->curr_gw = NULL;
 }
 
 void gw_election(struct bat_priv *bat_priv)
 {
+	struct hlist_node *node;
 	struct gw_node *gw_node, *curr_gw_tmp = NULL;
 	uint8_t max_tq = 0;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
@@ -70,24 +60,24 @@ void gw_election(struct bat_priv *bat_priv)
 	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
 		return;
 
-	if (curr_gateway)
+	if (bat_priv->curr_gw)
 		return;
 
 	rcu_read_lock();
-	if (list_empty(&gw_list)) {
+	if (hlist_empty(&bat_priv->gw_list)) {
 		rcu_read_unlock();
 
-		if (curr_gateway) {
+		if (bat_priv->curr_gw) {
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
 				"no gateway in range\n");
-			gw_deselect();
+			gw_deselect(bat_priv);
 		}
 
 		return;
 	}
 
-	list_for_each_entry_rcu(gw_node, &gw_list, list) {
+	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
 		if (!gw_node->orig_node->router)
 			continue;
 
@@ -132,13 +122,12 @@ void gw_election(struct bat_priv *bat_priv)
 	}
 	rcu_read_unlock();
 
-	spin_lock(&curr_gw_lock);
-	if (curr_gateway != curr_gw_tmp) {
-		if ((curr_gateway) && (!curr_gw_tmp))
+	if (bat_priv->curr_gw != curr_gw_tmp) {
+		if ((bat_priv->curr_gw) && (!curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
 				"no gateway in range\n");
-		else if ((!curr_gateway) && (curr_gw_tmp))
+		else if ((!bat_priv->curr_gw) && (curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Adding route to gateway %pM "
 				"(gw_flags: %i, tq: %i)\n",
@@ -153,20 +142,15 @@ void gw_election(struct bat_priv *bat_priv)
 				curr_gw_tmp->orig_node->gw_flags,
 				curr_gw_tmp->orig_node->router->tq_avg);
 
-		curr_gateway = curr_gw_tmp;
+		bat_priv->curr_gw = curr_gw_tmp;
 	}
-	spin_unlock(&curr_gw_lock);
 }
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
-	struct gw_node *curr_gateway_tmp;
+	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
-	spin_lock(&curr_gw_lock);
-	curr_gateway_tmp = curr_gateway;
-	spin_unlock(&curr_gw_lock);
-
 	if (!curr_gateway_tmp)
 		return;
 
@@ -204,7 +188,7 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 		gw_tq_avg, orig_tq_avg);
 
 deselect:
-	gw_deselect();
+	gw_deselect(bat_priv);
 }
 
 static void gw_node_add(struct bat_priv *bat_priv,
@@ -218,10 +202,10 @@ static void gw_node_add(struct bat_priv *bat_priv,
 		return;
 
 	memset(gw_node, 0, sizeof(struct gw_node));
-	INIT_LIST_HEAD(&gw_node->list);
+	INIT_HLIST_NODE(&gw_node->list);
 	gw_node->orig_node = orig_node;
 
-	list_add_tail_rcu(&gw_node->list, &gw_list);
+	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
 
 	gw_srv_class_to_kbit(new_gwflags, &down, &up);
 	bat_dbg(DBG_BATMAN, bat_priv,
@@ -236,10 +220,11 @@ static void gw_node_add(struct bat_priv *bat_priv,
 void gw_node_update(struct bat_priv *bat_priv,
 		    struct orig_node *orig_node, uint8_t new_gwflags)
 {
+	struct hlist_node *node;
 	struct gw_node *gw_node;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gw_node, &gw_list, list) {
+	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
 		if (gw_node->orig_node != orig_node)
 			continue;
 
@@ -257,8 +242,8 @@ void gw_node_update(struct bat_priv *bat_priv,
 				"Gateway %pM removed from gateway list\n",
 				orig_node->orig);
 
-			if (gw_node == curr_gateway)
-				gw_deselect();
+			if (gw_node == bat_priv->curr_gw)
+				gw_deselect(bat_priv);
 		}
 
 		rcu_read_unlock();
@@ -283,41 +268,46 @@ static void gw_node_free(struct rcu_head *rcu)
 	kfree(gw_node);
 }
 
-void gw_node_purge_deleted(void)
+void gw_node_purge_deleted(struct bat_priv *bat_priv)
 {
-	struct gw_node *gw_node, *gw_node_tmp;
+	struct gw_node *gw_node;
+	struct hlist_node *node, *node_tmp;
 	unsigned long timeout = 2 * PURGE_TIMEOUT * HZ;
 
-	spin_lock(&gw_list_lock);
+	spin_lock(&bat_priv->gw_list_lock);
 
-	list_for_each_entry_safe(gw_node, gw_node_tmp, &gw_list, list) {
+	hlist_for_each_entry_safe(gw_node, node, node_tmp,
+						&bat_priv->gw_list, list) {
 		if ((gw_node->deleted) &&
 		    (time_after(jiffies, gw_node->deleted + timeout))) {
 
-			list_del_rcu(&gw_node->list);
+			hlist_del_rcu(&gw_node->list);
 			call_rcu(&gw_node->rcu, gw_node_free);
 		}
 	}
 
-	spin_unlock(&gw_list_lock);
+	spin_unlock(&bat_priv->gw_list_lock);
 }
 
-void gw_node_list_free(void)
+void gw_node_list_free(struct bat_priv *bat_priv)
 {
-	struct gw_node *gw_node, *gw_node_tmp;
+	struct gw_node *gw_node;
+	struct hlist_node *node, *node_tmp;
 
-	spin_lock(&gw_list_lock);
+	spin_lock(&bat_priv->gw_list_lock);
 
-	list_for_each_entry_safe(gw_node, gw_node_tmp, &gw_list, list) {
-		list_del_rcu(&gw_node->list);
+	hlist_for_each_entry_safe(gw_node, node, node_tmp,
+				 &bat_priv->gw_list, list) {
+		hlist_del_rcu(&gw_node->list);
 		call_rcu(&gw_node->rcu, gw_node_free);
 	}
 
-	gw_deselect();
-	spin_unlock(&gw_list_lock);
+	gw_deselect(bat_priv);
+	spin_unlock(&bat_priv->gw_list_lock);
 }
 
-static int _write_buffer_text(struct seq_file *seq, struct gw_node *gw_node)
+static int _write_buffer_text(struct bat_priv *bat_priv,
+			      struct seq_file *seq, struct gw_node *gw_node)
 {
 	int down, up;
 	char gw_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
@@ -327,7 +317,7 @@ static int _write_buffer_text(struct seq_file *seq, struct gw_node *gw_node)
 	gw_srv_class_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
 
 	return seq_printf(seq, "%s %-17s (%3i) %17s [%10s]: %3i - %i%s/%i%s\n",
-		       (curr_gateway == gw_node ? "=>" : "  "),
+		       (bat_priv->curr_gw == gw_node ? "=>" : "  "),
 		       gw_str,
 		       gw_node->orig_node->router->tq_avg,
 		       router_str,
@@ -344,6 +334,7 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct gw_node *gw_node;
+	struct hlist_node *node;
 	int gw_count = 0;
 
 	rcu_read_lock();
@@ -372,14 +363,14 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	rcu_read_unlock();
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gw_node, &gw_list, list) {
+	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
 		if (gw_node->deleted)
 			continue;
 
 		if (!gw_node->orig_node->router)
 			continue;
 
-		_write_buffer_text(seq, gw_node);
+		_write_buffer_text(bat_priv, seq, gw_node);
 		gw_count++;
 	}
 	rcu_read_unlock();
@@ -399,7 +390,7 @@ bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
 	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
 		return false;
 
-	if (!curr_gateway)
+	if (!bat_priv->curr_gw)
 		return false;
 
 	ethhdr = (struct ethhdr *)skb->data;
diff --git a/batman-adv/gateway_client.h b/batman-adv/gateway_client.h
index 19a82a7..ce0b4f0 100644
--- a/batman-adv/gateway_client.h
+++ b/batman-adv/gateway_client.h
@@ -22,15 +22,15 @@
 #ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 #define _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 
-void gw_deselect(void);
+void gw_deselect(struct bat_priv *bat_priv);
 void gw_election(struct bat_priv *bat_priv);
-void *gw_get_selected(void);
+void *gw_get_selected(struct bat_priv *bat_priv);
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void gw_node_update(struct bat_priv *bat_priv,
 		    struct orig_node *orig_node, uint8_t new_gwflags);
 void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node);
-void gw_node_purge_deleted(void);
-void gw_node_list_free(void);
+void gw_node_purge_deleted(struct bat_priv *bat_priv);
+void gw_node_list_free(struct bat_priv *bat_priv);
 int gw_client_seq_print_text(struct seq_file *seq, void *offset);
 bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb);
 
diff --git a/batman-adv/gateway_common.c b/batman-adv/gateway_common.c
index 06bdd75..3851930 100644
--- a/batman-adv/gateway_common.c
+++ b/batman-adv/gateway_common.c
@@ -261,7 +261,7 @@ next:
 		gw_srv_class_to_kbit((uint8_t)gw_class_tmp,
 				     (int *)&down, (int *)&up);
 
-		gw_deselect();
+		gw_deselect(bat_priv);
 		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s' "
 			 "(gw_class: %ld -> propagating: %ld%s/%ld%s)\n",
 			 gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp,
@@ -280,7 +280,7 @@ next:
 	atomic_set(&bat_priv->gw_class, gw_class_tmp);
 
 	if (gw_class_tmp == 0)
-		gw_deselect();
+		gw_deselect(bat_priv);
 
 end:
 	return count;
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 307acbd..e80dd50 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -80,13 +80,15 @@ static int is_valid_iface(struct net_device *net_dev)
 	return 1;
 }
 
-static struct batman_if *get_active_batman_if(void)
+static struct batman_if *get_active_batman_if(struct net_device *soft_iface)
 {
 	struct batman_if *batman_if;
 
-	/* TODO: should check interfaces belonging to bat_priv */
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
+		if (batman_if->soft_iface != soft_iface)
+			continue;
+
 		if (batman_if->if_status == IF_ACTIVE)
 			goto out;
 	}
@@ -108,8 +110,6 @@ static void set_primary_if(struct bat_priv *bat_priv,
 	if (!bat_priv->primary_if)
 		return;
 
-	set_main_if_addr(batman_if->net_dev->dev_addr);
-
 	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
 	batman_packet->flags = PRIMARIES_FIRST_HOP;
 	batman_packet->ttl = TTL;
@@ -118,7 +118,7 @@ static void set_primary_if(struct bat_priv *bat_priv,
 	 * hacky trick to make sure that we send the HNA information via
 	 * our new primary interface
 	 */
-	atomic_set(&hna_local_changed, 1);
+	atomic_set(&bat_priv->hna_local_changed, 1);
 }
 
 static bool hardif_is_iface_up(struct batman_if *batman_if)
@@ -221,9 +221,6 @@ static void hardif_activate_interface(struct batman_if *batman_if)
 	bat_info(batman_if->soft_iface, "Interface activated: %s\n",
 		 batman_if->dev);
 
-	if (atomic_read(&module_state) == MODULE_INACTIVE)
-		activate_module();
-
 	update_min_mtu(batman_if->soft_iface);
 	return;
 }
@@ -346,11 +343,16 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
 
 	if (batman_if == bat_priv->primary_if)
-		set_primary_if(bat_priv, get_active_batman_if());
+		set_primary_if(bat_priv,
+			       get_active_batman_if(batman_if->soft_iface));
 
 	kfree(batman_if->packet_buff);
 	batman_if->packet_buff = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
+
+	/* delete all references to this batman_if */
+	purge_orig_ref(bat_priv);
+	purge_outstanding_packets(bat_priv, batman_if);
 	dev_put(batman_if->soft_iface);
 
 	/* nobody uses this interface anymore */
@@ -358,10 +360,6 @@ void hardif_disable_interface(struct batman_if *batman_if)
 		softif_destroy(batman_if->soft_iface);
 
 	batman_if->soft_iface = NULL;
-
-	/*if ((atomic_read(&module_state) == MODULE_ACTIVE) &&
-	    (bat_priv->num_ifaces == 0))
-		deactivate_module();*/
 }
 
 static struct batman_if *hardif_add_interface(struct net_device *net_dev)
@@ -410,10 +408,6 @@ static void hardif_free_interface(struct rcu_head *rcu)
 {
 	struct batman_if *batman_if = container_of(rcu, struct batman_if, rcu);
 
-	/* delete all references to this batman_if */
-	purge_orig(NULL);
-	purge_outstanding_packets(batman_if);
-
 	kfree(batman_if->dev);
 	kfree(batman_if);
 }
@@ -509,9 +503,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb)
 		goto err_out;
 
-	if (atomic_read(&module_state) != MODULE_ACTIVE)
-		goto err_free;
-
 	/* if netfilter/ebtables wants to block incoming batman
 	 * packets then give them a chance to do so here */
 	ret = NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, dev, NULL,
@@ -532,12 +523,19 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!batman_if)
 		goto err_free;
 
+	if (!batman_if->soft_iface)
+		goto err_free;
+
+	bat_priv = netdev_priv(batman_if->soft_iface);
+
+	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
+		goto err_free;
+
 	/* discard frames on not active interfaces */
 	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
 
 	batman_packet = (struct batman_packet *)skb->data;
-	bat_priv = netdev_priv(batman_if->soft_iface);
 
 	if (batman_packet->version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -557,7 +555,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 		/* batman icmp packet */
 	case BAT_ICMP:
-		ret = recv_icmp_packet(skb);
+		ret = recv_icmp_packet(skb, batman_if);
 		break;
 
 		/* unicast packet */
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index 2660516..8ef87c0 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -205,11 +205,12 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		goto out;
 	}
 
-	if (atomic_read(&module_state) != MODULE_ACTIVE)
+	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dst_unreach;
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
-	orig_node = ((struct orig_node *)hash_find(orig_hash, icmp_packet.dst));
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
+						   icmp_packet.dst));
 
 	if (!orig_node)
 		goto unlock;
@@ -220,7 +221,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	batman_if = orig_node->router->if_incoming;
 	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 	if (!batman_if)
 		goto dst_unreach;
@@ -239,7 +240,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	goto out;
 
 unlock:
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 dst_unreach:
 	icmp_packet.msg_type = DESTINATION_UNREACHABLE;
 	bat_socket_add_packet(socket_client, &icmp_packet, packet_len);
diff --git a/batman-adv/main.c b/batman-adv/main.c
index 22f9c5e..22767b7 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -36,18 +36,8 @@
 #include "compat.h"
 
 struct list_head if_list;
-struct hlist_head forw_bat_list;
-struct hlist_head forw_bcast_list;
-struct hashtable_t *orig_hash;
-
-DEFINE_SPINLOCK(orig_hash_lock);
-DEFINE_SPINLOCK(forw_bat_list_lock);
-DEFINE_SPINLOCK(forw_bcast_list_lock);
-
-int16_t num_hna;
 
 unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-atomic_t module_state;
 
 static struct packet_type batman_adv_packet_type __read_mostly = {
 	.type = __constant_htons(ETH_P_BATMAN),
@@ -59,10 +49,6 @@ struct workqueue_struct *bat_event_workqueue;
 static int __init batman_init(void)
 {
 	INIT_LIST_HEAD(&if_list);
-	INIT_HLIST_HEAD(&forw_bat_list);
-	INIT_HLIST_HEAD(&forw_bcast_list);
-
-	atomic_set(&module_state, MODULE_INACTIVE);
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
@@ -86,69 +72,82 @@ static int __init batman_init(void)
 
 static void __exit batman_exit(void)
 {
-	deactivate_module();
-
 	debugfs_destroy();
 	unregister_netdevice_notifier(&hard_if_notifier);
 	hardif_remove_interfaces();
 
 	dev_remove_pack(&batman_adv_packet_type);
 
+	flush_workqueue(bat_event_workqueue);
 	destroy_workqueue(bat_event_workqueue);
 	bat_event_workqueue = NULL;
 }
 
-/* activates the module, starts timer ... */
-void activate_module(void)
+int mesh_init(struct net_device *soft_iface)
 {
-	if (originator_init() < 1)
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
+
+	spin_lock_init(&bat_priv->orig_hash_lock);
+	spin_lock_init(&bat_priv->forw_bat_list_lock);
+	spin_lock_init(&bat_priv->forw_bcast_list_lock);
+	spin_lock_init(&bat_priv->hna_lhash_lock);
+	spin_lock_init(&bat_priv->hna_ghash_lock);
+	spin_lock_init(&bat_priv->gw_list_lock);
+	spin_lock_init(&bat_priv->vis_hash_lock);
+	spin_lock_init(&bat_priv->vis_list_lock);
+
+	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
+	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
+	INIT_HLIST_HEAD(&bat_priv->gw_list);
+
+	if (originator_init(bat_priv) < 1)
 		goto err;
 
-	if (hna_local_init() < 1)
+	if (hna_local_init(bat_priv) < 1)
 		goto err;
 
-	if (hna_global_init() < 1)
+	if (hna_global_init(bat_priv) < 1)
 		goto err;
 
-	/*hna_local_add(soft_device->dev_addr);*/
+	hna_local_add(soft_iface, soft_iface->dev_addr);
 
-	if (vis_init() < 1)
+	if (vis_init(bat_priv) < 1)
 		goto err;
 
-	/*update_min_mtu();*/
-	atomic_set(&module_state, MODULE_ACTIVE);
+
+	atomic_set(&bat_priv->mesh_state, MESH_ACTIVE);
 	goto end;
 
 err:
 	pr_err("Unable to allocate memory for mesh information structures: "
 	       "out of mem ?\n");
-	deactivate_module();
+	mesh_free(soft_iface);
+	return 1;
+
 end:
-	return;
+	return 0;
 }
 
-/* shuts down the whole module.*/
-void deactivate_module(void)
+void mesh_free(struct net_device *soft_iface)
 {
-	atomic_set(&module_state, MODULE_DEACTIVATING);
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 
-	purge_outstanding_packets(NULL);
-	flush_workqueue(bat_event_workqueue);
+	atomic_set(&bat_priv->mesh_state, MESH_DEACTIVATING);
 
-	vis_quit();
+	purge_outstanding_packets(bat_priv, NULL);
 
-	/* TODO: unregister BATMAN pack */
+	vis_quit(bat_priv);
 
-	gw_node_list_free();
-	originator_free();
+	gw_node_list_free(bat_priv);
+	originator_free(bat_priv);
 
-	hna_local_free();
-	hna_global_free();
+	hna_local_free(bat_priv);
+	hna_global_free(bat_priv);
 
 	synchronize_net();
 
 	synchronize_rcu();
-	atomic_set(&module_state, MODULE_INACTIVE);
+	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 }
 
 void inc_module_count(void)
diff --git a/batman-adv/main.h b/batman-adv/main.h
index 70d6e36..1528f7a 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -76,9 +76,9 @@
 #define EXPECTED_SEQNO_RANGE	65536
 /* don't reset again within 30 seconds */
 
-#define MODULE_INACTIVE 0
-#define MODULE_ACTIVE 1
-#define MODULE_DEACTIVATING 2
+#define MESH_INACTIVE 0
+#define MESH_ACTIVE 1
+#define MESH_DEACTIVATING 2
 
 #define BCAST_QUEUE_LEN		256
 #define BATMAN_QUEUE_LEN	256
@@ -128,22 +128,12 @@
 #endif
 
 extern struct list_head if_list;
-extern struct hlist_head forw_bat_list;
-extern struct hlist_head forw_bcast_list;
-extern struct hashtable_t *orig_hash;
-
-extern spinlock_t orig_hash_lock;
-extern spinlock_t forw_bat_list_lock;
-extern spinlock_t forw_bcast_list_lock;
-
-extern int16_t num_hna;
 
 extern unsigned char broadcast_addr[];
-extern atomic_t module_state;
 extern struct workqueue_struct *bat_event_workqueue;
 
-void activate_module(void);
-void deactivate_module(void);
+int mesh_init(struct net_device *soft_iface);
+void mesh_free(struct net_device *soft_iface);
 void inc_module_count(void);
 void dec_module_count(void);
 int addr_to_string(char *buff, uint8_t *addr);
@@ -154,7 +144,7 @@ int is_bcast(uint8_t *addr);
 int is_mcast(uint8_t *addr);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-extern int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
+int debug_log(struct bat_priv *bat_priv, char *fmt, ...);
 
 #define bat_dbg(type, bat_priv, fmt, arg...)			\
 	do {							\
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 205ec01..aba582e 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -31,31 +31,32 @@
 #include "hard-interface.h"
 #include "fragmentation.h"
 
-static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
+static void purge_orig(struct work_struct *work);
 
-static void start_purge_timer(void)
+static void start_purge_timer(struct bat_priv *bat_priv)
 {
-	queue_delayed_work(bat_event_workqueue, &purge_orig_wq, 1 * HZ);
+	INIT_DELAYED_WORK(&bat_priv->orig_work, purge_orig);
+	queue_delayed_work(bat_event_workqueue, &bat_priv->orig_work, 1 * HZ);
 }
 
-int originator_init(void)
+int originator_init(struct bat_priv *bat_priv)
 {
 	unsigned long flags;
-	if (orig_hash)
+	if (bat_priv->orig_hash)
 		return 1;
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
-	orig_hash = hash_new(128, compare_orig, choose_orig);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	bat_priv->orig_hash = hash_new(128, compare_orig, choose_orig);
 
-	if (!orig_hash)
+	if (!bat_priv->orig_hash)
 		goto err;
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
-	start_purge_timer();
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
+	start_purge_timer(bat_priv);
 	return 1;
 
 err:
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 	return 0;
 }
 
@@ -106,19 +107,19 @@ static void free_orig_node(void *data, void *arg)
 	kfree(orig_node);
 }
 
-void originator_free(void)
+void originator_free(struct bat_priv *bat_priv)
 {
 	unsigned long flags;
 
-	if (!orig_hash)
+	if (!bat_priv->orig_hash)
 		return;
 
-	cancel_delayed_work_sync(&purge_orig_wq);
+	cancel_delayed_work_sync(&bat_priv->orig_work);
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
-	/*hash_delete(orig_hash, free_orig_node, bat_priv);*/
-	orig_hash = NULL;
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	hash_delete(bat_priv->orig_hash, free_orig_node, bat_priv);
+	bat_priv->orig_hash = NULL;
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 }
 
 /* this function finds or creates an originator entry for the given
@@ -129,9 +130,9 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	struct hashtable_t *swaphash;
 	int size;
 
-	orig_node = ((struct orig_node *)hash_find(orig_hash, addr));
+	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash, addr));
 
-	if (orig_node != NULL)
+	if (orig_node)
 		return orig_node;
 
 	bat_dbg(DBG_BATMAN, bat_priv,
@@ -166,17 +167,18 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
-	if (hash_add(orig_hash, orig_node) < 0)
+	if (hash_add(bat_priv->orig_hash, orig_node) < 0)
 		goto free_bcast_own_sum;
 
-	if (orig_hash->elements * 4 > orig_hash->size) {
-		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
+	if (bat_priv->orig_hash->elements * 4 > bat_priv->orig_hash->size) {
+		swaphash = hash_resize(bat_priv->orig_hash,
+				       bat_priv->orig_hash->size * 2);
 
-		if (swaphash == NULL)
+		if (!swaphash)
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Couldn't resize orig hash table\n");
 		else
-			orig_hash = swaphash;
+			bat_priv->orig_hash = swaphash;
 	}
 
 	return orig_node;
@@ -205,8 +207,8 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 
 		if ((time_after(jiffies,
 			neigh_node->last_valid + PURGE_TIMEOUT * HZ)) ||
-		    (neigh_node->if_incoming->if_status ==
-						IF_TO_BE_REMOVED)) {
+		    (neigh_node->if_incoming->if_status == IF_INACTIVE) ||
+		    (neigh_node->if_incoming->if_status == IF_TO_BE_REMOVED)) {
 
 			if (neigh_node->if_incoming->if_status ==
 							IF_TO_BE_REMOVED)
@@ -262,39 +264,50 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 	return false;
 }
 
-void purge_orig(struct work_struct *work)
+static void _purge_orig(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
 	unsigned long flags;
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
 	/* for all origins... */
-	while (hash_iterate(orig_hash, &hashit)) {
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
 
-		/*if (purge_orig_node(bat_priv, orig_node)) {
+		if (purge_orig_node(bat_priv, orig_node)) {
 			if (orig_node->gw_flags)
 				gw_node_delete(bat_priv, orig_node);
-			hash_remove_bucket(orig_hash, &hashit);
-			free_orig_node(orig_node);
-		}*/
+			hash_remove_bucket(bat_priv->orig_hash, &hashit);
+			free_orig_node(orig_node, bat_priv);
+		}
 
 		if (time_after(jiffies, (orig_node->last_frag_packet +
 					msecs_to_jiffies(FRAG_TIMEOUT))))
 			frag_list_free(&orig_node->frag_list);
 	}
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
-	gw_node_purge_deleted();
-	/*gw_election(bat_priv);*/
+	gw_node_purge_deleted(bat_priv);
+	gw_election(bat_priv);
+}
 
-	/* if work == NULL we were not called by the timer
-	 * and thus do not need to re-arm the timer */
-	if (work)
-		start_purge_timer();
+static void purge_orig(struct work_struct *work)
+{
+	struct delayed_work *delayed_work =
+		container_of(work, struct delayed_work, work);
+	struct bat_priv *bat_priv =
+		container_of(delayed_work, struct bat_priv, orig_work);
+
+	_purge_orig(bat_priv);
+	start_purge_timer(bat_priv);
+}
+
+void purge_orig_ref(struct bat_priv *bat_priv)
+{
+	_purge_orig(bat_priv);
 }
 
 int orig_seq_print_text(struct seq_file *seq, void *offset)
@@ -332,9 +345,9 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		   "outgoingIF", "Potential nexthops");
 	rcu_read_unlock();
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
-	while (hash_iterate(orig_hash, &hashit)) {
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 
 		orig_node = hashit.bucket->data;
 
@@ -366,7 +379,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		batman_count++;
 	}
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 	if ((batman_count == 0))
 		seq_printf(seq, "No batman nodes in range ...\n");
@@ -406,25 +419,26 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 {
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	struct orig_node *orig_node;
 	HASHIT(hashit);
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock(&orig_hash_lock);
+	spin_lock(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(orig_hash, &hashit)) {
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
 
 		if (orig_node_add_if(orig_node, max_if_num) == -1)
 			goto err;
 	}
 
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&bat_priv->orig_hash_lock);
 	return 0;
 
 err:
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&bat_priv->orig_hash_lock);
 	return -ENOMEM;
 }
 
@@ -482,6 +496,7 @@ free_own_sum:
 
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 {
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	struct batman_if *batman_if_tmp;
 	struct orig_node *orig_node;
 	HASHIT(hashit);
@@ -489,9 +504,9 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock(&orig_hash_lock);
+	spin_lock(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(orig_hash, &hashit)) {
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
 
 		ret = orig_node_del_if(orig_node, max_if_num,
@@ -510,16 +525,19 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 		if (batman_if == batman_if_tmp)
 			continue;
 
+		if (batman_if->soft_iface != batman_if_tmp->soft_iface)
+			continue;
+
 		if (batman_if_tmp->if_num > batman_if->if_num)
 			batman_if_tmp->if_num--;
 	}
 	rcu_read_unlock();
 
 	batman_if->if_num = -1;
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&bat_priv->orig_hash_lock);
 	return 0;
 
 err:
-	spin_unlock(&orig_hash_lock);
+	spin_unlock(&bat_priv->orig_hash_lock);
 	return -ENOMEM;
 }
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index bc47c68..a97c400 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -22,9 +22,9 @@
 #ifndef _NET_BATMAN_ADV_ORIGINATOR_H_
 #define _NET_BATMAN_ADV_ORIGINATOR_H_
 
-int originator_init(void);
-void originator_free(void);
-void purge_orig(struct work_struct *work);
+int originator_init(struct bat_priv *bat_priv);
+void originator_free(struct bat_priv *bat_priv);
+void purge_orig_ref(struct bat_priv *bat_priv);
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 3baec55..399ac60 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -36,8 +36,6 @@
 #include "gateway_client.h"
 #include "fragmentation.h"
 
-static DECLARE_WAIT_QUEUE_HEAD(thread_wait);
-
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
@@ -46,9 +44,9 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 	TYPE_OF_WORD *word;
 	unsigned long flags;
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
-	while (hash_iterate(orig_hash, &hashit)) {
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
 		word = &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
 
@@ -57,7 +55,7 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 			bit_packet_count(word);
 	}
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 }
 
 static void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
@@ -580,6 +578,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		if (batman_if->if_status != IF_ACTIVE)
 			continue;
 
+		if (batman_if->soft_iface != if_incoming->soft_iface)
+			continue;
+
 		if (compare_orig(ethhdr->h_source,
 				 batman_if->net_dev->dev_addr))
 			is_my_addr = 1;
@@ -751,9 +752,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				0, hna_buff_len, if_incoming);
 }
 
-int recv_bat_packet(struct sk_buff *skb,
-				struct batman_if *batman_if)
+int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	struct ethhdr *ethhdr;
 	unsigned long flags;
 	struct sk_buff *skb_old;
@@ -785,18 +786,19 @@ int recv_bat_packet(struct sk_buff *skb,
 		kfree_skb(skb_old);
 	}
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	receive_aggr_bat_packet(ethhdr,
 				skb->data,
 				skb_headlen(skb),
 				batman_if);
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 	kfree_skb(skb);
 	return NET_RX_SUCCESS;
 }
 
-static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
+static int recv_my_icmp_packet(struct bat_priv *bat_priv,
+			       struct sk_buff *skb, size_t icmp_len)
 {
 	struct orig_node *orig_node;
 	struct icmp_packet_rr *icmp_packet;
@@ -818,8 +820,8 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 
 	/* answer echo request (ping) */
 	/* get routing information */
-	spin_lock_irqsave(&orig_hash_lock, flags);
-	orig_node = ((struct orig_node *)hash_find(orig_hash,
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
+	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   icmp_packet->orig));
 	ret = NET_RX_DROP;
 
@@ -830,7 +832,7 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 		 * copy the required data before sending */
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
 		skb_old = NULL;
@@ -853,12 +855,13 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 		ret = NET_RX_SUCCESS;
 
 	} else
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 	return ret;
 }
 
-static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
+static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
+				  struct sk_buff *skb, size_t icmp_len)
 {
 	struct orig_node *orig_node;
 	struct icmp_packet *icmp_packet;
@@ -881,9 +884,9 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 	}
 
 	/* get routing information */
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, icmp_packet->orig));
+		     hash_find(bat_priv->orig_hash, icmp_packet->orig));
 	ret = NET_RX_DROP;
 
 	if ((orig_node != NULL) &&
@@ -893,7 +896,7 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 		 * copy the required data before sending */
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
 		if (!skb_clone_writable(skb, icmp_len)) {
@@ -915,14 +918,15 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 		ret = NET_RX_SUCCESS;
 
 	} else
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 	return ret;
 }
 
 
-int recv_icmp_packet(struct sk_buff *skb)
+int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct orig_node *orig_node;
@@ -969,18 +973,18 @@ int recv_icmp_packet(struct sk_buff *skb)
 
 	/* packet for me */
 	if (is_my_mac(icmp_packet->dst))
-		return recv_my_icmp_packet(skb, hdr_size);
+		return recv_my_icmp_packet(bat_priv, skb, hdr_size);
 
 	/* TTL exceeded */
 	if (icmp_packet->ttl < 2)
-		return recv_icmp_ttl_exceeded(skb, hdr_size);
+		return recv_icmp_ttl_exceeded(bat_priv, skb, hdr_size);
 
 	ret = NET_RX_DROP;
 
 	/* get routing information */
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, icmp_packet->dst));
+		     hash_find(bat_priv->orig_hash, icmp_packet->dst));
 
 	if ((orig_node != NULL) &&
 	    (orig_node->router != NULL)) {
@@ -989,7 +993,7 @@ int recv_icmp_packet(struct sk_buff *skb)
 		 * copy the required data before sending */
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
 		if (!skb_clone_writable(skb, hdr_size)) {
@@ -1010,7 +1014,7 @@ int recv_icmp_packet(struct sk_buff *skb)
 		ret = NET_RX_SUCCESS;
 
 	} else
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 	return ret;
 }
@@ -1018,7 +1022,7 @@ int recv_icmp_packet(struct sk_buff *skb)
 /* find a suitable router for this originator, and use
  * bonding if possible. */
 struct neigh_node *find_router(struct orig_node *orig_node,
-		struct batman_if *recv_if)
+			       struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv;
 	struct orig_node *primary_orig_node;
@@ -1059,8 +1063,9 @@ struct neigh_node *find_router(struct orig_node *orig_node,
 				router_orig->orig, ETH_ALEN) == 0) {
 		primary_orig_node = router_orig;
 	} else {
-		primary_orig_node = hash_find(orig_hash,
+		primary_orig_node = hash_find(bat_priv->orig_hash,
 						router_orig->primary_addr);
+
 		if (!primary_orig_node)
 			return orig_node->router;
 	}
@@ -1140,6 +1145,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 static int route_unicast_packet(struct sk_buff *skb,
 				struct batman_if *recv_if, int hdr_size)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node;
 	struct neigh_node *router;
 	struct batman_if *batman_if;
@@ -1166,14 +1172,14 @@ static int route_unicast_packet(struct sk_buff *skb,
 	}
 
 	/* get routing information */
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, unicast_packet->dest));
+		     hash_find(bat_priv->orig_hash, unicast_packet->dest));
 
 	router = find_router(orig_node, recv_if);
 
 	if (!router) {
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 		return NET_RX_DROP;
 	}
 
@@ -1183,7 +1189,7 @@ static int route_unicast_packet(struct sk_buff *skb,
 	batman_if = router->if_incoming;
 	memcpy(dstaddr, router->addr, ETH_ALEN);
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 	/* create a copy of the skb, if needed, to modify it. */
 	if (!skb_clone_writable(skb, hdr_size)) {
@@ -1191,7 +1197,7 @@ static int route_unicast_packet(struct sk_buff *skb,
 		skb = skb_copy(skb, GFP_ATOMIC);
 		if (!skb)
 			return NET_RX_DROP;
-		unicast_packet = (struct unicast_packet *) skb->data;
+		unicast_packet = (struct unicast_packet *)skb->data;
 		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 		kfree_skb(skb_old);
 	}
@@ -1226,6 +1232,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_frag_packet *unicast_packet;
 	struct orig_node *orig_node;
 	struct frag_packet_list_entry *tmp_frag_entry;
@@ -1235,19 +1242,20 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
-	unicast_packet = (struct unicast_frag_packet *) skb->data;
+	unicast_packet = (struct unicast_frag_packet *)skb->data;
 
 	/* packet for me */
 	if (is_my_mac(unicast_packet->dest)) {
 
-		spin_lock_irqsave(&orig_hash_lock, flags);
+		spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 		orig_node = ((struct orig_node *)
-			hash_find(orig_hash, unicast_packet->orig));
+			hash_find(bat_priv->orig_hash, unicast_packet->orig));
 
 		if (!orig_node) {
 			pr_warning("couldn't find orig node for "
 				"fragmentation\n");
-			spin_unlock_irqrestore(&orig_hash_lock, flags);
+			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
+					       flags);
 			return NET_RX_DROP;
 		}
 
@@ -1258,17 +1266,18 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 		tmp_frag_entry =
 			search_frag_packet(&orig_node->frag_list,
-			unicast_packet);
+					   unicast_packet);
 
 		if (!tmp_frag_entry) {
 			create_frag_entry(&orig_node->frag_list, skb);
-			spin_unlock_irqrestore(&orig_hash_lock, flags);
+			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
+					       flags);
 			return NET_RX_SUCCESS;
 		}
 
 		skb = merge_frag_packet(&orig_node->frag_list,
-			tmp_frag_entry, skb);
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+					tmp_frag_entry, skb);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 		if (!skb)
 			return NET_RX_DROP;
 
@@ -1280,12 +1289,12 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 }
 
 
-int recv_bcast_packet(struct sk_buff *skb, struct batman_if *batman_if)
+int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node;
 	struct bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
-	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	int hdr_size = sizeof(struct bcast_packet);
 	int32_t seq_diff;
 	unsigned long flags;
@@ -1317,12 +1326,12 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *batman_if)
 	if (bcast_packet->ttl < 2)
 		return NET_RX_DROP;
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, bcast_packet->orig));
+		     hash_find(bat_priv->orig_hash, bcast_packet->orig));
 
 	if (orig_node == NULL) {
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 		return NET_RX_DROP;
 	}
 
@@ -1330,7 +1339,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *batman_if)
 	if (get_bit_status(orig_node->bcast_bits,
 			   orig_node->last_bcast_seqno,
 			   ntohl(bcast_packet->seqno))) {
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 		return NET_RX_DROP;
 	}
 
@@ -1339,7 +1348,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *batman_if)
 	/* check whether the packet is old and the host just restarted. */
 	if (window_protected(bat_priv, seq_diff,
 			     &orig_node->bcast_seqno_reset)) {
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 		return NET_RX_DROP;
 	}
 
@@ -1348,21 +1357,21 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *batman_if)
 	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 	/* rebroadcast packet */
 	add_bcast_packet_to_list(bat_priv, skb);
 
 	/* broadcast for me */
-	interface_rx(batman_if->soft_iface, skb, hdr_size);
+	interface_rx(recv_if->soft_iface, skb, hdr_size);
 
 	return NET_RX_SUCCESS;
 }
 
-int recv_vis_packet(struct sk_buff *skb, struct batman_if *batman_if)
+int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct vis_packet *vis_packet;
 	struct ethhdr *ethhdr;
-	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	int hdr_size = sizeof(struct vis_packet);
 
 	if (skb_headlen(skb) < hdr_size)
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index 67f2842..06ea99d 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -32,13 +32,12 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len);
-int recv_icmp_packet(struct sk_buff *skb);
+int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
-int recv_bat_packet(struct sk_buff *skb,
-				struct batman_if *batman_if);
+int recv_bat_packet(struct sk_buff *skb, struct batman_if *recv_if);
 struct neigh_node *find_router(struct orig_node *orig_node,
 		struct batman_if *recv_if);
 void update_bonding_candidates(struct bat_priv *bat_priv,
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 785f997..0baa294 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -182,8 +182,8 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 static void send_packet(struct forw_packet *forw_packet)
 {
 	struct batman_if *batman_if;
-	struct bat_priv *bat_priv =
-		netdev_priv(forw_packet->if_incoming->soft_iface);
+	struct net_device *soft_iface = forw_packet->if_incoming->soft_iface;
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->packet_buff);
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
@@ -220,18 +220,24 @@ static void send_packet(struct forw_packet *forw_packet)
 
 	/* broadcast on every interface */
 	rcu_read_lock();
-	list_for_each_entry_rcu(batman_if, &if_list, list)
+	list_for_each_entry_rcu(batman_if, &if_list, list) {
+		if (batman_if->soft_iface != soft_iface)
+			continue;
+
 		send_packet_to_if(forw_packet, batman_if);
+	}
 	rcu_read_unlock();
 }
 
-static void rebuild_batman_packet(struct batman_if *batman_if)
+static void rebuild_batman_packet(struct bat_priv *bat_priv,
+				  struct batman_if *batman_if)
 {
 	int new_len;
 	unsigned char *new_buff;
 	struct batman_packet *batman_packet;
 
-	new_len = sizeof(struct batman_packet) + (num_hna * ETH_ALEN);
+	new_len = sizeof(struct batman_packet) +
+			(bat_priv->num_local_hna * ETH_ALEN);
 	new_buff = kmalloc(new_len, GFP_ATOMIC);
 
 	/* keep old buffer if kmalloc should fail */
@@ -240,9 +246,9 @@ static void rebuild_batman_packet(struct batman_if *batman_if)
 		       sizeof(struct batman_packet));
 		batman_packet = (struct batman_packet *)new_buff;
 
-		batman_packet->num_hna = hna_local_fill_buffer(
-			new_buff + sizeof(struct batman_packet),
-			new_len - sizeof(struct batman_packet));
+		batman_packet->num_hna = hna_local_fill_buffer(bat_priv,
+				new_buff + sizeof(struct batman_packet),
+				new_len - sizeof(struct batman_packet));
 
 		kfree(batman_if->packet_buff);
 		batman_if->packet_buff = new_buff;
@@ -274,9 +280,9 @@ void schedule_own_packet(struct batman_if *batman_if)
 		batman_if->if_status = IF_ACTIVE;
 
 	/* if local hna has changed and interface is a primary interface */
-	if ((atomic_read(&hna_local_changed)) &&
+	if ((atomic_read(&bat_priv->hna_local_changed)) &&
 	    (batman_if == bat_priv->primary_if))
-		rebuild_batman_packet(batman_if);
+		rebuild_batman_packet(bat_priv, batman_if);
 
 	/**
 	 * NOTE: packet_buff might just have been re-allocated in
@@ -379,16 +385,17 @@ static void forw_packet_free(struct forw_packet *forw_packet)
 	kfree(forw_packet);
 }
 
-static void _add_bcast_packet_to_list(struct forw_packet *forw_packet,
+static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
+				      struct forw_packet *forw_packet,
 				      unsigned long send_time)
 {
 	unsigned long flags;
 	INIT_HLIST_NODE(&forw_packet->list);
 
 	/* add new packet to packet list */
-	spin_lock_irqsave(&forw_bcast_list_lock, flags);
-	hlist_add_head(&forw_packet->list, &forw_bcast_list);
-	spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
+	hlist_add_head(&forw_packet->list, &bat_priv->forw_bcast_list);
+	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
@@ -416,6 +423,9 @@ int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb)
 		goto out;
 	}
 
+	if (!bat_priv->primary_if)
+		goto out;
+
 	forw_packet = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
 
 	if (!forw_packet)
@@ -433,11 +443,12 @@ int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb)
 
 	forw_packet->skb = skb;
 	forw_packet->packet_buff = NULL;
+	forw_packet->if_incoming = bat_priv->primary_if;
 
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets = 0;
 
-	_add_bcast_packet_to_list(forw_packet, 1);
+	_add_bcast_packet_to_list(bat_priv, forw_packet, 1);
 	return NETDEV_TX_OK;
 
 packet_free:
@@ -457,23 +468,26 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 		container_of(delayed_work, struct forw_packet, delayed_work);
 	unsigned long flags;
 	struct sk_buff *skb1;
-	struct bat_priv *bat_priv;
+	struct net_device *soft_iface = forw_packet->if_incoming->soft_iface;
+	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 
-	spin_lock_irqsave(&forw_bcast_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
 	hlist_del(&forw_packet->list);
-	spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
 
-	if (atomic_read(&module_state) == MODULE_DEACTIVATING)
+	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
 	/* rebroadcast packet */
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
+		if (batman_if->soft_iface != soft_iface)
+			continue;
+
 		/* send a copy of the saved skb */
 		skb1 = skb_copy(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
-			send_skb_packet(skb1,
-				batman_if, broadcast_addr);
+			send_skb_packet(skb1, batman_if, broadcast_addr);
 	}
 	rcu_read_unlock();
 
@@ -481,12 +495,12 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 
 	/* if we still have some more bcasts to send */
 	if (forw_packet->num_packets < 3) {
-		_add_bcast_packet_to_list(forw_packet, ((5 * HZ) / 1000));
+		_add_bcast_packet_to_list(bat_priv, forw_packet,
+					  ((5 * HZ) / 1000));
 		return;
 	}
 
 out:
-	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
 	forw_packet_free(forw_packet);
 	atomic_inc(&bat_priv->bcast_queue_left);
 }
@@ -500,11 +514,12 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	unsigned long flags;
 	struct bat_priv *bat_priv;
 
-	spin_lock_irqsave(&forw_bat_list_lock, flags);
+	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
+	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
 	hlist_del(&forw_packet->list);
-	spin_unlock_irqrestore(&forw_bat_list_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
 
-	if (atomic_read(&module_state) == MODULE_DEACTIVATING)
+	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
 	send_packet(forw_packet);
@@ -518,8 +533,6 @@ void send_outstanding_bat_packet(struct work_struct *work)
 		schedule_own_packet(forw_packet->if_incoming);
 
 out:
-	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
-
 	/* don't count own packet */
 	if (!forw_packet->own)
 		atomic_inc(&bat_priv->batman_queue_left);
@@ -527,29 +540,25 @@ out:
 	forw_packet_free(forw_packet);
 }
 
-void purge_outstanding_packets(struct batman_if *batman_if)
+void purge_outstanding_packets(struct bat_priv *bat_priv,
+			       struct batman_if *batman_if)
 {
-	struct bat_priv *bat_priv;
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
 	unsigned long flags;
 
-	if (batman_if->soft_iface) {
-		bat_priv = netdev_priv(batman_if->soft_iface);
-
-		if (batman_if)
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"purge_outstanding_packets(): %s\n",
-				batman_if->dev);
-		else
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"purge_outstanding_packets()\n");
-	}
+	if (batman_if)
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"purge_outstanding_packets(): %s\n",
+			batman_if->dev);
+	else
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"purge_outstanding_packets()\n");
 
 	/* free bcast list */
-	spin_lock_irqsave(&forw_bcast_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
 	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
-				  &forw_bcast_list, list) {
+				  &bat_priv->forw_bcast_list, list) {
 
 		/**
 		 * if purge_outstanding_packets() was called with an argmument
@@ -559,21 +568,21 @@ void purge_outstanding_packets(struct batman_if *batman_if)
 		    (forw_packet->if_incoming != batman_if))
 			continue;
 
-		spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
 
 		/**
 		 * send_outstanding_bcast_packet() will lock the list to
 		 * delete the item from the list
 		 */
 		cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_irqsave(&forw_bcast_list_lock, flags);
+		spin_lock_irqsave(&bat_priv->forw_bcast_list_lock, flags);
 	}
-	spin_unlock_irqrestore(&forw_bcast_list_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->forw_bcast_list_lock, flags);
 
 	/* free batman packet list */
-	spin_lock_irqsave(&forw_bat_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
 	hlist_for_each_entry_safe(forw_packet, tmp_node, safe_tmp_node,
-				  &forw_bat_list, list) {
+				  &bat_priv->forw_bat_list, list) {
 
 		/**
 		 * if purge_outstanding_packets() was called with an argmument
@@ -583,14 +592,14 @@ void purge_outstanding_packets(struct batman_if *batman_if)
 		    (forw_packet->if_incoming != batman_if))
 			continue;
 
-		spin_unlock_irqrestore(&forw_bat_list_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
 
 		/**
 		 * send_outstanding_bat_packet() will lock the list to
 		 * delete the item from the list
 		 */
 		cancel_delayed_work_sync(&forw_packet->delayed_work);
-		spin_lock_irqsave(&forw_bat_list_lock, flags);
+		spin_lock_irqsave(&bat_priv->forw_bat_list_lock, flags);
 	}
-	spin_unlock_irqrestore(&forw_bat_list_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->forw_bat_list_lock, flags);
 }
diff --git a/batman-adv/send.h b/batman-adv/send.h
index 2c48042..c253f28 100644
--- a/batman-adv/send.h
+++ b/batman-adv/send.h
@@ -37,6 +37,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     struct batman_if *if_outgoing);
 int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb);
 void send_outstanding_bat_packet(struct work_struct *work);
-void purge_outstanding_packets(struct batman_if *batman_if);
+void purge_outstanding_packets(struct bat_priv *bat_priv,
+			       struct batman_if *batman_if);
 
 #endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 7e0b1e0..37ffa0b 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -37,12 +37,6 @@
 #include "compat.h"
 #include "fragmentation.h"
 
-static uint32_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
-				  * broadcast storms */
-static int32_t skb_packets;
-static int32_t skb_bad_packets;
-
-unsigned char main_if_addr[ETH_ALEN];
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
 static void bat_get_drvinfo(struct net_device *dev,
 			    struct ethtool_drvinfo *info);
@@ -62,18 +56,11 @@ static const struct ethtool_ops bat_ethtool_ops = {
 	.set_rx_csum = bat_set_rx_csum
 };
 
-void set_main_if_addr(uint8_t *addr)
-{
-	memcpy(main_if_addr, addr, ETH_ALEN);
-}
-
 int my_skb_push(struct sk_buff *skb, unsigned int len)
 {
 	int result = 0;
 
-	skb_packets++;
 	if (skb_headroom(skb) < len) {
-		skb_bad_packets++;
 		result = pskb_expand_head(skb, len, 0, GFP_ATOMIC);
 
 		if (result < 0)
@@ -111,7 +98,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 		return -EADDRNOTAVAIL;
 
 	/* only modify hna-table if it has been initialised before */
-	if (atomic_read(&module_state) == MODULE_ACTIVE) {
+	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
 		hna_local_remove(bat_priv, dev->dev_addr,
 				 "mac address changed");
 		hna_local_add(dev, addr->sa_data);
@@ -150,7 +137,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	int hdr_len;
 	bool bcast_dst = false, do_bcast = true;
 
-	if (atomic_read(&module_state) != MODULE_ACTIVE)
+	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dropped;
 
 	soft_iface->trans_start = jiffies;
@@ -165,6 +152,9 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 	/* ethernet packet should be broadcasted */
 	if (bcast_dst && do_bcast) {
+		if (!bat_priv->primary_if)
+			goto dropped;
+
 		if (my_skb_push(skb, sizeof(struct bcast_packet)) < 0)
 			goto dropped;
 
@@ -177,14 +167,14 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 		/* hw address of first interface is the orig mac because only
 		 * this mac is known throughout the mesh */
-		memcpy(bcast_packet->orig, main_if_addr, ETH_ALEN);
+		memcpy(bcast_packet->orig,
+		       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 
 		/* set broadcast sequence number */
-		bcast_packet->seqno = htonl(bcast_seqno);
+		bcast_packet->seqno =
+			htonl(atomic_inc_return(&bat_priv->bcast_seqno));
 
-		/* broadcast packet. on success, increase seqno. */
-		if (add_bcast_packet_to_list(bat_priv, skb) == NETDEV_TX_OK)
-			bcast_seqno++;
+		add_bcast_packet_to_list(bat_priv, skb);
 
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb. */
@@ -192,18 +182,21 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 	/* unicast packet */
 	} else {
-		spin_lock_irqsave(&orig_hash_lock, flags);
+		spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
 		/* get routing information */
 		if (bcast_dst)
-			orig_node = (struct orig_node *)gw_get_selected();
+			orig_node = (struct orig_node *)
+						gw_get_selected(bat_priv);
 		else
-			orig_node = ((struct orig_node *)hash_find(orig_hash,
-							   ethhdr->h_dest));
+			orig_node = ((struct orig_node *)hash_find(
+							bat_priv->orig_hash,
+							ethhdr->h_dest));
 
 		/* check for hna host */
 		if (!orig_node)
-			orig_node = transtable_search(ethhdr->h_dest);
+			orig_node = transtable_search(bat_priv,
+						      ethhdr->h_dest);
 
 		router = find_router(orig_node, NULL);
 
@@ -216,7 +209,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		batman_if = router->if_incoming;
 		memcpy(dstaddr, router->addr, ETH_ALEN);
 
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 		if (batman_if->if_status != IF_ACTIVE)
 			goto dropped;
@@ -288,7 +281,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	goto end;
 
 unlock:
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 dropped:
 	bat_priv->stats.tx_dropped++;
 	kfree_skb(skb);
@@ -392,7 +385,6 @@ struct net_device *softif_create(char *name)
 	}
 
 	ret = register_netdev(soft_iface);
-
 	if (ret < 0) {
 		pr_err("Unable to register the batman interface '%s': %i\n",
 		       name, ret);
@@ -412,21 +404,29 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
 	atomic_set(&bat_priv->batman_queue_left, BATMAN_QUEUE_LEN);
 
+	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
+	atomic_set(&bat_priv->bcast_seqno, 1);
+	atomic_set(&bat_priv->hna_local_changed, 0);
+
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
 	ret = sysfs_add_meshif(soft_iface);
-
 	if (ret < 0)
 		goto unreg_soft_iface;
 
 	ret = debugfs_add_meshif(soft_iface);
-
 	if (ret < 0)
 		goto unreg_sysfs;
 
+	ret = mesh_init(soft_iface);
+	if (ret < 0)
+		goto unreg_debugfs;
+
 	return soft_iface;
 
+unreg_debugfs:
+	debugfs_del_meshif(soft_iface);
 unreg_sysfs:
 	sysfs_del_meshif(soft_iface);
 unreg_soft_iface:
@@ -443,6 +443,7 @@ void softif_destroy(struct net_device *soft_iface)
 {
 	debugfs_del_meshif(soft_iface);
 	sysfs_del_meshif(soft_iface);
+	mesh_free(soft_iface);
 	unregister_netdev(soft_iface);
 }
 
diff --git a/batman-adv/soft-interface.h b/batman-adv/soft-interface.h
index dd5cf4d..2429f66 100644
--- a/batman-adv/soft-interface.h
+++ b/batman-adv/soft-interface.h
@@ -22,7 +22,6 @@
 #ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 #define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 
-void set_main_if_addr(uint8_t *addr);
 int interface_tx(struct sk_buff *skb, struct net_device *soft_iface);
 void interface_rx(struct net_device *soft_iface,
 		  struct sk_buff *skb, int hdr_size);
@@ -30,6 +29,4 @@ int my_skb_push(struct sk_buff *skb, unsigned int len);
 struct net_device *softif_create(char *name);
 void softif_destroy(struct net_device *soft_iface);
 
-extern unsigned char main_if_addr[];
-
 #endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index d1e0d10..9cae140 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -26,36 +26,29 @@
 #include "hash.h"
 #include "compat.h"
 
-struct hashtable_t *hna_local_hash;
-static struct hashtable_t *hna_global_hash;
-atomic_t hna_local_changed;
-
-DEFINE_SPINLOCK(hna_local_hash_lock);
-static DEFINE_SPINLOCK(hna_global_hash_lock);
-
 static void hna_local_purge(struct work_struct *work);
-static DECLARE_DELAYED_WORK(hna_local_purge_wq, hna_local_purge);
 static void _hna_global_del_orig(struct bat_priv *bat_priv,
 				 struct hna_global_entry *hna_global_entry,
 				 char *message);
 
-static void hna_local_start_timer(void)
+static void hna_local_start_timer(struct bat_priv *bat_priv)
 {
-	queue_delayed_work(bat_event_workqueue, &hna_local_purge_wq, 10 * HZ);
+	INIT_DELAYED_WORK(&bat_priv->hna_work, hna_local_purge);
+	queue_delayed_work(bat_event_workqueue, &bat_priv->hna_work, 10 * HZ);
 }
 
-int hna_local_init(void)
+int hna_local_init(struct bat_priv *bat_priv)
 {
-	if (hna_local_hash)
+	if (bat_priv->hna_local_hash)
 		return 1;
 
-	hna_local_hash = hash_new(128, compare_orig, choose_orig);
+	bat_priv->hna_local_hash = hash_new(128, compare_orig, choose_orig);
 
-	if (!hna_local_hash)
+	if (!bat_priv->hna_local_hash)
 		return 0;
 
-	atomic_set(&hna_local_changed, 0);
-	hna_local_start_timer();
+	atomic_set(&bat_priv->hna_local_changed, 0);
+	hna_local_start_timer(bat_priv);
 
 	return 1;
 }
@@ -68,12 +61,13 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	struct hashtable_t *swaphash;
 	unsigned long flags;
 
-	spin_lock_irqsave(&hna_local_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 	hna_local_entry =
-		((struct hna_local_entry *)hash_find(hna_local_hash, addr));
-	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+		((struct hna_local_entry *)hash_find(bat_priv->hna_local_hash,
+						     addr));
+	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 
-	if (hna_local_entry != NULL) {
+	if (hna_local_entry) {
 		hna_local_entry->last_seen = jiffies;
 		return;
 	}
@@ -81,8 +75,9 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	/* only announce as many hosts as possible in the batman-packet and
 	   space in batman_packet->num_hna That also should give a limit to
 	   MAC-flooding. */
-	if ((num_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN) / ETH_ALEN) ||
-	    (num_hna + 1 > 255)) {
+	if ((bat_priv->num_local_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN)
+								/ ETH_ALEN) ||
+	    (bat_priv->num_local_hna + 1 > 255)) {
 		bat_dbg(DBG_ROUTES, bat_priv,
 			"Can't add new local hna entry (%pM): "
 			"number of local hna entries exceeds packet size\n",
@@ -106,47 +101,49 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	else
 		hna_local_entry->never_purge = 0;
 
-	spin_lock_irqsave(&hna_local_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
-	hash_add(hna_local_hash, hna_local_entry);
-	num_hna++;
-	atomic_set(&hna_local_changed, 1);
+	hash_add(bat_priv->hna_local_hash, hna_local_entry);
+	bat_priv->num_local_hna++;
+	atomic_set(&bat_priv->hna_local_changed, 1);
 
-	if (hna_local_hash->elements * 4 > hna_local_hash->size) {
-		swaphash = hash_resize(hna_local_hash,
-				       hna_local_hash->size * 2);
+	if (bat_priv->hna_local_hash->elements * 4 >
+					bat_priv->hna_local_hash->size) {
+		swaphash = hash_resize(bat_priv->hna_local_hash,
+				       bat_priv->hna_local_hash->size * 2);
 
-		if (swaphash == NULL)
+		if (!swaphash)
 			pr_err("Couldn't resize local hna hash table\n");
 		else
-			hna_local_hash = swaphash;
+			bat_priv->hna_local_hash = swaphash;
 	}
 
-	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 
 	/* remove address from global hash if present */
-	spin_lock_irqsave(&hna_global_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 
-	hna_global_entry =
-		((struct hna_global_entry *)hash_find(hna_global_hash, addr));
+	hna_global_entry = ((struct hna_global_entry *)
+				hash_find(bat_priv->hna_global_hash, addr));
 
-	if (hna_global_entry != NULL)
+	if (hna_global_entry)
 		_hna_global_del_orig(bat_priv, hna_global_entry,
 				     "local hna received");
 
-	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 }
 
-int hna_local_fill_buffer(unsigned char *buff, int buff_len)
+int hna_local_fill_buffer(struct bat_priv *bat_priv,
+			  unsigned char *buff, int buff_len)
 {
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
 	int i = 0;
 	unsigned long flags;
 
-	spin_lock_irqsave(&hna_local_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
-	while (hash_iterate(hna_local_hash, &hashit)) {
+	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
 
 		if (buff_len < (i + 1) * ETH_ALEN)
 			break;
@@ -158,11 +155,10 @@ int hna_local_fill_buffer(unsigned char *buff, int buff_len)
 	}
 
 	/* if we did not get all new local hnas see you next time  ;-) */
-	if (i == num_hna)
-		atomic_set(&hna_local_changed, 0);
-
-	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+	if (i == bat_priv->num_local_hna)
+		atomic_set(&bat_priv->hna_local_changed, 0);
 
+	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 	return i;
 }
 
@@ -187,29 +183,29 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 		   "announced via HNA:\n",
 		   net_dev->name);
 
-	spin_lock_irqsave(&hna_local_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx\n" */
-	while (hash_iterate(hna_local_hash, &hashit_count))
+	while (hash_iterate(bat_priv->hna_local_hash, &hashit_count))
 		buf_size += 21;
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 		return -ENOMEM;
 	}
 	buff[0] = '\0';
 	pos = 0;
 
-	while (hash_iterate(hna_local_hash, &hashit)) {
+	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
 		hna_local_entry = hashit.bucket->data;
 
 		pos += snprintf(buff + pos, 22, " * %pM\n",
 				hna_local_entry->addr);
 	}
 
-	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
@@ -218,9 +214,11 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 
 static void _hna_local_del(void *data, void *arg)
 {
+	struct bat_priv *bat_priv = (struct bat_priv *)arg;
+
 	kfree(data);
-	num_hna--;
-	atomic_set(&hna_local_changed, 1);
+	bat_priv->num_local_hna--;
+	atomic_set(&bat_priv->hna_local_changed, 1);
 }
 
 static void hna_local_del(struct bat_priv *bat_priv,
@@ -230,7 +228,7 @@ static void hna_local_del(struct bat_priv *bat_priv,
 	bat_dbg(DBG_ROUTES, bat_priv, "Deleting local hna entry (%pM): %s\n",
 		hna_local_entry->addr, message);
 
-	hash_remove(hna_local_hash, hna_local_entry->addr);
+	hash_remove(bat_priv->hna_local_hash, hna_local_entry->addr);
 	_hna_local_del(hna_local_entry, bat_priv);
 }
 
@@ -240,57 +238,62 @@ void hna_local_remove(struct bat_priv *bat_priv,
 	struct hna_local_entry *hna_local_entry;
 	unsigned long flags;
 
-	spin_lock_irqsave(&hna_local_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
 	hna_local_entry = (struct hna_local_entry *)
-		hash_find(hna_local_hash, addr);
+		hash_find(bat_priv->hna_local_hash, addr);
 	if (hna_local_entry)
 		hna_local_del(bat_priv, hna_local_entry, message);
 
-	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 }
 
 static void hna_local_purge(struct work_struct *work)
 {
+	struct delayed_work *delayed_work =
+		container_of(work, struct delayed_work, work);
+	struct bat_priv *bat_priv =
+		container_of(delayed_work, struct bat_priv, hna_work);
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
 	unsigned long flags;
 	unsigned long timeout;
 
-	spin_lock_irqsave(&hna_local_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
-	while (hash_iterate(hna_local_hash, &hashit)) {
+	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
 		hna_local_entry = hashit.bucket->data;
 
 		timeout = hna_local_entry->last_seen + LOCAL_HNA_TIMEOUT * HZ;
-		/* if ((!hna_local_entry->never_purge) &&
+
+		if ((!hna_local_entry->never_purge) &&
 		    time_after(jiffies, timeout))
 			hna_local_del(bat_priv, hna_local_entry,
-				      "address timed out");*/
+				      "address timed out");
 	}
 
-	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
-	hna_local_start_timer();
+	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
+	hna_local_start_timer(bat_priv);
 }
 
-void hna_local_free(void)
+void hna_local_free(struct bat_priv *bat_priv)
 {
-	if (!hna_local_hash)
+	if (!bat_priv->hna_local_hash)
 		return;
 
-	cancel_delayed_work_sync(&hna_local_purge_wq);
-	hash_delete(hna_local_hash, _hna_local_del, NULL);
-	hna_local_hash = NULL;
+	cancel_delayed_work_sync(&bat_priv->hna_work);
+	hash_delete(bat_priv->hna_local_hash, _hna_local_del, bat_priv);
+	bat_priv->hna_local_hash = NULL;
 }
 
-int hna_global_init(void)
+int hna_global_init(struct bat_priv *bat_priv)
 {
-	if (hna_global_hash)
+	if (bat_priv->hna_global_hash)
 		return 1;
 
-	hna_global_hash = hash_new(128, compare_orig, choose_orig);
+	bat_priv->hna_global_hash = hash_new(128, compare_orig, choose_orig);
 
-	if (!hna_global_hash)
+	if (!bat_priv->hna_global_hash)
 		return 0;
 
 	return 1;
@@ -308,14 +311,15 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 	unsigned char *hna_ptr;
 
 	while ((hna_buff_count + 1) * ETH_ALEN <= hna_buff_len) {
-		spin_lock_irqsave(&hna_global_hash_lock, flags);
+		spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_global_entry = (struct hna_global_entry *)
-			hash_find(hna_global_hash, hna_ptr);
+			hash_find(bat_priv->hna_global_hash, hna_ptr);
 
-		if (hna_global_entry == NULL) {
-			spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+		if (!hna_global_entry) {
+			spin_unlock_irqrestore(&bat_priv->hna_ghash_lock,
+					       flags);
 
 			hna_global_entry =
 				kmalloc(sizeof(struct hna_global_entry),
@@ -331,26 +335,26 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 				"%pM (via %pM)\n",
 				hna_global_entry->addr, orig_node->orig);
 
-			spin_lock_irqsave(&hna_global_hash_lock, flags);
-			hash_add(hna_global_hash, hna_global_entry);
+			spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
+			hash_add(bat_priv->hna_global_hash, hna_global_entry);
 
 		}
 
 		hna_global_entry->orig_node = orig_node;
-		spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 
 		/* remove address from local hash if present */
-		spin_lock_irqsave(&hna_local_hash_lock, flags);
+		spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_local_entry = (struct hna_local_entry *)
-			hash_find(hna_local_hash, hna_ptr);
+			hash_find(bat_priv->hna_local_hash, hna_ptr);
 
-		if (hna_local_entry != NULL)
+		if (hna_local_entry)
 			hna_local_del(bat_priv, hna_local_entry,
 				      "global hna received");
 
-		spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 
 		hna_buff_count++;
 	}
@@ -367,19 +371,20 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 		}
 	}
 
-	spin_lock_irqsave(&hna_global_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 
-	if (hna_global_hash->elements * 4 > hna_global_hash->size) {
-		swaphash = hash_resize(hna_global_hash,
-				       hna_global_hash->size * 2);
+	if (bat_priv->hna_global_hash->elements * 4 >
+					bat_priv->hna_global_hash->size) {
+		swaphash = hash_resize(bat_priv->hna_global_hash,
+				       bat_priv->hna_global_hash->size * 2);
 
-		if (swaphash == NULL)
+		if (!swaphash)
 			pr_err("Couldn't resize global hna hash table\n");
 		else
-			hna_global_hash = swaphash;
+			bat_priv->hna_global_hash = swaphash;
 	}
 
-	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 }
 
 int hna_global_seq_print_text(struct seq_file *seq, void *offset)
@@ -402,22 +407,22 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 	seq_printf(seq, "Globally announced HNAs received via the mesh %s\n",
 		   net_dev->name);
 
-	spin_lock_irqsave(&hna_global_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx via xx:xx:xx:xx:xx:xx\n"*/
-	while (hash_iterate(hna_global_hash, &hashit_count))
+	while (hash_iterate(bat_priv->hna_global_hash, &hashit_count))
 		buf_size += 43;
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 		return -ENOMEM;
 	}
 	buff[0] = '\0';
 	pos = 0;
 
-	while (hash_iterate(hna_global_hash, &hashit)) {
+	while (hash_iterate(bat_priv->hna_global_hash, &hashit)) {
 		hna_global_entry = hashit.bucket->data;
 
 		pos += snprintf(buff + pos, 44,
@@ -425,7 +430,7 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 				hna_global_entry->orig_node->orig);
 	}
 
-	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
@@ -441,7 +446,7 @@ static void _hna_global_del_orig(struct bat_priv *bat_priv,
 		hna_global_entry->addr, hna_global_entry->orig_node->orig,
 		message);
 
-	hash_remove(hna_global_hash, hna_global_entry->addr);
+	hash_remove(bat_priv->hna_global_hash, hna_global_entry->addr);
 	kfree(hna_global_entry);
 }
 
@@ -456,14 +461,14 @@ void hna_global_del_orig(struct bat_priv *bat_priv,
 	if (orig_node->hna_buff_len == 0)
 		return;
 
-	spin_lock_irqsave(&hna_global_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 
 	while ((hna_buff_count + 1) * ETH_ALEN <= orig_node->hna_buff_len) {
 		hna_ptr = orig_node->hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_global_entry = (struct hna_global_entry *)
-			hash_find(hna_global_hash, hna_ptr);
+			hash_find(bat_priv->hna_global_hash, hna_ptr);
 
-		if ((hna_global_entry != NULL) &&
+		if ((hna_global_entry) &&
 		    (hna_global_entry->orig_node == orig_node))
 			_hna_global_del_orig(bat_priv, hna_global_entry,
 					     message);
@@ -471,7 +476,7 @@ void hna_global_del_orig(struct bat_priv *bat_priv,
 		hna_buff_count++;
 	}
 
-	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 
 	orig_node->hna_buff_len = 0;
 	kfree(orig_node->hna_buff);
@@ -483,26 +488,26 @@ static void hna_global_del(void *data, void *arg)
 	kfree(data);
 }
 
-void hna_global_free(void)
+void hna_global_free(struct bat_priv *bat_priv)
 {
-	if (!hna_global_hash)
+	if (!bat_priv->hna_global_hash)
 		return;
 
-	hash_delete(hna_global_hash, hna_global_del, NULL);
-	hna_global_hash = NULL;
+	hash_delete(bat_priv->hna_global_hash, hna_global_del, NULL);
+	bat_priv->hna_global_hash = NULL;
 }
 
-struct orig_node *transtable_search(uint8_t *addr)
+struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
 {
 	struct hna_global_entry *hna_global_entry;
 	unsigned long flags;
 
-	spin_lock_irqsave(&hna_global_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 	hna_global_entry = (struct hna_global_entry *)
-		hash_find(hna_global_hash, addr);
-	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+				hash_find(bat_priv->hna_global_hash, addr);
+	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 
-	if (hna_global_entry == NULL)
+	if (!hna_global_entry)
 		return NULL;
 
 	return hna_global_entry->orig_node;
diff --git a/batman-adv/translation-table.h b/batman-adv/translation-table.h
index af7a59c..10c4c5c 100644
--- a/batman-adv/translation-table.h
+++ b/batman-adv/translation-table.h
@@ -24,25 +24,22 @@
 
 #include "types.h"
 
-int hna_local_init(void);
+int hna_local_init(struct bat_priv *bat_priv);
 void hna_local_add(struct net_device *soft_iface, uint8_t *addr);
 void hna_local_remove(struct bat_priv *bat_priv,
 		      uint8_t *addr, char *message);
-int hna_local_fill_buffer(unsigned char *buff, int buff_len);
+int hna_local_fill_buffer(struct bat_priv *bat_priv,
+			  unsigned char *buff, int buff_len);
 int hna_local_seq_print_text(struct seq_file *seq, void *offset);
-void hna_local_free(void);
-int hna_global_init(void);
+void hna_local_free(struct bat_priv *bat_priv);
+int hna_global_init(struct bat_priv *bat_priv);
 void hna_global_add_orig(struct bat_priv *bat_priv,
 			 struct orig_node *orig_node,
 			 unsigned char *hna_buff, int hna_buff_len);
 int hna_global_seq_print_text(struct seq_file *seq, void *offset);
 void hna_global_del_orig(struct bat_priv *bat_priv,
 			 struct orig_node *orig_node, char *message);
-void hna_global_free(void);
-struct orig_node *transtable_search(uint8_t *addr);
-
-extern spinlock_t hna_local_hash_lock;
-extern struct hashtable_t *hna_local_hash;
-extern atomic_t hna_local_changed;
+void hna_global_free(struct bat_priv *bat_priv);
+struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 20cb0f7..56c6b52 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -50,19 +50,19 @@ struct batman_if {
 };
 
 /**
-  *	orig_node - structure for orig_list maintaining nodes of mesh
-  *	@primary_addr: hosts primary interface address
-  *	@last_valid: when last packet from this node was received
-  *	@bcast_seqno_reset: time when the broadcast seqno window was reset
-  *	@batman_seqno_reset: time when the batman seqno window was reset
-  *	@gw_flags: flags related to gateway class
-  *	@flags: for now only VIS_SERVER flag
-  *	@last_real_seqno: last and best known squence number
-  *	@last_ttl: ttl of last received packet
-  *	@last_bcast_seqno: last broadcast sequence number received by this host
-  *
-  *	@candidates: how many candidates are available
-  *	@selected: next bonding candidate
+ *	orig_node - structure for orig_list maintaining nodes of mesh
+ *	@primary_addr: hosts primary interface address
+ *	@last_valid: when last packet from this node was received
+ *	@bcast_seqno_reset: time when the broadcast seqno window was reset
+ *	@batman_seqno_reset: time when the batman seqno window was reset
+ *	@gw_flags: flags related to gateway class
+ *	@flags: for now only VIS_SERVER flag
+ *	@last_real_seqno: last and best known squence number
+ *	@last_ttl: ttl of last received packet
+ *	@last_bcast_seqno: last broadcast sequence number received by this host
+ *
+ *	@candidates: how many candidates are available
+ *	@selected: next bonding candidate
  */
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
@@ -93,15 +93,15 @@ struct orig_node {
 };
 
 struct gw_node {
-	struct list_head list;
+	struct hlist_node list;
 	struct orig_node *orig_node;
 	unsigned long deleted;
 	struct rcu_head rcu;
 };
 
 /**
-  *	neigh_node
-  *	@last_valid: when last packet via this neighbor was received
+ *	neigh_node
+ *	@last_valid: when last packet via this neighbor was received
  */
 struct neigh_node {
 	struct list_head list;
@@ -119,6 +119,7 @@ struct neigh_node {
 };
 
 struct bat_priv {
+	atomic_t mesh_state;
 	struct net_device_stats stats;
 	atomic_t aggregation_enabled;
 	atomic_t bonding_enabled;
@@ -128,6 +129,7 @@ struct bat_priv {
 	atomic_t gw_class;
 	atomic_t orig_interval;
 	atomic_t log_level;
+	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
 	atomic_t batman_queue_left;
 	char num_ifaces;
@@ -135,6 +137,29 @@ struct bat_priv {
 	struct batman_if *primary_if;
 	struct kobject *mesh_obj;
 	struct dentry *debug_dir;
+	struct hlist_head forw_bat_list;
+	struct hlist_head forw_bcast_list;
+	struct hlist_head gw_list;
+	struct list_head vis_send_list;
+	struct hashtable_t *orig_hash;
+	struct hashtable_t *hna_local_hash;
+	struct hashtable_t *hna_global_hash;
+	struct hashtable_t *vis_hash;
+	spinlock_t orig_hash_lock;
+	spinlock_t forw_bat_list_lock;
+	spinlock_t forw_bcast_list_lock;
+	spinlock_t hna_lhash_lock;
+	spinlock_t hna_ghash_lock;
+	spinlock_t gw_list_lock;
+	spinlock_t vis_hash_lock;
+	spinlock_t vis_list_lock;
+	int16_t num_local_hna;
+	atomic_t hna_local_changed;
+	struct delayed_work hna_work;
+	struct delayed_work orig_work;
+	struct delayed_work vis_work;
+	struct gw_node *curr_gw;
+	struct vis_info *my_vis_info;
 };
 
 struct socket_client {
@@ -164,8 +189,8 @@ struct hna_global_entry {
 };
 
 /**
-  *	forw_packet - structure for forw_list maintaining packets to be
-  *	              send/forwarded
+ *	forw_packet - structure for forw_list maintaining packets to be
+ *	              send/forwarded
  */
 struct forw_packet {
 	struct hlist_node list;
@@ -204,4 +229,28 @@ struct frag_packet_list_entry {
 	struct sk_buff *skb;
 };
 
+struct vis_info {
+	unsigned long       first_seen;
+	struct list_head    recv_list;
+			    /* list of server-neighbors we received a vis-packet
+			     * from.  we should not reply to them. */
+	struct list_head send_list;
+	struct kref refcount;
+	struct bat_priv *bat_priv;
+	/* this packet might be part of the vis send queue. */
+	struct vis_packet packet;
+	/* vis_info may follow here*/
+} __attribute__((packed));
+
+struct vis_info_entry {
+	uint8_t  src[ETH_ALEN];
+	uint8_t  dest[ETH_ALEN];
+	uint8_t  quality;	/* quality = 0 means HNA */
+} __attribute__((packed));
+
+struct recvlist_node {
+	struct list_head list;
+	uint8_t mac[ETH_ALEN];
+};
+
 #endif /* _NET_BATMAN_ADV_TYPES_H_ */
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 5766148..8f03b5b 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -44,28 +44,23 @@
 			_dummy > smallest_signed_int(_dummy); })
 #define seq_after(x, y) seq_before(y, x)
 
-static struct hashtable_t *vis_hash;
-static DEFINE_SPINLOCK(vis_hash_lock);
-static DEFINE_SPINLOCK(recv_list_lock);
-static struct vis_info *my_vis_info;
-static struct list_head send_list;	/* always locked with vis_hash_lock */
-
-static void start_vis_timer(void);
+static void start_vis_timer(struct bat_priv *bat_priv);
 
 /* free the info */
 static void free_info(struct kref *ref)
 {
 	struct vis_info *info = container_of(ref, struct vis_info, refcount);
+	struct bat_priv *bat_priv = info->bat_priv;
 	struct recvlist_node *entry, *tmp;
 	unsigned long flags;
 
 	list_del_init(&info->send_list);
-	spin_lock_irqsave(&recv_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->vis_list_lock, flags);
 	list_for_each_entry_safe(entry, tmp, &info->recv_list, list) {
 		list_del(&entry->list);
 		kfree(entry);
 	}
-	spin_unlock_irqrestore(&recv_list_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->vis_list_lock, flags);
 	kfree(info);
 }
 
@@ -199,8 +194,8 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 
 	buf_size = 1;
 	/* Estimate length */
-	spin_lock_irqsave(&vis_hash_lock, flags);
-	while (hash_iterate(vis_hash, &hashit_count)) {
+	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	while (hash_iterate(bat_priv->vis_hash, &hashit_count)) {
 		info = hashit_count.bucket->data;
 		entries = (struct vis_info_entry *)
 			((char *)info + sizeof(struct vis_info));
@@ -232,13 +227,13 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
-		spin_unlock_irqrestore(&vis_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
 		return -ENOMEM;
 	}
 	buff[0] = '\0';
 	buff_pos = 0;
 
-	while (hash_iterate(vis_hash, &hashit)) {
+	while (hash_iterate(bat_priv->vis_hash, &hashit)) {
 		info = hashit.bucket->data;
 		entries = (struct vis_info_entry *)
 			((char *)info + sizeof(struct vis_info));
@@ -277,7 +272,7 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 		}
 	}
 
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
 
 	seq_printf(seq, "%s", buff);
 	kfree(buff);
@@ -287,11 +282,11 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 
 /* add the info packet to the send list, if it was not
  * already linked in. */
-static void send_list_add(struct vis_info *info)
+static void send_list_add(struct bat_priv *bat_priv, struct vis_info *info)
 {
 	if (list_empty(&info->send_list)) {
 		kref_get(&info->refcount);
-		list_add_tail(&info->send_list, &send_list);
+		list_add_tail(&info->send_list, &bat_priv->vis_send_list);
 	}
 }
 
@@ -306,7 +301,8 @@ static void send_list_del(struct vis_info *info)
 }
 
 /* tries to add one entry to the receive list. */
-static void recv_list_add(struct list_head *recv_list, char *mac)
+static void recv_list_add(struct bat_priv *bat_priv,
+			  struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
 	unsigned long flags;
@@ -316,32 +312,35 @@ static void recv_list_add(struct list_head *recv_list, char *mac)
 		return;
 
 	memcpy(entry->mac, mac, ETH_ALEN);
-	spin_lock_irqsave(&recv_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->vis_list_lock, flags);
 	list_add_tail(&entry->list, recv_list);
-	spin_unlock_irqrestore(&recv_list_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->vis_list_lock, flags);
 }
 
 /* returns 1 if this mac is in the recv_list */
-static int recv_list_is_in(struct list_head *recv_list, char *mac)
+static int recv_list_is_in(struct bat_priv *bat_priv,
+			   struct list_head *recv_list, char *mac)
 {
 	struct recvlist_node *entry;
 	unsigned long flags;
 
-	spin_lock_irqsave(&recv_list_lock, flags);
+	spin_lock_irqsave(&bat_priv->vis_list_lock, flags);
 	list_for_each_entry(entry, recv_list, list) {
 		if (memcmp(entry->mac, mac, ETH_ALEN) == 0) {
-			spin_unlock_irqrestore(&recv_list_lock, flags);
+			spin_unlock_irqrestore(&bat_priv->vis_list_lock,
+					       flags);
 			return 1;
 		}
 	}
-	spin_unlock_irqrestore(&recv_list_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->vis_list_lock, flags);
 	return 0;
 }
 
 /* try to add the packet to the vis_hash. return NULL if invalid (e.g. too old,
  * broken.. ).	vis hash must be locked outside.  is_new is set when the packet
  * is newer than old entries in the hash. */
-static struct vis_info *add_packet(struct vis_packet *vis_packet,
+static struct vis_info *add_packet(struct bat_priv *bat_priv,
+				   struct vis_packet *vis_packet,
 				   int vis_info_len, int *is_new,
 				   int make_broadcast)
 {
@@ -350,18 +349,18 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 
 	*is_new = 0;
 	/* sanity check */
-	if (vis_hash == NULL)
+	if (!bat_priv->vis_hash)
 		return NULL;
 
 	/* see if the packet is already in vis_hash */
 	memcpy(search_elem.packet.vis_orig, vis_packet->vis_orig, ETH_ALEN);
-	old_info = hash_find(vis_hash, &search_elem);
+	old_info = hash_find(bat_priv->vis_hash, &search_elem);
 
 	if (old_info != NULL) {
 		if (!seq_after(ntohl(vis_packet->seqno),
 				ntohl(old_info->packet.seqno))) {
 			if (old_info->packet.seqno == vis_packet->seqno) {
-				recv_list_add(&old_info->recv_list,
+				recv_list_add(bat_priv, &old_info->recv_list,
 					      vis_packet->sender_orig);
 				return old_info;
 			} else {
@@ -370,19 +369,20 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 			}
 		}
 		/* remove old entry */
-		hash_remove(vis_hash, old_info);
+		hash_remove(bat_priv->vis_hash, old_info);
 		send_list_del(old_info);
 		kref_put(&old_info->refcount, free_info);
 	}
 
 	info = kmalloc(sizeof(struct vis_info) + vis_info_len, GFP_ATOMIC);
-	if (info == NULL)
+	if (!info)
 		return NULL;
 
 	kref_init(&info->refcount);
 	INIT_LIST_HEAD(&info->send_list);
 	INIT_LIST_HEAD(&info->recv_list);
 	info->first_seen = jiffies;
+	info->bat_priv = bat_priv;
 	memcpy(&info->packet, vis_packet,
 	       sizeof(struct vis_packet) + vis_info_len);
 
@@ -398,10 +398,10 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 		info->packet.entries = vis_info_len /
 			sizeof(struct vis_info_entry);
 
-	recv_list_add(&info->recv_list, info->packet.sender_orig);
+	recv_list_add(bat_priv, &info->recv_list, info->packet.sender_orig);
 
 	/* try to add it */
-	if (hash_add(vis_hash, info) < 0) {
+	if (hash_add(bat_priv->vis_hash, info) < 0) {
 		/* did not work (for some reason) */
 		kref_put(&old_info->refcount, free_info);
 		info = NULL;
@@ -422,17 +422,18 @@ void receive_server_sync_packet(struct bat_priv *bat_priv,
 
 	make_broadcast = (vis_server == VIS_TYPE_SERVER_SYNC);
 
-	spin_lock_irqsave(&vis_hash_lock, flags);
-	info = add_packet(vis_packet, vis_info_len, &is_new, make_broadcast);
-	if (info == NULL)
+	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	info = add_packet(bat_priv, vis_packet, vis_info_len,
+			  &is_new, make_broadcast);
+	if (!info)
 		goto end;
 
 	/* only if we are server ourselves and packet is newer than the one in
 	 * hash.*/
 	if (vis_server == VIS_TYPE_SERVER_SYNC && is_new)
-		send_list_add(info);
+		send_list_add(bat_priv, info);
 end:
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
 }
 
 /* handle an incoming client update packet and schedule forward if needed. */
@@ -455,9 +456,10 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 	    is_my_mac(vis_packet->target_orig))
 		are_target = 1;
 
-	spin_lock_irqsave(&vis_hash_lock, flags);
-	info = add_packet(vis_packet, vis_info_len, &is_new, are_target);
-	if (info == NULL)
+	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	info = add_packet(bat_priv, vis_packet, vis_info_len,
+			  &is_new, are_target);
+	if (!info)
 		goto end;
 	/* note that outdated packets will be dropped at this point. */
 
@@ -465,30 +467,30 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 	/* send only if we're the target server or ... */
 	if (are_target && is_new) {
 		info->packet.vis_type = VIS_TYPE_SERVER_SYNC;	/* upgrade! */
-		send_list_add(info);
+		send_list_add(bat_priv, info);
 
 		/* ... we're not the recipient (and thus need to forward). */
 	} else if (!is_my_mac(info->packet.target_orig)) {
-		send_list_add(info);
+		send_list_add(bat_priv, info);
 	}
 end:
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
 }
 
 /* Walk the originators and find the VIS server with the best tq. Set the packet
  * address to its address and return the best_tq.
  *
  * Must be called with the originator hash locked */
-static int find_best_vis_server(struct vis_info *info)
+static int find_best_vis_server(struct bat_priv *bat_priv,
+				struct vis_info *info)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
 	int best_tq = -1;
 
-	while (hash_iterate(orig_hash, &hashit)) {
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
-		if ((orig_node != NULL) &&
-		    (orig_node->router != NULL) &&
+		if ((orig_node) && (orig_node->router) &&
 		    (orig_node->flags & VIS_SERVER) &&
 		    (orig_node->router->tq_avg > best_tq)) {
 			best_tq = orig_node->router->tq_avg;
@@ -515,7 +517,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	HASHIT(hashit_local);
 	HASHIT(hashit_global);
 	struct orig_node *orig_node;
-	struct vis_info *info = (struct vis_info *)my_vis_info;
+	struct vis_info *info = (struct vis_info *)bat_priv->my_vis_info;
 	struct vis_info_entry *entry, *entry_array;
 	struct hna_local_entry *hna_local_entry;
 	int best_tq = -1;
@@ -524,26 +526,27 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	info->first_seen = jiffies;
 	info->packet.vis_type = atomic_read(&bat_priv->vis_mode);
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
 	info->packet.ttl = TTL;
 	info->packet.seqno = htonl(ntohl(info->packet.seqno) + 1);
 	info->packet.entries = 0;
 
 	if (info->packet.vis_type == VIS_TYPE_CLIENT_UPDATE) {
-		best_tq = find_best_vis_server(info);
+		best_tq = find_best_vis_server(bat_priv, info);
 		if (best_tq < 0) {
-			spin_unlock_irqrestore(&orig_hash_lock, flags);
+			spin_unlock_irqrestore(&bat_priv->orig_hash_lock,
+					       flags);
 			return -1;
 		}
 	}
 
 	entry_array = (struct vis_info_entry *)
-		((char *)info + sizeof(struct vis_info));
+				((char *)info + sizeof(struct vis_info));
 
-	while (hash_iterate(orig_hash, &hashit_global)) {
+	while (hash_iterate(bat_priv->orig_hash, &hashit_global)) {
 		orig_node = hashit_global.bucket->data;
-		if (orig_node->router != NULL
+		if (orig_node->router
 			&& compare_orig(orig_node->router->addr,
 					orig_node->orig)
 			&& (orig_node->router->if_incoming->if_status ==
@@ -560,16 +563,17 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 			info->packet.entries++;
 
 			if (vis_packet_full(info)) {
-				spin_unlock_irqrestore(&orig_hash_lock, flags);
+				spin_unlock_irqrestore(
+					&bat_priv->orig_hash_lock, flags);
 				return 0;
 			}
 		}
 	}
 
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
-	spin_lock_irqsave(&hna_local_hash_lock, flags);
-	while (hash_iterate(hna_local_hash, &hashit_local)) {
+	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
+	while (hash_iterate(bat_priv->hna_local_hash, &hashit_local)) {
 		hna_local_entry = hashit_local.bucket->data;
 		entry = &entry_array[info->packet.entries];
 		memset(entry->src, 0, ETH_ALEN);
@@ -578,35 +582,40 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		info->packet.entries++;
 
 		if (vis_packet_full(info)) {
-			spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+			spin_unlock_irqrestore(&bat_priv->hna_lhash_lock,
+					       flags);
 			return 0;
 		}
 	}
-	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 	return 0;
 }
 
 /* free old vis packets. Must be called with this vis_hash_lock
  * held */
-static void purge_vis_packets(void)
+static void purge_vis_packets(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit);
 	struct vis_info *info;
 
-	while (hash_iterate(vis_hash, &hashit)) {
+	while (hash_iterate(bat_priv->vis_hash, &hashit)) {
 		info = hashit.bucket->data;
-		if (info == my_vis_info)	/* never purge own data. */
+
+		/* never purge own data. */
+		if (info == bat_priv->my_vis_info)
 			continue;
+
 		if (time_after(jiffies,
 			       info->first_seen + VIS_TIMEOUT * HZ)) {
-			hash_remove_bucket(vis_hash, &hashit);
+			hash_remove_bucket(bat_priv->vis_hash, &hashit);
 			send_list_del(info);
 			kref_put(&info->refcount, free_info);
 		}
 	}
 }
 
-static void broadcast_vis_packet(struct vis_info *info, int packet_length)
+static void broadcast_vis_packet(struct bat_priv *bat_priv,
+				 struct vis_info *info, int packet_length)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
@@ -614,10 +623,10 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
 	/* send to all routers in range. */
-	while (hash_iterate(orig_hash, &hashit)) {
+	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
 
 		/* if it's a vis server and reachable, send it. */
@@ -627,34 +636,36 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 			continue;
 		/* don't send it if we already received the packet from
 		 * this node. */
-		if (recv_list_is_in(&info->recv_list, orig_node->orig))
+		if (recv_list_is_in(bat_priv, &info->recv_list,
+							orig_node->orig))
 			continue;
 
 		memcpy(info->packet.target_orig, orig_node->orig, ETH_ALEN);
 		batman_if = orig_node->router->if_incoming;
 		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 		send_raw_packet((unsigned char *)&info->packet,
 				packet_length, batman_if, dstaddr);
 
-		spin_lock_irqsave(&orig_hash_lock, flags);
+		spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 
 	}
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
 }
 
-static void unicast_vis_packet(struct vis_info *info, int packet_length)
+static void unicast_vis_packet(struct bat_priv *bat_priv,
+			       struct vis_info *info, int packet_length)
 {
 	struct orig_node *orig_node;
 	unsigned long flags;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
 
-	spin_lock_irqsave(&orig_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(orig_hash, info->packet.target_orig));
+		     hash_find(bat_priv->orig_hash, info->packet.target_orig));
 
 	if ((!orig_node) || (!orig_node->router))
 		goto out;
@@ -663,18 +674,18 @@ static void unicast_vis_packet(struct vis_info *info, int packet_length)
 	 * copy the required data before sending */
 	batman_if = orig_node->router->if_incoming;
 	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 
 	send_raw_packet((unsigned char *)&info->packet,
 			packet_length, batman_if, dstaddr);
 	return;
 
 out:
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
+	spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
 }
 
 /* only send one vis packet. called from send_vis_packets() */
-static void send_vis_packet(struct vis_info *info)
+static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 {
 	int packet_length;
 
@@ -683,103 +694,115 @@ static void send_vis_packet(struct vis_info *info)
 		return;
 	}
 
-	memcpy(info->packet.sender_orig, main_if_addr, ETH_ALEN);
+	memcpy(info->packet.sender_orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 	info->packet.ttl--;
 
 	packet_length = sizeof(struct vis_packet) +
 		info->packet.entries * sizeof(struct vis_info_entry);
 
 	if (is_bcast(info->packet.target_orig))
-		broadcast_vis_packet(info, packet_length);
+		broadcast_vis_packet(bat_priv, info, packet_length);
 	else
-		unicast_vis_packet(info, packet_length);
+		unicast_vis_packet(bat_priv, info, packet_length);
 	info->packet.ttl++; /* restore TTL */
 }
 
 /* called from timer; send (and maybe generate) vis packet. */
 static void send_vis_packets(struct work_struct *work)
 {
+	struct delayed_work *delayed_work =
+		container_of(work, struct delayed_work, work);
+	struct bat_priv *bat_priv =
+		container_of(delayed_work, struct bat_priv, vis_work);
 	struct vis_info *info, *temp;
 	unsigned long flags;
-	/* struct bat_priv *bat_priv = netdev_priv(soft_device); */
-
-	spin_lock_irqsave(&vis_hash_lock, flags);
 
-	purge_vis_packets();
+	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
+	purge_vis_packets(bat_priv);
 
-	/* if (generate_vis_packet(bat_priv) == 0) {*/
+	if (generate_vis_packet(bat_priv) == 0) {
 		/* schedule if generation was successful */
-		/*send_list_add(my_vis_info);
-	} */
+		send_list_add(bat_priv, bat_priv->my_vis_info);
+	}
 
-	list_for_each_entry_safe(info, temp, &send_list, send_list) {
+	list_for_each_entry_safe(info, temp, &bat_priv->vis_send_list,
+				 send_list) {
 
 		kref_get(&info->refcount);
-		spin_unlock_irqrestore(&vis_hash_lock, flags);
+		spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
 
-		send_vis_packet(info);
+		if (bat_priv->primary_if)
+			send_vis_packet(bat_priv, info);
 
-		spin_lock_irqsave(&vis_hash_lock, flags);
+		spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
 		send_list_del(info);
 		kref_put(&info->refcount, free_info);
 	}
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
-	start_vis_timer();
+	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	start_vis_timer(bat_priv);
 }
-static DECLARE_DELAYED_WORK(vis_timer_wq, send_vis_packets);
 
 /* init the vis server. this may only be called when if_list is already
  * initialized (e.g. bat0 is initialized, interfaces have been added) */
-int vis_init(void)
+int vis_init(struct bat_priv *bat_priv)
 {
 	unsigned long flags;
-	if (vis_hash)
+
+	if (bat_priv->vis_hash)
 		return 1;
 
-	spin_lock_irqsave(&vis_hash_lock, flags);
+	if (!bat_priv->primary_if)
+		return 0;
+
+	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
 
-	vis_hash = hash_new(256, vis_info_cmp, vis_info_choose);
-	if (!vis_hash) {
+	bat_priv->vis_hash = hash_new(256, vis_info_cmp, vis_info_choose);
+	if (!bat_priv->vis_hash) {
 		pr_err("Can't initialize vis_hash\n");
 		goto err;
 	}
 
-	my_vis_info = kmalloc(1000, GFP_ATOMIC);
-	if (!my_vis_info) {
+	bat_priv->my_vis_info = kmalloc(1000, GFP_ATOMIC);
+	if (!bat_priv->my_vis_info) {
 		pr_err("Can't initialize vis packet\n");
 		goto err;
 	}
 
 	/* prefill the vis info */
-	my_vis_info->first_seen = jiffies - msecs_to_jiffies(VIS_INTERVAL);
-	INIT_LIST_HEAD(&my_vis_info->recv_list);
-	INIT_LIST_HEAD(&my_vis_info->send_list);
-	kref_init(&my_vis_info->refcount);
-	my_vis_info->packet.version = COMPAT_VERSION;
-	my_vis_info->packet.packet_type = BAT_VIS;
-	my_vis_info->packet.ttl = TTL;
-	my_vis_info->packet.seqno = 0;
-	my_vis_info->packet.entries = 0;
-
-	INIT_LIST_HEAD(&send_list);
-
-	memcpy(my_vis_info->packet.vis_orig, main_if_addr, ETH_ALEN);
-	memcpy(my_vis_info->packet.sender_orig, main_if_addr, ETH_ALEN);
-
-	if (hash_add(vis_hash, my_vis_info) < 0) {
+	bat_priv->my_vis_info->first_seen = jiffies -
+						msecs_to_jiffies(VIS_INTERVAL);
+	INIT_LIST_HEAD(&bat_priv->my_vis_info->recv_list);
+	INIT_LIST_HEAD(&bat_priv->my_vis_info->send_list);
+	kref_init(&bat_priv->my_vis_info->refcount);
+	bat_priv->my_vis_info->bat_priv = bat_priv;
+	bat_priv->my_vis_info->packet.version = COMPAT_VERSION;
+	bat_priv->my_vis_info->packet.packet_type = BAT_VIS;
+	bat_priv->my_vis_info->packet.ttl = TTL;
+	bat_priv->my_vis_info->packet.seqno = 0;
+	bat_priv->my_vis_info->packet.entries = 0;
+
+	INIT_LIST_HEAD(&bat_priv->vis_send_list);
+
+	memcpy(bat_priv->my_vis_info->packet.vis_orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(bat_priv->my_vis_info->packet.sender_orig,
+	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+
+	if (hash_add(bat_priv->vis_hash, bat_priv->my_vis_info) < 0) {
 		pr_err("Can't add own vis packet into hash\n");
 		/* not in hash, need to remove it manually. */
-		kref_put(&my_vis_info->refcount, free_info);
+		kref_put(&bat_priv->my_vis_info->refcount, free_info);
 		goto err;
 	}
 
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
-	start_vis_timer();
+	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	start_vis_timer(bat_priv);
 	return 1;
 
 err:
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
-	vis_quit();
+	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
+	vis_quit(bat_priv);
 	return 0;
 }
 
@@ -793,25 +816,26 @@ static void free_info_ref(void *data, void *arg)
 }
 
 /* shutdown vis-server */
-void vis_quit(void)
+void vis_quit(struct bat_priv *bat_priv)
 {
 	unsigned long flags;
-	if (!vis_hash)
+	if (!bat_priv->vis_hash)
 		return;
 
-	cancel_delayed_work_sync(&vis_timer_wq);
+	cancel_delayed_work_sync(&bat_priv->vis_work);
 
-	spin_lock_irqsave(&vis_hash_lock, flags);
+	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
 	/* properly remove, kill timers ... */
-	hash_delete(vis_hash, free_info_ref, NULL);
-	vis_hash = NULL;
-	my_vis_info = NULL;
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
+	hash_delete(bat_priv->vis_hash, free_info_ref, NULL);
+	bat_priv->vis_hash = NULL;
+	bat_priv->my_vis_info = NULL;
+	spin_unlock_irqrestore(&bat_priv->vis_hash_lock, flags);
 }
 
 /* schedule packets for (re)transmission */
-static void start_vis_timer(void)
+static void start_vis_timer(struct bat_priv *bat_priv)
 {
-	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
-			   (VIS_INTERVAL * HZ) / 1000);
+	INIT_DELAYED_WORK(&bat_priv->vis_work, send_vis_packets);
+	queue_delayed_work(bat_event_workqueue, &bat_priv->vis_work,
+			   msecs_to_jiffies(VIS_INTERVAL));
 }
diff --git a/batman-adv/vis.h b/batman-adv/vis.h
index bb13bf1..2c3b330 100644
--- a/batman-adv/vis.h
+++ b/batman-adv/vis.h
@@ -24,29 +24,6 @@
 
 #define VIS_TIMEOUT		200	/* timeout of vis packets in seconds */
 
-struct vis_info {
-	unsigned long       first_seen;
-	struct list_head    recv_list;
-			    /* list of server-neighbors we received a vis-packet
-			     * from.  we should not reply to them. */
-	struct list_head send_list;
-	struct kref refcount;
-	/* this packet might be part of the vis send queue. */
-	struct vis_packet packet;
-	/* vis_info may follow here*/
-} __attribute__((packed));
-
-struct vis_info_entry {
-	uint8_t  src[ETH_ALEN];
-	uint8_t  dest[ETH_ALEN];
-	uint8_t  quality;	/* quality = 0 means HNA */
-} __attribute__((packed));
-
-struct recvlist_node {
-	struct list_head list;
-	uint8_t mac[ETH_ALEN];
-};
-
 int vis_seq_print_text(struct seq_file *seq, void *offset);
 void receive_server_sync_packet(struct bat_priv *bat_priv,
 				struct vis_packet *vis_packet,
@@ -54,7 +31,7 @@ void receive_server_sync_packet(struct bat_priv *bat_priv,
 void receive_client_update_packet(struct bat_priv *bat_priv,
 				  struct vis_packet *vis_packet,
 				  int vis_info_len);
-int vis_init(void);
-void vis_quit(void);
+int vis_init(struct bat_priv *bat_priv);
+void vis_quit(struct bat_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_VIS_H_ */
-- 
1.7.1

