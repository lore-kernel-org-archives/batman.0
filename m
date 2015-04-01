Return-Path: <alex.suykov@gmail.com>
Date: Wed, 1 Apr 2015 20:32:19 +0300
From: Alex Suykov <alex.suykov@gmail.com>
Message-ID: <20150401173219.GA21473@vostro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] batctl: musl build fixes
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

musl does not allow including netinet/* and linux/* headers together.
batctl includes netinet/if_ether.h indirectly via net/ethernet.h,
so netinet/if_ether.h must be used instead of linux/if_ether.h.

__be16 and __be32 are linux-specific typedefs for uint16_t and
uint32_t with __attribute__((bitwise)) that has no effect
outside of the kernel. Replacing them with uint16_t and uint32_t
removes dependency on linux/types.h.

Signed-off-by: Alex Suykov <alex.suykov@gmail.com>
---
batctl fails to build with musl, mostly because of somewhat weird
netinet/*.h headers musl provides, but the problem turns out
to be easy to fix.

Please disregard the first patch, that was against batctl-2014.4.0
and this one is against current git master.

 packet.h     | 40 ++++++++++++++++++++--------------------
 ping.c       |  2 +-
 tcpdump.h    |  2 +-
 traceroute.c |  2 +-
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/packet.h b/packet.h
index b81fbbf..1c2ead3 100644
--- a/packet.h
+++ b/packet.h
@@ -196,7 +196,7 @@ enum batadv_tvlv_type {
 struct batadv_bla_claim_dst {
 	uint8_t magic[3];	/* FF:43:05 */
 	uint8_t type;		/* bla_claimframe */
-	__be16 group;		/* group id */
+	uint16_t group;		/* group id */
 };
 
 #pragma pack()
@@ -214,12 +214,12 @@ struct batadv_ogm_packet {
 	uint8_t  version;
 	uint8_t  ttl;
 	uint8_t  flags;
-	__be32   seqno;
+	uint32_t   seqno;
 	uint8_t  orig[ETH_ALEN];
 	uint8_t  prev_sender[ETH_ALEN];
 	uint8_t  reserved;
 	uint8_t  tq;
-	__be16   tvlv_len;
+	uint16_t   tvlv_len;
 	/* __packed is not needed as the struct size is divisible by 4,
 	 * and the largest data type in this struct has a size of 4.
 	 */
@@ -274,7 +274,7 @@ struct batadv_icmp_packet {
 	uint8_t  orig[ETH_ALEN];
 	uint8_t  uid;
 	uint8_t  reserved;
-	__be16   seqno;
+	uint16_t seqno;
 };
 
 #define BATADV_RR_LEN 16
@@ -301,7 +301,7 @@ struct batadv_icmp_packet_rr {
 	uint8_t  orig[ETH_ALEN];
 	uint8_t  uid;
 	uint8_t  rr_cur;
-	__be16   seqno;
+	uint16_t seqno;
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 };
 
@@ -381,8 +381,8 @@ struct batadv_frag_packet {
 #endif
 	uint8_t dest[ETH_ALEN];
 	uint8_t orig[ETH_ALEN];
-	__be16  seqno;
-	__be16  total_size;
+	uint16_t seqno;
+	uint16_t total_size;
 };
 
 /**
@@ -399,7 +399,7 @@ struct batadv_bcast_packet {
 	uint8_t  version;  /* batman version field */
 	uint8_t  ttl;
 	uint8_t  reserved;
-	__be32   seqno;
+	uint32_t seqno;
 	uint8_t  orig[ETH_ALEN];
 	/* "4 bytes boundary + 2 bytes" long to make the payload after the
 	 * following ethernet header again 4 bytes boundary aligned
@@ -432,14 +432,14 @@ struct batadv_coded_packet {
 	/* uint8_t  first_dest[ETH_ALEN]; - saved in mac header destination */
 	uint8_t  first_source[ETH_ALEN];
 	uint8_t  first_orig_dest[ETH_ALEN];
-	__be32   first_crc;
+	uint32_t first_crc;
 	uint8_t  second_ttl;
 	uint8_t  second_ttvn;
 	uint8_t  second_dest[ETH_ALEN];
 	uint8_t  second_source[ETH_ALEN];
 	uint8_t  second_orig_dest[ETH_ALEN];
-	__be32   second_crc;
-	__be16   coded_len;
+	uint32_t second_crc;
+	uint16_t coded_len;
 };
 
 #pragma pack()
@@ -462,7 +462,7 @@ struct batadv_unicast_tvlv_packet {
 	uint8_t  reserved;
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  src[ETH_ALEN];
-	__be16   tvlv_len;
+	uint16_t tvlv_len;
 	uint16_t align;
 };
 
@@ -475,7 +475,7 @@ struct batadv_unicast_tvlv_packet {
 struct batadv_tvlv_hdr {
 	uint8_t type;
 	uint8_t version;
-	__be16  len;
+	uint16_t len;
 };
 
 /**
@@ -485,8 +485,8 @@ struct batadv_tvlv_hdr {
  * @bandwidth_up: advertised uplink upload bandwidth
  */
 struct batadv_tvlv_gateway_data {
-	__be32 bandwidth_down;
-	__be32 bandwidth_up;
+	uint32_t bandwidth_down;
+	uint32_t bandwidth_up;
 };
 
 /**
@@ -499,7 +499,7 @@ struct batadv_tvlv_gateway_data {
 struct batadv_tvlv_tt_data {
 	uint8_t flags;
 	uint8_t ttvn;
-	__be16  num_vlan;
+	uint16_t num_vlan;
 };
 
 /**
@@ -510,8 +510,8 @@ struct batadv_tvlv_tt_data {
  * @reserved: unused, useful for alignment purposes
  */
 struct batadv_tvlv_tt_vlan_data {
-	__be32	crc;
-	__be16	vid;
+	uint32_t crc;
+	uint16_t vid;
 	uint16_t reserved;
 };
 
@@ -527,7 +527,7 @@ struct batadv_tvlv_tt_change {
 	uint8_t flags;
 	uint8_t reserved[3];
 	uint8_t addr[ETH_ALEN];
-	__be16 vid;
+	uint16_t vid;
 };
 
 /**
@@ -537,7 +537,7 @@ struct batadv_tvlv_tt_change {
  */
 struct batadv_tvlv_roam_adv {
 	uint8_t  client[ETH_ALEN];
-	__be16 vid;
+	uint16_t vid;
 };
 
 /**
diff --git a/ping.c b/ping.c
index bdca222..7880a82 100644
--- a/ping.c
+++ b/ping.c
@@ -34,7 +34,7 @@
 #include <stdint.h>
 #include <sys/select.h>
 #include <sys/time.h>
-#include <linux/if_ether.h>
+#include <netinet/if_ether.h>
 
 #include "main.h"
 #include "ping.h"
diff --git a/tcpdump.h b/tcpdump.h
index 5d936f2..3c9126c 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -23,7 +23,7 @@
 #define _BATCTL_TCPDUMP_H
 
 #include <netpacket/packet.h>
-#include <linux/if_ether.h>
+#include <netinet/if_ether.h>
 #include <net/if_arp.h>
 #include <sys/types.h>
 #include "main.h"
diff --git a/traceroute.c b/traceroute.c
index 4ebfec2..c5af1e0 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -28,7 +28,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <linux/if_ether.h>
+#include <netinet/if_ether.h>
 #include <stddef.h>
 #include <sys/select.h>
 #include <sys/time.h>
-- 
2.0.3

