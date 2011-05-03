Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  3 May 2011 17:54:55 +0200
Message-Id: <1304438096-19009-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1303940106-1457-1-git-send-email-ordex@autistici.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: improved roaming mechanism
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Exploting the new announcement implementation, it has been possible to
improve the roaming mechanism and reduce the number of packet drops.

For details, please visit:
http://www.open-mesh.org/wiki/batman-adv/Roaming-improvements

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hard-interface.c    |    4 +
 main.c              |    2 +
 main.h              |    4 +
 originator.c        |    1 +
 packet.h            |   10 +++
 routing.c           |   70 ++++++++++++++++++++--
 routing.h           |    1 +
 send.c              |    1 +
 soft-interface.c    |    3 +-
 translation-table.c |  169 +++++++++++++++++++++++++++++++++++++++++++++-----
 translation-table.h |    7 ++-
 types.h             |   24 +++++++
 12 files changed, 271 insertions(+), 25 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 4fcd22e..a1cf040 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -673,6 +673,10 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	case BAT_TT_QUERY:
 		ret = recv_tt_query(skb, hard_iface);
 		break;
+		/* Roaming advertisement */
+	case BAT_ROAM_ADV:
+		ret = recv_roam_adv(skb, hard_iface);
+		break;
 	default:
 		ret = NET_RX_DROP;
 	}
diff --git a/main.c b/main.c
index a84679a..31cbecc 100644
--- a/main.c
+++ b/main.c
@@ -85,6 +85,7 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->tt_ghash_lock);
 	spin_lock_init(&bat_priv->tt_changes_list_lock);
 	spin_lock_init(&bat_priv->tt_req_list_lock);
+	spin_lock_init(&bat_priv->tt_roam_list_lock);
 	spin_lock_init(&bat_priv->tt_buff_lock);
 	spin_lock_init(&bat_priv->gw_list_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
@@ -97,6 +98,7 @@ int mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->softif_neigh_list);
 	INIT_LIST_HEAD(&bat_priv->tt_changes_list);
 	INIT_LIST_HEAD(&bat_priv->tt_req_list);
+	INIT_LIST_HEAD(&bat_priv->tt_roam_list);
 
 	if (originator_init(bat_priv) < 1)
 		goto err;
diff --git a/main.h b/main.h
index cc1c277..802d87a 100644
--- a/main.h
+++ b/main.h
@@ -55,6 +55,10 @@
 #define TT_ADD 0
 #define TT_DEL 1
 
+#define ROAMING_MAX_TIME 20 /* Time in which a client can roam at most
+			     * ROAMING_MAX_COUNT times */
+#define ROAMING_MAX_COUNT 5
+
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
diff --git a/originator.c b/originator.c
index be7257b..2cb7425 100644
--- a/originator.c
+++ b/originator.c
@@ -221,6 +221,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	/* extra reference for return */
 	atomic_set(&orig_node->refcount, 2);
 
+	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
diff --git a/packet.h b/packet.h
index de8bf3b..396a2e6 100644
--- a/packet.h
+++ b/packet.h
@@ -31,6 +31,7 @@
 #define BAT_VIS          0x05
 #define BAT_UNICAST_FRAG 0x06
 #define BAT_TT_QUERY     0x07
+#define BAT_ROAM_ADV     0x08
 
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 14
@@ -164,4 +165,13 @@ struct tt_query_packet {
 				 */
 } __packed;
 
+struct roam_adv_packet {
+	uint8_t  packet_type;
+	uint8_t  version;
+	uint8_t  dst[6];
+	uint8_t  ttl;
+	uint8_t  src[6];
+	uint8_t  client[6];
+} __packed;
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/routing.c b/routing.c
index 52107cd..39bc7b2 100644
--- a/routing.c
+++ b/routing.c
@@ -92,7 +92,7 @@ static void update_transtable(struct bat_priv *bat_priv,
 			else
 				if (!tt_global_add(bat_priv, orig_node,
 							tt_change->addr,
-							ttvn))
+							ttvn, false))
 					/* In case of problem while storing a
 					 * global_entry, we stop the updating
 					 * procedure without committing the
@@ -111,6 +111,10 @@ static void update_transtable(struct bat_priv *bat_priv,
 		 * to recompute it to spot any possible inconsistency
 		 * in the global table */
 		orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
+		/* Roaming phase is over: tables are in sync again. I can
+		 * unset the flag */
+		if (tt_num_changes)
+			orig_node->tt_poss_change = false;
 	} else {
 		/* if we missed more than one change or our tables are not
 		 * in sync anymore -> request fresh tt data */
@@ -1294,6 +1298,56 @@ out:
 	return ret;
 }
 
+int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
+{
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct roam_adv_packet *roam_adv_packet;
+	struct orig_node *orig_node;
+	struct ethhdr *ethhdr;
+	int ret = NET_RX_DROP;
+
+	/* drop packet if it has not necessary minimum size */
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct roam_adv_packet))))
+		goto out;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* packet with unicast indication but broadcast recipient */
+	if (is_broadcast_ether_addr(ethhdr->h_dest))
+		goto out;
+
+	/* packet with broadcast sender address */
+	if (is_broadcast_ether_addr(ethhdr->h_source))
+		goto out;
+
+	roam_adv_packet = (struct roam_adv_packet *)skb->data;
+
+	if (!is_my_mac(roam_adv_packet->dst))
+		return route_unicast_packet(skb, recv_if);
+
+	orig_node = orig_hash_find(bat_priv, roam_adv_packet->src);
+	if (!orig_node)
+		goto out;
+
+	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
+		      atomic_read(&orig_node->last_ttvn) + 1, true);
+
+	/* Roaming phase starts: I have a new information but the ttvn has been
+	 * incremented yet. This flag will make me check all the incoming
+	 * packets for the correct destination. */
+	bat_priv->tt_poss_change = true;
+
+	bat_dbg(DBG_ROUTES, bat_priv, "Received ROAMING_ADV from %pM "
+		"(client %pM)\n", roam_adv_packet->src,
+		roam_adv_packet->client);
+
+	orig_node_free_ref(orig_node);
+	ret = NET_RX_SUCCESS;
+out:
+	kfree(skb);
+	return ret;
+}
+
 /* find a suitable router for this originator, and use
  * bonding if possible. increases the found neighbors
  * refcount.*/
@@ -1482,35 +1536,41 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	struct ethhdr *ethhdr;
 	uint8_t curr_ttvn;
 	int16_t diff;
+	bool tt_poss_change;
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
+	/* I could need to modify it */
+	if (skb_cow(skb, sizeof(struct unicast_packet)) < 0)
+		return NET_RX_DROP;
+
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	if (is_my_mac(unicast_packet->dest))
+	if (is_my_mac(unicast_packet->dest)) {
+		tt_poss_change = bat_priv->tt_poss_change;
 		curr_ttvn = (uint8_t)atomic_read(&bat_priv->ttvn);
-	else {
+	} else {
 		orig_node = orig_hash_find(bat_priv, unicast_packet->dest);
 
 		if (!orig_node)
 			return NET_RX_DROP;
 
 		curr_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
+		tt_poss_change = orig_node->tt_poss_change;
 		orig_node_free_ref(orig_node);
 	}
 
 	diff = unicast_packet->ttvn - curr_ttvn;
 	/* Check whether I have to reroute the packet */
 	if (unicast_packet->packet_type == BAT_UNICAST &&
-	    (diff < 0 && diff > -0xff/2)) {
+	    ((diff < 0 && diff > -0xff/2) || tt_poss_change)) {
 		/* Linearize the skb before accessing it */
 		if (skb_linearize(skb) < 0)
 			return NET_RX_DROP;
 
 		ethhdr = (struct ethhdr *)(skb->data +
 			sizeof(struct unicast_packet));
-
 		orig_node = transtable_search(bat_priv, ethhdr->h_dest);
 
 		if (!orig_node) {
diff --git a/routing.h b/routing.h
index 6f6a5f8..e2943e0 100644
--- a/routing.h
+++ b/routing.h
@@ -37,6 +37,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if);
+int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if);
 struct neigh_node *find_router(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node,
 			       struct hard_iface *recv_if);
diff --git a/send.c b/send.c
index aa0ad64..3f45f39 100644
--- a/send.c
+++ b/send.c
@@ -303,6 +303,7 @@ void schedule_own_packet(struct hard_iface *hard_iface)
 			prepare_packet_buffer(bat_priv, hard_iface);
 			/* Increment the TTVN only once per OGM interval */
 			atomic_inc(&bat_priv->ttvn);
+			bat_priv->tt_poss_change = false;
 		}
 
 		/* if the changes have been sent enough times */
diff --git a/soft-interface.c b/soft-interface.c
index 96b98f7..3be105d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -366,7 +366,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	/* only modify tt-table if it has been initialised before */
 	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
 		tt_local_remove(bat_priv, dev->dev_addr,
-				"mac address changed");
+				"mac address changed", false);
 		tt_local_add(dev, addr->sa_data);
 	}
 
@@ -669,6 +669,7 @@ struct net_device *softif_create(char *name)
 
 	bat_priv->tt_buff = NULL;
 	bat_priv->tt_buff_len = 0;
+	bat_priv->tt_poss_change = false;
 
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
diff --git a/translation-table.c b/translation-table.c
index 698c3d4..b533f0a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -168,6 +168,8 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct tt_local_entry *tt_local_entry;
 	struct tt_global_entry *tt_global_entry;
+	uint8_t roam_addr[ETH_ALEN];
+	struct orig_node *roam_orig_node;
 
 	spin_lock_bh(&bat_priv->tt_lhash_lock);
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
@@ -206,12 +208,21 @@ void tt_local_add(struct net_device *soft_iface, uint8_t *addr)
 
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
 
-	if (tt_global_entry)
+	/* Check whether it is a roaming! */
+	if (tt_global_entry) {
+		memcpy(roam_addr, tt_global_entry->addr, ETH_ALEN);
+		roam_orig_node = tt_global_entry->orig_node;
+		/* This node is probably going to update its tt table */
+		tt_global_entry->orig_node->tt_poss_change = true;
 		_tt_global_del(bat_priv, tt_global_entry,
 			       "local tt received");
+		spin_unlock_bh(&bat_priv->tt_ghash_lock);
+		send_roam_adv(bat_priv, tt_global_entry->addr,
+			tt_global_entry->orig_node);
+	} else
+		spin_unlock_bh(&bat_priv->tt_ghash_lock);
 
-	spin_unlock_bh(&bat_priv->tt_ghash_lock);
-
+	return;
 unlock:
 	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 }
@@ -364,7 +375,8 @@ static void tt_local_del(struct bat_priv *bat_priv,
 	tt_local_entry_free(&tt_local_entry->hash_entry, bat_priv);
 }
 
-void tt_local_remove(struct bat_priv *bat_priv, uint8_t *addr, char *message)
+void tt_local_remove(struct bat_priv *bat_priv, uint8_t *addr,
+		     char *message, bool roaming)
 {
 	struct tt_local_entry *tt_local_entry;
 
@@ -372,7 +384,11 @@ void tt_local_remove(struct bat_priv *bat_priv, uint8_t *addr, char *message)
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 
 	if (tt_local_entry) {
-		tt_local_event(bat_priv, TT_DEL, tt_local_entry->addr);
+		if (roaming)
+			tt_local_event(bat_priv, TT_DEL, broadcast_addr);
+		else
+			tt_local_event(bat_priv, TT_DEL, tt_local_entry->addr);
+
 		tt_local_del(bat_priv, tt_local_entry, message);
 	}
 	spin_unlock_bh(&bat_priv->tt_lhash_lock);
@@ -473,7 +489,7 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
 /* caller must hold orig_node recount */
 int tt_global_add(struct bat_priv *bat_priv,
 		  struct orig_node *orig_node,
-		  unsigned char *tt_addr, uint8_t ttvn)
+		  unsigned char *tt_addr, uint8_t ttvn, bool roaming)
 {
 	struct tt_global_entry *tt_global_entry;
 	struct tt_local_entry *tt_local_entry;
@@ -520,8 +536,9 @@ int tt_global_add(struct bat_priv *bat_priv,
 	tt_local_entry = tt_local_hash_find(bat_priv, tt_addr);
 
 	if (tt_local_entry)
-		tt_local_del(bat_priv, tt_local_entry,
-			     "global tt received");
+		tt_local_remove(bat_priv, tt_global_entry->addr,
+				"global tt received", roaming);
+
 	spin_unlock_bh(&bat_priv->tt_lhash_lock);
 	return 1;
 unlock:
@@ -905,6 +922,7 @@ out:
 		kfree(tt_req_node);
 	}
 	return ret;
+
 unlock_tt:
 	spin_unlock_bh(&bat_priv->tt_req_list_lock);
 	return ret;
@@ -1245,7 +1263,7 @@ static void _tt_fill_gtable(struct bat_priv *bat_priv,
 		tt_ptr = tt_buff + (count * ETH_ALEN);
 
 		/* If we fail to allocate a new entry we return immediatly */
-		if (!tt_global_add(bat_priv, orig_node, tt_ptr, ttvn))
+		if (!tt_global_add(bat_priv, orig_node, tt_ptr, ttvn, false))
 			return;
 	}
 	atomic_set(&orig_node->last_ttvn, ttvn);
@@ -1299,7 +1317,8 @@ static void tt_update_changes(struct bat_priv *bat_priv,
 				      "tt removed by tt_response");
 		else
 			if (!tt_global_add(bat_priv, orig_node,
-				     (tt_change + i)->addr, tt_response->ttvn))
+					   (tt_change + i)->addr,
+					   tt_response->ttvn, false))
 				return;
 	}
 
@@ -1378,16 +1397,118 @@ int tt_init(struct bat_priv *bat_priv)
 	return 1;
 }
 
-void tt_free(struct bat_priv *bat_priv)
+static void tt_roam_list_free(struct bat_priv *bat_priv)
 {
-	cancel_delayed_work_sync(&bat_priv->tt_work);
+	struct tt_roam_node *node, *safe;
 
-	tt_local_table_free(bat_priv);
-	tt_global_table_free(bat_priv);
-	tt_req_list_free(bat_priv);
-	tt_changes_list_free(bat_priv);
+	spin_lock_bh(&bat_priv->tt_roam_list_lock);
 
-	kfree(bat_priv->tt_buff);
+	list_for_each_entry_safe(node, safe, &bat_priv->tt_roam_list, list) {
+		list_del(&node->list);
+		kfree(node);
+	}
+
+	spin_unlock_bh(&bat_priv->tt_roam_list_lock);
+}
+
+static void tt_roam_purge(struct bat_priv *bat_priv)
+{
+	struct tt_roam_node *node, *safe;
+
+	spin_lock_bh(&bat_priv->tt_roam_list_lock);
+	list_for_each_entry_safe(node, safe, &bat_priv->tt_roam_list, list) {
+		if (!is_out_of_time(node->first_time,
+				    ROAMING_MAX_TIME * 1000))
+			continue;
+
+		list_del(&node->list);
+		kfree(node);
+	}
+	spin_unlock_bh(&bat_priv->tt_roam_list_lock);
+}
+
+void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
+		   struct orig_node *orig_node)
+{
+	struct neigh_node *neigh_node;
+	struct sk_buff *skb;
+	struct roam_adv_packet *roam_adv_packet;
+	struct tt_roam_node *tt_roam_node;
+	bool found = false;
+	int ret = 1;
+
+	spin_lock_bh(&bat_priv->tt_roam_list_lock);
+	/* The new tt_req will be issued only if I'm not waiting for a
+	 * reply from the same orig_node yet */
+	list_for_each_entry(tt_roam_node, &bat_priv->tt_roam_list, list) {
+		if (!compare_eth(tt_roam_node->addr, client))
+			continue;
+
+		if (is_out_of_time(tt_roam_node->first_time,
+				   ROAMING_MAX_TIME * 1000))
+			continue;
+
+		if (!atomic_dec_not_zero(&tt_roam_node->counter))
+			/* Sorry, you roamed too many times! */
+			goto unlock;
+
+		found = true;
+		break;
+	}
+
+	if (!found) {
+		tt_roam_node = kmalloc(sizeof(struct tt_roam_node), GFP_ATOMIC);
+		if (!tt_roam_node)
+			goto unlock;
+
+		tt_roam_node->first_time = jiffies;
+		atomic_set(&tt_roam_node->counter, ROAMING_MAX_COUNT - 1);
+		memcpy(tt_roam_node->addr, client, ETH_ALEN);
+
+		list_add(&tt_roam_node->list, &bat_priv->tt_roam_list);
+	}
+	spin_unlock_bh(&bat_priv->tt_roam_list_lock);
+
+	skb = dev_alloc_skb(sizeof(struct roam_adv_packet) + ETH_HLEN);
+	if (!skb)
+		goto free_skb;
+
+	skb_reserve(skb, ETH_HLEN);
+
+	roam_adv_packet = (struct roam_adv_packet *)skb_put(skb,
+					sizeof(struct roam_adv_packet));
+
+	roam_adv_packet->packet_type = BAT_ROAM_ADV;
+	roam_adv_packet->version = COMPAT_VERSION;
+	roam_adv_packet->ttl = TTL;
+	memcpy(roam_adv_packet->src,
+		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(roam_adv_packet->dst, orig_node->orig, ETH_ALEN);
+	memcpy(roam_adv_packet->client, client, ETH_ALEN);
+
+	neigh_node = find_router(bat_priv, orig_node, NULL);
+	if (!neigh_node)
+		goto free_skb;
+
+	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
+		goto free_neigh;
+
+	bat_dbg(DBG_ROUTES, bat_priv,
+		"Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
+		orig_node->orig, client, neigh_node->addr);
+
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = 0;
+
+free_neigh:
+	if (neigh_node)
+		neigh_node_free_ref(neigh_node);
+free_skb:
+	if (ret)
+		kfree_skb(skb);
+	return;
+unlock:
+	spin_unlock_bh(&bat_priv->tt_roam_list_lock);
 }
 
 static void tt_purge(struct work_struct *work)
@@ -1399,6 +1520,20 @@ static void tt_purge(struct work_struct *work)
 
 	tt_local_purge(bat_priv);
 	tt_req_purge(bat_priv);
+	tt_roam_purge(bat_priv);
 
 	tt_start_timer(bat_priv);
 }
+
+void tt_free(struct bat_priv *bat_priv)
+{
+	cancel_delayed_work_sync(&bat_priv->tt_work);
+
+	tt_local_table_free(bat_priv);
+	tt_global_table_free(bat_priv);
+	tt_req_list_free(bat_priv);
+	tt_changes_list_free(bat_priv);
+	tt_roam_list_free(bat_priv);
+
+	kfree(bat_priv->tt_buff);
+}
diff --git a/translation-table.h b/translation-table.h
index 68cb1bc..7344415 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -22,6 +22,7 @@
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 #define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
 
+struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr);
 int tt_len(int changes_num);
 void tt_changes_primary_if(struct bat_priv *bat_priv, uint8_t *old_addr,
 			   uint8_t *new_addr);
@@ -30,14 +31,14 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 int tt_init(struct bat_priv *bat_priv);
 void tt_local_add(struct net_device *soft_iface, uint8_t *addr);
 void tt_local_remove(struct bat_priv *bat_priv,
-		     uint8_t *addr, char *message);
+		     uint8_t *addr, char *message, bool roaming);
 int tt_local_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_add_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node,
 			unsigned char *tt_buff, int tt_buff_len);
 int tt_global_add(struct bat_priv *bat_priv,
 		  struct orig_node *orig_node, unsigned char *addr,
-		  uint8_t ttvn);
+		  uint8_t ttvn, bool roaming);
 int tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_del_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node, char *message);
@@ -58,5 +59,7 @@ bool send_tt_response(struct bat_priv *bat_priv,
 bool is_my_client(struct bat_priv *bat_priv, uint8_t *addr);
 void handle_tt_response(struct bat_priv *bat_priv,
 			struct tt_query_packet *tt_response);
+void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
+		   struct orig_node *orig_node);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index ba97028..c1e88a4 100644
--- a/types.h
+++ b/types.h
@@ -81,6 +81,14 @@ struct orig_node {
 	int16_t tt_buff_len;
 	spinlock_t tt_buff_lock; /* protects tt_buff */
 	atomic_t tt_size;
+	bool tt_poss_change; /* this flag is needed to detect an ongoing
+			      * roaming event. If it is true, it means that
+			      * in the last OGM interval I sent a Roaming_adv,
+			      * so I have to check every packet going to it
+			      * whether the destination is still a client of
+			      * its or not, it will be reset as soon as I'll
+			      * receive a new TTVN from it */
+
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
 	unsigned long bcast_bits[NUM_WORDS];
@@ -158,6 +166,13 @@ struct bat_priv {
 	atomic_t ttvn; /* tranlation table version number */
 	atomic_t tt_ogm_append_cnt;
 	atomic_t tt_local_changes; /* changes registered in a OGM interval */
+	bool tt_poss_change; /* this flag is needed to detect an ongoing
+			      * roaming event. If it is true, it means that
+			      * in the last OGM interval I received a
+			      * Roaming_adv, so I have to check every packet
+			      * going to me whether the destination is still
+			      * a client of mine or not, it will be reset as
+			      * soon as I'll increase my TTVN */
 	char num_ifaces;
 	struct hlist_head softif_neigh_list;
 	struct softif_neigh __rcu *softif_neigh;
@@ -173,6 +188,7 @@ struct bat_priv {
 	struct hashtable_t *tt_local_hash;
 	struct hashtable_t *tt_global_hash;
 	struct list_head tt_req_list; /* list of pending tt_requests */
+	struct list_head tt_roam_list;
 	struct hashtable_t *vis_hash;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
@@ -180,6 +196,7 @@ struct bat_priv {
 	spinlock_t tt_lhash_lock; /* protects tt_local_hash */
 	spinlock_t tt_ghash_lock; /* protects tt_global_hash */
 	spinlock_t tt_req_list_lock; /* protects tt_req_list */
+	spinlock_t tt_roam_list_lock; /* protects tt_roam_list */
 	spinlock_t gw_list_lock; /* protects gw_list and curr_gw */
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
@@ -239,6 +256,13 @@ struct tt_req_node {
 	struct list_head list;
 };
 
+struct tt_roam_node {
+	uint8_t addr[ETH_ALEN];
+	atomic_t counter;
+	unsigned long first_time;
+	struct list_head list;
+};
+
 /**
  *	forw_packet - structure for forw_list maintaining packets to be
  *	              send/forwarded
-- 
1.7.3.4

