Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 19 Nov 2016 14:35:21 +0100
Message-Id: <20161119133528.1379-2-sw@simonwunderlich.de>
In-Reply-To: <20161119133528.1379-1-sw@simonwunderlich.de>
References: <20161119133528.1379-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Return non-const ptr in
	batadv_getlink_net
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The returned net_namespace of batadv_getlink_net may be used with functions
that potentially modify the struct. Thus it must return the pointer as
non-const like rtnl_link_ops::get_link_net does.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index a7a462e..fdbb47e 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -92,8 +92,8 @@ batadv_hardif_get_by_netdev(const struct net_device *net_dev)
  *
  * Return: result of rtnl_link_ops->get_link_net or @fallback_net
  */
-static const struct net *batadv_getlink_net(const struct net_device *netdev,
-					    const struct net *fallback_net)
+static struct net *batadv_getlink_net(const struct net_device *netdev,
+				      struct net *fallback_net)
 {
 	if (!netdev->rtnl_link_ops)
 		return fallback_net;
@@ -116,9 +116,9 @@ static const struct net *batadv_getlink_net(const struct net_device *netdev,
  * Return: true if the devices are each others parent, otherwise false
  */
 static bool batadv_mutual_parents(const struct net_device *dev1,
-				  const struct net *net1,
+				  struct net *net1,
 				  const struct net_device *dev2,
-				  const struct net *net2)
+				  struct net *net2)
 {
 	int dev1_parent_iflink = dev_get_iflink(dev1);
 	int dev2_parent_iflink = dev_get_iflink(dev2);
@@ -154,7 +154,7 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 {
 	struct net *net = dev_net(net_dev);
 	struct net_device *parent_dev;
-	const struct net *parent_net;
+	struct net *parent_net;
 	bool ret;
 
 	/* check if this is a batman-adv mesh interface */
-- 
2.10.2

