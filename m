Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  5 Nov 2012 21:25:27 +0100
Message-Id: <1352147127-2932-2-git-send-email-sven@narfation.org>
In-Reply-To: <1352147127-2932-1-git-send-email-sven@narfation.org>
References: <1352038798-29658-2-git-send-email-sven@narfation.org>
 <1352147127-2932-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC-alt2/2 2/4] batman-adv: Use packing of 2 for
	all headers before an ethernet header
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

All packet headers in front of an ethernet header have to be completely
divisible by 2 but not by 4 to make the payload after the ethernet header again
4 bytes boundary aligned.

A packing of 2 is necessary to avoid extra padding at the end of the struct
caused by a structure member which is larger than two bytes. Otherwise the
structure would not fulfill the previously mentioned rule to avoid the
misalignment of the payload after the ethernet header. It may also lead to
leakage of information when the padding it not initialized before sending.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Because we had protests against the approach of splitting the 32 bit seqno...
here is a different approach. Now get your dices to find out what David may
will like.

 packet.h |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index 28699f1..a211916 100644
--- a/packet.h
+++ b/packet.h
@@ -172,6 +172,18 @@ struct batadv_icmp_packet_rr {
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 };
 
+/* All packet headers in front of an ethernet header have to be completely
+ * divisible by 2 but not by 4 to make the payload after the ethernet
+ * header again 4 bytes boundary aligned.
+ *
+ * A packing of 2 is necessary to avoid extra padding at the end of the struct
+ * caused by a structure member which is larger than two bytes. Otherwise
+ * the structure would not fulfill the previously mentioned rule to avoid the
+ * misalignment of the payload after the ethernet header. It may also lead to
+ * leakage of information when the padding it not initialized before sending.
+ */
+#pragma pack(2)
+
 struct batadv_unicast_packet {
 	struct batadv_header header;
 	uint8_t  ttvn; /* destination translation table version number */
@@ -211,7 +223,9 @@ struct batadv_bcast_packet {
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
-} __packed;
+};
+
+#pragma pack()
 
 struct batadv_vis_packet {
 	struct batadv_header header;
-- 
1.7.10.4

