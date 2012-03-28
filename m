Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 28 Mar 2012 13:35:05 +0200
Message-Id: <1332934505-22964-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Use eth_hw_addr_random compat
	also for kernel 3.3
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The changes for eth_hw_addr_random were not merged in linux 3.3. Therefore, the
compat layer has to provide it.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index 46de8b0..92379ef 100644
--- a/compat.h
+++ b/compat.h
@@ -132,13 +132,13 @@ void free_rcu_backbone_gw(struct rcu_head *rcu);
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
 
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
 	random_ether_addr(dev->dev_addr);
 }
 
-#endif /* < KERNEL_VERSION(3, 0, 0) */
+#endif /* < KERNEL_VERSION(3, 4, 0) */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.9.1

