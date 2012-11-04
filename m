Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2012 15:19:56 +0100
Message-Id: <1352038798-29658-2-git-send-email-sven@narfation.org>
In-Reply-To: <1352038798-29658-1-git-send-email-sven@narfation.org>
References: <1352038798-29658-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 2/4] batman-adv: Mark correctly aligned headers
	not as __packed
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

Headers which are already perfectly aligned and create a 4 byte boundary
non-ethernet header payload can have the __packed attribute removed. The
__packed attribute doesn't change the appeareance of the packet for these
headers because no extra padding is necessary to align the data members. The
compiler will also create slightly faster code for loads of multi-byte members.

The definition of the batadv_bcast_packet has to change slightly because the 32
bit sequence number would cause this packet to be padded with two extra bytes
at the end. These "missing" two bytes are used to fix the alignment of the
payload after the following ethernet header. Splitting the sequence number in
two 16 bit values avoids it without changing the actual packet.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Newer tested - but at least it builds ;)

 packet.h         |   25 +++++++++++++++++--------
 routing.c        |   21 ++++++++++++++++++---
 soft-interface.c |   16 +++++++++++++++-
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/packet.h b/packet.h
index aa3e63a..43c863c 100644
--- a/packet.h
+++ b/packet.h
@@ -121,13 +121,15 @@ struct batadv_bla_claim_dst {
 	uint8_t magic[3];	/* FF:43:05 */
 	uint8_t type;		/* bla_claimframe */
 	__be16 group;		/* group id */
-} __packed;
+};
 
 struct batadv_header {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  ttl;
-} __packed;
+	/* the parent struct has to add a byte after the header to make
+	 * everything 4 bytes aligned again */
+};
 
 struct batadv_ogm_packet {
 	struct batadv_header header;
@@ -152,7 +154,7 @@ struct batadv_icmp_packet {
 	__be16   seqno;
 	uint8_t  uid;
 	uint8_t  reserved;
-} __packed;
+};
 
 #define BATADV_RR_LEN 16
 
@@ -168,13 +170,16 @@ struct batadv_icmp_packet_rr {
 	uint8_t  uid;
 	uint8_t  rr_cur;
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
-} __packed;
+};
 
 struct batadv_unicast_packet {
 	struct batadv_header header;
 	uint8_t  ttvn; /* destination translation table version number */
 	uint8_t  dest[ETH_ALEN];
-} __packed;
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
+};
 
 /**
  * struct batadv_unicast_4addr_packet - extended unicast packet
@@ -201,9 +206,13 @@ struct batadv_unicast_frag_packet {
 struct batadv_bcast_packet {
 	struct batadv_header header;
 	uint8_t  reserved;
-	__be32   seqno;
+	__be16   seqno_hi;
+	__be16   seqno_lo;
 	uint8_t  orig[ETH_ALEN];
-} __packed;
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
+};
 
 struct batadv_vis_packet {
 	struct batadv_header header;
@@ -214,7 +223,7 @@ struct batadv_vis_packet {
 	uint8_t  vis_orig[ETH_ALEN];	/* originator reporting its neighbors */
 	uint8_t  target_orig[ETH_ALEN]; /* who should receive this packet */
 	uint8_t  sender_orig[ETH_ALEN]; /* who sent or forwarded this packet */
-} __packed;
+};
 
 struct batadv_tt_query_packet {
 	struct batadv_header header;
diff --git a/routing.c b/routing.c
index d5a01d1..f7d50d0 100644
--- a/routing.c
+++ b/routing.c
@@ -1115,6 +1115,17 @@ rx_success:
 	return batadv_route_unicast_packet(skb, recv_if);
 }
 
+/**
+ * batadv_ntoh_seqno32 - Convert 2 seqno parts to a single host byte order seqno
+ * @seqno_hi: Upper 16 bit part of the sequence number
+ * @seqno_lo: Lower 16 bit part of the sequence number
+ *
+ * Returns the complete host byte order sequence number
+ */
+static uint32_t batadv_ntoh_seqno32(__be16 seqno_hi, __be16 seqno_lo)
+{
+	return ntohs(seqno_hi) << 16 | ntohs(seqno_lo);
+}
 
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
@@ -1126,6 +1137,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	int hdr_size = sizeof(*bcast_packet);
 	int ret = NET_RX_DROP;
 	int32_t seq_diff;
+	uint32_t seqno;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -1161,12 +1173,15 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	spin_lock_bh(&orig_node->bcast_seqno_lock);
 
+	seqno = batadv_ntoh_seqno32(bcast_packet->seqno_hi,
+				    bcast_packet->seqno_lo);
+
 	/* check whether the packet is a duplicate */
 	if (batadv_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqno,
-			    ntohl(bcast_packet->seqno)))
+			    seqno))
 		goto spin_unlock;
 
-	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
+	seq_diff = seqno - orig_node->last_bcast_seqno;
 
 	/* check whether the packet is old and the host just restarted. */
 	if (batadv_window_protected(bat_priv, seq_diff,
@@ -1177,7 +1192,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	 * if required.
 	 */
 	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
-		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
+		orig_node->last_bcast_seqno = seqno;
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 
diff --git a/soft-interface.c b/soft-interface.c
index 2d1f895..7d1b0ce 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -138,6 +138,19 @@ static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+/**
+ * batadv_hton_seqno32 - Convert seqno in two sequence number parts
+ * @seqno: Sequence number to be converted
+ * @seqno_hi: Pointer to upper 16 bit part of the sequence number
+ * @seqno_lo: Pointer to ulower 16 bit part of the sequence number
+ */
+static void batadv_hton_seqno32(uint32_t seqno,
+				__be16 *seqno_hi, __be16 *seqno_lo)
+{
+	*seqno_hi = htons(seqno >> 16);
+	*seqno_lo = htons(seqno & 0xffff);
+}
+
 static int batadv_interface_tx(struct sk_buff *skb,
 			       struct net_device *soft_iface)
 {
@@ -252,7 +265,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 		/* set broadcast sequence number */
 		seqno = atomic_inc_return(&bat_priv->bcast_seqno);
-		bcast_packet->seqno = htonl(seqno);
+		batadv_hton_seqno32(seqno, &bcast_packet->seqno_hi,
+				    &bcast_packet->seqno_lo);
 
 		batadv_add_bcast_packet_to_list(bat_priv, skb, brd_delay);
 
-- 
1.7.10.4

