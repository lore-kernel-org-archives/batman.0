Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:17 +0100
Message-Id: <20171220110124.13117-13-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 12/19] batman-adv: Add missing kernel-doc to
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/packet.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 4eaf4b426726..dccbd4a6f019 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -22,6 +22,12 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 
+/**
+ * batadv_tp_is_error() - Check throughput meter return code for error
+ * @n: throughput meter return code
+ *
+ * Return: 0 when not error was detected, != 0 otherwise
+ */
 #define batadv_tp_is_error(n) ((u8)(n) > 127 ? 1 : 0)
 
 /**
@@ -89,7 +95,15 @@ enum batadv_iv_flags {
 	BATADV_DIRECTLINK          = BIT(2),
 };
 
-/* ICMP message types */
+/**
+ * enum batadv_icmp_packettype - ICMP message types
+ * @BATADV_ECHO_REPLY: success reply to BATADV_ECHO_REQUEST
+ * @BATADV_DESTINATION_UNREACHABLE: failure when route to destination not found
+ * @BATADV_ECHO_REQUEST: request BATADV_ECHO_REPLY from destination
+ * @BATADV_TTL_EXCEEDED: error after BATADV_ECHO_REQUEST traversed too many hops
+ * @BATADV_PARAMETER_PROBLEM: return code for malformed messages
+ * @BATADV_TP: throughput meter packet
+ */
 enum batadv_icmp_packettype {
 	BATADV_ECHO_REPLY	       = 0,
 	BATADV_DESTINATION_UNREACHABLE = 3,
@@ -137,7 +151,14 @@ enum batadv_vlan_flags {
 	BATADV_VLAN_HAS_TAG	= BIT(15),
 };
 
-/* claim frame types for the bridge loop avoidance */
+/**
+ * enum batadv_bla_claimframe - claim frame types for the bridge loop avoidance
+ * @BATADV_CLAIM_TYPE_CLAIM: claim of a client mac address
+ * @BATADV_CLAIM_TYPE_UNCLAIM: unclaim of a client mac address
+ * @BATADV_CLAIM_TYPE_ANNOUNCE: announcement of backbone with current crc
+ * @BATADV_CLAIM_TYPE_REQUEST: request of full claim table
+ * @BATADV_CLAIM_TYPE_LOOPDETECT: mesh-traversing loop detect packet
+ */
 enum batadv_bla_claimframe {
 	BATADV_CLAIM_TYPE_CLAIM		= 0x00,
 	BATADV_CLAIM_TYPE_UNCLAIM	= 0x01,
-- 
2.11.0

