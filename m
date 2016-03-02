Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  2 Mar 2016 21:45:56 +0100
Message-Id: <1456951556-27662-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: clarify CFG80211 dependency
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

From: Arnd Bergmann <arnd@arndb.de>

The driver calls cfg80211_get_station, which may be part of a
module, so we must not enable BATMAN_ADV_BATMAN_V if
BATMAN_ADV=y and CFG80211=m:

net/built-in.o: In function `batadv_v_elp_get_throughput':
(text+0x5c62c): undefined reference to `cfg80211_get_station'

This clarifies the dependency to cover all combinations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 2e0a2972e354 ("batman-adv: Depend on CFG80211 for BATMAN_V")
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Submitted for out-of-tree module with adjusted "Fixes" line. The
upstream commit is fb653ebddcf871e8a83a63c1e4e73d41bc3cf599

 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index e651dc9..f66930e 100644
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

