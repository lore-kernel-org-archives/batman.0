Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Oct 2016 08:36:26 +0100
Message-Id: <20161031073629.31819-3-sven@narfation.org>
In-Reply-To: <1637163.TC9CcXIrIP@sven-edge>
References: <1637163.TC9CcXIrIP@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: Revert "compat: Replace
	IFF_NO_QUEUE with coccinelle"
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

This reverts commit 541c087012bd6b57d37f041aedc4d0b4440a96d1.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-patches/0003-iff-no-queue.cocci | 9 ---------
 compat.h                               | 6 ++++++
 2 files changed, 6 insertions(+), 9 deletions(-)
 delete mode 100644 compat-patches/0003-iff-no-queue.cocci

diff --git a/compat-patches/0003-iff-no-queue.cocci b/compat-patches/0003-iff-no-queue.cocci
deleted file mode 100644
index 9c95b85..0000000
--- a/compat-patches/0003-iff-no-queue.cocci
+++ /dev/null
@@ -1,9 +0,0 @@
-@@
-expression E;
-@@
-
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
- E->priv_flags |= IFF_NO_QUEUE;
-+#else
-+E->tx_queue_len = 0;
-+#endif
diff --git a/compat.h b/compat.h
index 245621f..78de7ea 100644
--- a/compat.h
+++ b/compat.h
@@ -152,4 +152,10 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(4, 0, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
+
+#define IFF_NO_QUEUE	0; dev->tx_queue_len = 0
+
+#endif /* < KERNEL_VERSION(4, 3, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
2.10.1

