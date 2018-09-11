Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 11 Sep 2018 17:59:42 +0200
Message-Id: <20180911155942.15494-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Enable LockLess TX for softif
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

The batadv interfaces are virtual interfaces which just tunnel the traffic
over other ethernet compatible interfaces. It doesn't need serialization
during the tx phase and is using RCU for most of its internal
datastructures. Since it doesn't have actual queues which could be locked
independently, the throughput gets significantly reduced by the extra lock
in the core net code.

8 parallel TCP connections forwarded by an IPQ4019 based hardware over
5GHz could reach:

* without LLX: 349 Mibit/s
* with LLX:    563 Mibit/s

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 626ddca3..b1596c23 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1062,6 +1062,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = batadv_softif_free;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
+	dev->features |= NETIF_F_LLTX;
 	dev->priv_flags |= IFF_NO_QUEUE;
 
 	/* can't call min_mtu, because the needed variables
-- 
2.11.0

