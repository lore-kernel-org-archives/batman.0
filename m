Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 13 Jun 2014 11:21:09 +0200
Message-Id: <1402651269-19233-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add compat code for
	kmalloc_array()
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

kmalloc_array() was introduced with linux-3.4 therefore
we need some compat code in order to be able to compile
batman-adv against older kernels.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

Changes from v2:
- fix linux version in commit message



 compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat.h b/compat.h
index 5eb5fe6..28f4cfe 100644
--- a/compat.h
+++ b/compat.h
@@ -274,6 +274,8 @@ static inline void batadv_eth_hw_addr_random(struct net_device *dev)
 	random_ether_addr(dev->dev_addr);
 }
 
+#define kmalloc_array(n, size, flags) kmalloc(n * size, flags)
+
 #endif /* < KERNEL_VERSION(3, 4, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 5, 0)
-- 
1.8.5.5

