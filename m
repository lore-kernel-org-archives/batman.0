Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:39 +0200
Message-Id: <1336781383-15649-19-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 19/23] batman-adv: Prefix translation-table
	non-static functions with batadv_
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
 bat_debugfs.c           |    4 +--
 bat_iv_ogm.c            |   23 +++++++------
 bridge_loop_avoidance.c |    4 +--
 distributed-arp-table.c |    2 +-
 gateway_client.c        |    4 +--
 main.c                  |    6 ++--
 originator.c            |    4 +--
 routing.c               |   23 +++++++------
 soft-interface.c        |   10 +++---
 translation-table.c     |   88 +++++++++++++++++++++++++----------------------
 translation-table.h     |   65 ++++++++++++++++++----------------
 unicast.c               |    6 ++--
 12 files changed, 129 insertions(+), 110 deletions(-)

diff --git a/bat_debugfs.c b/bat_debugfs.c
index fe4599e..cab2425 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -242,7 +242,7 @@ static int gateways_open(struct inode *inode, struct file *file)
 static int transtable_global_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, tt_global_seq_print_text, net_dev);
+	return single_open(file, batadv_tt_global_seq_print_text, net_dev);
 }
 
 #ifdef CONFIG_BATMAN_ADV_BLA
@@ -257,7 +257,7 @@ static int bla_claim_table_open(struct inode *inode, struct file *file)
 static int transtable_local_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-	return single_open(file, tt_local_seq_print_text, net_dev);
+	return single_open(file, batadv_tt_local_seq_print_text, net_dev);
 }
 
 static int vis_data_open(struct inode *inode, struct file *file)
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index d4e94ca..2518781 100644
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
@@ -556,7 +559,7 @@ static void bat_iv_ogm_forward(struct orig_node *orig_node,
 		batman_ogm_packet->flags &= ~DIRECTLINK;
 
 	bat_iv_ogm_queue_add(bat_priv, (unsigned char *)batman_ogm_packet,
-			     BATMAN_OGM_HLEN + tt_len(tt_num_changes),
+			     BATMAN_OGM_HLEN + batadv_tt_len(tt_num_changes),
 			     if_incoming, 0, bat_iv_ogm_fwd_send_time());
 }
 
@@ -724,10 +727,10 @@ update_tt:
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
 		batadv_gw_node_update(bat_priv, orig_node,
@@ -1228,8 +1231,8 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 		bat_iv_ogm_process(ethhdr, batman_ogm_packet,
 				   tt_buff, if_incoming);
 
-		buff_pos += BATMAN_OGM_HLEN +
-				tt_len(batman_ogm_packet->tt_num_changes);
+		buff_pos += BATMAN_OGM_HLEN;
+		buff_pos += batadv_tt_len(batman_ogm_packet->tt_num_changes);
 
 		batman_ogm_packet = (struct batman_ogm_packet *)
 						(packet_buff + buff_pos);
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index c4b28af..bd356a1 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -397,8 +397,8 @@ static struct backbone_gw *bla_get_backbone_gw(struct bat_priv *bat_priv,
 	/* this is a gateway now, remove any tt entries */
 	orig_node = orig_hash_find(bat_priv, orig);
 	if (orig_node) {
-		tt_global_del_orig(bat_priv, orig_node,
-				   "became a backbone gateway");
+		batadv_tt_global_del_orig(bat_priv, orig_node,
+					  "became a backbone gateway");
 		batadv_orig_node_free_ref(orig_node);
 	}
 	return entry;
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 64b02f1..97e229d 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -557,7 +557,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct bat_priv *bat_priv,
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
 	 */
-	ret = !is_my_client(bat_priv, hw_dst);
+	ret = !batadv_is_my_client(bat_priv, hw_dst);
 out:
 	/* if ret == false packet has to be delivered to the interface */
 	return ret;
diff --git a/gateway_client.c b/gateway_client.c
index 2bf330d..e396029 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -652,8 +652,8 @@ bool batadv_gw_out_of_range(struct bat_priv *bat_priv,
 	if (!ret)
 		goto out;
 
-	orig_dst_node = transtable_search(bat_priv, ethhdr->h_source,
-					  ethhdr->h_dest);
+	orig_dst_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
+						 ethhdr->h_dest);
 	if (!orig_dst_node)
 		goto out;
 
diff --git a/main.c b/main.c
index 4921c13..a405513 100644
--- a/main.c
+++ b/main.c
@@ -115,11 +115,11 @@ int mesh_init(struct net_device *soft_iface)
 	if (ret < 0)
 		goto err;
 
-	ret = tt_init(bat_priv);
+	ret = batadv_tt_init(bat_priv);
 	if (ret < 0)
 		goto err;
 
-	tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
+	batadv_tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
 
 	ret = vis_init(bat_priv);
 	if (ret < 0)
@@ -152,7 +152,7 @@ void mesh_free(struct net_device *soft_iface)
 	batadv_gw_node_purge(bat_priv);
 	batadv_originator_free(bat_priv);
 
-	tt_free(bat_priv);
+	batadv_tt_free(bat_priv);
 
 	batadv_bla_free(bat_priv);
 
diff --git a/originator.c b/originator.c
index e6a2680..d560301 100644
--- a/originator.c
+++ b/originator.c
@@ -140,8 +140,8 @@ static void orig_node_free_rcu(struct rcu_head *rcu)
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
 	frag_list_free(&orig_node->frag_list);
-	tt_global_del_orig(orig_node->bat_priv, orig_node,
-			   "originator timed out");
+	batadv_tt_global_del_orig(orig_node->bat_priv, orig_node,
+				  "originator timed out");
 
 	kfree(orig_node->tt_buff);
 	kfree(orig_node->bcast_own);
diff --git a/routing.c b/routing.c
index db74e38..df32246 100644
--- a/routing.c
+++ b/routing.c
@@ -75,8 +75,8 @@ static void _update_route(struct bat_priv *bat_priv,
 	if ((curr_router) && (!neigh_node)) {
 		bat_dbg(DBG_ROUTES, bat_priv, "Deleting route towards: %pM\n",
 			orig_node->orig);
-		tt_global_del_orig(bat_priv, orig_node,
-				   "Deleted route towards originator");
+		batadv_tt_global_del_orig(bat_priv, orig_node,
+					  "Deleted route towards originator");
 
 	/* route added */
 	} else if ((!curr_router) && (neigh_node)) {
@@ -603,7 +603,7 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 		/* If we cannot provide an answer the tt_request is
 		 * forwarded */
-		if (!send_tt_response(bat_priv, tt_query)) {
+		if (!batadv_send_tt_response(bat_priv, tt_query)) {
 			bat_dbg(DBG_TT, bat_priv,
 				"Routing TT_REQUEST to %pM [%c]\n",
 				tt_query->dst,
@@ -620,14 +620,14 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
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
@@ -686,8 +686,9 @@ int batadv_recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 		"Received ROAMING_ADV from %pM (client %pM)\n",
 		roam_adv_packet->src, roam_adv_packet->client);
 
-	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
-		      atomic_read(&orig_node->last_ttvn) + 1, true, false);
+	batadv_tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
+			     atomic_read(&orig_node->last_ttvn) + 1, true,
+			     false);
 
 	/* Roaming phase starts: I have new information but the ttvn has not
 	 * been incremented yet. This flag will make me check all the incoming
@@ -930,13 +931,15 @@ static int check_unicast_ttvn(struct bat_priv *bat_priv,
 
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
diff --git a/soft-interface.c b/soft-interface.c
index 462c705..947a0b1 100644
--- a/soft-interface.c
+++ b/soft-interface.c
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
@@ -168,7 +168,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		goto dropped;
 
 	/* Register the client MAC in the transtable */
-	tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
+	batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
 
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
@@ -316,7 +316,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
 	soft_iface->last_rx = jiffies;
 
-	if (is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
+	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
 		goto dropped;
 
 	/* Let the bridge loop avoidance check the packet. If will
diff --git a/translation-table.c b/translation-table.c
index 46a907e..61140e2 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -173,7 +173,7 @@ static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
 	atomic_set(&bat_priv->tt_ogm_append_cnt, 0);
 }
 
-int tt_len(int changes_num)
+int batadv_tt_len(int changes_num)
 {
 	return changes_num * sizeof(struct tt_change);
 }
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
@@ -302,7 +302,7 @@ static void tt_prepare_packet_buff(struct bat_priv *bat_priv,
 	primary_if = primary_if_get_selected(bat_priv);
 
 	req_len = min_packet_len;
-	req_len += tt_len(atomic_read(&bat_priv->tt_local_changes));
+	req_len += batadv_tt_len(atomic_read(&bat_priv->tt_local_changes));
 
 	/* if we have too many changes for one packet don't send any
 	 * and wait for the tt table request which will be fragmented
@@ -332,7 +332,7 @@ static int tt_changes_fill_buff(struct bat_priv *bat_priv,
 	tt_buff = *packet_buff + min_packet_len;
 
 	if (new_len > 0)
-		tot_changes = new_len / tt_len(1);
+		tot_changes = new_len / batadv_tt_len(1);
 
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
 	atomic_set(&bat_priv->tt_local_changes, 0);
@@ -340,7 +340,7 @@ static int tt_changes_fill_buff(struct bat_priv *bat_priv,
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
 				 list) {
 		if (count < tot_changes) {
-			memcpy(tt_buff + tt_len(count),
+			memcpy(tt_buff + batadv_tt_len(count),
 			       &entry->change, sizeof(struct tt_change));
 			count++;
 		}
@@ -370,7 +370,7 @@ static int tt_changes_fill_buff(struct bat_priv *bat_priv,
 	return count;
 }
 
-int tt_local_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -445,8 +445,8 @@ static void tt_local_set_pending(struct bat_priv *bat_priv,
 		tt_local_entry->common.addr, message);
 }
 
-void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
-		     const char *message, bool roaming)
+void batadv_tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
+			    const char *message, bool roaming)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
 
@@ -611,9 +611,9 @@ static void tt_global_add_orig_entry(struct tt_global_entry *tt_global_entry,
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
@@ -677,8 +677,8 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
 
 out_remove:
 	/* remove address from local hash if present */
-	tt_local_remove(bat_priv, tt_global_entry->common.addr,
-			"global tt received", roaming);
+	batadv_tt_local_remove(bat_priv, tt_global_entry->common.addr,
+			       "global tt received", roaming);
 	ret = 1;
 out:
 	if (tt_global_entry)
@@ -714,7 +714,7 @@ static void tt_global_print_entry(struct tt_global_entry *tt_global_entry,
 	}
 }
 
-int tt_global_seq_print_text(struct seq_file *seq, void *offset)
+int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
@@ -919,8 +919,8 @@ out:
 		tt_local_entry_free_ref(tt_local_entry);
 }
 
-void tt_global_del_orig(struct bat_priv *bat_priv,
-			struct orig_node *orig_node, const char *message)
+void batadv_tt_global_del_orig(struct bat_priv *bat_priv,
+			       struct orig_node *orig_node, const char *message)
 {
 	struct tt_global_entry *tt_global_entry;
 	struct tt_common_entry *tt_common_entry;
@@ -1048,8 +1048,9 @@ static bool _is_ap_isolated(struct tt_local_entry *tt_local_entry,
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
@@ -1153,7 +1154,7 @@ static uint16_t tt_global_crc(struct bat_priv *bat_priv,
 }
 
 /* Calculates the checksum of the local table */
-uint16_t tt_local_crc(struct bat_priv *bat_priv)
+uint16_t batadv_tt_local_crc(struct bat_priv *bat_priv)
 {
 	uint16_t total = 0, total_one;
 	struct hashtable_t *hash = bat_priv->tt_local_hash;
@@ -1204,7 +1205,7 @@ static void tt_save_orig_buffer(struct bat_priv *bat_priv,
 				const unsigned char *tt_buff,
 				uint8_t tt_num_changes)
 {
-	uint16_t tt_buff_len = tt_len(tt_num_changes);
+	uint16_t tt_buff_len = batadv_tt_len(tt_num_changes);
 
 	/* Replace the old buffer only if I received something in the
 	 * last OGM (the OGM could carry no changes) */
@@ -1669,8 +1670,8 @@ out:
 	return true;
 }
 
-bool send_tt_response(struct bat_priv *bat_priv,
-		      struct tt_query_packet *tt_request)
+bool batadv_send_tt_response(struct bat_priv *bat_priv,
+			     struct tt_query_packet *tt_request)
 {
 	if (is_my_mac(tt_request->dst)) {
 		/* don't answer backbone gws! */
@@ -1689,18 +1690,19 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
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
@@ -1708,6 +1710,7 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
 				 * corrupted data on tt_request
 				 */
 				return;
+		}
 	}
 	orig_node->tt_initialised = true;
 }
@@ -1722,7 +1725,7 @@ static void tt_fill_gtable(struct bat_priv *bat_priv,
 		goto out;
 
 	/* Purge the old table first.. */
-	tt_global_del_orig(bat_priv, orig_node, "Received full table");
+	batadv_tt_global_del_orig(bat_priv, orig_node, "Received full table");
 
 	_tt_update_changes(bat_priv, orig_node,
 			   (struct tt_change *)(tt_response + 1),
@@ -1754,7 +1757,7 @@ static void tt_update_changes(struct bat_priv *bat_priv,
 	atomic_set(&orig_node->last_ttvn, ttvn);
 }
 
-bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
+bool batadv_is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
 	bool ret = false;
@@ -1773,8 +1776,8 @@ out:
 	return ret;
 }
 
-void handle_tt_response(struct bat_priv *bat_priv,
-			struct tt_query_packet *tt_response)
+void batadv_handle_tt_response(struct bat_priv *bat_priv,
+			       struct tt_query_packet *tt_response)
 {
 	struct tt_req_node *node, *safe;
 	struct orig_node *orig_node = NULL;
@@ -1821,7 +1824,7 @@ out:
 		batadv_orig_node_free_ref(orig_node);
 }
 
-int tt_init(struct bat_priv *bat_priv)
+int batadv_tt_init(struct bat_priv *bat_priv)
 {
 	int ret;
 
@@ -1983,7 +1986,7 @@ static void tt_purge(struct work_struct *work)
 	tt_start_timer(bat_priv);
 }
 
-void tt_free(struct bat_priv *bat_priv)
+void batadv_tt_free(struct bat_priv *bat_priv)
 {
 	cancel_delayed_work_sync(&bat_priv->tt_work);
 
@@ -2088,7 +2091,7 @@ static int tt_commit_changes(struct bat_priv *bat_priv,
 	/* all reset entries have to be counted as local entries */
 	atomic_add(changed_num, &bat_priv->num_local_tt);
 	tt_local_purge_pending_clients(bat_priv);
-	bat_priv->tt_crc = tt_local_crc(bat_priv);
+	bat_priv->tt_crc = batadv_tt_local_crc(bat_priv);
 
 	/* Increment the TTVN only once per OGM interval */
 	atomic_inc(&bat_priv->ttvn);
@@ -2125,7 +2128,8 @@ int batadv_tt_append_diff(struct bat_priv *bat_priv,
 	return tt_num_changes;
 }
 
-bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst)
+bool batadv_is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src,
+			   uint8_t *dst)
 {
 	struct tt_local_entry *tt_local_entry = NULL;
 	struct tt_global_entry *tt_global_entry = NULL;
@@ -2155,9 +2159,10 @@ out:
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
@@ -2221,7 +2226,8 @@ request_table:
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
index d6af2ba..aea1ce8 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -22,38 +22,45 @@
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 #define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 
-int tt_len(int changes_num);
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
-bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst);
-void tt_update_orig(struct bat_priv *bat_priv, struct orig_node *orig_node,
-		    const unsigned char *tt_buff, uint8_t tt_num_changes,
-		    uint8_t ttvn, uint16_t tt_crc);
+int batadv_tt_len(int changes_num);
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
+bool batadv_is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src,
+			   uint8_t *dst);
+void batadv_tt_update_orig(struct bat_priv *bat_priv,
+			   struct orig_node *orig_node,
+			   const unsigned char *tt_buff, uint8_t tt_num_changes,
+			   uint8_t ttvn, uint16_t tt_crc);
 int batadv_tt_append_diff(struct bat_priv *bat_priv,
 			  unsigned char **packet_buff, int *packet_buff_len,
 			  int packet_min_len);
-bool tt_global_client_is_roaming(struct bat_priv *bat_priv, uint8_t *addr);
+bool batadv_tt_global_client_is_roaming(struct bat_priv *bat_priv,
+					uint8_t *addr);
 
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/unicast.c b/unicast.c
index 0ac14ce..136e80b 100644
--- a/unicast.c
+++ b/unicast.c
@@ -366,8 +366,8 @@ int unicast_generic_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 
 	/* check for tt host - increases orig_node refcount.
 	 * returns NULL in case of AP isolation */
-	orig_node = transtable_search(bat_priv, ethhdr->h_source,
-				      ethhdr->h_dest);
+	orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
+					     ethhdr->h_dest);
 find_router:
 	/**
 	 * find_router():
@@ -399,7 +399,7 @@ find_router:
 	 * for this client. The destination will receive this packet and will
 	 * try to reroute it because the ttvn contained in the header is less
 	 * than the current one */
-	if (tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
+	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
 	/* fragmentation mechanism only works for UNICAST (now) */
-- 
1.7.10

