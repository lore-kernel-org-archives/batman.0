Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Sat, 20 Apr 2013 18:17:34 +0200
Message-Id: <1366474654-26361-4-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366474654-26361-1-git-send-email-martin@hundeboll.net>
References: <1366474654-26361-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Fragment and send skbs
	larger than mtu
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Non-broadcast packets larger than MTU are fragmented and sent with
an encapsulating header. Up to 16 fragments are supported, which are
sent in reverse order on the wire.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 fragmentation.c  | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fragmentation.h  |   3 ++
 send.c           |  21 ++++++++--
 soft-interface.c |   7 ++++
 types.h          |   3 ++
 5 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/fragmentation.c b/fragmentation.c
index 1c1ed2d..a7c3218 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -370,3 +370,124 @@ out:
 		batadv_neigh_node_free_ref(neigh_node);
 	return ret;
 }
+
+/**
+ * batadv_frag_create() - Create a fragment from skb.
+ * @skb: skb to create fragment from.
+ * @frag_head: header to use in new fragment.
+ * @mtu: Size of new fragment.
+ *
+ * Split the passed skb into two fragments: A new one with size matching the
+ * passed mtu and the old one with the rest. The new skb contains data from the
+ * tail of the old skb.
+ *
+ * Returns the new fragment, NULL on error.
+ */
+static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
+					  struct batadv_frag_packet *frag_head,
+					  unsigned int mtu)
+{
+	struct sk_buff *skb_fragment;
+	unsigned header_size = sizeof(*frag_head);
+	unsigned fragment_size = mtu - header_size - ETH_HLEN;
+
+	skb_fragment = dev_alloc_skb(mtu);
+	if (!skb_fragment)
+		goto out_err;
+
+	/* Eat the last mtu-bytes of the skb */
+	skb_reserve(skb_fragment, header_size);
+	skb_split(skb, skb_fragment, skb->len - fragment_size);
+
+	/* Add the header */
+	skb_push(skb_fragment, header_size);
+	memcpy(skb_fragment->data, frag_head, header_size);
+
+	return skb_fragment;
+
+out_err:
+	return NULL;
+}
+
+/**
+ * batadv_frag_send_packet() - Create up to 16 fragments from the passed skb.
+ * @skb: skb to create fragments from.
+ * @orig_node: Final destination of the created fragments.
+ * @neigh_node: Next-hop of the created fragments.
+ *
+ * Returns true on success, false otherwise.
+ */
+bool batadv_frag_send_packet(struct sk_buff *skb,
+			     struct batadv_orig_node *orig_node,
+			     struct batadv_neigh_node *neigh_node)
+{
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if;
+	struct batadv_frag_packet frag_header;
+	struct sk_buff *skb_fragment;
+	unsigned mtu = neigh_node->if_incoming->net_dev->mtu;
+	unsigned header_size = sizeof(frag_header);
+	unsigned max_fragment_size, max_packet_size;
+
+	/* To avoid merge and refragmentation at next-hops we never send
+	 * fragments larger than BATADV_FRAG_MAX_FRAG_SIZE
+	 */
+	mtu = min_t(int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
+	max_fragment_size = (mtu - header_size - ETH_HLEN);
+	max_packet_size = max_fragment_size*BATADV_FRAG_MAX_FRAGMENTS;
+
+	/* Don't even try to fragment, if we need more than 16 fragments */
+	if (skb->len > max_packet_size)
+		goto out_err;
+
+	bat_priv = orig_node->bat_priv;
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out_err;
+
+	/* Create one header to be copied to all fragments */
+	frag_header.header.packet_type = BATADV_UNICAST_FRAG;
+	frag_header.header.version = BATADV_COMPAT_VERSION;
+	frag_header.header.ttl = BATADV_TTL;
+	frag_header.seqno = htons(atomic_inc_return(&bat_priv->frag_seqno));
+	frag_header.reserved = 0;
+	frag_header.no = 0;
+	frag_header.total_size = htons(skb->len);
+	memcpy(frag_header.orig, primary_if->net_dev->dev_addr, ETH_ALEN);
+	memcpy(frag_header.dest, orig_node->orig, ETH_ALEN);
+
+	/* Eat and send fragments from the tail of skb */
+	while (skb->len > max_fragment_size) {
+		skb_fragment = batadv_frag_create(skb, &frag_header, mtu);
+		if (!skb_fragment)
+			goto out_err;
+
+		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_TX);
+		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_TX_BYTES,
+				   skb_fragment->len + ETH_HLEN);
+		batadv_send_skb_packet(skb_fragment, neigh_node->if_incoming,
+				       neigh_node->addr);
+		frag_header.no++;
+
+		/* The initial check in this function should cover this case */
+		if (frag_header.no == BATADV_FRAG_MAX_FRAGMENTS - 1)
+			goto out_err;
+	}
+
+	/* Make room for the fragment header. */
+	if (batadv_skb_head_push(skb, header_size) < 0 ||
+	    pskb_expand_head(skb, header_size + ETH_HLEN, 0, GFP_ATOMIC) < 0)
+		goto out_err;
+
+	memcpy(skb->data, &frag_header, header_size);
+
+	/* Send the last fragment */
+	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_TX);
+	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_TX_BYTES,
+			   skb->len + ETH_HLEN);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+
+	return true;
+out_err:
+	return false;
+}
diff --git a/fragmentation.h b/fragmentation.h
index 16d1a62..ed85d97 100644
--- a/fragmentation.h
+++ b/fragmentation.h
@@ -27,5 +27,8 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_orig_node *orig_node_src);
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
 			    struct batadv_orig_node *orig_node);
+bool batadv_frag_send_packet(struct sk_buff *skb,
+			     struct batadv_orig_node *orig_node,
+			     struct batadv_neigh_node *neigh_node);
 
 #endif /* _NET_BATMAN_ADV_FRAGMENTATION_H_ */
diff --git a/send.c b/send.c
index 21ba70d..6fc812a 100644
--- a/send.c
+++ b/send.c
@@ -28,8 +28,7 @@
 #include "gateway_client.h"
 #include "originator.h"
 #include "network-coding.h"
-
-#include <linux/if_ether.h>
+#include "fragmentation.h"
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
 
@@ -110,7 +109,19 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 	/* batadv_find_router() increases neigh_nodes refcount if found. */
 	neigh_node = batadv_find_router(bat_priv, orig_node, recv_if);
 	if (!neigh_node)
-		return ret;
+		goto out;
+
+	/* Check if the skb is too large to send in one piece and fragment
+	 * it if needed.
+	 */
+	if (atomic_read(&bat_priv->fragmentation) &&
+	    skb->len + ETH_HLEN > neigh_node->if_incoming->net_dev->mtu) {
+		/* Fragment and send packet. */
+		if (batadv_frag_send_packet(skb, orig_node, neigh_node))
+			ret = NET_XMIT_SUCCESS;
+
+		goto out;
+	}
 
 	/* try to network code the packet, if it is received on an interface
 	 * (i.e. being forwarded). If the packet originates from this node or if
@@ -124,7 +135,9 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 		ret = NET_XMIT_SUCCESS;
 	}
 
-	batadv_neigh_node_free_ref(neigh_node);
+out:
+	if (neigh_node)
+		batadv_neigh_node_free_ref(neigh_node);
 
 	return ret;
 }
diff --git a/soft-interface.c b/soft-interface.c
index bcbb6fc..5d08c6c 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -431,6 +431,7 @@ static void batadv_softif_destroy_finish(struct work_struct *work)
 static int batadv_softif_init_late(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv;
+	uint32_t random_seqno;
 	int ret;
 	size_t cnt_len = sizeof(uint64_t) * BATADV_CNT_NUM;
 
@@ -479,6 +480,10 @@ static int batadv_softif_init_late(struct net_device *dev)
 	bat_priv->tt.last_changeset = NULL;
 	bat_priv->tt.last_changeset_len = 0;
 
+	/* randomize initial seqno to avoid collision */
+	get_random_bytes(&random_seqno, sizeof(random_seqno));
+	atomic_set(&bat_priv->frag_seqno, random_seqno);
+
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
@@ -746,6 +751,8 @@ static const struct {
 	{ "mgmt_tx_bytes" },
 	{ "mgmt_rx" },
 	{ "mgmt_rx_bytes" },
+	{ "frag_tx" },
+	{ "frag_tx_bytes" },
 	{ "frag_rx" },
 	{ "frag_rx_bytes" },
 	{ "frag_fwd" },
diff --git a/types.h b/types.h
index ee6e5d5..b9bc2b6 100644
--- a/types.h
+++ b/types.h
@@ -336,6 +336,8 @@ enum batadv_counters {
 	BATADV_CNT_MGMT_TX_BYTES,
 	BATADV_CNT_MGMT_RX,
 	BATADV_CNT_MGMT_RX_BYTES,
+	BATADV_CNT_FRAG_TX,
+	BATADV_CNT_FRAG_TX_BYTES,
 	BATADV_CNT_FRAG_RX,
 	BATADV_CNT_FRAG_RX_BYTES,
 	BATADV_CNT_FRAG_FWD,
@@ -577,6 +579,7 @@ struct batadv_priv {
 	atomic_t aggregated_ogms;
 	atomic_t bonding;
 	atomic_t fragmentation;
+	atomic_t frag_seqno;
 	atomic_t ap_isolation;
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_t bridge_loop_avoidance;
-- 
1.8.2.1

