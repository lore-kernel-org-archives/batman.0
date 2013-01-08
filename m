Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue,  8 Jan 2013 15:23:04 +0100
Message-Id: <1357654984-19098-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix NET_ADDR_RANDOM usage for
	pre-3.9 kernel
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Kernel before 3.9 have the NET_ADDR_RANDOM flag which needs to be set.
This patch adds the necessary compat change for older kernel.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 compat.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/compat.h b/compat.h
index 3d03a2f..e21b310 100644
--- a/compat.h
+++ b/compat.h
@@ -198,6 +198,19 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 
 #define prandom_u32() random32()
 
+#define batadv_interface_set_mac_addr(x, y) \
+__batadv_interface_set_mac_addr(struct net_device *dev, void *p);\
+static int batadv_interface_set_mac_addr(struct net_device *dev, void *p) \
+{\
+	int ret;\
+\
+	ret = __batadv_interface_set_mac_addr(dev, p);\
+	if (!ret) \
+		dev->addr_assign_type &= ~NET_ADDR_RANDOM;\
+	return ret;\
+}\
+static int __batadv_interface_set_mac_addr(x, y)
+
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.10.4

