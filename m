Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 3/4] batman-adv: Don't manually reattach hard-interface
Date: Wed,  2 Jun 2021 22:32:34 +0200
Message-Id: <20210602203235.10659-3-sven@narfation.org>
In-Reply-To: <20210602203235.10659-1-sven@narfation.org>
References: <20210602203235.10659-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

The batadv_hardif_enable_interface is now only called from the callback
ndo_add_slave. This callback is only used by do_set_master in the rtnetlink
code which only does two things:

1. remove the net_device from its old master
2. add the net_device to its new batadv master

The code to replicate the first step in batman-adv is therefore unused
since the sysfs code was dropped.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 34 ---------------------------------
 1 file changed, 34 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 44b65fa4..6ce75ec6 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -677,31 +677,6 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 	batadv_update_min_mtu(hard_iface->soft_iface);
 }
 
-/**
- * batadv_master_del_slave() - remove hard_iface from the current master iface
- * @slave: the interface enslaved in another master
- * @master: the master from which slave has to be removed
- *
- * Invoke ndo_del_slave on master passing slave as argument. In this way the
- * slave is free'd and the master can correctly change its internal state.
- *
- * Return: 0 on success, a negative value representing the error otherwise
- */
-static int batadv_master_del_slave(struct batadv_hard_iface *slave,
-				   struct net_device *master)
-{
-	int ret;
-
-	if (!master)
-		return 0;
-
-	ret = -EBUSY;
-	if (master->netdev_ops->ndo_del_slave)
-		ret = master->netdev_ops->ndo_del_slave(master, slave->net_dev);
-
-	return ret;
-}
-
 /**
  * batadv_hardif_enable_interface() - Enslave hard interface to soft interface
  * @hard_iface: hard interface to add to soft interface
@@ -713,7 +688,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv;
-	struct net_device *master;
 	__be16 ethertype = htons(ETH_P_BATMAN);
 	int max_header_len = batadv_max_header_len();
 	int ret;
@@ -732,14 +706,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		goto err_dev;
 	}
 
-	/* check if the interface is enslaved in another virtual one and
-	 * in that case unlink it first
-	 */
-	master = netdev_master_upper_dev_get(hard_iface->net_dev);
-	ret = batadv_master_del_slave(hard_iface, master);
-	if (ret)
-		goto err_dev;
-
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-- 
2.30.2

