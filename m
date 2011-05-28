Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 May 2011 14:51:06 +0200
Message-Id: <1306587066-7102-1-git-send-email-sven@narfation.org>
In-Reply-To: <201105281443.35742.sven@narfation.org>
References: <201105281443.35742.sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3-sven] batman-adv: Unify the first 3 bytes
	in each packet
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

From: Antonio Quartulli <ordex@autistici.org>

The amount of duplicated code in the receive and routing code can be
reduced when all headers provide the packet type, version and ttl in the
same first bytes.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
* Keep the reserved fields in unicast_frag_packet for ordex's changes

 packet.h |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/packet.h b/packet.h
index eda9965..f4052f2 100644
--- a/packet.h
+++ b/packet.h
@@ -32,7 +32,7 @@
 #define BAT_UNICAST_FRAG 0x06
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 12
+#define COMPAT_VERSION 14
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 #define PRIMARIES_FIRST_HOP 0x10
@@ -55,15 +55,15 @@
 struct batman_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
+	uint8_t  ttl;
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
-	uint8_t  tq;
 	uint32_t seqno;
 	uint8_t  orig[6];
 	uint8_t  prev_sender[6];
-	uint8_t  ttl;
-	uint8_t  num_tt;
 	uint8_t  gw_flags;  /* flags related to gateway class */
-	uint8_t  align;
+	uint8_t  tq;
+	uint8_t  num_tt;
+	uint8_t  reserved;
 } __packed;
 
 #define BAT_PACKET_LEN sizeof(struct batman_packet)
@@ -71,12 +71,13 @@ struct batman_packet {
 struct icmp_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  ttl;
+	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[6];
 	uint8_t  orig[6];
 	uint16_t seqno;
 	uint8_t  uid;
+	uint8_t  reserved;
 } __packed;
 
 #define BAT_RR_LEN 16
@@ -86,8 +87,8 @@ struct icmp_packet {
 struct icmp_packet_rr {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  ttl;
+	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[6];
 	uint8_t  orig[6];
 	uint16_t seqno;
@@ -99,16 +100,19 @@ struct icmp_packet_rr {
 struct unicast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  dest[6];
 	uint8_t  ttl;
+	uint8_t  reserved;
+	uint8_t  dest[6];
 } __packed;
 
 struct unicast_frag_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  dest[6];
 	uint8_t  ttl;
+	uint8_t  reserved;
+	uint8_t  dest[6];
 	uint8_t  flags;
+	uint8_t  align;
 	uint8_t  orig[6];
 	uint16_t seqno;
 } __packed;
@@ -116,18 +120,20 @@ struct unicast_frag_packet {
 struct bcast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  orig[6];
 	uint8_t  ttl;
+	uint8_t  reserved;
 	uint32_t seqno;
+	uint8_t  orig[6];
 } __packed;
 
 struct vis_packet {
 	uint8_t  packet_type;
 	uint8_t  version;        /* batman version field */
+	uint8_t  ttl;		 /* TTL */
 	uint8_t  vis_type;	 /* which type of vis-participant sent this? */
-	uint8_t  entries;	 /* number of entries behind this struct */
 	uint32_t seqno;		 /* sequence number */
-	uint8_t  ttl;		 /* TTL */
+	uint8_t  entries;	 /* number of entries behind this struct */
+	uint8_t  reserved;
 	uint8_t  vis_orig[6];	 /* originator that announces its neighbors */
 	uint8_t  target_orig[6]; /* who should receive this packet */
 	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
-- 
1.7.5.1

