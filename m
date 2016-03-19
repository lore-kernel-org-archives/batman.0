Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Mar 2016 13:55:21 +0100
Message-Id: <1458392121-23608-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Deactive TO_BE_ACTIVATED hardif
	on shutdown
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

The shutdown of an batman-adv interface can happen with one of its slave
interfaces still being in the BATADV_IF_TO_BE_ACTIVATED state. A possible
reason for it is that the routing algorithm BATMAN_V was selected and
batadv_schedule_bat_ogm was not yet called for this interface. This slave
interface still has to be set to BATADV_IF_INACTIVE or the batman-adv
interface will never reduce its usage counter and thus never gets shutdown.

This problem can be simulated via:

    $ modprobe dummy
    $ modprobe batman-adv routing_algo=BATMAN_V
    $ ip link add bat0 type batadv
    $ ip link set dummy0 master bat0
    $ ip link set dummy0 up
    $ ip link del bat0
    unregister_netdevice: waiting for bat0 to become free. Usage count = 3

Fixes: 88861ea9acb7 ("[batman-adv] replacing if up/down timer with kernel notifications")
Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Please check https://www.open-mesh.org/issues/248 to learn more about the
bug

I have not checked why batadv_schedule_bat_ogm isn't called successfully
(which would mark the interface as active) in this situation.
---
 net/batman-adv/hard-interface.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 3240a67..f41b472 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -572,8 +572,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 
-	if (hard_iface->if_status == BATADV_IF_ACTIVE)
-		batadv_hardif_deactivate_interface(hard_iface);
+	batadv_hardif_deactivate_interface(hard_iface);
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
 		goto out;
-- 
2.8.0.rc3

