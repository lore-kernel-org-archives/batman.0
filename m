Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 26 Jun 2010 00:28:18 +0200
Message-Id: <1277504905-27672-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] Staging: batman-adv: Convert names from
	Java to C style
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Antonio Quartulli <ordex@ritirata.org>

Useless but meaningfull patch that converts JavaStyle names into c_style

Signed-off-by: Antonio Quartulli <ordex@ritirata.org>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c           |    2 +-
 drivers/staging/batman-adv/main.h           |    2 +-
 drivers/staging/batman-adv/routing.c        |    6 +++---
 drivers/staging/batman-adv/send.c           |    6 +++---
 drivers/staging/batman-adv/soft-interface.c |    6 +++---
 drivers/staging/batman-adv/soft-interface.h |    2 +-
 drivers/staging/batman-adv/vis.c            |   12 ++++++------
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 72fccb1..ae88806 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -49,7 +49,7 @@ int16_t num_hna;
 
 struct net_device *soft_device;
 
-unsigned char broadcastAddr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 atomic_t module_state;
 
 static struct packet_type batman_adv_packet_type __read_mostly = {
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index fe5ee51..ab4c9e7 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -148,7 +148,7 @@ extern int16_t num_hna;
 
 extern struct net_device *soft_device;
 
-extern unsigned char broadcastAddr[];
+extern unsigned char broadcast_addr[];
 extern atomic_t module_state;
 extern struct workqueue_struct *bat_event_workqueue;
 
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index acd8f74..127cfbf 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -120,7 +120,7 @@ void update_routes(struct orig_node *orig_node,
 		update_HNA(orig_node, hna_buff, hna_buff_len);
 }
 
-static int isBidirectionalNeigh(struct orig_node *orig_node,
+static int is_bidirectional_neigh(struct orig_node *orig_node,
 				struct orig_node *orig_neigh_node,
 				struct batman_packet *batman_packet,
 				struct batman_if *if_incoming)
@@ -564,7 +564,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				 batman_if->net_dev->dev_addr))
 			is_my_oldorig = 1;
 
-		if (compare_orig(ethhdr->h_source, broadcastAddr))
+		if (compare_orig(ethhdr->h_source, broadcast_addr))
 			is_broadcast = 1;
 	}
 
@@ -674,7 +674,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		return;
 	}
 
-	is_bidirectional = isBidirectionalNeigh(orig_node, orig_neigh_node,
+	is_bidirectional = is_bidirectional_neigh(orig_node, orig_neigh_node,
 						batman_packet, if_incoming);
 
 	/* update ranking if it is not a duplicate or has the same
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index e61a62c..8059adb 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -174,7 +174,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 
 	send_raw_packet(forw_packet->packet_buff,
 			forw_packet->packet_len,
-			batman_if, broadcastAddr);
+			batman_if, broadcast_addr);
 }
 
 /* send a batman packet */
@@ -211,7 +211,7 @@ static void send_packet(struct forw_packet *forw_packet)
 		send_raw_packet(forw_packet->packet_buff,
 				forw_packet->packet_len,
 				forw_packet->if_incoming,
-				broadcastAddr);
+				broadcast_addr);
 		return;
 	}
 
@@ -464,7 +464,7 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 		skb1 = skb_copy(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
 			send_skb_packet(skb1,
-				batman_if, broadcastAddr);
+				batman_if, broadcast_addr);
 	}
 	rcu_read_unlock();
 
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index ef7860d..2ea97de 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -36,7 +36,7 @@ static uint32_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
 static int32_t skb_packets;
 static int32_t skb_bad_packets;
 
-unsigned char mainIfAddr[ETH_ALEN];
+unsigned char main_if_addr[ETH_ALEN];
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
 static void bat_get_drvinfo(struct net_device *dev,
 			    struct ethtool_drvinfo *info);
@@ -58,7 +58,7 @@ static const struct ethtool_ops bat_ethtool_ops = {
 
 void set_main_if_addr(uint8_t *addr)
 {
-	memcpy(mainIfAddr, addr, ETH_ALEN);
+	memcpy(main_if_addr, addr, ETH_ALEN);
 }
 
 int my_skb_push(struct sk_buff *skb, unsigned int len)
@@ -164,7 +164,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 
 		/* hw address of first interface is the orig mac because only
 		 * this mac is known throughout the mesh */
-		memcpy(bcast_packet->orig, mainIfAddr, ETH_ALEN);
+		memcpy(bcast_packet->orig, main_if_addr, ETH_ALEN);
 
 		/* set broadcast sequence number */
 		bcast_packet->seqno = htonl(bcast_seqno);
diff --git a/drivers/staging/batman-adv/soft-interface.h b/drivers/staging/batman-adv/soft-interface.h
index 3852c57..0847e42 100644
--- a/drivers/staging/batman-adv/soft-interface.h
+++ b/drivers/staging/batman-adv/soft-interface.h
@@ -25,4 +25,4 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev);
 void interface_rx(struct sk_buff *skb, int hdr_size);
 int my_skb_push(struct sk_buff *skb, unsigned int len);
 
-extern unsigned char mainIfAddr[];
+extern unsigned char main_if_addr[];
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index d9ab981..ed2c1f9 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -390,7 +390,7 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 
 	/* Make it a broadcast packet, if required */
 	if (make_broadcast)
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+		memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
 
 	/* repair if entries is longer than packet. */
 	if (info->packet.entries * sizeof(struct vis_info_entry) > vis_info_len)
@@ -524,7 +524,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	info->packet.vis_type = atomic_read(&bat_priv->vis_mode);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
-	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+	memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
 	info->packet.ttl = TTL;
 	info->packet.seqno = htonl(ntohl(info->packet.seqno) + 1);
 	info->packet.entries = 0;
@@ -641,7 +641,7 @@ static void broadcast_vis_packet(struct vis_info *info, int packet_length)
 
 	}
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
-	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+	memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
 }
 
 static void unicast_vis_packet(struct vis_info *info, int packet_length)
@@ -682,7 +682,7 @@ static void send_vis_packet(struct vis_info *info)
 		return;
 	}
 
-	memcpy(info->packet.sender_orig, mainIfAddr, ETH_ALEN);
+	memcpy(info->packet.sender_orig, main_if_addr, ETH_ALEN);
 	info->packet.ttl--;
 
 	packet_length = sizeof(struct vis_packet) +
@@ -763,8 +763,8 @@ int vis_init(void)
 
 	INIT_LIST_HEAD(&send_list);
 
-	memcpy(my_vis_info->packet.vis_orig, mainIfAddr, ETH_ALEN);
-	memcpy(my_vis_info->packet.sender_orig, mainIfAddr, ETH_ALEN);
+	memcpy(my_vis_info->packet.vis_orig, main_if_addr, ETH_ALEN);
+	memcpy(my_vis_info->packet.sender_orig, main_if_addr, ETH_ALEN);
 
 	if (hash_add(vis_hash, my_vis_info) < 0) {
 		printk(KERN_ERR
-- 
1.7.1

