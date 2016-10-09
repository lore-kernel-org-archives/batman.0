Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  9 Oct 2016 08:57:37 +0200
Message-Id: <20161009065738.8279-10-sven@narfation.org>
In-Reply-To: <1647833.jYley1tZnH@sven-edge>
References: <1647833.jYley1tZnH@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v2 10/11] batman-adv: compat: Move
	get_link_net patch to coccinelle
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - new patch
---
 compat-patches/0004-get_link_net.cocci | 13 +++++++++++++
 compat.h                               |  7 -------
 2 files changed, 13 insertions(+), 7 deletions(-)
 create mode 100644 compat-patches/0004-get_link_net.cocci

diff --git a/compat-patches/0004-get_link_net.cocci b/compat-patches/0004-get_link_net.cocci
new file mode 100644
index 0000000..1ae3192
--- /dev/null
+++ b/compat-patches/0004-get_link_net.cocci
@@ -0,0 +1,13 @@
+@@
+identifier netdev, fallback_net;
+@@
+
+ static const struct net *batadv_getlink_net(const struct net_device *netdev,
+ 				             const struct net *fallback_net)
+ {
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
++	return fallback_net;
++#else
+ ...
++#endif
+ }
diff --git a/compat.h b/compat.h
index 245621f..2865eeb 100644
--- a/compat.h
+++ b/compat.h
@@ -145,11 +145,4 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 15, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
-
-/* WARNING for batadv_getlink_net */
-#define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops->get_xstats_size
-
-#endif /* < KERNEL_VERSION(4, 0, 0) */
-
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
2.9.3

