Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 28 May 2011 00:10:22 +0200
Message-Id: <1306534222-11710-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: move the ttl field to the third
	position of unicast_* packets
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Move the ttl field to the third position of unicast_packet and
unicast_frag_packet. In this way it possible to give them a better shape for
later usage

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/packet.h b/packet.h
index eda9965..e464ceb 100644
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
@@ -99,16 +99,19 @@ struct icmp_packet_rr {
 struct unicast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  dest[6];
 	uint8_t  ttl;
+	uint8_t  align;
+	uint8_t  dest[6];
 } __packed;
 
 struct unicast_frag_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
-	uint8_t  dest[6];
 	uint8_t  ttl;
+	uint8_t  align;
+	uint8_t  dest[6];
 	uint8_t  flags;
+	uint8_t  align;
 	uint8_t  orig[6];
 	uint16_t seqno;
 } __packed;
-- 
1.7.3.4

