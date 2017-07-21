Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Jul 2017 11:17:09 +0200
Message-Id: <20170721091709.7978-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Only enable priv_destructor
 compat for < 4.11.9
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

The teardown netdev API change 33e9de0c769c ("batman-adv: Fix inconsistent
teardown and release of private netdev state.") was backported to Linux
4.11.9. The compat code to switch back to the old style destructor code
must therefore not be enabled for Linux >= 4.11.9.

Reported-by: Ruben Kelevra <cyrond@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 1b36e529..00ed5e40 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -86,7 +86,7 @@ static inline void batadv_netif_trans_update(struct net_device *dev)
 
 #endif /* < KERNEL_VERSION(4, 7, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 12, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 11, 9)
 
 /* work around missing attribute needs_free_netdev and priv_destructor in
  * net_device
@@ -103,6 +103,6 @@ static inline void batadv_netif_trans_update(struct net_device *dev)
 #define needs_free_netdev destructor = batadv_softif_free2; t2
 #define priv_destructor destructor = batadv_softif_free2; t1
 
-#endif /* < KERNEL_VERSION(4, 12, 0) */
+#endif /* < KERNEL_VERSION(4, 11, 9) */
 
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_ */
-- 
2.11.0

