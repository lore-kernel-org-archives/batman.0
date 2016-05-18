Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Wed, 18 May 2016 11:38:48 +0200
Message-Id: <1463564330-11178-1-git-send-email-sven.eckelmann@open-mesh.com>
In-Reply-To: <4816418.hDXNbSuFUQ@bentobox>
References: <4816418.hDXNbSuFUQ@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v11 1/2] batman-adv: return netdev status in
	the TX path
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

From: Antonio Quartulli <antonio.quartulli@open-mesh.com>

Return the proper netdev TX status along the TX path so that the tp_meter
can understand when the queue is full and should stop sending packets.

Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v11:
 * no changes
v10:
 * no changes
v9:
 * rebase on top of current master+"batman-adv: Include main.h in all files"+
   "batman-adv: Keep includes ordered by filename"
v8:
 * rebase on top of current master
---
 net/batman-adv/fragmentation.c | 41 +++++++++++++++++++++++++----------------
 net/batman-adv/fragmentation.h |  6 +++---
 net/batman-adv/main.c          |  4 +++-
 net/batman-adv/routing.c       | 23 ++++++++++++++---------
 net/batman-adv/send.c          | 25 +++++++++++++------------
 5 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 9f41a0a..0934730 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -433,11 +433,12 @@ err:
  * @orig_node: final destination of the created fragments
  * @neigh_node: next-hop of the created fragments
  *
- * Return: true on success, false otherwise.
+ * Return: the netdev tx status or -1 in case of error.
+ * When -1 is returned the skb is not consumed.
  */
-bool batadv_frag_send_packet(struct sk_buff *skb,
-			     struct batadv_orig_node *orig_node,
-			     struct batadv_neigh_node *neigh_node)
+int batadv_frag_send_packet(struct sk_buff *skb,
+			    struct batadv_orig_node *orig_node,
+			    struct batadv_neigh_node *neigh_node)
 {
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -446,7 +447,7 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 	unsigned int mtu = neigh_node->if_incoming->net_dev->mtu;
 	unsigned int header_size = sizeof(frag_header);
 	unsigned int max_fragment_size, max_packet_size;
-	bool ret = false;
+	int ret = -1;
 
 	/* To avoid merge and refragmentation at next-hops we never send
 	 * fragments larger than BATADV_FRAG_MAX_FRAG_SIZE
@@ -457,12 +458,12 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 
 	/* Don't even try to fragment, if we need more than 16 fragments */
 	if (skb->len > max_packet_size)
-		goto out_err;
+		goto out;
 
 	bat_priv = orig_node->bat_priv;
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
-		goto out_err;
+		goto out;
 
 	/* Create one header to be copied to all fragments */
 	frag_header.packet_type = BATADV_UNICAST_FRAG;
@@ -488,23 +489,33 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 	while (skb->len > max_fragment_size) {
 		skb_fragment = batadv_frag_create(skb, &frag_header, mtu);
 		if (!skb_fragment)
-			goto out_err;
+			goto out;
 
 		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_TX);
 		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_TX_BYTES,
 				   skb_fragment->len + ETH_HLEN);
-		batadv_send_unicast_skb(skb_fragment, neigh_node);
+		ret = batadv_send_unicast_skb(skb_fragment, neigh_node);
+		if (ret != NET_XMIT_SUCCESS) {
+			/* return -1 so that the caller can free the original
+			 * skb
+			 */
+			ret = -1;
+			goto out;
+		}
+
 		frag_header.no++;
 
 		/* The initial check in this function should cover this case */
-		if (frag_header.no == BATADV_FRAG_MAX_FRAGMENTS - 1)
-			goto out_err;
+		if (frag_header.no == BATADV_FRAG_MAX_FRAGMENTS - 1) {
+			ret = -1;
+			goto out;
+		}
 	}
 
 	/* Make room for the fragment header. */
 	if (batadv_skb_head_push(skb, header_size) < 0 ||
 	    pskb_expand_head(skb, header_size + ETH_HLEN, 0, GFP_ATOMIC) < 0)
-		goto out_err;
+		goto out;
 
 	memcpy(skb->data, &frag_header, header_size);
 
@@ -512,11 +523,9 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_TX_BYTES,
 			   skb->len + ETH_HLEN);
-	batadv_send_unicast_skb(skb, neigh_node);
+	ret = batadv_send_unicast_skb(skb, neigh_node);
 
-	ret = true;
-
-out_err:
+out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 9ff77c7..3202fe3 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -34,9 +34,9 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_orig_node *orig_node_src);
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
 			    struct batadv_orig_node *orig_node);
-bool batadv_frag_send_packet(struct sk_buff *skb,
-			     struct batadv_orig_node *orig_node,
-			     struct batadv_neigh_node *neigh_node);
+int batadv_frag_send_packet(struct sk_buff *skb,
+			    struct batadv_orig_node *orig_node,
+			    struct batadv_neigh_node *neigh_node);
 
 /**
  * batadv_frag_check_entry - check if a list of fragments has timed out
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e78b318..d12506b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1194,6 +1194,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 	unsigned char *tvlv_buff;
 	unsigned int tvlv_len;
 	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
+	int res;
 
 	orig_node = batadv_orig_hash_find(bat_priv, dst);
 	if (!orig_node)
@@ -1226,7 +1227,8 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 	tvlv_buff += sizeof(*tvlv_hdr);
 	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
 
-	if (batadv_send_skb_to_orig(skb, orig_node, NULL) == NET_XMIT_DROP)
+	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (!(res != -1 && dev_xmit_complete(res)))
 		kfree_skb(skb);
 out:
 	batadv_orig_node_put(orig_node);
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 93ee5c7..f27fb1d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -268,7 +268,10 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 		icmph->ttl = BATADV_TTL;
 
 		res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-		if (res != NET_XMIT_DROP)
+		if (res == -1)
+			goto out;
+
+		if (dev_xmit_complete(res))
 			ret = NET_RX_SUCCESS;
 
 		break;
@@ -290,7 +293,7 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_icmp_packet *icmp_packet;
-	int ret = NET_RX_DROP;
+	int res, ret = NET_RX_DROP;
 
 	icmp_packet = (struct batadv_icmp_packet *)skb->data;
 
@@ -321,7 +324,8 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet->msg_type = BATADV_TTL_EXCEEDED;
 	icmp_packet->ttl = BATADV_TTL;
 
-	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
+	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (res != -1 && dev_xmit_complete(res))
 		ret = NET_RX_SUCCESS;
 
 out:
@@ -341,7 +345,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	struct ethhdr *ethhdr;
 	struct batadv_orig_node *orig_node = NULL;
 	int hdr_size = sizeof(struct batadv_icmp_header);
-	int ret = NET_RX_DROP;
+	int res, ret = NET_RX_DROP;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -407,7 +411,8 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	icmph->ttl--;
 
 	/* route it */
-	if (batadv_send_skb_to_orig(skb, orig_node, recv_if) != NET_XMIT_DROP)
+	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
+	if (res != -1 && dev_xmit_complete(res))
 		ret = NET_RX_SUCCESS;
 
 out:
@@ -644,6 +649,8 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 
 	len = skb->len;
 	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
+	if (res == -1)
+		goto out;
 
 	/* translate transmit result into receive result */
 	if (res == NET_XMIT_SUCCESS) {
@@ -651,12 +658,10 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 		batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
 		batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
 				   len + ETH_HLEN);
+	}
 
+	if (dev_xmit_complete(res))
 		ret = NET_RX_SUCCESS;
-	} else if (res == NET_XMIT_POLICED) {
-		/* skb was buffered and consumed */
-		ret = NET_RX_SUCCESS;
-	}
 
 out:
 	if (orig_node)
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 45ca6ac..09f44cb 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -155,8 +155,11 @@ int batadv_send_unicast_skb(struct sk_buff *skb,
  * host, NULL can be passed as recv_if and no interface alternating is
  * attempted.
  *
- * Return: NET_XMIT_SUCCESS on success, NET_XMIT_DROP on failure, or
- * NET_XMIT_POLICED if the skb is buffered for later transmit.
+ * Return: -1 on failure (and the skb is not consumed), NET_XMIT_POLICED if the
+ * skb is buffered for later transmit or the NET_XMIT status returned by the
+ * lower routine if the packet has been passed down.
+ *
+ * If the returning value is not -1 the skb has been consumed.
  */
 int batadv_send_skb_to_orig(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
@@ -164,7 +167,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = orig_node->bat_priv;
 	struct batadv_neigh_node *neigh_node;
-	int ret = NET_XMIT_DROP;
+	int ret = -1;
 
 	/* batadv_find_router() increases neigh_nodes refcount if found. */
 	neigh_node = batadv_find_router(bat_priv, orig_node, recv_if);
@@ -177,8 +180,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 	if (atomic_read(&bat_priv->fragmentation) &&
 	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
 		/* Fragment and send packet. */
-		if (batadv_frag_send_packet(skb, orig_node, neigh_node))
-			ret = NET_XMIT_SUCCESS;
+		ret = batadv_frag_send_packet(skb, orig_node, neigh_node);
 
 		goto out;
 	}
@@ -187,12 +189,10 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 	 * (i.e. being forwarded). If the packet originates from this node or if
 	 * network coding fails, then send the packet as usual.
 	 */
-	if (recv_if && batadv_nc_skb_forward(skb, neigh_node)) {
+	if (recv_if && batadv_nc_skb_forward(skb, neigh_node))
 		ret = NET_XMIT_POLICED;
-	} else {
-		batadv_send_unicast_skb(skb, neigh_node);
-		ret = NET_XMIT_SUCCESS;
-	}
+	else
+		ret = batadv_send_unicast_skb(skb, neigh_node);
 
 out:
 	if (neigh_node)
@@ -318,7 +318,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 {
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr;
-	int ret = NET_XMIT_DROP;
+	int res, ret = NET_XMIT_DROP;
 
 	if (!orig_node)
 		goto out;
@@ -355,7 +355,8 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest, vid))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
-	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
+	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (res != -1 && dev_xmit_complete(res))
 		ret = NET_XMIT_SUCCESS;
 
 out:
-- 
2.8.1

