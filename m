Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 26 May 2018 11:40:31 +0200
Message-Id: <20180526094032.10044-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: Remove "default n" in
 Kconfig
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

The "default n" is the default value for any bool or tristate Kconfig
setting. It is therefore not necessary to add it to a config entry.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2: changed "the an config entry" to "a config entry" in commit message

 net/batman-adv/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index de8034d80623..41bb67d70c83 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -24,7 +24,6 @@ config BATMAN_ADV
 	depends on NET
 	select CRC16
 	select LIBCRC32C
-        default n
 	help
           B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
           a routing protocol for multi-hop ad-hoc mesh networks. The
@@ -60,7 +59,6 @@ config BATMAN_ADV_BLA
 config BATMAN_ADV_DAT
 	bool "Distributed ARP Table"
 	depends on BATMAN_ADV && INET
-	default n
 	help
 	  This option enables DAT (Distributed ARP Table), a DHT based
 	  mechanism that increases ARP reliability on sparse wireless
@@ -70,7 +68,6 @@ config BATMAN_ADV_DAT
 config BATMAN_ADV_NC
 	bool "Network Coding"
 	depends on BATMAN_ADV
-	default n
 	help
 	  This option enables network coding, a mechanism that aims to
 	  increase the overall network throughput by fusing multiple
@@ -84,7 +81,6 @@ config BATMAN_ADV_NC
 config BATMAN_ADV_MCAST
 	bool "Multicast optimisation"
 	depends on BATMAN_ADV && INET && !(BRIDGE=m && BATMAN_ADV=y)
-	default n
 	help
 	  This option enables the multicast optimisation which aims to
 	  reduce the air overhead while improving the reliability of
@@ -94,7 +90,6 @@ config BATMAN_ADV_DEBUGFS
 	bool "batman-adv debugfs entries"
 	depends on BATMAN_ADV
 	depends on DEBUG_FS
-	default n
 	help
 	  Enable this to export routing related debug tables via debugfs.
 	  The information for each soft-interface and used hard-interface can be
-- 
2.17.0

