Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 19 Dec 2016 12:25:30 +0100
Message-Id: <20161219112535.9446-2-linus.luessing@c0d3.blue>
In-Reply-To: <20161219112535.9446-1-linus.luessing@c0d3.blue>
References: <20161219112535.9446-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH 1/6] batman-adv: Allow TVLVs greater than
	128 bytes
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

The upcoming aggregation TVLVs will need to be able to hold larger
broadcast packets too.

For one thing this patch increases the according stack buffer to
256 bytes to be able to handle the most common broadcast packet cases
quickly.

For larger TVLVs, this patch will try to linearize skb data up to
and including the TVLV within the received packet.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/bat_iv_ogm.c |  4 ++--
 net/batman-adv/bat_v_ogm.c  |  4 ++--
 net/batman-adv/tvlv.c       | 20 +++++++++++---------
 net/batman-adv/tvlv.h       |  4 ++--
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 07bf38e..a1472ab 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1409,7 +1409,7 @@ out:
  * @if_outgoing: the interface for which the packet should be considered
  */
 static void
-batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
+batadv_iv_ogm_process_per_outif(struct sk_buff *skb, int ogm_offset,
 				struct batadv_orig_node *orig_node,
 				struct batadv_hard_iface *if_incoming,
 				struct batadv_hard_iface *if_outgoing)
@@ -1613,7 +1613,7 @@ out:
  * @ogm_offset: offset to the OGM which should be processed (for aggregates)
  * @if_incoming: the interface where this packet was receved
  */
-static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
+static void batadv_iv_ogm_process(struct sk_buff *skb, int ogm_offset,
 				  struct batadv_hard_iface *if_incoming)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 002f52a..b6a275d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -606,7 +606,7 @@ out:
  */
 static void
 batadv_v_ogm_process_per_outif(struct batadv_priv *bat_priv,
-			       const struct sk_buff *skb,
+			       struct sk_buff *skb,
 			       const struct batadv_ogm2_packet *ogm2,
 			       struct batadv_orig_node *orig_node,
 			       struct batadv_neigh_node *neigh_node,
@@ -676,7 +676,7 @@ static bool batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
  * @ogm_offset: offset to the OGM which should be processed (for aggregates)
  * @if_incoming: the interface where this packet was receved
  */
-static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
+static void batadv_v_ogm_process(struct sk_buff *skb, int ogm_offset,
 				 struct batadv_hard_iface *if_incoming)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index d432e16..c824d74 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -498,12 +498,12 @@ static void batadv_tvlv_call_unfound_handlers(struct batadv_priv *bat_priv,
  * any TVLV handler called successfully. Returns NET_RX_DROP otherwise.
  */
 int batadv_tvlv_containers_process2(struct batadv_priv *bat_priv,
-				    const struct sk_buff *skb, u8 packet_type,
+				    struct sk_buff *skb, u8 packet_type,
 				    unsigned int tvlv_offset,
 				    u16 tvlv_value_len, void *ctx)
 {
 	struct batadv_tvlv_hdr *tvlv_hdr, tvlv_hdr_buff;
-	u8 *tvlv_value, tvlv_value_buff[128];
+	u8 *tvlv_value, tvlv_value_buff[256];
 	u16 tvlv_value_cont_len;
 	int ret = NET_RX_SUCCESS;
 
@@ -518,14 +518,16 @@ int batadv_tvlv_containers_process2(struct batadv_priv *bat_priv,
 		tvlv_offset += sizeof(*tvlv_hdr);
 		tvlv_value_len -= sizeof(*tvlv_hdr);
 
-		if (tvlv_value_cont_len > sizeof(tvlv_value_buff)) {
-			pr_warn_once("batman-adv: TVLVs greater than 128 bytes unsupported for now, ignoring\n");
-			goto skip_handler_call;
-		}
-
 		if (tvlv_value_cont_len > tvlv_value_len)
 			return NET_RX_DROP;
 
+		/* check for sufficient space either in stack buffer or
+		 * in skb's linear data buffer
+		 */
+		if (tvlv_value_cont_len > sizeof(tvlv_value_buff) &&
+		    !pskb_may_pull(skb, tvlv_offset + tvlv_value_cont_len))
+			return NET_RX_DROP;
+
 		tvlv_value = skb_header_pointer(skb, tvlv_offset,
 						tvlv_value_cont_len,
 						tvlv_value_buff);
@@ -536,7 +538,7 @@ int batadv_tvlv_containers_process2(struct batadv_priv *bat_priv,
 						 tvlv_hdr->type,
 						 tvlv_hdr->version, tvlv_value,
 						 tvlv_value_cont_len, ctx);
-skip_handler_call:
+
 		tvlv_offset += tvlv_value_cont_len;
 		tvlv_value_len -= tvlv_value_cont_len;
 	}
@@ -656,7 +658,7 @@ struct batadv_orig_node *batadv_tvlv_ogm_unpack_ctx(void *ctx)
  * OGM header.
  */
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
-			     const struct sk_buff *skb,
+			     struct sk_buff *skb,
 			     struct batadv_orig_node *orig_node)
 {
 	void *ctx = batadv_tvlv_ogm_pack_ctx(orig_node);
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 0d2d586..d8cdf6b 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -33,7 +33,7 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 void *batadv_tvlv_ogm_pack_ctx(struct batadv_orig_node *orig_node);
 struct batadv_orig_node *batadv_tvlv_ogm_unpack_ctx(void *ctx);
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
-			     const struct sk_buff *skb,
+			     struct sk_buff *skb,
 			     struct batadv_orig_node *orig_node);
 void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
 				      u8 type, u8 version);
@@ -67,7 +67,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   u8 *src, u8 *dst,
 				   void *tvlv_buff, u16 tvlv_buff_len);
 int batadv_tvlv_containers_process2(struct batadv_priv *bat_priv,
-				    const struct sk_buff *skb, u8 packet_type,
+				    struct sk_buff *skb, u8 packet_type,
 				    unsigned int tvlv_offset,
 				    u16 tvlv_value_len, void *ctx);
 void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
-- 
2.1.4

