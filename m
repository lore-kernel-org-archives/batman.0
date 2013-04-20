Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 20 Apr 2013 13:08:16 +0200
Message-Id: <1366456097-1447-6-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366456097-1447-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1366456097-1447-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCHv3 5/6] batman-adv: reorder batadv_iv_flags
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

The vis flag is not needed anymore, and since we do a compat bump we
can start with the first bit again

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 packet.h |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/packet.h b/packet.h
index 88d3aa6..8cc9068 100644
--- a/packet.h
+++ b/packet.h
@@ -69,11 +69,19 @@ enum batadv_subtype {
 /* this file is included by batctl which needs these defines */
 #define BATADV_COMPAT_VERSION 14
 
+/**
+ * enum batadv_iv_flags - flags used in B.A.T.M.A.N. IV OGM packets
+ * @BATADV_NOT_BEST_NEXT_HOP: flag is set when ogm packet is forwarded and was
+ *	previously received from someone else than the best neighbor.
+ * @BATADV_PRIMARIES_FIRST_HOP: flag is set when the primary interface address
+ *	is used, and the packet travels its first hop.
+ * @BATADV_DIRECTLINK: flag is for the first hop or if rebroadcasted from a
+ *	one hop neighbor on the interface where it was originally received.
+ */
 enum batadv_iv_flags {
-	BATADV_NOT_BEST_NEXT_HOP   = BIT(3),
-	BATADV_PRIMARIES_FIRST_HOP = BIT(4),
-	BATADV_VIS_SERVER	   = BIT(5),
-	BATADV_DIRECTLINK	   = BIT(6),
+	BATADV_NOT_BEST_NEXT_HOP   = BIT(0),
+	BATADV_PRIMARIES_FIRST_HOP = BIT(1),
+	BATADV_DIRECTLINK	   = BIT(2),
 };
 
 /* ICMP message types */
@@ -167,11 +175,12 @@ struct batadv_header {
 /**
  * struct batadv_ogm_packet - ogm (routing protocol) packet
  * @header: common batman packet header
+ * @flags: contains routing relevant flags - see enum batadv_iv_flags
  * @tvlv_len: length of tvlv data following the ogm header
  */
 struct batadv_ogm_packet {
 	struct batadv_header header;
-	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
+	uint8_t  flags;
 	__be32   seqno;
 	uint8_t  orig[ETH_ALEN];
 	uint8_t  prev_sender[ETH_ALEN];
-- 
1.7.10.4

