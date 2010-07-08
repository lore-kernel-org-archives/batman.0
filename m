Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri,  9 Jul 2010 01:00:18 +0200
Message-Id: <1278630018-18345-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix 64 bit counters on 32 bit
	arches
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

From: Eric Dumazet <eric.dumazet@gmail.com>

There is a small possibility that a reader gets incorrect values on 32
bit arches. SNMP applications could catch incorrect counters when a
32bit high part is changed by another stats consumer/provider.

One way to solve this is to add a rtnl_link_stats64 param to all
ndo_get_stats64() methods, and also add such a parameter to
dev_get_stats().

Rule is that we are not allowed to use dev->stats64 as a temporary
storage for 64bit stats, but a caller provided area (usually on stack)

Old drivers (only providing get_stats() method) need no changes.

Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven.eckelmann@gmx.de: Added compat.h defines for pre-2.6.36 kernels]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
This patch entered net-next-2.6 today. It is also part of maint and must be
applied in trunk too.

The original commit can be found using its SHA1
28172739f0a276eb8d6ca917b3974c2edb036da3.

 batman-adv/compat.h         |    8 ++++++++
 batman-adv/hard-interface.c |    3 ++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index 09016c8..103593d 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -249,4 +249,12 @@ static inline struct net_device_stats *dev_get_stats(struct net_device *dev)
 
 #endif /* < KERNEL_VERSION(2, 6, 29) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
+
+#define dev_get_stats(x, y) dev_get_stats(x)
+
+#define rtnl_link_stats64 rtnl_link_stats __attribute__((unused))
+
+#endif /* < KERNEL_VERSION(2, 6, 36) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 5ff9dcb..6a37c33 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -445,6 +445,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
 	struct net_device_stats *stats;
+	struct rtnl_link_stats64 temp;
 	int ret;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
@@ -480,7 +481,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
 
-	stats = (struct net_device_stats *)dev_get_stats(skb->dev);
+	stats = (struct net_device_stats *)dev_get_stats(skb->dev, &temp);
 	if (stats) {
 		stats->rx_packets++;
 		stats->rx_bytes += skb->len;
-- 
1.7.1

