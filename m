Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 21 Oct 2010 13:26:51 +0200
Message-Id: <1287660411-4238-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1287660411-4238-1-git-send-email-sven.eckelmann@gmx.de>
References: <1287660411-4238-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Cleanup compat.h
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

Following functions/defines were declared more than once:
 * skb_mac_header

Following functions/defines weren't used anymore:
 * skb_clone_writable
 * dev_get_stats

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/compat.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index 5c02b44..da474e4 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -46,9 +46,6 @@
 #define skb_mac_header(_skb) \
     ((_skb)->mac.raw)
 
-#define skb_mac_header(_skb) \
-    ((_skb)->mac.raw)
-
 #include <linux/etherdevice.h>
 static inline __be16 bat_eth_type_trans(struct sk_buff *skb,
 					struct net_device *dev)
@@ -64,12 +61,6 @@ static inline __be16 bat_eth_type_trans(struct sk_buff *skb,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 23)
 
-static inline int skb_clone_writable(struct sk_buff *skb, unsigned int len)
-{
-	/* skb->hdr_len not available, just "not writable" to enforce a copy */
-	return 0;
-}
-
 static inline int skb_cow_head(struct sk_buff *skb, unsigned int headroom)
 {
 	return skb_cow(skb, headroom);
@@ -268,14 +259,6 @@ int bat_sprintf(char *buf, const char *fmt, ...);
 int bat_snprintf(char *buf, size_t size, const char *fmt, ...);
 #define snprintf bat_snprintf
 
-static inline struct net_device_stats *dev_get_stats(struct net_device *dev)
-{
-	if (dev->get_stats)
-		return dev->get_stats(dev);
-	else
-		return NULL;
-}
-
 #endif /* < KERNEL_VERSION(2, 6, 29) */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.2.3

