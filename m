Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  2 Dec 2017 19:51:46 +0100
Message-Id: <20171202185153.552-2-sven@narfation.org>
In-Reply-To: <20171202185153.552-1-sven@narfation.org>
References: <20171202185153.552-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Add missing kernel-doc to
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
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/packet.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 8e8a5db1..bf98cb5f 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -21,6 +21,12 @@
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
@@ -88,7 +94,15 @@ enum batadv_iv_flags {
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
@@ -136,7 +150,14 @@ enum batadv_vlan_flags {
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

