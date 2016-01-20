Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 20 Jan 2016 18:48:29 +0100
Message-Id: <1453312110-32683-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Handle parent interfaces in
	a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

batman-adv tries to prevent the user from placing a batX soft
interface into another batman mesh as a hard interface. It does this
by walking up the devices list of parents and ensures they are all
none batX interfaces. iflink can point to an interface in a different
nameplace, so also retrieve the parents name space when finding the
parent.

Additionally, veth devices come in pairs and they are each others
parents. Don't infinitely recurse in this situation.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/hard-interface.c | 44 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index a5ce58a..8d51a4a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -75,6 +75,39 @@ out:
 }
 
 /**
+ * batadv_mutual_parents - check if two devices are each others parent
+ * @net_dev - 1st parent
+ * @parent_dev - 2nd parent
+ *
+ * veth devices come in pairs and each is the parent of the other!
+ *
+ * Return true if the devices are each others parent, otherwise false
+ */
+static bool batadv_mutual_parents(const struct net_device *dev1,
+				  const struct net *dev1_net,
+				  const struct net_device *dev2,
+				  const struct net *dev2_net)
+{
+	int dev1_parent_iflink = dev_get_iflink(dev1);
+	int dev2_parent_iflink = dev_get_iflink(dev2);
+	const struct net *dev1_parent_net = dev1_net;
+	const struct net *dev2_parent_net = dev2_net;
+
+	if (dev1->rtnl_link_ops && dev1->rtnl_link_ops->get_link_net)
+		dev1_parent_net = dev1->rtnl_link_ops->get_link_net(dev1);
+	if (dev2->rtnl_link_ops && dev2->rtnl_link_ops->get_link_net)
+		dev2_parent_net = dev2->rtnl_link_ops->get_link_net(dev2);
+
+	if (!dev1_parent_iflink || !dev2_parent_iflink)
+		return false;
+
+	return (dev1_parent_iflink == dev2->ifindex) &&
+		(dev2_parent_iflink == dev1->ifindex) &&
+		net_eq(dev1_parent_net, dev2_net) &&
+		net_eq(dev2_parent_net, dev1_net);
+}
+
+/**
  * batadv_is_on_batman_iface - check if a device is a batman iface descendant
  * @net_dev: the device to check
  *
@@ -89,8 +122,9 @@ out:
  */
 static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 {
-	struct net_device *parent_dev;
 	struct net *net = dev_net(net_dev);
+	struct net_device *parent_dev;
+	struct net *parent_net = net;
 	bool ret;
 
 	/* check if this is a batman-adv mesh interface */
@@ -102,12 +136,18 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 	    dev_get_iflink(net_dev) == net_dev->ifindex)
 		return false;
 
+	if (net_dev->rtnl_link_ops && net_dev->rtnl_link_ops->get_link_net)
+		parent_net = net_dev->rtnl_link_ops->get_link_net(net_dev);
+
 	/* recurse over the parent device */
-	parent_dev = __dev_get_by_index(net, dev_get_iflink(net_dev));
+	parent_dev = __dev_get_by_index(parent_net, dev_get_iflink(net_dev));
 	/* if we got a NULL parent_dev there is something broken.. */
 	if (WARN(!parent_dev, "Cannot find parent device"))
 		return false;
 
+	if (batadv_mutual_parents(net_dev, net, parent_dev, parent_net))
+		return false;
+
 	ret = batadv_is_on_batman_iface(parent_dev);
 
 	return ret;
-- 
2.7.0.rc3

