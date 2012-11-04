Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2012 15:19:57 +0100
Message-Id: <1352038798-29658-3-git-send-email-sven@narfation.org>
In-Reply-To: <1352038798-29658-1-git-send-email-sven@narfation.org>
References: <1352038798-29658-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 3/4] batman-adv: Fix alignment and padding of
	packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The packets sent by batman-adv in COMPAT_VERSION 14 were badly aligned and
resulted in unnecessary extra cycles for architectures without load/store
operations on unaligned memory addresses. This also affects the payload like
the IP headers following after the unicast/broadcast headers and the ethernet
header.

COMPAT_VERSION 15 tries to fix this by adding extra reserved fields to ensure
that either the packet length is either a multiple of 4 bytes long or the
header plus the ethernet frame is a multiple of 4 bytes long. Also address
fields are now 2 bytes boundary aligned.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Did I told you that I don't intend to test this stuff?

 bat_iv_ogm.c        |    1 +
 packet.h            |   26 +++++++++++++++++++-------
 translation-table.c |    6 ++++++
 types.h             |    5 +++--
 unicast.c           |    4 ++++
 vis.c               |    2 ++
 6 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 5be9a3e..9cc7a81 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -80,6 +80,7 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	batadv_ogm_packet->tq = BATADV_TQ_MAX_VALUE;
 	batadv_ogm_packet->tt_num_changes = 0;
 	batadv_ogm_packet->ttvn = 0;
+	batadv_ogm_packet->reserved = 0;
 
 	res = 0;
 
diff --git a/packet.h b/packet.h
index 43c863c..c94ff5e 100644
--- a/packet.h
+++ b/packet.h
@@ -49,7 +49,7 @@ enum batadv_subtype {
 };
 
 /* this file is included by batctl which needs these defines */
-#define BATADV_COMPAT_VERSION 14
+#define BATADV_COMPAT_VERSION 15
 
 enum batadv_iv_flags {
 	BATADV_NOT_BEST_NEXT_HOP   = BIT(3),
@@ -142,7 +142,8 @@ struct batadv_ogm_packet {
 	uint8_t  tt_num_changes;
 	uint8_t  ttvn; /* translation table version number */
 	__be16   tt_crc;
-} __packed;
+	__be16   reserved;
+};
 
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
@@ -191,7 +192,11 @@ struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
 	uint8_t src[ETH_ALEN];
 	uint8_t subtype;
-} __packed;
+	uint8_t reserved;
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
+};
 
 struct batadv_unicast_frag_packet {
 	struct batadv_header header;
@@ -201,7 +206,11 @@ struct batadv_unicast_frag_packet {
 	uint8_t  align;
 	uint8_t  orig[ETH_ALEN];
 	__be16   seqno;
-} __packed;
+	__be16   reserved;
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
+};
 
 struct batadv_bcast_packet {
 	struct batadv_header header;
@@ -241,13 +250,14 @@ struct batadv_tt_query_packet {
 	 *		   orig_node
 	 */
 	uint8_t  ttvn;
+	uint8_t reserved;
 	/* tt_data field is:
 	 * if TT_REQUEST: crc associated with the
 	 *		  ttvn
 	 * if TT_RESPONSE: table_size
 	 */
 	__be16 tt_data;
-} __packed;
+};
 
 struct batadv_roam_adv_packet {
 	struct batadv_header header;
@@ -255,11 +265,13 @@ struct batadv_roam_adv_packet {
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  src[ETH_ALEN];
 	uint8_t  client[ETH_ALEN];
-} __packed;
+	__be16   reserved2;
+};
 
 struct batadv_tt_change {
 	uint8_t flags;
+	uint8_t reserved;
 	uint8_t addr[ETH_ALEN];
-} __packed;
+};
 
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/translation-table.c b/translation-table.c
index bb3941c..668766c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1601,6 +1601,7 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
 	tt_response = (struct batadv_tt_query_packet *)skb_put(skb, len);
 	tt_response->ttvn = ttvn;
+	tt_response->reserved = 0;
 
 	tt_change = (struct batadv_tt_change *)(skb->data + tt_query_size);
 	tt_count = 0;
@@ -1620,6 +1621,7 @@ batadv_tt_response_fill_table(uint16_t tt_len, uint8_t ttvn,
 			memcpy(tt_change->addr, tt_common_entry->addr,
 			       ETH_ALEN);
 			tt_change->flags = BATADV_NO_FLAGS;
+			tt_change->reserved = 0;
 
 			tt_count++;
 			tt_change++;
@@ -1676,6 +1678,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	tt_request->ttvn = ttvn;
 	tt_request->tt_data = htons(tt_crc);
 	tt_request->flags = BATADV_TT_REQUEST;
+	tt_request->reserved = 0;
 
 	if (full_table)
 		tt_request->flags |= BATADV_TT_FULL_TABLE;
@@ -1799,6 +1802,7 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	memcpy(tt_response->src, req_dst_orig_node->orig, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
 	tt_response->flags = BATADV_TT_RESPONSE;
+	tt_response->reserved = 0;
 
 	if (full_table)
 		tt_response->flags |= BATADV_TT_FULL_TABLE;
@@ -1916,6 +1920,7 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	memcpy(tt_response->src, primary_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(tt_response->dst, tt_request->src, ETH_ALEN);
 	tt_response->flags = BATADV_TT_RESPONSE;
+	tt_response->reserved = 0;
 
 	if (full_table)
 		tt_response->flags |= BATADV_TT_FULL_TABLE;
@@ -2223,6 +2228,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	roam_adv_packet->header.version = BATADV_COMPAT_VERSION;
 	roam_adv_packet->header.ttl = BATADV_TTL;
 	roam_adv_packet->reserved = 0;
+	roam_adv_packet->reserved2 = 0;
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
diff --git a/types.h b/types.h
index ae9ac9a..4bfb91a 100644
--- a/types.h
+++ b/types.h
@@ -449,13 +449,14 @@ struct batadv_vis_info {
 	/* this packet might be part of the vis send queue. */
 	struct sk_buff *skb_packet;
 	/* vis_info may follow here */
-} __packed;
+};
 
 struct batadv_vis_info_entry {
 	uint8_t  src[ETH_ALEN];
 	uint8_t  dest[ETH_ALEN];
 	uint8_t  quality;	/* quality = 0 client */
-} __packed;
+	uint8_t reserved;
+};
 
 struct batadv_recvlist_node {
 	struct list_head list;
diff --git a/unicast.c b/unicast.c
index 9416136..fbbc4c8 100644
--- a/unicast.c
+++ b/unicast.c
@@ -276,6 +276,9 @@ int batadv_frag_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv,
 	frag1->seqno = htons(seqno - 1);
 	frag2->seqno = htons(seqno);
 
+	frag1->reserved = 0;
+	frag2->reserved = 0;
+
 	batadv_send_skb_packet(skb, hard_iface, dstaddr);
 	batadv_send_skb_packet(frag_skb, hard_iface, dstaddr);
 	ret = NET_RX_SUCCESS;
@@ -374,6 +377,7 @@ bool batadv_unicast_4addr_prepare_skb(struct batadv_priv *bat_priv,
 	memcpy(unicast_4addr_packet->src, primary_if->net_dev->dev_addr,
 	       ETH_ALEN);
 	unicast_4addr_packet->subtype = packet_subtype;
+	unicast_4addr_packet->reserved = 0;
 
 	ret = true;
 out:
diff --git a/vis.c b/vis.c
index b004560..e08a204 100644
--- a/vis.c
+++ b/vis.c
@@ -626,6 +626,7 @@ static int batadv_generate_vis_packet(struct batadv_priv *bat_priv)
 			       ETH_ALEN);
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
 			entry->quality = router->tq_avg;
+			entry->reserved = 0;
 			packet->entries++;
 
 next:
@@ -650,6 +651,7 @@ next:
 			memset(entry->src, 0, ETH_ALEN);
 			memcpy(entry->dest, tt_common_entry->addr, ETH_ALEN);
 			entry->quality = 0; /* 0 means TT */
+			entry->reserved = 0;
 			packet->entries++;
 
 			if (batadv_vis_packet_full(info))
-- 
1.7.10.4

