Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Sat, 16 Mar 2013 12:30:10 +0100
Message-Id: <be7bde49d2b117e29460dc013cb877b410648a1a.1363433383.git.mschiffer@universe-factory.net>
In-Reply-To: <201303161910.18263.lindner_marek@yahoo.de>
References: <201303161910.18263.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: fix compat for Debian Wheezy
	kernel v3.2.39
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
unpatched kernels by renaming batman-adv's compat definition of the
eth_hw_addr_random() function to resolve the name conflict and adding a #define
macro.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 compat.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index e1c6cd2..d955166 100644
--- a/compat.h
+++ b/compat.h
@@ -174,7 +174,9 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
 
-static inline void eth_hw_addr_random(struct net_device *dev)
+#define eth_hw_addr_random(dev)	batadv_eth_hw_addr_random(dev)
+
+static inline void batadv_eth_hw_addr_random(struct net_device *dev)
 {
 	random_ether_addr(dev->dev_addr);
 }
-- 
1.8.2

