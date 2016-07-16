Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jul 2016 21:30:20 +0200
Message-Id: <1468697424-10701-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Add BATADV_DBG_TP_METER to
	BATADV_DBG_ALL
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

The BATADV_DBG_ALL has to contain the bit of BATADV_DBG_TP_METER to really
support all available debug messages.

Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/log.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index e0e1a88..d2905a8 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -63,7 +63,7 @@ enum batadv_dbg_level {
 	BATADV_DBG_NC		= BIT(5),
 	BATADV_DBG_MCAST	= BIT(6),
 	BATADV_DBG_TP_METER	= BIT(7),
-	BATADV_DBG_ALL		= 127,
+	BATADV_DBG_ALL		= 255,
 };
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-- 
2.8.1

