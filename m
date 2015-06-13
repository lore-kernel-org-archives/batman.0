Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
Date: Fri, 12 Jun 2015 23:37:14 -0400
Message-Id: <1434166634-11050-1-git-send-email-xerofoify@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv:Make the function
	batadv_softif_is_valid bool
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
To: mareklindner@neomailbox.ch
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, antonio@meshcoding.com, davem@davemloft.net

This makes the function batadv_softif_is_valid bool
due to this particular function only returning either
one or zero aas it s return value.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/batman-adv/soft-interface.c | 6 +++---
 net/batman-adv/soft-interface.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5ec31d7..dc683c8 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -974,12 +974,12 @@ static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
 	unregister_netdevice_queue(soft_iface, head);
 }
 
-int batadv_softif_is_valid(const struct net_device *net_dev)
+bool batadv_softif_is_valid(const struct net_device *net_dev)
 {
 	if (net_dev->netdev_ops->ndo_start_xmit == batadv_interface_tx)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 struct rtnl_link_ops batadv_link_ops __read_mostly = {
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index dbab22f..48a7aa4 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -24,7 +24,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 			 int hdr_size, struct batadv_orig_node *orig_node);
 struct net_device *batadv_softif_create(const char *name);
 void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
-int batadv_softif_is_valid(const struct net_device *net_dev);
+bool batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
 void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *softif_vlan);
-- 
2.1.4

