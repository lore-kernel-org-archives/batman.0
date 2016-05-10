Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 11 May 2016 03:29:51 +0800
Message-Id: <1462908605-27412-4-git-send-email-a@unstable.cc>
In-Reply-To: <1462908605-27412-1-git-send-email-a@unstable.cc>
References: <1462908605-27412-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: NETIF_F_NETNS_LOCAL
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Andrew Lunn <andrew@lunn.ch>

The batX soft interface should not be moved between network name
spaces. This is similar to bridges, bonds, tunnels, which are not
allowed to move between network namespaces.

Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Antonio Quartulli <a@unstable.cc>
Reviewed-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d72f88707736..66dd0aac480a 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -972,7 +972,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->destructor = batadv_softif_free;
-	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
 	dev->priv_flags |= IFF_NO_QUEUE;
 
 	/* can't call min_mtu, because the needed variables
-- 
2.8.2

