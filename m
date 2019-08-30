Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/2] batman-adv: Only read OGM2 tvlv_len after buffer len check
Date: Fri, 30 Aug 2019 09:25:02 +0200
Message-Id: <20190830072502.16929-3-sw@simonwunderlich.de>
In-Reply-To: <20190830072502.16929-1-sw@simonwunderlich.de>
References: <20190830072502.16929-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

Multiple batadv_ogm2_packet can be stored in an skbuff. The functions
batadv_v_ogm_send_to_if() uses batadv_v_ogm_aggr_packet() to check if there
is another additional batadv_ogm2_packet in the skb or not before they
continue processing the packet.

The length for such an OGM2 is BATADV_OGM2_HLEN +
batadv_ogm2_packet->tvlv_len. The check must first check that at least
BATADV_OGM2_HLEN bytes are available before it accesses tvlv_len (which is
part of the header. Otherwise it might try read outside of the currently
available skbuff to get the content of tvlv_len.

Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index fad95ef64e01..bc06e3cdfa84 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -631,17 +631,23 @@ batadv_v_ogm_process_per_outif(struct batadv_priv *bat_priv,
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
@@ -818,7 +824,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 
 	while (batadv_v_ogm_aggr_packet(ogm_offset, skb_headlen(skb),
-					ogm_packet->tvlv_len)) {
+					ogm_packet)) {
 		batadv_v_ogm_process(skb, ogm_offset, if_incoming);
 
 		ogm_offset += BATADV_OGM2_HLEN;
-- 
2.20.1

