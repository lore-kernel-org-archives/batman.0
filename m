Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Oct 2016 08:36:25 +0100
Message-Id: <20161031073629.31819-2-sven@narfation.org>
In-Reply-To: <1637163.TC9CcXIrIP@sven-edge>
References: <1637163.TC9CcXIrIP@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: Revert "compat: Move
	get_link_net patch to coccinelle"
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

The coccinelle in Debian Jessie seems to be broken. It fails to parse
the patches and thus makes it impossible to use the out-of-tree
module in these systems. Therefore drop it for now.

This reverts commit 3b79cd3d9b3eb920d17233b5270ee7162d55587e.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-patches/0004-get_link_net.cocci | 13 -------------
 compat.h                               |  7 +++++++
 2 files changed, 7 insertions(+), 13 deletions(-)
 delete mode 100644 compat-patches/0004-get_link_net.cocci

diff --git a/compat-patches/0004-get_link_net.cocci b/compat-patches/0004-get_link_net.cocci
deleted file mode 100644
index 7520bb6..0000000
--- a/compat-patches/0004-get_link_net.cocci
+++ /dev/null
@@ -1,13 +0,0 @@
-@@
-identifier netdev, fallback_net;
-@@
-
- static struct net *batadv_getlink_net(const struct net_device *netdev,
-				       struct net *fallback_net)
- {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
-+	return fallback_net;
-+#else
- ...
-+#endif
- }
diff --git a/compat.h b/compat.h
index 2865eeb..245621f 100644
--- a/compat.h
+++ b/compat.h
@@ -145,4 +145,11 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 15, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
+
+/* WARNING for batadv_getlink_net */
+#define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops->get_xstats_size
+
+#endif /* < KERNEL_VERSION(4, 0, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
2.10.1

