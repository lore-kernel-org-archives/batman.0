Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 May 2018 22:03:11 +0200
Message-Id: <20180525200312.13527-2-sven@narfation.org>
In-Reply-To: <20180525200312.13527-1-sven@narfation.org>
References: <20180525200312.13527-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Disable DAT during compilation
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
Cc: a@unstable.cc, linus.luessing@c0d3.blue, Sven Eckelmann <sven@narfation.org>

The distributed arp table compile option is disabled by default in the
Kconfig of batman-adv. The out-of-tree module should keep this setting in
sync and thus has to also disable the build of DAT by default.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile               | 2 +-
 README.external.rst    | 2 +-
 gen-compat-autoconf.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ea995216..85348893 100644
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
 export CONFIG_BATMAN_ADV_BLA=y
 # B.A.T.M.A.N. distributed ARP table:
-export CONFIG_BATMAN_ADV_DAT=y
+export CONFIG_BATMAN_ADV_DAT=n
 # B.A.T.M.A.N network coding (catwoman):
 export CONFIG_BATMAN_ADV_NC=n
 # B.A.T.M.A.N. multicast optimizations:
diff --git a/README.external.rst b/README.external.rst
index a6f14a03..ac06faa9 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -46,7 +46,7 @@ module).  Available  options  and  their    possible   values are
  * ``CONFIG_BATMAN_ADV_DEBUGFS=[y|n*]`` (B.A.T.M.A.N. debugfs entries)
  * ``CONFIG_BATMAN_ADV_DEBUG=[y|n*]`` (B.A.T.M.A.N. debugging)
  * ``CONFIG_BATMAN_ADV_BLA=[y*|n]`` (B.A.T.M.A.N. bridge loop avoidance)
- * ``CONFIG_BATMAN_ADV_DAT=[y*|n]`` (B.A.T.M.A.N. Distributed ARP Table)
+ * ``CONFIG_BATMAN_ADV_DAT=[y|n*]`` (B.A.T.M.A.N. Distributed ARP Table)
  * ``CONFIG_BATMAN_ADV_MCAST=[y*|n]`` (B.A.T.M.A.N. multicast optimizations)
  * ``CONFIG_BATMAN_ADV_NC=[y|n*]`` (B.A.T.M.A.N. Network Coding)
  * ``CONFIG_BATMAN_ADV_BATMAN_V=[y*|n]`` (B.A.T.M.A.N. V routing algorithm)
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 5dcd875d..b498e6eb 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -55,7 +55,7 @@ gen_config() {
 gen_config 'CONFIG_BATMAN_ADV_DEBUGFS' ${CONFIG_BATMAN_ADV_DEBUGFS:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
-gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_MCAST' ${CONFIG_BATMAN_ADV_MCAST:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BATMAN_V' ${CONFIG_BATMAN_ADV_BATMAN_V:="y"} >> "${TMP}"
-- 
2.17.0

