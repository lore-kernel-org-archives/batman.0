Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 10 Dec 2013 19:39:00 +0100
Message-Id: <1386700740-2752-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 next] batadv: Slight optimization of
	batadv_compare_eth
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Use the newly added generic routine ether_addr_equal_unaligned
to test if possibly unaligned to u16 Ethernet addresses are equal.

This slightly improves comparison time for systems with
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Signed-off-by: Joe Perches <joe@perches.com>
[antonio@meshcoding.com: added compat code for linux <3.14]
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 compat.h | 6 ++++++
 main.h   | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index 04a2256..997b817 100644
--- a/compat.h
+++ b/compat.h
@@ -376,4 +376,10 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 	})
 #endif /* < KERNEL_VERSION(3, 11, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 14, 0)
+
+#define ether_addr_equal_unaligned(_a, _b) (memcmp(_a, _b, ETH_ALEN) == 0)
+
+#endif /* < KERNEL_VERSION(3, 14, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/main.h b/main.h
index c5d6eb2..d4187ba 100644
--- a/main.h
+++ b/main.h
@@ -267,7 +267,7 @@ static inline void batadv_dbg(int type __always_unused,
  */
 static inline int batadv_compare_eth(const void *data1, const void *data2)
 {
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+	return ether_addr_equal_unaligned(data1, data2);
 }
 
 /**
-- 
1.8.5.1

