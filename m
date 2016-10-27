Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 27 Oct 2016 21:01:41 +0200
Message-Id: <20161027190150.7880-9-sw@simonwunderlich.de>
In-Reply-To: <20161027190150.7880-1-sw@simonwunderlich.de>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/17] batman-adv: Remove unused
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
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
-- 
2.10.1

