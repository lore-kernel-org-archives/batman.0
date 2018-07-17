Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jul 2018 17:26:44 +0200
Message-Id: <20180717152649.32282-3-sw@simonwunderlich.de>
In-Reply-To: <20180717152649.32282-1-sw@simonwunderlich.de>
References: <20180717152649.32282-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: enable DAT by default at
 compile time
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Antonio Quartulli <a@unstable.cc>

DAT (Distributed ARP Table) has been enabled by default
in the out-of-tree batman-adv kernel module for several
years already.
It can now be enabled in the kernel too.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 98c7f3820d53..ff38df8bab91 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -60,7 +60,7 @@ config BATMAN_ADV_BLA
 config BATMAN_ADV_DAT
 	bool "Distributed ARP Table"
 	depends on BATMAN_ADV && INET
-	default n
+	default y
 	help
 	  This option enables DAT (Distributed ARP Table), a DHT based
 	  mechanism that increases ARP reliability on sparse wireless
-- 
2.11.0

