Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Fri, 15 Mar 2013 23:18:17 +0100
Message-Id: <65e1eabaa1dae3e9003482b35ae1d012939ab07b.1363385881.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH] Fix compat for for Debian Wheezy kernel
	v3.2.39
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

Starting with kernel v3.2.39, a Debian specific patch defines
eth_hw_addr_random() in include/linux/etherdevice.h, causing the build of
batman-adv to fail.

This patch fixes the build on these kernels while keeping compatiblity with
unpatched kernels by replacing batman-adv's compat definition of the
eth_hw_addr_random() function with a #define macro.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 compat.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/compat.h b/compat.h
index e1c6cd2..46baf6c 100644
--- a/compat.h
+++ b/compat.h
@@ -174,10 +174,7 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
 
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	random_ether_addr(dev->dev_addr);
-}
+#define eth_hw_addr_random(dev) random_ether_addr((dev)->dev_addr)
 
 #endif /* < KERNEL_VERSION(3, 4, 0) */
 
-- 
1.8.2

