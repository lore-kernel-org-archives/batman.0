Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 11 Jul 2014 14:26:29 +0200
Message-Id: <1405081595-23371-7-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 07/13] batman-adv: kernel doc fixes for
	packet.h
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 packet.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/packet.h b/packet.h
index 34e096d..cfbaf4d 100644
--- a/packet.h
+++ b/packet.h
@@ -156,7 +156,7 @@ enum batadv_tt_client_flags {
 };
 
 /**
- * batadv_vlan_flags - flags for the four MSB of any vlan ID field
+ * enum batadv_vlan_flags - flags for the four MSB of any vlan ID field
  * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
  */
 enum batadv_vlan_flags {
@@ -203,9 +203,14 @@ struct batadv_bla_claim_dst {
 /**
  * struct batadv_ogm_packet - ogm (routing protocol) packet
  * @packet_type: batman-adv packet type, part of the general header
- * @version: batman-adv protocol version, part of the genereal header
- * @ttl: time to live for this packet, part of the genereal header
+ * @version: batman-adv protocol version, part of the general header
+ * @ttl: time to live for this packet, part of the general header
  * @flags: contains routing relevant flags - see enum batadv_iv_flags
+ * @seqno: inremental sequence number for this ogm packet
+ * @orig: address of the originator of this ogm packet
+ * @prev_sender: address of the previous sender of this ogm packet
+ * @reserved: reserved byte for alignment
+ * @tq: accumulated TQ value towards the originator of this ogm packet
  * @tvlv_len: length of tvlv data following the ogm header
  */
 struct batadv_ogm_packet {
@@ -227,7 +232,7 @@ struct batadv_ogm_packet {
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
 /**
- * batadv_icmp_header - common members among all the ICMP packets
+ * struct batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
@@ -253,7 +258,7 @@ struct batadv_icmp_header {
 };
 
 /**
- * batadv_icmp_packet - ICMP packet
+ * struct batadv_icmp_packet - ICMP packet
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
@@ -279,7 +284,7 @@ struct batadv_icmp_packet {
 #define BATADV_RR_LEN 16
 
 /**
- * batadv_icmp_packet_rr - ICMP RouteRecord packet
+ * struct batadv_icmp_packet_rr - ICMP RouteRecord packet
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
@@ -342,6 +347,7 @@ struct batadv_unicast_packet {
  * @u: common unicast packet header
  * @src: address of the source
  * @subtype: packet subtype
+ * @reserved: reserved byte for alignment
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
@@ -410,7 +416,6 @@ struct batadv_bcast_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
- * @reserved: Align following fields to 2-byte boundaries
  * @first_source: original source of first included packet
  * @first_orig_dest: original destinal of first included packet
  * @first_crc: checksum of first included packet
@@ -492,7 +497,7 @@ struct batadv_tvlv_gateway_data {
  * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
  * @flags: translation table flags (see batadv_tt_data_flags)
  * @ttvn: translation table version number
- * @vlan_num: number of announced VLANs. In the TVLV this struct is followed by
+ * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
  *  one batadv_tvlv_tt_vlan_data object per announced vlan
  */
 struct batadv_tvlv_tt_data {
-- 
2.0.1

