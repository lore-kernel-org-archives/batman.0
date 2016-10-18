Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:57:41 +0200
Message-Id: <20161018135743.3705-6-sven@narfation.org>
In-Reply-To: <2219629.dYY2ZvZvNG@bentobox>
References: <2219629.dYY2ZvZvNG@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v3 6/8] batman-adv: compat: Replace
	IFF_NO_QUEUE with coccinelle
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
v3:
 - no changes
v2:
 - new patch
---
 compat-patches/0003-iff-no-queue.cocci | 9 +++++++++
 compat.h                               | 6 ------
 2 files changed, 9 insertions(+), 6 deletions(-)
 create mode 100644 compat-patches/0003-iff-no-queue.cocci

diff --git a/compat-patches/0003-iff-no-queue.cocci b/compat-patches/0003-iff-no-queue.cocci
new file mode 100644
index 0000000..9c95b85
--- /dev/null
+++ b/compat-patches/0003-iff-no-queue.cocci
@@ -0,0 +1,9 @@
+@@
+expression E;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
+ E->priv_flags |= IFF_NO_QUEUE;
++#else
++E->tx_queue_len = 0;
++#endif
diff --git a/compat.h b/compat.h
index 78de7ea..245621f 100644
--- a/compat.h
+++ b/compat.h
@@ -152,10 +152,4 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(4, 0, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
-
-#define IFF_NO_QUEUE	0; dev->tx_queue_len = 0
-
-#endif /* < KERNEL_VERSION(4, 3, 0) */
-
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
2.9.3

