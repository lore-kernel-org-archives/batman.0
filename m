Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 13 May 2018 06:24:03 +0800
Message-Id: <20180512222403.4624-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: enable B.A.T.M.A.N. V
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 Makefile               | 2 +-
 net/batman-adv/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index de607ad9..ea995216 100644
--- a/Makefile
+++ b/Makefile
@@ -30,7 +30,7 @@ export CONFIG_BATMAN_ADV_NC=n
 # B.A.T.M.A.N. multicast optimizations:
 export CONFIG_BATMAN_ADV_MCAST=y
 # B.A.T.M.A.N. V routing algorithm (experimental):
-export CONFIG_BATMAN_ADV_BATMAN_V=n
+export CONFIG_BATMAN_ADV_BATMAN_V=y
 
 PWD:=$(shell pwd)
 BUILD_DIR=$(PWD)/build
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index bee034a9..de8034d8 100644
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
2.17.0

