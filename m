Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  2 Mar 2016 14:54:35 +0100
Message-Id: <1456926882-2941809-1-git-send-email-arnd@arndb.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: clarify CFG80211 dependency
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

The driver calls cfg80211_get_station, which may be part of a
module, so we must not enable BATMAN_ADV_BATMAN_V if
BATMAN_ADV=y and CFG80211=m:

net/built-in.o: In function `batadv_v_elp_get_throughput':
(text+0x5c62c): undefined reference to `cfg80211_get_station'

This clarifies the dependency to cover all combinations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c833484e5f38 ("batman-adv: ELP - compute the metric based on the estimated throughput")
---
 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index e651dc927bfd..f66930ee3c0b 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -17,7 +17,7 @@ config BATMAN_ADV
 
 config BATMAN_ADV_BATMAN_V
 	bool "B.A.T.M.A.N. V protocol (experimental)"
-	depends on BATMAN_ADV && CFG80211
+	depends on BATMAN_ADV && CFG80211=y || (CFG80211=m && BATMAN_ADV=m)
 	default n
 	help
 	  This option enables the B.A.T.M.A.N. V protocol, the successor
-- 
2.7.0

