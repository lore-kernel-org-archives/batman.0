Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 14:03:00 +0200
Message-Id: <20180524120300.15829-9-sw@simonwunderlich.de>
In-Reply-To: <20180524120300.15829-1-sw@simonwunderlich.de>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 8/8] batman-adv: enable B.A.T.M.A.N. V
 compilation by default
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index bee034a95208..de8034d80623 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -35,7 +35,7 @@ config BATMAN_ADV
 config BATMAN_ADV_BATMAN_V
 	bool "B.A.T.M.A.N. V protocol (experimental)"
 	depends on BATMAN_ADV && !(CFG80211=m && BATMAN_ADV=y)
-	default n
+	default y
 	help
 	  This option enables the B.A.T.M.A.N. V protocol, the successor
 	  of the currently used B.A.T.M.A.N. IV protocol. The main
-- 
2.11.0

