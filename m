Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu,  3 Oct 2013 23:02:13 +0200
Message-Id: <1380834133-10808-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix compat of
	net_ratelimited_function for >3.2.46
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Appearently net_ratelimited_function was added to the stable series of
from 3.2.47, which results in a lot of warnings when compiling against
this kernel. This patch avoids this redefinition.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 compat.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat.h b/compat.h
index 7e0a7f0..04a2256 100644
--- a/compat.h
+++ b/compat.h
@@ -241,11 +241,13 @@ static inline void batadv_eth_hw_addr_random(struct net_device *dev)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 5, 0)
 
+#ifndef net_ratelimited_function
 #define net_ratelimited_function(func, ...) \
 	do { \
 		if (net_ratelimit()) \
 			func(__VA_ARGS__); \
 	} while (0)
+#endif /* ifndef net_ratelimited_function */
 
 #endif /* < KERNEL_VERSION(3, 5, 0) */
 
-- 
1.7.10.4

