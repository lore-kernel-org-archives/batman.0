Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jul 2018 17:26:45 +0200
Message-Id: <20180717152649.32282-4-sw@simonwunderlich.de>
In-Reply-To: <20180717152649.32282-1-sw@simonwunderlich.de>
References: <20180717152649.32282-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] batman-adv: Remove "default n" in Kconfig
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

The "default n" is the default value for any bool or tristate Kconfig
setting. It is therefore not necessary to add it to a config entry.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index ff38df8bab91..361116f77cb9 100644
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
@@ -70,7 +69,6 @@ config BATMAN_ADV_DAT
 config BATMAN_ADV_NC
 	bool "Network Coding"
 	depends on BATMAN_ADV
-	default n
 	help
 	  This option enables network coding, a mechanism that aims to
 	  increase the overall network throughput by fusing multiple
@@ -84,7 +82,6 @@ config BATMAN_ADV_NC
 config BATMAN_ADV_MCAST
 	bool "Multicast optimisation"
 	depends on BATMAN_ADV && INET && !(BRIDGE=m && BATMAN_ADV=y)
-	default n
 	help
 	  This option enables the multicast optimisation which aims to
 	  reduce the air overhead while improving the reliability of
@@ -94,7 +91,6 @@ config BATMAN_ADV_DEBUGFS
 	bool "batman-adv debugfs entries"
 	depends on BATMAN_ADV
 	depends on DEBUG_FS
-	default n
 	help
 	  Enable this to export routing related debug tables via debugfs.
 	  The information for each soft-interface and used hard-interface can be
-- 
2.11.0

