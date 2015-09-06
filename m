Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Sep 2015 21:38:49 +0200
Message-Id: <1441568333-15947-6-git-send-email-sven@narfation.org>
In-Reply-To: <1441568333-15947-1-git-send-email-sven@narfation.org>
References: <1441568333-15947-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/9] batman-adv: Fix kerneldoc parsing of
	structs/enums
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
 net/batman-adv/multicast.h | 2 +-
 net/batman-adv/packet.h    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 8f3cb04..685219f 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -23,7 +23,7 @@
 struct sk_buff;
 
 /**
- * batadv_forw_mode - the way a packet should be forwarded as
+ * enum batadv_forw_mode - the way a packet should be forwarded as
  * @BATADV_FORW_ALL: forward the packet to all nodes (currently via classic
  *  flooding)
  * @BATADV_FORW_SINGLE: forward the packet to a single node (currently via the
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 11f996b..c5973a1 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -159,7 +159,7 @@ enum batadv_tt_client_flags {
 };
 
 /**
- * batadv_vlan_flags - flags for the four MSB of any vlan ID field
+ * enum batadv_vlan_flags - flags for the four MSB of any vlan ID field
  * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
  */
 enum batadv_vlan_flags {
@@ -231,7 +231,7 @@ struct batadv_ogm_packet {
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
 /**
- * batadv_icmp_header - common members among all the ICMP packets
+ * struct batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
@@ -257,7 +257,7 @@ struct batadv_icmp_header {
 };
 
 /**
- * batadv_icmp_packet - ICMP packet
+ * struct batadv_icmp_packet - ICMP packet
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
@@ -283,7 +283,7 @@ struct batadv_icmp_packet {
 #define BATADV_RR_LEN 16
 
 /**
- * batadv_icmp_packet_rr - ICMP RouteRecord packet
+ * struct batadv_icmp_packet_rr - ICMP RouteRecord packet
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
-- 
2.5.1

