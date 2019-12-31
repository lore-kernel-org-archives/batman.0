Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Disable CONFIG_BATMAN_ADV_SYSFS by default
Date: Wed,  1 Jan 2020 00:55:39 +0100
Message-Id: <20191231235539.18041-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The sysfs support in batman-adv is deprecated since a while and will be
removed completely next year.

All tools which were known to the batman-adv development team are
supporting the batman-adv netlink interface since a while. Thus
disabling CONFIG_BATMAN_ADV_SYSFS by default should not cause problems on
most systems. It is still possible to enable it in case it is still
required in a specific setup.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile               | 2 +-
 README.external.rst    | 2 +-
 net/batman-adv/Kconfig | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index e391a1e7..448a14d6 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,7 @@ export CONFIG_BATMAN_ADV_NC=n
 # B.A.T.M.A.N. multicast optimizations:
 export CONFIG_BATMAN_ADV_MCAST=y
 # B.A.T.M.A.N. sysfs support:
-export CONFIG_BATMAN_ADV_SYSFS=y
+export CONFIG_BATMAN_ADV_SYSFS=n
 # B.A.T.M.A.N. tracing support:
 export CONFIG_BATMAN_ADV_TRACING=n
 # B.A.T.M.A.N. V routing algorithm (experimental):
diff --git a/README.external.rst b/README.external.rst
index 6db0117d..5a5da14e 100644
--- a/README.external.rst
+++ b/README.external.rst
@@ -49,7 +49,7 @@ module).  Available  options  and  their    possible   values are
  * ``CONFIG_BATMAN_ADV_DAT=[y*|n]`` (B.A.T.M.A.N. Distributed ARP Table)
  * ``CONFIG_BATMAN_ADV_MCAST=[y*|n]`` (B.A.T.M.A.N. multicast optimizations)
  * ``CONFIG_BATMAN_ADV_NC=[y|n*]`` (B.A.T.M.A.N. Network Coding)
- * ``CONFIG_BATMAN_ADV_SYSFS=[y*|n]`` (B.A.T.M.A.N. sysfs support)
+ * ``CONFIG_BATMAN_ADV_SYSFS=[y|n*]`` (B.A.T.M.A.N. sysfs support)
  * ``CONFIG_BATMAN_ADV_TRACING=[y|n*]`` (B.A.T.M.A.N. tracing support)
  * ``CONFIG_BATMAN_ADV_BATMAN_V=[y*|n]`` (B.A.T.M.A.N. V routing algorithm)
 
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 045b2b18..c762758a 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -100,7 +100,6 @@ config BATMAN_ADV_DEBUG
 config BATMAN_ADV_SYSFS
 	bool "batman-adv sysfs entries"
 	depends on BATMAN_ADV
-	default y
 	help
 	  Say Y here if you want to enable batman-adv device configuration and
 	  status interface through sysfs attributes. It is replaced by the
-- 
2.20.1

