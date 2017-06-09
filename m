Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  9 Jun 2017 16:29:58 +0200
Message-Id: <20170609142958.22105-2-sven@narfation.org>
In-Reply-To: <20170609142958.22105-1-sven@narfation.org>
References: <20170609142958.22105-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Accept only filled wifi
 station info
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

The wifi driver can decide to not provide parts of the station info. For
example, the expected throughput of the station can be omitted when the
used rate control doesn't provide this kind of information.

The B.A.T.M.A.N. V implementation must therefore check the filled bitfield
before it tries to access the expected_throughput of the returned
station_info.

Reported-by: Alvaro Antelo <alvaro.antelo@gmail.com>
Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - switched to BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT) for Linux 4.0+

 compat-include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/batman-adv/bat_v_elp.c          |  4 ++++
 2 files changed, 20 insertions(+)
 create mode 100644 compat-include/uapi/linux/nl80211.h

diff --git a/compat-include/uapi/linux/nl80211.h b/compat-include/uapi/linux/nl80211.h
new file mode 100644
index 00000000..06f5625a
--- /dev/null
+++ b/compat-include/uapi/linux/nl80211.h
@@ -0,0 +1,16 @@
+#ifndef _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_
+#define _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_
+
+#include <linux/version.h>
+#include_next <uapi/linux/nl80211.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
+
+/* for batadv_v_elp_get_throughput which would have used
+ * STATION_INFO_EXPECTED_THROUGHPUT in Linux 4.0.0
+ */
+#define NL80211_STA_INFO_EXPECTED_THROUGHPUT    28
+
+#endif /* < KERNEL_VERSION(4, 0, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_ */
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 96e73337..4729a68a 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -39,6 +40,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <net/cfg80211.h>
+#include <uapi/linux/nl80211.h>
 
 #include "bat_algo.h"
 #include "bat_v_ogm.h"
@@ -111,6 +113,8 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		}
 		if (ret)
 			goto default_throughput;
+		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
+			goto default_throughput;
 
 		return sinfo.expected_throughput / 100;
 	}
-- 
2.11.0

