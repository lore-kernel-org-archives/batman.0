Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Wed,  2 Mar 2011 18:18:31 +0100
Message-Id: <1299086321-25116-3-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
References: <1299086321-25116-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 02/12] batman-adv: Add explicit batman header
	structure
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

Just a minor style adjustment, to give people a hint which fields should
not be reordered and need to be at the beginning of each packet with
batman-adv's frame type.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 aggregation.c    |    4 ++--
 hard-interface.c |   18 +++++++++---------
 icmp_socket.c    |    6 +++---
 packet.h         |   50 +++++++++++++++++++++-----------------------------
 routing.c        |   34 +++++++++++++++++-----------------
 send.c           |   20 ++++++++++----------
 soft-interface.c |   14 +++++++-------
 unicast.c        |   16 ++++++++--------
 vis.c            |   14 +++++++-------
 9 files changed, 84 insertions(+), 92 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index af45d6b..5bd74e1 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -69,7 +69,7 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 		 * are flooded through the net  */
 		if ((!directlink) &&
 		    (!(batman_packet->flags & DIRECTLINK)) &&
-		    (batman_packet->ttl != 1) &&
+		    (batman_packet->header.ttl != 1) &&
 
 		    /* own packets originating non-primary
 		     * interfaces leave only that interface */
@@ -80,7 +80,7 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 		/* if the incoming packet is sent via this one
 		 * interface only - we still can aggregate */
 		if ((directlink) &&
-		    (new_batman_packet->ttl == 1) &&
+		    (new_batman_packet->header.ttl == 1) &&
 		    (forw_packet->if_incoming == if_incoming) &&
 
 		    /* packets from direct neighbors or
diff --git a/hard-interface.c b/hard-interface.c
index 95a35b6..3637602 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -146,8 +146,8 @@ static void set_primary_if(struct bat_priv *bat_priv,
 		return;
 
 	batman_packet = (struct batman_packet *)(hard_iface->packet_buff);
+	batman_packet->header.ttl = TTL;
 	batman_packet->flags = PRIMARIES_FIRST_HOP;
-	batman_packet->ttl = TTL;
 
 	update_primary_addr(bat_priv);
 
@@ -312,10 +312,10 @@ int hardif_enable_interface(struct hard_iface *hard_iface, char *iface_name)
 	}
 
 	batman_packet = (struct batman_packet *)(hard_iface->packet_buff);
-	batman_packet->packet_type = BAT_PACKET;
-	batman_packet->version = COMPAT_VERSION;
+	batman_packet->header.packet_type = BAT_PACKET;
+	batman_packet->header.version = COMPAT_VERSION;
+	batman_packet->header.ttl = 2;
 	batman_packet->flags = 0;
-	batman_packet->ttl = 2;
 	batman_packet->tq = TQ_MAX_VALUE;
 	batman_packet->num_hna = 0;
 
@@ -559,7 +559,7 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct net_device *orig_dev)
 {
 	struct bat_priv *bat_priv;
-	struct batman_packet *batman_packet;
+	struct batman_header *batman_header;
 	struct hard_iface *hard_iface;
 	int ret;
 
@@ -591,19 +591,19 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (hard_iface->if_status != IF_ACTIVE)
 		goto err_free;
 
-	batman_packet = (struct batman_packet *)skb->data;
+	batman_header = (struct batman_header *)skb->data;
 
-	if (batman_packet->version != COMPAT_VERSION) {
+	if (batman_header->version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: incompatible batman version (%i)\n",
-			batman_packet->version);
+			batman_header->version);
 		goto err_free;
 	}
 
 	/* all receive handlers return whether they received or reused
 	 * the supplied skb. if not, we have to free the skb. */
 
-	switch (batman_packet->packet_type) {
+	switch (batman_header->packet_type) {
 		/* batman originator packet */
 	case BAT_PACKET:
 		ret = recv_bat_packet(skb, hard_iface);
diff --git a/icmp_socket.c b/icmp_socket.c
index 34ce56c..2b9ea74 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -190,7 +190,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		goto free_skb;
 	}
 
-	if (icmp_packet->packet_type != BAT_ICMP) {
+	if (icmp_packet->header.packet_type != BAT_ICMP) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Error - can't send packet from char device: "
 			"got bogus packet type (expected: BAT_ICMP)\n");
@@ -208,9 +208,9 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 
 	icmp_packet->uid = socket_client->index;
 
-	if (icmp_packet->version != COMPAT_VERSION) {
+	if (icmp_packet->header.version != COMPAT_VERSION) {
+		icmp_packet->header.ttl = COMPAT_VERSION;
 		icmp_packet->msg_type = PARAMETER_PROBLEM;
-		icmp_packet->ttl = COMPAT_VERSION;
 		bat_socket_add_packet(socket_client, icmp_packet, packet_len);
 		goto free_skb;
 	}
diff --git a/packet.h b/packet.h
index e757187..ae7a0ce 100644
--- a/packet.h
+++ b/packet.h
@@ -52,31 +52,33 @@
 #define UNI_FRAG_HEAD 0x01
 #define UNI_FRAG_LARGETAIL 0x02
 
-struct batman_packet {
+struct batman_header {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
+	uint8_t  ttl;
+	uint8_t  align;
+} __packed;
+
+struct batman_packet {
+	struct   batman_header header;
+	uint32_t seqno;
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
 	uint8_t  tq;
-	uint32_t seqno;
 	uint8_t  orig[6];
 	uint8_t  prev_sender[6];
-	uint8_t  ttl;
 	uint8_t  num_hna;
 	uint8_t  gw_flags;  /* flags related to gateway class */
-	uint8_t  align;
 } __packed;
 
 #define BAT_PACKET_LEN sizeof(struct batman_packet)
 
 struct icmp_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
+	struct   batman_header header;
+	uint16_t seqno;
 	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  ttl;
+	uint8_t  uid;
 	uint8_t  dst[6];
 	uint8_t  orig[6];
-	uint16_t seqno;
-	uint8_t  uid;
 } __packed;
 
 #define BAT_RR_LEN 16
@@ -84,50 +86,40 @@ struct icmp_packet {
 /* icmp_packet_rr must start with all fields from imcp_packet
  * as this is assumed by code that handles ICMP packets */
 struct icmp_packet_rr {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
+	struct   batman_header header;
+	uint16_t seqno;
 	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  ttl;
+	uint8_t  uid;
 	uint8_t  dst[6];
 	uint8_t  orig[6];
-	uint16_t seqno;
-	uint8_t  uid;
 	uint8_t  rr_cur;
 	uint8_t  rr[BAT_RR_LEN][ETH_ALEN];
 } __packed;
 
 struct unicast_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
+	struct   batman_header header;
 	uint8_t  dest[6];
-	uint8_t  ttl;
 } __packed;
 
 struct unicast_frag_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
+	struct   batman_header header;
 	uint8_t  dest[6];
-	uint8_t  ttl;
-	uint8_t  flags;
 	uint8_t  orig[6];
+	uint8_t  flags;
 	uint16_t seqno;
 } __packed;
 
 struct bcast_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  orig[6];
-	uint8_t  ttl;
+	struct   batman_header header;
 	uint32_t seqno;
+	uint8_t  orig[6];
 } __packed;
 
 struct vis_packet {
-	uint8_t  packet_type;
-	uint8_t  version;        /* batman version field */
+	struct   batman_header header;
+	uint32_t seqno;		 /* sequence number */
 	uint8_t  vis_type;	 /* which type of vis-participant sent this? */
 	uint8_t  entries;	 /* number of entries behind this struct */
-	uint32_t seqno;		 /* sequence number */
-	uint8_t  ttl;		 /* TTL */
 	uint8_t  vis_orig[6];	 /* originator that informs about its
 				  * neighbors */
 	uint8_t  target_orig[6]; /* who should receive this packet */
diff --git a/routing.c b/routing.c
index c172f5d..115a8de 100644
--- a/routing.c
+++ b/routing.c
@@ -430,8 +430,8 @@ static void update_orig(struct bat_priv *bat_priv,
 	neigh_node->tq_avg = ring_buffer_avg(neigh_node->tq_recv);
 
 	if (!is_duplicate) {
-		orig_node->last_ttl = batman_packet->ttl;
-		neigh_node->last_ttl = batman_packet->ttl;
+		orig_node->last_ttl = batman_packet->header.ttl;
+		neigh_node->last_ttl = batman_packet->header.ttl;
 	}
 
 	bonding_candidate_add(orig_node, neigh_node);
@@ -621,7 +621,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	 * packet in an aggregation.  Here we expect that the padding
 	 * is always zero (or not 0x01)
 	 */
-	if (batman_packet->packet_type != BAT_PACKET)
+	if (batman_packet->header.packet_type != BAT_PACKET)
 		return;
 
 	/* could be changed by schedule_own_packet() */
@@ -639,8 +639,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		ethhdr->h_source, if_incoming->net_dev->name,
 		if_incoming->net_dev->dev_addr, batman_packet->orig,
 		batman_packet->prev_sender, batman_packet->seqno,
-		batman_packet->tq, batman_packet->ttl, batman_packet->version,
-		has_directlink_flag);
+		batman_packet->tq, batman_packet->header.ttl,
+		batman_packet->header.version, has_directlink_flag);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(hard_iface, &hardif_list, list) {
@@ -667,10 +667,10 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 	rcu_read_unlock();
 
-	if (batman_packet->version != COMPAT_VERSION) {
+	if (batman_packet->header.version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: incompatible batman version (%i)\n",
-			batman_packet->version);
+			batman_packet->header.version);
 		return;
 	}
 
@@ -787,7 +787,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	if (is_bidirectional &&
 	    (!is_duplicate ||
 	     ((orig_node->last_real_seqno == batman_packet->seqno) &&
-	      (orig_node->last_ttl - 3 <= batman_packet->ttl))))
+	      (orig_node->last_ttl - 3 <= batman_packet->header.ttl))))
 		update_orig(bat_priv, orig_node, ethhdr, batman_packet,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
@@ -914,7 +914,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	memcpy(icmp_packet->orig,
 		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 	icmp_packet->msg_type = ECHO_REPLY;
-	icmp_packet->ttl = TTL;
+	icmp_packet->header.ttl = TTL;
 
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
@@ -980,7 +980,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	memcpy(icmp_packet->orig,
 		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 	icmp_packet->msg_type = TTL_EXCEEDED;
-	icmp_packet->ttl = TTL;
+	icmp_packet->header.ttl = TTL;
 
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
@@ -1046,7 +1046,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		return recv_my_icmp_packet(bat_priv, skb, hdr_size);
 
 	/* TTL exceeded */
-	if (icmp_packet->ttl < 2)
+	if (icmp_packet->header.ttl < 2)
 		return recv_icmp_ttl_exceeded(bat_priv, skb);
 
 	/* get routing information */
@@ -1075,7 +1075,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
 
 	/* decrement ttl */
-	icmp_packet->ttl--;
+	icmp_packet->header.ttl--;
 
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
@@ -1276,7 +1276,7 @@ int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	unicast_packet = (struct unicast_packet *)skb->data;
 
 	/* TTL exceeded */
-	if (unicast_packet->ttl < 2) {
+	if (unicast_packet->header.ttl < 2) {
 		pr_debug("Warning - can't forward unicast packet from %pM to "
 			 "%pM: ttl exceeded\n", ethhdr->h_source,
 			 unicast_packet->dest);
@@ -1304,7 +1304,7 @@ int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	if (unicast_packet->packet_type == BAT_UNICAST &&
+	if (unicast_packet->header.packet_type == BAT_UNICAST &&
 	    atomic_read(&bat_priv->fragmentation) &&
 	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
 		ret = frag_send_skb(skb, bat_priv,
@@ -1312,7 +1312,7 @@ int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 	}
 
-	if (unicast_packet->packet_type == BAT_UNICAST_FRAG &&
+	if (unicast_packet->header.packet_type == BAT_UNICAST_FRAG &&
 	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
 
 		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
@@ -1331,7 +1331,7 @@ int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	}
 
 	/* decrement ttl */
-	unicast_packet->ttl--;
+	unicast_packet->header.ttl--;
 
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
@@ -1435,7 +1435,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (is_my_mac(bcast_packet->orig))
 		goto out;
 
-	if (bcast_packet->ttl < 2)
+	if (bcast_packet->header.ttl < 2)
 		goto out;
 
 	rcu_read_lock();
diff --git a/send.c b/send.c
index d49e54d..93e4f8f 100644
--- a/send.c
+++ b/send.c
@@ -139,7 +139,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 			" IDF %s) on interface %s [%pM]\n",
 			fwd_str, (packet_num > 0 ? "aggregated " : ""),
 			batman_packet->orig, ntohl(batman_packet->seqno),
-			batman_packet->tq, batman_packet->ttl,
+			batman_packet->tq, batman_packet->header.ttl,
 			(batman_packet->flags & DIRECTLINK ?
 			 "on" : "off"),
 			hard_iface->net_dev->name,
@@ -182,7 +182,7 @@ static void send_packet(struct forw_packet *forw_packet)
 
 	/* multihomed peer assumed */
 	/* non-primary OGMs are only broadcasted on their interface */
-	if ((directlink && (batman_packet->ttl == 1)) ||
+	if ((directlink && (batman_packet->header.ttl == 1)) ||
 	    (forw_packet->own && (forw_packet->if_incoming->if_num > 0))) {
 
 		/* FIXME: what about aggregated packets ? */
@@ -191,7 +191,7 @@ static void send_packet(struct forw_packet *forw_packet)
 			"on interface %s [%pM]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
 			batman_packet->orig, ntohl(batman_packet->seqno),
-			batman_packet->ttl,
+			batman_packet->header.ttl,
 			forw_packet->if_incoming->net_dev->name,
 			forw_packet->if_incoming->net_dev->dev_addr);
 
@@ -311,15 +311,15 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
 
-	if (batman_packet->ttl <= 1) {
+	if (batman_packet->header.ttl <= 1) {
 		bat_dbg(DBG_BATMAN, bat_priv, "ttl exceeded\n");
 		return;
 	}
 
 	in_tq = batman_packet->tq;
-	in_ttl = batman_packet->ttl;
+	in_ttl = batman_packet->header.ttl;
 
-	batman_packet->ttl--;
+	batman_packet->header.ttl--;
 	memcpy(batman_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
 
 	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
@@ -331,8 +331,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			batman_packet->tq = orig_node->router->tq_avg;
 
 			if (orig_node->router->last_ttl)
-				batman_packet->ttl = orig_node->router->last_ttl
-							- 1;
+				batman_packet->header.ttl =
+					orig_node->router->last_ttl - 1;
 		}
 
 		tq_avg = orig_node->router->tq_avg;
@@ -345,7 +345,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
 		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
-		batman_packet->ttl);
+		batman_packet->header.ttl);
 
 	batman_packet->seqno = htonl(batman_packet->seqno);
 
@@ -421,7 +421,7 @@ int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb)
 
 	/* as we have a copy now, it is safe to decrease the TTL */
 	bcast_packet = (struct bcast_packet *)skb->data;
-	bcast_packet->ttl--;
+	bcast_packet->header.ttl--;
 
 	skb_reset_mac_header(skb);
 
diff --git a/soft-interface.c b/soft-interface.c
index 6b514ec..b0c023d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -206,10 +206,10 @@ static void softif_batman_recv(struct sk_buff *skb, struct net_device *dev,
 	else
 		batman_packet = (struct batman_packet *)(skb->data + ETH_HLEN);
 
-	if (batman_packet->version != COMPAT_VERSION)
+	if (batman_packet->header.version != COMPAT_VERSION)
 		goto err;
 
-	if (batman_packet->packet_type != BAT_PACKET)
+	if (batman_packet->header.packet_type != BAT_PACKET)
 		goto err;
 
 	if (!(batman_packet->flags & PRIMARIES_FIRST_HOP))
@@ -373,11 +373,11 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 			goto dropped;
 
 		bcast_packet = (struct bcast_packet *)skb->data;
-		bcast_packet->version = COMPAT_VERSION;
-		bcast_packet->ttl = TTL;
+		bcast_packet->header.version = COMPAT_VERSION;
+		bcast_packet->header.ttl = TTL;
 
 		/* batman packet type: broadcast */
-		bcast_packet->packet_type = BAT_BCAST;
+		bcast_packet->header.packet_type = BAT_BCAST;
 
 		/* hw address of first interface is the orig mac because only
 		 * this mac is known throughout the mesh */
@@ -454,8 +454,8 @@ void interface_rx(struct net_device *soft_iface,
 		skb_push(skb, hdr_size);
 		unicast_packet = (struct unicast_packet *)skb->data;
 
-		if ((unicast_packet->packet_type != BAT_UNICAST) &&
-		    (unicast_packet->packet_type != BAT_UNICAST_FRAG))
+		if ((unicast_packet->header.packet_type != BAT_UNICAST) &&
+		    (unicast_packet->header.packet_type != BAT_UNICAST_FRAG))
 			goto dropped;
 
 		skb_reset_mac_header(skb);
diff --git a/unicast.c b/unicast.c
index 19f84bd..a57033a 100644
--- a/unicast.c
+++ b/unicast.c
@@ -67,7 +67,7 @@ static struct sk_buff *frag_merge_packet(struct list_head *head,
 
 	memmove(skb->data + uni_diff, skb->data, hdr_len);
 	unicast_packet = (struct unicast_packet *) skb_pull(skb, uni_diff);
-	unicast_packet->packet_type = BAT_UNICAST;
+	unicast_packet->header.packet_type = BAT_UNICAST;
 
 	return skb;
 
@@ -250,9 +250,9 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 
 	memcpy(frag1, &tmp_uc, sizeof(struct unicast_packet));
 
-	frag1->ttl--;
-	frag1->version = COMPAT_VERSION;
-	frag1->packet_type = BAT_UNICAST_FRAG;
+	frag1->header.ttl--;
+	frag1->header.version = COMPAT_VERSION;
+	frag1->header.packet_type = BAT_UNICAST_FRAG;
 
 	memcpy(frag1->orig, bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(frag2, frag1, sizeof(struct unicast_frag_packet));
@@ -316,11 +316,11 @@ find_router:
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	unicast_packet->version = COMPAT_VERSION;
+	unicast_packet->header.version = COMPAT_VERSION;
 	/* batman packet type: unicast */
-	unicast_packet->packet_type = BAT_UNICAST;
+	unicast_packet->header.packet_type = BAT_UNICAST;
 	/* set unicast ttl */
-	unicast_packet->ttl = TTL;
+	unicast_packet->header.ttl = TTL;
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
@@ -328,7 +328,7 @@ find_router:
 	    data_len + sizeof(struct unicast_packet) >
 				neigh_node->if_incoming->net_dev->mtu) {
 		/* send frag skb decreases ttl */
-		unicast_packet->ttl++;
+		unicast_packet->header.ttl++;
 		ret = frag_send_skb(skb, bat_priv,
 				    neigh_node->if_incoming, neigh_node->addr);
 		goto out;
diff --git a/vis.c b/vis.c
index f90212f..491430c 100644
--- a/vis.c
+++ b/vis.c
@@ -616,7 +616,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	packet->vis_type = atomic_read(&bat_priv->vis_mode);
 
 	memcpy(packet->target_orig, broadcast_addr, ETH_ALEN);
-	packet->ttl = TTL;
+	packet->header.ttl = TTL;
 	packet->seqno = htonl(ntohl(packet->seqno) + 1);
 	packet->entries = 0;
 	skb_trim(info->skb_packet, sizeof(struct vis_packet));
@@ -819,20 +819,20 @@ static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 	struct vis_packet *packet;
 
 	packet = (struct vis_packet *)info->skb_packet->data;
-	if (packet->ttl < 2) {
+	if (packet->header.ttl < 2) {
 		pr_debug("Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
 	memcpy(packet->sender_orig, bat_priv->primary_if->net_dev->dev_addr,
 	       ETH_ALEN);
-	packet->ttl--;
+	packet->header.ttl--;
 
 	if (is_broadcast_ether_addr(packet->target_orig))
 		broadcast_vis_packet(bat_priv, info);
 	else
 		unicast_vis_packet(bat_priv, info);
-	packet->ttl++; /* restore TTL */
+	packet->header.ttl++; /* restore TTL */
 }
 
 /* called from timer; send (and maybe generate) vis packet. */
@@ -913,9 +913,9 @@ int vis_init(struct bat_priv *bat_priv)
 	INIT_LIST_HEAD(&bat_priv->my_vis_info->send_list);
 	kref_init(&bat_priv->my_vis_info->refcount);
 	bat_priv->my_vis_info->bat_priv = bat_priv;
-	packet->version = COMPAT_VERSION;
-	packet->packet_type = BAT_VIS;
-	packet->ttl = TTL;
+	packet->header.version = COMPAT_VERSION;
+	packet->header.packet_type = BAT_VIS;
+	packet->header.ttl = TTL;
 	packet->seqno = 0;
 	packet->entries = 0;
 
-- 
1.7.2.3

