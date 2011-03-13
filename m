Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 13 Mar 2011 20:52:24 +0100
Message-Id: <1300045945-28734-5-git-send-email-linus.luessing@web.de>
In-Reply-To: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
References: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Make orig_node->router an
	rcu protected pointer
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

The rcu protected macros rcu_dereference() and rcu_assign_pointer()
for the orig_node->router need to be used, as well as spin/rcu locking.
Otherwise we might end up using a router pointer pointing to already
freed memory.

Therefore this commit introduces the safe getter method
orig_node_get_router().

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 gateway_client.c |   78 ++++++++++++++++++------------
 icmp_socket.c    |   18 +------
 originator.c     |   25 +++++++++-
 originator.h     |    1 +
 routing.c        |  139 +++++++++++++++++++++++------------------------------
 send.c           |   19 +++++---
 types.h          |    4 +-
 vis.c            |   70 +++++++++++++--------------
 8 files changed, 180 insertions(+), 174 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 879ac15..d41ae97 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -98,6 +98,7 @@ void gw_election(struct bat_priv *bat_priv)
 {
 	struct hlist_node *node;
 	struct gw_node *gw_node, *curr_gw, *curr_gw_tmp = NULL;
+	struct neigh_node *router;
 	uint8_t max_tq = 0;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	int down, up;
@@ -133,26 +134,28 @@ void gw_election(struct bat_priv *bat_priv)
 	}
 
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
-		if (!gw_node->orig_node->router)
+		router = orig_node_get_router(gw_node->orig_node);
+		if (!router)
 			continue;
 
-		if (gw_node->deleted)
+		if (gw_node->deleted) {
+			neigh_node_free_ref(router);
 			continue;
+		}
 
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
 			gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags,
 					     &down, &up);
 
-			tmp_gw_factor = (gw_node->orig_node->router->tq_avg *
-					 gw_node->orig_node->router->tq_avg *
+			tmp_gw_factor = (router->tq_avg * router->tq_avg *
 					 down * 100 * 100) /
 					 (TQ_LOCAL_WINDOW_SIZE *
 					 TQ_LOCAL_WINDOW_SIZE * 64);
 
 			if ((tmp_gw_factor > max_gw_factor) ||
 			    ((tmp_gw_factor == max_gw_factor) &&
-			     (gw_node->orig_node->router->tq_avg > max_tq)))
+			     (router->tq_avg > max_tq)))
 				curr_gw_tmp = gw_node;
 			break;
 
@@ -164,19 +167,25 @@ void gw_election(struct bat_priv *bat_priv)
 			  *     soon as a better gateway appears which has
 			  *     $routing_class more tq points)
 			  **/
-			if (gw_node->orig_node->router->tq_avg > max_tq)
+			if (router->tq_avg > max_tq)
 				curr_gw_tmp = gw_node;
 			break;
 		}
 
-		if (gw_node->orig_node->router->tq_avg > max_tq)
-			max_tq = gw_node->orig_node->router->tq_avg;
+		if (router->tq_avg > max_tq)
+			max_tq = router->tq_avg;
 
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
+
+		neigh_node_free_ref(router);
 	}
 
 	if (curr_gw != curr_gw_tmp) {
+		router = orig_node_get_router(curr_gw_tmp->orig_node);
+		if (!router)
+			goto out;
+
 		if ((curr_gw) && (!curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
@@ -187,45 +196,47 @@ void gw_election(struct bat_priv *bat_priv)
 				"(gw_flags: %i, tq: %i)\n",
 				curr_gw_tmp->orig_node->orig,
 				curr_gw_tmp->orig_node->gw_flags,
-				curr_gw_tmp->orig_node->router->tq_avg);
+				router->tq_avg);
 		else
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Changing route to gateway %pM "
 				"(gw_flags: %i, tq: %i)\n",
 				curr_gw_tmp->orig_node->orig,
 				curr_gw_tmp->orig_node->gw_flags,
-				curr_gw_tmp->orig_node->router->tq_avg);
+				router->tq_avg);
 
+		neigh_node_free_ref(router);
 		gw_select(bat_priv, curr_gw_tmp);
 	}
 
+out:
 	rcu_read_unlock();
 }
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
 	struct orig_node *curr_gw_orig;
+	struct neigh_node *router_gw = NULL, *router_orig = NULL;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
 	curr_gw_orig = gw_get_selected(bat_priv);
 	if (!curr_gw_orig)
 		goto deselect;
 
-	rcu_read_lock();
-	if (!curr_gw_orig->router)
-		goto deselect_rcu;
+	router_gw = orig_node_get_router(curr_gw_orig);
+	if (!router_gw)
+		goto deselect;
 
 	/* this node already is the gateway */
 	if (curr_gw_orig == orig_node)
-		goto out_rcu;
+		goto out;
 
-	if (!orig_node->router)
-		goto out_rcu;
+	router_orig = orig_node_get_router(orig_node);
+	if (!router_orig)
+		goto out;
 
-	gw_tq_avg = curr_gw_orig->router->tq_avg;
-	rcu_read_unlock();
-
-	orig_tq_avg = orig_node->router->tq_avg;
+	gw_tq_avg = router_gw->tq_avg;
+	orig_tq_avg = router_orig->tq_avg;
 
 	/* the TQ value has to be better */
 	if (orig_tq_avg < gw_tq_avg)
@@ -243,18 +254,16 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 		"Restarting gateway selection: better gateway found (tq curr: "
 		"%i, tq new: %i)\n",
 		gw_tq_avg, orig_tq_avg);
-	goto deselect;
 
-out_rcu:
-	rcu_read_unlock();
-	goto out;
-deselect_rcu:
-	rcu_read_unlock();
 deselect:
 	gw_deselect(bat_priv);
 out:
 	if (curr_gw_orig)
 		orig_node_free_ref(curr_gw_orig);
+	if (router_gw)
+		neigh_node_free_ref(router_gw);
+	if (router_orig)
+		neigh_node_free_ref(router_orig);
 
 	return;
 }
@@ -366,19 +375,23 @@ static int _write_buffer_text(struct bat_priv *bat_priv,
 			      struct seq_file *seq, struct gw_node *gw_node)
 {
 	struct gw_node *curr_gw;
-	int down, up, ret;
+	struct neigh_node *router;
+	int down, up, ret = -1;
 
 	gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
 
+	router = orig_node_get_router(gw_node->orig_node);
+	if (!router)
+		goto out;
+
 	rcu_read_lock();
 	curr_gw = rcu_dereference(bat_priv->curr_gw);
 
 	ret = seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
 		       (curr_gw == gw_node ? "=>" : "  "),
 		       gw_node->orig_node->orig,
-		       gw_node->orig_node->router->tq_avg,
-		       gw_node->orig_node->router->addr,
-		       gw_node->orig_node->router->if_incoming->net_dev->name,
+		       router->tq_avg, router->addr,
+		       router->if_incoming->net_dev->name,
 		       gw_node->orig_node->gw_flags,
 		       (down > 2048 ? down / 1024 : down),
 		       (down > 2048 ? "MBit" : "KBit"),
@@ -386,6 +399,8 @@ static int _write_buffer_text(struct bat_priv *bat_priv,
 		       (up > 2048 ? "MBit" : "KBit"));
 
 	rcu_read_unlock();
+	neigh_node_free_ref(router);
+out:
 	return ret;
 }
 
@@ -423,10 +438,9 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 		if (gw_node->deleted)
 			continue;
 
-		if (!gw_node->orig_node->router)
+		if (_write_buffer_text(bat_priv, seq, gw_node) < 0)
 			continue;
 
-		_write_buffer_text(bat_priv, seq, gw_node);
 		gw_count++;
 	}
 	rcu_read_unlock();
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index 34ce56c..49079c2 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -218,23 +218,13 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dst_unreach;
 
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, icmp_packet->dst);
-
 	if (!orig_node)
-		goto unlock;
-
-	neigh_node = orig_node->router;
+		goto dst_unreach;
 
+	neigh_node = orig_node_get_router(orig_node);
 	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-		neigh_node = NULL;
-		goto unlock;
-	}
-
-	rcu_read_unlock();
+		goto dst_unreach;
 
 	if (!neigh_node->if_incoming)
 		goto dst_unreach;
@@ -252,8 +242,6 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	goto out;
 
-unlock:
-	rcu_read_unlock();
 dst_unreach:
 	icmp_packet->msg_type = DESTINATION_UNREACHABLE;
 	bat_socket_add_packet(socket_client, icmp_packet, packet_len);
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 0b91330..4989bbb 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -70,6 +70,21 @@ void neigh_node_free_ref(struct neigh_node *neigh_node)
 		call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
 }
 
+/* increases the refcounter of a found router */
+struct neigh_node *orig_node_get_router(struct orig_node *orig_node)
+{
+	struct neigh_node *router;
+
+	rcu_read_lock();
+	router = rcu_dereference(orig_node->router);
+
+	if (router && !atomic_inc_not_zero(&router->refcount))
+		router = NULL;
+
+	rcu_read_unlock();
+	return router;
+}
+
 struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   struct orig_node *orig_neigh_node,
 				   uint8_t *neigh,
@@ -421,24 +436,28 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-			if (!orig_node->router)
+			neigh_node = orig_node_get_router(orig_node);
+			if (!neigh_node)
 				continue;
 
-			if (orig_node->router->tq_avg == 0)
+			if (neigh_node->tq_avg == 0) {
+				neigh_node_free_ref(neigh_node);
 				continue;
+			}
 
 			last_seen_secs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) / 1000;
 			last_seen_msecs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) % 1000;
 
-			neigh_node = orig_node->router;
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
 				   last_seen_msecs, neigh_node->tq_avg,
 				   neigh_node->addr,
 				   neigh_node->if_incoming->net_dev->name);
 
+			neigh_node_free_ref(neigh_node);
+
 			hlist_for_each_entry_rcu(neigh_node, node_tmp,
 						 &orig_node->neigh_list, list) {
 				seq_printf(seq, " %pM (%3i)", neigh_node->addr,
diff --git a/batman-adv/originator.h b/batman-adv/originator.h
index 5cc0110..e1d641f 100644
--- a/batman-adv/originator.h
+++ b/batman-adv/originator.h
@@ -34,6 +34,7 @@ struct neigh_node *create_neighbor(struct orig_node *orig_node,
 				   uint8_t *neigh,
 				   struct hard_iface *if_incoming);
 void neigh_node_free_ref(struct neigh_node *neigh_node);
+struct neigh_node *orig_node_get_router(struct orig_node *orig_node);
 int orig_seq_print_text(struct seq_file *seq, void *offset);
 int orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num);
 int orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index c00d861..9780a62 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -89,8 +89,10 @@ static void update_route(struct bat_priv *bat_priv,
 {
 	struct neigh_node *neigh_node_tmp;
 
+	neigh_node_tmp = orig_node_get_router(orig_node);
+
 	/* route deleted */
-	if ((orig_node->router) && (!neigh_node)) {
+	if ((neigh_node_tmp) && (!neigh_node)) {
 
 		bat_dbg(DBG_ROUTES, bat_priv, "Deleting route towards: %pM\n",
 			orig_node->orig);
@@ -98,7 +100,7 @@ static void update_route(struct bat_priv *bat_priv,
 				    "originator timed out");
 
 		/* route added */
-	} else if ((!orig_node->router) && (neigh_node)) {
+	} else if ((!neigh_node_tmp) && (neigh_node)) {
 
 		bat_dbg(DBG_ROUTES, bat_priv,
 			"Adding route towards: %pM (via %pM)\n",
@@ -112,13 +114,16 @@ static void update_route(struct bat_priv *bat_priv,
 			"Changing route towards: %pM "
 			"(now via %pM - was via %pM)\n",
 			orig_node->orig, neigh_node->addr,
-			orig_node->router->addr);
+			neigh_node_tmp->addr);
 	}
 
 	if (neigh_node && !atomic_inc_not_zero(&neigh_node->refcount))
 		neigh_node = NULL;
-	neigh_node_tmp = orig_node->router;
-	orig_node->router = neigh_node;
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	rcu_assign_pointer(orig_node->router, neigh_node);
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
 	if (neigh_node_tmp)
 		neigh_node_free_ref(neigh_node_tmp);
 }
@@ -128,16 +133,21 @@ void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len)
 {
+	struct neigh_node *router = orig_node_get_router(orig_node);
 
 	if (!orig_node)
 		return;
 
-	if (orig_node->router != neigh_node)
+	if (router != neigh_node) {
 		update_route(bat_priv, orig_node, neigh_node,
 			     hna_buff, hna_buff_len);
+	}
 	/* may be just HNA changed */
 	else
 		update_HNA(bat_priv, orig_node, hna_buff, hna_buff_len);
+
+	if (router)
+		neigh_node_free_ref(router);
 }
 
 static int is_bidirectional_neigh(struct orig_node *orig_node,
@@ -288,8 +298,8 @@ static void bonding_candidate_add(struct orig_node *orig_node,
 				  struct neigh_node *neigh_node)
 {
 	struct hlist_node *node;
-	struct neigh_node *tmp_neigh_node;
-	uint8_t best_tq, interference_candidate = 0;
+	struct neigh_node *tmp_neigh_node, *router = NULL;
+	uint8_t interference_candidate = 0;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
@@ -298,13 +308,12 @@ static void bonding_candidate_add(struct orig_node *orig_node,
 			 neigh_node->orig_node->primary_addr))
 		goto candidate_del;
 
-	if (!orig_node->router)
+	router = orig_node_get_router(orig_node);
+	if (!router)
 		goto candidate_del;
 
-	best_tq = orig_node->router->tq_avg;
-
 	/* ... and is good enough to be considered */
-	if (neigh_node->tq_avg < best_tq - BONDING_TQ_THRESHOLD)
+	if (neigh_node->tq_avg < router->tq_avg - BONDING_TQ_THRESHOLD)
 		goto candidate_del;
 
 	/**
@@ -350,7 +359,9 @@ candidate_del:
 
 out:
 	spin_unlock_bh(&orig_node->neigh_list_lock);
-	return;
+
+	if (router)
+		neigh_node_free_ref(router);
 }
 
 /* copy primary address for bonding */
@@ -372,7 +383,8 @@ static void update_orig(struct bat_priv *bat_priv,
 			unsigned char *hna_buff, int hna_buff_len,
 			char is_duplicate)
 {
-	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL,
+			  *router = NULL;
 	struct orig_node *orig_node_tmp;
 	struct hlist_node *node;
 	int tmp_hna_buff_len;
@@ -441,19 +453,18 @@ static void update_orig(struct bat_priv *bat_priv,
 
 	/* if this neighbor already is our next hop there is nothing
 	 * to change */
-	if (orig_node->router == neigh_node)
+	router = orig_node_get_router(orig_node);
+	if (router == neigh_node)
 		goto update_hna;
 
 	/* if this neighbor does not offer a better TQ we won't consider it */
-	if ((orig_node->router) &&
-	    (orig_node->router->tq_avg > neigh_node->tq_avg))
+	if (router && (router->tq_avg > neigh_node->tq_avg))
 		goto update_hna;
 
 	/* if the TQ is the same and the link not more symetric we
 	 * won't consider it either */
-	if ((orig_node->router) &&
-	     (neigh_node->tq_avg == orig_node->router->tq_avg)) {
-		orig_node_tmp = orig_node->router->orig_node;
+	if (router && (neigh_node->tq_avg == router->tq_avg)) {
+		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
 		bcast_own_sum_orig =
 			orig_node_tmp->bcast_own_sum[if_incoming->if_num];
@@ -474,7 +485,7 @@ static void update_orig(struct bat_priv *bat_priv,
 	goto update_gw;
 
 update_hna:
-	update_routes(bat_priv, orig_node, orig_node->router,
+	update_routes(bat_priv, orig_node, router,
 		      hna_buff, tmp_hna_buff_len);
 
 update_gw:
@@ -496,6 +507,8 @@ unlock:
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
+	if (router)
+		neigh_node_free_ref(router);
 }
 
 /* checks whether the host restarted and is in the protection time.
@@ -603,6 +616,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct hard_iface *hard_iface;
 	struct orig_node *orig_neigh_node, *orig_node;
+	struct neigh_node *router = NULL, *router_router = NULL;
 	char has_directlink_flag;
 	char is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	char is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
@@ -747,14 +761,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		goto out;
 	}
 
+	router = orig_node_get_router(orig_node);
+	if (router)
+		router_router = orig_node_get_router(router->orig_node);
+
 	/* avoid temporary routing loops */
-	if ((orig_node->router) &&
-	    (orig_node->router->orig_node->router) &&
-	    (compare_eth(orig_node->router->addr,
-			 batman_packet->prev_sender)) &&
+	if (router && router_router &&
+	    (compare_eth(router->addr, batman_packet->prev_sender)) &&
 	    !(compare_eth(batman_packet->orig, batman_packet->prev_sender)) &&
-	    (compare_eth(orig_node->router->addr,
-			 orig_node->router->orig_node->router->addr))) {
+	    (compare_eth(router->addr, router_router->addr))) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: ignoring all rebroadcast packets that "
 			"may make me loop (sender: %pM)\n", ethhdr->h_source);
@@ -825,6 +840,11 @@ out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
 		orig_node_free_ref(orig_neigh_node);
 out:
+	if (router)
+		neigh_node_free_ref(router);
+	if (router_router)
+		neigh_node_free_ref(router_router);
+
 	orig_node_free_ref(orig_node);
 }
 
@@ -886,23 +906,13 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 
 	/* answer echo request (ping) */
 	/* get routing information */
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, icmp_packet->orig);
-
 	if (!orig_node)
-		goto unlock;
-
-	neigh_node = orig_node->router;
+		goto out;
 
+	neigh_node = orig_node_get_router(orig_node);
 	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-		neigh_node = NULL;
-		goto unlock;
-	}
-
-	rcu_read_unlock();
+		goto out;
 
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
@@ -918,10 +928,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
-	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
@@ -952,23 +959,13 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		goto out;
 
 	/* get routing information */
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, icmp_packet->orig);
-
 	if (!orig_node)
-		goto unlock;
-
-	neigh_node = orig_node->router;
+		goto out;
 
+	neigh_node = orig_node_get_router(orig_node);
 	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-		neigh_node = NULL;
-		goto unlock;
-	}
-
-	rcu_read_unlock();
+		goto out;
 
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
@@ -984,10 +981,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
-	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
@@ -1050,23 +1044,13 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		return recv_icmp_ttl_exceeded(bat_priv, skb);
 
 	/* get routing information */
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, icmp_packet->dst);
-
 	if (!orig_node)
-		goto unlock;
-
-	neigh_node = orig_node->router;
+		goto out;
 
+	neigh_node = orig_node_get_router(orig_node);
 	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-		neigh_node = NULL;
-		goto unlock;
-	}
-
-	rcu_read_unlock();
+		goto out;
 
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
@@ -1080,10 +1064,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
-	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
@@ -1204,7 +1185,8 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	if (!orig_node)
 		return NULL;
 
-	if (!orig_node->router)
+	router = orig_node_get_router(orig_node);
+	if (!router)
 		return NULL;
 
 	/* without bonding, the first node should
@@ -1213,9 +1195,8 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 
 	rcu_read_lock();
 	/* select default router to output */
-	router = orig_node->router;
-	router_orig = orig_node->router->orig_node;
-	if (!router_orig || !atomic_inc_not_zero(&router->refcount)) {
+	router_orig = router->orig_node;
+	if (!router_orig) {
 		rcu_read_unlock();
 		return NULL;
 	}
diff --git a/batman-adv/send.c b/batman-adv/send.c
index d49e54d..e78670c 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -308,6 +308,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct neigh_node *router;
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
 
@@ -316,6 +317,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 		return;
 	}
 
+	router = orig_node_get_router(orig_node);
+
 	in_tq = batman_packet->tq;
 	in_ttl = batman_packet->ttl;
 
@@ -324,20 +327,22 @@ void schedule_forward_packet(struct orig_node *orig_node,
 
 	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
 	 * of our best tq value */
-	if ((orig_node->router) && (orig_node->router->tq_avg != 0)) {
+	if (router && router->tq_avg != 0) {
 
 		/* rebroadcast ogm of best ranking neighbor as is */
-		if (!compare_eth(orig_node->router->addr, ethhdr->h_source)) {
-			batman_packet->tq = orig_node->router->tq_avg;
+		if (!compare_eth(router->addr, ethhdr->h_source)) {
+			batman_packet->tq = router->tq_avg;
 
-			if (orig_node->router->last_ttl)
-				batman_packet->ttl = orig_node->router->last_ttl
-							- 1;
+			if (router->last_ttl)
+				batman_packet->ttl = router->last_ttl - 1;
 		}
 
-		tq_avg = orig_node->router->tq_avg;
+		tq_avg = router->tq_avg;
 	}
 
+	if (router)
+		neigh_node_free_ref(router);
+
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq, bat_priv);
 
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 83445cf..1854cbb 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -67,7 +67,7 @@ struct hard_iface {
 struct orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
-	struct neigh_node *router;
+	struct neigh_node __rcu *router; /* rcu protected pointer */
 	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
 	unsigned long last_valid;
@@ -83,7 +83,7 @@ struct orig_node {
 	uint32_t last_bcast_seqno;
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
-	spinlock_t neigh_list_lock; /* protects neighbor list */
+	spinlock_t neigh_list_lock; /* protects neigh_list and router */
 	atomic_t refcount;
 	struct rcu_head rcu;
 	struct hlist_node hash_entry;
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index f90212f..3efd1ea 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -558,6 +558,7 @@ static int find_best_vis_server(struct bat_priv *bat_priv,
 				struct vis_info *info)
 {
 	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct neigh_node *router;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct orig_node *orig_node;
@@ -571,13 +572,17 @@ static int find_best_vis_server(struct bat_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-			if ((orig_node) && (orig_node->router) &&
-			    (orig_node->flags & VIS_SERVER) &&
-			    (orig_node->router->tq_avg > best_tq)) {
-				best_tq = orig_node->router->tq_avg;
+			router = orig_node_get_router(orig_node);
+			if (!router)
+				continue;
+
+			if ((orig_node->flags & VIS_SERVER) &&
+			    (router->tq_avg > best_tq)) {
+				best_tq = router->tq_avg;
 				memcpy(packet->target_orig, orig_node->orig,
 				       ETH_ALEN);
 			}
+			neigh_node_free_ref(router);
 		}
 		rcu_read_unlock();
 	}
@@ -633,19 +638,16 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-			neigh_node = orig_node->router;
-
+			neigh_node = orig_node_get_router(orig_node);
 			if (!neigh_node)
 				continue;
 
-			if (!compare_eth(neigh_node->addr, orig_node->orig))
-				continue;
-
-			if (neigh_node->if_incoming->if_status != IF_ACTIVE)
-				continue;
-
-			if (neigh_node->tq_avg < 1)
+			if (!compare_eth(neigh_node->addr, orig_node->orig) ||
+			    neigh_node->if_incoming->if_status != IF_ACTIVE ||
+			    neigh_node->tq_avg < 1) {
+				neigh_node_free_ref(neigh_node);
 				continue;
+			}
 
 			/* fill one entry into buffer. */
 			entry = (struct vis_info_entry *)
@@ -657,6 +659,8 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 			entry->quality = neigh_node->tq_avg;
 			packet->entries++;
 
+			neigh_node_free_ref(neigh_node);
+
 			if (vis_packet_full(info))
 				goto unlock;
 		}
@@ -725,6 +729,7 @@ static void purge_vis_packets(struct bat_priv *bat_priv)
 static void broadcast_vis_packet(struct bat_priv *bat_priv,
 				 struct vis_info *info)
 {
+	struct neigh_node *router;
 	struct hashtable_t *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
@@ -745,19 +750,26 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
 			/* if it's a vis server and reachable, send it. */
-			if ((!orig_node) || (!orig_node->router))
-				continue;
 			if (!(orig_node->flags & VIS_SERVER))
 				continue;
+
+			router = orig_node_get_router(orig_node);
+			if (!router)
+				continue;
+
 			/* don't send it if we already received the packet from
-			* this node. */
+			 * this node. */
 			if (recv_list_is_in(bat_priv, &info->recv_list,
-					    orig_node->orig))
+					    orig_node->orig)) {
+				neigh_node_free_ref(router);
 				continue;
+			}
 
 			memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
-			hard_iface = orig_node->router->if_incoming;
-			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+			hard_iface = router->if_incoming;
+			memcpy(dstaddr, router->addr, ETH_ALEN);
+
+			neigh_node_free_ref(router);
 
 			skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 			if (skb)
@@ -778,33 +790,19 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 
 	packet = (struct vis_packet *)info->skb_packet->data;
 
-	rcu_read_lock();
 	orig_node = orig_hash_find(bat_priv, packet->target_orig);
-
 	if (!orig_node)
-		goto unlock;
-
-	neigh_node = orig_node->router;
+		goto out;
 
+	neigh_node = orig_node_get_router(orig_node);
 	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-		neigh_node = NULL;
-		goto unlock;
-	}
-
-	rcu_read_unlock();
+		goto out;
 
 	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 	if (skb)
 		send_skb_packet(skb, neigh_node->if_incoming,
 				neigh_node->addr);
 
-	goto out;
-
-unlock:
-	rcu_read_unlock();
 out:
 	if (neigh_node)
 		neigh_node_free_ref(neigh_node);
-- 
1.7.4.1

