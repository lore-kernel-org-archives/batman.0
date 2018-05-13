Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 14 May 2018 06:42:59 +0800
Message-Id: <20180513224259.14876-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: enable B.A.T.M.A.N. V
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
Acked-by: Antonio Quartulli <a@unstable.cc>
---
v2:
 * add relevant changes to README.external.rst & gen-compat-autoconf.sh

 Makefile               | 2 +-
 README.external.rst    | 2 +-
 gen-compat-autoconf.sh | 2 +-
 net/batman-adv/Kconfig | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/README.external.rst b/README.external.rst
index a7694bbf..a6f14a03 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -49,7 +49,7 @@ module).  Available  options  and  their    possible   values are
  * ``CONFIG_BATMAN_ADV_DAT=[y*|n]`` (B.A.T.M.A.N. Distributed ARP Table)
  * ``CONFIG_BATMAN_ADV_MCAST=[y*|n]`` (B.A.T.M.A.N. multicast optimizations)
  * ``CONFIG_BATMAN_ADV_NC=[y|n*]`` (B.A.T.M.A.N. Network Coding)
- * ``CONFIG_BATMAN_ADV_BATMAN_V=[y|n*]`` (B.A.T.M.A.N. V routing algorithm)
+ * ``CONFIG_BATMAN_ADV_BATMAN_V=[y*|n]`` (B.A.T.M.A.N. V routing algorithm)
 
 e.g., debugging can be enabled by::
 
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 071b6ccf..5dcd875d 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -58,7 +58,7 @@ gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_MCAST' ${CONFIG_BATMAN_ADV_MCAST:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
-gen_config 'CONFIG_BATMAN_ADV_BATMAN_V' ${CONFIG_BATMAN_ADV_BATMAN_V:="n"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_BATMAN_V' ${CONFIG_BATMAN_ADV_BATMAN_V:="y"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
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

