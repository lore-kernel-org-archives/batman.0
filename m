Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 26 Aug 2015 10:24:41 +0200
Message-Id: <1440577481-14719-1-git-send-email-sven@narfation.org>
In-Reply-To: <4340969.K0PsB6WH4o@bentobox>
References: <4340969.K0PsB6WH4o@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: convert to using IFF_NO_QUEUE
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

From: Phil Sutter <phil@nwl.cc>

Signed-off-by: Phil Sutter <phil@nwl.cc>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: added compat hack]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Yes, I go the "route of shame" and added this weird hack. But at least I
don't substract functions from each other.
---
 compat.h                        | 6 ++++++
 net/batman-adv/soft-interface.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index 05fb4f1a4e77..f6f8c44609f7 100644
--- a/compat.h
+++ b/compat.h
@@ -170,4 +170,10 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 10, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
+
+#define IFF_NO_QUEUE	0; dev->tx_queue_len = 0
+
+#endif /* < KERNEL_VERSION(4, 3, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index cce8e896d511..ac4d08de5df4 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -941,7 +941,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->destructor = batadv_softif_free;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
-	dev->tx_queue_len = 0;
+	dev->priv_flags |= IFF_NO_QUEUE;
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
-- 
2.5.0

