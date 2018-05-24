Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 14:02:54 +0200
Message-Id: <20180524120300.15829-3-sw@simonwunderlich.de>
In-Reply-To: <20180524120300.15829-1-sw@simonwunderlich.de>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Disable
 CONFIG_BATMAN_ADV_DEBUGFS by default
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

All tools which were known to the batman-adv development team are
supporting the batman-adv netlink interface since a while. Also debugfs is
not supported for batman-adv interfaces in any non-default netns. Thus
disabling CONFIG_BATMAN_ADV_DEBUGFS by default should not cause problems on
most systems. It is still possible to enable it in case it is still
required in a specific setup.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index e4e2e02b7380..bee034a95208 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -94,13 +94,13 @@ config BATMAN_ADV_DEBUGFS
 	bool "batman-adv debugfs entries"
 	depends on BATMAN_ADV
 	depends on DEBUG_FS
-	default y
+	default n
 	help
 	  Enable this to export routing related debug tables via debugfs.
 	  The information for each soft-interface and used hard-interface can be
 	  found under batman_adv/
 
-	  If unsure, say Y.
+	  If unsure, say N.
 
 config BATMAN_ADV_DEBUG
 	bool "B.A.T.M.A.N. debugging"
-- 
2.11.0

