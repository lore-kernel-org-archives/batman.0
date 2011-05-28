Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 May 2011 10:43:03 +0200
Message-Id: <1306572183-25950-1-git-send-email-sven@narfation.org>
In-Reply-To: <201105280926.32059.sven@narfation.org>
References: <201105280926.32059.sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-sven] batman-adv: Unify the first 4 bytes in
	each packet
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

The amount of duplicated code in the receive and routing code can be reduced
when all headers provide the packet type, version and ttl in the same first
bytes.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
just my suggestion

 packet.h |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/packet.h b/packet.h
index eda9965..c84f325 100644
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
@@ -55,12 +55,13 @@
 struct batman_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
+	uint8_t  ttl;
+	uint8_t  reserved;
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
 	uint8_t  tq;
 	uint32_t seqno;
 	uint8_t  orig[6];
 	uint8_t  prev_sender[6];
-	uint8_t  ttl;
 	uint8_t  num_tt;
 	uint8_t  gw_flags;  /* flags related to gateway class */
 	uint8_t  align;
@@ -71,8 +72,9 @@ struct batman_packet {
 struct icmp_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  ttl;
+	uint8_t  reserved;
+	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[6];
 	uint8_t  orig[6];
 	uint16_t seqno;
@@ -86,8 +88,9 @@ struct icmp_packet {
 struct icmp_packet_rr {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  ttl;
+	uint8_t  reserved;
+	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[6];
 	uint8_t  orig[6];
 	uint16_t seqno;
@@ -99,16 +102,19 @@ struct icmp_packet_rr {
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
@@ -116,8 +122,9 @@ struct unicast_frag_packet {
 struct bcast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  orig[6];
 	uint8_t  ttl;
+	uint8_t  reserved;
+	uint8_t  orig[6];
 	uint32_t seqno;
 } __packed;
 
-- 
1.7.5.1

