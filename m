Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  3 Mar 2013 18:34:36 +0100
Message-Id: <1362332076-27516-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix old master freeing operation
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

When a new hard_iface has a master already, ndo_del_slave
has to be used in order to let the old master perform its
cleaning up routing correctly. Unregistering the master
iface only could lead to a inconsistent state in the old
master knowledge.

Introduced by 5e57e3bff429cd403f0e30af69cf87a2cd55598f
("batman-adv: free an hard-interface before adding it").

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hard-interface.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index fd99e42..f446e69 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -346,8 +346,15 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	 * in that case unlink it first
 	 */
 	master = netdev_master_upper_dev_get(hard_iface->net_dev);
-	if (master)
-		netdev_upper_dev_unlink(hard_iface->net_dev, master);
+	if (master && master->netdev_ops->ndo_del_slave) {
+		ret = master->netdev_ops->ndo_del_slave(master,
+							hard_iface->net_dev);
+		if (ret < 0)
+			goto err_dev;
+	} else if (master) {
+		ret = -EINVAL;
+		goto err_dev;
+	}
 
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
-- 
1.8.1.5

