Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 24 Jan 2017 01:00:30 +0100
Message-Id: <20170124000030.29160-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: restructure cfg80211 compat code
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
Cc: Antonio Quartulli <a@unstable.cc>

This commit restructures the compat code regarding cfg80211 to achieve
the following:

a) Allows to compile kernels < 3.16 with -Werror by replacing the
"#warning" with a runtime warning through pr_warn_once().
b) Allows to run < 3.16 kernels without warnings if no cfg80211 based
interface is used.
c) Migrates cfg80211 compat code from compat.h to compat cfg80211.h to
keep compat.h slim.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 compat-include/net/cfg80211.h | 21 ++++++++++++++++++++-
 compat.h                      | 21 ---------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index 8dbbf0e..6e0eca3 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -4,9 +4,28 @@
 #include <linux/version.h>
 #include_next <net/cfg80211.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
+static inline int cfg80211_get_station(struct net_device *dev,
+				       const u8 *mac_addr,
+				       struct station_info *sinfo)
+{
+	pr_warn_once("cfg80211 based throughput metric is only supported with Linux 3.16+\n");
+	return -ENOENT;
+}
+
+/* The following define substitutes the expected_throughput field with a random
+ * one existing in the station_info struct. It can be random because due to the
+ * function above it will never be used. Only needed to make the code compile
+ */
+#define expected_throughput filled
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 8, 0)
 
-#if !IS_ENABLED(CONFIG_CFG80211)
+#if !IS_ENABLED(CONFIG_CFG80211) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(3, 16, 0)
 
 #define cfg80211_get_station(dev, mac_addr, sinfo) \
 	batadv_cfg80211_get_station(dev, mac_addr, sinfo)
diff --git a/compat.h b/compat.h
index 5397629..e43c413 100644
--- a/compat.h
+++ b/compat.h
@@ -130,27 +130,6 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 10, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
-
-/* the expected behaviour of this function is to return 0 on success, therefore
- * it is possible to define it as 1 so that batman-adv thinks like something
- * went wrong. It will then decide what to do.
- */
-#define cfg80211_get_station(_a, _b, _c) (1)
-/* the following define substitute the expected_throughput field with a random
- * one existing in the station_info struct. It can be random because due to the
- * define above it will never be used. We need it only to make the code compile
- */
-#define expected_throughput filled
-
-#ifdef CONFIG_BATMAN_ADV_BATMAN_V
-
-#warning cfg80211 based throughput metric is only supported with Linux 3.15+
-
-#endif
-
-#endif /* < KERNEL_VERSION(3, 16, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
 
 /* wild hack for batadv_getlink_net only */
-- 
2.1.4

