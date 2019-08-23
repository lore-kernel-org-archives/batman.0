Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 2/2] batman-adv: Only read OGM2 tvlv_len after buffer len
 check
Date: Fri, 23 Aug 2019 14:34:28 +0200
Message-Id: <20190823123428.8076-2-sven@narfation.org>
In-Reply-To: <20190823123428.8076-1-sven@narfation.org>
References: <20190823123428.8076-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Multiple batadv_ogm2_packet can be stored in an skbuff. The functions
batadv_v_ogm_send_to_if() uses batadv_v_ogm_aggr_packet() to check if there
is another additional batadv_ogm2_packet in the skb or not before they
continue processing the packet.

The length for such an OGM2 is BATADV_OGM2_HLEN +
batadv_ogm2_packet->tvlv_len. The check must first check that at least
BATADV_OGM2_HLEN bytes are available before it accesses tvlv_len (which is
part of the header. Otherwise it might try read outside of the currently
available skbuff to get the content of tvlv_len.

Fixes: 667996ebeab4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_ogm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 319249f0..dc4f7430 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -806,17 +806,23 @@ batadv_v_ogm_process_per_outif(struct batadv_priv *bat_priv,
  * batadv_v_ogm_aggr_packet() - checks if there is another OGM aggregated
  * @buff_pos: current position in the skb
  * @packet_len: total length of the skb
- * @tvlv_len: tvlv length of the previously considered OGM
+ * @ogm2_packet: potential OGM2 in buffer
  *
  * Return: true if there is enough space for another OGM, false otherwise.
  */
-static bool batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
-				     __be16 tvlv_len)
+static bool
+batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
+			 const struct batadv_ogm2_packet *ogm2_packet)
 {
 	int next_buff_pos = 0;
 
-	next_buff_pos += buff_pos + BATADV_OGM2_HLEN;
-	next_buff_pos += ntohs(tvlv_len);
+	/* check if there is enough space for the header */
+	next_buff_pos += buff_pos + sizeof(*ogm2_packet);
+	if (next_buff_pos > packet_len)
+		return false;
+
+	/* check if there is enough space for the optional TVLV */
+	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
 	return (next_buff_pos <= packet_len) &&
 	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
@@ -993,7 +999,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 
 	while (batadv_v_ogm_aggr_packet(ogm_offset, skb_headlen(skb),
-					ogm_packet->tvlv_len)) {
+					ogm_packet)) {
 		batadv_v_ogm_process(skb, ogm_offset, if_incoming);
 
 		ogm_offset += BATADV_OGM2_HLEN;
-- 
2.20.1

