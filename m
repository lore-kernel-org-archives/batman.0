Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 11 Jun 2015 12:47:53 +0200
Message-Id: <1434019673-21646-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Replace C99 int types with kernel
	type
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

(s|u)(8|16|32|64) are the preferred types in the kernel. The use of the
standard C99 types u?int(8|16|32|64)_t are objected by some people and even
checkpatch now warns about using them.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.h   |   5 ++
 packet.h | 204 +++++++++++++++++++++++++++++++--------------------------------
 2 files changed, 107 insertions(+), 102 deletions(-)

diff --git a/main.h b/main.h
index d96ce94..a3ae5f6 100644
--- a/main.h
+++ b/main.h
@@ -22,6 +22,8 @@
 #ifndef _BATCTL_MAIN_H
 #define _BATCTL_MAIN_H
 
+#include <stdint.h>
+
 #ifndef SOURCE_VERSION
 #define SOURCE_VERSION "2015.0"
 #endif
@@ -47,6 +49,9 @@
 #define __packed __attribute((packed))   /* linux kernel compat */
 #define BIT(nr)                 (1UL << (nr)) /* linux kernel compat */
 
+typedef uint8_t u8; /* linux kernel compat */
+typedef uint16_t u16; /* linux kernel compat */
+
 extern char module_ver_path[];
 
 #ifndef VLAN_VID_MASK
diff --git a/packet.h b/packet.h
index 7a9cb7a..4242ede 100644
--- a/packet.h
+++ b/packet.h
@@ -197,8 +197,8 @@ enum batadv_tvlv_type {
  * transport the claim type and the group id
  */
 struct batadv_bla_claim_dst {
-	uint8_t magic[3];	/* FF:43:05 */
-	uint8_t type;		/* bla_claimframe */
+	u8     magic[3];	/* FF:43:05 */
+	u8     type;		/* bla_claimframe */
 	__be16 group;		/* group id */
 };
 
@@ -213,16 +213,16 @@ struct batadv_bla_claim_dst {
  * @tvlv_len: length of tvlv data following the ogm header
  */
 struct batadv_ogm_packet {
-	uint8_t  packet_type;
-	uint8_t  version;
-	uint8_t  ttl;
-	uint8_t  flags;
-	__be32   seqno;
-	uint8_t  orig[ETH_ALEN];
-	uint8_t  prev_sender[ETH_ALEN];
-	uint8_t  reserved;
-	uint8_t  tq;
-	__be16   tvlv_len;
+	u8     packet_type;
+	u8     version;
+	u8     ttl;
+	u8     flags;
+	__be32 seqno;
+	u8     orig[ETH_ALEN];
+	u8     prev_sender[ETH_ALEN];
+	u8     reserved;
+	u8     tq;
+	__be16 tvlv_len;
 	/* __packed is not needed as the struct size is divisible by 4,
 	 * and the largest data type in this struct has a size of 4.
 	 */
@@ -246,14 +246,14 @@ struct batadv_ogm_packet {
  * members are padded the same way as they are in real packets.
  */
 struct batadv_icmp_header {
-	uint8_t  packet_type;
-	uint8_t  version;
-	uint8_t  ttl;
-	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  dst[ETH_ALEN];
-	uint8_t  orig[ETH_ALEN];
-	uint8_t  uid;
-	uint8_t  align[3];
+	u8 packet_type;
+	u8 version;
+	u8 ttl;
+	u8 msg_type; /* see ICMP message types above */
+	u8 dst[ETH_ALEN];
+	u8 orig[ETH_ALEN];
+	u8 uid;
+	u8 align[3];
 };
 
 /**
@@ -269,15 +269,15 @@ struct batadv_icmp_header {
  * @seqno: ICMP sequence number
  */
 struct batadv_icmp_packet {
-	uint8_t  packet_type;
-	uint8_t  version;
-	uint8_t  ttl;
-	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  dst[ETH_ALEN];
-	uint8_t  orig[ETH_ALEN];
-	uint8_t  uid;
-	uint8_t  reserved;
-	__be16   seqno;
+	u8     packet_type;
+	u8     version;
+	u8     ttl;
+	u8     msg_type; /* see ICMP message types above */
+	u8     dst[ETH_ALEN];
+	u8     orig[ETH_ALEN];
+	u8     uid;
+	u8     reserved;
+	__be16 seqno;
 };
 
 #define BATADV_RR_LEN 16
@@ -296,16 +296,16 @@ struct batadv_icmp_packet {
  * @rr: route record array
  */
 struct batadv_icmp_packet_rr {
-	uint8_t  packet_type;
-	uint8_t  version;
-	uint8_t  ttl;
-	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  dst[ETH_ALEN];
-	uint8_t  orig[ETH_ALEN];
-	uint8_t  uid;
-	uint8_t  rr_cur;
-	__be16   seqno;
-	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
+	u8     packet_type;
+	u8     version;
+	u8     ttl;
+	u8     msg_type; /* see ICMP message types above */
+	u8     dst[ETH_ALEN];
+	u8     orig[ETH_ALEN];
+	u8     uid;
+	u8     rr_cur;
+	__be16 seqno;
+	u8     rr[BATADV_RR_LEN][ETH_ALEN];
 };
 
 #define BATADV_ICMP_MAX_PACKET_SIZE	sizeof(struct batadv_icmp_packet_rr)
@@ -331,11 +331,11 @@ struct batadv_icmp_packet_rr {
  * @dest: originator destination of the unicast packet
  */
 struct batadv_unicast_packet {
-	uint8_t  packet_type;
-	uint8_t  version;
-	uint8_t  ttl;
-	uint8_t  ttvn; /* destination translation table version number */
-	uint8_t  dest[ETH_ALEN];
+	u8 packet_type;
+	u8 version;
+	u8 ttl;
+	u8 ttvn; /* destination translation table version number */
+	u8 dest[ETH_ALEN];
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
@@ -349,9 +349,9 @@ struct batadv_unicast_packet {
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
-	uint8_t src[ETH_ALEN];
-	uint8_t subtype;
-	uint8_t reserved;
+	u8 src[ETH_ALEN];
+	u8 subtype;
+	u8 reserved;
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
@@ -370,22 +370,22 @@ struct batadv_unicast_4addr_packet {
  * @total_size: size of the merged packet
  */
 struct batadv_frag_packet {
-	uint8_t packet_type;
-	uint8_t version;  /* batman version field */
-	uint8_t ttl;
+	u8     packet_type;
+	u8     version;  /* batman version field */
+	u8     ttl;
 #if defined(__BIG_ENDIAN_BITFIELD)
-	uint8_t no:4;
-	uint8_t reserved:4;
+	u8     no:4;
+	u8     reserved:4;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	uint8_t reserved:4;
-	uint8_t no:4;
+	u8     reserved:4;
+	u8     no:4;
 #else
 #error "unknown bitfield endianness"
 #endif
-	uint8_t dest[ETH_ALEN];
-	uint8_t orig[ETH_ALEN];
-	__be16  seqno;
-	__be16  total_size;
+	u8     dest[ETH_ALEN];
+	u8     orig[ETH_ALEN];
+	__be16 seqno;
+	__be16 total_size;
 };
 
 /**
@@ -398,12 +398,12 @@ struct batadv_frag_packet {
  * @orig: originator of the broadcast packet
  */
 struct batadv_bcast_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
-	uint8_t  reserved;
-	__be32   seqno;
-	uint8_t  orig[ETH_ALEN];
+	u8     packet_type;
+	u8     version;  /* batman version field */
+	u8     ttl;
+	u8     reserved;
+	__be32 seqno;
+	u8     orig[ETH_ALEN];
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
@@ -428,21 +428,21 @@ struct batadv_bcast_packet {
  * @coded_len: length of network coded part of the payload
  */
 struct batadv_coded_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
-	uint8_t  first_ttvn;
-	/* uint8_t  first_dest[ETH_ALEN]; - saved in mac header destination */
-	uint8_t  first_source[ETH_ALEN];
-	uint8_t  first_orig_dest[ETH_ALEN];
-	__be32   first_crc;
-	uint8_t  second_ttl;
-	uint8_t  second_ttvn;
-	uint8_t  second_dest[ETH_ALEN];
-	uint8_t  second_source[ETH_ALEN];
-	uint8_t  second_orig_dest[ETH_ALEN];
-	__be32   second_crc;
-	__be16   coded_len;
+	u8     packet_type;
+	u8     version;  /* batman version field */
+	u8     ttl;
+	u8     first_ttvn;
+	/* u8  first_dest[ETH_ALEN]; - saved in mac header destination */
+	u8     first_source[ETH_ALEN];
+	u8     first_orig_dest[ETH_ALEN];
+	__be32 first_crc;
+	u8     second_ttl;
+	u8     second_ttvn;
+	u8     second_dest[ETH_ALEN];
+	u8     second_source[ETH_ALEN];
+	u8     second_orig_dest[ETH_ALEN];
+	__be32 second_crc;
+	__be16 coded_len;
 };
 
 #pragma pack()
@@ -459,14 +459,14 @@ struct batadv_coded_packet {
  * @align: 2 bytes to align the header to a 4 byte boundary
  */
 struct batadv_unicast_tvlv_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
-	uint8_t  reserved;
-	uint8_t  dst[ETH_ALEN];
-	uint8_t  src[ETH_ALEN];
-	__be16   tvlv_len;
-	uint16_t align;
+	u8     packet_type;
+	u8     version;  /* batman version field */
+	u8     ttl;
+	u8     reserved;
+	u8     dst[ETH_ALEN];
+	u8     src[ETH_ALEN];
+	__be16 tvlv_len;
+	u16    align;
 };
 
 /**
@@ -476,9 +476,9 @@ struct batadv_unicast_tvlv_packet {
  * @len: tvlv container length
  */
 struct batadv_tvlv_hdr {
-	uint8_t type;
-	uint8_t version;
-	__be16  len;
+	u8     type;
+	u8     version;
+	__be16 len;
 };
 
 /**
@@ -500,9 +500,9 @@ struct batadv_tvlv_gateway_data {
  *  one batadv_tvlv_tt_vlan_data object per announced vlan
  */
 struct batadv_tvlv_tt_data {
-	uint8_t flags;
-	uint8_t ttvn;
-	__be16  num_vlan;
+	u8     flags;
+	u8     ttvn;
+	__be16 num_vlan;
 };
 
 /**
@@ -513,9 +513,9 @@ struct batadv_tvlv_tt_data {
  * @reserved: unused, useful for alignment purposes
  */
 struct batadv_tvlv_tt_vlan_data {
-	__be32	crc;
-	__be16	vid;
-	uint16_t reserved;
+	__be32 crc;
+	__be16 vid;
+	u16    reserved;
 };
 
 /**
@@ -527,9 +527,9 @@ struct batadv_tvlv_tt_vlan_data {
  * @vid: VLAN identifier
  */
 struct batadv_tvlv_tt_change {
-	uint8_t flags;
-	uint8_t reserved[3];
-	uint8_t addr[ETH_ALEN];
+	u8     flags;
+	u8     reserved[3];
+	u8     addr[ETH_ALEN];
 	__be16 vid;
 };
 
@@ -539,7 +539,7 @@ struct batadv_tvlv_tt_change {
  * @vid: VLAN identifier
  */
 struct batadv_tvlv_roam_adv {
-	uint8_t  client[ETH_ALEN];
+	u8     client[ETH_ALEN];
 	__be16 vid;
 };
 
@@ -549,8 +549,8 @@ struct batadv_tvlv_roam_adv {
  * @reserved: reserved field
  */
 struct batadv_tvlv_mcast_data {
-	uint8_t	flags;
-	uint8_t reserved[3];
+	u8 flags;
+	u8 reserved[3];
 };
 
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
-- 
2.1.4

