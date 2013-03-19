Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 19 Mar 2013 20:48:32 +0100
Message-Id: <1363722512-3619-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix old master freeing
	operation
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

When a new hard_iface has a master already, ndo_del_slave
has to be used in order to let the old master perform its
cleaning up routing correctly. Unregistering the master
iface only could lead to a inconsistent state in the old
master knowledge.

Introduced by 5e57e3bff429cd403f0e30af69cf87a2cd55598f
("batman-adv: free an hard-interface before adding it").

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- patch restyled
- added compat code for <2.6.39 (Thanks to Simon)


 compat.h         |  4 +++-
 hard-interface.c | 29 +++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index ba07ae4..a5a4f1d 100644
--- a/compat.h
+++ b/compat.h
@@ -161,8 +161,10 @@ static const struct { \
 } __attribute__((unused)) __useless_ops1 = { \
 	.ndo_validate_addr
 
-#endif /* < KERNEL_VERSION(2, 6, 39) */
+#define ndo_del_slave          ndo_init
+#define ndo_init(x, y)         ndo_init - master->netdev_ops->ndo_init - EINVAL
 
+#endif /* < KERNEL_VERSION(2, 6, 39) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
diff --git a/hard-interface.c b/hard-interface.c
index fd99e42..b7fb9c0 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -307,6 +307,30 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 	batadv_update_min_mtu(hard_iface->soft_iface);
 }
 
+/**
+ * batadv_master_del_slave - remove hard_iface from the current master interface
+ * @slave: the interface enslaved in another master
+ * @master: the master from which slave has to be removed
+ *
+ * Invoke ndo_del_slave on master passing slave as argument. In this way slave
+ * is free'd and master can correctly change its internal state.
+ * Return 0 on success, a negative value representing the error otherwise
+ */
+static int batadv_master_del_slave(struct batadv_hard_iface *slave,
+				   struct net_device *master)
+{
+	int ret;
+
+	if (!master)
+		return 0;
+
+	ret = -EINVAL;
+	if (master->netdev_ops->ndo_del_slave)
+		ret = master->netdev_ops->ndo_del_slave(master, slave->net_dev);
+
+	return ret;
+}
+
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   const char *iface_name)
 {
@@ -346,8 +370,9 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	 * in that case unlink it first
 	 */
 	master = netdev_master_upper_dev_get(hard_iface->net_dev);
-	if (master)
-		netdev_upper_dev_unlink(hard_iface->net_dev, master);
+	ret = batadv_master_del_slave(hard_iface, master);
+	if (ret)
+		goto err_dev;
 
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
-- 
1.8.1.5

