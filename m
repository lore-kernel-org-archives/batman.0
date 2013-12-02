Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  2 Dec 2013 20:38:32 +0100
Message-Id: <1386013113-25471-3-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-next 3/4] batman-adv: fix size of
	batadv_icmp_header
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

struct batadv_icmp_header currently has a size of 17, which will be
padded to 20 on some architectures. Fix this by moving more common
fields into the icmp header.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 packet.h  |   13 +++++--------
 routing.c |    6 +++---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/packet.h b/packet.h
index 175ce7d..001b941 100644
--- a/packet.h
+++ b/packet.h
@@ -199,6 +199,9 @@ struct batadv_ogm_packet {
  * @dst: address of the destination node
  * @orig: address of the source node
  * @uid: local ICMP socket identifier
+ * @rr_cur: for record route packets: number of entries the rr array,
+ *  reserved for other packet types.
+ * @seqno: ICMP sequence number
  */
 struct batadv_icmp_header {
 	uint8_t  packet_type;
@@ -208,18 +211,16 @@ struct batadv_icmp_header {
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  orig[ETH_ALEN];
 	uint8_t  uid;
+	uint8_t  rr_cur;
+	__be16   seqno;
 };
 
 /**
  * batadv_icmp_packet - ICMP packet
  * @icmph: common ICMP header
- * @reserved: not used - useful for alignment
- * @seqno: ICMP sequence number
  */
 struct batadv_icmp_packet {
 	struct batadv_icmp_header icmph;
-	uint8_t  reserved;
-	__be16   seqno;
 };
 
 #define BATADV_RR_LEN 16
@@ -227,14 +228,10 @@ struct batadv_icmp_packet {
 /**
  * batadv_icmp_packet_rr - ICMP RouteRecord packet
  * @icmph: common ICMP header
- * @rr_cur: number of entries the rr array
- * @seqno: ICMP sequence number
  * @rr: route record array
  */
 struct batadv_icmp_packet_rr {
 	struct batadv_icmp_header icmph;
-	uint8_t  rr_cur;
-	__be16   seqno;
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 };
 
diff --git a/routing.c b/routing.c
index 5b52d71..785f8d9 100644
--- a/routing.c
+++ b/routing.c
@@ -421,12 +421,12 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 		icmph = (struct batadv_icmp_header *)skb->data;
 		icmp_packet_rr = (struct batadv_icmp_packet_rr *)icmph;
-		if (icmp_packet_rr->rr_cur >= BATADV_RR_LEN)
+		if (icmp_packet_rr->icmph.rr_cur >= BATADV_RR_LEN)
 			goto out;
 
-		memcpy(&(icmp_packet_rr->rr[icmp_packet_rr->rr_cur]),
+		memcpy(&(icmp_packet_rr->rr[icmp_packet_rr->icmph.rr_cur]),
 		       ethhdr->h_dest, ETH_ALEN);
-		icmp_packet_rr->rr_cur++;
+		icmp_packet_rr->icmph.rr_cur++;
 	}
 
 	/* packet for me */
-- 
1.7.10.4

