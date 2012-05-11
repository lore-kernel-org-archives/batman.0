Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 May 2012 21:26:08 +0200
Message-Id: <1336764370-10653-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: Prefix non-static
	functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_algo.h              |    2 +-
 bat_debugfs.c           |   31 +++----
 bat_debugfs.h           |    8 +-
 bat_iv_ogm.c            |  130 ++++++++++++++--------------
 bat_sysfs.c             |   34 ++++----
 bat_sysfs.h             |   13 +--
 bitarray.c              |    8 +-
 bitarray.h              |    4 +-
 bridge_loop_avoidance.c |   46 +++++-----
 bridge_loop_avoidance.h |   65 +++++++-------
 compat.c                |    8 +-
 compat.h                |    2 +-
 distributed-arp-table.c |   46 +++++-----
 distributed-arp-table.h |   67 ++++++++-------
 gateway_client.c        |   93 ++++++++++----------
 gateway_client.h        |   26 +++---
 gateway_common.c        |    9 +-
 gateway_common.h        |    5 +-
 hard-interface.c        |   72 ++++++++--------
 hard-interface.h        |   22 ++---
 hash.c                  |    4 +-
 hash.h                  |    6 +-
 icmp_socket.c           |   20 ++---
 icmp_socket.h           |    8 +-
 main.c                  |  109 ++++++++++++------------
 main.h                  |   46 +++++-----
 originator.c            |   65 +++++++-------
 originator.h            |   21 ++---
 ring_buffer.c           |    5 +-
 ring_buffer.h           |    5 +-
 routing.c               |  215 ++++++++++++++++++++++++-----------------------
 routing.h               |   52 ++++++------
 send.c                  |   47 ++++++-----
 send.h                  |   17 ++--
 soft-interface.c        |   68 +++++++--------
 soft-interface.h        |   13 ++-
 translation-table.c     |  150 +++++++++++++++++----------------
 translation-table.h     |   71 +++++++++-------
 unicast.c               |   62 +++++++-------
 unicast.h               |   30 ++++---
 vis.c                   |   57 +++++++------
 vis.h                   |   18 ++--
 42 files changed, 925 insertions(+), 855 deletions(-)

diff --git a/bat_algo.h b/bat_algo.h
index 9852a68..a14336a 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -22,6 +22,6 @@
 #ifndef _NET_BATMAN_ADV_BAT_ALGO_H_
 #define _NET_BATMAN_ADV_BAT_ALGO_H_
 
-int bat_iv_init(void);
+int batadv_iv_init(void);
 
 #endif /* _NET_BATMAN_ADV_BAT_ALGO_H_ */
diff --git a/bat_debugfs.c b/bat_debugfs.c
index 3b588f8..3bdd99a 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -76,7 +76,7 @@ static int fdebug_log(struct debug_log *debug_log, const char *fmt, ...)
 	return 0;
 }
 
-int debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
+int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
 {
 	va_list args;
 	char tmp_log_buf[256];
@@ -94,13 +94,13 @@ static int log_open(struct inode *inode, struct file *file)
 {
 	nonseekable_open(inode, file);
 	file->private_data = inode->i_private;
-	inc_module_count();
+	batadv_inc_module_count();
 	return 0;
 }
 
 static int log_release(struct inode *inode, struct file *file)
 {
-	dec_module_count();
+	batadv_dec_module_count();
 	return 0;
 }
 
@@ -224,45 +224,46 @@ static void debug_log_cleanup(struct bat_priv *bat_priv)
 
 static int bat_algorithms_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, bat_algo_seq_print_text, NULL);
+	return single_open(file, batadv_algo_seq_print_text, NULL);
 }
 
 static int originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, orig_seq_print_text, net_dev);
+	return single_open(file, batadv_orig_seq_print_text, net_dev);
 }
 
 static int gateways_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, gw_client_seq_print_text, net_dev);
+	return single_open(file, batadv_gw_client_seq_print_text, net_dev);
 }
 
 static int transtable_global_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, tt_global_seq_print_text, net_dev);
+	return single_open(file, batadv_tt_global_seq_print_text, net_dev);
 }
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 static int bla_claim_table_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, bla_claim_table_seq_print_text, net_dev);
+	return single_open(file, batadv_bla_claim_table_seq_print_text,
+			   net_dev);
 }
 #endif
 
 static int transtable_local_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, tt_local_seq_print_text, net_dev);
+	return single_open(file, batadv_tt_local_seq_print_text, net_dev);
 }
 
 static int vis_data_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, vis_seq_print_text, net_dev);
+	return single_open(file, batadv_vis_seq_print_text, net_dev);
 }
 
 struct bat_debuginfo {
@@ -304,7 +305,7 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
 	NULL,
 };
 
-void debugfs_init(void)
+void batadv_debugfs_init(void)
 {
 	struct bat_debuginfo *bat_debug;
 	struct dentry *file;
@@ -327,7 +328,7 @@ out:
 	return;
 }
 
-void debugfs_destroy(void)
+void batadv_debugfs_destroy(void)
 {
 	if (bat_debugfs) {
 		debugfs_remove_recursive(bat_debugfs);
@@ -335,7 +336,7 @@ void debugfs_destroy(void)
 	}
 }
 
-int debugfs_add_meshif(struct net_device *dev)
+int batadv_debugfs_add_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct bat_debuginfo **bat_debug;
@@ -348,7 +349,7 @@ int debugfs_add_meshif(struct net_device *dev)
 	if (!bat_priv->debug_dir)
 		goto out;
 
-	bat_socket_setup(bat_priv);
+	batadv_socket_setup(bat_priv);
 	debug_log_setup(bat_priv);
 
 	for (bat_debug = mesh_debuginfos; *bat_debug; ++bat_debug) {
@@ -375,7 +376,7 @@ out:
 #endif /* CONFIG_DEBUG_FS */
 }
 
-void debugfs_del_meshif(struct net_device *dev)
+void batadv_debugfs_del_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 
diff --git a/bat_debugfs.h b/bat_debugfs.h
index d605c67..3b206c8 100644
--- a/bat_debugfs.h
+++ b/bat_debugfs.h
@@ -25,9 +25,9 @@
 
 #define DEBUGFS_BAT_SUBDIR "batman_adv"
 
-void debugfs_init(void);
-void debugfs_destroy(void);
-int debugfs_add_meshif(struct net_device *dev);
-void debugfs_del_meshif(struct net_device *dev);
+void batadv_debugfs_init(void);
+void batadv_debugfs_destroy(void);
+int batadv_debugfs_add_meshif(struct net_device *dev);
+void batadv_debugfs_del_meshif(struct net_device *dev);
 
 #endif /* _NET_BATMAN_ADV_DEBUGFS_H_ */
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 8b0ecf3..82fc03b 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -138,7 +138,10 @@ static uint8_t hop_penalty(uint8_t tq, const struct bat_priv *bat_priv)
 static int bat_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 				  int tt_num_changes)
 {
-	int next_buff_pos = buff_pos + BATMAN_OGM_HLEN + tt_len(tt_num_changes);
+	int next_buff_pos = 0;
+
+	next_buff_pos += buff_pos + BATMAN_OGM_HLEN;
+	next_buff_pos += batadv_tt_len(tt_num_changes);
 
 	return (next_buff_pos <= packet_len) &&
 		(next_buff_pos <= MAX_AGGREGATION_BYTES);
@@ -188,8 +191,8 @@ static void bat_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 			batman_ogm_packet->ttvn, hard_iface->net_dev->name,
 			hard_iface->net_dev->dev_addr);
 
-		buff_pos += BATMAN_OGM_HLEN +
-				tt_len(batman_ogm_packet->tt_num_changes);
+		buff_pos += BATMAN_OGM_HLEN;
+		buff_pos += batadv_tt_len(batman_ogm_packet->tt_num_changes);
 		packet_num++;
 		batman_ogm_packet = (struct batman_ogm_packet *)
 					(forw_packet->skb->data + buff_pos);
@@ -201,7 +204,7 @@ static void bat_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 		inc_counter(bat_priv, BAT_CNT_MGMT_TX);
 		add_counter(bat_priv, BAT_CNT_MGMT_TX_BYTES,
 			    skb->len + ETH_HLEN);
-		send_skb_packet(skb, hard_iface, broadcast_addr);
+		batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
 	}
 }
 
@@ -250,8 +253,9 @@ static void bat_iv_ogm_emit(struct forw_packet *forw_packet)
 			forw_packet->if_incoming->net_dev->dev_addr);
 
 		/* skb is only used once and than forw_packet is free'd */
-		send_skb_packet(forw_packet->skb, forw_packet->if_incoming,
-				broadcast_addr);
+		batadv_send_skb_packet(forw_packet->skb,
+				       forw_packet->if_incoming,
+				       batadv_broadcast_addr);
 		forw_packet->skb = NULL;
 
 		goto out;
@@ -259,7 +263,7 @@ static void bat_iv_ogm_emit(struct forw_packet *forw_packet)
 
 	/* broadcast on every interface */
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
@@ -420,8 +424,8 @@ static void bat_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
-			  send_outstanding_bat_ogm_packet);
-	queue_delayed_work(bat_event_workqueue,
+			  batadv_send_outstanding_bat_ogm_packet);
+	queue_delayed_work(batadv_event_workqueue,
 			   &forw_packet_aggr->delayed_work,
 			   send_time - jiffies);
 
@@ -555,7 +559,7 @@ static void bat_iv_ogm_forward(struct orig_node *orig_node,
 		batman_ogm_packet->flags &= ~DIRECTLINK;
 
 	bat_iv_ogm_queue_add(bat_priv, (unsigned char *)batman_ogm_packet,
-			     BATMAN_OGM_HLEN + tt_len(tt_num_changes),
+			     BATMAN_OGM_HLEN + batadv_tt_len(tt_num_changes),
 			     if_incoming, 0, bat_iv_ogm_fwd_send_time());
 }
 
@@ -595,7 +599,7 @@ static void bat_iv_ogm_schedule(struct hard_iface *hard_iface,
 
 	atomic_inc(&hard_iface->seqno);
 
-	slide_own_bcast_window(hard_iface);
+	batadv_slide_own_bcast_window(hard_iface);
 	bat_iv_ogm_queue_add(bat_priv, hard_iface->packet_buff,
 			     hard_iface->packet_len, hard_iface, 1,
 			     bat_iv_ogm_emit_send_time(bat_priv));
@@ -629,7 +633,7 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 		    (tmp_neigh_node->if_incoming == if_incoming) &&
 		     atomic_inc_not_zero(&tmp_neigh_node->refcount)) {
 			if (neigh_node)
-				neigh_node_free_ref(neigh_node);
+				batadv_neigh_node_free_ref(neigh_node);
 			neigh_node = tmp_neigh_node;
 			continue;
 		}
@@ -638,17 +642,17 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 			continue;
 
 		spin_lock_bh(&tmp_neigh_node->lq_update_lock);
-		ring_buffer_set(tmp_neigh_node->tq_recv,
-				&tmp_neigh_node->tq_index, 0);
+		batadv_ring_buffer_set(tmp_neigh_node->tq_recv,
+				       &tmp_neigh_node->tq_index, 0);
 		tmp_neigh_node->tq_avg =
-			ring_buffer_avg(tmp_neigh_node->tq_recv);
+			batadv_ring_buffer_avg(tmp_neigh_node->tq_recv);
 		spin_unlock_bh(&tmp_neigh_node->lq_update_lock);
 	}
 
 	if (!neigh_node) {
 		struct orig_node *orig_tmp;
 
-		orig_tmp = get_orig_node(bat_priv, ethhdr->h_source);
+		orig_tmp = batadv_get_orig_node(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
 			goto unlock;
 
@@ -656,7 +660,7 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 						  orig_node, orig_tmp,
 						  batman_ogm_packet->seqno);
 
-		orig_node_free_ref(orig_tmp);
+		batadv_orig_node_free_ref(orig_tmp);
 		if (!neigh_node)
 			goto unlock;
 	} else
@@ -669,10 +673,10 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 	neigh_node->last_seen = jiffies;
 
 	spin_lock_bh(&neigh_node->lq_update_lock);
-	ring_buffer_set(neigh_node->tq_recv,
-			&neigh_node->tq_index,
-			batman_ogm_packet->tq);
-	neigh_node->tq_avg = ring_buffer_avg(neigh_node->tq_recv);
+	batadv_ring_buffer_set(neigh_node->tq_recv,
+			       &neigh_node->tq_index,
+			       batman_ogm_packet->tq);
+	neigh_node->tq_avg = batadv_ring_buffer_avg(neigh_node->tq_recv);
 	spin_unlock_bh(&neigh_node->lq_update_lock);
 
 	if (!is_duplicate) {
@@ -680,11 +684,11 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 		neigh_node->last_ttl = batman_ogm_packet->header.ttl;
 	}
 
-	bonding_candidate_add(orig_node, neigh_node);
+	batadv_bonding_candidate_add(orig_node, neigh_node);
 
 	/* if this neighbor already is our next hop there is nothing
 	 * to change */
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 	if (router == neigh_node)
 		goto update_tt;
 
@@ -711,7 +715,7 @@ static void bat_iv_ogm_orig_update(struct bat_priv *bat_priv,
 			goto update_tt;
 	}
 
-	update_route(bat_priv, orig_node, neigh_node);
+	batadv_update_route(bat_priv, orig_node, neigh_node);
 
 update_tt:
 	/* I have to check for transtable changes only if the OGM has been
@@ -719,14 +723,14 @@ update_tt:
 	if (((batman_ogm_packet->orig != ethhdr->h_source) &&
 	     (batman_ogm_packet->header.ttl > 2)) ||
 	    (batman_ogm_packet->flags & PRIMARIES_FIRST_HOP))
-		tt_update_orig(bat_priv, orig_node, tt_buff,
-			       batman_ogm_packet->tt_num_changes,
-			       batman_ogm_packet->ttvn,
-			       ntohs(batman_ogm_packet->tt_crc));
+		batadv_tt_update_orig(bat_priv, orig_node, tt_buff,
+				      batman_ogm_packet->tt_num_changes,
+				      batman_ogm_packet->ttvn,
+				      ntohs(batman_ogm_packet->tt_crc));
 
 	if (orig_node->gw_flags != batman_ogm_packet->gw_flags)
-		gw_node_update(bat_priv, orig_node,
-			       batman_ogm_packet->gw_flags);
+		batadv_gw_node_update(bat_priv, orig_node,
+				      batman_ogm_packet->gw_flags);
 
 	orig_node->gw_flags = batman_ogm_packet->gw_flags;
 
@@ -734,7 +738,7 @@ update_tt:
 	if ((orig_node->gw_flags) &&
 	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_CLIENT) &&
 	    (atomic_read(&bat_priv->gw_sel_class) > 2))
-		gw_check_election(bat_priv, orig_node);
+		batadv_gw_check_election(bat_priv, orig_node);
 
 	goto out;
 
@@ -742,9 +746,9 @@ unlock:
 	rcu_read_unlock();
 out:
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 }
 
 static int bat_iv_ogm_calc_tq(struct orig_node *orig_node,
@@ -844,7 +848,7 @@ static int bat_iv_ogm_calc_tq(struct orig_node *orig_node,
 
 out:
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	return ret;
 }
 
@@ -871,7 +875,7 @@ static int bat_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	int set_mark, ret = -1;
 	uint32_t seqno = ntohl(batman_ogm_packet->seqno);
 
-	orig_node = get_orig_node(bat_priv, batman_ogm_packet->orig);
+	orig_node = batadv_get_orig_node(bat_priv, batman_ogm_packet->orig);
 	if (!orig_node)
 		return 0;
 
@@ -880,8 +884,8 @@ static int bat_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 	/* signalize caller that the packet is to be dropped. */
 	if (!hlist_empty(&orig_node->neigh_list) &&
-	    window_protected(bat_priv, seq_diff,
-			     &orig_node->batman_seqno_reset))
+	    batadv_window_protected(bat_priv, seq_diff,
+				    &orig_node->batman_seqno_reset))
 		goto out;
 
 	rcu_read_lock();
@@ -899,9 +903,9 @@ static int bat_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			set_mark = 0;
 
 		/* if the window moved, set the update flag. */
-		need_update |= bit_get_packet(bat_priv,
-					      tmp_neigh_node->real_bits,
-					      seq_diff, set_mark);
+		need_update |= batadv_bit_get_packet(bat_priv,
+						     tmp_neigh_node->real_bits,
+						     seq_diff, set_mark);
 
 		tmp_neigh_node->real_packet_count =
 			bitmap_weight(tmp_neigh_node->real_bits,
@@ -920,7 +924,7 @@ static int bat_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 out:
 	spin_unlock_bh(&orig_node->ogm_cnt_lock);
-	orig_node_free_ref(orig_node);
+	batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -976,7 +980,7 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 		batman_ogm_packet->header.version, has_directlink_flag);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->if_status != IF_ACTIVE)
 			continue;
 
@@ -1025,7 +1029,8 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 		unsigned long *word;
 		int offset;
 
-		orig_neigh_node = get_orig_node(bat_priv, ethhdr->h_source);
+		orig_neigh_node = batadv_get_orig_node(bat_priv,
+						       ethhdr->h_source);
 		if (!orig_neigh_node)
 			return;
 
@@ -1049,7 +1054,7 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: originator packet from myself (via neighbor)\n");
-		orig_node_free_ref(orig_neigh_node);
+		batadv_orig_node_free_ref(orig_neigh_node);
 		return;
 	}
 
@@ -1067,7 +1072,7 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 		return;
 	}
 
-	orig_node = get_orig_node(bat_priv, batman_ogm_packet->orig);
+	orig_node = batadv_get_orig_node(bat_priv, batman_ogm_packet->orig);
 	if (!orig_node)
 		return;
 
@@ -1087,9 +1092,9 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 		goto out;
 	}
 
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 	if (router)
-		router_router = orig_node_get_router(router->orig_node);
+		router_router = batadv_orig_node_get_router(router->orig_node);
 
 	if ((router && router->tq_avg != 0) &&
 	    (compare_eth(router->addr, ethhdr->h_source)))
@@ -1111,11 +1116,11 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 	 * originator mac */
 	orig_neigh_node = (is_single_hop_neigh ?
 			   orig_node :
-			   get_orig_node(bat_priv, ethhdr->h_source));
+			   batadv_get_orig_node(bat_priv, ethhdr->h_source));
 	if (!orig_neigh_node)
 		goto out;
 
-	orig_neigh_router = orig_node_get_router(orig_neigh_node);
+	orig_neigh_router = batadv_orig_node_get_router(orig_neigh_node);
 
 	/* drop packet if sender is not a direct neighbor and if we
 	 * don't route towards it */
@@ -1128,7 +1133,8 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 	is_bidirectional = bat_iv_ogm_calc_tq(orig_node, orig_neigh_node,
 					      batman_ogm_packet, if_incoming);
 
-	bonding_save_primary(orig_node, orig_neigh_node, batman_ogm_packet);
+	batadv_bonding_save_primary(orig_node, orig_neigh_node,
+				    batman_ogm_packet);
 
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate */
@@ -1174,16 +1180,16 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
-		orig_node_free_ref(orig_neigh_node);
+		batadv_orig_node_free_ref(orig_neigh_node);
 out:
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 	if (router_router)
-		neigh_node_free_ref(router_router);
+		batadv_neigh_node_free_ref(router_router);
 	if (orig_neigh_router)
-		neigh_node_free_ref(orig_neigh_router);
+		batadv_neigh_node_free_ref(orig_neigh_router);
 
-	orig_node_free_ref(orig_node);
+	batadv_orig_node_free_ref(orig_node);
 }
 
 static int bat_iv_ogm_receive(struct sk_buff *skb,
@@ -1196,7 +1202,7 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 	unsigned char *tt_buff, *packet_buff;
 	bool ret;
 
-	ret = check_management_packet(skb, if_incoming, BATMAN_OGM_HLEN);
+	ret = batadv_check_management_packet(skb, if_incoming, BATMAN_OGM_HLEN);
 	if (!ret)
 		return NET_RX_DROP;
 
@@ -1221,8 +1227,8 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 		bat_iv_ogm_process(ethhdr, batman_ogm_packet,
 				   tt_buff, if_incoming);
 
-		buff_pos += BATMAN_OGM_HLEN +
-				tt_len(batman_ogm_packet->tt_num_changes);
+		buff_pos += BATMAN_OGM_HLEN;
+		buff_pos += batadv_tt_len(batman_ogm_packet->tt_num_changes);
 
 		batman_ogm_packet = (struct batman_ogm_packet *)
 						(packet_buff + buff_pos);
@@ -1243,23 +1249,23 @@ static struct bat_algo_ops batman_iv __read_mostly = {
 	.bat_ogm_emit = bat_iv_ogm_emit,
 };
 
-int __init bat_iv_init(void)
+int __init batadv_iv_init(void)
 {
 	int ret;
 
 	/* batman originator packet */
-	ret = recv_handler_register(BAT_IV_OGM, bat_iv_ogm_receive);
+	ret = batadv_recv_handler_register(BAT_IV_OGM, bat_iv_ogm_receive);
 	if (ret < 0)
 		goto out;
 
-	ret = bat_algo_register(&batman_iv);
+	ret = batadv_algo_register(&batman_iv);
 	if (ret < 0)
 		goto handler_unregister;
 
 	goto out;
 
 handler_unregister:
-	recv_handler_unregister(BAT_IV_OGM);
+	batadv_recv_handler_unregister(BAT_IV_OGM);
 out:
 	return ret;
 }
diff --git a/bat_sysfs.c b/bat_sysfs.c
index 6ba3d89..6a2a812 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -326,7 +326,7 @@ static ssize_t show_bat_algo(struct kobject *kobj, struct attribute *attr,
 static void post_gw_deselect(struct net_device *net_dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	gw_deselect(bat_priv);
+	batadv_gw_deselect(bat_priv);
 }
 
 static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
@@ -397,7 +397,7 @@ static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
 	bat_info(net_dev, "Changing gw mode from: %s to: %s\n",
 		 curr_gw_mode_str, buff);
 
-	gw_deselect(bat_priv);
+	batadv_gw_deselect(bat_priv);
 	atomic_set(&bat_priv->gw_mode, (unsigned int)gw_mode_tmp);
 	return count;
 }
@@ -409,7 +409,7 @@ static ssize_t show_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 	int down, up;
 	int gw_bandwidth = atomic_read(&bat_priv->gw_bandwidth);
 
-	gw_bandwidth_to_kbit(gw_bandwidth, &down, &up);
+	batadv_gw_bandwidth_to_kbit(gw_bandwidth, &down, &up);
 	return sprintf(buff, "%i%s/%i%s\n",
 		       (down > 2048 ? down / 1024 : down),
 		       (down > 2048 ? "MBit" : "KBit"),
@@ -425,7 +425,7 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
-	return gw_bandwidth_set(net_dev, buff, count);
+	return batadv_gw_bandwidth_set(net_dev, buff, count);
 }
 
 BAT_ATTR_SIF_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
@@ -433,7 +433,7 @@ BAT_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
 BAT_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
 #endif
-BAT_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
+BAT_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, batadv_update_min_mtu);
 BAT_ATTR_SIF_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(routing_algo, S_IRUGO, show_bat_algo, NULL);
@@ -469,7 +469,7 @@ static struct bat_attribute *mesh_attrs[] = {
 	NULL,
 };
 
-int sysfs_add_meshif(struct net_device *dev)
+int batadv_sysfs_add_meshif(struct net_device *dev)
 {
 	struct kobject *batif_kobject = &dev->dev.kobj;
 	struct bat_priv *bat_priv = netdev_priv(dev);
@@ -507,7 +507,7 @@ out:
 	return -ENOMEM;
 }
 
-void sysfs_del_meshif(struct net_device *dev)
+void batadv_sysfs_del_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct bat_attribute **bat_attr;
@@ -523,7 +523,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 			       char *buff)
 {
 	struct net_device *net_dev = kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	ssize_t length;
 
 	if (!hard_iface)
@@ -541,7 +541,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 				char *buff, size_t count)
 {
 	struct net_device *net_dev = kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	int status_tmp = -1;
 	int ret = count;
 
@@ -576,15 +576,15 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	}
 
 	if (status_tmp == IF_NOT_IN_USE) {
-		hardif_disable_interface(hard_iface);
+		batadv_hardif_disable_interface(hard_iface);
 		goto unlock;
 	}
 
 	/* if the interface already is in use */
 	if (hard_iface->if_status != IF_NOT_IN_USE)
-		hardif_disable_interface(hard_iface);
+		batadv_hardif_disable_interface(hard_iface);
 
-	ret = hardif_enable_interface(hard_iface, buff);
+	ret = batadv_hardif_enable_interface(hard_iface, buff);
 
 unlock:
 	rtnl_unlock();
@@ -597,7 +597,7 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 				 char *buff)
 {
 	struct net_device *net_dev = kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	ssize_t length;
 
 	if (!hard_iface)
@@ -637,7 +637,7 @@ static struct bat_attribute *batman_attrs[] = {
 	NULL,
 };
 
-int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
+int batadv_sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 {
 	struct kobject *hardif_kobject = &dev->dev.kobj;
 	struct bat_attribute **bat_attr;
@@ -671,14 +671,14 @@ out:
 	return -ENOMEM;
 }
 
-void sysfs_del_hardif(struct kobject **hardif_obj)
+void batadv_sysfs_del_hardif(struct kobject **hardif_obj)
 {
 	kobject_put(*hardif_obj);
 	*hardif_obj = NULL;
 }
 
-int throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
-		 enum uev_action action, const char *data)
+int batadv_throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
+			enum uev_action action, const char *data)
 {
 	int ret = -ENOMEM;
 	struct hard_iface *primary_if = NULL;
diff --git a/bat_sysfs.h b/bat_sysfs.h
index fece77a..f01aea8 100644
--- a/bat_sysfs.h
+++ b/bat_sysfs.h
@@ -34,11 +34,12 @@ struct bat_attribute {
 			 char *buf, size_t count);
 };
 
-int sysfs_add_meshif(struct net_device *dev);
-void sysfs_del_meshif(struct net_device *dev);
-int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev);
-void sysfs_del_hardif(struct kobject **hardif_obj);
-int throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
-		 enum uev_action action, const char *data);
+int batadv_sysfs_add_meshif(struct net_device *dev);
+void batadv_sysfs_del_meshif(struct net_device *dev);
+int batadv_sysfs_add_hardif(struct kobject **hardif_obj,
+			    struct net_device *dev);
+void batadv_sysfs_del_hardif(struct kobject **hardif_obj);
+int batadv_throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
+			enum uev_action action, const char *data);
 
 #endif /* _NET_BATMAN_ADV_SYSFS_H_ */
diff --git a/bitarray.c b/bitarray.c
index 07ae6e1..99ed991 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -25,7 +25,7 @@
 #include <linux/bitops.h>
 
 /* shift the packet array by n places. */
-static void bat_bitmap_shift_left(unsigned long *seq_bits, int32_t n)
+static void batadv_bitmap_shift_left(unsigned long *seq_bits, int32_t n)
 {
 	if (n <= 0 || n >= TQ_LOCAL_WINDOW_SIZE)
 		return;
@@ -40,8 +40,8 @@ static void bat_bitmap_shift_left(unsigned long *seq_bits, int32_t n)
  *  1 if the window was moved (either new or very old)
  *  0 if the window was not moved/shifted.
  */
-int bit_get_packet(void *priv, unsigned long *seq_bits,
-		    int32_t seq_num_diff, int set_mark)
+int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
+			  int32_t seq_num_diff, int set_mark)
 {
 	struct bat_priv *bat_priv = priv;
 
@@ -58,7 +58,7 @@ int bit_get_packet(void *priv, unsigned long *seq_bits,
 	 * set the mark if required */
 
 	if ((seq_num_diff > 0) && (seq_num_diff < TQ_LOCAL_WINDOW_SIZE)) {
-		bat_bitmap_shift_left(seq_bits, seq_num_diff);
+		batadv_bitmap_shift_left(seq_bits, seq_num_diff);
 
 		if (set_mark)
 			bat_set_bit(seq_bits, 0);
diff --git a/bitarray.h b/bitarray.h
index 1835c15..e855ddd 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -48,7 +48,7 @@ static inline void bat_set_bit(unsigned long *seq_bits, int32_t n)
 
 /* receive and process one packet, returns 1 if received seq_num is considered
  * new, 0 if old  */
-int bit_get_packet(void *priv, unsigned long *seq_bits,
-		   int32_t seq_num_diff, int set_mark);
+int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
+			  int32_t seq_num_diff, int set_mark);
 
 #endif /* _NET_BATMAN_ADV_BITARRAY_H_ */
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 89e9721..0c5a3ef 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -397,9 +397,9 @@ static struct backbone_gw *bla_get_backbone_gw(struct bat_priv *bat_priv,
 	/* this is a gateway now, remove any tt entries */
 	orig_node = orig_hash_find(bat_priv, orig);
 	if (orig_node) {
-		tt_global_del_orig(bat_priv, orig_node,
-				   "became a backbone gateway");
-		orig_node_free_ref(orig_node);
+		batadv_tt_global_del_orig(bat_priv, orig_node,
+					  "became a backbone gateway");
+		batadv_orig_node_free_ref(orig_node);
 	}
 	return entry;
 }
@@ -804,7 +804,7 @@ static int check_claim_group(struct bat_priv *bat_priv,
 		bla_dst_own->group = bla_dst->group;
 	}
 
-	orig_node_free_ref(orig_node);
+	batadv_orig_node_free_ref(orig_node);
 
 	return 2;
 }
@@ -1019,9 +1019,9 @@ purge_now:
  * Update the backbone gateways when the own orig address changes.
  *
  */
-void bla_update_orig_address(struct bat_priv *bat_priv,
-			     struct hard_iface *primary_if,
-			     struct hard_iface *oldif)
+void batadv_bla_update_orig_address(struct bat_priv *bat_priv,
+				    struct hard_iface *primary_if,
+				    struct hard_iface *oldif)
 {
 	struct backbone_gw *backbone_gw;
 	struct hlist_node *node;
@@ -1070,7 +1070,7 @@ void bla_update_orig_address(struct bat_priv *bat_priv,
 static void bla_start_timer(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->bla_work, bla_periodic_work);
-	queue_delayed_work(bat_event_workqueue, &bat_priv->bla_work,
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->bla_work,
 			   msecs_to_jiffies(BLA_PERIOD_LENGTH));
 }
 
@@ -1136,7 +1136,7 @@ static struct lock_class_key claim_hash_lock_class_key;
 static struct lock_class_key backbone_hash_lock_class_key;
 
 /* initialize all bla structures */
-int bla_init(struct bat_priv *bat_priv)
+int batadv_bla_init(struct bat_priv *bat_priv)
 {
 	int i;
 	uint8_t claim_dest[ETH_ALEN] = {0xff, 0x43, 0x05, 0x00, 0x00, 0x00};
@@ -1166,8 +1166,8 @@ int bla_init(struct bat_priv *bat_priv)
 	if (bat_priv->claim_hash)
 		return 0;
 
-	bat_priv->claim_hash = hash_new(128);
-	bat_priv->backbone_hash = hash_new(32);
+	bat_priv->claim_hash = batadv_hash_new(128);
+	bat_priv->backbone_hash = batadv_hash_new(32);
 
 	if (!bat_priv->claim_hash || !bat_priv->backbone_hash)
 		return -ENOMEM;
@@ -1198,9 +1198,9 @@ int bla_init(struct bat_priv *bat_priv)
  *
  **/
 
-int bla_check_bcast_duplist(struct bat_priv *bat_priv,
-			    struct bcast_packet *bcast_packet,
-			    int hdr_size)
+int batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
+				   struct bcast_packet *bcast_packet,
+				   int hdr_size)
 {
 	int i, length, curr;
 	uint8_t *content;
@@ -1259,7 +1259,7 @@ int bla_check_bcast_duplist(struct bat_priv *bat_priv,
  *
  */
 
-int bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
+int batadv_bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
 {
 	struct hashtable_t *hash = bat_priv->backbone_hash;
 	struct hlist_head *head;
@@ -1300,8 +1300,8 @@ int bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig)
  * returns 0.
  *
  */
-int bla_is_backbone_gw(struct sk_buff *skb,
-		       struct orig_node *orig_node, int hdr_size)
+int batadv_bla_is_backbone_gw(struct sk_buff *skb,
+			      struct orig_node *orig_node, int hdr_size)
 {
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
@@ -1338,7 +1338,7 @@ int bla_is_backbone_gw(struct sk_buff *skb,
 }
 
 /* free all bla structures (for softinterface free or module unload) */
-void bla_free(struct bat_priv *bat_priv)
+void batadv_bla_free(struct bat_priv *bat_priv)
 {
 	struct hard_iface *primary_if;
 
@@ -1347,12 +1347,12 @@ void bla_free(struct bat_priv *bat_priv)
 
 	if (bat_priv->claim_hash) {
 		bla_purge_claims(bat_priv, primary_if, 1);
-		hash_destroy(bat_priv->claim_hash);
+		batadv_hash_destroy(bat_priv->claim_hash);
 		bat_priv->claim_hash = NULL;
 	}
 	if (bat_priv->backbone_hash) {
 		bla_purge_backbone_gw(bat_priv, 1);
-		hash_destroy(bat_priv->backbone_hash);
+		batadv_hash_destroy(bat_priv->backbone_hash);
 		bat_priv->backbone_hash = NULL;
 	}
 	if (primary_if)
@@ -1373,7 +1373,7 @@ void bla_free(struct bat_priv *bat_priv)
  * process the skb.
  *
  */
-int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
+int batadv_bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 {
 	struct ethhdr *ethhdr;
 	struct claim search_claim, *claim = NULL;
@@ -1462,7 +1462,7 @@ out:
  * process the skb.
  *
  */
-int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
+int batadv_bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
 {
 	struct ethhdr *ethhdr;
 	struct claim search_claim, *claim = NULL;
@@ -1536,7 +1536,7 @@ out:
 	return ret;
 }
 
-int bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index e39f93a..3fafed8 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -23,73 +23,76 @@
 #define _NET_BATMAN_ADV_BLA_H_
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
-int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
-int bla_is_backbone_gw(struct sk_buff *skb,
-		       struct orig_node *orig_node, int hdr_size);
-int bla_claim_table_seq_print_text(struct seq_file *seq, void *offset);
-int bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig);
-int bla_check_bcast_duplist(struct bat_priv *bat_priv,
-			    struct bcast_packet *bcast_packet, int hdr_size);
-void bla_update_orig_address(struct bat_priv *bat_priv,
-			     struct hard_iface *primary_if,
-			     struct hard_iface *oldif);
-int bla_init(struct bat_priv *bat_priv);
-void bla_free(struct bat_priv *bat_priv);
+int batadv_bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
+int batadv_bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid);
+int batadv_bla_is_backbone_gw(struct sk_buff *skb,
+			      struct orig_node *orig_node, int hdr_size);
+int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_bla_is_backbone_gw_orig(struct bat_priv *bat_priv, uint8_t *orig);
+int batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
+				   struct bcast_packet *bcast_packet,
+				   int hdr_size);
+void batadv_bla_update_orig_address(struct bat_priv *bat_priv,
+				    struct hard_iface *primary_if,
+				    struct hard_iface *oldif);
+int batadv_bla_init(struct bat_priv *bat_priv);
+void batadv_bla_free(struct bat_priv *bat_priv);
 
 #define BLA_CRC_INIT	0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
-static inline int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb,
-			 short vid)
+static inline int batadv_bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb,
+				short vid)
 {
 	return 0;
 }
 
-static inline int bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb,
+static inline int batadv_bla_tx(struct bat_priv *bat_priv, struct sk_buff *skb,
 			 short vid)
 {
 	return 0;
 }
 
-static inline int bla_is_backbone_gw(struct sk_buff *skb,
-				     struct orig_node *orig_node,
-				     int hdr_size)
+static inline int batadv_bla_is_backbone_gw(struct sk_buff *skb,
+					    struct orig_node *orig_node,
+					    int hdr_size)
 {
 	return 0;
 }
 
-static inline int bla_claim_table_seq_print_text(struct seq_file *seq,
-						 void *offset)
+static inline int batadv_bla_claim_table_seq_print_text(struct seq_file *seq,
+							void *offset)
 {
 	return 0;
 }
 
-static inline int bla_is_backbone_gw_orig(struct bat_priv *bat_priv,
-					  uint8_t *orig)
+static inline int batadv_bla_is_backbone_gw_orig(struct bat_priv *bat_priv,
+						 uint8_t *orig)
 {
 	return 0;
 }
 
-static inline int bla_check_bcast_duplist(struct bat_priv *bat_priv,
-					  struct bcast_packet *bcast_packet,
-					  int hdr_size)
+static inline int
+batadv_bla_check_bcast_duplist(struct bat_priv *bat_priv,
+			       struct bcast_packet *bcast_packet,
+			       int hdr_size)
 {
 	return 0;
 }
 
-static inline void bla_update_orig_address(struct bat_priv *bat_priv,
-					   struct hard_iface *primary_if,
-					   struct hard_iface *oldif)
+static inline void
+batadv_bla_update_orig_address(struct bat_priv *bat_priv,
+			       struct hard_iface *primary_if,
+			       struct hard_iface *oldif)
 {
 }
 
-static inline int bla_init(struct bat_priv *bat_priv)
+static inline int batadv_bla_init(struct bat_priv *bat_priv)
 {
 	return 1;
 }
 
-static inline void bla_free(struct bat_priv *bat_priv)
+static inline void batadv_bla_free(struct bat_priv *bat_priv)
 {
 }
 
diff --git a/compat.c b/compat.c
index 35ad397..702c7c1 100644
--- a/compat.c
+++ b/compat.c
@@ -28,7 +28,7 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
-void free_rcu_gw_node(struct rcu_head *rcu)
+void batadv_free_rcu_gw_node(struct rcu_head *rcu)
 {
 	struct gw_node *gw_node;
 
@@ -36,7 +36,7 @@ void free_rcu_gw_node(struct rcu_head *rcu)
 	kfree(gw_node);
 }
 
-void free_rcu_neigh_node(struct rcu_head *rcu)
+void batadv_free_rcu_neigh_node(struct rcu_head *rcu)
 {
 	struct neigh_node *neigh_node;
 
@@ -44,7 +44,7 @@ void free_rcu_neigh_node(struct rcu_head *rcu)
 	kfree(neigh_node);
 }
 
-void free_rcu_tt_local_entry(struct rcu_head *rcu)
+void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu)
 {
 	struct tt_common_entry *tt_common_entry;
 	struct tt_local_entry *tt_local_entry;
@@ -56,7 +56,7 @@ void free_rcu_tt_local_entry(struct rcu_head *rcu)
 }
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-void free_rcu_backbone_gw(struct rcu_head *rcu)
+void batadv_free_rcu_backbone_gw(struct rcu_head *rcu)
 {
 	struct backbone_gw *backbone_gw;
 
diff --git a/compat.h b/compat.h
index 33c52d3..f4ec1b8 100644
--- a/compat.h
+++ b/compat.h
@@ -138,7 +138,7 @@ static inline int __param_set_copystring(const char *val,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
-#define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, free_rcu_##ptr)
+#define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, batadv_free_rcu_##ptr)
 #define vlan_insert_tag(skb, vid) __vlan_put_tag(skb, vid)
 
 void free_rcu_gw_node(struct rcu_head *rcu);
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 31699a4..6bc64f8 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -179,7 +179,7 @@ static void choose_next_candidate(struct bat_priv *bat_priv,
 
 			max = tmp_max;
 			if (max_orig_node)
-				orig_node_free_ref(max_orig_node);
+				batadv_orig_node_free_ref(max_orig_node);
 			max_orig_node = orig_node;
 		}
 		rcu_read_unlock();
@@ -240,6 +240,7 @@ static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
 {
 	int i;
 	bool ret = false;
+	int send_status;
 	struct neigh_node *neigh_node = NULL;
 	struct sk_buff *tmp_skb;
 	struct dht_candidate *cand = dht_select_candidates(bat_priv, ip);
@@ -253,25 +254,28 @@ static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
 		if (cand[i].type == DHT_CANDIDATE_NOT_FOUND)
 			continue;
 
-		neigh_node = orig_node_get_router(cand[i].orig_node);
+		neigh_node = batadv_orig_node_get_router(cand[i].orig_node);
 		if (!neigh_node)
 			goto free_orig;
 
 		tmp_skb = pskb_copy(skb, GFP_ATOMIC);
-		if (!prepare_unicast_4addr_packet(bat_priv, tmp_skb,
-						  cand[i].orig_node,
-						  packet_subtype)) {
+		if (!batadv_prepare_unicast_4addr_packet(bat_priv, tmp_skb,
+							 cand[i].orig_node,
+							 packet_subtype)) {
 			kfree_skb(tmp_skb);
 			goto free_neigh;
 		}
-		if (send_skb_packet(tmp_skb, neigh_node->if_incoming,
-				    neigh_node->addr) == NET_XMIT_SUCCESS)
+
+		send_status = batadv_send_skb_packet(tmp_skb,
+						     neigh_node->if_incoming,
+						     neigh_node->addr);
+		if (send_status == NET_XMIT_SUCCESS)
 			/* packet sent to a candidate: we can return true */
 			ret = true;
 free_neigh:
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 free_orig:
-		orig_node_free_ref(cand[i].orig_node);
+		batadv_orig_node_free_ref(cand[i].orig_node);
 	}
 
 out:
@@ -362,8 +366,8 @@ out:
  * otherwise. In case of true the message has to be enqueued to permit the
  * fallback
  */
-bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb)
+bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+					   struct sk_buff *skb)
 {
 	uint16_t type = 0;
 	__be32 ip_dst, ip_src;
@@ -428,8 +432,8 @@ out:
  * into the local table. If found, an ARP reply is sent immediately, otherwise
  * the caller has to deliver the ARP request to the upper layer
  */
-bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb, int hdr_size)
+bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+					   struct sk_buff *skb, int hdr_size)
 {
 	uint16_t type;
 	__be32 ip_src, ip_dst;
@@ -487,8 +491,8 @@ out:
  * soft interface. The related neighbour entry has to be updated and the DHT has
  * to be populated as well
  */
-bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb)
+bool batadv_dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+					 struct sk_buff *skb)
 {
 	uint16_t type;
 	__be32 ip_src, ip_dst;
@@ -524,8 +528,8 @@ out:
 /* This function has to be invoked on an ARP reply coming into the soft
  * interface from the mesh network. The local table has to be updated
  */
-bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb, int hdr_size)
+bool batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+					 struct sk_buff *skb, int hdr_size)
 {
 	uint16_t type;
 	__be32 ip_src, ip_dst;
@@ -553,14 +557,14 @@ bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
 	 */
-	ret = !is_my_client(bat_priv, hw_dst);
+	ret = !batadv_is_my_client(bat_priv, hw_dst);
 out:
 	/* if ret == false packet has to be delivered to the interface */
 	return ret;
 }
 
-bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-			       struct forw_packet *forw_packet)
+bool batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
+				      struct forw_packet *forw_packet)
 {
 	struct neighbour *n;
 
@@ -590,7 +594,7 @@ bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
 	return false;
 }
 
-void arp_change_timeout(struct net_device *soft_iface, const char *name)
+void batadv_arp_change_timeout(struct net_device *soft_iface, const char *name)
 {
 	struct in_device *in_dev = in_dev_get(soft_iface);
 	if (!in_dev) {
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index bf72275..23ffbfb 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -39,17 +39,17 @@
 #define ARP_IP_DST(skb, hdr_size) (*(__be32 *)(ARP_HW_SRC(skb, hdr_size) + \
 				   ETH_ALEN * 2 + 4))
 
-bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb);
-bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-				    struct sk_buff *skb, int hdr_size);
-bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb);
-bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-				  struct sk_buff *skb, int hdr_size);
-bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-			       struct forw_packet *forw_packet);
-void arp_change_timeout(struct net_device *soft_iface, const char *name);
+bool batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+					   struct sk_buff *skb);
+bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+					   struct sk_buff *skb, int hdr_size);
+bool batadv_dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+					 struct sk_buff *skb);
+bool batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+					 struct sk_buff *skb, int hdr_size);
+bool batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
+				      struct forw_packet *forw_packet);
+void batadv_arp_change_timeout(struct net_device *soft_iface, const char *name);
 
 /* hash function to choose an entry in a hash table of given size.
  * hash algorithm from http://en.wikipedia.org/wiki/Hash_table
@@ -73,14 +73,15 @@ static inline uint32_t hash_ipv4(const void *data, uint32_t size)
 	return hash % size;
 }
 
-static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
+static inline void
+batadv_dat_init_orig_node_dht_addr(struct orig_node *orig_node)
 {
 	orig_node->dht_addr = (dat_addr_t)choose_orig(orig_node->orig,
 						      DAT_ADDR_MAX);
 }
 
-static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
-					 struct hard_iface *primary_if)
+static inline void batadv_dat_init_own_dht_addr(struct bat_priv *bat_priv,
+						struct hard_iface *primary_if)
 {
 	bat_priv->dht_addr = (dat_addr_t)
 				choose_orig(primary_if->net_dev->dev_addr,
@@ -89,49 +90,53 @@ static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
 
 #else
 
-static inline bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
-						  struct sk_buff *skb)
+static inline bool
+batadv_dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
+				      struct sk_buff *skb)
 {
 	return false;
 }
 
-static inline bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
-						  struct sk_buff *skb,
-						  int hdr_size)
+static inline bool
+batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
+				      struct sk_buff *skb, int hdr_size)
 {
 	return false;
 }
 
-static inline bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
-						struct sk_buff *skb)
+static inline bool
+batadv_dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
+				    struct sk_buff *skb)
 {
 	return false;
 }
 
-static inline bool dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
-						struct sk_buff *skb,
-						int hdr_size)
+static inline bool
+batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
+				    struct sk_buff *skb, int hdr_size)
 {
 	return false;
 }
 
-static inline bool dat_drop_broadcast_packet(struct bat_priv *bat_priv,
-					     struct forw_packet *forw_packet)
+static inline bool
+batadv_dat_drop_broadcast_packet(struct bat_priv *bat_priv,
+				 struct forw_packet *forw_packet)
 {
 	return false;
 }
 
-static inline void dat_init_orig_node_dht_addr(struct orig_node *orig_node)
+static inline void
+batadv_dat_init_orig_node_dht_addr(struct orig_node *orig_node)
 {
 }
 
-static inline void dat_init_own_dht_addr(struct bat_priv *bat_priv,
-					 struct hard_iface *primary_if)
+static inline void batadv_dat_init_own_dht_addr(struct bat_priv *bat_priv,
+						struct hard_iface *primary_if)
 {
 }
 
-static inline void arp_change_timeout(struct net_device *soft_iface,
-				      const char *name)
+static inline void batadv_arp_change_timeout(struct net_device *soft_iface,
+					     const char *name)
 {
 }
 
diff --git a/gateway_client.c b/gateway_client.c
index 47f7186..e396029 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -60,7 +60,7 @@ out:
 	return gw_node;
 }
 
-struct orig_node *gw_get_selected_orig(struct bat_priv *bat_priv)
+struct orig_node *batadv_gw_get_selected_orig(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node;
 	struct orig_node *orig_node = NULL;
@@ -103,7 +103,7 @@ static void gw_select(struct bat_priv *bat_priv, struct gw_node *new_gw_node)
 	spin_unlock_bh(&bat_priv->gw_list_lock);
 }
 
-void gw_deselect(struct bat_priv *bat_priv)
+void batadv_gw_deselect(struct bat_priv *bat_priv)
 {
 	atomic_set(&bat_priv->gw_reselect, 1);
 }
@@ -116,13 +116,15 @@ static struct gw_node *gw_get_best_gw_node(struct bat_priv *bat_priv)
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	uint8_t max_tq = 0;
 	int down, up;
+	struct orig_node *orig_node;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
 		if (gw_node->deleted)
 			continue;
 
-		router = orig_node_get_router(gw_node->orig_node);
+		orig_node = gw_node->orig_node;
+		router = batadv_orig_node_get_router(orig_node);
 		if (!router)
 			continue;
 
@@ -131,8 +133,8 @@ static struct gw_node *gw_get_best_gw_node(struct bat_priv *bat_priv)
 
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
-			gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags,
-					     &down, &up);
+			batadv_gw_bandwidth_to_kbit(orig_node->gw_flags,
+						    &down, &up);
 
 			tmp_gw_factor = (router->tq_avg * router->tq_avg *
 					 down * 100 * 100) /
@@ -175,14 +177,14 @@ static struct gw_node *gw_get_best_gw_node(struct bat_priv *bat_priv)
 		gw_node_free_ref(gw_node);
 
 next:
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 	}
 	rcu_read_unlock();
 
 	return curr_gw;
 }
 
-void gw_election(struct bat_priv *bat_priv)
+void batadv_gw_election(struct bat_priv *bat_priv)
 {
 	struct gw_node *curr_gw = NULL, *next_gw = NULL;
 	struct neigh_node *router = NULL;
@@ -210,9 +212,9 @@ void gw_election(struct bat_priv *bat_priv)
 	if (next_gw) {
 		sprintf(gw_addr, "%pM", next_gw->orig_node->orig);
 
-		router = orig_node_get_router(next_gw->orig_node);
+		router = batadv_orig_node_get_router(next_gw->orig_node);
 		if (!router) {
-			gw_deselect(bat_priv);
+			batadv_gw_deselect(bat_priv);
 			goto out;
 		}
 	}
@@ -220,19 +222,19 @@ void gw_election(struct bat_priv *bat_priv)
 	if ((curr_gw) && (!next_gw)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Removing selected gateway - no gateway in range\n");
-		throw_uevent(bat_priv, UEV_GW, UEV_DEL, NULL);
+		batadv_throw_uevent(bat_priv, UEV_GW, UEV_DEL, NULL);
 	} else if ((!curr_gw) && (next_gw)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
 			next_gw->orig_node->orig, next_gw->orig_node->gw_flags,
 			router->tq_avg);
-		throw_uevent(bat_priv, UEV_GW, UEV_ADD, gw_addr);
+		batadv_throw_uevent(bat_priv, UEV_GW, UEV_ADD, gw_addr);
 	} else {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Changing route to gateway %pM (gw_flags: %i, tq: %i)\n",
 			next_gw->orig_node->orig, next_gw->orig_node->gw_flags,
 			router->tq_avg);
-		throw_uevent(bat_priv, UEV_GW, UEV_CHANGE, gw_addr);
+		batadv_throw_uevent(bat_priv, UEV_GW, UEV_CHANGE, gw_addr);
 	}
 
 	gw_select(bat_priv, next_gw);
@@ -243,20 +245,21 @@ out:
 	if (next_gw)
 		gw_node_free_ref(next_gw);
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 }
 
-void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
+void batadv_gw_check_election(struct bat_priv *bat_priv,
+			      struct orig_node *orig_node)
 {
 	struct orig_node *curr_gw_orig;
 	struct neigh_node *router_gw = NULL, *router_orig = NULL;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
-	curr_gw_orig = gw_get_selected_orig(bat_priv);
+	curr_gw_orig = batadv_gw_get_selected_orig(bat_priv);
 	if (!curr_gw_orig)
 		goto deselect;
 
-	router_gw = orig_node_get_router(curr_gw_orig);
+	router_gw = batadv_orig_node_get_router(curr_gw_orig);
 	if (!router_gw)
 		goto deselect;
 
@@ -264,7 +267,7 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	if (curr_gw_orig == orig_node)
 		goto out;
 
-	router_orig = orig_node_get_router(orig_node);
+	router_orig = batadv_orig_node_get_router(orig_node);
 	if (!router_orig)
 		goto out;
 
@@ -288,14 +291,14 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 		gw_tq_avg, orig_tq_avg);
 
 deselect:
-	gw_deselect(bat_priv);
+	batadv_gw_deselect(bat_priv);
 out:
 	if (curr_gw_orig)
-		orig_node_free_ref(curr_gw_orig);
+		batadv_orig_node_free_ref(curr_gw_orig);
 	if (router_gw)
-		neigh_node_free_ref(router_gw);
+		batadv_neigh_node_free_ref(router_gw);
 	if (router_orig)
-		neigh_node_free_ref(router_orig);
+		batadv_neigh_node_free_ref(router_orig);
 
 	return;
 }
@@ -318,7 +321,7 @@ static void gw_node_add(struct bat_priv *bat_priv,
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
 	spin_unlock_bh(&bat_priv->gw_list_lock);
 
-	gw_bandwidth_to_kbit(new_gwflags, &down, &up);
+	batadv_gw_bandwidth_to_kbit(new_gwflags, &down, &up);
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Found new gateway %pM -> gw_class: %i - %i%s/%i%s\n",
 		orig_node->orig, new_gwflags,
@@ -328,8 +331,8 @@ static void gw_node_add(struct bat_priv *bat_priv,
 		(up > 2048 ? "MBit" : "KBit"));
 }
 
-void gw_node_update(struct bat_priv *bat_priv,
-		    struct orig_node *orig_node, uint8_t new_gwflags)
+void batadv_gw_node_update(struct bat_priv *bat_priv,
+			   struct orig_node *orig_node, uint8_t new_gwflags)
 {
 	struct hlist_node *node;
 	struct gw_node *gw_node, *curr_gw;
@@ -374,7 +377,7 @@ void gw_node_update(struct bat_priv *bat_priv,
 	goto unlock;
 
 deselect:
-	gw_deselect(bat_priv);
+	batadv_gw_deselect(bat_priv);
 unlock:
 	rcu_read_unlock();
 
@@ -382,12 +385,13 @@ unlock:
 		gw_node_free_ref(curr_gw);
 }
 
-void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node)
+void batadv_gw_node_delete(struct bat_priv *bat_priv,
+			   struct orig_node *orig_node)
 {
-	gw_node_update(bat_priv, orig_node, 0);
+	batadv_gw_node_update(bat_priv, orig_node, 0);
 }
 
-void gw_node_purge(struct bat_priv *bat_priv)
+void batadv_gw_node_purge(struct bat_priv *bat_priv)
 {
 	struct gw_node *gw_node, *curr_gw;
 	struct hlist_node *node, *node_tmp;
@@ -416,7 +420,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
 
 	/* gw_deselect() needs to acquire the gw_list_lock */
 	if (do_deselect)
-		gw_deselect(bat_priv);
+		batadv_gw_deselect(bat_priv);
 
 	if (curr_gw)
 		gw_node_free_ref(curr_gw);
@@ -432,9 +436,9 @@ static int _write_buffer_text(struct bat_priv *bat_priv, struct seq_file *seq,
 	struct neigh_node *router;
 	int down, up, ret = -1;
 
-	gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
+	batadv_gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
 
-	router = orig_node_get_router(gw_node->orig_node);
+	router = batadv_orig_node_get_router(gw_node->orig_node);
 	if (!router)
 		goto out;
 
@@ -451,14 +455,14 @@ static int _write_buffer_text(struct bat_priv *bat_priv, struct seq_file *seq,
 			 (up > 2048 ? up / 1024 : up),
 			 (up > 2048 ? "MBit" : "KBit"));
 
-	neigh_node_free_ref(router);
+	batadv_neigh_node_free_ref(router);
 	if (curr_gw)
 		gw_node_free_ref(curr_gw);
 out:
 	return ret;
 }
 
-int gw_client_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -568,7 +572,7 @@ out:
 	return ret;
 }
 
-bool gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
+bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 {
 	struct ethhdr *ethhdr;
 	struct iphdr *iphdr;
@@ -634,8 +638,8 @@ bool gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	return true;
 }
 
-bool gw_out_of_range(struct bat_priv *bat_priv,
-		     struct sk_buff *skb, struct ethhdr *ethhdr)
+bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
+			    struct sk_buff *skb, struct ethhdr *ethhdr)
 {
 	struct neigh_node *neigh_curr = NULL, *neigh_old = NULL;
 	struct orig_node *orig_dst_node = NULL;
@@ -644,12 +648,12 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 	unsigned int header_len = 0;
 	uint8_t curr_tq_avg;
 
-	ret = gw_is_dhcp_target(skb, &header_len);
+	ret = batadv_gw_is_dhcp_target(skb, &header_len);
 	if (!ret)
 		goto out;
 
-	orig_dst_node = transtable_search(bat_priv, ethhdr->h_source,
-					  ethhdr->h_dest);
+	orig_dst_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
+						 ethhdr->h_dest);
 	if (!orig_dst_node)
 		goto out;
 
@@ -678,7 +682,8 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 		/* If the dhcp packet has been sent to a different gw,
 		 * we have to evaluate whether the old gw is still
 		 * reliable enough */
-		neigh_curr = find_router(bat_priv, curr_gw->orig_node, NULL);
+		neigh_curr = batadv_find_router(bat_priv, curr_gw->orig_node,
+						NULL);
 		if (!neigh_curr)
 			goto out;
 
@@ -689,7 +694,7 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 		goto out;
 	}
 
-	neigh_old = find_router(bat_priv, orig_dst_node, NULL);
+	neigh_old = batadv_find_router(bat_priv, orig_dst_node, NULL);
 	if (!neigh_old)
 		goto out;
 
@@ -698,12 +703,12 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 
 out:
 	if (orig_dst_node)
-		orig_node_free_ref(orig_dst_node);
+		batadv_orig_node_free_ref(orig_dst_node);
 	if (curr_gw)
 		gw_node_free_ref(curr_gw);
 	if (neigh_old)
-		neigh_node_free_ref(neigh_old);
+		batadv_neigh_node_free_ref(neigh_old);
 	if (neigh_curr)
-		neigh_node_free_ref(neigh_curr);
+		batadv_neigh_node_free_ref(neigh_curr);
 	return out_of_range;
 }
diff --git a/gateway_client.h b/gateway_client.h
index bf56a5a..2c2446f 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -22,17 +22,19 @@
 #ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 #define _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
 
-void gw_deselect(struct bat_priv *bat_priv);
-void gw_election(struct bat_priv *bat_priv);
-struct orig_node *gw_get_selected_orig(struct bat_priv *bat_priv);
-void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node);
-void gw_node_update(struct bat_priv *bat_priv,
-		    struct orig_node *orig_node, uint8_t new_gwflags);
-void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node);
-void gw_node_purge(struct bat_priv *bat_priv);
-int gw_client_seq_print_text(struct seq_file *seq, void *offset);
-bool gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len);
-bool gw_out_of_range(struct bat_priv *bat_priv,
-		     struct sk_buff *skb, struct ethhdr *ethhdr);
+void batadv_gw_deselect(struct bat_priv *bat_priv);
+void batadv_gw_election(struct bat_priv *bat_priv);
+struct orig_node *batadv_gw_get_selected_orig(struct bat_priv *bat_priv);
+void batadv_gw_check_election(struct bat_priv *bat_priv,
+			      struct orig_node *orig_node);
+void batadv_gw_node_update(struct bat_priv *bat_priv,
+			   struct orig_node *orig_node, uint8_t new_gwflags);
+void batadv_gw_node_delete(struct bat_priv *bat_priv,
+			   struct orig_node *orig_node);
+void batadv_gw_node_purge(struct bat_priv *bat_priv);
+int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset);
+bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len);
+bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
+			    struct sk_buff *skb, struct ethhdr *ethhdr);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_CLIENT_H_ */
diff --git a/gateway_common.c b/gateway_common.c
index ca57ac7..149f22c 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -59,7 +59,7 @@ static void kbit_to_gw_bandwidth(int down, int up, long *gw_srv_class)
 }
 
 /* returns the up and downspeeds in kbit, calculated from the class */
-void gw_bandwidth_to_kbit(uint8_t gw_srv_class, int *down, int *up)
+void batadv_gw_bandwidth_to_kbit(uint8_t gw_srv_class, int *down, int *up)
 {
 	int sbit = (gw_srv_class & 0x80) >> 7;
 	int dpart = (gw_srv_class & 0x78) >> 3;
@@ -136,7 +136,8 @@ static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
 	return true;
 }
 
-ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count)
+ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
+				size_t count)
 {
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	long gw_bandwidth_tmp = 0;
@@ -160,9 +161,9 @@ ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count)
 	 * speeds, hence we need to calculate it back to show the number
 	 * that is going to be propagated
 	 **/
-	gw_bandwidth_to_kbit((uint8_t)gw_bandwidth_tmp, &down, &up);
+	batadv_gw_bandwidth_to_kbit((uint8_t)gw_bandwidth_tmp, &down, &up);
 
-	gw_deselect(bat_priv);
+	batadv_gw_deselect(bat_priv);
 	bat_info(net_dev,
 		 "Changing gateway bandwidth from: '%i' to: '%ld' (propagating: %d%s/%d%s)\n",
 		 atomic_read(&bat_priv->gw_bandwidth), gw_bandwidth_tmp,
diff --git a/gateway_common.h b/gateway_common.h
index b8fb11c..e256040 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -32,7 +32,8 @@ enum gw_modes {
 #define GW_MODE_CLIENT_NAME	"client"
 #define GW_MODE_SERVER_NAME	"server"
 
-void gw_bandwidth_to_kbit(uint8_t gw_class, int *down, int *up);
-ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count);
+void batadv_gw_bandwidth_to_kbit(uint8_t gw_class, int *down, int *up);
+ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
+				size_t count);
 
 #endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index 843caa7..106b4e3 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -33,7 +33,7 @@
 
 #include <linux/if_arp.h>
 
-void hardif_free_rcu(struct rcu_head *rcu)
+void batadv_hardif_free_rcu(struct rcu_head *rcu)
 {
 	struct hard_iface *hard_iface;
 
@@ -42,12 +42,12 @@ void hardif_free_rcu(struct rcu_head *rcu)
 	kfree(hard_iface);
 }
 
-struct hard_iface *hardif_get_by_netdev(const struct net_device *net_dev)
+struct hard_iface *batadv_hardif_get_by_netdev(const struct net_device *net_dev)
 {
 	struct hard_iface *hard_iface;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->net_dev == net_dev &&
 		    atomic_inc_not_zero(&hard_iface->refcount))
 			goto out;
@@ -72,7 +72,7 @@ static int is_valid_iface(const struct net_device *net_dev)
 		return 0;
 
 	/* no batman over batman */
-	if (softif_is_valid(net_dev))
+	if (batadv_softif_is_valid(net_dev))
 		return 0;
 
 	/* Device is being bridged */
@@ -87,7 +87,7 @@ static struct hard_iface *hardif_get_active(const struct net_device *soft_iface)
 	struct hard_iface *hard_iface;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
@@ -113,7 +113,7 @@ static void primary_if_update_addr(struct bat_priv *bat_priv,
 	if (!primary_if)
 		goto out;
 
-	dat_init_own_dht_addr(bat_priv, primary_if);
+	batadv_dat_init_own_dht_addr(bat_priv, primary_if);
 
 	vis_packet = (struct vis_packet *)
 				bat_priv->my_vis_info->skb_packet->data;
@@ -121,7 +121,7 @@ static void primary_if_update_addr(struct bat_priv *bat_priv,
 	memcpy(vis_packet->sender_orig,
 	       primary_if->net_dev->dev_addr, ETH_ALEN);
 
-	bla_update_orig_address(bat_priv, primary_if, oldif);
+	batadv_bla_update_orig_address(bat_priv, primary_if, oldif);
 out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
@@ -164,7 +164,7 @@ static void check_known_mac_addr(const struct net_device *net_dev)
 	const struct hard_iface *hard_iface;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if ((hard_iface->if_status != IF_ACTIVE) &&
 		    (hard_iface->if_status != IF_TO_BE_ACTIVATED))
 			continue;
@@ -183,7 +183,7 @@ static void check_known_mac_addr(const struct net_device *net_dev)
 	rcu_read_unlock();
 }
 
-int hardif_min_mtu(struct net_device *soft_iface)
+int batadv_hardif_min_mtu(struct net_device *soft_iface)
 {
 	const struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	const struct hard_iface *hard_iface;
@@ -195,7 +195,7 @@ int hardif_min_mtu(struct net_device *soft_iface)
 		goto out;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if ((hard_iface->if_status != IF_ACTIVE) &&
 		    (hard_iface->if_status != IF_TO_BE_ACTIVATED))
 			continue;
@@ -212,11 +212,11 @@ out:
 }
 
 /* adjusts the MTU if a new interface with a smaller MTU appeared. */
-void update_min_mtu(struct net_device *soft_iface)
+void batadv_update_min_mtu(struct net_device *soft_iface)
 {
 	int min_mtu;
 
-	min_mtu = hardif_min_mtu(soft_iface);
+	min_mtu = batadv_hardif_min_mtu(soft_iface);
 	if (soft_iface->mtu != min_mtu)
 		soft_iface->mtu = min_mtu;
 }
@@ -245,7 +245,7 @@ static void hardif_activate_interface(struct hard_iface *hard_iface)
 	bat_info(hard_iface->soft_iface, "Interface activated: %s\n",
 		 hard_iface->net_dev->name);
 
-	update_min_mtu(hard_iface->soft_iface);
+	batadv_update_min_mtu(hard_iface->soft_iface);
 
 out:
 	if (primary_if)
@@ -263,11 +263,11 @@ static void hardif_deactivate_interface(struct hard_iface *hard_iface)
 	bat_info(hard_iface->soft_iface, "Interface deactivated: %s\n",
 		 hard_iface->net_dev->name);
 
-	update_min_mtu(hard_iface->soft_iface);
+	batadv_update_min_mtu(hard_iface->soft_iface);
 }
 
-int hardif_enable_interface(struct hard_iface *hard_iface,
-			    const char *iface_name)
+int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
+				   const char *iface_name)
 {
 	struct bat_priv *bat_priv;
 	struct net_device *soft_iface;
@@ -287,7 +287,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	soft_iface = dev_get_by_name(&init_net, iface_name);
 
 	if (!soft_iface) {
-		soft_iface = softif_create(iface_name);
+		soft_iface = batadv_softif_create(iface_name);
 
 		if (!soft_iface) {
 			ret = -ENOMEM;
@@ -298,7 +298,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 		dev_hold(soft_iface);
 	}
 
-	if (!softif_is_valid(soft_iface)) {
+	if (!batadv_softif_is_valid(soft_iface)) {
 		pr_err("Can't create batman mesh interface %s: already exists as regular interface\n",
 		       soft_iface->name);
 		ret = -EINVAL;
@@ -315,10 +315,10 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	hard_iface->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
 	hard_iface->if_status = IF_INACTIVE;
-	orig_hash_add_if(hard_iface, bat_priv->num_ifaces);
+	batadv_orig_hash_add_if(hard_iface, bat_priv->num_ifaces);
 
 	hard_iface->batman_adv_ptype.type = __constant_htons(ETH_P_BATMAN);
-	hard_iface->batman_adv_ptype.func = batman_skb_recv;
+	hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv;
 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
 	dev_add_pack(&hard_iface->batman_adv_ptype);
 
@@ -348,7 +348,7 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 			hard_iface->net_dev->name);
 
 	/* begin scheduling originator messages on that interface */
-	schedule_bat_ogm(hard_iface);
+	batadv_schedule_bat_ogm(hard_iface);
 
 out:
 	return 0;
@@ -360,7 +360,7 @@ err:
 	return ret;
 }
 
-void hardif_disable_interface(struct hard_iface *hard_iface)
+void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct hard_iface *primary_if = NULL;
@@ -376,7 +376,7 @@ void hardif_disable_interface(struct hard_iface *hard_iface)
 	dev_remove_pack(&hard_iface->batman_adv_ptype);
 
 	bat_priv->num_ifaces--;
-	orig_hash_del_if(hard_iface, bat_priv->num_ifaces);
+	batadv_orig_hash_del_if(hard_iface, bat_priv->num_ifaces);
 
 	primary_if = primary_if_get_selected(bat_priv);
 	if (hard_iface == primary_if) {
@@ -393,13 +393,13 @@ void hardif_disable_interface(struct hard_iface *hard_iface)
 	hard_iface->if_status = IF_NOT_IN_USE;
 
 	/* delete all references to this hard_iface */
-	purge_orig_ref(bat_priv);
-	purge_outstanding_packets(bat_priv, hard_iface);
+	batadv_purge_orig_ref(bat_priv);
+	batadv_purge_outstanding_packets(bat_priv, hard_iface);
 	dev_put(hard_iface->soft_iface);
 
 	/* nobody uses this interface anymore */
 	if (!bat_priv->num_ifaces)
-		softif_destroy(hard_iface->soft_iface);
+		batadv_softif_destroy(hard_iface->soft_iface);
 
 	hard_iface->soft_iface = NULL;
 	hardif_free_ref(hard_iface);
@@ -426,7 +426,7 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	if (!hard_iface)
 		goto release_dev;
 
-	ret = sysfs_add_hardif(&hard_iface->hardif_obj, net_dev);
+	ret = batadv_sysfs_add_hardif(&hard_iface->hardif_obj, net_dev);
 	if (ret)
 		goto free_if;
 
@@ -439,7 +439,7 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	atomic_set(&hard_iface->refcount, 2);
 
 	check_known_mac_addr(hard_iface->net_dev);
-	list_add_tail_rcu(&hard_iface->list, &hardif_list);
+	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 
 	/**
 	 * This can't be called via a bat_priv callback because
@@ -464,23 +464,23 @@ static void hardif_remove_interface(struct hard_iface *hard_iface)
 
 	/* first deactivate interface */
 	if (hard_iface->if_status != IF_NOT_IN_USE)
-		hardif_disable_interface(hard_iface);
+		batadv_hardif_disable_interface(hard_iface);
 
 	if (hard_iface->if_status != IF_NOT_IN_USE)
 		return;
 
 	hard_iface->if_status = IF_TO_BE_REMOVED;
-	sysfs_del_hardif(&hard_iface->hardif_obj);
+	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
 	hardif_free_ref(hard_iface);
 }
 
-void hardif_remove_interfaces(void)
+void batadv_hardif_remove_interfaces(void)
 {
 	struct hard_iface *hard_iface, *hard_iface_tmp;
 
 	rtnl_lock();
 	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
-				 &hardif_list, list) {
+				 &batadv_hardif_list, list) {
 		list_del_rcu(&hard_iface->list);
 		hardif_remove_interface(hard_iface);
 	}
@@ -491,7 +491,7 @@ static int hard_if_event(struct notifier_block *this,
 			 unsigned long event, void *ptr)
 {
 	struct net_device *net_dev = ptr;
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	struct hard_iface *primary_if = NULL;
 	struct bat_priv *bat_priv;
 
@@ -516,7 +516,7 @@ static int hard_if_event(struct notifier_block *this,
 		break;
 	case NETDEV_CHANGEMTU:
 		if (hard_iface->soft_iface)
-			update_min_mtu(hard_iface->soft_iface);
+			batadv_update_min_mtu(hard_iface->soft_iface);
 		break;
 	case NETDEV_CHANGEADDR:
 		if (hard_iface->if_status == IF_NOT_IN_USE)
@@ -548,7 +548,7 @@ out:
 
 /* This function returns true if the interface represented by ifindex is a
  * 802.11 wireless device */
-bool is_wifi_iface(int ifindex)
+bool batadv_is_wifi_iface(int ifindex)
 {
 	struct net_device *net_device = NULL;
 	bool ret = false;
@@ -576,6 +576,6 @@ out:
 	return ret;
 }
 
-struct notifier_block hard_if_notifier = {
+struct notifier_block batadv_hard_if_notifier = {
 	.notifier_call = hard_if_event,
 };
diff --git a/hard-interface.h b/hard-interface.h
index e68c565..20e09db 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -31,23 +31,23 @@ enum hard_if_state {
 	IF_I_WANT_YOU
 };
 
-extern struct notifier_block hard_if_notifier;
+extern struct notifier_block batadv_hard_if_notifier;
 
 struct hard_iface*
-hardif_get_by_netdev(const struct net_device *net_dev);
-int hardif_enable_interface(struct hard_iface *hard_iface,
-			    const char *iface_name);
-void hardif_disable_interface(struct hard_iface *hard_iface);
-void hardif_remove_interfaces(void);
-int hardif_min_mtu(struct net_device *soft_iface);
-void update_min_mtu(struct net_device *soft_iface);
-void hardif_free_rcu(struct rcu_head *rcu);
-bool is_wifi_iface(int ifindex);
+batadv_hardif_get_by_netdev(const struct net_device *net_dev);
+int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
+				   const char *iface_name);
+void batadv_hardif_disable_interface(struct hard_iface *hard_iface);
+void batadv_hardif_remove_interfaces(void);
+int batadv_hardif_min_mtu(struct net_device *soft_iface);
+void batadv_update_min_mtu(struct net_device *soft_iface);
+void batadv_hardif_free_rcu(struct rcu_head *rcu);
+bool batadv_is_wifi_iface(int ifindex);
 
 static inline void hardif_free_ref(struct hard_iface *hard_iface)
 {
 	if (atomic_dec_and_test(&hard_iface->refcount))
-		call_rcu(&hard_iface->rcu, hardif_free_rcu);
+		call_rcu(&hard_iface->rcu, batadv_hardif_free_rcu);
 }
 
 static inline struct hard_iface *primary_if_get_selected(
diff --git a/hash.c b/hash.c
index 4578c20..260d092 100644
--- a/hash.c
+++ b/hash.c
@@ -34,7 +34,7 @@ static void hash_init(struct hashtable_t *hash)
 }
 
 /* free only the hashtable and the hash itself. */
-void hash_destroy(struct hashtable_t *hash)
+void batadv_hash_destroy(struct hashtable_t *hash)
 {
 	kfree(hash->list_locks);
 	kfree(hash->table);
@@ -42,7 +42,7 @@ void hash_destroy(struct hashtable_t *hash)
 }
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(uint32_t size)
+struct hashtable_t *batadv_hash_new(uint32_t size)
 {
 	struct hashtable_t *hash;
 
diff --git a/hash.h b/hash.h
index 7bcb98f..486b94b 100644
--- a/hash.h
+++ b/hash.h
@@ -43,13 +43,13 @@ struct hashtable_t {
 };
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(uint32_t size);
+struct hashtable_t *batadv_hash_new(uint32_t size);
 
 /* set class key for all locks */
 void hash_set_lock_class(struct hashtable_t *hash, struct lock_class_key *key);
 
 /* free only the hashtable and the hash itself. */
-void hash_destroy(struct hashtable_t *hash);
+void batadv_hash_destroy(struct hashtable_t *hash);
 
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
  * called to remove the elements inside of the hash.  if you don't remove the
@@ -76,7 +76,7 @@ static inline void hash_delete(struct hashtable_t *hash,
 		spin_unlock_bh(list_lock);
 	}
 
-	hash_destroy(hash);
+	batadv_hash_destroy(hash);
 }
 
 /**
diff --git a/icmp_socket.c b/icmp_socket.c
index 2e98a57..cd4e357 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -34,7 +34,7 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 				  struct icmp_packet_rr *icmp_packet,
 				  size_t icmp_len);
 
-void bat_socket_init(void)
+void batadv_socket_init(void)
 {
 	memset(socket_client_hash, 0, sizeof(socket_client_hash));
 }
@@ -73,7 +73,7 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 
 	file->private_data = socket_client;
 
-	inc_module_count();
+	batadv_inc_module_count();
 	return 0;
 }
 
@@ -98,7 +98,7 @@ static int bat_socket_release(struct inode *inode, struct file *file)
 	spin_unlock_bh(&socket_client->lock);
 
 	kfree(socket_client);
-	dec_module_count();
+	batadv_dec_module_count();
 
 	return 0;
 }
@@ -219,7 +219,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (!orig_node)
 		goto dst_unreach;
 
-	neigh_node = orig_node_get_router(orig_node);
+	neigh_node = batadv_orig_node_get_router(orig_node);
 	if (!neigh_node)
 		goto dst_unreach;
 
@@ -236,7 +236,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		memcpy(icmp_packet->rr,
 		       neigh_node->if_incoming->net_dev->dev_addr, ETH_ALEN);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	goto out;
 
 dst_unreach:
@@ -248,9 +248,9 @@ out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	return len;
 }
 
@@ -276,7 +276,7 @@ static const struct file_operations fops = {
 	.llseek = no_llseek,
 };
 
-int bat_socket_setup(struct bat_priv *bat_priv)
+int batadv_socket_setup(struct bat_priv *bat_priv)
 {
 	struct dentry *d;
 
@@ -336,8 +336,8 @@ static void bat_socket_add_packet(struct socket_client *socket_client,
 	wake_up(&socket_client->queue_wait);
 }
 
-void bat_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
-			       size_t icmp_len)
+void batadv_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
+				  size_t icmp_len)
 {
 	struct socket_client *hash = socket_client_hash[icmp_packet->uid];
 
diff --git a/icmp_socket.h b/icmp_socket.h
index 380ed4c..7b88636 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -24,9 +24,9 @@
 
 #define ICMP_SOCKET "socket"
 
-void bat_socket_init(void);
-int bat_socket_setup(struct bat_priv *bat_priv);
-void bat_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
-			       size_t icmp_len);
+void batadv_socket_init(void);
+int batadv_socket_setup(struct bat_priv *bat_priv);
+void batadv_socket_receive_packet(struct icmp_packet_rr *icmp_packet,
+				  size_t icmp_len);
 
 #endif /* _NET_BATMAN_ADV_ICMP_SOCKET_H_ */
diff --git a/main.c b/main.c
index 805373f..535d785 100644
--- a/main.c
+++ b/main.c
@@ -38,37 +38,37 @@
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
  * list traversals just rcu-locked */
-struct list_head hardif_list;
+struct list_head batadv_hardif_list;
 static int (*recv_packet_handler[256])(struct sk_buff *, struct hard_iface *);
-char bat_routing_algo[20] = "BATMAN_IV";
+char batadv_routing_algo[20] = "BATMAN_IV";
 static struct hlist_head bat_algo_list;
 
-unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+unsigned char batadv_broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-struct workqueue_struct *bat_event_workqueue;
+struct workqueue_struct *batadv_event_workqueue;
 
 static void recv_handler_init(void);
 
 static int __init batman_init(void)
 {
-	INIT_LIST_HEAD(&hardif_list);
+	INIT_LIST_HEAD(&batadv_hardif_list);
 	INIT_HLIST_HEAD(&bat_algo_list);
 
 	recv_handler_init();
 
-	bat_iv_init();
+	batadv_iv_init();
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
-	bat_event_workqueue = create_singlethread_workqueue("bat_events");
+	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
 
-	if (!bat_event_workqueue)
+	if (!batadv_event_workqueue)
 		return -ENOMEM;
 
-	bat_socket_init();
-	debugfs_init();
+	batadv_socket_init();
+	batadv_debugfs_init();
 
-	register_netdevice_notifier(&hard_if_notifier);
+	register_netdevice_notifier(&batadv_hard_if_notifier);
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
 		SOURCE_VERSION, COMPAT_VERSION);
@@ -78,18 +78,18 @@ static int __init batman_init(void)
 
 static void __exit batman_exit(void)
 {
-	debugfs_destroy();
-	unregister_netdevice_notifier(&hard_if_notifier);
-	hardif_remove_interfaces();
+	batadv_debugfs_destroy();
+	unregister_netdevice_notifier(&batadv_hard_if_notifier);
+	batadv_hardif_remove_interfaces();
 
-	flush_workqueue(bat_event_workqueue);
-	destroy_workqueue(bat_event_workqueue);
-	bat_event_workqueue = NULL;
+	flush_workqueue(batadv_event_workqueue);
+	destroy_workqueue(batadv_event_workqueue);
+	batadv_event_workqueue = NULL;
 
 	rcu_barrier();
 }
 
-int mesh_init(struct net_device *soft_iface)
+int batadv_mesh_init(struct net_device *soft_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	int ret;
@@ -111,21 +111,21 @@ int mesh_init(struct net_device *soft_iface)
 	INIT_LIST_HEAD(&bat_priv->tt_req_list);
 	INIT_LIST_HEAD(&bat_priv->tt_roam_list);
 
-	ret = originator_init(bat_priv);
+	ret = batadv_originator_init(bat_priv);
 	if (ret < 0)
 		goto err;
 
-	ret = tt_init(bat_priv);
+	ret = batadv_tt_init(bat_priv);
 	if (ret < 0)
 		goto err;
 
-	tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
+	batadv_tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
 
-	ret = vis_init(bat_priv);
+	ret = batadv_vis_init(bat_priv);
 	if (ret < 0)
 		goto err;
 
-	ret = bla_init(bat_priv);
+	ret = batadv_bla_init(bat_priv);
 	if (ret < 0)
 		goto err;
 
@@ -135,48 +135,48 @@ int mesh_init(struct net_device *soft_iface)
 	return 0;
 
 err:
-	mesh_free(soft_iface);
+	batadv_mesh_free(soft_iface);
 	return ret;
 }
 
-void mesh_free(struct net_device *soft_iface)
+void batadv_mesh_free(struct net_device *soft_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 
 	atomic_set(&bat_priv->mesh_state, MESH_DEACTIVATING);
 
-	purge_outstanding_packets(bat_priv, NULL);
+	batadv_purge_outstanding_packets(bat_priv, NULL);
 
-	vis_quit(bat_priv);
+	batadv_vis_quit(bat_priv);
 
-	gw_node_purge(bat_priv);
-	originator_free(bat_priv);
+	batadv_gw_node_purge(bat_priv);
+	batadv_originator_free(bat_priv);
 
-	tt_free(bat_priv);
+	batadv_tt_free(bat_priv);
 
-	bla_free(bat_priv);
+	batadv_bla_free(bat_priv);
 
 	free_percpu(bat_priv->bat_counters);
 
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 }
 
-void inc_module_count(void)
+void batadv_inc_module_count(void)
 {
 	try_module_get(THIS_MODULE);
 }
 
-void dec_module_count(void)
+void batadv_dec_module_count(void)
 {
 	module_put(THIS_MODULE);
 }
 
-int is_my_mac(const uint8_t *addr)
+int batadv_is_my_mac(const uint8_t *addr)
 {
 	const struct hard_iface *hard_iface;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->if_status != IF_ACTIVE)
 			continue;
 
@@ -198,8 +198,9 @@ static int recv_unhandled_packet(struct sk_buff *skb,
 /* incoming packets with the batman ethertype received on any active hard
  * interface
  */
-int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
-		    struct packet_type *ptype, struct net_device *orig_dev)
+int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
+			   struct packet_type *ptype,
+			   struct net_device *orig_dev)
 {
 	struct bat_priv *bat_priv;
 	struct batman_ogm_packet *batman_ogm_packet;
@@ -272,26 +273,26 @@ static void recv_handler_init(void)
 		recv_packet_handler[i] = recv_unhandled_packet;
 
 	/* batman icmp packet */
-	recv_packet_handler[BAT_ICMP] = recv_icmp_packet;
+	recv_packet_handler[BAT_ICMP] = batadv_recv_icmp_packet;
 	/* unicast with 4 addresses packet */
-	recv_packet_handler[BAT_UNICAST_4ADDR] = recv_unicast_packet;
+	recv_packet_handler[BAT_UNICAST_4ADDR] = batadv_recv_unicast_packet;
 	/* unicast packet */
-	recv_packet_handler[BAT_UNICAST] = recv_unicast_packet;
+	recv_packet_handler[BAT_UNICAST] = batadv_recv_unicast_packet;
 	/* fragmented unicast packet */
-	recv_packet_handler[BAT_UNICAST_FRAG] = recv_ucast_frag_packet;
+	recv_packet_handler[BAT_UNICAST_FRAG] = batadv_recv_ucast_frag_packet;
 	/* broadcast packet */
-	recv_packet_handler[BAT_BCAST] = recv_bcast_packet;
+	recv_packet_handler[BAT_BCAST] = batadv_recv_bcast_packet;
 	/* vis packet */
-	recv_packet_handler[BAT_VIS] = recv_vis_packet;
+	recv_packet_handler[BAT_VIS] = batadv_recv_vis_packet;
 	/* Translation table query (request or response) */
-	recv_packet_handler[BAT_TT_QUERY] = recv_tt_query;
+	recv_packet_handler[BAT_TT_QUERY] = batadv_recv_tt_query;
 	/* Roaming advertisement */
-	recv_packet_handler[BAT_ROAM_ADV] = recv_roam_adv;
+	recv_packet_handler[BAT_ROAM_ADV] = batadv_recv_roam_adv;
 }
 
-int recv_handler_register(uint8_t packet_type,
-			  int (*recv_handler)(struct sk_buff *,
-					      struct hard_iface *))
+int batadv_recv_handler_register(uint8_t packet_type,
+				 int (*recv_handler)(struct sk_buff *,
+						     struct hard_iface *))
 {
 	if (recv_packet_handler[packet_type] != &recv_unhandled_packet)
 		return -EBUSY;
@@ -300,7 +301,7 @@ int recv_handler_register(uint8_t packet_type,
 	return 0;
 }
 
-void recv_handler_unregister(uint8_t packet_type)
+void batadv_recv_handler_unregister(uint8_t packet_type)
 {
 	recv_packet_handler[packet_type] = recv_unhandled_packet;
 }
@@ -321,7 +322,7 @@ static struct bat_algo_ops *bat_algo_get(char *name)
 	return bat_algo_ops;
 }
 
-int bat_algo_register(struct bat_algo_ops *bat_algo_ops)
+int batadv_algo_register(struct bat_algo_ops *bat_algo_ops)
 {
 	struct bat_algo_ops *bat_algo_ops_tmp;
 	int ret;
@@ -355,7 +356,7 @@ out:
 	return ret;
 }
 
-int bat_algo_select(struct bat_priv *bat_priv, char *name)
+int batadv_algo_select(struct bat_priv *bat_priv, char *name)
 {
 	struct bat_algo_ops *bat_algo_ops;
 	int ret = -EINVAL;
@@ -371,7 +372,7 @@ out:
 	return ret;
 }
 
-int bat_algo_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct bat_algo_ops *bat_algo_ops;
 	struct hlist_node *node;
@@ -409,8 +410,8 @@ static const struct kernel_param_ops param_ops_ra = {
 };
 
 static struct kparam_string __param_string_ra = {
-	.maxlen = sizeof(bat_routing_algo),
-	.string = bat_routing_algo,
+	.maxlen = sizeof(batadv_routing_algo),
+	.string = batadv_routing_algo,
 };
 
 module_param_cb(routing_algo, &param_ops_ra, &__param_string_ra, 0644);
diff --git a/main.h b/main.h
index a94ceae..b15cd94 100644
--- a/main.h
+++ b/main.h
@@ -160,34 +160,36 @@ enum dbg_level {
 
 #include "types.h"
 
-extern char bat_routing_algo[];
-extern struct list_head hardif_list;
-
-extern unsigned char broadcast_addr[];
-extern struct workqueue_struct *bat_event_workqueue;
-
-int mesh_init(struct net_device *soft_iface);
-void mesh_free(struct net_device *soft_iface);
-void inc_module_count(void);
-void dec_module_count(void);
-int is_my_mac(const uint8_t *addr);
-int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
-		    struct packet_type *ptype, struct net_device *orig_dev);
-int recv_handler_register(uint8_t packet_type,
-			  int (*recv_handler)(struct sk_buff *,
-					      struct hard_iface *));
-void recv_handler_unregister(uint8_t packet_type);
-int bat_algo_register(struct bat_algo_ops *bat_algo_ops);
-int bat_algo_select(struct bat_priv *bat_priv, char *name);
-int bat_algo_seq_print_text(struct seq_file *seq, void *offset);
+extern char batadv_routing_algo[];
+extern struct list_head batadv_hardif_list;
+
+extern unsigned char batadv_broadcast_addr[];
+extern struct workqueue_struct *batadv_event_workqueue;
+
+int batadv_mesh_init(struct net_device *soft_iface);
+void batadv_mesh_free(struct net_device *soft_iface);
+void batadv_inc_module_count(void);
+void batadv_dec_module_count(void);
+int batadv_is_my_mac(const uint8_t *addr);
+int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
+			   struct packet_type *ptype,
+			   struct net_device *orig_dev);
+int batadv_recv_handler_register(uint8_t packet_type,
+				 int (*recv_handler)(struct sk_buff *,
+						     struct hard_iface *));
+void batadv_recv_handler_unregister(uint8_t packet_type);
+int batadv_algo_register(struct bat_algo_ops *bat_algo_ops);
+int batadv_algo_select(struct bat_priv *bat_priv, char *name);
+int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-int debug_log(struct bat_priv *bat_priv, const char *fmt, ...) __printf(2, 3);
+int batadv_debug_log(struct bat_priv *bat_priv, const char *fmt, ...)
+__printf(2, 3);
 
 #define bat_dbg(type, bat_priv, fmt, arg...)			\
 	do {							\
 		if (atomic_read(&bat_priv->log_level) & type)	\
-			debug_log(bat_priv, fmt, ## arg);	\
+			batadv_debug_log(bat_priv, fmt, ## arg);\
 	}							\
 	while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
diff --git a/originator.c b/originator.c
index c17dc0c..93d5b2b 100644
--- a/originator.c
+++ b/originator.c
@@ -36,7 +36,7 @@ static void purge_orig(struct work_struct *work);
 static void start_purge_timer(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->orig_work, purge_orig);
-	queue_delayed_work(bat_event_workqueue,
+	queue_delayed_work(batadv_event_workqueue,
 			   &bat_priv->orig_work, msecs_to_jiffies(1000));
 }
 
@@ -48,12 +48,12 @@ static int compare_orig(const struct hlist_node *node, const void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
-int originator_init(struct bat_priv *bat_priv)
+int batadv_originator_init(struct bat_priv *bat_priv)
 {
 	if (bat_priv->orig_hash)
 		return 0;
 
-	bat_priv->orig_hash = hash_new(1024);
+	bat_priv->orig_hash = batadv_hash_new(1024);
 
 	if (!bat_priv->orig_hash)
 		goto err;
@@ -65,14 +65,14 @@ err:
 	return -ENOMEM;
 }
 
-void neigh_node_free_ref(struct neigh_node *neigh_node)
+void batadv_neigh_node_free_ref(struct neigh_node *neigh_node)
 {
 	if (atomic_dec_and_test(&neigh_node->refcount))
 		kfree_rcu(neigh_node, rcu);
 }
 
 /* increases the refcounter of a found router */
-struct neigh_node *orig_node_get_router(struct orig_node *orig_node)
+struct neigh_node *batadv_orig_node_get_router(struct orig_node *orig_node)
 {
 	struct neigh_node *router;
 
@@ -127,21 +127,21 @@ static void orig_node_free_rcu(struct rcu_head *rcu)
 	list_for_each_entry_safe(neigh_node, tmp_neigh_node,
 				 &orig_node->bond_list, bonding_list) {
 		list_del_rcu(&neigh_node->bonding_list);
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	}
 
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
 				  &orig_node->neigh_list, list) {
 		hlist_del_rcu(&neigh_node->list);
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	}
 
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
-	frag_list_free(&orig_node->frag_list);
-	tt_global_del_orig(orig_node->bat_priv, orig_node,
-			   "originator timed out");
+	batadv_frag_list_free(&orig_node->frag_list);
+	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
+				  "originator timed out");
 
 	kfree(orig_node->tt_buff);
 	kfree(orig_node->bcast_own);
@@ -149,13 +149,13 @@ static void orig_node_free_rcu(struct rcu_head *rcu)
 	kfree(orig_node);
 }
 
-void orig_node_free_ref(struct orig_node *orig_node)
+void batadv_orig_node_free_ref(struct orig_node *orig_node)
 {
 	if (atomic_dec_and_test(&orig_node->refcount))
 		call_rcu(&orig_node->rcu, orig_node_free_rcu);
 }
 
-void originator_free(struct bat_priv *bat_priv)
+void batadv_originator_free(struct bat_priv *bat_priv)
 {
 	struct hashtable_t *hash = bat_priv->orig_hash;
 	struct hlist_node *node, *node_tmp;
@@ -180,17 +180,18 @@ void originator_free(struct bat_priv *bat_priv)
 					  head, hash_entry) {
 
 			hlist_del_rcu(node);
-			orig_node_free_ref(orig_node);
+			batadv_orig_node_free_ref(orig_node);
 		}
 		spin_unlock_bh(list_lock);
 	}
 
-	hash_destroy(hash);
+	 batadv_hash_destroy(hash);
 }
 
 /* this function finds or creates an originator entry for the given
  * address if it does not exits */
-struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
+struct orig_node *batadv_get_orig_node(struct bat_priv *bat_priv,
+				       const uint8_t *addr)
 {
 	struct orig_node *orig_node;
 	int size;
@@ -221,7 +222,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
-	dat_init_orig_node_dht_addr(orig_node);
+	batadv_dat_init_orig_node_dht_addr(orig_node);
 	orig_node->router = NULL;
 	orig_node->tt_crc = 0;
 	atomic_set(&orig_node->last_ttvn, 0);
@@ -308,8 +309,8 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 			neigh_purged = true;
 
 			hlist_del_rcu(&neigh_node->list);
-			bonding_candidate_del(orig_node, neigh_node);
-			neigh_node_free_ref(neigh_node);
+			batadv_bonding_candidate_del(orig_node, neigh_node);
+			batadv_neigh_node_free_ref(neigh_node);
 		} else {
 			if ((!*best_neigh_node) ||
 			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
@@ -335,7 +336,8 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 	} else {
 		if (purge_orig_neighbors(bat_priv, orig_node,
 					 &best_neigh_node))
-			update_route(bat_priv, orig_node, best_neigh_node);
+			batadv_update_route(bat_priv, orig_node,
+					    best_neigh_node);
 	}
 
 	return false;
@@ -363,21 +365,22 @@ static void _purge_orig(struct bat_priv *bat_priv)
 					  head, hash_entry) {
 			if (purge_orig_node(bat_priv, orig_node)) {
 				if (orig_node->gw_flags)
-					gw_node_delete(bat_priv, orig_node);
+					batadv_gw_node_delete(bat_priv,
+							      orig_node);
 				hlist_del_rcu(node);
-				orig_node_free_ref(orig_node);
+				batadv_orig_node_free_ref(orig_node);
 				continue;
 			}
 
 			if (has_timed_out(orig_node->last_frag_packet,
 					  FRAG_TIMEOUT))
-				frag_list_free(&orig_node->frag_list);
+				batadv_frag_list_free(&orig_node->frag_list);
 		}
 		spin_unlock_bh(list_lock);
 	}
 
-	gw_node_purge(bat_priv);
-	gw_election(bat_priv);
+	batadv_gw_node_purge(bat_priv);
+	batadv_gw_election(bat_priv);
 }
 
 static void purge_orig(struct work_struct *work)
@@ -391,12 +394,12 @@ static void purge_orig(struct work_struct *work)
 	start_purge_timer(bat_priv);
 }
 
-void purge_orig_ref(struct bat_priv *bat_priv)
+void batadv_purge_orig_ref(struct bat_priv *bat_priv)
 {
 	_purge_orig(bat_priv);
 }
 
-int orig_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -440,7 +443,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-			neigh_node = orig_node_get_router(orig_node);
+			neigh_node = batadv_orig_node_get_router(orig_node);
 			if (!neigh_node)
 				continue;
 
@@ -469,7 +472,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 			batman_count++;
 
 next:
-			neigh_node_free_ref(neigh_node);
+			batadv_neigh_node_free_ref(neigh_node);
 		}
 		rcu_read_unlock();
 	}
@@ -509,7 +512,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	return 0;
 }
 
-int orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num)
+int batadv_orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct hashtable_t *hash = bat_priv->orig_hash;
@@ -591,7 +594,7 @@ free_own_sum:
 	return 0;
 }
 
-int orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num)
+int batadv_orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct hashtable_t *hash = bat_priv->orig_hash;
@@ -622,7 +625,7 @@ int orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num)
 
 	/* renumber remaining batman interfaces _inside_ of orig_hash_lock */
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface_tmp, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface_tmp, &batadv_hardif_list, list) {
 		if (hard_iface_tmp->if_status == IF_NOT_IN_USE)
 			continue;
 
diff --git a/originator.h b/originator.h
index f74d0d6..97deeba 100644
--- a/originator.h
+++ b/originator.h
@@ -24,19 +24,20 @@
 
 #include "hash.h"
 
-int originator_init(struct bat_priv *bat_priv);
-void originator_free(struct bat_priv *bat_priv);
-void purge_orig_ref(struct bat_priv *bat_priv);
-void orig_node_free_ref(struct orig_node *orig_node);
-struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr);
+int batadv_originator_init(struct bat_priv *bat_priv);
+void batadv_originator_free(struct bat_priv *bat_priv);
+void batadv_purge_orig_ref(struct bat_priv *bat_priv);
+void batadv_orig_node_free_ref(struct orig_node *orig_node);
+struct orig_node *batadv_get_orig_node(struct bat_priv *bat_priv,
+				       const uint8_t *addr);
 struct neigh_node *batadv_neigh_node_new(struct hard_iface *hard_iface,
 					 const uint8_t *neigh_addr,
 					 uint32_t seqno);
-void neigh_node_free_ref(struct neigh_node *neigh_node);
-struct neigh_node *orig_node_get_router(struct orig_node *orig_node);
-int orig_seq_print_text(struct seq_file *seq, void *offset);
-int orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num);
-int orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num);
+void batadv_neigh_node_free_ref(struct neigh_node *neigh_node);
+struct neigh_node *batadv_orig_node_get_router(struct orig_node *orig_node);
+int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_orig_hash_add_if(struct hard_iface *hard_iface, int max_if_num);
+int batadv_orig_hash_del_if(struct hard_iface *hard_iface, int max_if_num);
 
 
 /* hashfunction to choose an entry in a hash table of given size */
diff --git a/ring_buffer.c b/ring_buffer.c
index fd63951..db8f5ef 100644
--- a/ring_buffer.c
+++ b/ring_buffer.c
@@ -22,13 +22,14 @@
 #include "main.h"
 #include "ring_buffer.h"
 
-void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value)
+void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
+			    uint8_t value)
 {
 	lq_recv[*lq_index] = value;
 	*lq_index = (*lq_index + 1) % TQ_GLOBAL_WINDOW_SIZE;
 }
 
-uint8_t ring_buffer_avg(const uint8_t lq_recv[])
+uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 {
 	const uint8_t *ptr;
 	uint16_t count = 0, i = 0, sum = 0;
diff --git a/ring_buffer.h b/ring_buffer.h
index 8b58bd8..fbaf9d2 100644
--- a/ring_buffer.h
+++ b/ring_buffer.h
@@ -22,7 +22,8 @@
 #ifndef _NET_BATMAN_ADV_RING_BUFFER_H_
 #define _NET_BATMAN_ADV_RING_BUFFER_H_
 
-void ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index, uint8_t value);
-uint8_t ring_buffer_avg(const uint8_t lq_recv[]);
+void batadv_ring_buffer_set(uint8_t lq_recv[], uint8_t *lq_index,
+			    uint8_t value);
+uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[]);
 
 #endif /* _NET_BATMAN_ADV_RING_BUFFER_H_ */
diff --git a/routing.c b/routing.c
index 9beb2e2..c708cf5 100644
--- a/routing.c
+++ b/routing.c
@@ -34,7 +34,7 @@
 static int route_unicast_packet(struct sk_buff *skb,
 				struct hard_iface *recv_if);
 
-void slide_own_bcast_window(struct hard_iface *hard_iface)
+void batadv_slide_own_bcast_window(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct hashtable_t *hash = bat_priv->orig_hash;
@@ -54,7 +54,7 @@ void slide_own_bcast_window(struct hard_iface *hard_iface)
 			word_index = hard_iface->if_num * NUM_WORDS;
 			word = &(orig_node->bcast_own[word_index]);
 
-			bit_get_packet(bat_priv, word, 1, 0);
+			batadv_bit_get_packet(bat_priv, word, 1, 0);
 			orig_node->bcast_own_sum[hard_iface->if_num] =
 				bitmap_weight(word, TQ_LOCAL_WINDOW_SIZE);
 			spin_unlock_bh(&orig_node->ogm_cnt_lock);
@@ -69,14 +69,14 @@ static void _update_route(struct bat_priv *bat_priv,
 {
 	struct neigh_node *curr_router;
 
-	curr_router = orig_node_get_router(orig_node);
+	curr_router = batadv_orig_node_get_router(orig_node);
 
 	/* route deleted */
 	if ((curr_router) && (!neigh_node)) {
 		bat_dbg(DBG_ROUTES, bat_priv, "Deleting route towards: %pM\n",
 			orig_node->orig);
-		tt_global_del_orig(bat_priv, orig_node,
-				   "Deleted route towards originator");
+		batadv_tt_global_del_orig(bat_priv, orig_node,
+					  "Deleted route towards originator");
 
 	/* route added */
 	} else if ((!curr_router) && (neigh_node)) {
@@ -93,7 +93,7 @@ static void _update_route(struct bat_priv *bat_priv,
 	}
 
 	if (curr_router)
-		neigh_node_free_ref(curr_router);
+		batadv_neigh_node_free_ref(curr_router);
 
 	/* increase refcount of new best neighbor */
 	if (neigh_node && !atomic_inc_not_zero(&neigh_node->refcount))
@@ -105,30 +105,30 @@ static void _update_route(struct bat_priv *bat_priv,
 
 	/* decrease refcount of previous best neighbor */
 	if (curr_router)
-		neigh_node_free_ref(curr_router);
+		batadv_neigh_node_free_ref(curr_router);
 }
 
-void update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		  struct neigh_node *neigh_node)
+void batadv_update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
+			 struct neigh_node *neigh_node)
 {
 	struct neigh_node *router = NULL;
 
 	if (!orig_node)
 		goto out;
 
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 
 	if (router != neigh_node)
 		_update_route(bat_priv, orig_node, neigh_node);
 
 out:
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 }
 
 /* caller must hold the neigh_list_lock */
-void bonding_candidate_del(struct orig_node *orig_node,
-			   struct neigh_node *neigh_node)
+void batadv_bonding_candidate_del(struct orig_node *orig_node,
+				  struct neigh_node *neigh_node)
 {
 	/* this neighbor is not part of our candidate list */
 	if (list_empty(&neigh_node->bonding_list))
@@ -136,15 +136,15 @@ void bonding_candidate_del(struct orig_node *orig_node,
 
 	list_del_rcu(&neigh_node->bonding_list);
 	INIT_LIST_HEAD(&neigh_node->bonding_list);
-	neigh_node_free_ref(neigh_node);
+	batadv_neigh_node_free_ref(neigh_node);
 	atomic_dec(&orig_node->bond_candidates);
 
 out:
 	return;
 }
 
-void bonding_candidate_add(struct orig_node *orig_node,
-			   struct neigh_node *neigh_node)
+void batadv_bonding_candidate_add(struct orig_node *orig_node,
+				  struct neigh_node *neigh_node)
 {
 	struct hlist_node *node;
 	struct neigh_node *tmp_neigh_node, *router = NULL;
@@ -157,7 +157,7 @@ void bonding_candidate_add(struct orig_node *orig_node,
 			 neigh_node->orig_node->primary_addr))
 		goto candidate_del;
 
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 	if (!router)
 		goto candidate_del;
 
@@ -204,19 +204,20 @@ void bonding_candidate_add(struct orig_node *orig_node,
 	goto out;
 
 candidate_del:
-	bonding_candidate_del(orig_node, neigh_node);
+	batadv_bonding_candidate_del(orig_node, neigh_node);
 
 out:
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 }
 
 /* copy primary address for bonding */
-void bonding_save_primary(const struct orig_node *orig_node,
-			  struct orig_node *orig_neigh_node,
-			  const struct batman_ogm_packet *batman_ogm_packet)
+void
+batadv_bonding_save_primary(const struct orig_node *orig_node,
+			    struct orig_node *orig_neigh_node,
+			    const struct batman_ogm_packet *batman_ogm_packet)
 {
 	if (!(batman_ogm_packet->flags & PRIMARIES_FIRST_HOP))
 		return;
@@ -229,8 +230,8 @@ void bonding_save_primary(const struct orig_node *orig_node,
  *  0 if the packet is to be accepted
  *  1 if the packet is to be ignored.
  */
-int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
-		     unsigned long *last_reset)
+int batadv_window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
+			    unsigned long *last_reset)
 {
 	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE) ||
 	    (seq_num_diff >= EXPECTED_SEQNO_RANGE)) {
@@ -245,9 +246,9 @@ int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
 	return 0;
 }
 
-bool check_management_packet(struct sk_buff *skb,
-			     struct hard_iface *hard_iface,
-			     int header_len)
+bool batadv_check_management_packet(struct sk_buff *skb,
+				    struct hard_iface *hard_iface,
+				    int header_len)
 {
 	struct ethhdr *ethhdr;
 
@@ -289,7 +290,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		bat_socket_receive_packet(icmp_packet, icmp_len);
+		batadv_socket_receive_packet(icmp_packet, icmp_len);
 		goto out;
 	}
 
@@ -303,7 +304,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 	if (!router)
 		goto out;
 
@@ -318,16 +319,16 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	icmp_packet->msg_type = ECHO_REPLY;
 	icmp_packet->header.ttl = TTL;
 
-	send_skb_packet(skb, router->if_incoming, router->addr);
+	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 	ret = NET_RX_SUCCESS;
 
 out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -358,7 +359,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 	if (!router)
 		goto out;
 
@@ -373,21 +374,21 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	icmp_packet->msg_type = TTL_EXCEEDED;
 	icmp_packet->header.ttl = TTL;
 
-	send_skb_packet(skb, router->if_incoming, router->addr);
+	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 	ret = NET_RX_SUCCESS;
 
 out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
 
 
-int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct icmp_packet_rr *icmp_packet;
@@ -418,7 +419,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	/* not for me */
-	if (!is_my_mac(ethhdr->h_dest))
+	if (!batadv_is_my_mac(ethhdr->h_dest))
 		goto out;
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
@@ -432,7 +433,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	}
 
 	/* packet for me */
-	if (is_my_mac(icmp_packet->dst))
+	if (batadv_is_my_mac(icmp_packet->dst))
 		return recv_my_icmp_packet(bat_priv, skb, hdr_size);
 
 	/* TTL exceeded */
@@ -444,7 +445,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (!orig_node)
 		goto out;
 
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 	if (!router)
 		goto out;
 
@@ -458,14 +459,14 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	icmp_packet->header.ttl--;
 
 	/* route it */
-	send_skb_packet(skb, router->if_incoming, router->addr);
+	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 	ret = NET_RX_SUCCESS;
 
 out:
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -551,13 +552,13 @@ static struct neigh_node *find_ifalter_router(struct orig_node *primary_orig,
 			/* decrement refcount of
 			 * previously selected router */
 			if (router)
-				neigh_node_free_ref(router);
+				batadv_neigh_node_free_ref(router);
 
 			router = tmp_neigh_node;
 			atomic_inc_not_zero(&router->refcount);
 		}
 
-		neigh_node_free_ref(tmp_neigh_node);
+		batadv_neigh_node_free_ref(tmp_neigh_node);
 	}
 
 	/* use the first candidate if nothing was found. */
@@ -569,7 +570,7 @@ static struct neigh_node *find_ifalter_router(struct orig_node *primary_orig,
 	return router;
 }
 
-int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct tt_query_packet *tt_query;
@@ -602,7 +603,7 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 		/* If we cannot provide an answer the tt_request is
 		 * forwarded */
-		if (!send_tt_response(bat_priv, tt_query)) {
+		if (!batadv_send_tt_response(bat_priv, tt_query)) {
 			bat_dbg(DBG_TT, bat_priv,
 				"Routing TT_REQUEST to %pM [%c]\n",
 				tt_query->dst,
@@ -613,20 +614,20 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 	case TT_RESPONSE:
 		inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_RX);
 
-		if (is_my_mac(tt_query->dst)) {
+		if (batadv_is_my_mac(tt_query->dst)) {
 			/* packet needs to be linearized to access the TT
 			 * changes */
 			if (skb_linearize(skb) < 0)
 				goto out;
 
-			tt_size = tt_len(ntohs(tt_query->tt_data));
+			tt_size = batadv_tt_len(ntohs(tt_query->tt_data));
 
 			/* Ensure we have all the claimed data */
 			if (unlikely(skb_headlen(skb) <
 				     sizeof(struct tt_query_packet) + tt_size))
 				goto out;
 
-			handle_tt_response(bat_priv, tt_query);
+			batadv_handle_tt_response(bat_priv, tt_query);
 		} else {
 			bat_dbg(DBG_TT, bat_priv,
 				"Routing TT_RESPONSE to %pM [%c]\n",
@@ -642,7 +643,7 @@ out:
 	return NET_RX_DROP;
 }
 
-int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct roam_adv_packet *roam_adv_packet;
@@ -667,14 +668,14 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	roam_adv_packet = (struct roam_adv_packet *)skb->data;
 
-	if (!is_my_mac(roam_adv_packet->dst))
+	if (!batadv_is_my_mac(roam_adv_packet->dst))
 		return route_unicast_packet(skb, recv_if);
 
 	/* check if it is a backbone gateway. we don't accept
 	 * roaming advertisement from it, as it has the same
 	 * entries as we have.
 	 */
-	if (bla_is_backbone_gw_orig(bat_priv, roam_adv_packet->src))
+	if (batadv_bla_is_backbone_gw_orig(bat_priv, roam_adv_packet->src))
 		goto out;
 
 	orig_node = orig_hash_find(bat_priv, roam_adv_packet->src);
@@ -685,15 +686,16 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 		"Received ROAMING_ADV from %pM (client %pM)\n",
 		roam_adv_packet->src, roam_adv_packet->client);
 
-	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
-		      atomic_read(&orig_node->last_ttvn) + 1, true, false);
+	batadv_tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
+			     atomic_read(&orig_node->last_ttvn) + 1, true,
+			     false);
 
 	/* Roaming phase starts: I have new information but the ttvn has not
 	 * been incremented yet. This flag will make me check all the incoming
 	 * packets for the correct destination. */
 	bat_priv->tt_poss_change = true;
 
-	orig_node_free_ref(orig_node);
+	batadv_orig_node_free_ref(orig_node);
 out:
 	/* returning NET_RX_DROP will make the caller function kfree the skb */
 	return NET_RX_DROP;
@@ -702,9 +704,9 @@ out:
 /* find a suitable router for this originator, and use
  * bonding if possible. increases the found neighbors
  * refcount.*/
-struct neigh_node *find_router(struct bat_priv *bat_priv,
-			       struct orig_node *orig_node,
-			       const struct hard_iface *recv_if)
+struct neigh_node *batadv_find_router(struct bat_priv *bat_priv,
+				      struct orig_node *orig_node,
+				      const struct hard_iface *recv_if)
 {
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
@@ -715,7 +717,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	if (!orig_node)
 		return NULL;
 
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 	if (!router)
 		goto err;
 
@@ -748,7 +750,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		if (!primary_orig_node)
 			goto return_router;
 
-		orig_node_free_ref(primary_orig_node);
+		batadv_orig_node_free_ref(primary_orig_node);
 	}
 
 	/* with less than 2 candidates, we can't do any
@@ -760,7 +762,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	 * is is not on the interface where the packet came
 	 * in. */
 
-	neigh_node_free_ref(router);
+	batadv_neigh_node_free_ref(router);
 
 	if (bonding_enabled)
 		router = find_bond_router(primary_orig_node, recv_if);
@@ -777,7 +779,7 @@ err_unlock:
 	rcu_read_unlock();
 err:
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 	return NULL;
 }
 
@@ -800,7 +802,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 		return -1;
 
 	/* not for me */
-	if (!is_my_mac(ethhdr->h_dest))
+	if (!batadv_is_my_mac(ethhdr->h_dest))
 		return -1;
 
 	return 0;
@@ -832,7 +834,7 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	/* find_router() increases neigh_nodes refcount if found. */
-	neigh_node = find_router(bat_priv, orig_node, recv_if);
+	neigh_node = batadv_find_router(bat_priv, orig_node, recv_if);
 
 	if (!neigh_node)
 		goto out;
@@ -846,15 +848,16 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (unicast_packet->header.packet_type == BAT_UNICAST &&
 	    atomic_read(&bat_priv->fragmentation) &&
 	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
-		ret = frag_send_skb(skb, bat_priv,
-				    neigh_node->if_incoming, neigh_node->addr);
+		ret = batadv_frag_send_skb(skb, bat_priv,
+					   neigh_node->if_incoming,
+					   neigh_node->addr);
 		goto out;
 	}
 
 	if (unicast_packet->header.packet_type == BAT_UNICAST_FRAG &&
 	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
 
-		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
+		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
 
 		if (ret == NET_RX_DROP)
 			goto out;
@@ -877,14 +880,14 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	add_counter(bat_priv, BAT_CNT_FORWARD_BYTES, skb->len + ETH_HLEN);
 
 	/* route it */
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
 
 out:
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
 
@@ -903,7 +906,7 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	if (is_my_mac(unicast_packet->dest)) {
+	if (batadv_is_my_mac(unicast_packet->dest)) {
 		tt_poss_change = bat_priv->tt_poss_change;
 		curr_ttvn = (uint8_t)atomic_read(&bat_priv->ttvn);
 	} else {
@@ -914,7 +917,7 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
 		curr_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 		tt_poss_change = orig_node->tt_poss_change;
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	}
 
 	/* Check whether I have to reroute the packet */
@@ -929,13 +932,15 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
 		/* we don't have an updated route for this client, so we should
 		 * not try to reroute the packet!! */
-		if (tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
+		if (batadv_tt_global_client_is_roaming(bat_priv,
+						       ethhdr->h_dest))
 			return 1;
 
-		orig_node = transtable_search(bat_priv, NULL, ethhdr->h_dest);
+		orig_node = batadv_transtable_search(bat_priv, NULL,
+						     ethhdr->h_dest);
 
 		if (!orig_node) {
-			if (!is_my_client(bat_priv, ethhdr->h_dest))
+			if (!batadv_is_my_client(bat_priv, ethhdr->h_dest))
 				return 0;
 			primary_if = primary_if_get_selected(bat_priv);
 			if (!primary_if)
@@ -948,7 +953,7 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 			       ETH_ALEN);
 			curr_ttvn = (uint8_t)
 				atomic_read(&orig_node->last_ttvn);
-			orig_node_free_ref(orig_node);
+			batadv_orig_node_free_ref(orig_node);
 		}
 
 		bat_dbg(DBG_ROUTES, bat_priv,
@@ -961,7 +966,7 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 	return 1;
 }
 
-int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_packet *unicast_packet;
@@ -980,15 +985,17 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		return NET_RX_DROP;
 
 	/* packet for me */
-	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+	if (batadv_is_my_mac(unicast_packet->dest)) {
+		batadv_interface_rx(recv_if->soft_iface, skb, recv_if,
+				    hdr_size);
 		return NET_RX_SUCCESS;
 	}
 
 	return route_unicast_packet(skb, recv_if);
 }
 
-int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
+				  struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_frag_packet *unicast_packet;
@@ -1005,9 +1012,9 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	unicast_packet = (struct unicast_frag_packet *)skb->data;
 
 	/* packet for me */
-	if (is_my_mac(unicast_packet->dest)) {
+	if (batadv_is_my_mac(unicast_packet->dest)) {
 
-		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
+		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
 
 		if (ret == NET_RX_DROP)
 			return NET_RX_DROP;
@@ -1016,8 +1023,8 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		if (!new_skb)
 			return NET_RX_SUCCESS;
 
-		interface_rx(recv_if->soft_iface, new_skb, recv_if,
-			     sizeof(struct unicast_packet));
+		batadv_interface_rx(recv_if->soft_iface, new_skb, recv_if,
+				    sizeof(struct unicast_packet));
 		return NET_RX_SUCCESS;
 	}
 
@@ -1025,7 +1032,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 }
 
 
-int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node = NULL;
@@ -1050,13 +1057,13 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	/* ignore broadcasts sent by myself */
-	if (is_my_mac(ethhdr->h_source))
+	if (batadv_is_my_mac(ethhdr->h_source))
 		goto out;
 
 	bcast_packet = (struct bcast_packet *)skb->data;
 
 	/* ignore broadcasts originated by myself */
-	if (is_my_mac(bcast_packet->orig))
+	if (batadv_is_my_mac(bcast_packet->orig))
 		goto out;
 
 	if (bcast_packet->header.ttl < 2)
@@ -1077,32 +1084,32 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
 
 	/* check whether the packet is old and the host just restarted. */
-	if (window_protected(bat_priv, seq_diff,
-			     &orig_node->bcast_seqno_reset))
+	if (batadv_window_protected(bat_priv, seq_diff,
+				    &orig_node->bcast_seqno_reset))
 		goto spin_unlock;
 
 	/* mark broadcast in flood history, update window position
 	 * if required. */
-	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
+	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 
 	/* check whether this has been sent by another originator before */
-	if (bla_check_bcast_duplist(bat_priv, bcast_packet, hdr_size))
+	if (batadv_bla_check_bcast_duplist(bat_priv, bcast_packet, hdr_size))
 		goto out;
 
 	/* rebroadcast packet */
-	add_bcast_packet_to_list(bat_priv, skb, 1);
+	batadv_add_bcast_packet_to_list(bat_priv, skb, 1);
 
 	/* don't hand the broadcast up if it is from an originator
 	 * from the same backbone.
 	 */
-	if (bla_is_backbone_gw(skb, orig_node, hdr_size))
+	if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))
 		goto out;
 
 	/* broadcast for me */
-	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+	batadv_interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
 	ret = NET_RX_SUCCESS;
 	goto out;
 
@@ -1110,11 +1117,11 @@ spin_unlock:
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 out:
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
 
-int recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if)
+int batadv_recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct vis_packet *vis_packet;
 	struct ethhdr *ethhdr;
@@ -1132,25 +1139,25 @@ int recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* not for me */
-	if (!is_my_mac(ethhdr->h_dest))
+	if (!batadv_is_my_mac(ethhdr->h_dest))
 		return NET_RX_DROP;
 
 	/* ignore own packets */
-	if (is_my_mac(vis_packet->vis_orig))
+	if (batadv_is_my_mac(vis_packet->vis_orig))
 		return NET_RX_DROP;
 
-	if (is_my_mac(vis_packet->sender_orig))
+	if (batadv_is_my_mac(vis_packet->sender_orig))
 		return NET_RX_DROP;
 
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
-		receive_server_sync_packet(bat_priv, vis_packet,
-					   skb_headlen(skb));
+		batadv_receive_server_sync_packet(bat_priv, vis_packet,
+						  skb_headlen(skb));
 		break;
 
 	case VIS_TYPE_CLIENT_UPDATE:
-		receive_client_update_packet(bat_priv, vis_packet,
-					     skb_headlen(skb));
+		batadv_receive_client_update_packet(bat_priv, vis_packet,
+						    skb_headlen(skb));
 		break;
 
 	default:	/* ignore unknown packet */
diff --git a/routing.h b/routing.h
index d6bbbeb..4652f0c 100644
--- a/routing.h
+++ b/routing.h
@@ -22,30 +22,32 @@
 #ifndef _NET_BATMAN_ADV_ROUTING_H_
 #define _NET_BATMAN_ADV_ROUTING_H_
 
-void slide_own_bcast_window(struct hard_iface *hard_iface);
-bool check_management_packet(struct sk_buff *skb,
-			     struct hard_iface *hard_iface,
-			     int header_len);
-void update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		  struct neigh_node *neigh_node);
-int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if);
-int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if);
-int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if);
-struct neigh_node *find_router(struct bat_priv *bat_priv,
-			       struct orig_node *orig_node,
-			       const struct hard_iface *recv_if);
-void bonding_candidate_del(struct orig_node *orig_node,
-			   struct neigh_node *neigh_node);
-void bonding_candidate_add(struct orig_node *orig_node,
-			   struct neigh_node *neigh_node);
-void bonding_save_primary(const struct orig_node *orig_node,
-			  struct orig_node *orig_neigh_node,
-			  const struct batman_ogm_packet *batman_ogm_packet);
-int window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
-		     unsigned long *last_reset);
+void batadv_slide_own_bcast_window(struct hard_iface *hard_iface);
+bool batadv_check_management_packet(struct sk_buff *skb,
+				    struct hard_iface *hard_iface,
+				    int header_len);
+void batadv_update_route(struct bat_priv *bat_priv, struct orig_node *orig_node,
+			 struct neigh_node *neigh_node);
+int batadv_recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if);
+int batadv_recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
+int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
+				  struct hard_iface *recv_if);
+int batadv_recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
+int batadv_recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if);
+int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if);
+int batadv_recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if);
+struct neigh_node *batadv_find_router(struct bat_priv *bat_priv,
+				      struct orig_node *orig_node,
+				      const struct hard_iface *recv_if);
+void batadv_bonding_candidate_del(struct orig_node *orig_node,
+				  struct neigh_node *neigh_node);
+void batadv_bonding_candidate_add(struct orig_node *orig_node,
+				  struct neigh_node *neigh_node);
+void batadv_bonding_save_primary(const struct orig_node *orig_node,
+				 struct orig_node *orig_neigh_node,
+				 const struct batman_ogm_packet
+				 *batman_ogm_packet);
+int batadv_window_protected(struct bat_priv *bat_priv, int32_t seq_num_diff,
+			    unsigned long *last_reset);
 
 #endif /* _NET_BATMAN_ADV_ROUTING_H_ */
diff --git a/send.c b/send.c
index cebc14a..adb0694 100644
--- a/send.c
+++ b/send.c
@@ -34,8 +34,8 @@ static void send_outstanding_bcast_packet(struct work_struct *work);
 
 /* send out an already prepared packet to the given address via the
  * specified batman interface */
-int send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
-		    const uint8_t *dst_addr)
+int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
+			   const uint8_t *dst_addr)
 {
 	struct ethhdr *ethhdr;
 
@@ -52,7 +52,7 @@ int send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
 	}
 
 	/* push to the ethernet header. */
-	if (my_skb_head_push(skb, ETH_HLEN) < 0)
+	if (batadv_skb_head_push(skb, ETH_HLEN) < 0)
 		goto send_skb_err;
 
 	skb_reset_mac_header(skb);
@@ -101,9 +101,12 @@ static int prepare_packet_buffer(struct bat_priv *bat_priv,
 				  struct hard_iface *hard_iface)
 {
 	int new_len;
+	uint8_t num_changes;
+	unsigned char *pos;
+	int buf_len;
 
-	new_len = BATMAN_OGM_HLEN +
-		  tt_len((uint8_t)atomic_read(&bat_priv->tt_local_changes));
+	num_changes = (uint8_t)atomic_read(&bat_priv->tt_local_changes);
+	new_len = BATMAN_OGM_HLEN + batadv_tt_len(num_changes);
 
 	/* if we have too many changes for one packet don't send any
 	 * and wait for the tt table request which will be fragmented */
@@ -112,14 +115,14 @@ static int prepare_packet_buffer(struct bat_priv *bat_priv,
 
 	realloc_packet_buffer(hard_iface, new_len);
 
-	bat_priv->tt_crc = tt_local_crc(bat_priv);
+	bat_priv->tt_crc = batadv_tt_local_crc(bat_priv);
 
 	/* reset the sending counter */
 	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
 
-	return tt_changes_fill_buffer(bat_priv,
-				      hard_iface->packet_buff + BATMAN_OGM_HLEN,
-				      hard_iface->packet_len - BATMAN_OGM_HLEN);
+	pos = hard_iface->packet_buff + BATMAN_OGM_HLEN;
+	buf_len = hard_iface->packet_len - BATMAN_OGM_HLEN;
+	return batadv_tt_changes_fill_buffer(bat_priv, pos, buf_len);
 }
 
 static int reset_packet_buffer(struct bat_priv *bat_priv,
@@ -129,7 +132,7 @@ static int reset_packet_buffer(struct bat_priv *bat_priv,
 	return 0;
 }
 
-void schedule_bat_ogm(struct hard_iface *hard_iface)
+void batadv_schedule_bat_ogm(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct hard_iface *primary_if;
@@ -154,7 +157,7 @@ void schedule_bat_ogm(struct hard_iface *hard_iface)
 	if (hard_iface == primary_if) {
 		/* if at least one change happened */
 		if (atomic_read(&bat_priv->tt_local_changes) > 0) {
-			tt_commit_changes(bat_priv);
+			batadv_tt_commit_changes(bat_priv);
 			tt_num_changes = prepare_packet_buffer(bat_priv,
 							       hard_iface);
 		}
@@ -194,7 +197,7 @@ static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
 			  send_outstanding_bcast_packet);
-	queue_delayed_work(bat_event_workqueue, &forw_packet->delayed_work,
+	queue_delayed_work(batadv_event_workqueue, &forw_packet->delayed_work,
 			   send_time);
 }
 
@@ -206,8 +209,9 @@ static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
  *
  * The skb is not consumed, so the caller should make sure that the
  * skb is freed. */
-int add_bcast_packet_to_list(struct bat_priv *bat_priv,
-			     const struct sk_buff *skb, unsigned long delay)
+int batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
+				    const struct sk_buff *skb,
+				    unsigned long delay)
 {
 	struct hard_iface *primary_if = NULL;
 	struct forw_packet *forw_packet;
@@ -275,19 +279,20 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
-	if (dat_drop_broadcast_packet(bat_priv, forw_packet))
+	if (batadv_dat_drop_broadcast_packet(bat_priv, forw_packet))
 		goto out;
 
 	/* rebroadcast packet */
 	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
 		/* send a copy of the saved skb */
 		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
-			send_skb_packet(skb1, hard_iface, broadcast_addr);
+			batadv_send_skb_packet(skb1, hard_iface,
+					       batadv_broadcast_addr);
 	}
 	rcu_read_unlock();
 
@@ -305,7 +310,7 @@ out:
 	atomic_inc(&bat_priv->bcast_queue_left);
 }
 
-void send_outstanding_bat_ogm_packet(struct work_struct *work)
+void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 {
 	struct delayed_work *delayed_work =
 		container_of(work, struct delayed_work, work);
@@ -329,7 +334,7 @@ void send_outstanding_bat_ogm_packet(struct work_struct *work)
 	 * shutting down
 	 */
 	if (forw_packet->own)
-		schedule_bat_ogm(forw_packet->if_incoming);
+		batadv_schedule_bat_ogm(forw_packet->if_incoming);
 
 out:
 	/* don't count own packet */
@@ -339,8 +344,8 @@ out:
 	forw_packet_free(forw_packet);
 }
 
-void purge_outstanding_packets(struct bat_priv *bat_priv,
-			       const struct hard_iface *hard_iface)
+void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
+				      const struct hard_iface *hard_iface)
 {
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
diff --git a/send.h b/send.h
index 824ef06..452e8df 100644
--- a/send.h
+++ b/send.h
@@ -22,13 +22,14 @@
 #ifndef _NET_BATMAN_ADV_SEND_H_
 #define _NET_BATMAN_ADV_SEND_H_
 
-int send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
-		    const uint8_t *dst_addr);
-void schedule_bat_ogm(struct hard_iface *hard_iface);
-int add_bcast_packet_to_list(struct bat_priv *bat_priv,
-			     const struct sk_buff *skb, unsigned long delay);
-void send_outstanding_bat_ogm_packet(struct work_struct *work);
-void purge_outstanding_packets(struct bat_priv *bat_priv,
-			       const struct hard_iface *hard_iface);
+int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
+			   const uint8_t *dst_addr);
+void batadv_schedule_bat_ogm(struct hard_iface *hard_iface);
+int batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
+				    const struct sk_buff *skb,
+				    unsigned long delay);
+void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work);
+void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
+				      const struct hard_iface *hard_iface);
 
 #endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index 101253d..eb76396 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -62,7 +62,7 @@ static const struct ethtool_ops bat_ethtool_ops = {
 	.get_sset_count = bat_get_sset_count,
 };
 
-int my_skb_head_push(struct sk_buff *skb, unsigned int len)
+int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
 {
 	int result;
 
@@ -110,9 +110,9 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 
 	/* only modify transtable if it has been initialized before */
 	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
-		tt_local_remove(bat_priv, dev->dev_addr,
-				"mac address changed", false);
-		tt_local_add(dev, addr->sa_data, NULL_IFINDEX);
+		batadv_tt_local_remove(bat_priv, dev->dev_addr,
+				       "mac address changed", false);
+		batadv_tt_local_add(dev, addr->sa_data, NULL_IFINDEX);
 	}
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
@@ -123,7 +123,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 static int interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* check ranges */
-	if ((new_mtu < 68) || (new_mtu > hardif_min_mtu(dev)))
+	if ((new_mtu < 68) || (new_mtu > batadv_hardif_min_mtu(dev)))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
@@ -164,11 +164,11 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		goto dropped;
 	}
 
-	if (bla_tx(bat_priv, skb, vid))
+	if (batadv_bla_tx(bat_priv, skb, vid))
 		goto dropped;
 
 	/* Register the client MAC in the transtable */
-	tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
+	batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
@@ -183,14 +183,14 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		case GW_MODE_SERVER:
 			/* gateway servers should not send dhcp
 			 * requests into the mesh */
-			ret = gw_is_dhcp_target(skb, &header_len);
+			ret = batadv_gw_is_dhcp_target(skb, &header_len);
 			if (ret)
 				goto dropped;
 			break;
 		case GW_MODE_CLIENT:
 			/* gateway clients should send dhcp requests
 			 * via unicast to their gateway */
-			ret = gw_is_dhcp_target(skb, &header_len);
+			ret = batadv_gw_is_dhcp_target(skb, &header_len);
 			if (ret)
 				do_bcast = false;
 			break;
@@ -206,10 +206,10 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		if (!primary_if)
 			goto dropped;
 
-		if (dat_snoop_outgoing_arp_request(bat_priv, skb))
+		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
 			brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
 
-		if (my_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
+		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
 			goto dropped;
 
 		bcast_packet = (struct bcast_packet *)skb->data;
@@ -228,7 +228,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		bcast_packet->seqno =
 			htonl(atomic_inc_return(&bat_priv->bcast_seqno));
 
-		add_bcast_packet_to_list(bat_priv, skb, brd_delay);
+		batadv_add_bcast_packet_to_list(bat_priv, skb, brd_delay);
 
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb. */
@@ -237,12 +237,12 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	/* unicast packet */
 	} else {
 		if (atomic_read(&bat_priv->gw_mode) != GW_MODE_OFF) {
-			ret = gw_out_of_range(bat_priv, skb, ethhdr);
+			ret = batadv_gw_out_of_range(bat_priv, skb, ethhdr);
 			if (ret)
 				goto dropped;
 		}
 
-		dat_snoop_outgoing_arp_reply(bat_priv, skb);
+		batadv_dat_snoop_outgoing_arp_reply(bat_priv, skb);
 
 		ret = unicast_send_skb(skb, bat_priv);
 		if (ret != 0)
@@ -263,9 +263,9 @@ end:
 	return NETDEV_TX_OK;
 }
 
-void interface_rx(struct net_device *soft_iface,
-		  struct sk_buff *skb, struct hard_iface *recv_if,
-		  int hdr_size)
+void batadv_interface_rx(struct net_device *soft_iface,
+			 struct sk_buff *skb, struct hard_iface *recv_if,
+			 int hdr_size)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct ethhdr *ethhdr;
@@ -276,10 +276,10 @@ void interface_rx(struct net_device *soft_iface,
 	if (!pskb_may_pull(skb, hdr_size))
 		goto dropped;
 
-	if (dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
 		goto out;
 
-	if (dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
 		goto out;
 
 	skb_pull_rcsum(skb, hdr_size);
@@ -316,13 +316,13 @@ void interface_rx(struct net_device *soft_iface,
 
 	soft_iface->last_rx = jiffies;
 
-	if (is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
+	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
 		goto dropped;
 
 	/* Let the bridge loop avoidance check the packet. If will
 	 * not handle it, we can safely push it up.
 	 */
-	if (bla_rx(bat_priv, skb, vid))
+	if (batadv_bla_rx(bat_priv, skb, vid))
 		goto out;
 
 	netif_rx(skb);
@@ -370,7 +370,7 @@ static void interface_setup(struct net_device *dev)
 	memset(priv, 0, sizeof(*priv));
 }
 
-struct net_device *softif_create(const char *name)
+struct net_device *batadv_softif_create(const char *name)
 {
 	struct net_device *soft_iface;
 	struct bat_priv *bat_priv;
@@ -388,7 +388,7 @@ struct net_device *softif_create(const char *name)
 		goto free_soft_iface;
 	}
 
-	arp_change_timeout(soft_iface, name);
+	batadv_arp_change_timeout(soft_iface, name);
 
 	bat_priv = netdev_priv(soft_iface);
 
@@ -426,28 +426,28 @@ struct net_device *softif_create(const char *name)
 	if (!bat_priv->bat_counters)
 		goto unreg_soft_iface;
 
-	ret = bat_algo_select(bat_priv, bat_routing_algo);
+	ret = batadv_algo_select(bat_priv, batadv_routing_algo);
 	if (ret < 0)
 		goto free_bat_counters;
 
-	ret = sysfs_add_meshif(soft_iface);
+	ret = batadv_sysfs_add_meshif(soft_iface);
 	if (ret < 0)
 		goto free_bat_counters;
 
-	ret = debugfs_add_meshif(soft_iface);
+	ret = batadv_debugfs_add_meshif(soft_iface);
 	if (ret < 0)
 		goto unreg_sysfs;
 
-	ret = mesh_init(soft_iface);
+	ret = batadv_mesh_init(soft_iface);
 	if (ret < 0)
 		goto unreg_debugfs;
 
 	return soft_iface;
 
 unreg_debugfs:
-	debugfs_del_meshif(soft_iface);
+	batadv_debugfs_del_meshif(soft_iface);
 unreg_sysfs:
-	sysfs_del_meshif(soft_iface);
+	batadv_sysfs_del_meshif(soft_iface);
 free_bat_counters:
 	free_percpu(bat_priv->bat_counters);
 unreg_soft_iface:
@@ -460,15 +460,15 @@ out:
 	return NULL;
 }
 
-void softif_destroy(struct net_device *soft_iface)
+void batadv_softif_destroy(struct net_device *soft_iface)
 {
-	debugfs_del_meshif(soft_iface);
-	sysfs_del_meshif(soft_iface);
-	mesh_free(soft_iface);
+	batadv_debugfs_del_meshif(soft_iface);
+	batadv_sysfs_del_meshif(soft_iface);
+	batadv_mesh_free(soft_iface);
 	unregister_netdevice(soft_iface);
 }
 
-int softif_is_valid(const struct net_device *net_dev)
+int batadv_softif_is_valid(const struct net_device *net_dev)
 {
 	if (net_dev->netdev_ops->ndo_start_xmit == interface_tx)
 		return 1;
diff --git a/soft-interface.h b/soft-interface.h
index 0203006..7e2bfaf 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -22,12 +22,11 @@
 #ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 #define _NET_BATMAN_ADV_SOFT_INTERFACE_H_
 
-int my_skb_head_push(struct sk_buff *skb, unsigned int len);
-void interface_rx(struct net_device *soft_iface,
-		  struct sk_buff *skb, struct hard_iface *recv_if,
-		  int hdr_size);
-struct net_device *softif_create(const char *name);
-void softif_destroy(struct net_device *soft_iface);
-int softif_is_valid(const struct net_device *net_dev);
+int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
+void batadv_interface_rx(struct net_device *soft_iface, struct sk_buff *skb,
+			 struct hard_iface *recv_if, int hdr_size);
+struct net_device *batadv_softif_create(const char *name);
+void batadv_softif_destroy(struct net_device *soft_iface);
+int batadv_softif_is_valid(const struct net_device *net_dev);
 
 #endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
diff --git a/translation-table.c b/translation-table.c
index 4155918..27fd965 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -48,7 +48,7 @@ static int compare_tt(const struct hlist_node *node, const void *data2)
 static void tt_start_timer(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->tt_work, tt_purge);
-	queue_delayed_work(bat_event_workqueue, &bat_priv->tt_work,
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->tt_work,
 			   msecs_to_jiffies(5000));
 }
 
@@ -142,7 +142,7 @@ static void tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 
 	orig_entry = container_of(rcu, struct tt_orig_list_entry, rcu);
 	atomic_dec(&orig_entry->orig_node->tt_size);
-	orig_node_free_ref(orig_entry->orig_node);
+	batadv_orig_node_free_ref(orig_entry->orig_node);
 	kfree(orig_entry);
 }
 
@@ -173,7 +173,7 @@ static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
 	atomic_set(&bat_priv->tt_ogm_append_cnt, 0);
 }
 
-int tt_len(int changes_num)
+int batadv_tt_len(int changes_num)
 {
 	return changes_num * sizeof(struct tt_change);
 }
@@ -183,7 +183,7 @@ static int tt_local_init(struct bat_priv *bat_priv)
 	if (bat_priv->tt_local_hash)
 		return 0;
 
-	bat_priv->tt_local_hash = hash_new(1024);
+	bat_priv->tt_local_hash = batadv_hash_new(1024);
 
 	if (!bat_priv->tt_local_hash)
 		return -ENOMEM;
@@ -191,8 +191,8 @@ static int tt_local_init(struct bat_priv *bat_priv)
 	return 0;
 }
 
-void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
-		  int ifindex)
+void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
+			 int ifindex)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct tt_local_entry *tt_local_entry = NULL;
@@ -221,7 +221,7 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	memcpy(tt_local_entry->common.addr, addr, ETH_ALEN);
 	tt_local_entry->common.flags = NO_FLAGS;
-	if (is_wifi_iface(ifindex))
+	if (batadv_is_wifi_iface(ifindex))
 		tt_local_entry->common.flags |= TT_CLIENT_WIFI;
 	atomic_set(&tt_local_entry->common.refcount, 2);
 	tt_local_entry->last_seen = jiffies;
@@ -275,14 +275,14 @@ out:
 		tt_global_entry_free_ref(tt_global_entry);
 }
 
-int tt_changes_fill_buffer(struct bat_priv *bat_priv,
-			   unsigned char *buff, int buff_len)
+int batadv_tt_changes_fill_buffer(struct bat_priv *bat_priv,
+				  unsigned char *buff, int buff_len)
 {
 	int count = 0, tot_changes = 0;
 	struct tt_change_node *entry, *safe;
 
 	if (buff_len > 0)
-		tot_changes = buff_len / tt_len(1);
+		tot_changes = buff_len / batadv_tt_len(1);
 
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
 	atomic_set(&bat_priv->tt_local_changes, 0);
@@ -290,7 +290,7 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
 				 list) {
 		if (count < tot_changes) {
-			memcpy(buff + tt_len(count),
+			memcpy(buff + batadv_tt_len(count),
 			       &entry->change, sizeof(struct tt_change));
 			count++;
 		}
@@ -322,7 +322,7 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 	return count;
 }
 
-int tt_local_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -397,8 +397,8 @@ static void tt_local_set_pending(struct bat_priv *bat_priv,
 		tt_local_entry->common.addr, message);
 }
 
-void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
-		     const char *message, bool roaming)
+void batadv_tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
+			    const char *message, bool roaming)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
 
@@ -483,7 +483,7 @@ static void tt_local_table_free(struct bat_priv *bat_priv)
 		spin_unlock_bh(list_lock);
 	}
 
-	hash_destroy(hash);
+	batadv_hash_destroy(hash);
 
 	bat_priv->tt_local_hash = NULL;
 }
@@ -493,7 +493,7 @@ static int tt_global_init(struct bat_priv *bat_priv)
 	if (bat_priv->tt_global_hash)
 		return 0;
 
-	bat_priv->tt_global_hash = hash_new(1024);
+	bat_priv->tt_global_hash = batadv_hash_new(1024);
 
 	if (!bat_priv->tt_global_hash)
 		return -ENOMEM;
@@ -563,9 +563,9 @@ static void tt_global_add_orig_entry(struct tt_global_entry *tt_global_entry,
 }
 
 /* caller must hold orig_node refcount */
-int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming,
-		  bool wifi)
+int batadv_tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
+			 const unsigned char *tt_addr, uint8_t ttvn,
+			 bool roaming, bool wifi)
 {
 	struct tt_global_entry *tt_global_entry = NULL;
 	int ret = 0;
@@ -629,8 +629,8 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 
 out_remove:
 	/* remove address from local hash if present */
-	tt_local_remove(bat_priv, tt_global_entry->common.addr,
-			"global tt received", roaming);
+	batadv_tt_local_remove(bat_priv, tt_global_entry->common.addr,
+			       "global tt received", roaming);
 	ret = 1;
 out:
 	if (tt_global_entry)
@@ -666,7 +666,7 @@ static void tt_global_print_entry(struct tt_global_entry *tt_global_entry,
 	}
 }
 
-int tt_global_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -871,8 +871,8 @@ out:
 		tt_local_entry_free_ref(tt_local_entry);
 }
 
-void tt_global_del_orig(struct bat_priv *bat_priv,
-			struct orig_node *orig_node, const char *message)
+void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node, const char *message)
 {
 	struct tt_global_entry *tt_global_entry;
 	struct tt_common_entry *tt_common_entry;
@@ -983,7 +983,7 @@ static void tt_global_table_free(struct bat_priv *bat_priv)
 		spin_unlock_bh(list_lock);
 	}
 
-	hash_destroy(hash);
+	batadv_hash_destroy(hash);
 
 	bat_priv->tt_global_hash = NULL;
 }
@@ -1000,8 +1000,9 @@ static bool _is_ap_isolated(struct tt_local_entry *tt_local_entry,
 	return ret;
 }
 
-struct orig_node *transtable_search(struct bat_priv *bat_priv,
-				    const uint8_t *src, const uint8_t *addr)
+struct orig_node *batadv_transtable_search(struct bat_priv *bat_priv,
+					   const uint8_t *src,
+					   const uint8_t *addr)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
 	struct tt_global_entry *tt_global_entry = NULL;
@@ -1032,7 +1033,7 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 	rcu_read_lock();
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
-		router = orig_node_get_router(orig_entry->orig_node);
+		router = batadv_orig_node_get_router(orig_entry->orig_node);
 		if (!router)
 			continue;
 
@@ -1040,7 +1041,7 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv,
 			orig_node = orig_entry->orig_node;
 			best_tq = router->tq_avg;
 		}
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 	}
 	/* found anything? */
 	if (orig_node && !atomic_inc_not_zero(&orig_node->refcount))
@@ -1105,7 +1106,7 @@ static uint16_t tt_global_crc(struct bat_priv *bat_priv,
 }
 
 /* Calculates the checksum of the local table */
-uint16_t tt_local_crc(struct bat_priv *bat_priv)
+uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv)
 {
 	uint16_t total = 0, total_one;
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
@@ -1156,7 +1157,7 @@ static void tt_save_orig_buffer(struct bat_priv *bat_priv,
 				const unsigned char *tt_buff,
 				uint8_t tt_num_changes)
 {
-	uint16_t tt_buff_len = tt_len(tt_num_changes);
+	uint16_t tt_buff_len = batadv_tt_len(tt_num_changes);
 
 	/* Replace the old buffer only if I received something in the
 	 * last OGM (the OGM could carry no changes) */
@@ -1347,7 +1348,7 @@ static int send_tt_request(struct bat_priv *bat_priv,
 	if (full_table)
 		tt_request->flags |= TT_FULL_TABLE;
 
-	neigh_node = orig_node_get_router(dst_orig_node);
+	neigh_node = batadv_orig_node_get_router(dst_orig_node);
 	if (!neigh_node)
 		goto out;
 
@@ -1358,12 +1359,12 @@ static int send_tt_request(struct bat_priv *bat_priv,
 
 	inc_counter(bat_priv, BAT_CNT_TT_REQUEST_TX);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
 out:
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (ret)
@@ -1405,7 +1406,7 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	neigh_node = orig_node_get_router(res_dst_orig_node);
+	neigh_node = batadv_orig_node_get_router(res_dst_orig_node);
 	if (!neigh_node)
 		goto out;
 
@@ -1484,7 +1485,7 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 
 	inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
 
@@ -1493,11 +1494,11 @@ unlock:
 
 out:
 	if (res_dst_orig_node)
-		orig_node_free_ref(res_dst_orig_node);
+		batadv_orig_node_free_ref(res_dst_orig_node);
 	if (req_dst_orig_node)
-		orig_node_free_ref(req_dst_orig_node);
+		batadv_orig_node_free_ref(req_dst_orig_node);
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (!ret)
@@ -1532,7 +1533,7 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	neigh_node = orig_node_get_router(orig_node);
+	neigh_node = batadv_orig_node_get_router(orig_node);
 	if (!neigh_node)
 		goto out;
 
@@ -1602,7 +1603,7 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 
 	inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
 
@@ -1610,9 +1611,9 @@ unlock:
 	spin_unlock_bh(&bat_priv->tt_buff_lock);
 out:
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (!ret)
@@ -1621,12 +1622,12 @@ out:
 	return true;
 }
 
-bool send_tt_response(struct bat_priv *bat_priv,
-		      struct tt_query_packet *tt_request)
+bool batadv_send_tt_response(struct bat_priv *bat_priv,
+			     struct tt_query_packet *tt_request)
 {
-	if (is_my_mac(tt_request->dst)) {
+	if (batadv_is_my_mac(tt_request->dst)) {
 		/* don't answer backbone gws! */
-		if (bla_is_backbone_gw_orig(bat_priv, tt_request->src))
+		if (batadv_bla_is_backbone_gw_orig(bat_priv, tt_request->src))
 			return true;
 
 		return send_my_tt_response(bat_priv, tt_request);
@@ -1641,18 +1642,19 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 			       uint16_t tt_num_changes, uint8_t ttvn)
 {
 	int i;
+	int is_wifi;
 
 	for (i = 0; i < tt_num_changes; i++) {
-		if ((tt_change + i)->flags & TT_CLIENT_DEL)
+		if ((tt_change + i)->flags & TT_CLIENT_DEL) {
 			tt_global_del(bat_priv, orig_node,
 				      (tt_change + i)->addr,
 				      "tt removed by changes",
 				      (tt_change + i)->flags & TT_CLIENT_ROAM);
-		else
-			if (!tt_global_add(bat_priv, orig_node,
-					   (tt_change + i)->addr, ttvn, false,
-					   (tt_change + i)->flags &
-							TT_CLIENT_WIFI))
+		} else {
+			is_wifi = (tt_change + i)->flags & TT_CLIENT_WIFI;
+			if (!batadv_tt_global_add(bat_priv, orig_node,
+						  (tt_change + i)->addr, ttvn,
+						  false, is_wifi))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the
@@ -1660,6 +1662,7 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 				 * corrupted data on tt_request
 				 */
 				return;
+		}
 	}
 	orig_node->tt_initialised = true;
 }
@@ -1674,7 +1677,7 @@ static void tt_fill_gtable(struct bat_priv *bat_priv,
 		goto out;
 
 	/* Purge the old table first.. */
-	tt_global_del_orig(bat_priv, orig_node, "Received full table");
+	batadv_tt_global_del_orig(bat_priv, orig_node, "Received full table");
 
 	_tt_update_changes(bat_priv, orig_node,
 			   (struct tt_change *)(tt_response + 1),
@@ -1690,7 +1693,7 @@ static void tt_fill_gtable(struct bat_priv *bat_priv,
 
 out:
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 }
 
 static void tt_update_changes(struct bat_priv *bat_priv,
@@ -1706,7 +1709,7 @@ static void tt_update_changes(struct bat_priv *bat_priv,
 	atomic_set(&orig_node->last_ttvn, ttvn);
 }
 
-bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
+bool batadv_is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
 	bool ret = false;
@@ -1725,8 +1728,8 @@ out:
 	return ret;
 }
 
-void handle_tt_response(struct bat_priv *bat_priv,
-			struct tt_query_packet *tt_response)
+void batadv_handle_tt_response(struct bat_priv *bat_priv,
+			       struct tt_query_packet *tt_response)
 {
 	struct tt_req_node *node, *safe;
 	struct orig_node *orig_node = NULL;
@@ -1738,7 +1741,7 @@ void handle_tt_response(struct bat_priv *bat_priv,
 		(tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
 
 	/* we should have never asked a backbone gw */
-	if (bla_is_backbone_gw_orig(bat_priv, tt_response->src))
+	if (batadv_bla_is_backbone_gw_orig(bat_priv, tt_response->src))
 		goto out;
 
 	orig_node = orig_hash_find(bat_priv, tt_response->src);
@@ -1770,10 +1773,10 @@ void handle_tt_response(struct bat_priv *bat_priv,
 	orig_node->tt_poss_change = false;
 out:
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 }
 
-int tt_init(struct bat_priv *bat_priv)
+int batadv_tt_init(struct bat_priv *bat_priv)
 {
 	int ret;
 
@@ -1899,7 +1902,7 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 	memcpy(roam_adv_packet->dst, orig_node->orig, ETH_ALEN);
 	memcpy(roam_adv_packet->client, client, ETH_ALEN);
 
-	neigh_node = orig_node_get_router(orig_node);
+	neigh_node = batadv_orig_node_get_router(orig_node);
 	if (!neigh_node)
 		goto out;
 
@@ -1909,12 +1912,12 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 
 	inc_counter(bat_priv, BAT_CNT_TT_ROAM_ADV_TX);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
 out:
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	if (ret)
 		kfree_skb(skb);
 	return;
@@ -1935,7 +1938,7 @@ static void tt_purge(struct work_struct *work)
 	tt_start_timer(bat_priv);
 }
 
-void tt_free(struct bat_priv *bat_priv)
+void batadv_tt_free(struct bat_priv *bat_priv)
 {
 	cancel_delayed_work_sync(&bat_priv->tt_work);
 
@@ -2025,7 +2028,7 @@ static void tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 
 }
 
-void tt_commit_changes(struct bat_priv *bat_priv)
+void batadv_tt_commit_changes(struct bat_priv *bat_priv)
 {
 	uint16_t changed_num = tt_set_flags(bat_priv->tt_local_hash,
 					    TT_CLIENT_NEW, false);
@@ -2041,7 +2044,8 @@ void tt_commit_changes(struct bat_priv *bat_priv)
 	bat_priv->tt_poss_change = false;
 }
 
-bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst)
+bool batadv_is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src,
+			   uint8_t *dst)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
 	struct tt_global_entry *tt_global_entry = NULL;
@@ -2071,15 +2075,16 @@ out:
 	return ret;
 }
 
-void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		    const unsigned char *tt_buff, uint8_t tt_num_changes,
-		    uint8_t ttvn, uint16_t tt_crc)
+void batadv_tt_update_orig(struct bat_priv *bat_priv,
+			   struct orig_node *orig_node,
+			   const unsigned char *tt_buff, uint8_t tt_num_changes,
+			   uint8_t ttvn, uint16_t tt_crc)
 {
 	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
 	bool full_table = true;
 
 	/* don't care about a backbone gateways updates. */
-	if (bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
+	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
 		return;
 
 	/* orig table not initialised AND first diff is in the OGM OR the ttvn
@@ -2137,7 +2142,8 @@ request_table:
 /* returns true whether we know that the client has moved from its old
  * originator to another one. This entry is kept is still kept for consistency
  * purposes */
-bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr)
+bool batadv_tt_global_client_is_roaming(struct bat_priv *bat_priv,
+					uint8_t *addr)
 {
 	struct tt_global_entry *tt_global_entry;
 	bool ret = false;
diff --git a/translation-table.h b/translation-table.h
index c43374d..6d1ccb9 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -22,38 +22,45 @@
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 #define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 
-int tt_len(int changes_num);
-int tt_changes_fill_buffer(struct bat_priv *bat_priv,
-			   unsigned char *buff, int buff_len);
-int tt_init(struct bat_priv *bat_priv);
-void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
-		  int ifindex);
-void tt_local_remove(struct bat_priv *bat_priv,
-		     const uint8_t *addr, const char *message, bool roaming);
-int tt_local_seq_print_text(struct seq_file *seq, void *offset);
-void tt_global_add_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
-			const unsigned char *tt_buff, int tt_buff_len);
-int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		  const unsigned char *addr, uint8_t ttvn, bool roaming,
-		  bool wifi);
-int tt_global_seq_print_text(struct seq_file *seq, void *offset);
-void tt_global_del_orig(struct bat_priv *bat_priv,
-			struct orig_node *orig_node, const char *message);
-struct orig_node *transtable_search(struct bat_priv *bat_priv,
-				    const uint8_t *src, const uint8_t *addr);
-uint16_t tt_local_crc(struct bat_priv *bat_priv);
-void tt_free(struct bat_priv *bat_priv);
-bool send_tt_response(struct bat_priv *bat_priv,
-		      struct tt_query_packet *tt_request);
-bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr);
-void handle_tt_response(struct bat_priv *bat_priv,
-			struct tt_query_packet *tt_response);
-void tt_commit_changes(struct bat_priv *bat_priv);
-bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst);
-void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		    const unsigned char *tt_buff, uint8_t tt_num_changes,
-		    uint8_t ttvn, uint16_t tt_crc);
-bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr);
+int batadv_tt_len(int changes_num);
+int batadv_tt_changes_fill_buffer(struct bat_priv *bat_priv,
+				  unsigned char *buff, int buff_len);
+int batadv_tt_init(struct bat_priv *bat_priv);
+void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
+			 int ifindex);
+void batadv_tt_local_remove(struct bat_priv *bat_priv,
+			    const uint8_t *addr, const char *message,
+			    bool roaming);
+int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset);
+void batadv_tt_global_add_orig(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node,
+			       const unsigned char *tt_buff, int tt_buff_len);
+int batadv_tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
+			 const unsigned char *addr, uint8_t ttvn, bool roaming,
+			 bool wifi);
+int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
+void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node,
+			       const char *message);
+struct orig_node *batadv_transtable_search(struct bat_priv *bat_priv,
+					   const uint8_t *src,
+					   const uint8_t *addr);
+uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv);
+void batadv_tt_free(struct bat_priv *bat_priv);
+bool batadv_send_tt_response(struct bat_priv *bat_priv,
+			     struct tt_query_packet *tt_request);
+bool batadv_is_my_client(struct bat_priv *bat_priv, const uint8_t *addr);
+void batadv_handle_tt_response(struct bat_priv *bat_priv,
+			       struct tt_query_packet *tt_response);
+void batadv_tt_commit_changes(struct bat_priv *bat_priv);
+bool batadv_is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src,
+			   uint8_t *dst);
+void batadv_tt_update_orig(struct bat_priv *bat_priv,
+			   struct orig_node *orig_node,
+			   const unsigned char *tt_buff, uint8_t tt_num_changes,
+			   uint8_t ttvn, uint16_t tt_crc);
+bool batadv_tt_global_client_is_roaming(struct bat_priv *bat_priv,
+					uint8_t *addr);
 
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/unicast.c b/unicast.c
index 62ea9f1..ae59a74 100644
--- a/unicast.c
+++ b/unicast.c
@@ -101,7 +101,7 @@ static int frag_create_buffer(struct list_head *head)
 	for (i = 0; i < FRAG_BUFFER_SIZE; i++) {
 		tfp = kmalloc(sizeof(*tfp), GFP_ATOMIC);
 		if (!tfp) {
-			frag_list_free(head);
+			batadv_frag_list_free(head);
 			return -ENOMEM;
 		}
 		tfp->skb = NULL;
@@ -151,7 +151,7 @@ mov_tail:
 	return NULL;
 }
 
-void frag_list_free(struct list_head *head)
+void batadv_frag_list_free(struct list_head *head)
 {
 	struct frag_packet_list_entry *pf, *tmp_pf;
 
@@ -172,8 +172,8 @@ void frag_list_free(struct list_head *head)
  * or the skb could be reassembled (skb_new will point to the new packet and
  * skb was freed)
  */
-int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			struct sk_buff **new_skb)
+int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			       struct sk_buff **new_skb)
 {
 	struct orig_node *orig_node;
 	struct frag_packet_list_entry *tmp_frag_entry;
@@ -212,12 +212,12 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 
 out:
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
 
-int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-		  struct hard_iface *hard_iface, const uint8_t dstaddr[])
+int batadv_frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			 struct hard_iface *hard_iface, const uint8_t dstaddr[])
 {
 	struct unicast_packet tmp_uc, *unicast_packet;
 	struct hard_iface *primary_if;
@@ -242,8 +242,8 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	memcpy(&tmp_uc, unicast_packet, uc_hdr_len);
 	skb_split(skb, frag_skb, data_len / 2 + uc_hdr_len);
 
-	if (my_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
-	    my_skb_head_push(frag_skb, ucf_hdr_len) < 0)
+	if (batadv_skb_head_push(skb, ucf_hdr_len - uc_hdr_len) < 0 ||
+	    batadv_skb_head_push(frag_skb, ucf_hdr_len) < 0)
 		goto drop_frag;
 
 	frag1 = (struct unicast_frag_packet *)skb->data;
@@ -268,8 +268,8 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	frag1->seqno = htons(seqno - 1);
 	frag2->seqno = htons(seqno);
 
-	send_skb_packet(skb, hard_iface, dstaddr);
-	send_skb_packet(frag_skb, hard_iface, dstaddr);
+	batadv_send_skb_packet(skb, hard_iface, dstaddr);
+	batadv_send_skb_packet(frag_skb, hard_iface, dstaddr);
 	ret = NET_RX_SUCCESS;
 	goto out;
 
@@ -288,7 +288,7 @@ static bool pull_and_fill_unicast(struct sk_buff *skb, int hdr_size,
 {
 	struct unicast_packet *unicast_packet;
 
-	if (my_skb_head_push(skb, hdr_size) < 0)
+	if (batadv_skb_head_push(skb, hdr_size) < 0)
 		return false;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
@@ -313,10 +313,10 @@ static bool prepare_unicast_packet(struct sk_buff *skb,
 				     orig_node);
 }
 
-bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
-				  struct sk_buff *skb,
-				  struct orig_node *orig_node,
-				  int packet_subtype)
+bool batadv_prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+					 struct sk_buff *skb,
+					 struct orig_node *orig_node,
+					 int packet_subtype)
 {
 	struct hard_iface *primary_if;
 	struct unicast_4addr_packet *unicast_4addr_packet;
@@ -347,8 +347,9 @@ out:
 	return ret;
 }
 
-int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			     int packet_type, int packet_subtype)
+int batadv_unicast_generic_send_skb(struct sk_buff *skb,
+				    struct bat_priv *bat_priv,
+				    int packet_type, int packet_subtype)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct orig_node *orig_node;
@@ -359,22 +360,22 @@ int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 
 	/* get routing information */
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
-		orig_node = gw_get_selected_orig(bat_priv);
+		orig_node = batadv_gw_get_selected_orig(bat_priv);
 		if (orig_node)
 			goto find_router;
 	}
 
 	/* check for tt host - increases orig_node refcount.
 	 * returns NULL in case of AP isolation */
-	orig_node = transtable_search(bat_priv, ethhdr->h_source,
-				      ethhdr->h_dest);
+	orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
+					     ethhdr->h_dest);
 find_router:
 	/**
 	 * find_router():
 	 *  - if orig_node is NULL it returns NULL
 	 *  - increases neigh_nodes refcount if found.
 	 */
-	neigh_node = find_router(bat_priv, orig_node, NULL);
+	neigh_node = batadv_find_router(bat_priv, orig_node, NULL);
 	if (!neigh_node)
 		goto out;
 
@@ -383,8 +384,8 @@ find_router:
 		prepare_unicast_packet(skb, orig_node);
 		break;
 	case BAT_UNICAST_4ADDR:
-		prepare_unicast_4addr_packet(bat_priv, skb, orig_node,
-					     packet_subtype);
+		batadv_prepare_unicast_4addr_packet(bat_priv, skb, orig_node,
+						    packet_subtype);
 		break;
 	default:
 		/* this function supports UNICAST and UNICAST_4ADDR only. It
@@ -399,7 +400,7 @@ find_router:
 	 * for this client. The destination will receive this packet and will
 	 * try to reroute it because the ttvn contained in the header is less
 	 * than the current one */
-	if (tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
+	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
 	/* fragmentation mechanism only works for UNICAST (now) */
@@ -409,19 +410,20 @@ find_router:
 				neigh_node->if_incoming->net_dev->mtu) {
 		/* send frag skb decreases ttl */
 		unicast_packet->header.ttl++;
-		ret = frag_send_skb(skb, bat_priv,
-				    neigh_node->if_incoming, neigh_node->addr);
+		ret = batadv_frag_send_skb(skb, bat_priv,
+					   neigh_node->if_incoming,
+					   neigh_node->addr);
 		goto out;
 	}
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
 out:
 	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
+		batadv_neigh_node_free_ref(neigh_node);
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 	if (ret == 1)
 		kfree_skb(skb);
 	return ret;
diff --git a/unicast.h b/unicast.h
index e15aa62..da402b1 100644
--- a/unicast.h
+++ b/unicast.h
@@ -27,30 +27,32 @@
 #define FRAG_TIMEOUT 10000	/* purge frag list entries after time in ms */
 #define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
 
-int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			struct sk_buff **new_skb);
-void frag_list_free(struct list_head *head);
-int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-		  struct hard_iface *hard_iface, const uint8_t dstaddr[]);
-bool prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
-				  struct sk_buff *skb,
-				  struct orig_node *orig_node,
-				  int packet_subtype);
-int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
-			     int packet_type, int packet_subtype);
+int batadv_frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			       struct sk_buff **new_skb);
+void batadv_frag_list_free(struct list_head *head);
+int batadv_frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
+			 struct hard_iface *hard_iface,
+			 const uint8_t dstaddr[]);
+bool batadv_prepare_unicast_4addr_packet(struct bat_priv *bat_priv,
+					 struct sk_buff *skb,
+					 struct orig_node *orig_node,
+					 int packet_subtype);
+int batadv_unicast_generic_send_skb(struct sk_buff *skb,
+				    struct bat_priv *bat_priv,
+				    int packet_type, int packet_subtype);
 
 static inline int unicast_send_skb(struct sk_buff *skb,
 				   struct bat_priv *bat_priv)
 {
-	return unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST, 0);
+	return batadv_unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST, 0);
 }
 
 static inline int unicast_4addr_send_skb(struct sk_buff *skb,
 					 struct bat_priv *bat_priv,
 					 int packet_subtype)
 {
-	return unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST_4ADDR,
-					packet_subtype);
+	return batadv_unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST_4ADDR,
+					       packet_subtype);
 }
 
 static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
diff --git a/vis.c b/vis.c
index 01d5da5..83c931f 100644
--- a/vis.c
+++ b/vis.c
@@ -188,7 +188,7 @@ static ssize_t vis_data_read_entry(char *buff,
 	return 0;
 }
 
-int vis_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_vis_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct hard_iface *primary_if;
 	struct hlist_node *node;
@@ -462,7 +462,7 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 
 	/* Make it a broadcast packet, if required */
 	if (make_broadcast)
-		memcpy(packet->target_orig, broadcast_addr, ETH_ALEN);
+		memcpy(packet->target_orig, batadv_broadcast_addr, ETH_ALEN);
 
 	/* repair if entries is longer than packet. */
 	if (packet->entries * sizeof(struct vis_info_entry) > vis_info_len)
@@ -483,9 +483,9 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 }
 
 /* handle the server sync packet, forward if needed. */
-void receive_server_sync_packet(struct bat_priv *bat_priv,
-				struct vis_packet *vis_packet,
-				int vis_info_len)
+void batadv_receive_server_sync_packet(struct bat_priv *bat_priv,
+				       struct vis_packet *vis_packet,
+				       int vis_info_len)
 {
 	struct vis_info *info;
 	int is_new, make_broadcast;
@@ -508,9 +508,9 @@ end:
 }
 
 /* handle an incoming client update packet and schedule forward if needed. */
-void receive_client_update_packet(struct bat_priv *bat_priv,
-				  struct vis_packet *vis_packet,
-				  int vis_info_len)
+void batadv_receive_client_update_packet(struct bat_priv *bat_priv,
+					 struct vis_packet *vis_packet,
+					 int vis_info_len)
 {
 	struct vis_info *info;
 	struct vis_packet *packet;
@@ -524,7 +524,7 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 
 	/* Are we the target for this VIS packet? */
 	if (vis_server == VIS_TYPE_SERVER_SYNC	&&
-	    is_my_mac(vis_packet->target_orig))
+	    batadv_is_my_mac(vis_packet->target_orig))
 		are_target = 1;
 
 	spin_lock_bh(&bat_priv->vis_hash_lock);
@@ -543,7 +543,7 @@ void receive_client_update_packet(struct bat_priv *bat_priv,
 		send_list_add(bat_priv, info);
 
 		/* ... we're not the recipient (and thus need to forward). */
-	} else if (!is_my_mac(packet->target_orig)) {
+	} else if (!batadv_is_my_mac(packet->target_orig)) {
 		send_list_add(bat_priv, info);
 	}
 
@@ -574,7 +574,7 @@ static int find_best_vis_server(struct bat_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-			router = orig_node_get_router(orig_node);
+			router = batadv_orig_node_get_router(orig_node);
 			if (!router)
 				continue;
 
@@ -584,7 +584,7 @@ static int find_best_vis_server(struct bat_priv *bat_priv,
 				memcpy(packet->target_orig, orig_node->orig,
 				       ETH_ALEN);
 			}
-			neigh_node_free_ref(router);
+			batadv_neigh_node_free_ref(router);
 		}
 		rcu_read_unlock();
 	}
@@ -623,7 +623,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	info->first_seen = jiffies;
 	packet->vis_type = atomic_read(&bat_priv->vis_mode);
 
-	memcpy(packet->target_orig, broadcast_addr, ETH_ALEN);
+	memcpy(packet->target_orig, batadv_broadcast_addr, ETH_ALEN);
 	packet->header.ttl = TTL;
 	packet->seqno = htonl(ntohl(packet->seqno) + 1);
 	packet->entries = 0;
@@ -641,7 +641,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-			router = orig_node_get_router(orig_node);
+			router = batadv_orig_node_get_router(orig_node);
 			if (!router)
 				continue;
 
@@ -665,7 +665,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 			packet->entries++;
 
 next:
-			neigh_node_free_ref(router);
+			batadv_neigh_node_free_ref(router);
 
 			if (vis_packet_full(info))
 				goto unlock;
@@ -757,7 +757,7 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 			if (!(orig_node->flags & VIS_SERVER))
 				continue;
 
-			router = orig_node_get_router(orig_node);
+			router = batadv_orig_node_get_router(orig_node);
 			if (!router)
 				continue;
 
@@ -765,7 +765,7 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 			 * this node. */
 			if (recv_list_is_in(bat_priv, &info->recv_list,
 					    orig_node->orig)) {
-				neigh_node_free_ref(router);
+				batadv_neigh_node_free_ref(router);
 				continue;
 			}
 
@@ -773,11 +773,12 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 			hard_iface = router->if_incoming;
 			memcpy(dstaddr, router->addr, ETH_ALEN);
 
-			neigh_node_free_ref(router);
+			batadv_neigh_node_free_ref(router);
 
 			skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 			if (skb)
-				send_skb_packet(skb, hard_iface, dstaddr);
+				batadv_send_skb_packet(skb, hard_iface,
+						       dstaddr);
 
 		}
 		rcu_read_unlock();
@@ -798,19 +799,19 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node);
 	if (!router)
 		goto out;
 
 	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 	if (skb)
-		send_skb_packet(skb, router->if_incoming, router->addr);
+		batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 
 out:
 	if (router)
-		neigh_node_free_ref(router);
+		batadv_neigh_node_free_ref(router);
 	if (orig_node)
-		orig_node_free_ref(orig_node);
+		batadv_orig_node_free_ref(orig_node);
 }
 
 /* only send one vis packet. called from send_vis_packets() */
@@ -879,7 +880,7 @@ static void send_vis_packets(struct work_struct *work)
 
 /* init the vis server. this may only be called when if_list is already
  * initialized (e.g. bat0 is initialized, interfaces have been added) */
-int vis_init(struct bat_priv *bat_priv)
+int batadv_vis_init(struct bat_priv *bat_priv)
 {
 	struct vis_packet *packet;
 	int hash_added;
@@ -889,7 +890,7 @@ int vis_init(struct bat_priv *bat_priv)
 
 	spin_lock_bh(&bat_priv->vis_hash_lock);
 
-	bat_priv->vis_hash = hash_new(256);
+	bat_priv->vis_hash = batadv_hash_new(256);
 	if (!bat_priv->vis_hash) {
 		pr_err("Can't initialize vis_hash\n");
 		goto err;
@@ -943,7 +944,7 @@ free_info:
 	bat_priv->my_vis_info = NULL;
 err:
 	spin_unlock_bh(&bat_priv->vis_hash_lock);
-	vis_quit(bat_priv);
+	batadv_vis_quit(bat_priv);
 	return -ENOMEM;
 }
 
@@ -958,7 +959,7 @@ static void free_info_ref(struct hlist_node *node, void *arg)
 }
 
 /* shutdown vis-server */
-void vis_quit(struct bat_priv *bat_priv)
+void batadv_vis_quit(struct bat_priv *bat_priv)
 {
 	if (!bat_priv->vis_hash)
 		return;
@@ -977,6 +978,6 @@ void vis_quit(struct bat_priv *bat_priv)
 static void start_vis_timer(struct bat_priv *bat_priv)
 {
 	INIT_DELAYED_WORK(&bat_priv->vis_work, send_vis_packets);
-	queue_delayed_work(bat_event_workqueue, &bat_priv->vis_work,
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->vis_work,
 			   msecs_to_jiffies(VIS_INTERVAL));
 }
diff --git a/vis.h b/vis.h
index ee2e46e..932514e 100644
--- a/vis.h
+++ b/vis.h
@@ -25,14 +25,14 @@
 #define VIS_TIMEOUT		200000	/* timeout of vis packets
 					 * in miliseconds */
 
-int vis_seq_print_text(struct seq_file *seq, void *offset);
-void receive_server_sync_packet(struct bat_priv *bat_priv,
-				struct vis_packet *vis_packet,
-				int vis_info_len);
-void receive_client_update_packet(struct bat_priv *bat_priv,
-				  struct vis_packet *vis_packet,
-				  int vis_info_len);
-int vis_init(struct bat_priv *bat_priv);
-void vis_quit(struct bat_priv *bat_priv);
+int batadv_vis_seq_print_text(struct seq_file *seq, void *offset);
+void batadv_receive_server_sync_packet(struct bat_priv *bat_priv,
+				       struct vis_packet *vis_packet,
+				       int vis_info_len);
+void batadv_receive_client_update_packet(struct bat_priv *bat_priv,
+					 struct vis_packet *vis_packet,
+					 int vis_info_len);
+int batadv_vis_init(struct bat_priv *bat_priv);
+void batadv_vis_quit(struct bat_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_VIS_H_ */
-- 
1.7.10

