Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 Jul 2016 12:59:29 +0200
Message-Id: <1468148369-17048-2-git-send-email-sven@narfation.org>
In-Reply-To: <1468148369-17048-1-git-send-email-sven@narfation.org>
References: <1468148369-17048-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Disable
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
supporting the batman-adv netlink interface since a while. Thus disabling
CONFIG_BATMAN_ADV_DEBUGFS by default should not cause problems on most
systems. It is still possible to enable it in case it is still required in
a specific setup

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Of course, this patch is for the future - not now.
---
 Makefile               | 2 +-
 README.external        | 2 +-
 gen-compat-autoconf.sh | 2 +-
 net/batman-adv/Kconfig | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index d42bb56..84bacdc 100644
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
diff --git a/README.external b/README.external
index ec04364..d8470f2 100644
--- a/README.external
+++ b/README.external
@@ -35,7 +35,7 @@ option  can be set to to y (enabled), n (disabled) or m (build as
 module).  Available  options  and  their    possible   values are
 (default marked with an "*")
 
- * CONFIG_BATMAN_ADV_DEBUGFS=[y*|n] (B.A.T.M.A.N. debugfs entries)
+ * CONFIG_BATMAN_ADV_DEBUGFS=[y|n*] (B.A.T.M.A.N. debugfs entries)
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
  * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index cf36e55..d27f3fb 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -36,7 +36,7 @@ gen_config() {
 }
 
 # write config variables
-gen_config 'CONFIG_BATMAN_ADV_DEBUGFS' ${CONFIG_BATMAN_ADV_DEBUGFS:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_DEBUGFS' ${CONFIG_BATMAN_ADV_DEBUGFS:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index d9b71a1..1e220a0 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -77,13 +77,13 @@ config BATMAN_ADV_DEBUGFS
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
2.8.1

