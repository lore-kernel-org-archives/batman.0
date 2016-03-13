Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 19:50:30 +0100
Message-Id: <1457895034-13823-2-git-send-email-sven@narfation.org>
In-Reply-To: <3465881.llCNFeNLl4@sven-edge>
References: <3465881.llCNFeNLl4@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v3 2/6] batman-adv: NETIF_F_NETNS_LOCAL
	feature to prevent netns moves
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

From: Andrew Lunn <andrew@lunn.ch>

The batX soft interface should not be moved between network name
spaces. This is similar to bridges, bonds, tunnels, which are not
allowed to move between network namespaces.

Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7679f3a..f4aa60a 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -955,7 +955,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->destructor = batadv_softif_free;
-	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
 	dev->priv_flags |= IFF_NO_QUEUE;
 
 	/* can't call min_mtu, because the needed variables
-- 
2.7.0

