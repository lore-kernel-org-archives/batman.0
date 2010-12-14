Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 14 Dec 2010 10:58:07 +0100
Message-Id: <1292320696-11983-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
References: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: Creating new neighbor
	discovery packet
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

This patch creates the new neighbor discovery packet type (which is not
actually being used with this patch). It will later be responsible to
detect neighbors and calculate the link quality to them.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 aggregation.c       |   44 +++++++++++-----------
 aggregation.h       |    2 +-
 hard-interface.c    |   43 +++++++++++----------
 packet.h            |   28 ++++++++++----
 routing.c           |  101 ++++++++++++++++++++++++------------------------
 routing.h           |    2 +-
 send.c              |  106 ++++++++++++++++++++++++++-------------------------
 send.h              |    2 +-
 soft-interface.c    |   18 +++++----
 translation-table.c |    2 +-
 10 files changed, 183 insertions(+), 165 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index 0c92e3b..c158df2 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -25,21 +25,21 @@
 #include "routing.h"
 
 /* calculate the size of the hna information for a given packet */
-static int hna_len(struct batman_packet *batman_packet)
+static int hna_len(struct batman_packet_ogm *batman_packet_ogm)
 {
-	return batman_packet->num_hna * ETH_ALEN;
+	return batman_packet_ogm->num_hna * ETH_ALEN;
 }
 
 /* return true if new_packet can be aggregated with forw_packet */
-static bool can_aggregate_with(struct batman_packet *new_batman_packet,
+static bool can_aggregate_with(struct batman_packet_ogm *new_batman_packet_ogm,
 			       int packet_len,
 			       unsigned long send_time,
 			       bool directlink,
 			       struct batman_if *if_incoming,
 			       struct forw_packet *forw_packet)
 {
-	struct batman_packet *batman_packet =
-		(struct batman_packet *)forw_packet->skb->data;
+	struct batman_packet_ogm *batman_packet_ogm =
+		(struct batman_packet_ogm *)forw_packet->skb->data;
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
 
 	/**
@@ -68,8 +68,8 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 		/* packets without direct link flag and high TTL
 		 * are flooded through the net  */
 		if ((!directlink) &&
-		    (!(batman_packet->flags & DIRECTLINK)) &&
-		    (batman_packet->ttl != 1) &&
+		    (!(batman_packet_ogm->flags & DIRECTLINK)) &&
+		    (batman_packet_ogm->ttl != 1) &&
 
 		    /* own packets originating non-primary
 		     * interfaces leave only that interface */
@@ -80,13 +80,13 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 		/* if the incoming packet is sent via this one
 		 * interface only - we still can aggregate */
 		if ((directlink) &&
-		    (new_batman_packet->ttl == 1) &&
+		    (new_batman_packet_ogm->ttl == 1) &&
 		    (forw_packet->if_incoming == if_incoming) &&
 
 		    /* packets from direct neighbors or
 		     * own secondary interface packets
 		     * (= secondary interface packets in general) */
-		    (batman_packet->flags & DIRECTLINK ||
+		    (batman_packet_ogm->flags & DIRECTLINK ||
 		     (forw_packet->own &&
 		      forw_packet->if_incoming->if_num != 0)))
 			return true;
@@ -197,9 +197,9 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 	 */
 	struct forw_packet *forw_packet_aggr = NULL, *forw_packet_pos = NULL;
 	struct hlist_node *tmp_node;
-	struct batman_packet *batman_packet =
-		(struct batman_packet *)packet_buff;
-	bool direct_link = batman_packet->flags & DIRECTLINK ? 1 : 0;
+	struct batman_packet_ogm *batman_packet_ogm =
+		(struct batman_packet_ogm *)packet_buff;
+	bool direct_link = batman_packet_ogm->flags & DIRECTLINK ? 1 : 0;
 
 	/* find position for the packet in the forward queue */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
@@ -207,7 +207,7 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 	if ((atomic_read(&bat_priv->aggregated_ogms)) && (!own_packet)) {
 		hlist_for_each_entry(forw_packet_pos, tmp_node,
 				     &bat_priv->forw_bat_list, list) {
-			if (can_aggregate_with(batman_packet,
+			if (can_aggregate_with(batman_packet_ogm,
 					       packet_len,
 					       send_time,
 					       direct_link,
@@ -249,25 +249,25 @@ void add_bat_packet_to_list(struct bat_priv *bat_priv,
 void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 			     int packet_len, struct batman_if *if_incoming)
 {
-	struct batman_packet *batman_packet;
+	struct batman_packet_ogm *batman_packet_ogm;
 	int buff_pos = 0;
 	unsigned char *hna_buff;
 
-	batman_packet = (struct batman_packet *)packet_buff;
+	batman_packet_ogm = (struct batman_packet_ogm *)packet_buff;
 
 	do {
 		/* network to host order for our 32bit seqno, and the
 		   orig_interval. */
-		batman_packet->seqno = ntohl(batman_packet->seqno);
+		batman_packet_ogm->seqno = ntohl(batman_packet_ogm->seqno);
 
-		hna_buff = packet_buff + buff_pos + BAT_PACKET_LEN;
-		receive_bat_packet(ethhdr, batman_packet,
-				   hna_buff, hna_len(batman_packet),
+		hna_buff = packet_buff + buff_pos + BAT_PACKET_OGM_LEN;
+		receive_bat_packet(ethhdr, batman_packet_ogm,
+				   hna_buff, hna_len(batman_packet_ogm),
 				   if_incoming);
 
-		buff_pos += BAT_PACKET_LEN + hna_len(batman_packet);
-		batman_packet = (struct batman_packet *)
+		buff_pos += BAT_PACKET_OGM_LEN + hna_len(batman_packet_ogm);
+		batman_packet_ogm = (struct batman_packet_ogm *)
 			(packet_buff + buff_pos);
 	} while (aggregated_packet(buff_pos, packet_len,
-				   batman_packet->num_hna));
+				   batman_packet_ogm->num_hna));
 }
diff --git a/aggregation.h b/aggregation.h
index 71a91b3..1a7a0b6 100644
--- a/aggregation.h
+++ b/aggregation.h
@@ -27,7 +27,7 @@
 /* is there another aggregated packet here? */
 static inline int aggregated_packet(int buff_pos, int packet_len, int num_hna)
 {
-	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (num_hna * ETH_ALEN);
+	int next_buff_pos = buff_pos + BAT_PACKET_OGM_LEN + (num_hna * ETH_ALEN);
 
 	return (next_buff_pos <= packet_len) &&
 		(next_buff_pos <= MAX_AGGREGATION_BYTES);
diff --git a/hard-interface.c b/hard-interface.c
index 4f95777..784c475 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -128,7 +128,7 @@ static void update_primary_addr(struct bat_priv *bat_priv)
 static void set_primary_if(struct bat_priv *bat_priv,
 			   struct batman_if *batman_if)
 {
-	struct batman_packet *batman_packet;
+	struct batman_packet_ogm *batman_packet_ogm;
 	struct batman_if *old_if;
 
 	if (batman_if)
@@ -143,9 +143,9 @@ static void set_primary_if(struct bat_priv *bat_priv,
 	if (!bat_priv->primary_if)
 		return;
 
-	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
-	batman_packet->flags = PRIMARIES_FIRST_HOP;
-	batman_packet->ttl = TTL;
+	batman_packet_ogm = (struct batman_packet_ogm *)batman_if->packet_buff;
+	batman_packet_ogm->flags = PRIMARIES_FIRST_HOP;
+	batman_packet_ogm->ttl = TTL;
 
 	update_primary_addr(bat_priv);
 
@@ -166,9 +166,10 @@ static bool hardif_is_iface_up(struct batman_if *batman_if)
 
 static void update_mac_addresses(struct batman_if *batman_if)
 {
-	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
+	memcpy(((struct batman_packet_ogm *)(batman_if->packet_buff))->orig,
 	       batman_if->net_dev->dev_addr, ETH_ALEN);
-	memcpy(((struct batman_packet *)(batman_if->packet_buff))->prev_sender,
+	memcpy(((struct batman_packet_ogm *)
+		(batman_if->packet_buff))->prev_sender,
 	       batman_if->net_dev->dev_addr, ETH_ALEN);
 }
 
@@ -279,7 +280,7 @@ static void hardif_deactivate_interface(struct batman_if *batman_if)
 int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 {
 	struct bat_priv *bat_priv;
-	struct batman_packet *batman_packet;
+	struct batman_packet_ogm *batman_packet_ogm;
 
 	if (batman_if->if_status != IF_NOT_IN_USE)
 		goto out;
@@ -297,7 +298,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	}
 
 	bat_priv = netdev_priv(batman_if->soft_iface);
-	batman_if->packet_len = BAT_PACKET_LEN;
+	batman_if->packet_len = BAT_PACKET_OGM_LEN;
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_ATOMIC);
 
 	if (!batman_if->packet_buff) {
@@ -306,13 +307,13 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 		goto err;
 	}
 
-	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
-	batman_packet->packet_type = BAT_PACKET;
-	batman_packet->version = COMPAT_VERSION;
-	batman_packet->flags = 0;
-	batman_packet->ttl = 2;
-	batman_packet->tq = TQ_MAX_VALUE;
-	batman_packet->num_hna = 0;
+	batman_packet_ogm = (struct batman_packet_ogm *)(batman_if->packet_buff);
+	batman_packet_ogm->packet_type = BAT_PACKET_OGM;
+	batman_packet_ogm->version = COMPAT_VERSION;
+	batman_packet_ogm->flags = 0;
+	batman_packet_ogm->ttl = 2;
+	batman_packet_ogm->tq = TQ_MAX_VALUE;
+	batman_packet_ogm->num_hna = 0;
 
 	batman_if->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
@@ -553,7 +554,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct packet_type *ptype, struct net_device *orig_dev)
 {
 	struct bat_priv *bat_priv;
-	struct batman_packet *batman_packet;
+	struct batman_packet_ogm *batman_packet_ogm;
 	struct batman_if *batman_if;
 	int ret;
 
@@ -585,21 +586,21 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
 
-	batman_packet = (struct batman_packet *)skb->data;
+	batman_packet_ogm = (struct batman_packet_ogm *)skb->data;
 
-	if (batman_packet->version != COMPAT_VERSION) {
+	if (batman_packet_ogm->version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: incompatible batman version (%i)\n",
-			batman_packet->version);
+			batman_packet_ogm->version);
 		goto err_free;
 	}
 
 	/* all receive handlers return whether they received or reused
 	 * the supplied skb. if not, we have to free the skb. */
 
-	switch (batman_packet->packet_type) {
+	switch (batman_packet_ogm->packet_type) {
 		/* batman originator packet */
-	case BAT_PACKET:
+	case BAT_PACKET_OGM:
 		ret = recv_bat_packet(skb, batman_if);
 		break;
 
diff --git a/packet.h b/packet.h
index b49fdf7..beb1b56 100644
--- a/packet.h
+++ b/packet.h
@@ -24,12 +24,13 @@
 
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
-#define BAT_PACKET       0x01
-#define BAT_ICMP         0x02
-#define BAT_UNICAST      0x03
-#define BAT_BCAST        0x04
-#define BAT_VIS          0x05
-#define BAT_UNICAST_FRAG 0x06
+#define BAT_PACKET_NDP   0x01
+#define BAT_PACKET_OGM   0x02
+#define BAT_ICMP         0x03
+#define BAT_UNICAST      0x04
+#define BAT_BCAST        0x05
+#define BAT_VIS          0x06
+#define BAT_UNICAST_FRAG 0x07
 
 /* this file is included by batctl which needs these defines */
 #define COMPAT_VERSION 12
@@ -51,7 +52,18 @@
 /* fragmentation defines */
 #define UNI_FRAG_HEAD 0x01
 
-struct batman_packet {
+/* Neighbor discovery packet */
+struct batman_packet_ndp {
+	uint8_t  packet_type;
+	uint8_t  version;  /* batman version field */
+	uint8_t  orig[6];
+	uint32_t seqno;
+	uint8_t  num_neighbors;
+	uint8_t  align[3];
+} __attribute__((packed));
+
+/* Originator message packet */
+struct batman_packet_ogm {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
@@ -65,7 +77,7 @@ struct batman_packet {
 	uint8_t  align;
 } __attribute__((packed));
 
-#define BAT_PACKET_LEN sizeof(struct batman_packet)
+#define BAT_PACKET_OGM_LEN sizeof(struct batman_packet_ogm)
 
 struct icmp_packet {
 	uint8_t  packet_type;
diff --git a/routing.c b/routing.c
index d8b0c5a..a9406ba 100644
--- a/routing.c
+++ b/routing.c
@@ -130,7 +130,7 @@ void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 
 static int is_bidirectional_neigh(struct orig_node *orig_node,
 				struct orig_node *orig_neigh_node,
-				struct batman_packet *batman_packet,
+				struct batman_packet_ogm *batman_packet_ogm,
 				struct batman_if *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
@@ -215,7 +215,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		 TQ_LOCAL_WINDOW_SIZE *
 		 TQ_LOCAL_WINDOW_SIZE);
 
-	batman_packet->tq = ((batman_packet->tq *
+	batman_packet_ogm->tq = ((batman_packet_ogm->tq *
 			      orig_neigh_node->tq_own *
 			      orig_neigh_node->tq_asym_penalty) /
 			     (TQ_MAX_VALUE * TQ_MAX_VALUE));
@@ -227,11 +227,11 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 		"total tq: %3i\n",
 		orig_node->orig, orig_neigh_node->orig, total_count,
 		neigh_node->real_packet_count, orig_neigh_node->tq_own,
-		orig_neigh_node->tq_asym_penalty, batman_packet->tq);
+		orig_neigh_node->tq_asym_penalty, batman_packet_ogm->tq);
 
 	/* if link has the minimum required transmission quality
 	 * consider it bidirectional */
-	if (batman_packet->tq >= TQ_TOTAL_BIDRECT_LIMIT)
+	if (batman_packet_ogm->tq >= TQ_TOTAL_BIDRECT_LIMIT)
 		return 1;
 
 	return 0;
@@ -240,7 +240,7 @@ static int is_bidirectional_neigh(struct orig_node *orig_node,
 static void update_orig(struct bat_priv *bat_priv,
 			struct orig_node *orig_node,
 			struct ethhdr *ethhdr,
-			struct batman_packet *batman_packet,
+			struct batman_packet_ogm *batman_packet_ogm,
 			struct batman_if *if_incoming,
 			unsigned char *hna_buff, int hna_buff_len,
 			char is_duplicate)
@@ -282,21 +282,21 @@ static void update_orig(struct bat_priv *bat_priv,
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Updating existing last-hop neighbor of originator\n");
 
-	orig_node->flags = batman_packet->flags;
+	orig_node->flags = batman_packet_ogm->flags;
 	neigh_node->last_valid = jiffies;
 
 	ring_buffer_set(neigh_node->tq_recv,
 			&neigh_node->tq_index,
-			batman_packet->tq);
+			batman_packet_ogm->tq);
 	neigh_node->tq_avg = ring_buffer_avg(neigh_node->tq_recv);
 
 	if (!is_duplicate) {
-		orig_node->last_ttl = batman_packet->ttl;
-		neigh_node->last_ttl = batman_packet->ttl;
+		orig_node->last_ttl = batman_packet_ogm->ttl;
+		neigh_node->last_ttl = batman_packet_ogm->ttl;
 	}
 
-	tmp_hna_buff_len = (hna_buff_len > batman_packet->num_hna * ETH_ALEN ?
-			    batman_packet->num_hna * ETH_ALEN : hna_buff_len);
+	tmp_hna_buff_len = (hna_buff_len > batman_packet_ogm->num_hna * ETH_ALEN ?
+			    batman_packet_ogm->num_hna * ETH_ALEN : hna_buff_len);
 
 	/* if this neighbor already is our next hop there is nothing
 	 * to change */
@@ -325,10 +325,11 @@ update_hna:
 		      hna_buff, tmp_hna_buff_len);
 
 update_gw:
-	if (orig_node->gw_flags != batman_packet->gw_flags)
-		gw_node_update(bat_priv, orig_node, batman_packet->gw_flags);
+	if (orig_node->gw_flags != batman_packet_ogm->gw_flags)
+		gw_node_update(bat_priv, orig_node,
+			       batman_packet_ogm->gw_flags);
 
-	orig_node->gw_flags = batman_packet->gw_flags;
+	orig_node->gw_flags = batman_packet_ogm->gw_flags;
 
 	/* restart gateway selection if fast or late switching was enabled */
 	if ((orig_node->gw_flags) &&
@@ -371,7 +372,7 @@ static int window_protected(struct bat_priv *bat_priv,
  *     was protected. Caller should drop it.
  */
 static char count_real_packets(struct ethhdr *ethhdr,
-			       struct batman_packet *batman_packet,
+			       struct batman_packet_ogm *batman_packet_ogm,
 			       struct batman_if *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
@@ -382,11 +383,11 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	int need_update = 0;
 	int set_mark;
 
-	orig_node = get_orig_node(bat_priv, batman_packet->orig);
+	orig_node = get_orig_node(bat_priv, batman_packet_ogm->orig);
 	if (orig_node == NULL)
 		return 0;
 
-	seq_diff = batman_packet->seqno - orig_node->last_real_seqno;
+	seq_diff = batman_packet_ogm->seqno - orig_node->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
 	if (window_protected(bat_priv, seq_diff,
@@ -397,7 +398,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 
 		is_duplicate |= get_bit_status(tmp_neigh_node->real_bits,
 					       orig_node->last_real_seqno,
-					       batman_packet->seqno);
+					       batman_packet_ogm->seqno);
 
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
 		    (tmp_neigh_node->if_incoming == if_incoming))
@@ -417,8 +418,8 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	if (need_update) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"updating last_seqno: old %d, new %d\n",
-			orig_node->last_real_seqno, batman_packet->seqno);
-		orig_node->last_real_seqno = batman_packet->seqno;
+			orig_node->last_real_seqno, batman_packet_ogm->seqno);
+		orig_node->last_real_seqno = batman_packet_ogm->seqno;
 	}
 
 	return is_duplicate;
@@ -428,10 +429,10 @@ static char count_real_packets(struct ethhdr *ethhdr,
 static void mark_bonding_address(struct bat_priv *bat_priv,
 				 struct orig_node *orig_node,
 				 struct orig_node *orig_neigh_node,
-				 struct batman_packet *batman_packet)
+				 struct batman_packet_ogm *batman_packet_ogm)
 
 {
-	if (batman_packet->flags & PRIMARIES_FIRST_HOP)
+	if (batman_packet_ogm->flags & PRIMARIES_FIRST_HOP)
 		memcpy(orig_neigh_node->primary_addr,
 		       orig_node->orig, ETH_ALEN);
 
@@ -532,7 +533,7 @@ void update_bonding_candidates(struct bat_priv *bat_priv,
 }
 
 void receive_bat_packet(struct ethhdr *ethhdr,
-				struct batman_packet *batman_packet,
+				struct batman_packet_ogm *batman_packet_ogm,
 				unsigned char *hna_buff, int hna_buff_len,
 				struct batman_if *if_incoming)
 {
@@ -553,30 +554,30 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	 * it as an additional length.
 	 *
 	 * TODO: A more sane solution would be to have a bit in the
-	 * batman_packet to detect whether the packet is the last
+	 * batman_packet_ogm to detect whether the packet is the last
 	 * packet in an aggregation.  Here we expect that the padding
 	 * is always zero (or not 0x01)
 	 */
-	if (batman_packet->packet_type != BAT_PACKET)
+	if (batman_packet_ogm->packet_type != BAT_PACKET_OGM)
 		return;
 
 	/* could be changed by schedule_own_packet() */
 	if_incoming_seqno = atomic_read(&if_incoming->seqno);
 
-	has_directlink_flag = (batman_packet->flags & DIRECTLINK ? 1 : 0);
+	has_directlink_flag = (batman_packet_ogm->flags & DIRECTLINK ? 1 : 0);
 
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
-					    batman_packet->orig) ? 1 : 0);
+					    batman_packet_ogm->orig) ? 1 : 0);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Received BATMAN packet via NB: %pM, IF: %s [%pM] "
 		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
 		"TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->net_dev->name,
-		if_incoming->net_dev->dev_addr, batman_packet->orig,
-		batman_packet->prev_sender, batman_packet->seqno,
-		batman_packet->tq, batman_packet->ttl, batman_packet->version,
-		has_directlink_flag);
+		if_incoming->net_dev->dev_addr, batman_packet_ogm->orig,
+		batman_packet_ogm->prev_sender, batman_packet_ogm->seqno,
+		batman_packet_ogm->tq, batman_packet_ogm->ttl,
+		batman_packet_ogm->version, has_directlink_flag);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
@@ -590,11 +591,11 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				 batman_if->net_dev->dev_addr))
 			is_my_addr = 1;
 
-		if (compare_orig(batman_packet->orig,
+		if (compare_orig(batman_packet_ogm->orig,
 				 batman_if->net_dev->dev_addr))
 			is_my_orig = 1;
 
-		if (compare_orig(batman_packet->prev_sender,
+		if (compare_orig(batman_packet_ogm->prev_sender,
 				 batman_if->net_dev->dev_addr))
 			is_my_oldorig = 1;
 
@@ -603,10 +604,10 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 	rcu_read_unlock();
 
-	if (batman_packet->version != COMPAT_VERSION) {
+	if (batman_packet_ogm->version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: incompatible batman version (%i)\n",
-			batman_packet->version);
+			batman_packet_ogm->version);
 		return;
 	}
 
@@ -640,8 +641,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		 * seqno for bidirectional check */
 		if (has_directlink_flag &&
 		    compare_orig(if_incoming->net_dev->dev_addr,
-				 batman_packet->orig) &&
-		    (batman_packet->seqno - if_incoming_seqno + 2 == 0)) {
+				 batman_packet_ogm->orig) &&
+		    (batman_packet_ogm->seqno - if_incoming_seqno + 2 == 0)) {
 			offset = if_incoming->if_num * NUM_WORDS;
 			word = &(orig_neigh_node->bcast_own[offset]);
 			bit_mark(word, 0);
@@ -661,11 +662,11 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		return;
 	}
 
-	orig_node = get_orig_node(bat_priv, batman_packet->orig);
+	orig_node = get_orig_node(bat_priv, batman_packet_ogm->orig);
 	if (orig_node == NULL)
 		return;
 
-	is_duplicate = count_real_packets(ethhdr, batman_packet, if_incoming);
+	is_duplicate = count_real_packets(ethhdr, batman_packet_ogm, if_incoming);
 
 	if (is_duplicate == -1) {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -674,7 +675,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		return;
 	}
 
-	if (batman_packet->tq == 0) {
+	if (batman_packet_ogm->tq == 0) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Drop packet: originator packet with tq equal 0\n");
 		return;
@@ -684,8 +685,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	if ((orig_node->router) &&
 	    (orig_node->router->orig_node->router) &&
 	    (compare_orig(orig_node->router->addr,
-			  batman_packet->prev_sender)) &&
-	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
+			  batman_packet_ogm->prev_sender)) &&
+	    !(compare_orig(batman_packet_ogm->orig, batman_packet_ogm->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -712,26 +713,26 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	is_bidirectional = is_bidirectional_neigh(orig_node, orig_neigh_node,
-						batman_packet, if_incoming);
+						batman_packet_ogm, if_incoming);
 
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate */
 	if (is_bidirectional &&
 	    (!is_duplicate ||
-	     ((orig_node->last_real_seqno == batman_packet->seqno) &&
-	      (orig_node->last_ttl - 3 <= batman_packet->ttl))))
-		update_orig(bat_priv, orig_node, ethhdr, batman_packet,
+	     ((orig_node->last_real_seqno == batman_packet_ogm->seqno) &&
+	      (orig_node->last_ttl - 3 <= batman_packet_ogm->ttl))))
+		update_orig(bat_priv, orig_node, ethhdr, batman_packet_ogm,
 			    if_incoming, hna_buff, hna_buff_len, is_duplicate);
 
 	mark_bonding_address(bat_priv, orig_node,
-			     orig_neigh_node, batman_packet);
+			     orig_neigh_node, batman_packet_ogm);
 	update_bonding_candidates(bat_priv, orig_node);
 
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
 
 		/* mark direct link on incoming interface */
-		schedule_forward_packet(orig_node, ethhdr, batman_packet,
+		schedule_forward_packet(orig_node, ethhdr, batman_packet_ogm,
 					1, hna_buff_len, if_incoming);
 
 		bat_dbg(DBG_BATMAN, bat_priv, "Forwarding packet: "
@@ -754,7 +755,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: rebroadcast originator packet\n");
-	schedule_forward_packet(orig_node, ethhdr, batman_packet,
+	schedule_forward_packet(orig_node, ethhdr, batman_packet_ogm,
 				0, hna_buff_len, if_incoming);
 }
 
@@ -764,7 +765,7 @@ int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
 	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
-	if (unlikely(!pskb_may_pull(skb, sizeof(struct batman_packet))))
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct batman_packet_ogm))))
 		return NET_RX_DROP;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
diff --git a/routing.h b/routing.h
index f108f23..81e27d5 100644
--- a/routing.h
+++ b/routing.h
@@ -26,7 +26,7 @@
 
 void slide_own_bcast_window(struct batman_if *batman_if);
 void receive_bat_packet(struct ethhdr *ethhdr,
-				struct batman_packet *batman_packet,
+				struct batman_packet_ogm *batman_packet_ogm,
 				unsigned char *hna_buff, int hna_buff_len,
 				struct batman_if *if_incoming);
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
diff --git a/send.c b/send.c
index b89b9f7..eb9c1e3 100644
--- a/send.c
+++ b/send.c
@@ -109,7 +109,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 	char *fwd_str;
 	uint8_t packet_num;
 	int16_t buff_pos;
-	struct batman_packet *batman_packet;
+	struct batman_packet_ogm *batman_packet_ogm;
 	struct sk_buff *skb;
 
 	if (batman_if->if_status != IF_ACTIVE)
@@ -117,20 +117,20 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 
 	packet_num = 0;
 	buff_pos = 0;
-	batman_packet = (struct batman_packet *)forw_packet->skb->data;
+	batman_packet_ogm = (struct batman_packet_ogm *)forw_packet->skb->data;
 
 	/* adjust all flags and log packets */
 	while (aggregated_packet(buff_pos,
 				 forw_packet->packet_len,
-				 batman_packet->num_hna)) {
+				 batman_packet_ogm->num_hna)) {
 
 		/* we might have aggregated direct link packets with an
 		 * ordinary base packet */
 		if ((forw_packet->direct_link_flags & (1 << packet_num)) &&
 		    (forw_packet->if_incoming == batman_if))
-			batman_packet->flags |= DIRECTLINK;
+			batman_packet_ogm->flags |= DIRECTLINK;
 		else
-			batman_packet->flags &= ~DIRECTLINK;
+			batman_packet_ogm->flags &= ~DIRECTLINK;
 
 		fwd_str = (packet_num > 0 ? "Forwarding" : (forw_packet->own ?
 							    "Sending own" :
@@ -139,16 +139,16 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d,"
 			" IDF %s) on interface %s [%pM]\n",
 			fwd_str, (packet_num > 0 ? "aggregated " : ""),
-			batman_packet->orig, ntohl(batman_packet->seqno),
-			batman_packet->tq, batman_packet->ttl,
-			(batman_packet->flags & DIRECTLINK ?
+			batman_packet_ogm->orig, ntohl(batman_packet_ogm->seqno),
+			batman_packet_ogm->tq, batman_packet_ogm->ttl,
+			(batman_packet_ogm->flags & DIRECTLINK ?
 			 "on" : "off"),
 			batman_if->net_dev->name, batman_if->net_dev->dev_addr);
 
-		buff_pos += sizeof(struct batman_packet) +
-			(batman_packet->num_hna * ETH_ALEN);
+		buff_pos += sizeof(struct batman_packet_ogm) +
+			(batman_packet_ogm->num_hna * ETH_ALEN);
 		packet_num++;
-		batman_packet = (struct batman_packet *)
+		batman_packet_ogm = (struct batman_packet_ogm *)
 			(forw_packet->skb->data + buff_pos);
 	}
 
@@ -164,9 +164,10 @@ static void send_packet(struct forw_packet *forw_packet)
 	struct batman_if *batman_if;
 	struct net_device *soft_iface;
 	struct bat_priv *bat_priv;
-	struct batman_packet *batman_packet =
-		(struct batman_packet *)(forw_packet->skb->data);
-	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
+	struct batman_packet_ogm *batman_packet_ogm =
+			(struct batman_packet_ogm *)(forw_packet->skb->data);
+	unsigned char directlink =
+			(batman_packet_ogm->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not "
@@ -182,7 +183,7 @@ static void send_packet(struct forw_packet *forw_packet)
 
 	/* multihomed peer assumed */
 	/* non-primary OGMs are only broadcasted on their interface */
-	if ((directlink && (batman_packet->ttl == 1)) ||
+	if ((directlink && (batman_packet_ogm->ttl == 1)) ||
 	    (forw_packet->own && (forw_packet->if_incoming->if_num > 0))) {
 
 		/* FIXME: what about aggregated packets ? */
@@ -190,8 +191,9 @@ static void send_packet(struct forw_packet *forw_packet)
 			"%s packet (originator %pM, seqno %d, TTL %d) "
 			"on interface %s [%pM]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
-			batman_packet->orig, ntohl(batman_packet->seqno),
-			batman_packet->ttl,
+			batman_packet_ogm->orig,
+			ntohl(batman_packet_ogm->seqno),
+			batman_packet_ogm->ttl,
 			forw_packet->if_incoming->net_dev->name,
 			forw_packet->if_incoming->net_dev->dev_addr);
 
@@ -214,26 +216,26 @@ static void send_packet(struct forw_packet *forw_packet)
 	rcu_read_unlock();
 }
 
-static void rebuild_batman_packet(struct bat_priv *bat_priv,
-				  struct batman_if *batman_if)
+static void rebuild_batman_packet_ogm(struct bat_priv *bat_priv,
+				      struct batman_if *batman_if)
 {
 	int new_len;
 	unsigned char *new_buff;
-	struct batman_packet *batman_packet;
+	struct batman_packet_ogm *batman_packet_ogm;
 
-	new_len = sizeof(struct batman_packet) +
+	new_len = sizeof(struct batman_packet_ogm) +
 			(bat_priv->num_local_hna * ETH_ALEN);
 	new_buff = kmalloc(new_len, GFP_ATOMIC);
 
 	/* keep old buffer if kmalloc should fail */
 	if (new_buff) {
 		memcpy(new_buff, batman_if->packet_buff,
-		       sizeof(struct batman_packet));
-		batman_packet = (struct batman_packet *)new_buff;
+		       sizeof(struct batman_packet_ogm));
+		batman_packet_ogm = (struct batman_packet_ogm *)new_buff;
 
-		batman_packet->num_hna = hna_local_fill_buffer(bat_priv,
-				new_buff + sizeof(struct batman_packet),
-				new_len - sizeof(struct batman_packet));
+		batman_packet_ogm->num_hna = hna_local_fill_buffer(bat_priv,
+				new_buff + sizeof(struct batman_packet_ogm),
+				new_len - sizeof(struct batman_packet_ogm));
 
 		kfree(batman_if->packet_buff);
 		batman_if->packet_buff = new_buff;
@@ -245,7 +247,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	unsigned long send_time;
-	struct batman_packet *batman_packet;
+	struct batman_packet_ogm *batman_packet_ogm;
 	int vis_server;
 
 	if ((batman_if->if_status == IF_NOT_IN_USE) ||
@@ -267,29 +269,29 @@ void schedule_own_packet(struct batman_if *batman_if)
 	/* if local hna has changed and interface is a primary interface */
 	if ((atomic_read(&bat_priv->hna_local_changed)) &&
 	    (batman_if == bat_priv->primary_if))
-		rebuild_batman_packet(bat_priv, batman_if);
+		rebuild_batman_packet_ogm(bat_priv, batman_if);
 
 	/**
 	 * NOTE: packet_buff might just have been re-allocated in
-	 * rebuild_batman_packet()
+	 * rebuild_batman_packet_ogm()
 	 */
-	batman_packet = (struct batman_packet *)batman_if->packet_buff;
+	batman_packet_ogm = (struct batman_packet_ogm *)batman_if->packet_buff;
 
 	/* change sequence number to network order */
-	batman_packet->seqno =
+	batman_packet_ogm->seqno =
 		htonl((uint32_t)atomic_read(&batman_if->seqno));
 
 	if (vis_server == VIS_TYPE_SERVER_SYNC)
-		batman_packet->flags |= VIS_SERVER;
+		batman_packet_ogm->flags |= VIS_SERVER;
 	else
-		batman_packet->flags &= ~VIS_SERVER;
+		batman_packet_ogm->flags &= ~VIS_SERVER;
 
 	if ((batman_if == bat_priv->primary_if) &&
 	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER))
-		batman_packet->gw_flags =
+		batman_packet_ogm->gw_flags =
 				(uint8_t)atomic_read(&bat_priv->gw_bandwidth);
 	else
-		batman_packet->gw_flags = 0;
+		batman_packet_ogm->gw_flags = 0;
 
 	atomic_inc(&batman_if->seqno);
 
@@ -303,7 +305,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 
 void schedule_forward_packet(struct orig_node *orig_node,
 			     struct ethhdr *ethhdr,
-			     struct batman_packet *batman_packet,
+			     struct batman_packet_ogm *batman_packet_ogm,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_incoming)
 {
@@ -311,16 +313,16 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
 
-	if (batman_packet->ttl <= 1) {
+	if (batman_packet_ogm->ttl <= 1) {
 		bat_dbg(DBG_BATMAN, bat_priv, "ttl exceeded\n");
 		return;
 	}
 
-	in_tq = batman_packet->tq;
-	in_ttl = batman_packet->ttl;
+	in_tq = batman_packet_ogm->tq;
+	in_ttl = batman_packet_ogm->ttl;
 
-	batman_packet->ttl--;
-	memcpy(batman_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
+	batman_packet_ogm->ttl--;
+	memcpy(batman_packet_ogm->prev_sender, ethhdr->h_source, ETH_ALEN);
 
 	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
 	 * of our best tq value */
@@ -328,10 +330,10 @@ void schedule_forward_packet(struct orig_node *orig_node,
 
 		/* rebroadcast ogm of best ranking neighbor as is */
 		if (!compare_orig(orig_node->router->addr, ethhdr->h_source)) {
-			batman_packet->tq = orig_node->router->tq_avg;
+			batman_packet_ogm->tq = orig_node->router->tq_avg;
 
 			if (orig_node->router->last_ttl)
-				batman_packet->ttl = orig_node->router->last_ttl
+				batman_packet_ogm->ttl = orig_node->router->last_ttl
 							- 1;
 		}
 
@@ -339,27 +341,27 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	}
 
 	/* apply hop penalty */
-	batman_packet->tq = hop_penalty(batman_packet->tq, bat_priv);
+	batman_packet_ogm->tq = hop_penalty(batman_packet_ogm->tq, bat_priv);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
 		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
-		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
-		batman_packet->ttl);
+		in_tq, tq_avg, batman_packet_ogm->tq, in_ttl - 1,
+		batman_packet_ogm->ttl);
 
-	batman_packet->seqno = htonl(batman_packet->seqno);
+	batman_packet_ogm->seqno = htonl(batman_packet_ogm->seqno);
 
 	/* switch of primaries first hop flag when forwarding */
-	batman_packet->flags &= ~PRIMARIES_FIRST_HOP;
+	batman_packet_ogm->flags &= ~PRIMARIES_FIRST_HOP;
 	if (directlink)
-		batman_packet->flags |= DIRECTLINK;
+		batman_packet_ogm->flags |= DIRECTLINK;
 	else
-		batman_packet->flags &= ~DIRECTLINK;
+		batman_packet_ogm->flags &= ~DIRECTLINK;
 
 	send_time = forward_send_time(bat_priv);
 	add_bat_packet_to_list(bat_priv,
-			       (unsigned char *)batman_packet,
-			       sizeof(struct batman_packet) + hna_buff_len,
+			       (unsigned char *)batman_packet_ogm,
+			       sizeof(struct batman_packet_ogm) + hna_buff_len,
 			       if_incoming, 0, send_time);
 }
 
diff --git a/send.h b/send.h
index c4cefa8..acf59e7 100644
--- a/send.h
+++ b/send.h
@@ -30,7 +30,7 @@ int send_skb_packet(struct sk_buff *skb,
 void schedule_own_packet(struct batman_if *batman_if);
 void schedule_forward_packet(struct orig_node *orig_node,
 			     struct ethhdr *ethhdr,
-			     struct batman_packet *batman_packet,
+			     struct batman_packet_ogm *batman_packet_ogm,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_outgoing);
 int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb);
diff --git a/soft-interface.c b/soft-interface.c
index e89ede1..ac65bc1 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -221,28 +221,30 @@ static void softif_batman_recv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
-	struct batman_packet *batman_packet;
+	struct batman_packet_ogm *batman_packet_ogm;
 	struct softif_neigh *softif_neigh, *softif_neigh_tmp;
 
 	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q)
-		batman_packet = (struct batman_packet *)
+		batman_packet_ogm = (struct batman_packet_ogm *)
 					(skb->data + ETH_HLEN + VLAN_HLEN);
 	else
-		batman_packet = (struct batman_packet *)(skb->data + ETH_HLEN);
+		batman_packet_ogm = (struct batman_packet_ogm *)
+					(skb->data + ETH_HLEN);
 
-	if (batman_packet->version != COMPAT_VERSION)
+	if (batman_packet_ogm->version != COMPAT_VERSION)
 		goto err;
 
-	if (batman_packet->packet_type != BAT_PACKET)
+	if (batman_packet_ogm->packet_type != BAT_PACKET_OGM)
 		goto err;
 
-	if (!(batman_packet->flags & PRIMARIES_FIRST_HOP))
+	if (!(batman_packet_ogm->flags & PRIMARIES_FIRST_HOP))
 		goto err;
 
-	if (is_my_mac(batman_packet->orig))
+	if (is_my_mac(batman_packet_ogm->orig))
 		goto err;
 
-	softif_neigh = softif_neigh_get(bat_priv, batman_packet->orig, vid);
+	softif_neigh = softif_neigh_get(bat_priv, batman_packet_ogm->orig,
+					vid);
 
 	if (!softif_neigh)
 		goto err;
diff --git a/translation-table.c b/translation-table.c
index 4b0a107..6d5d3ec 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -77,7 +77,7 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	   space in batman_packet->num_hna That also should give a limit to
 	   MAC-flooding. */
 	required_bytes = (bat_priv->num_local_hna + 1) * ETH_ALEN;
-	required_bytes += BAT_PACKET_LEN;
+	required_bytes += BAT_PACKET_OGM_LEN;
 
 	if ((required_bytes > ETH_DATA_LEN) ||
 	    (atomic_read(&bat_priv->aggregated_ogms) &&
-- 
1.7.1

