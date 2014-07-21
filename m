Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 21 Jul 2014 15:42:05 +0200
Message-Id: <1405950125-13983-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] net: set name_assign_type in alloc_netdev()
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
Cc: Tom Gundersen <teg@jklm.no>, "David S. Miller" <davem@davemloft.net>

From: Tom Gundersen <teg@jklm.no>

Extend alloc_netdev{,_mq{,s}}() to take name_assign_type as argument, and convert
all users to pass NET_NAME_UNKNOWN.

Coccinelle patch:

@@
expression sizeof_priv, name, setup, txqs, rxqs, count;
@@

(
-alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs)
+alloc_netdev_mqs(sizeof_priv, name, NET_NAME_UNKNOWN, setup, txqs, rxqs)
|
-alloc_netdev_mq(sizeof_priv, name, setup, count)
+alloc_netdev_mq(sizeof_priv, name, NET_NAME_UNKNOWN, setup, count)
|
-alloc_netdev(sizeof_priv, name, setup)
+alloc_netdev(sizeof_priv, name, NET_NAME_UNKNOWN, setup)
)

v9: move comments here from the wrong commit

Signed-off-by: Tom Gundersen <teg@jklm.no>
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sw: added compat code]
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 compat.h         | 14 ++++++++++++++
 soft-interface.c |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index ed5b815..d218426 100644
--- a/compat.h
+++ b/compat.h
@@ -446,4 +446,18 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 16, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
+
+/* alloc_netdev() was defined differently before 2.6.38 */
+#undef alloc_netdev
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 38)
+#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
+	alloc_netdev_mq(sizeof_priv, name, setup, 1)
+#else
+#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
+	alloc_netdev_mqs(sizeof_priv, name, setup, 1, 1)
+#endif /* nested < KERNEL_VERSION(2, 6, 38) */
+
+#endif /* < KERNEL_VERSION(3, 17, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index 9bf382d..cfc2cd2 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -933,7 +933,7 @@ struct net_device *batadv_softif_create(const char *name)
 	int ret;
 
 	soft_iface = alloc_netdev(sizeof(struct batadv_priv), name,
-				  batadv_softif_init_early);
+				  NET_NAME_UNKNOWN, batadv_softif_init_early);
 	if (!soft_iface)
 		return NULL;
 
-- 
1.9.1

