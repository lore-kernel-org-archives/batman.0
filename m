Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 11 Jun 2014 20:43:11 +0200
Message-Id: <1402512191-14922-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: drop QinQ claim frames in bridge
	loop avoidance
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Since bridge loop avoidance only supports untagged or simple 802.1q
tagged VLAN claim frames, claim frames with stacked VLAN headers (QinQ)
should be detected and dropped. Transporting the over the mesh may cause
problems on the receivers, or create bogus entries in the local tt
tables.

Reported-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bridge_loop_avoidance.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 6f0d9ec..75274f7 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -851,6 +851,75 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 	return 2;
 }
 
+/**
+ * batadv_is_encapsulated_claim
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: skb to be checked
+ *
+ * Check if this frame is a claim frame encapsulated in at least
+ * two layers of VLANs.
+ *
+ * returns 1 if this is an encapsulated claim frame, 0 otherwise.
+ */
+static int batadv_is_encapsulated_claim(struct batadv_priv *bat_priv,
+					struct sk_buff *skb)
+{
+	struct batadv_bla_claim_dst *bla_dst, *bla_dst_own;
+	struct vlan_hdr vhdr, *vhdr_ptr;
+	uint8_t *hw_src, *hw_dst;
+	struct ethhdr *ethhdr;
+	struct arphdr *arphdr;
+	int headlen;
+
+	/* Traverse the VLAN/Ethertypes until an ARP header is found.
+	 *
+	 * At this point it is known that the first two protocols
+	 * are VLAN headers, so start checking at the encapsulated protocol
+	 * of the second header.
+	 */
+	headlen = VLAN_ETH_HLEN;
+	do {
+		vhdr_ptr = skb_header_pointer(skb, headlen, VLAN_HLEN, &vhdr);
+		if (!vhdr_ptr)
+			return 0;
+
+		headlen += VLAN_HLEN;
+	} while (vhdr_ptr->h_vlan_encapsulated_proto == htons(ETH_P_8021Q));
+
+	if (vhdr_ptr->h_vlan_encapsulated_proto != htons(ETH_P_ARP))
+		return 0;
+
+	if (unlikely(!pskb_may_pull(skb, headlen + arp_hdr_len(skb->dev))))
+		return 0;
+
+	/* pskb_may_pull() may have modified the pointers, get ethhdr again */
+	ethhdr = eth_hdr(skb);
+	arphdr = (struct arphdr *)((uint8_t *)ethhdr + headlen);
+
+	/* Check whether the ARP frame carries a valid IP information */
+	if (arphdr->ar_hrd != htons(ARPHRD_ETHER))
+		return 0;
+	if (arphdr->ar_pro != htons(ETH_P_IP))
+		return 0;
+	if (arphdr->ar_hln != ETH_ALEN)
+		return 0;
+	if (arphdr->ar_pln != 4)
+		return 0;
+
+	hw_src = (uint8_t *)arphdr + sizeof(struct arphdr);
+	hw_dst = hw_src + ETH_ALEN + 4;
+	bla_dst = (struct batadv_bla_claim_dst *)hw_dst;
+	bla_dst_own = &bat_priv->bla.claim_dest;
+
+	/* check if it is a claim frame in general */
+	if (memcmp(bla_dst->magic, bla_dst_own->magic,
+		   sizeof(bla_dst->magic)) != 0)
+		return 0;
+
+	batadv_dbg(BATADV_DBG_BLA, bat_priv, "Dropping encapsulated claim frame\n");
+
+	return 1;
+}
 
 /**
  * batadv_bla_process_claim
@@ -885,6 +954,21 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 		vhdr = vlan_eth_hdr(skb);
 		proto = vhdr->h_vlan_encapsulated_proto;
 		headlen += VLAN_HLEN;
+
+		if (proto == htons(ETH_P_8021Q)) {
+			/* check if there is a claim frame encapsulated
+			 * deeper in (QinQ) and drop that, as this is
+			 * not supported by BLA but should also not be
+			 * sent via the mesh.
+			 *
+			 * if its not, let the frame pass without further
+			 * checks, as it is not a claim frame anyway.
+			 */
+			if (batadv_is_encapsulated_claim(bat_priv, skb))
+				return 1;
+			else
+				return 0;
+		}
 	}
 
 	if (proto != htons(ETH_P_ARP))
-- 
1.9.1

