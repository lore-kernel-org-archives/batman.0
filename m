Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 21 Nov 2012 13:11:59 +0100
Message-Id: <1353499919-28596-10-git-send-email-ordex@autistici.org>
In-Reply-To: <1353499919-28596-1-git-send-email-ordex@autistici.org>
References: <1353499919-28596-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Use packing of 2 for all
	headers before an ethernet header
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Sven Eckelmann <sven@narfation.org>

All packet headers in front of an ethernet header have to be completely
divisible by 2 but not by 4 to make the payload after the ethernet header again
4 bytes boundary aligned.

A packing of 2 is necessary to avoid extra padding at the end of the struct
caused by a structure member which is larger than two bytes. Otherwise the
structure would not fulfill the previously mentioned rule to avoid the
misalignment of the payload after the ethernet header. It may also lead to
leakage of information when the padding it not initialized before sending.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/packet.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index df548ed..1c5454d 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -173,6 +173,18 @@ struct batadv_icmp_packet_rr {
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
@@ -216,7 +228,9 @@ struct batadv_bcast_packet {
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
1.8.0

