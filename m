Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 20 Sep 2016 15:59:17 +0200
Message-Id: <20160920135917.24290-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Allow selecting BATMAN V if
	CFG80211 is not built
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

With the new stub for cfg80211_get_station(), we can now build the
BATMAN V protocol even with a kernel that was built without any
wireless support.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 compat-include/net/cfg80211.h | 24 ++++++++++++++++++++++++
 net/batman-adv/Kconfig        |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 compat-include/net/cfg80211.h

diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
new file mode 100644
index 0000000..8dbbf0e
--- /dev/null
+++ b/compat-include/net/cfg80211.h
@@ -0,0 +1,24 @@
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_
+
+#include <linux/version.h>
+#include_next <net/cfg80211.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 8, 0)
+
+#if !IS_ENABLED(CONFIG_CFG80211)
+
+#define cfg80211_get_station(dev, mac_addr, sinfo) \
+	batadv_cfg80211_get_station(dev, mac_addr, sinfo)
+
+static inline int batadv_cfg80211_get_station(struct net_device *dev,
+					      const u8 *mac_addr,
+					      struct station_info *sinfo)
+{
+	return -ENOENT;
+}
+#endif
+
+#endif /* < KERNEL_VERSION(4, 8, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_ */
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index f20742c..b73b96a 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -17,7 +17,7 @@ config BATMAN_ADV
 
 config BATMAN_ADV_BATMAN_V
 	bool "B.A.T.M.A.N. V protocol (experimental)"
-	depends on BATMAN_ADV && CFG80211=y || (CFG80211=m && BATMAN_ADV=m)
+	depends on BATMAN_ADV && !(CFG80211=m && BATMAN_ADV=y)
 	default n
 	help
 	  This option enables the B.A.T.M.A.N. V protocol, the successor
-- 
2.1.4

