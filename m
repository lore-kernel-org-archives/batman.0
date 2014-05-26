Return-Path: <danielehlers@mindeye.net>
Message-ID: <538314F7.1070404@mindeye.net>
Date: Mon, 26 May 2014 12:18:31 +0200
From: Daniel Ehlers <danielehlers@mindeye.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Restrict movement of batman
 interfaces between netns.
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

We shall _not_ move composed interfaces between network namespaces.
Should fix issue #179, though I only tested it in a pure netns enviroment
and not in a more complex lxc setup.

Signed-off-by: Daniel Ehlers <danielehlers@mindeye.net>
---
 soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index e783afb..dcaf02b 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -909,7 +909,7 @@ static void batadv_softif_init_early(struct net_device *dev)
  	dev->netdev_ops = &batadv_netdev_ops;
 	dev->destructor = batadv_softif_free;
-	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
 	dev->tx_queue_len = 0;
  	/* can't call min_mtu, because the needed variables
-- 
1.9.2


