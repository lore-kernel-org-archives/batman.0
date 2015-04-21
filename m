Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 12:42:09 +0200
Message-Id: <1429612929-19765-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Document multicast compile time
	option
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

The README.external lists all options which can be enabled/disabled during
compile time. The CONFIG_BATMAN_ADV_MCAST option wasn't document in this
list.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile        | 1 +
 README.external | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 8a04d12..d8bd4ef 100644
--- a/Makefile
+++ b/Makefile
@@ -59,6 +59,7 @@ BUILD_FLAGS := \
 	CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
 	CONFIG_BATMAN_ADV_MCAST=$(CONFIG_BATMAN_ADV_MCAST) \
 	INSTALL_MOD_DIR=updates/net/batman-adv/
+export batman-adv-y += ../../compat.o
 
 all: config
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS)	modules
diff --git a/README.external b/README.external
index e3b533d..f068273 100644
--- a/README.external
+++ b/README.external
@@ -38,6 +38,7 @@ module).  Available  options  and  their    possible   values are
  * CONFIG_BATMAN_ADV_DEBUG=[y|n*] (B.A.T.M.A.N. debugging)
  * CONFIG_BATMAN_ADV_BLA=[y*|n] (B.A.T.M.A.N. bridge loop avoidance)
  * CONFIG_BATMAN_ADV_DAT=[y*|n] (B.A.T.M.A.N. Distributed ARP Table)
+ * CONFIG_BATMAN_ADV_MCAST=[y*|n] (B.A.T.M.A.N. multicast optimizations)
  * CONFIG_BATMAN_ADV_NC=[y|n*] (B.A.T.M.A.N. Network Coding)
 
 e.g., debugging can be enabled by
-- 
2.1.4

