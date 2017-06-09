Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  9 Jun 2017 09:05:10 +0200
Message-Id: <20170609070510.19552-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Fix inconsistent teardown and
 release of private netdev state.
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

From: "David S. Miller" <davem@davemloft.net>

Network devices can allocate reasources and private memory using
netdev_ops->ndo_init().  However, the release of these resources
can occur in one of two different places.

Either netdev_ops->ndo_uninit() or netdev->destructor().

The decision of which operation frees the resources depends upon
whether it is necessary for all netdev refs to be released before it
is safe to perform the freeing.

netdev_ops->ndo_uninit() presumably can occur right after the
NETDEV_UNREGISTER notifier completes and the unicast and multicast
address lists are flushed.

netdev->destructor(), on the other hand, does not run until the
netdev references all go away.

Further complicating the situation is that netdev->destructor()
almost universally does also a free_netdev().

This creates a problem for the logic in register_netdevice().
Because all callers of register_netdevice() manage the freeing
of the netdev, and invoke free_netdev(dev) if register_netdevice()
fails.

If netdev_ops->ndo_init() succeeds, but something else fails inside
of register_netdevice(), it does call ndo_ops->ndo_uninit().  But
it is not able to invoke netdev->destructor().

This is because netdev->destructor() will do a free_netdev() and
then the caller of register_netdevice() will do the same.

However, this means that the resources that would normally be released
by netdev->destructor() will not be.

Over the years drivers have added local hacks to deal with this, by
invoking their destructor parts by hand when register_netdevice()
fails.

Many drivers do not try to deal with this, and instead we have leaks.

Let's close this hole by formalizing the distinction between what
private things need to be freed up by netdev->destructor() and whether
the driver needs unregister_netdevice() to perform the free_netdev().

netdev->priv_destructor() performs all actions to free up the private
resources that used to be freed by netdev->destructor(), except for
free_netdev().

netdev->needs_free_netdev is a boolean that indicates whether
free_netdev() should be done at the end of unregister_netdevice().

Now, register_netdevice() can sanely release all resources after
ndo_ops->ndo_init() succeeds, by invoking both ndo_ops->ndo_uninit()
and netdev->priv_destructor().

And at the end of unregister_netdevice(), we invoke
netdev->priv_destructor() and optionally call free_netdev().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
It is an RFC because I need someone clever to create the compat code for this.

 net/batman-adv/soft-interface.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index b25789a..10f7edf 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1034,8 +1034,6 @@ static void batadv_softif_free(struct net_device *dev)
 	 * netdev and its private data (bat_priv)
 	 */
 	rcu_barrier();
-
-	free_netdev(dev);
 }
 
 /**
@@ -1047,7 +1045,8 @@ static void batadv_softif_init_early(struct net_device *dev)
 	ether_setup(dev);
 
 	dev->netdev_ops = &batadv_netdev_ops;
-	dev->destructor = batadv_softif_free;
+	dev->needs_free_netdev = true;
+	dev->priv_destructor = batadv_softif_free;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_NETNS_LOCAL;
 	dev->priv_flags |= IFF_NO_QUEUE;
 
-- 
2.11.0

