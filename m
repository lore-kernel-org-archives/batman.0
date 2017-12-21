Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 21 Dec 2017 10:17:40 +0100
Message-Id: <20171221091742.8020-4-sven.eckelmann@openmesh.com>
In-Reply-To: <20171221091742.8020-1-sven.eckelmann@openmesh.com>
References: <20171221091742.8020-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH v4 3/5] batman-adv: Remove kernel fixed width
 types in packet.h
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
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Tom Herbert <tom@herbertland.com>, Jiri Pirko <jiri@mellanox.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Sven Eckelmann <sven.eckelmann@openmesh.com>

The uapi headers use the __u8/__u16/... version of the fixed width types
instead of u8/u16/... The use of the latter must be avoided before
packet.h is copied to include/uapi/linux/.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 net/batman-adv/packet.h | 214 ++++++++++++++++++++++++------------------------
 1 file changed, 107 insertions(+), 107 deletions(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 44f20d03205b..3b2d2db993aa 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -29,7 +29,7 @@
  *
  * Return: 0 when not error was detected, != 0 otherwise
  */
-#define batadv_tp_is_error(n) ((u8)(n) > 127 ? 1 : 0)
+#define batadv_tp_is_error(n) ((__u8)(n) > 127 ? 1 : 0)
 
 /**
  * enum batadv_packettype - types for batman-adv encapsulated packets
@@ -191,8 +191,8 @@ enum batadv_tvlv_type {
  * transport the claim type and the group id
  */
 struct batadv_bla_claim_dst {
-	u8     magic[3];	/* FF:43:05 */
-	u8     type;		/* bla_claimframe */
+	__u8   magic[3];	/* FF:43:05 */
+	__u8   type;		/* bla_claimframe */
 	__be16 group;		/* group id */
 };
 
@@ -212,15 +212,15 @@ struct batadv_bla_claim_dst {
  * @tvlv_len: length of tvlv data following the ogm header
  */
 struct batadv_ogm_packet {
-	u8     packet_type;
-	u8     version;
-	u8     ttl;
-	u8     flags;
+	__u8   packet_type;
+	__u8   version;
+	__u8   ttl;
+	__u8   flags;
 	__be32 seqno;
-	u8     orig[ETH_ALEN];
-	u8     prev_sender[ETH_ALEN];
-	u8     reserved;
-	u8     tq;
+	__u8   orig[ETH_ALEN];
+	__u8   prev_sender[ETH_ALEN];
+	__u8   reserved;
+	__u8   tq;
 	__be16 tvlv_len;
 	/* __packed is not needed as the struct size is divisible by 4,
 	 * and the largest data type in this struct has a size of 4.
@@ -241,12 +241,12 @@ struct batadv_ogm_packet {
  * @throughput: the currently flooded path throughput
  */
 struct batadv_ogm2_packet {
-	u8     packet_type;
-	u8     version;
-	u8     ttl;
-	u8     flags;
+	__u8   packet_type;
+	__u8   version;
+	__u8   ttl;
+	__u8   flags;
 	__be32 seqno;
-	u8     orig[ETH_ALEN];
+	__u8   orig[ETH_ALEN];
 	__be16 tvlv_len;
 	__be32 throughput;
 	/* __packed is not needed as the struct size is divisible by 4,
@@ -265,9 +265,9 @@ struct batadv_ogm2_packet {
  * @elp_interval: currently used ELP sending interval in ms
  */
 struct batadv_elp_packet {
-	u8     packet_type;
-	u8     version;
-	u8     orig[ETH_ALEN];
+	__u8   packet_type;
+	__u8   version;
+	__u8   orig[ETH_ALEN];
 	__be32 seqno;
 	__be32 elp_interval;
 };
@@ -290,14 +290,14 @@ struct batadv_elp_packet {
  * members are padded the same way as they are in real packets.
  */
 struct batadv_icmp_header {
-	u8 packet_type;
-	u8 version;
-	u8 ttl;
-	u8 msg_type; /* see ICMP message types above */
-	u8 dst[ETH_ALEN];
-	u8 orig[ETH_ALEN];
-	u8 uid;
-	u8 align[3];
+	__u8 packet_type;
+	__u8 version;
+	__u8 ttl;
+	__u8 msg_type; /* see ICMP message types above */
+	__u8 dst[ETH_ALEN];
+	__u8 orig[ETH_ALEN];
+	__u8 uid;
+	__u8 align[3];
 };
 
 /**
@@ -313,14 +313,14 @@ struct batadv_icmp_header {
  * @seqno: ICMP sequence number
  */
 struct batadv_icmp_packet {
-	u8     packet_type;
-	u8     version;
-	u8     ttl;
-	u8     msg_type; /* see ICMP message types above */
-	u8     dst[ETH_ALEN];
-	u8     orig[ETH_ALEN];
-	u8     uid;
-	u8     reserved;
+	__u8   packet_type;
+	__u8   version;
+	__u8   ttl;
+	__u8   msg_type; /* see ICMP message types above */
+	__u8   dst[ETH_ALEN];
+	__u8   orig[ETH_ALEN];
+	__u8   uid;
+	__u8   reserved;
 	__be16 seqno;
 };
 
@@ -342,15 +342,15 @@ struct batadv_icmp_packet {
  *  store it using network order
  */
 struct batadv_icmp_tp_packet {
-	u8  packet_type;
-	u8  version;
-	u8  ttl;
-	u8  msg_type; /* see ICMP message types above */
-	u8  dst[ETH_ALEN];
-	u8  orig[ETH_ALEN];
-	u8  uid;
-	u8  subtype;
-	u8  session[2];
+	__u8   packet_type;
+	__u8   version;
+	__u8   ttl;
+	__u8   msg_type; /* see ICMP message types above */
+	__u8   dst[ETH_ALEN];
+	__u8   orig[ETH_ALEN];
+	__u8   uid;
+	__u8   subtype;
+	__u8   session[2];
 	__be32 seqno;
 	__be32 timestamp;
 };
@@ -381,16 +381,16 @@ enum batadv_icmp_tp_subtype {
  * @rr: route record array
  */
 struct batadv_icmp_packet_rr {
-	u8     packet_type;
-	u8     version;
-	u8     ttl;
-	u8     msg_type; /* see ICMP message types above */
-	u8     dst[ETH_ALEN];
-	u8     orig[ETH_ALEN];
-	u8     uid;
-	u8     rr_cur;
+	__u8   packet_type;
+	__u8   version;
+	__u8   ttl;
+	__u8   msg_type; /* see ICMP message types above */
+	__u8   dst[ETH_ALEN];
+	__u8   orig[ETH_ALEN];
+	__u8   uid;
+	__u8   rr_cur;
 	__be16 seqno;
-	u8     rr[BATADV_RR_LEN][ETH_ALEN];
+	__u8   rr[BATADV_RR_LEN][ETH_ALEN];
 };
 
 #define BATADV_ICMP_MAX_PACKET_SIZE	sizeof(struct batadv_icmp_packet_rr)
@@ -416,11 +416,11 @@ struct batadv_icmp_packet_rr {
  * @dest: originator destination of the unicast packet
  */
 struct batadv_unicast_packet {
-	u8 packet_type;
-	u8 version;
-	u8 ttl;
-	u8 ttvn; /* destination translation table version number */
-	u8 dest[ETH_ALEN];
+	__u8 packet_type;
+	__u8 version;
+	__u8 ttl;
+	__u8 ttvn; /* destination translation table version number */
+	__u8 dest[ETH_ALEN];
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
@@ -435,9 +435,9 @@ struct batadv_unicast_packet {
  */
 struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
-	u8 src[ETH_ALEN];
-	u8 subtype;
-	u8 reserved;
+	__u8 src[ETH_ALEN];
+	__u8 subtype;
+	__u8 reserved;
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
@@ -457,22 +457,22 @@ struct batadv_unicast_4addr_packet {
  * @total_size: size of the merged packet
  */
 struct batadv_frag_packet {
-	u8     packet_type;
-	u8     version;  /* batman version field */
-	u8     ttl;
+	__u8   packet_type;
+	__u8   version;  /* batman version field */
+	__u8   ttl;
 #if defined(__BIG_ENDIAN_BITFIELD)
-	u8     no:4;
-	u8     priority:3;
-	u8     reserved:1;
+	__u8   no:4;
+	__u8   priority:3;
+	__u8   reserved:1;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	u8     reserved:1;
-	u8     priority:3;
-	u8     no:4;
+	__u8   reserved:1;
+	__u8   priority:3;
+	__u8   no:4;
 #else
 #error "unknown bitfield endianness"
 #endif
-	u8     dest[ETH_ALEN];
-	u8     orig[ETH_ALEN];
+	__u8   dest[ETH_ALEN];
+	__u8   orig[ETH_ALEN];
 	__be16 seqno;
 	__be16 total_size;
 };
@@ -487,12 +487,12 @@ struct batadv_frag_packet {
  * @orig: originator of the broadcast packet
  */
 struct batadv_bcast_packet {
-	u8     packet_type;
-	u8     version;  /* batman version field */
-	u8     ttl;
-	u8     reserved;
+	__u8   packet_type;
+	__u8   version;  /* batman version field */
+	__u8   ttl;
+	__u8   reserved;
 	__be32 seqno;
-	u8     orig[ETH_ALEN];
+	__u8   orig[ETH_ALEN];
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
 	 */
@@ -516,19 +516,19 @@ struct batadv_bcast_packet {
  * @coded_len: length of network coded part of the payload
  */
 struct batadv_coded_packet {
-	u8     packet_type;
-	u8     version;  /* batman version field */
-	u8     ttl;
-	u8     first_ttvn;
-	/* u8  first_dest[ETH_ALEN]; - saved in mac header destination */
-	u8     first_source[ETH_ALEN];
-	u8     first_orig_dest[ETH_ALEN];
+	__u8   packet_type;
+	__u8   version;  /* batman version field */
+	__u8   ttl;
+	__u8   first_ttvn;
+	/* __u8 first_dest[ETH_ALEN]; - saved in mac header destination */
+	__u8   first_source[ETH_ALEN];
+	__u8   first_orig_dest[ETH_ALEN];
 	__be32 first_crc;
-	u8     second_ttl;
-	u8     second_ttvn;
-	u8     second_dest[ETH_ALEN];
-	u8     second_source[ETH_ALEN];
-	u8     second_orig_dest[ETH_ALEN];
+	__u8   second_ttl;
+	__u8   second_ttvn;
+	__u8   second_dest[ETH_ALEN];
+	__u8   second_source[ETH_ALEN];
+	__u8   second_orig_dest[ETH_ALEN];
 	__be32 second_crc;
 	__be16 coded_len;
 };
@@ -547,14 +547,14 @@ struct batadv_coded_packet {
  * @align: 2 bytes to align the header to a 4 byte boundary
  */
 struct batadv_unicast_tvlv_packet {
-	u8     packet_type;
-	u8     version;  /* batman version field */
-	u8     ttl;
-	u8     reserved;
-	u8     dst[ETH_ALEN];
-	u8     src[ETH_ALEN];
+	__u8   packet_type;
+	__u8   version;  /* batman version field */
+	__u8   ttl;
+	__u8   reserved;
+	__u8   dst[ETH_ALEN];
+	__u8   src[ETH_ALEN];
 	__be16 tvlv_len;
-	u16    align;
+	__u16  align;
 };
 
 /**
@@ -564,8 +564,8 @@ struct batadv_unicast_tvlv_packet {
  * @len: tvlv container length
  */
 struct batadv_tvlv_hdr {
-	u8     type;
-	u8     version;
+	__u8   type;
+	__u8   version;
 	__be16 len;
 };
 
@@ -588,8 +588,8 @@ struct batadv_tvlv_gateway_data {
  *  one batadv_tvlv_tt_vlan_data object per announced vlan
  */
 struct batadv_tvlv_tt_data {
-	u8     flags;
-	u8     ttvn;
+	__u8   flags;
+	__u8   ttvn;
 	__be16 num_vlan;
 };
 
@@ -603,7 +603,7 @@ struct batadv_tvlv_tt_data {
 struct batadv_tvlv_tt_vlan_data {
 	__be32 crc;
 	__be16 vid;
-	u16    reserved;
+	__u16  reserved;
 };
 
 /**
@@ -615,9 +615,9 @@ struct batadv_tvlv_tt_vlan_data {
  * @vid: VLAN identifier
  */
 struct batadv_tvlv_tt_change {
-	u8     flags;
-	u8     reserved[3];
-	u8     addr[ETH_ALEN];
+	__u8   flags;
+	__u8   reserved[3];
+	__u8   addr[ETH_ALEN];
 	__be16 vid;
 };
 
@@ -627,7 +627,7 @@ struct batadv_tvlv_tt_change {
  * @vid: VLAN identifier
  */
 struct batadv_tvlv_roam_adv {
-	u8     client[ETH_ALEN];
+	__u8   client[ETH_ALEN];
 	__be16 vid;
 };
 
@@ -637,8 +637,8 @@ struct batadv_tvlv_roam_adv {
  * @reserved: reserved field
  */
 struct batadv_tvlv_mcast_data {
-	u8 flags;
-	u8 reserved[3];
+	__u8 flags;
+	__u8 reserved[3];
 };
 
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
-- 
2.11.0

