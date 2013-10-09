Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  9 Oct 2013 14:40:18 +0200
Message-Id: <1381322418-1349-17-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1381322418-1349-1-git-send-email-antonio@meshcoding.com>
References: <1381322418-1349-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 16/16] batman-adv: reorder batadv_iv_flags
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <lindner_marek@yahoo.de>

From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

The vis flag is not needed anymore, and since we do a compat bump we
can start with the first bit again

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/packet.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 4e5fe7d..4361bae 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -67,10 +67,19 @@ enum batadv_subtype {
 /* this file is included by batctl which needs these defines */
 #define BATADV_COMPAT_VERSION 15
 
+/**
+ * enum batadv_iv_flags - flags used in B.A.T.M.A.N. IV OGM packets
+ * @BATADV_NOT_BEST_NEXT_HOP: flag is set when ogm packet is forwarded and was
+ *     previously received from someone else than the best neighbor.
+ * @BATADV_PRIMARIES_FIRST_HOP: flag is set when the primary interface address
+ *     is used, and the packet travels its first hop.
+ * @BATADV_DIRECTLINK: flag is for the first hop or if rebroadcasted from a
+ *     one hop neighbor on the interface where it was originally received.
+ */
 enum batadv_iv_flags {
-	BATADV_NOT_BEST_NEXT_HOP   = BIT(3),
-	BATADV_PRIMARIES_FIRST_HOP = BIT(4),
-	BATADV_DIRECTLINK	   = BIT(6),
+	BATADV_NOT_BEST_NEXT_HOP   = BIT(0),
+	BATADV_PRIMARIES_FIRST_HOP = BIT(1),
+	BATADV_DIRECTLINK          = BIT(2),
 };
 
 /* ICMP message types */
@@ -164,11 +173,12 @@ struct batadv_header {
 /**
  * struct batadv_ogm_packet - ogm (routing protocol) packet
  * @header: common batman packet header
+ * @flags: contains routing relevant flags - see enum batadv_iv_flags
  * @tvlv_len: length of tvlv data following the ogm header
  */
 struct batadv_ogm_packet {
 	struct batadv_header header;
-	uint8_t  flags;    /* 0x40: DIRECTLINK flag ... */
+	uint8_t  flags;
 	__be32   seqno;
 	uint8_t  orig[ETH_ALEN];
 	uint8_t  prev_sender[ETH_ALEN];
-- 
1.8.3.2

