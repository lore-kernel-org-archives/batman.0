Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Dec 2011 20:10:46 +0100
Message-Id: <1323025848-14024-2-git-send-email-sven@narfation.org>
In-Reply-To: <1323025848-14024-1-git-send-email-sven@narfation.org>
References: <1323025848-14024-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Remove OpenWRT specific
	makefile rules
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Makefile and Makefile.kbuild are included by the linux kbuild environment to
build the kernel module. Rules by other build systems could lead to hard to
debug problems and therefore should be avoided.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile.kbuild |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index bd7e93c..3c51455 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -18,13 +18,6 @@
 # 02110-1301, USA
 #
 
-
-
-# openwrt integration
-ifeq ($(MAKING_MODULES),1)
--include $(TOPDIR)/Rules.make
-endif
-
 # ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
 
 ifneq ($(REVISION),)
-- 
1.7.7.3

