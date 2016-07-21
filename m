Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 22 Jul 2016 01:30:11 +0200
Message-Id: <1469143811-15498-3-git-send-email-sven@narfation.org>
In-Reply-To: <1469143811-15498-1-git-send-email-sven@narfation.org>
References: <1469143811-15498-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused
	batadv_icmp_user_cmd_type
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
 net/batman-adv/packet.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 6afc0b8..d2e9bbd 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -252,16 +252,6 @@ struct batadv_elp_packet {
 #define BATADV_ELP_HLEN sizeof(struct batadv_elp_packet)
 
 /**
- * enum batadv_icmp_user_cmd_type - types for batman-adv icmp cmd modes
- * @BATADV_TP_START: start a throughput meter run
- * @BATADV_TP_STOP: stop a throughput meter run
- */
-enum batadv_icmp_user_cmd_type {
-	BATADV_TP_START		= 0,
-	BATADV_TP_STOP		= 2,
-};
-
-/**
  * struct batadv_icmp_header - common members among all the ICMP packets
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
