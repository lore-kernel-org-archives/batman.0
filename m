Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 13 May 2013 12:34:56 +0200
Message-Id: <1368441296-3541-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1368441296-3541-1-git-send-email-ordex@autistici.org>
References: <1368441296-3541-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: move seqno field outside of
	the common ICMP header
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

The sequence number might be subtype dependent (e.g. a new
ICMP mechanism may require a bigger space) and therefore it
is better to move it away from the common ICMP header and
let each subtype define its own.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 packet.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/packet.h b/packet.h
index 6f98d02..c8ef60e 100644
--- a/packet.h
+++ b/packet.h
@@ -198,7 +198,6 @@ struct batadv_ogm_packet {
  * @msg_type: ICMP packet type
  * @dst: address of the destination node
  * @orig: address of the source node
- * @seqno: ICMP sequence number
  * @uid: local ICMP socket identifier
  */
 struct batadv_icmp_header {
@@ -206,7 +205,6 @@ struct batadv_icmp_header {
 	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  orig[ETH_ALEN];
-	__be16   seqno;
 	uint8_t  uid;
 };
 
@@ -214,10 +212,12 @@ struct batadv_icmp_header {
  * batadv_icmp_packet - ICMP packet
  * @ih: common ICMP header
  * @reserved: not used - useful for alignment
+ * @seqno: ICMP sequence number
  */
 struct batadv_icmp_packet {
 	struct batadv_icmp_header ih;
 	uint8_t  reserved;
+	__be16   seqno;
 };
 
 #define BATADV_RR_LEN 16
@@ -226,11 +226,13 @@ struct batadv_icmp_packet {
  * batadv_icmp_packet_rr - ICMP RouteRecord packet
  * @ih: common ICMP header
  * @rr_cur: number of entries the rr array
+ * @seqno: ICMP sequence number
  * @rr: route record array
  */
 struct batadv_icmp_packet_rr {
 	struct batadv_icmp_header ih;
 	uint8_t  rr_cur;
+	__be16   seqno;
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 };
 
-- 
1.8.1.5

