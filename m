Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 17:12:07 +0100
Message-Id: <20171119161207.32588-7-sven@narfation.org>
In-Reply-To: <20171119161207.32588-1-sven@narfation.org>
References: <20171119161207.32588-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: compat: Map to
 linux/nl80211.h for Linux < 3.7
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

The uapi header of linux/nl80211.h was introduced with 3.7. Older version
have to rely on the linux/nl80211.h header.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/uapi/linux/nl80211.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat-include/uapi/linux/nl80211.h b/compat-include/uapi/linux/nl80211.h
index 9b18178e..ead4c6dd 100644
--- a/compat-include/uapi/linux/nl80211.h
+++ b/compat-include/uapi/linux/nl80211.h
@@ -25,7 +25,11 @@
 #define _NET_BATMAN_ADV_COMPAT_UAPI_LINUX_NL80211_H_
 
 #include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0)
 #include_next <uapi/linux/nl80211.h>
+#else
+#include <linux/nl80211.h>
+#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
 
-- 
2.11.0

