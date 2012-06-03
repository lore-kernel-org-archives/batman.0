Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:13 +0200
Message-Id: <1338754762-28424-7-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 07/16] batman-adv: Prefix packet defines with
	BATADV_
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

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_iv_ogm.c        |   20 ++++++++++----------
 hard-interface.c    |    3 ++-
 icmp_socket.c       |    4 ++--
 main.c              |    4 ++--
 packet.h            |   12 ++++++------
 routing.c           |    4 ++--
 send.c              |    4 ++--
 soft-interface.c    |   12 +++++++-----
 translation-table.c |    8 ++++----
 unicast.c           |    4 ++--
 vis.c               |    2 +-
 11 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 9e83f35..825054a 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -64,7 +64,7 @@ static int batadv_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
 	atomic_set(&hard_iface->seqno, random_seqno);
 
-	hard_iface->packet_len = BATMAN_OGM_HLEN;
+	hard_iface->packet_len = BATADV_OGM_HLEN;
 	hard_iface->packet_buff = kmalloc(hard_iface->packet_len, GFP_ATOMIC);
 
 	if (!hard_iface->packet_buff)
@@ -72,7 +72,7 @@ static int batadv_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 
 	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
 	batman_ogm_packet->header.packet_type = BAT_IV_OGM;
-	batman_ogm_packet->header.version = COMPAT_VERSION;
+	batman_ogm_packet->header.version = BATADV_COMPAT_VERSION;
 	batman_ogm_packet->header.ttl = 2;
 	batman_ogm_packet->flags = NO_FLAGS;
 	batman_ogm_packet->tq = TQ_MAX_VALUE;
@@ -139,7 +139,7 @@ static int batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 {
 	int next_buff_pos = 0;
 
-	next_buff_pos += buff_pos + BATMAN_OGM_HLEN;
+	next_buff_pos += buff_pos + BATADV_OGM_HLEN;
 	next_buff_pos += batadv_tt_len(tt_num_changes);
 
 	return (next_buff_pos <= packet_len) &&
@@ -191,7 +191,7 @@ static void batadv_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 			   batman_ogm_packet->ttvn, hard_iface->net_dev->name,
 			   hard_iface->net_dev->dev_addr);
 
-		buff_pos += BATMAN_OGM_HLEN;
+		buff_pos += BATADV_OGM_HLEN;
 		buff_pos += batadv_tt_len(batman_ogm_packet->tt_num_changes);
 		packet_num++;
 		batman_ogm_packet = (struct batman_ogm_packet *)
@@ -561,7 +561,7 @@ static void batadv_iv_ogm_forward(struct orig_node *orig_node,
 		batman_ogm_packet->flags &= ~DIRECTLINK;
 
 	batadv_iv_ogm_queue_add(bat_priv, (unsigned char *)batman_ogm_packet,
-				BATMAN_OGM_HLEN + batadv_tt_len(tt_num_changes),
+				BATADV_OGM_HLEN + batadv_tt_len(tt_num_changes),
 				if_incoming, 0, batadv_iv_ogm_fwd_send_time());
 }
 
@@ -579,7 +579,7 @@ static void batadv_iv_ogm_schedule(struct hard_iface *hard_iface)
 		tt_num_changes = batadv_tt_append_diff(bat_priv,
 						       &hard_iface->packet_buff,
 						       &hard_iface->packet_len,
-						       BATMAN_OGM_HLEN);
+						       BATADV_OGM_HLEN);
 
 	batman_ogm_packet = (struct batman_ogm_packet *)hard_iface->packet_buff;
 
@@ -1025,7 +1025,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	}
 	rcu_read_unlock();
 
-	if (batman_ogm_packet->header.version != COMPAT_VERSION) {
+	if (batman_ogm_packet->header.version != BATADV_COMPAT_VERSION) {
 		batadv_dbg(DBG_BATMAN, bat_priv,
 			   "Drop packet: incompatible batman version (%i)\n",
 			   batman_ogm_packet->header.version);
@@ -1227,7 +1227,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 	unsigned char *tt_buff, *packet_buff;
 	bool ret;
 
-	ret = batadv_check_management_packet(skb, if_incoming, BATMAN_OGM_HLEN);
+	ret = batadv_check_management_packet(skb, if_incoming, BATADV_OGM_HLEN);
 	if (!ret)
 		return NET_RX_DROP;
 
@@ -1248,12 +1248,12 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 
 	/* unpack the aggregated packets and process them one by one */
 	do {
-		tt_buff = packet_buff + buff_pos + BATMAN_OGM_HLEN;
+		tt_buff = packet_buff + buff_pos + BATADV_OGM_HLEN;
 
 		batadv_iv_ogm_process(ethhdr, batman_ogm_packet, tt_buff,
 				      if_incoming);
 
-		buff_pos += BATMAN_OGM_HLEN;
+		buff_pos += BATADV_OGM_HLEN;
 		buff_pos += batadv_tt_len(batman_ogm_packet->tt_num_changes);
 
 		batman_ogm_packet = (struct batman_ogm_packet *)
diff --git a/hard-interface.c b/hard-interface.c
index ef81f01..1db2d05 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -263,6 +263,7 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 {
 	struct bat_priv *bat_priv;
 	struct net_device *soft_iface;
+	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
 	int ret;
 
 	if (hard_iface->if_status != IF_NOT_IN_USE)
@@ -309,7 +310,7 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 	hard_iface->if_status = IF_INACTIVE;
 	batadv_orig_hash_add_if(hard_iface, bat_priv->num_ifaces);
 
-	hard_iface->batman_adv_ptype.type = __constant_htons(ETH_P_BATMAN);
+	hard_iface->batman_adv_ptype.type = ethertype;
 	hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv;
 	hard_iface->batman_adv_ptype.dev = hard_iface->net_dev;
 	dev_add_pack(&hard_iface->batman_adv_ptype);
diff --git a/icmp_socket.c b/icmp_socket.c
index 1f6df39..319235d 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -203,9 +203,9 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 
 	icmp_packet->uid = socket_client->index;
 
-	if (icmp_packet->header.version != COMPAT_VERSION) {
+	if (icmp_packet->header.version != BATADV_COMPAT_VERSION) {
 		icmp_packet->msg_type = PARAMETER_PROBLEM;
-		icmp_packet->header.version = COMPAT_VERSION;
+		icmp_packet->header.version = BATADV_COMPAT_VERSION;
 		batadv_socket_add_packet(socket_client, icmp_packet,
 					 packet_len);
 		goto free_skb;
diff --git a/main.c b/main.c
index 9cf0b38..986be72 100644
--- a/main.c
+++ b/main.c
@@ -72,7 +72,7 @@ static int __init batadv_init(void)
 	register_netdevice_notifier(&batadv_hard_if_notifier);
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-		SOURCE_VERSION, COMPAT_VERSION);
+		SOURCE_VERSION, BATADV_COMPAT_VERSION);
 
 	return 0;
 }
@@ -238,7 +238,7 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 
 	batman_ogm_packet = (struct batman_ogm_packet *)skb->data;
 
-	if (batman_ogm_packet->header.version != COMPAT_VERSION) {
+	if (batman_ogm_packet->header.version != BATADV_COMPAT_VERSION) {
 		batadv_dbg(DBG_BATMAN, bat_priv,
 			   "Drop packet: incompatible batman version (%i)\n",
 			   batman_ogm_packet->header.version);
diff --git a/packet.h b/packet.h
index c90219c..e562414 100644
--- a/packet.h
+++ b/packet.h
@@ -20,7 +20,7 @@
 #ifndef _NET_BATMAN_ADV_PACKET_H_
 #define _NET_BATMAN_ADV_PACKET_H_
 
-#define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
+#define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype */
 
 enum bat_packettype {
 	BAT_IV_OGM	 = 0x01,
@@ -34,7 +34,7 @@ enum bat_packettype {
 };
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 14
+#define BATADV_COMPAT_VERSION 14
 
 enum batman_iv_flags {
 	NOT_BEST_NEXT_HOP   = 1 << 3,
@@ -65,7 +65,7 @@ enum unicast_frag_flags {
 };
 
 /* TT_QUERY subtypes */
-#define TT_QUERY_TYPE_MASK 0x3
+#define BATADV_TT_QUERY_TYPE_MASK 0x3
 
 enum tt_query_packettype {
 	TT_REQUEST    = 0,
@@ -126,7 +126,7 @@ struct batman_ogm_packet {
 	__be16   tt_crc;
 } __packed;
 
-#define BATMAN_OGM_HLEN sizeof(struct batman_ogm_packet)
+#define BATADV_OGM_HLEN sizeof(struct batman_ogm_packet)
 
 struct icmp_packet {
 	struct batman_header header;
@@ -138,7 +138,7 @@ struct icmp_packet {
 	uint8_t  reserved;
 } __packed;
 
-#define BAT_RR_LEN 16
+#define BATADV_RR_LEN 16
 
 /* icmp_packet_rr must start with all fields from imcp_packet
  * as this is assumed by code that handles ICMP packets
@@ -151,7 +151,7 @@ struct icmp_packet_rr {
 	__be16   seqno;
 	uint8_t  uid;
 	uint8_t  rr_cur;
-	uint8_t  rr[BAT_RR_LEN][ETH_ALEN];
+	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 } __packed;
 
 struct unicast_packet {
diff --git a/routing.c b/routing.c
index c0737fa..f62fd85 100644
--- a/routing.c
+++ b/routing.c
@@ -423,7 +423,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	/* add record route information if not full */
 	if ((hdr_size == sizeof(struct icmp_packet_rr)) &&
-	    (icmp_packet->rr_cur < BAT_RR_LEN)) {
+	    (icmp_packet->rr_cur < BATADV_RR_LEN)) {
 		memcpy(&(icmp_packet->rr[icmp_packet->rr_cur]),
 		       ethhdr->h_dest, ETH_ALEN);
 		icmp_packet->rr_cur++;
@@ -603,7 +603,7 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	tt_query = (struct tt_query_packet *)skb->data;
 
-	switch (tt_query->flags & TT_QUERY_TYPE_MASK) {
+	switch (tt_query->flags & BATADV_TT_QUERY_TYPE_MASK) {
 	case TT_REQUEST:
 		batadv_inc_counter(bat_priv, BAT_CNT_TT_REQUEST_RX);
 
diff --git a/send.c b/send.c
index 3d725e0..72542cb 100644
--- a/send.c
+++ b/send.c
@@ -58,11 +58,11 @@ int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	memcpy(ethhdr->h_source, hard_iface->net_dev->dev_addr, ETH_ALEN);
 	memcpy(ethhdr->h_dest, dst_addr, ETH_ALEN);
-	ethhdr->h_proto = __constant_htons(ETH_P_BATMAN);
+	ethhdr->h_proto = __constant_htons(BATADV_ETH_P_BATMAN);
 
 	skb_set_network_header(skb, ETH_HLEN);
 	skb->priority = TC_PRIO_CONTROL;
-	skb->protocol = __constant_htons(ETH_P_BATMAN);
+	skb->protocol = __constant_htons(BATADV_ETH_P_BATMAN);
 
 	skb->dev = hard_iface->net_dev;
 
diff --git a/soft-interface.c b/soft-interface.c
index 2de1d74..e726419 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -135,6 +135,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	struct hard_iface *primary_if = NULL;
 	struct bcast_packet *bcast_packet;
 	struct vlan_ethhdr *vhdr;
+	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
 	static const uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00,
 						   0x00};
 	unsigned int header_len = 0;
@@ -152,11 +153,11 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		vhdr = (struct vlan_ethhdr *)skb->data;
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
 
-		if (ntohs(vhdr->h_vlan_encapsulated_proto) != ETH_P_BATMAN)
+		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
 
 		/* fall through */
-	case ETH_P_BATMAN:
+	case BATADV_ETH_P_BATMAN:
 		goto dropped;
 	}
 
@@ -208,7 +209,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			goto dropped;
 
 		bcast_packet = (struct bcast_packet *)skb->data;
-		bcast_packet->header.version = COMPAT_VERSION;
+		bcast_packet->header.version = BATADV_COMPAT_VERSION;
 		bcast_packet->header.ttl = TTL;
 
 		/* batman packet type: broadcast */
@@ -266,6 +267,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
 	short vid __maybe_unused = -1;
+	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
 
 	/* check if enough space is available for pulling, and pull */
 	if (!pskb_may_pull(skb, hdr_size))
@@ -281,11 +283,11 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		vhdr = (struct vlan_ethhdr *)skb->data;
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
 
-		if (ntohs(vhdr->h_vlan_encapsulated_proto) != ETH_P_BATMAN)
+		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
 
 		/* fall through */
-	case ETH_P_BATMAN:
+	case BATADV_ETH_P_BATMAN:
 		goto dropped;
 	}
 
diff --git a/translation-table.c b/translation-table.c
index c03c479..d6363a4 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1441,7 +1441,7 @@ static int batadv_send_tt_request(struct bat_priv *bat_priv,
 				sizeof(struct tt_query_packet));
 
 	tt_request->header.packet_type = BAT_TT_QUERY;
-	tt_request->header.version = COMPAT_VERSION;
+	tt_request->header.version = BATADV_COMPAT_VERSION;
 	memcpy(tt_request->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(tt_request->dst, dst_orig_node->orig, ETH_ALEN);
 	tt_request->header.ttl = TTL;
@@ -1575,7 +1575,7 @@ static bool batadv_send_other_tt_response(struct bat_priv *bat_priv,
 	}
 
 	tt_response->header.packet_type = BAT_TT_QUERY;
-	tt_response->header.version = COMPAT_VERSION;
+	tt_response->header.version = BATADV_COMPAT_VERSION;
 	tt_response->header.ttl = TTL;
 	memcpy(tt_response->src, req_dst_orig_node->orig, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
@@ -1696,7 +1696,7 @@ static bool batadv_send_my_tt_response(struct bat_priv *bat_priv,
 	}
 
 	tt_response->header.packet_type = BAT_TT_QUERY;
-	tt_response->header.version = COMPAT_VERSION;
+	tt_response->header.version = BATADV_COMPAT_VERSION;
 	tt_response->header.ttl = TTL;
 	memcpy(tt_response->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
@@ -2008,7 +2008,7 @@ static void batadv_send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 					sizeof(struct roam_adv_packet));
 
 	roam_adv_packet->header.packet_type = BAT_ROAM_ADV;
-	roam_adv_packet->header.version = COMPAT_VERSION;
+	roam_adv_packet->header.version = BATADV_COMPAT_VERSION;
 	roam_adv_packet->header.ttl = TTL;
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
diff --git a/unicast.c b/unicast.c
index f7a8cde..bafbbbf 100644
--- a/unicast.c
+++ b/unicast.c
@@ -253,7 +253,7 @@ int batadv_frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	memcpy(frag1, &tmp_uc, sizeof(tmp_uc));
 
 	frag1->header.ttl--;
-	frag1->header.version = COMPAT_VERSION;
+	frag1->header.version = BATADV_COMPAT_VERSION;
 	frag1->header.packet_type = BAT_UNICAST_FRAG;
 
 	memcpy(frag1->orig, primary_if->net_dev->dev_addr, ETH_ALEN);
@@ -321,7 +321,7 @@ find_router:
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	unicast_packet->header.version = COMPAT_VERSION;
+	unicast_packet->header.version = BATADV_COMPAT_VERSION;
 	/* batman packet type: unicast */
 	unicast_packet->header.packet_type = BAT_UNICAST;
 	/* set unicast ttl */
diff --git a/vis.c b/vis.c
index 7dc7506..596eacc 100644
--- a/vis.c
+++ b/vis.c
@@ -873,7 +873,7 @@ int batadv_vis_init(struct bat_priv *bat_priv)
 	INIT_LIST_HEAD(&bat_priv->my_vis_info->send_list);
 	kref_init(&bat_priv->my_vis_info->refcount);
 	bat_priv->my_vis_info->bat_priv = bat_priv;
-	packet->header.version = COMPAT_VERSION;
+	packet->header.version = BATADV_COMPAT_VERSION;
 	packet->header.packet_type = BAT_VIS;
 	packet->header.ttl = TTL;
 	packet->seqno = 0;
-- 
1.7.10

