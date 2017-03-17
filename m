Return-Path: <tklauser@distanz.ch>
From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri, 17 Mar 2017 12:08:59 +0100
Message-Id: <20170317110859.9273-1-tklauser@distanz.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Omit unnecessary memset of
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>

The memory for netdev_priv is allocated using kzalloc in alloc_netdev
(or alloc_netdev_mq respectively) so there is no need to set it to 0
again.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
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


