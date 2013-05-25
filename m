Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 26 May 2013 06:15:20 +0800
Message-Id: <1369520121-5998-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: properly align tvlv
	infrastructure
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

4bytes long members must start at an address multiple of 4
in order to avoid unaligned memory access.

Therefore, the tvlv short type is eliminated in favor of
tvlv long and that distinction removed from the code.

Introduced by 0b6aa0d43767889eeda43a132cf5e73df4e63bf2
"batman-adv: tvlv - basic infrastructure"

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 main.c   |   91 +++++++++++++++++---------------------------------------------
 packet.h |   44 +++++++-----------------------
 types.h  |    1 -
 3 files changed, 33 insertions(+), 103 deletions(-)

diff --git a/main.c b/main.c
index 7188beb..0194172 100644
--- a/main.c
+++ b/main.c
@@ -604,12 +604,8 @@ static uint16_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
 	uint16_t tvlv_len = 0;
 
 	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
-		if (tvlv->tvlv_hdr.long_tvlv)
-			tvlv_len += sizeof(struct batadv_tvlv_long);
-		else
-			tvlv_len += sizeof(struct batadv_tvlv_short);
-
-		tvlv_len += tvlv->value_len;
+		tvlv_len += sizeof(struct batadv_tvlv_hdr);
+		tvlv_len += tvlv->tvlv_hdr.len;
 	}
 
 	return tvlv_len;
@@ -678,13 +674,11 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 	if (!tvlv_new)
 		return;
 
-	tvlv_new->value_len = tvlv_value_len;
 	tvlv_new->tvlv_hdr.version = version;
 	tvlv_new->tvlv_hdr.type = type;
-	if (tvlv_new->value_len > 255)
-		tvlv_new->tvlv_hdr.long_tvlv = 1;
+	tvlv_new->tvlv_hdr.len = tvlv_value_len;
 
-	memcpy(tvlv_new + 1, tvlv_value, tvlv_new->value_len);
+	memcpy(tvlv_new + 1, tvlv_value, tvlv_new->tvlv_hdr.len);
 	INIT_HLIST_NODE(&tvlv_new->list);
 	atomic_set(&tvlv_new->refcount, 1);
 
@@ -748,8 +742,7 @@ uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 					  int packet_min_len)
 {
 	struct batadv_tvlv_container *tvlv;
-	struct batadv_tvlv_short *tvlv_short;
-	struct batadv_tvlv_long *tvlv_long;
+	struct batadv_tvlv_hdr *tvlv_hdr;
 	uint16_t tvlv_value_len;
 	void *tvlv_value;
 	bool ret;
@@ -769,20 +762,13 @@ uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 	tvlv_value = (*packet_buff) + packet_min_len;
 
 	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
-		if (tvlv->tvlv_hdr.long_tvlv) {
-			tvlv_long = tvlv_value;
-			tvlv_long->tvlv_hdr = tvlv->tvlv_hdr;
-			tvlv_long->len = htons(tvlv->value_len);
-			tvlv_value = tvlv_long + 1;
-		} else {
-			tvlv_short = tvlv_value;
-			tvlv_short->tvlv_hdr = tvlv->tvlv_hdr;
-			tvlv_short->len = tvlv->value_len;
-			tvlv_value = tvlv_short + 1;
-		}
-
-		memcpy(tvlv_value, tvlv + 1, tvlv->value_len);
-		tvlv_value = (uint8_t *)tvlv_value + tvlv->value_len;
+		tvlv_hdr = tvlv_value;
+		tvlv_hdr->type = tvlv->tvlv_hdr.type;
+		tvlv_hdr->version = tvlv->tvlv_hdr.version;
+		tvlv_hdr->len = htons(tvlv->tvlv_hdr.len);
+		tvlv_value = tvlv_hdr + 1;
+		memcpy(tvlv_value, tvlv + 1, tvlv->tvlv_hdr.len);
+		tvlv_value = (uint8_t *)tvlv_value + tvlv->tvlv_hdr.len;
 	}
 
 end:
@@ -865,30 +851,16 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   void *tvlv_value, uint16_t tvlv_value_len)
 {
 	struct batadv_tvlv_handler *tvlv_handler;
-	struct batadv_tvlv_short *tvlv_short;
-	struct batadv_tvlv_long *tvlv_long;
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	uint16_t tvlv_value_cont_len;
 	uint8_t cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	int ret = NET_RX_SUCCESS;
 
-	while (tvlv_value_len >= sizeof(*tvlv_short)) {
+	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
 		tvlv_hdr = tvlv_value;
-
-		if (tvlv_hdr->long_tvlv) {
-			if (sizeof(*tvlv_long) > tvlv_value_len)
-				break;
-
-			tvlv_long = tvlv_value;
-			tvlv_value_cont_len = ntohs(tvlv_long->len);
-			tvlv_value = tvlv_long + 1;
-			tvlv_value_len -= sizeof(*tvlv_long);
-		} else {
-			tvlv_short = tvlv_value;
-			tvlv_value_cont_len = tvlv_short->len;
-			tvlv_value = tvlv_short + 1;
-			tvlv_value_len -= sizeof(*tvlv_short);
-		}
+		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
+		tvlv_value = tvlv_hdr + 1;
+		tvlv_value_len -= sizeof(*tvlv_hdr);
 
 		if (tvlv_value_cont_len > tvlv_value_len)
 			break;
@@ -1042,8 +1014,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 			      void *tvlv_value, uint16_t tvlv_value_len)
 {
 	struct batadv_unicast_tvlv_packet *unicast_tvlv_packet;
-	struct batadv_tvlv_short *tvlv_short;
-	struct batadv_tvlv_long *tvlv_long;
+	struct batadv_tvlv_hdr *tvlv_hdr;
 	struct batadv_orig_node *orig_node;
 	struct sk_buff *skb = NULL;
 	unsigned char *tvlv_buff;
@@ -1058,11 +1029,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 	if (tvlv_value_len > 255)
 		tvlv_long_hdr = 1;
 
-	tvlv_len = tvlv_value_len;
-	if (tvlv_long_hdr)
-		tvlv_len += sizeof(*tvlv_long);
-	else
-		tvlv_len += sizeof(*tvlv_short);
+	tvlv_len = sizeof(*tvlv_hdr) + tvlv_value_len;
 
 	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + hdr_len + tvlv_len);
 	if (!skb)
@@ -1076,26 +1043,16 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 	unicast_tvlv_packet->header.ttl = BATADV_TTL;
 	unicast_tvlv_packet->reserved = 0;
 	unicast_tvlv_packet->tvlv_len = htons(tvlv_len);
+	unicast_tvlv_packet->align = 0;
 	memcpy(unicast_tvlv_packet->src, src, ETH_ALEN);
 	memcpy(unicast_tvlv_packet->dst, dst, ETH_ALEN);
 
 	tvlv_buff = (unsigned char *)(unicast_tvlv_packet + 1);
-
-	if (tvlv_long_hdr) {
-		tvlv_long = (struct batadv_tvlv_long *)tvlv_buff;
-		tvlv_long->tvlv_hdr.version = version;
-		tvlv_long->tvlv_hdr.type = type;
-		tvlv_long->tvlv_hdr.long_tvlv = 1;
-		tvlv_long->len = htons(tvlv_value_len);
-		tvlv_buff += sizeof(*tvlv_long);
-	} else {
-		tvlv_short = (struct batadv_tvlv_short *)tvlv_buff;
-		tvlv_short->tvlv_hdr.version = version;
-		tvlv_short->tvlv_hdr.type = type;
-		tvlv_short->len = tvlv_value_len;
-		tvlv_buff += sizeof(*tvlv_short);
-	}
-
+	tvlv_hdr = (struct batadv_tvlv_hdr *)tvlv_buff;
+	tvlv_hdr->version = version;
+	tvlv_hdr->type = type;
+	tvlv_hdr->len = htons(tvlv_value_len);
+	tvlv_buff += sizeof(*tvlv_hdr);
 	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
 
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
diff --git a/packet.h b/packet.h
index 2a73ebd..840d73d 100644
--- a/packet.h
+++ b/packet.h
@@ -327,53 +327,27 @@ struct batadv_coded_packet {
  * @src: address of the source
  * @dst: address of the destination
  * @tvlv_len: length of tvlv data following the unicast tvlv header
+ * @align: 2 bytes to align the header to a 4 byte boundry
  */
 struct batadv_unicast_tvlv_packet {
 	struct batadv_header header;
-	uint8_t reserved;
-	uint8_t dst[ETH_ALEN];
-	uint8_t src[ETH_ALEN];
-	__be16  tvlv_len;
+	uint8_t  reserved;
+	uint8_t  dst[ETH_ALEN];
+	uint8_t  src[ETH_ALEN];
+	__be16   tvlv_len;
+	uint16_t align;
 };
 
 /**
  * struct batadv_tvlv_hdr - base tvlv header struct
- * @long_tvlv: flag indicating whether this is a short tvlv container (max 256
- *  bytes) or a long tvlv one (up to ETH_DATA_LEN)
  * @type: tvlv container type (see batadv_tvlv_type)
  * @version: tvlv container version
+ * @len: tvlv container length
  */
 struct batadv_tvlv_hdr {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	uint8_t long_tvlv:1;
-	uint8_t type:7;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	uint8_t type:7;
-	uint8_t long_tvlv:1;
-#else
-#error "unknown bitfield endianess"
-#endif
+	uint8_t type;
 	uint8_t version;
-};
-
-/**
- * struct batadv_tvlv_short - short tvlv header struct
- * @tvlv_hdr: base tvlv header
- * @len: tvlv container length (limited to 255 bytes)
- */
-struct batadv_tvlv_short {
-	struct batadv_tvlv_hdr tvlv_hdr;
-	uint8_t len;
-};
-
-/**
- * struct batadv_tvlv_long - long tvlv header struct
- * @tvlv_hdr: base tvlv header
- * @len: tvlv container length
- */
-struct batadv_tvlv_long {
-	struct batadv_tvlv_hdr tvlv_hdr;
-	__be16 len;
+	__be16  len;
 };
 
 /**
diff --git a/types.h b/types.h
index c388e47..f99b508 100644
--- a/types.h
+++ b/types.h
@@ -976,7 +976,6 @@ struct batadv_dat_candidate {
 struct batadv_tvlv_container {
 	struct hlist_node list;
 	struct batadv_tvlv_hdr tvlv_hdr;
-	uint16_t value_len;
 	atomic_t refcount;
 };
 
-- 
1.7.10.4

