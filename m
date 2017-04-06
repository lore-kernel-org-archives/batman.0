Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  6 Apr 2017 16:07:29 +0200
Message-Id: <20170406140741.30745-8-sw@simonwunderlich.de>
In-Reply-To: <20170406140741.30745-1-sw@simonwunderlich.de>
References: <20170406140741.30745-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 07/19] batman-adv: Omit unnecessary memset of
	netdev private data
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>, b.a.t.m.a.n@lists.open-mesh.org

From: Tobias Klauser <tklauser@distanz.ch>

The memory for netdev_priv is allocated using kzalloc in alloc_netdev
(or alloc_netdev_mq respectively) so there is no need to set it to 0
again.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5d099b2e6cfc..8226495c6664 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -972,8 +972,6 @@ static void batadv_softif_free(struct net_device *dev)
  */
 static void batadv_softif_init_early(struct net_device *dev)
 {
-	struct batadv_priv *priv = netdev_priv(dev);
-
 	ether_setup(dev);
 
 	dev->netdev_ops = &batadv_netdev_ops;
@@ -990,8 +988,6 @@ static void batadv_softif_init_early(struct net_device *dev)
 	eth_hw_addr_random(dev);
 
 	dev->ethtool_ops = &batadv_ethtool_ops;
-
-	memset(priv, 0, sizeof(*priv));
 }
 
 struct net_device *batadv_softif_create(struct net *net, const char *name)
-- 
2.11.0

