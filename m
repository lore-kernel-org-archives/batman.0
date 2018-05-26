Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 26 May 2018 11:40:32 +0200
Message-Id: <20180526094032.10044-2-sven@narfation.org>
In-Reply-To: <20180526094032.10044-1-sven@narfation.org>
References: <20180526094032.10044-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Drop "experimental" from
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, sw@simonwunderlich.de, mareklindner@neomailbox.ch, joe@perches.com, sergei.shtylyov@cogentembedded.com, Sven Eckelmann <sven@narfation.org>

The Kconfig option BATMAN_ADV_BATMAN_V is now enabled by default when the
BATMAN_ADV is enabled. A feature which is enabled by default for a module
should not be considered experimental.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2: no change

 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 41bb67d70c83..da0b7aa98be9 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -32,7 +32,7 @@ config BATMAN_ADV
           tools.
 
 config BATMAN_ADV_BATMAN_V
-	bool "B.A.T.M.A.N. V protocol (experimental)"
+	bool "B.A.T.M.A.N. V protocol"
 	depends on BATMAN_ADV && !(CFG80211=m && BATMAN_ADV=y)
 	default y
 	help
-- 
2.17.0

