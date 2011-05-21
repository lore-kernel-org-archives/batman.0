Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 21 May 2011 23:25:06 +0200
Message-Id: <1306013107-18515-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1303940106-1457-1-git-send-email-ordex@autistici.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: improved roaming mechanism
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
Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---

- Cleaned following ecsv's patches/suggestions.

 hard-interface.c    |    4 +
 main.c              |    2 +
 main.h              |   12 +++-
 originator.c        |    1 +
 packet.h            |   10 +++
 routing.c           |   67 +++++++++++++++-
 routing.h           |    1 +
 send.c              |    1 +
 soft-interface.c    |    3 +-
 translation-table.c |  214 ++++++++++++++++++++++++++++++++++++++++++++++-----
 translation-table.h |    8 +-
 types.h             |   25 ++++++-
 12 files changed, 315 insertions(+), 33 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 5ade5a8..288d68e 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -658,6 +658,10 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
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
index 49a5e64..3318ee2 100644
--- a/main.c
+++ b/main.c
@@ -88,6 +88,7 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->tt_ghash_lock);
 	spin_lock_init(&bat_priv->tt_changes_list_lock);
 	spin_lock_init(&bat_priv->tt_req_list_lock);
+	spin_lock_init(&bat_priv->tt_roam_list_lock);
 	spin_lock_init(&bat_priv->tt_buff_lock);
 	spin_lock_init(&bat_priv->gw_list_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
@@ -101,6 +102,7 @@ int mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->softif_neigh_vids);
 	INIT_LIST_HEAD(&bat_priv->tt_changes_list);
 	INIT_LIST_HEAD(&bat_priv->tt_req_list);
+	INIT_LIST_HEAD(&bat_priv->tt_roam_list);
 
 	if (originator_init(bat_priv) < 1)
 		goto err;
diff --git a/main.h b/main.h
index 930fbdb..1207fbb 100644
--- a/main.h
+++ b/main.h
@@ -56,8 +56,16 @@
 #define TT_OGM_APPEND_MAX 3 /* number of OGMs sent with the last tt diff */
 
 /* Transtable change flags */
-#define TT_CHANGE_ADD 0x00
-#define TT_CHANGE_DEL 0x01
+#define TT_CHANGE_ADD   0x00
+#define TT_CHANGE_DEL   0x01
+#define TT_CHANGE_ROAM  0x02
+
+/* Transtable global entry flags */
+#define TT_GLOBAL_ROAM  0x01
+
+#define ROAMING_MAX_TIME 20 /* Time in which a client can roam at most
+			     * ROAMING_MAX_COUNT times */
+#define ROAMING_MAX_COUNT 5
 
 #define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
 
diff --git a/originator.c b/originator.c
index 66938fa..62d8196 100644
--- a/originator.c
+++ b/originator.c
@@ -211,6 +211,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	/* extra reference for return */
 	atomic_set(&orig_node->refcount, 2);
 
+	orig_node->tt_poss_change = false;
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
diff --git a/packet.h b/packet.h
index 525fee5..f218f0d 100644
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
 	uint16_t tt_data;
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
index e1b04a7..ed25b82 100644
--- a/routing.c
+++ b/routing.c
@@ -93,6 +93,9 @@ static void update_transtable(struct bat_priv *bat_priv,
 		spin_lock_bh(&bat_priv->tt_ghash_lock);
 		orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
 		spin_unlock_bh(&bat_priv->tt_ghash_lock);
+		/* Roaming phase is over: tables are in sync again. I can
+		 * unset the flag */
+		orig_node->tt_poss_change = false;
 	} else {
 		/* if we missed more than one change or our tables are not
 		 * in sync anymore -> request fresh tt data */
@@ -1253,6 +1256,56 @@ out:
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
+	bat_dbg(DBG_TT, bat_priv, "Received ROAMING_ADV from %pM "
+		"(client %pM)\n", roam_adv_packet->src,
+		roam_adv_packet->client);
+
+	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
+		      atomic_read(&orig_node->last_ttvn) + 1, true);
+
+	/* Roaming phase starts: I have new information but the ttvn has not
+	 * been incremented yet. This flag will make me check all the incoming
+	 * packets for the correct destination. */
+	bat_priv->tt_poss_change = true;
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
@@ -1449,35 +1502,41 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	uint8_t curr_ttvn;
 	int16_t diff;
 	struct hard_iface *primary_if;
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
+	    (seq_before(unicast_packet->ttvn, curr_ttvn) || tt_poss_change)) {
 		/* Linearize the skb before accessing it */
 		if (skb_linearize(skb) < 0)
 			return NET_RX_DROP;
 
 		ethhdr = (struct ethhdr *)(skb->data +
 			sizeof(struct unicast_packet));
-
 		orig_node = transtable_search(bat_priv, ethhdr->h_dest);
 
 		if (!orig_node) {
diff --git a/routing.h b/routing.h
index e77d464..fb14e95 100644
--- a/routing.h
+++ b/routing.h
@@ -37,6 +37,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if);
+int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if);
 struct neigh_node *find_router(struct bat_priv *bat_priv,
 			       struct orig_node *orig_node,
 			       const struct hard_iface *recv_if);
diff --git a/send.c b/send.c
index 13e5d20..0c5d671 100644
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
index 8e94273..b268f85 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -534,7 +534,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	/* only modify transtable if it has been initialised before */
 	if (atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE) {
 		tt_local_remove(bat_priv, dev->dev_addr,
-				"mac address changed");
+				"mac address changed", false);
 		tt_local_add(dev, addr->sa_data);
 	}
 
@@ -836,6 +836,7 @@ struct net_device *softif_create(const char *name)
 
 	bat_priv->tt_buff = NULL;
 	bat_priv->tt_buff_len = 0;
+	bat_priv->tt_poss_change = false;
 
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
diff --git a/translation-table.c b/translation-table.c
index 4c355b4..902635a 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -126,7 +126,7 @@ static bool is_out_of_time(unsigned long starting_time, unsigned long timeout)
 }
 
 static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
-			   const uint8_t *addr)
+			   const uint8_t *addr, uint8_t roaming)
 {
 	struct tt_change_node *tt_change_node;
 
@@ -137,6 +137,9 @@ static void tt_local_event(struct bat_priv *bat_priv, uint8_t op,
 		return;
 
 	tt_change_node->change.flags = op;
+	if (roaming)
+		tt_change_node->change.flags |= TT_GLOBAL_ROAM;
+
 	memcpy(tt_change_node->change.addr, addr, ETH_ALEN);
 
 	spin_lock_bh(&bat_priv->tt_changes_list_lock);
@@ -171,6 +174,8 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct tt_local_entry *tt_local_entry;
 	struct tt_global_entry *tt_global_entry;
+	uint8_t roam_addr[ETH_ALEN];
+	struct orig_node *roam_orig_node;
 
 	spin_lock_bh(&bat_priv->tt_lhash_lock);
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
@@ -184,7 +189,7 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 	if (!tt_local_entry)
 		goto unlock;
 
-	tt_local_event(bat_priv, TT_CHANGE_ADD, addr);
+	tt_local_event(bat_priv, TT_CHANGE_ADD, addr, false);
 
 	bat_dbg(DBG_TT, bat_priv,
 		"Creating new local tt entry: %pM (ttvn: %d)\n", addr,
@@ -209,11 +214,20 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 
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
 	return;
 unlock:
 	spin_unlock_bh(&bat_priv->tt_lhash_lock);
@@ -368,7 +382,7 @@ static void tt_local_del(struct bat_priv *bat_priv,
 }
 
 void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
-		     const char *message)
+		     const char *message, bool roaming)
 {
 	struct tt_local_entry *tt_local_entry;
 
@@ -376,7 +390,8 @@ void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 
 	if (tt_local_entry) {
-		tt_local_event(bat_priv, TT_CHANGE_DEL, tt_local_entry->addr);
+		tt_local_event(bat_priv, TT_CHANGE_DEL, tt_local_entry->addr,
+			       roaming);
 		tt_local_del(bat_priv, tt_local_entry, message);
 	}
 	spin_unlock_bh(&bat_priv->tt_lhash_lock);
@@ -405,7 +420,7 @@ static void tt_local_purge(struct bat_priv *bat_priv)
 				continue;
 
 			tt_local_event(bat_priv, TT_CHANGE_DEL,
-				       tt_local_entry->addr);
+				       tt_local_entry->addr, false);
 			tt_local_del(bat_priv, tt_local_entry,
 				     "address timed out");
 		}
@@ -478,7 +493,7 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
 /* caller must hold orig_node recount */
 int tt_global_add(struct bat_priv *bat_priv,
 		  struct orig_node *orig_node,
-		  const unsigned char *tt_addr, uint8_t ttvn)
+		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming)
 {
 	struct tt_global_entry *tt_global_entry;
 	struct tt_local_entry *tt_local_entry;
@@ -498,6 +513,7 @@ int tt_global_add(struct bat_priv *bat_priv,
 		atomic_inc(&orig_node->refcount);
 		tt_global_entry->orig_node = orig_node;
 		tt_global_entry->ttvn = ttvn;
+		tt_global_entry->flags = 0x00;
 		atomic_inc(&orig_node->tt_size);
 		hash_add(bat_priv->tt_global_hash, compare_gtt,
 			 choose_orig, tt_global_entry,
@@ -509,6 +525,7 @@ int tt_global_add(struct bat_priv *bat_priv,
 			atomic_inc(&orig_node->refcount);
 			tt_global_entry->orig_node = orig_node;
 			tt_global_entry->ttvn = ttvn;
+			tt_global_entry->flags = 0x00;
 			orig_node_free_ref(orig_node_tmp);
 			atomic_inc(&orig_node->tt_size);
 		}
@@ -525,8 +542,9 @@ int tt_global_add(struct bat_priv *bat_priv,
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
@@ -639,7 +657,7 @@ static void _tt_global_del(struct bat_priv *bat_priv,
 
 void tt_global_del(struct bat_priv *bat_priv,
 		   struct orig_node *orig_node, const unsigned char *addr,
-		   const char *message)
+		   const char *message, bool roaming)
 {
 	struct tt_global_entry *tt_global_entry;
 
@@ -647,9 +665,14 @@ void tt_global_del(struct bat_priv *bat_priv,
 	tt_global_entry = tt_global_hash_find(bat_priv, addr);
 
 	if (tt_global_entry && tt_global_entry->orig_node == orig_node) {
+		if (roaming) {
+			tt_global_entry->flags |= TT_GLOBAL_ROAM;
+			goto out;
+		}
 		atomic_dec(&orig_node->tt_size);
 		_tt_global_del(bat_priv, tt_global_entry, message);
 	}
+out:
 	spin_unlock_bh(&bat_priv->tt_ghash_lock);
 }
 
@@ -736,6 +759,12 @@ uint16_t tt_global_crc(struct bat_priv *bat_priv, struct orig_node *orig_node)
 					 head, hash_entry) {
 			if (compare_eth(tt_global_entry->orig_node,
 					orig_node)) {
+				/* Roaming clients are in the global table for
+				 * consistency only. They don't have to be
+				 * taken into account while computing the
+				 * global crc */
+				if (tt_global_entry->flags & TT_GLOBAL_ROAM)
+					continue;
 				total_one = 0;
 				for (j = 0; j < ETH_ALEN; j++)
 					total_one = crc16_byte(total_one,
@@ -1251,7 +1280,7 @@ static void _tt_fill_gtable(struct bat_priv *bat_priv,
 		tt_ptr = tt_buff + (count * ETH_ALEN);
 
 		/* If we fail to allocate a new entry we return immediatly */
-		if (!tt_global_add(bat_priv, orig_node, tt_ptr, ttvn))
+		if (!tt_global_add(bat_priv, orig_node, tt_ptr, ttvn, false))
 			return;
 	}
 	atomic_set(&orig_node->last_ttvn, ttvn);
@@ -1296,10 +1325,17 @@ void tt_update_changes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		if ((tt_change + i)->flags & TT_CHANGE_DEL)
 			tt_global_del(bat_priv, orig_node,
 				      (tt_change + i)->addr,
-				      "tt removed by changes");
+				      "tt removed by changes",
+				      (tt_change + i)->flags & TT_CHANGE_ROAM);
 		else
 			if (!tt_global_add(bat_priv, orig_node,
-					   (tt_change + i)->addr, ttvn))
+					   (tt_change + i)->addr, ttvn, false))
+				/* In case of problem while storing a
+				 * global_entry, we stop the updating
+				 * procedure without committing the
+				 * ttvn change. This will avoid to send
+				 * corrupted data on tt_request
+				 */
 				return;
 	}
 
@@ -1358,6 +1394,9 @@ void handle_tt_response(struct bat_priv *bat_priv,
 	spin_lock_bh(&bat_priv->tt_ghash_lock);
 	orig_node->tt_crc = tt_global_crc(bat_priv, orig_node);
 	spin_unlock_bh(&bat_priv->tt_ghash_lock);
+	/* Roaming phase is over: tables are in sync again. I can
+	 * unset the flag */
+	orig_node->tt_poss_change = false;
 out:
 	if (orig_node)
 		orig_node_free_ref(orig_node);
@@ -1376,16 +1415,135 @@ int tt_init(struct bat_priv *bat_priv)
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
+/* This function checks whether the client already reached the
+ * maximum number of possible roaming phases. In this case the ROAMING_ADV
+ * will not be sent.
+ *
+ * returns true if the ROAMING_ADV can be sent, false otherwise */
+static bool tt_check_roam_count(struct bat_priv *bat_priv,
+				uint8_t *client)
+{
+	struct tt_roam_node *tt_roam_node;
+	bool ret = false;
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
+		ret = true;
+		break;
+	}
+
+	if (!ret) {
+		tt_roam_node = kmalloc(sizeof(*tt_roam_node), GFP_ATOMIC);
+		if (!tt_roam_node)
+			goto unlock;
+
+		tt_roam_node->first_time = jiffies;
+		atomic_set(&tt_roam_node->counter, ROAMING_MAX_COUNT - 1);
+		memcpy(tt_roam_node->addr, client, ETH_ALEN);
+
+		list_add(&tt_roam_node->list, &bat_priv->tt_roam_list);
+		ret = true;
+	}
+
+unlock:
+	spin_unlock_bh(&bat_priv->tt_roam_list_lock);
+	return ret;
+}
+
+void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
+		   struct orig_node *orig_node)
+{
+	struct neigh_node *neigh_node = NULL;
+	struct sk_buff *skb = NULL;
+	struct roam_adv_packet *roam_adv_packet;
+	int ret = 1;
+	struct hard_iface *primary_if;
+
+	/* before going on we have to check whether the client has
+	 * already roamed to us too many times */
+	if (!tt_check_roam_count(bat_priv, client))
+		goto out;
+
+	skb = dev_alloc_skb(sizeof(struct roam_adv_packet) + ETH_HLEN);
+	if (!skb)
+		goto out;
+
+	skb_reserve(skb, ETH_HLEN);
+
+	roam_adv_packet = (struct roam_adv_packet *)skb_put(skb,
+					sizeof(struct roam_adv_packet));
+
+	roam_adv_packet->packet_type = BAT_ROAM_ADV;
+	roam_adv_packet->version = COMPAT_VERSION;
+	roam_adv_packet->ttl = TTL;
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+	memcpy(roam_adv_packet->src,
+		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	hardif_free_ref(primary_if);
+	memcpy(roam_adv_packet->dst, orig_node->orig, ETH_ALEN);
+	memcpy(roam_adv_packet->client, client, ETH_ALEN);
+
+	neigh_node = orig_node_get_router(orig_node);
+	if (!neigh_node)
+		goto out;
+
+	bat_dbg(DBG_TT, bat_priv,
+		"Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
+		orig_node->orig, client, neigh_node->addr);
+
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = 0;
+
+out:
+	if (neigh_node)
+		neigh_node_free_ref(neigh_node);
+	if (ret)
+		kfree_skb(skb);
+	return;
 }
 
 static void tt_purge(struct work_struct *work)
@@ -1397,6 +1555,20 @@ static void tt_purge(struct work_struct *work)
 
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
index 51f7e30..1cd2d39 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -28,20 +28,20 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
 int tt_init(struct bat_priv *bat_priv);
 void tt_local_add(struct net_device *soft_iface, const uint8_t *addr);
 void tt_local_remove(struct bat_priv *bat_priv,
-		     const uint8_t *addr, const char *message);
+		     const uint8_t *addr, const char *message, bool roaming);
 int tt_local_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_add_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node,
 			const unsigned char *tt_buff, int tt_buff_len);
 int tt_global_add(struct bat_priv *bat_priv,
 		  struct orig_node *orig_node, const unsigned char *addr,
-		  uint8_t ttvn);
+		  uint8_t ttvn, bool roaming);
 int tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void tt_global_del_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node, const char *message);
 void tt_global_del(struct bat_priv *bat_priv,
 		   struct orig_node *orig_node, const unsigned char *addr,
-		   const char *message);
+		   const char *message, bool roaming);
 struct orig_node *transtable_search(struct bat_priv *bat_priv,
 				    const uint8_t *addr);
 void tt_save_orig_buffer(struct bat_priv *bat_priv, struct orig_node *orig_node,
@@ -60,5 +60,7 @@ void tt_update_changes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr);
 void handle_tt_response(struct bat_priv *bat_priv,
 			struct tt_query_packet *tt_response);
+void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
+		   struct orig_node *orig_node);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index 0848fcc..8f05632 100644
--- a/types.h
+++ b/types.h
@@ -81,6 +81,12 @@ struct orig_node {
 	int16_t tt_buff_len;
 	spinlock_t tt_buff_lock; /* protects tt_buff */
 	atomic_t tt_size;
+	/* The tt_poss_change flag is used to detect an ongoing roaming phase.
+	 * If true, then I sent a Roaming_adv to this orig_node and I have to
+	 * inspect every packet directed to it to check whether it is still
+	 * the true destination or not. This flag will be reset to false as
+	 * soon as I receive a new TTVN from this orig_node */
+	bool tt_poss_change;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
 	unsigned long bcast_bits[NUM_WORDS];
@@ -158,6 +164,12 @@ struct bat_priv {
 	atomic_t ttvn; /* tranlation table version number */
 	atomic_t tt_ogm_append_cnt;
 	atomic_t tt_local_changes; /* changes registered in a OGM interval */
+	/* The tt_poss_change flag is used to detect an ongoing roaming phase.
+	 * If true, then I received a Roaming_adv and I have to inspect every
+	 * packet directed to me to check whether I am still the true
+	 * destination or not. This flag will be reset to false as soon as I
+	 * increase my TTVN */
+	bool tt_poss_change;
 	char num_ifaces;
 	struct debug_log *debug_log;
 	struct kobject *mesh_obj;
@@ -172,6 +184,7 @@ struct bat_priv {
 	struct hashtable_t *tt_local_hash;
 	struct hashtable_t *tt_global_hash;
 	struct list_head tt_req_list; /* list of pending tt_requests */
+	struct list_head tt_roam_list;
 	struct hashtable_t *vis_hash;
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
@@ -179,6 +192,7 @@ struct bat_priv {
 	spinlock_t tt_lhash_lock; /* protects tt_local_hash */
 	spinlock_t tt_ghash_lock; /* protects tt_global_hash */
 	spinlock_t tt_req_list_lock; /* protects tt_req_list */
+	spinlock_t tt_roam_list_lock; /* protects tt_roam_list */
 	spinlock_t gw_list_lock; /* protects gw_list and curr_gw */
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
@@ -224,8 +238,8 @@ struct tt_global_entry {
 	uint8_t addr[ETH_ALEN];
 	struct orig_node *orig_node;
 	uint8_t ttvn;
-	/* entry in the global table */
-	struct hlist_node hash_entry;
+	uint8_t flags; /* only TT_GLOBAL_ROAM is used */
+	struct hlist_node hash_entry; /* entry in the global table */
 };
 
 struct tt_change_node {
@@ -239,6 +253,13 @@ struct tt_req_node {
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

