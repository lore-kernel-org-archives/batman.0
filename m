Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  5 Nov 2012 21:25:26 +0100
Message-Id: <1352147127-2932-1-git-send-email-sven@narfation.org>
In-Reply-To: <1352038798-29658-2-git-send-email-sven@narfation.org>
References: <1352038798-29658-2-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC-alt1/2 2/4] batman-adv: Mark correctly aligned
	headers not as __packed
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Because we had protests against the approach of splitting the 32 bit seqno...
here is a different approach. Now get your dices to find out what David may
will like.

 packet.h |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/packet.h b/packet.h
index aa3e63a..28699f1 100644
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
@@ -203,6 +208,9 @@ struct batadv_bcast_packet {
 	uint8_t  reserved;
 	__be32   seqno;
 	uint8_t  orig[ETH_ALEN];
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
 } __packed;
 
 struct batadv_vis_packet {
@@ -214,7 +222,7 @@ struct batadv_vis_packet {
 	uint8_t  vis_orig[ETH_ALEN];	/* originator reporting its neighbors */
 	uint8_t  target_orig[ETH_ALEN]; /* who should receive this packet */
 	uint8_t  sender_orig[ETH_ALEN]; /* who sent or forwarded this packet */
-} __packed;
+};
 
 struct batadv_tt_query_packet {
 	struct batadv_header header;
-- 
1.7.10.4

