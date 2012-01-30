Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 30 Jan 2012 20:59:17 +0100
Message-Id: <1327953557-26774-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use ETH_ALEN instead of
	hardcoded numeric constants
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

In packet.h the numeric constant 6 is used instead of the more portable ETH_ALEN
define. This patch substitute any hardcoded value with such define.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/packet.h b/packet.h
index 441f3db..3496d38 100644
--- a/packet.h
+++ b/packet.h
@@ -100,8 +100,8 @@ struct batman_ogm_packet {
 	struct batman_header header;
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
 	uint32_t seqno;
-	uint8_t  orig[6];
-	uint8_t  prev_sender[6];
+	uint8_t  orig[ETH_ALEN];
+	uint8_t  prev_sender[ETH_ALEN];
 	uint8_t  gw_flags;  /* flags related to gateway class */
 	uint8_t  tq;
 	uint8_t  tt_num_changes;
@@ -114,8 +114,8 @@ struct batman_ogm_packet {
 struct icmp_packet {
 	struct batman_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  dst[6];
-	uint8_t  orig[6];
+	uint8_t  dst[ETH_ALEN];
+	uint8_t  orig[ETH_ALEN];
 	uint16_t seqno;
 	uint8_t  uid;
 	uint8_t  reserved;
@@ -128,8 +128,8 @@ struct icmp_packet {
 struct icmp_packet_rr {
 	struct batman_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  dst[6];
-	uint8_t  orig[6];
+	uint8_t  dst[ETH_ALEN];
+	uint8_t  orig[ETH_ALEN];
 	uint16_t seqno;
 	uint8_t  uid;
 	uint8_t  rr_cur;
@@ -139,16 +139,16 @@ struct icmp_packet_rr {
 struct unicast_packet {
 	struct batman_header header;
 	uint8_t  ttvn; /* destination translation table version number */
-	uint8_t  dest[6];
+	uint8_t  dest[ETH_ALEN];
 } __packed;
 
 struct unicast_frag_packet {
 	struct batman_header header;
 	uint8_t  ttvn; /* destination translation table version number */
-	uint8_t  dest[6];
+	uint8_t  dest[ETH_ALEN];
 	uint8_t  flags;
 	uint8_t  align;
-	uint8_t  orig[6];
+	uint8_t  orig[ETH_ALEN];
 	uint16_t seqno;
 } __packed;
 
@@ -156,7 +156,7 @@ struct bcast_packet {
 	struct batman_header header;
 	uint8_t  reserved;
 	uint32_t seqno;
-	uint8_t  orig[6];
+	uint8_t  orig[ETH_ALEN];
 } __packed;
 
 struct vis_packet {
@@ -165,9 +165,9 @@ struct vis_packet {
 	uint32_t seqno;		 /* sequence number */
 	uint8_t  entries;	 /* number of entries behind this struct */
 	uint8_t  reserved;
-	uint8_t  vis_orig[6];	 /* originator that announces its neighbors */
-	uint8_t  target_orig[6]; /* who should receive this packet */
-	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
+	uint8_t  vis_orig[ETH_ALEN];	 /* originator that announces its neighbors */
+	uint8_t  target_orig[ETH_ALEN]; /* who should receive this packet */
+	uint8_t  sender_orig[ETH_ALEN]; /* who sent or rebroadcasted this packet */
 } __packed;
 
 struct tt_query_packet {
-- 
1.7.3.4

