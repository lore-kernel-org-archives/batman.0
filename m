Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Fri, 15 Dec 2017 19:23:11 +0100
Message-Id: <20171215182313.15767-3-sven.eckelmann@openmesh.com>
In-Reply-To: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
References: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v3 2/4] batman-adv: Remove usage of BIT(x) in
 packet.h
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Tom Herbert <tom@herbertland.com>, Sven Eckelmann <sven.eckelmann@openmesh.com>

The BIT(x) macro is no longer available for uapi headers because it is
defined outside of it (linux/bitops.h). The use of it must therefore be
avoided and replaced by an appropriate other representation.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 net/batman-adv/packet.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 6b6563867455..44f20d03205b 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -20,7 +20,6 @@
 #define _NET_BATMAN_ADV_PACKET_H_
 
 #include <asm/byteorder.h>
-#include <linux/bitops.h>
 #include <linux/if_ether.h>
 #include <linux/types.h>
 
@@ -92,9 +91,9 @@ enum batadv_subtype {
  *     one hop neighbor on the interface where it was originally received.
  */
 enum batadv_iv_flags {
-	BATADV_NOT_BEST_NEXT_HOP   = BIT(0),
-	BATADV_PRIMARIES_FIRST_HOP = BIT(1),
-	BATADV_DIRECTLINK          = BIT(2),
+	BATADV_NOT_BEST_NEXT_HOP   = 1UL << 0,
+	BATADV_PRIMARIES_FIRST_HOP = 1UL << 1,
+	BATADV_DIRECTLINK          = 1UL << 2,
 };
 
 /**
@@ -123,9 +122,9 @@ enum batadv_icmp_packettype {
  * @BATADV_MCAST_WANT_ALL_IPV6: we want all IPv6 multicast packets
  */
 enum batadv_mcast_flags {
-	BATADV_MCAST_WANT_ALL_UNSNOOPABLES	= BIT(0),
-	BATADV_MCAST_WANT_ALL_IPV4		= BIT(1),
-	BATADV_MCAST_WANT_ALL_IPV6		= BIT(2),
+	BATADV_MCAST_WANT_ALL_UNSNOOPABLES	= 1UL << 0,
+	BATADV_MCAST_WANT_ALL_IPV4		= 1UL << 1,
+	BATADV_MCAST_WANT_ALL_IPV6		= 1UL << 2,
 };
 
 /* tt data subtypes */
@@ -139,10 +138,10 @@ enum batadv_mcast_flags {
  * @BATADV_TT_FULL_TABLE: contains full table to replace existing table
  */
 enum batadv_tt_data_flags {
-	BATADV_TT_OGM_DIFF   = BIT(0),
-	BATADV_TT_REQUEST    = BIT(1),
-	BATADV_TT_RESPONSE   = BIT(2),
-	BATADV_TT_FULL_TABLE = BIT(4),
+	BATADV_TT_OGM_DIFF   = 1UL << 0,
+	BATADV_TT_REQUEST    = 1UL << 1,
+	BATADV_TT_RESPONSE   = 1UL << 2,
+	BATADV_TT_FULL_TABLE = 1UL << 4,
 };
 
 /**
@@ -150,7 +149,7 @@ enum batadv_tt_data_flags {
  * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
  */
 enum batadv_vlan_flags {
-	BATADV_VLAN_HAS_TAG	= BIT(15),
+	BATADV_VLAN_HAS_TAG	= 1UL << 15,
 };
 
 /**
-- 
2.11.0

