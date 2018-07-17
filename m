Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jul 2018 17:26:43 +0200
Message-Id: <20180717152649.32282-2-sw@simonwunderlich.de>
In-Reply-To: <20180717152649.32282-1-sw@simonwunderlich.de>
References: <20180717152649.32282-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: Drop "experimental" from
 BATMAN_V Kconfig
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

The Kconfig option BATMAN_ADV_BATMAN_V is now enabled by default when the
BATMAN_ADV is enabled. A feature which is enabled by default for a module
should not be considered experimental.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index de8034d80623..98c7f3820d53 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -33,7 +33,7 @@ config BATMAN_ADV
           tools.
 
 config BATMAN_ADV_BATMAN_V
-	bool "B.A.T.M.A.N. V protocol (experimental)"
+	bool "B.A.T.M.A.N. V protocol"
 	depends on BATMAN_ADV && !(CFG80211=m && BATMAN_ADV=y)
 	default y
 	help
-- 
2.11.0

