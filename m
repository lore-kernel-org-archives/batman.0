Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  6 Mar 2011 03:19:13 +0100
Message-Id: <1299377954-8690-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Make orig_node->router an
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

In update_orig() the functions update_route_rcu() (former
update_route()) and update_HNA() are now called directly instead of
update_routes() in both cases. This made keeping the rcu-locking neat
easier update_routes() would have called the according functions at
these positions always anyway.

Also two small code blocks in receive_bat_packet() were swapped to keep
the time for rcu-locking low.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 gateway_client.c |   39 +++++++++++--------
 icmp_socket.c    |    2 +-
 originator.c     |    6 +-
 routing.c        |  110 ++++++++++++++++++++++++++++++++----------------------
 types.h          |    4 +-
 5 files changed, 93 insertions(+), 68 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 3cc4355..de57936 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -97,6 +97,7 @@ void gw_election(struct bat_priv *bat_priv)
 {
 	struct hlist_node *node;
 	struct gw_node *gw_node, *curr_gw, *curr_gw_tmp = NULL;
+	struct neigh_node *router;
 	uint8_t max_tq = 0;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	int down, up;
@@ -132,7 +133,8 @@ void gw_election(struct bat_priv *bat_priv)
 	}
 
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
-		if (!gw_node->orig_node->router)
+		router = rcu_dereference(gw_node->orig_node->router);
+		if (!router)
 			continue;
 
 		if (gw_node->deleted)
@@ -143,15 +145,14 @@ void gw_election(struct bat_priv *bat_priv)
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
 
@@ -163,19 +164,20 @@ void gw_election(struct bat_priv *bat_priv)
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
 	}
 
 	if (curr_gw != curr_gw_tmp) {
+		router = rcu_dereference(curr_gw_tmp->orig_node->router);
 		if ((curr_gw) && (!curr_gw_tmp))
 			bat_dbg(DBG_BATMAN, bat_priv,
 				"Removing selected gateway - "
@@ -186,14 +188,14 @@ void gw_election(struct bat_priv *bat_priv)
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
 
 		gw_select(bat_priv, curr_gw_tmp);
 	}
@@ -204,6 +206,7 @@ void gw_election(struct bat_priv *bat_priv)
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
 	struct gw_node *curr_gateway_tmp;
+	struct neigh_node *router;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
 	rcu_read_lock();
@@ -214,20 +217,21 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	if (!curr_gateway_tmp->orig_node)
 		goto deselect_rcu;
 
-	if (!curr_gateway_tmp->orig_node->router)
+	router = rcu_dereference(curr_gateway_tmp->orig_node->router);
+	if (!router)
 		goto deselect_rcu;
 
 	/* this node already is the gateway */
 	if (curr_gateway_tmp->orig_node == orig_node)
 		goto out_rcu;
 
-	if (!orig_node->router)
+	if (!rcu_dereference(orig_node->router))
 		goto out_rcu;
 
-	gw_tq_avg = curr_gateway_tmp->orig_node->router->tq_avg;
+	gw_tq_avg = router->tq_avg;
+	orig_tq_avg = rcu_dereference(orig_node->router)->tq_avg;
 	rcu_read_unlock();
 
-	orig_tq_avg = orig_node->router->tq_avg;
 
 	/* the TQ value has to be better */
 	if (orig_tq_avg < gw_tq_avg)
@@ -365,19 +369,20 @@ static int _write_buffer_text(struct bat_priv *bat_priv,
 			      struct seq_file *seq, struct gw_node *gw_node)
 {
 	struct gw_node *curr_gw;
+	struct neigh_node *router;
 	int down, up, ret;
 
 	gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
 
 	rcu_read_lock();
 	curr_gw = rcu_dereference(bat_priv->curr_gw);
+	router = rcu_dereference(gw_node->orig_node->router);
 
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
@@ -422,7 +427,7 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 		if (gw_node->deleted)
 			continue;
 
-		if (!gw_node->orig_node->router)
+		if (!rcu_dereference(gw_node->orig_node->router))
 			continue;
 
 		_write_buffer_text(bat_priv, seq, gw_node);
diff --git a/icmp_socket.c b/icmp_socket.c
index 34ce56c..3000c6b 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -224,7 +224,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (!orig_node)
 		goto unlock;
 
-	neigh_node = orig_node->router;
+	neigh_node = rcu_dereference(orig_node->router);
 
 	if (!neigh_node)
 		goto unlock;
diff --git a/originator.c b/originator.c
index 0b91330..31c6b5a 100644
--- a/originator.c
+++ b/originator.c
@@ -421,10 +421,11 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-			if (!orig_node->router)
+			neigh_node = rcu_dereference(orig_node->router);
+			if (!neigh_node)
 				continue;
 
-			if (orig_node->router->tq_avg == 0)
+			if (neigh_node->tq_avg == 0)
 				continue;
 
 			last_seen_secs = jiffies_to_msecs(jiffies -
@@ -432,7 +433,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) % 1000;
 
-			neigh_node = orig_node->router;
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
 				   last_seen_msecs, neigh_node->tq_avg,
diff --git a/routing.c b/routing.c
index c172f5d..db4f72c 100644
--- a/routing.c
+++ b/routing.c
@@ -82,15 +82,17 @@ static void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	}
 }
 
-static void update_route(struct bat_priv *bat_priv,
-			 struct orig_node *orig_node,
-			 struct neigh_node *neigh_node,
-			 unsigned char *hna_buff, int hna_buff_len)
+static void update_route_rcu(struct bat_priv *bat_priv,
+			     struct orig_node *orig_node,
+			     struct neigh_node *neigh_node,
+			     unsigned char *hna_buff, int hna_buff_len)
 {
 	struct neigh_node *neigh_node_tmp;
 
+	neigh_node_tmp = rcu_dereference(orig_node->router);
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
@@ -132,12 +137,17 @@ void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 	if (!orig_node)
 		return;
 
-	if (orig_node->router != neigh_node)
-		update_route(bat_priv, orig_node, neigh_node,
-			     hna_buff, hna_buff_len);
+	rcu_read_lock();
+	if (rcu_dereference(orig_node->router) != neigh_node) {
+		update_route_rcu(bat_priv, orig_node, neigh_node,
+				 hna_buff, hna_buff_len);
+		rcu_read_unlock();
+	}
 	/* may be just HNA changed */
-	else
+	else {
+		rcu_read_unlock();
 		update_HNA(bat_priv, orig_node, hna_buff, hna_buff_len);
+	}
 }
 
 static int is_bidirectional_neigh(struct orig_node *orig_node,
@@ -298,10 +308,12 @@ static void bonding_candidate_add(struct orig_node *orig_node,
 			 neigh_node->orig_node->primary_addr))
 		goto candidate_del;
 
-	if (!orig_node->router)
+	rcu_read_lock();
+	if (!rcu_dereference(orig_node->router))
 		goto candidate_del;
 
-	best_tq = orig_node->router->tq_avg;
+	best_tq = rcu_dereference(orig_node->router)->tq_avg;
+	rcu_read_unlock();
 
 	/* ... and is good enough to be considered */
 	if (neigh_node->tq_avg < best_tq - BONDING_TQ_THRESHOLD)
@@ -372,7 +384,7 @@ static void update_orig(struct bat_priv *bat_priv,
 			unsigned char *hna_buff, int hna_buff_len,
 			char is_duplicate)
 {
-	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL, *router;
 	struct orig_node *orig_node_tmp;
 	struct hlist_node *node;
 	int tmp_hna_buff_len;
@@ -441,19 +453,20 @@ static void update_orig(struct bat_priv *bat_priv,
 
 	/* if this neighbor already is our next hop there is nothing
 	 * to change */
-	if (orig_node->router == neigh_node)
+	rcu_read_lock();
+	router = rcu_dereference(orig_node->router);
+	if (router == neigh_node)
 		goto update_hna;
 
 	/* if this neighbor does not offer a better TQ we won't consider it */
-	if ((orig_node->router) &&
-	    (orig_node->router->tq_avg > neigh_node->tq_avg))
+	if ((router) && (router->tq_avg > neigh_node->tq_avg))
 		goto update_hna;
 
 	/* if the TQ is the same and the link not more symetric we
 	 * won't consider it either */
-	if ((orig_node->router) &&
-	     (neigh_node->tq_avg == orig_node->router->tq_avg)) {
-		orig_node_tmp = orig_node->router->orig_node;
+	if ((router) &&
+	     (neigh_node->tq_avg == router->tq_avg)) {
+		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
 		bcast_own_sum_orig =
 			orig_node_tmp->bcast_own_sum[if_incoming->if_num];
@@ -469,13 +482,15 @@ static void update_orig(struct bat_priv *bat_priv,
 			goto update_hna;
 	}
 
-	update_routes(bat_priv, orig_node, neigh_node,
-		      hna_buff, tmp_hna_buff_len);
+	update_route_rcu(bat_priv, orig_node, neigh_node,
+			 hna_buff, tmp_hna_buff_len);
+	rcu_read_unlock();
+
 	goto update_gw;
 
 update_hna:
-	update_routes(bat_priv, orig_node, orig_node->router,
-		      hna_buff, tmp_hna_buff_len);
+	rcu_read_unlock();
+	update_HNA(bat_priv, orig_node, hna_buff, hna_buff_len);
 
 update_gw:
 	if (orig_node->gw_flags != batman_packet->gw_flags)
@@ -603,6 +618,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct hard_iface *hard_iface;
 	struct orig_node *orig_neigh_node, *orig_node;
+	struct neigh_node *router;
 	char has_directlink_flag;
 	char is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	char is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
@@ -748,18 +764,30 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	/* avoid temporary routing loops */
-	if ((orig_node->router) &&
-	    (orig_node->router->orig_node->router) &&
-	    (compare_eth(orig_node->router->addr,
-			 batman_packet->prev_sender)) &&
+	rcu_read_lock();
+	router = rcu_dereference(orig_node->router);
+	if ((router) &&
+	    (rcu_dereference(router->orig_node->router)) &&
+	    (compare_eth(router->addr, batman_packet->prev_sender)) &&
 	    !(compare_eth(batman_packet->orig, batman_packet->prev_sender)) &&
-	    (compare_eth(orig_node->router->addr,
-			 orig_node->router->orig_node->router->addr))) {
+	    (compare_eth(router->addr,
+			 rcu_dereference(router->orig_node->router)->addr))) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: ignoring all rebroadcast packets that "
 			"may make me loop (sender: %pM)\n", ethhdr->h_source);
+		rcu_read_unlock();
+		goto out;
+	}
+
+	/* drop packet if sender is not a direct neighbor and if we
+	 * don't route towards it */
+	if (!is_single_hop_neigh && !router) {
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Drop packet: OGM via unknown neighbor!\n");
+		rcu_read_unlock();
 		goto out;
 	}
+	rcu_read_unlock();
 
 	/* if sender is a direct neighbor the sender mac equals
 	 * originator mac */
@@ -769,14 +797,6 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	if (!orig_neigh_node)
 		goto out;
 
-	/* drop packet if sender is not a direct neighbor and if we
-	 * don't route towards it */
-	if (!is_single_hop_neigh && (!orig_neigh_node->router)) {
-		bat_dbg(DBG_BATMAN, bat_priv,
-			"Drop packet: OGM via unknown neighbor!\n");
-		goto out_neigh;
-	}
-
 	is_bidirectional = is_bidirectional_neigh(orig_node, orig_neigh_node,
 						batman_packet, if_incoming);
 
@@ -892,7 +912,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	if (!orig_node)
 		goto unlock;
 
-	neigh_node = orig_node->router;
+	neigh_node = rcu_dereference(orig_node->router);
 
 	if (!neigh_node)
 		goto unlock;
@@ -958,7 +978,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	if (!orig_node)
 		goto unlock;
 
-	neigh_node = orig_node->router;
+	neigh_node = rcu_dereference(orig_node->router);
 
 	if (!neigh_node)
 		goto unlock;
@@ -1056,7 +1076,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (!orig_node)
 		goto unlock;
 
-	neigh_node = orig_node->router;
+	neigh_node = rcu_dereference(orig_node->router);
 
 	if (!neigh_node)
 		goto unlock;
@@ -1117,8 +1137,8 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 
 	rcu_read_lock();
 	/* select default router to output */
-	router = orig_node->router;
-	router_orig = orig_node->router->orig_node;
+	router = rcu_dereference(orig_node->router);
+	router_orig = router->orig_node;
 	if (!router_orig || !atomic_inc_not_zero(&router->refcount)) {
 		rcu_read_unlock();
 		return NULL;
diff --git a/types.h b/types.h
index 83445cf..1854cbb 100644
--- a/types.h
+++ b/types.h
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
-- 
1.7.4.1

