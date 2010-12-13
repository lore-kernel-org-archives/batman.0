Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 13 Dec 2010 01:18:56 +0100
Message-Id: <1292199536-4644-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201012130118.14949.lindner_marek@yahoo.de>
References: <201012130118.14949.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: remove orig_hash spinlock
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/icmp_socket.c       |   35 +++---
 batman-adv/main.c              |    1 -
 batman-adv/originator.c        |   21 ---
 batman-adv/routing.c           |  313 +++++++++++++++++++++-------------------
 batman-adv/translation-table.c |    4 +
 batman-adv/types.h             |    1 -
 batman-adv/unicast.c           |   96 ++++++++-----
 batman-adv/vis.c               |   59 ++++----
 8 files changed, 270 insertions(+), 260 deletions(-)

diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index a9a10ed..3598f2b 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -157,10 +157,9 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	struct sk_buff *skb;
 	struct icmp_packet_rr *icmp_packet;
 
-	struct orig_node *orig_node;
-	struct batman_if *batman_if;
+	struct orig_node *orig_node = NULL;
+	struct neigh_node *neigh_node = NULL;
 	size_t packet_len = sizeof(struct icmp_packet);
-	uint8_t dstaddr[ETH_ALEN];
 
 	if (len < sizeof(struct icmp_packet)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -220,49 +219,51 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (atomic_read(&bat_priv->mesh_state) != MESH_ACTIVE)
 		goto dst_unreach;
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   compare_orig, choose_orig,
 						   icmp_packet->dst));
-	rcu_read_unlock();
 
 	if (!orig_node)
 		goto unlock;
 
-	if (!orig_node->router)
-		goto unlock;
+	kref_get(&orig_node->refcount);
+	neigh_node = orig_node->router;
 
-	batman_if = orig_node->router->if_incoming;
-	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+	if (!neigh_node)
+		goto unlock;
 
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	kref_get(&neigh_node->refcount);
+	rcu_read_unlock();
 
-	if (!batman_if)
+	if (!neigh_node->if_incoming)
 		goto dst_unreach;
 
-	if (batman_if->if_status != IF_ACTIVE)
+	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
 		goto dst_unreach;
 
 	memcpy(icmp_packet->orig,
 	       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 
 	if (packet_len == sizeof(struct icmp_packet_rr))
-		memcpy(icmp_packet->rr, batman_if->net_dev->dev_addr, ETH_ALEN);
-
-
-	send_skb_packet(skb, batman_if, dstaddr);
+		memcpy(icmp_packet->rr,
+		       neigh_node->if_incoming->net_dev->dev_addr, ETH_ALEN);
 
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	goto out;
 
 unlock:
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	rcu_read_unlock();
 dst_unreach:
 	icmp_packet->msg_type = DESTINATION_UNREACHABLE;
 	bat_socket_add_packet(socket_client, icmp_packet, packet_len);
 free_skb:
 	kfree_skb(skb);
 out:
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return len;
 }
 
diff --git a/batman-adv/main.c b/batman-adv/main.c
index b827f6a..cb3c3a3 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -80,7 +80,6 @@ int mesh_init(struct net_device *soft_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 
-	spin_lock_init(&bat_priv->orig_hash_lock);
 	spin_lock_init(&bat_priv->forw_bat_list_lock);
 	spin_lock_init(&bat_priv->forw_bcast_list_lock);
 	spin_lock_init(&bat_priv->hna_lhash_lock);
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 332dce1..899ab0b 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -44,18 +44,15 @@ int originator_init(struct bat_priv *bat_priv)
 	if (bat_priv->orig_hash)
 		return 1;
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	bat_priv->orig_hash = hash_new(1024);
 
 	if (!bat_priv->orig_hash)
 		goto err;
 
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	start_purge_timer(bat_priv);
 	return 1;
 
 err:
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return 0;
 }
 
@@ -146,7 +143,6 @@ void originator_free(struct bat_priv *bat_priv)
 
 	cancel_delayed_work_sync(&bat_priv->orig_work);
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	bat_priv->orig_hash = NULL;
 
 	for (i = 0; i < hash->size; i++) {
@@ -165,7 +161,6 @@ void originator_free(struct bat_priv *bat_priv)
 	}
 
 	hash_destroy(hash);
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
 void bucket_free_orig_rcu(struct rcu_head *rcu)
@@ -343,8 +338,6 @@ static void _purge_orig(struct bat_priv *bat_priv)
 	if (!hash)
 		return;
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
-
 	/* for all origins... */
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -369,8 +362,6 @@ static void _purge_orig(struct bat_priv *bat_priv)
 		spin_unlock_bh(list_lock);
 	}
 
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
-
 	gw_node_purge(bat_priv);
 	gw_election(bat_priv);
 
@@ -428,8 +419,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
 		   "outgoingIF", "Potential nexthops");
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
-
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
@@ -467,8 +456,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		rcu_read_unlock();
 	}
 
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
-
 	if ((batman_count == 0))
 		seq_printf(seq, "No batman nodes in range ...\n");
 
@@ -517,8 +504,6 @@ int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock_bh(&bat_priv->orig_hash_lock);
-
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
@@ -536,12 +521,10 @@ int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 		rcu_read_unlock();
 	}
 
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return 0;
 
 err:
 	rcu_read_unlock();
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return -ENOMEM;
 }
 
@@ -610,8 +593,6 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
-	spin_lock_bh(&bat_priv->orig_hash_lock);
-
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
@@ -648,11 +629,9 @@ int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 	rcu_read_unlock();
 
 	batman_if->if_num = -1;
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return 0;
 
 err:
 	rcu_read_unlock();
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	return -ENOMEM;
 }
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index f0e658a..557e7d7 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -48,8 +48,6 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 	int i;
 	size_t word_index;
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
-
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
@@ -67,8 +65,6 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 		}
 		rcu_read_unlock();
 	}
-
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
 static void update_HNA(struct bat_priv *bat_priv, struct orig_node *orig_node,
@@ -785,7 +781,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 			   orig_node :
 			   get_orig_node(bat_priv, ethhdr->h_source));
 	if (!orig_neigh_node)
-		goto out_neigh;
+		goto out;
 
 	/* drop packet if sender is not a direct neighbor and if we
 	 * don't route towards it */
@@ -842,7 +838,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				0, hna_buff_len, if_incoming);
 
 out_neigh:
-	if (!is_single_hop_neigh)
+	if ((orig_neigh_node) && (!is_single_hop_neigh))
 		kref_put(&orig_neigh_node->refcount, orig_node_free_ref);
 out:
 	kref_put(&orig_node->refcount, orig_node_free_ref);
@@ -850,7 +846,6 @@ out:
 
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
 {
-	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
@@ -877,12 +872,10 @@ int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	receive_aggr_bat_packet(ethhdr,
 				skb->data,
 				skb_headlen(skb),
 				batman_if);
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 	kfree_skb(skb);
 	return NET_RX_SUCCESS;
@@ -891,12 +884,11 @@ int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
 static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 			       struct sk_buff *skb, size_t icmp_len)
 {
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
+	struct neigh_node *neigh_node = NULL;
 	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
-	struct batman_if *batman_if;
-	int ret;
-	uint8_t dstaddr[ETH_ALEN];
+	int ret = NET_RX_DROP;
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
@@ -904,61 +896,65 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	/* add data to device queue */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
 		bat_socket_receive_packet(icmp_packet, icmp_len);
-		return NET_RX_DROP;
+		goto out;
 	}
 
 	if (!bat_priv->primary_if)
-		return NET_RX_DROP;
+		goto out;
 
 	/* answer echo request (ping) */
 	/* get routing information */
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   compare_orig, choose_orig,
 						   icmp_packet->orig));
-	rcu_read_unlock();
-	ret = NET_RX_DROP;
+	if (!orig_node)
+		goto unlock;
 
-	if ((orig_node) && (orig_node->router)) {
+	kref_get(&orig_node->refcount);
+	neigh_node = orig_node->router;
 
-		/* don't lock while sending the packets ... we therefore
-		 * copy the required data before sending */
-		batman_if = orig_node->router->if_incoming;
-		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+	if (!neigh_node)
+		goto unlock;
 
-		/* create a copy of the skb, if needed, to modify it. */
-		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
-			return NET_RX_DROP;
+	kref_get(&neigh_node->refcount);
+	rcu_read_unlock();
 
-		icmp_packet = (struct icmp_packet_rr *)skb->data;
-		ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+		goto out;
 
-		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-		memcpy(icmp_packet->orig,
-		       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
-		icmp_packet->msg_type = ECHO_REPLY;
-		icmp_packet->ttl = TTL;
+	icmp_packet = (struct icmp_packet_rr *)skb->data;
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-		send_skb_packet(skb, batman_if, dstaddr);
-		ret = NET_RX_SUCCESS;
+	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
+	memcpy(icmp_packet->orig,
+		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	icmp_packet->msg_type = ECHO_REPLY;
+	icmp_packet->ttl = TTL;
 
-	} else
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = NET_RX_SUCCESS;
+	goto out;
 
+unlock:
+	rcu_read_unlock();
+out:
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
 }
 
 static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 				  struct sk_buff *skb, size_t icmp_len)
 {
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
+	struct neigh_node *neigh_node = NULL;
 	struct icmp_packet *icmp_packet;
 	struct ethhdr *ethhdr;
-	struct batman_if *batman_if;
-	int ret;
-	uint8_t dstaddr[ETH_ALEN];
+	int ret = NET_RX_DROP;
 
 	icmp_packet = (struct icmp_packet *)skb->data;
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
@@ -968,48 +964,53 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		pr_debug("Warning - can't forward icmp packet from %pM to "
 			 "%pM: ttl exceeded\n", icmp_packet->orig,
 			 icmp_packet->dst);
-		return NET_RX_DROP;
+		goto out;
 	}
 
 	if (!bat_priv->primary_if)
-		return NET_RX_DROP;
+		goto out;
 
 	/* get routing information */
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       icmp_packet->orig));
-	rcu_read_unlock();
-	ret = NET_RX_DROP;
+	if (!orig_node)
+		goto unlock;
 
-	if ((orig_node) && (orig_node->router)) {
+	kref_get(&orig_node->refcount);
+	neigh_node = orig_node->router;
 
-		/* don't lock while sending the packets ... we therefore
-		 * copy the required data before sending */
-		batman_if = orig_node->router->if_incoming;
-		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+	if (!neigh_node)
+		goto unlock;
 
-		/* create a copy of the skb, if needed, to modify it. */
-		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
-			return NET_RX_DROP;
+	kref_get(&neigh_node->refcount);
+	rcu_read_unlock();
 
-		icmp_packet = (struct icmp_packet *) skb->data;
-		ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+		goto out;
 
-		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-		memcpy(icmp_packet->orig,
-		       bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
-		icmp_packet->msg_type = TTL_EXCEEDED;
-		icmp_packet->ttl = TTL;
+	icmp_packet = (struct icmp_packet *)skb->data;
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-		send_skb_packet(skb, batman_if, dstaddr);
-		ret = NET_RX_SUCCESS;
+	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
+	memcpy(icmp_packet->orig,
+		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	icmp_packet->msg_type = TTL_EXCEEDED;
+	icmp_packet->ttl = TTL;
 
-	} else
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = NET_RX_SUCCESS;
+	goto out;
 
+unlock:
+	rcu_read_unlock();
+out:
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
 }
 
@@ -1019,11 +1020,10 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
-	struct orig_node *orig_node;
-	struct batman_if *batman_if;
+	struct orig_node *orig_node = NULL;
+	struct neigh_node *neigh_node = NULL;
 	int hdr_size = sizeof(struct icmp_packet);
-	int ret;
-	uint8_t dstaddr[ETH_ALEN];
+	int ret = NET_RX_DROP;
 
 	/**
 	 * we truncate all incoming icmp packets if they don't match our size
@@ -1033,21 +1033,21 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
-		return NET_RX_DROP;
+		goto out;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with unicast indication but broadcast recipient */
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
-		return NET_RX_DROP;
+		goto out;
 
 	/* packet with broadcast sender address */
 	if (is_broadcast_ether_addr(ethhdr->h_source))
-		return NET_RX_DROP;
+		goto out;
 
 	/* not for me */
 	if (!is_my_mac(ethhdr->h_dest))
-		return NET_RX_DROP;
+		goto out;
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
 
@@ -1067,41 +1067,45 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (icmp_packet->ttl < 2)
 		return recv_icmp_ttl_exceeded(bat_priv, skb, hdr_size);
 
-	ret = NET_RX_DROP;
-
 	/* get routing information */
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       icmp_packet->dst));
-	rcu_read_unlock();
+	if (!orig_node)
+		goto unlock;
 
-	if ((orig_node) && (orig_node->router)) {
+	kref_get(&orig_node->refcount);
+	neigh_node = orig_node->router;
 
-		/* don't lock while sending the packets ... we therefore
-		 * copy the required data before sending */
-		batman_if = orig_node->router->if_incoming;
-		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+	if (!neigh_node)
+		goto unlock;
 
-		/* create a copy of the skb, if needed, to modify it. */
-		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
-			return NET_RX_DROP;
+	kref_get(&neigh_node->refcount);
+	rcu_read_unlock();
 
-		icmp_packet = (struct icmp_packet_rr *)skb->data;
-		ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+		goto out;
 
-		/* decrement ttl */
-		icmp_packet->ttl--;
+	icmp_packet = (struct icmp_packet_rr *)skb->data;
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-		/* route it */
-		send_skb_packet(skb, batman_if, dstaddr);
-		ret = NET_RX_SUCCESS;
+	/* decrement ttl */
+	icmp_packet->ttl--;
 
-	} else
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+	/* route it */
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = NET_RX_SUCCESS;
+	goto out;
 
+unlock:
+	rcu_read_unlock();
+out:
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
 }
 
@@ -1231,13 +1235,11 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 			 int hdr_size)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct orig_node *orig_node;
-	struct neigh_node *router;
-	struct batman_if *batman_if;
-	uint8_t dstaddr[ETH_ALEN];
+	struct orig_node *orig_node = NULL;
+	struct neigh_node *neigh_node = NULL;
 	struct unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
-	int ret;
+	int ret = NET_RX_DROP;
 	struct sk_buff *new_skb;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
@@ -1247,55 +1249,54 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 		pr_debug("Warning - can't forward unicast packet from %pM to "
 			 "%pM: ttl exceeded\n", ethhdr->h_source,
 			 unicast_packet->dest);
-		return NET_RX_DROP;
+		goto out;
 	}
 
 	/* get routing information */
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       unicast_packet->dest));
-	rcu_read_unlock();
 
-	router = find_router(bat_priv, orig_node, recv_if);
-
-	if (!router) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
+	if (!orig_node)
+		goto unlock;
 
-	/* don't lock while sending the packets ... we therefore
-	 * copy the required data before sending */
+	kref_get(&orig_node->refcount);
+	neigh_node = find_router(bat_priv, orig_node, recv_if);
 
-	batman_if = router->if_incoming;
-	memcpy(dstaddr, router->addr, ETH_ALEN);
+	if (!neigh_node)
+		goto unlock;
 
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	kref_get(&neigh_node->refcount);
+	rcu_read_unlock();
 
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
-		return NET_RX_DROP;
+		goto out;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
 	if (unicast_packet->packet_type == BAT_UNICAST &&
 	    atomic_read(&bat_priv->fragmentation) &&
-	    skb->len > batman_if->net_dev->mtu)
-		return frag_send_skb(skb, bat_priv, batman_if,
-				     dstaddr);
+	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
+		ret = frag_send_skb(skb, bat_priv,
+				    neigh_node->if_incoming, neigh_node->addr);
+		goto out;
+	}
 
 	if (unicast_packet->packet_type == BAT_UNICAST_FRAG &&
-	    2 * skb->len - hdr_size <= batman_if->net_dev->mtu) {
+	    2 * skb->len - hdr_size <= neigh_node->if_incoming->net_dev->mtu) {
 
 		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
 
 		if (ret == NET_RX_DROP)
-			return NET_RX_DROP;
+			goto out;
 
 		/* packet was buffered for late merge */
-		if (!new_skb)
-			return NET_RX_SUCCESS;
+		if (!new_skb) {
+			ret = NET_RX_SUCCESS;
+			goto out;
+		}
 
 		skb = new_skb;
 		unicast_packet = (struct unicast_packet *)skb->data;
@@ -1305,9 +1306,18 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	unicast_packet->ttl--;
 
 	/* route it */
-	send_skb_packet(skb, batman_if, dstaddr);
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = NET_RX_SUCCESS;
+	goto out;
 
-	return NET_RX_SUCCESS;
+unlock:
+	rcu_read_unlock();
+out:
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
+	return ret;
 }
 
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
@@ -1366,81 +1376,82 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
-	struct orig_node *orig_node;
+	struct orig_node *orig_node = NULL;
 	struct bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct bcast_packet);
+	int ret = NET_RX_DROP;
 	int32_t seq_diff;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
-		return NET_RX_DROP;
+		goto out;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
-		return NET_RX_DROP;
+		goto out;
 
 	/* packet with broadcast sender address */
 	if (is_broadcast_ether_addr(ethhdr->h_source))
-		return NET_RX_DROP;
+		goto out;
 
 	/* ignore broadcasts sent by myself */
 	if (is_my_mac(ethhdr->h_source))
-		return NET_RX_DROP;
+		goto out;
 
 	bcast_packet = (struct bcast_packet *)skb->data;
 
 	/* ignore broadcasts originated by myself */
 	if (is_my_mac(bcast_packet->orig))
-		return NET_RX_DROP;
+		goto out;
 
 	if (bcast_packet->ttl < 2)
-		return NET_RX_DROP;
+		goto out;
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       bcast_packet->orig));
-	rcu_read_unlock();
 
-	if (!orig_node) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
+	if (!orig_node)
+		goto unlock;
+
+	kref_get(&orig_node->refcount);
+	rcu_read_unlock();
 
 	/* check whether the packet is a duplicate */
-	if (get_bit_status(orig_node->bcast_bits,
-			   orig_node->last_bcast_seqno,
-			   ntohl(bcast_packet->seqno))) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
+	if (get_bit_status(orig_node->bcast_bits, orig_node->last_bcast_seqno,
+			   ntohl(bcast_packet->seqno)))
+		goto out;
 
 	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
 
 	/* check whether the packet is old and the host just restarted. */
 	if (window_protected(bat_priv, seq_diff,
-			     &orig_node->bcast_seqno_reset)) {
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
-		return NET_RX_DROP;
-	}
+			     &orig_node->bcast_seqno_reset))
+		goto out;
 
 	/* mark broadcast in flood history, update window position
 	 * if required. */
 	if (bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 	/* rebroadcast packet */
 	add_bcast_packet_to_list(bat_priv, skb);
 
 	/* broadcast for me */
 	interface_rx(recv_if->soft_iface, skb, recv_if, hdr_size);
+	ret = NET_RX_SUCCESS;
+	goto out;
 
-	return NET_RX_SUCCESS;
+unlock:
+	rcu_read_unlock();
+out:
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
+	return ret;
 }
 
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if)
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index 6f6ee58..f299957 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -538,6 +538,10 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
 	hna_global_entry = (struct hna_global_entry *)
 				hash_find(bat_priv->hna_global_hash,
 					  compare_orig, choose_orig, addr);
+
+	if (hna_global_entry)
+		kref_get(&hna_global_entry->orig_node->refcount);
+
 	rcu_read_unlock();
 	spin_unlock_bh(&bat_priv->hna_ghash_lock);
 
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 11f6b65..52b6b08 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -157,7 +157,6 @@ struct bat_priv {
 	struct hashtable_t *hna_local_hash;
 	struct hashtable_t *hna_global_hash;
 	struct hashtable_t *vis_hash;
-	spinlock_t orig_hash_lock; /* protects orig_hash */
 	spinlock_t forw_bat_list_lock; /* protects forw_bat_list */
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t hna_lhash_lock; /* protects hna_local_hash */
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 0b2ea82..67bed2d 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -178,17 +178,16 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 		(struct unicast_frag_packet *)skb->data;
 
 	*new_skb = NULL;
-	spin_lock_bh(&bat_priv->orig_hash_lock);
+
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		    hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			      unicast_packet->orig));
-	rcu_read_unlock();
+	if (!orig_node)
+		goto unlock;
 
-	if (!orig_node) {
-		pr_debug("couldn't find originator in orig_hash\n");
-		goto out;
-	}
+	kref_get(&orig_node->refcount);
+	rcu_read_unlock();
 
 	orig_node->last_frag_packet = jiffies;
 
@@ -212,9 +211,14 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	/* if not, merge failed */
 	if (*new_skb)
 		ret = NET_RX_SUCCESS;
-out:
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
+	goto out;
+
+unlock:
+	rcu_read_unlock();
+out:
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
 	return ret;
 }
 
@@ -277,47 +281,53 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct unicast_packet *unicast_packet;
 	struct orig_node *orig_node;
-	struct batman_if *batman_if;
-	struct neigh_node *router;
+	struct neigh_node *neigh_node;
 	int data_len = skb->len;
-	uint8_t dstaddr[6];
-
-	spin_lock_bh(&bat_priv->orig_hash_lock);
+	int ret = 1;
 
 	/* get routing information */
-	if (is_multicast_ether_addr(ethhdr->h_dest))
+	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		orig_node = (struct orig_node *)gw_get_selected(bat_priv);
-	else {
+		if (!orig_node)
+			goto trans_search;
+
+		kref_get(&orig_node->refcount);
+		goto find_router;
+	} else {
 		rcu_read_lock();
 		orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 							   compare_orig,
 							   choose_orig,
 							   ethhdr->h_dest));
+		if (!orig_node) {
+			rcu_read_unlock();
+			goto trans_search;
+		}
+
+		kref_get(&orig_node->refcount);
 		rcu_read_unlock();
+		goto find_router;
 	}
 
-	/* check for hna host */
-	if (!orig_node)
-		orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+trans_search:
+	/* check for hna host - increases orig_node refcount */
+	orig_node = transtable_search(bat_priv, ethhdr->h_dest);
 
-	router = find_router(bat_priv, orig_node, NULL);
+find_router:
+	rcu_read_lock();
+	neigh_node = find_router(bat_priv, orig_node, NULL);
 
-	if (!router)
+	if (!neigh_node)
 		goto unlock;
 
-	/* don't lock while sending the packets ... we therefore
-		* copy the required data before sending */
-
-	batman_if = router->if_incoming;
-	memcpy(dstaddr, router->addr, ETH_ALEN);
-
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	kref_get(&neigh_node->refcount);
+	rcu_read_unlock();
 
-	if (batman_if->if_status != IF_ACTIVE)
-		goto dropped;
+	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
+		goto out;
 
 	if (my_skb_head_push(skb, sizeof(struct unicast_packet)) < 0)
-		goto dropped;
+		goto out;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
@@ -331,18 +341,26 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 
 	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(struct unicast_packet) >
-	    batman_if->net_dev->mtu) {
+				neigh_node->if_incoming->net_dev->mtu) {
 		/* send frag skb decreases ttl */
 		unicast_packet->ttl++;
-		return frag_send_skb(skb, bat_priv, batman_if,
-				     dstaddr);
+		ret = frag_send_skb(skb, bat_priv,
+				    neigh_node->if_incoming, neigh_node->addr);
+		goto out;
 	}
-	send_skb_packet(skb, batman_if, dstaddr);
-	return 0;
+
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = 0;
+	goto out;
 
 unlock:
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
-dropped:
-	kfree_skb(skb);
-	return 1;
+	rcu_read_unlock();
+out:
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
+	if (ret == 1)
+		kfree_skb(skb);
+	return ret;
 }
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 230e66b..69178d9 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -590,7 +590,6 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	info->first_seen = jiffies;
 	packet->vis_type = atomic_read(&bat_priv->vis_mode);
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	memcpy(packet->target_orig, broadcast_addr, ETH_ALEN);
 	packet->ttl = TTL;
 	packet->seqno = htonl(ntohl(packet->seqno) + 1);
@@ -600,10 +599,8 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	if (packet->vis_type == VIS_TYPE_CLIENT_UPDATE) {
 		best_tq = find_best_vis_server(bat_priv, info);
 
-		if (best_tq < 0) {
-			spin_unlock_bh(&bat_priv->orig_hash_lock);
+		if (best_tq < 0)
 			return -1;
-		}
 	}
 
 	for (i = 0; i < hash->size; i++) {
@@ -636,17 +633,12 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 			entry->quality = neigh_node->tq_avg;
 			packet->entries++;
 
-			if (vis_packet_full(info)) {
-				rcu_read_unlock();
-				spin_unlock_bh(&bat_priv->orig_hash_lock);
-				return 0;
-			}
+			if (vis_packet_full(info))
+				goto unlock;
 		}
 		rcu_read_unlock();
 	}
 
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
-
 	hash = bat_priv->hna_local_hash;
 
 	spin_lock_bh(&bat_priv->hna_lhash_lock);
@@ -672,6 +664,10 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 
 	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 	return 0;
+
+unlock:
+	rcu_read_unlock();
+	return 0;
 }
 
 /* free old vis packets. Must be called with this vis_hash_lock
@@ -721,7 +717,6 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 	int i;
 
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	packet = (struct vis_packet *)info->skb_packet->data;
 
 	/* send to all routers in range. */
@@ -746,54 +741,58 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 			memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
 			batman_if = orig_node->router->if_incoming;
 			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-			spin_unlock_bh(&bat_priv->orig_hash_lock);
 
 			skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 			if (skb)
 				send_skb_packet(skb, batman_if, dstaddr);
 
-			spin_lock_bh(&bat_priv->orig_hash_lock);
 		}
 		rcu_read_unlock();
 	}
-
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
 }
 
 static void unicast_vis_packet(struct bat_priv *bat_priv,
 			       struct vis_info *info)
 {
 	struct orig_node *orig_node;
+	struct neigh_node *neigh_node = NULL;
 	struct sk_buff *skb;
 	struct vis_packet *packet;
-	struct batman_if *batman_if;
-	uint8_t dstaddr[ETH_ALEN];
 
-	spin_lock_bh(&bat_priv->orig_hash_lock);
 	packet = (struct vis_packet *)info->skb_packet->data;
+
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   compare_orig, choose_orig,
 						   packet->target_orig));
-	rcu_read_unlock();
 
-	if ((!orig_node) || (!orig_node->router))
-		goto out;
+	if (!orig_node)
+		goto unlock;
 
-	/* don't lock while sending the packets ... we therefore
-	 * copy the required data before sending */
-	batman_if = orig_node->router->if_incoming;
-	memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	kref_get(&orig_node->refcount);
+	neigh_node = orig_node->router;
+
+	if (!neigh_node)
+		goto unlock;
+
+	kref_get(&neigh_node->refcount);
+	rcu_read_unlock();
 
 	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 	if (skb)
-		send_skb_packet(skb, batman_if, dstaddr);
+		send_skb_packet(skb, neigh_node->if_incoming,
+				neigh_node->addr);
 
-	return;
+	goto out;
 
+unlock:
+	rcu_read_unlock();
 out:
-	spin_unlock_bh(&bat_priv->orig_hash_lock);
+	if (neigh_node)
+		kref_put(&neigh_node->refcount, neigh_node_free_ref);
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
+	return;
 }
 
 /* only send one vis packet. called from send_vis_packets() */
-- 
1.7.2.3

