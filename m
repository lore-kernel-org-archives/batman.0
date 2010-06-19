Return-Path: <ordex@ritirata.org>
Date: Sat, 19 Jun 2010 11:42:53 +0200
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20100619094253.GA12975@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH-trunk] batman-adv: Convert names from Java to
	C style
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Useless but meaningfull patch that converts JavaStyle names into c_style

Signed-off-by: Antonio Quartulli <ordex@ritirata.org>
---




--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="java_to_c_style.diff"

Index: batman-adv-kernelland/vis.c
===================================================================
--- batman-adv-kernelland/vis.c	(revisione 1706)
+++ batman-adv-kernelland/vis.c	(copia locale)
@@ -391,7 +391,7 @@
 
 	/* Make it a broadcast packet, if required */
 	if (make_broadcast)
-		memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+		memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
 
 	/* repair if entries is longer than packet. */
 	if (info->packet.entries * sizeof(struct vis_info_entry) > vis_info_len)
@@ -525,7 +525,7 @@
 	info->packet.vis_type = atomic_read(&bat_priv->vis_mode);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
-	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+	memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
 	info->packet.ttl = TTL;
 	info->packet.seqno = htonl(ntohl(info->packet.seqno) + 1);
 	info->packet.entries = 0;
@@ -642,7 +642,7 @@
 
 	}
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
-	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
+	memcpy(info->packet.target_orig, broadcast_addr, ETH_ALEN);
 }
 
 static void unicast_vis_packet(struct vis_info *info, int packet_length)
@@ -683,7 +683,7 @@
 		return;
 	}
 
-	memcpy(info->packet.sender_orig, mainIfAddr, ETH_ALEN);
+	memcpy(info->packet.sender_orig, main_if_addr, ETH_ALEN);
 	info->packet.ttl--;
 
 	packet_length = sizeof(struct vis_packet) +
@@ -764,8 +764,8 @@
 
 	INIT_LIST_HEAD(&send_list);
 
-	memcpy(my_vis_info->packet.vis_orig, mainIfAddr, ETH_ALEN);
-	memcpy(my_vis_info->packet.sender_orig, mainIfAddr, ETH_ALEN);
+	memcpy(my_vis_info->packet.vis_orig, main_if_addr, ETH_ALEN);
+	memcpy(my_vis_info->packet.sender_orig, main_if_addr, ETH_ALEN);
 
 	if (hash_add(vis_hash, my_vis_info) < 0) {
 		printk(KERN_ERR
Index: batman-adv-kernelland/send.c
===================================================================
--- batman-adv-kernelland/send.c	(revisione 1706)
+++ batman-adv-kernelland/send.c	(copia locale)
@@ -176,7 +176,7 @@
 
 	send_raw_packet(forw_packet->packet_buff,
 			forw_packet->packet_len,
-			batman_if, broadcastAddr);
+			batman_if, broadcast_addr);
 }
 
 /* send a batman packet */
@@ -213,7 +213,7 @@
 		send_raw_packet(forw_packet->packet_buff,
 				forw_packet->packet_len,
 				forw_packet->if_incoming,
-				broadcastAddr);
+				broadcast_addr);
 		return;
 	}
 
@@ -476,7 +476,7 @@
 		skb1 = skb_copy(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
 			send_skb_packet(skb1,
-				batman_if, broadcastAddr);
+				batman_if, broadcast_addr);
 	}
 	rcu_read_unlock();
 
Index: batman-adv-kernelland/soft-interface.c
===================================================================
--- batman-adv-kernelland/soft-interface.c	(revisione 1706)
+++ batman-adv-kernelland/soft-interface.c	(copia locale)
@@ -38,7 +38,7 @@
 static int32_t skb_packets;
 static int32_t skb_bad_packets;
 
-unsigned char mainIfAddr[ETH_ALEN];
+unsigned char main_if_addr[ETH_ALEN];
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
 static void bat_get_drvinfo(struct net_device *dev,
 			    struct ethtool_drvinfo *info);
@@ -60,7 +60,7 @@
 
 void set_main_if_addr(uint8_t *addr)
 {
-	memcpy(mainIfAddr, addr, ETH_ALEN);
+	memcpy(main_if_addr, addr, ETH_ALEN);
 }
 
 int my_skb_push(struct sk_buff *skb, unsigned int len)
@@ -172,7 +172,7 @@
 
 		/* hw address of first interface is the orig mac because only
 		 * this mac is known throughout the mesh */
-		memcpy(bcast_packet->orig, mainIfAddr, ETH_ALEN);
+		memcpy(bcast_packet->orig, main_if_addr, ETH_ALEN);
 
 		/* set broadcast sequence number */
 		bcast_packet->seqno = htonl(bcast_seqno);
Index: batman-adv-kernelland/soft-interface.h
===================================================================
--- batman-adv-kernelland/soft-interface.h	(revisione 1706)
+++ batman-adv-kernelland/soft-interface.h	(copia locale)
@@ -25,4 +25,4 @@
 void interface_rx(struct sk_buff *skb, int hdr_size);
 int my_skb_push(struct sk_buff *skb, unsigned int len);
 
-extern unsigned char mainIfAddr[];
+extern unsigned char main_if_addr[];
Index: batman-adv-kernelland/main.c
===================================================================
--- batman-adv-kernelland/main.c	(revisione 1706)
+++ batman-adv-kernelland/main.c	(copia locale)
@@ -48,7 +48,7 @@
 
 struct net_device *soft_device;
 
-unsigned char broadcastAddr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 atomic_t module_state;
 
 static struct packet_type batman_adv_packet_type __read_mostly = {
Index: batman-adv-kernelland/routing.c
===================================================================
--- batman-adv-kernelland/routing.c	(revisione 1706)
+++ batman-adv-kernelland/routing.c	(copia locale)
@@ -122,7 +122,7 @@
 		update_HNA(orig_node, hna_buff, hna_buff_len);
 }
 
-static int isBidirectionalNeigh(struct orig_node *orig_node,
+static int is_bidirectional_neigh(struct orig_node *orig_node,
 				struct orig_node *orig_neigh_node,
 				struct batman_packet *batman_packet,
 				struct batman_if *if_incoming)
@@ -578,7 +578,7 @@
 				 batman_if->net_dev->dev_addr))
 			is_my_oldorig = 1;
 
-		if (compare_orig(ethhdr->h_source, broadcastAddr))
+		if (compare_orig(ethhdr->h_source, broadcast_addr))
 			is_broadcast = 1;
 	}
 
@@ -688,7 +688,7 @@
 		return;
 	}
 
-	is_bidirectional = isBidirectionalNeigh(orig_node, orig_neigh_node,
+	is_bidirectional = is_bidirectional_neigh(orig_node, orig_neigh_node,
 						batman_packet, if_incoming);
 
 	/* update ranking if it is not a duplicate or has the same
Index: batman-adv-kernelland/main.h
===================================================================
--- batman-adv-kernelland/main.h	(revisione 1706)
+++ batman-adv-kernelland/main.h	(copia locale)
@@ -146,7 +146,7 @@
 
 extern struct net_device *soft_device;
 
-extern unsigned char broadcastAddr[];
+extern unsigned char broadcast_addr[];
 extern atomic_t module_state;
 extern struct workqueue_struct *bat_event_workqueue;
 

--u3/rZRmxL6MmkK24--
