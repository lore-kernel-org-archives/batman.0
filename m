Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Mar 2018 10:34:29 +0100
Message-Id: <20180318093429.18752-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Disable
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
To: b.a.t.m.a.n@lists.open-mesh.org

All tools which were known to the batman-adv development team are
supporting the batman-adv netlink interface since a while. Also debugfs is
not supported for batman-adv interfaces in any non-default netns. Thus
disabling CONFIG_BATMAN_ADV_DEBUGFS by default should not cause problems on
most systems. It is still possible to enable it in case it is still
required in a specific setup.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Was already submitted as RFC in https://patchwork.open-mesh.org/patch/16498/
---
 Makefile               | 2 +-
 README.external.rst    | 2 +-
 gen-compat-autoconf.sh | 2 +-
 net/batman-adv/Kconfig | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index fe97d0aa..de607ad9 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,7 @@
 
 # read README.external for more information about the configuration
 # batman-adv DebugFS entries:
-export CONFIG_BATMAN_ADV_DEBUGFS=y
+export CONFIG_BATMAN_ADV_DEBUGFS=n
 # B.A.T.M.A.N. debugging:
 export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
diff --git a/README.external.rst b/README.external.rst
index 6379b4f5..4a2e9f6a 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -43,7 +43,7 @@ option  can be set to to y (enabled), n (disabled) or m (build as
 module).  Available  options  and  their    possible   values are
 (default marked with an "*")
 
- * ``CONFIG_BATMAN_ADV_DEBUGFS=[y*|n]`` (B.A.T.M.A.N. debugfs entries)
+ * ``CONFIG_BATMAN_ADV_DEBUGFS=[y|n*]`` (B.A.T.M.A.N. debugfs entries)
  * ``CONFIG_BATMAN_ADV_DEBUG=[y|n*]`` (B.A.T.M.A.N. debugging)
  * ``CONFIG_BATMAN_ADV_BLA=[y*|n]`` (B.A.T.M.A.N. bridge loop avoidance)
  * ``CONFIG_BATMAN_ADV_DAT=[y*|n]`` (B.A.T.M.A.N. Distributed ARP Table)
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 5a4cdefc..071b6ccf 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -52,7 +52,7 @@ gen_config() {
 }
 
 # write config variables
-gen_config 'CONFIG_BATMAN_ADV_DEBUGFS' ${CONFIG_BATMAN_ADV_DEBUGFS:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_DEBUGFS' ${CONFIG_BATMAN_ADV_DEBUGFS:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index e4e2e02b..bee034a9 100644
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
2.16.2

