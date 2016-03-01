Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  1 Mar 2016 08:33:37 +0100
Message-Id: <1456817617-5762-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next v2] batman-adv: Disable
	__ethtool_get_link_ksettings compat on < 3.2
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

The __ethtool_get_link_ksettings is currently used only for kernels >=
3.15. But the compat code is read by the compiler for each kernel. But
kernels up to 3.1 never had the function __ethtool_get_settings which is
used to emulate this function for kernels < 4.6. Therefore, kernels < 3.2
will fail to compile when this compatibility layer is enabled.

Fixes: 3515604d82d5 ("batman-adv: ELP - use new ethtool_link_get_ksettings API")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - correct version number of the supported kernel

 compat-include/linux/ethtool.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
index 87f7577..2e6270e 100644
--- a/compat-include/linux/ethtool.h
+++ b/compat-include/linux/ethtool.h
@@ -24,7 +24,9 @@
 #include <linux/version.h>
 #include_next <linux/ethtool.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
+/* WARNING only enabled on kernels with __ethtool_get_settings support */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(3, 2, 0)
 
 #define ethtool_link_ksettings batadv_ethtool_link_ksettings
 
-- 
2.7.0

