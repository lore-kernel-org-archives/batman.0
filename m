Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Feb 2012 14:35:30 +0100
Message-Id: <1329053731-4737-2-git-send-email-sven@narfation.org>
In-Reply-To: <1329053731-4737-1-git-send-email-sven@narfation.org>
References: <1329053731-4737-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Backport dev_hw_addr_random
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

910ccacb9dd2bfac8ce1ac411af514fe72fa84c0 introduced the hardware address
initialization using dev_hw_addr_random. This function was added to linux with
linux 2.6.36. Older kernel versions have to igore the NET_ADDR_RANDOM variable
and use random_ether_addr directly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/compat.h b/compat.h
index e90409f..88866da 100644
--- a/compat.h
+++ b/compat.h
@@ -104,6 +104,15 @@ static inline int __param_set_copystring(const char *val,
 }
 #define param_set_copystring __param_set_copystring
 
+static inline void dev_hw_addr_random(struct net_device *dev, u8 *hwaddr)
+{
+	random_ether_addr(hwaddr);
+}
+
+/* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
+#define addr_assign_type ifindex
+#define NET_ADDR_RANDOM 0
+
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
 
-- 
1.7.9

