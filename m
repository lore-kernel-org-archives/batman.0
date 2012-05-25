Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 May 2012 08:55:55 +0200
Message-Id: <1337928955-20454-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Use batctl indentation of
	bat_packettype
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The style of the indentation was changed in
206af118414355e867e725ea83bc3a2989db5a40

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 packet.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/packet.h b/packet.h
index 205879e..c90219c 100644
--- a/packet.h
+++ b/packet.h
@@ -23,14 +23,14 @@
 #define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
 
 enum bat_packettype {
-	BAT_IV_OGM       = 0x01,
-	BAT_ICMP         = 0x02,
-	BAT_UNICAST      = 0x03,
-	BAT_BCAST        = 0x04,
-	BAT_VIS          = 0x05,
+	BAT_IV_OGM	 = 0x01,
+	BAT_ICMP	 = 0x02,
+	BAT_UNICAST	 = 0x03,
+	BAT_BCAST	 = 0x04,
+	BAT_VIS		 = 0x05,
 	BAT_UNICAST_FRAG = 0x06,
-	BAT_TT_QUERY     = 0x07,
-	BAT_ROAM_ADV     = 0x08
+	BAT_TT_QUERY	 = 0x07,
+	BAT_ROAM_ADV	 = 0x08
 };
 
 /* this file is included by batctl which needs these defines */
-- 
1.7.10

