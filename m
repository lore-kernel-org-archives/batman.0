Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 27 Dec 2013 14:05:37 +0100
Message-Id: <1388149537-26581-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix compat sparse errors for
	BUILD_BUG_ON in <= 2.6.39
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

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 compat.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/compat.h b/compat.h
index a1c8396..92f88ee 100644
--- a/compat.h
+++ b/compat.h
@@ -207,6 +207,13 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 	skb->mac_len = skb->network_header - skb->mac_header;
 }
 
+#undef BUILD_BUG_ON
+#ifdef __CHECKER__
+#define BUILD_BUG_ON(condition) (0)
+#else /* __CHECKER__ */
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
+#endif /* __CHECKER__ */
+
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
-- 
1.7.10.4

