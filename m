Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 13 Jan 2013 17:51:02 +0800
Message-Id: <1358070663-8226-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1358070663-8226-1-git-send-email-lindner_marek@yahoo.de>
References: <201301131750.39338.lindner_marek@yahoo.de>
 <1358070663-8226-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 5/6] batman-adv: Allow to use rntl_link for
	device creation/deletion
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
Cc: Sven Eckelmann <sven@narfation.org>

From: Sven Eckelmann <sven@narfation.org>

The sysfs configuration interface of batman-adv to add/remove soft-interfaces
is not deadlock free and doesn't follow the currently common way to create new
virtual interfaces.

An additional interface though rtnl_link is introduced which provides easy device
creation/deletion with tools like "ip":

$ ip link add dev bat0 type batadv
$ ip link del dev bat0

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c           |    2 ++
 main.h           |    1 +
 soft-interface.c |   29 +++++++++++++++++++++++++++++
 soft-interface.h |    1 +
 4 files changed, 33 insertions(+)

diff --git a/main.c b/main.c
index 21fe698..d3752a4 100644
--- a/main.c
+++ b/main.c
@@ -70,6 +70,7 @@ static int __init batadv_init(void)
 	batadv_debugfs_init();
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
+	rtnl_link_register(&batadv_link_ops);
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
 		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
@@ -80,6 +81,7 @@ static int __init batadv_init(void)
 static void __exit batadv_exit(void)
 {
 	batadv_debugfs_destroy();
+	rtnl_link_unregister(&batadv_link_ops);
 	unregister_netdevice_notifier(&batadv_hard_if_notifier);
 	batadv_hardif_remove_interfaces();
 
diff --git a/main.h b/main.h
index 7cebbfd..d779303 100644
--- a/main.h
+++ b/main.h
@@ -150,6 +150,7 @@ enum batadv_uev_type {
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
+#include <net/rtnetlink.h>
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
 #include "compat.h"
diff --git a/soft-interface.c b/soft-interface.c
index bf19605..d9f27d5 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -567,6 +567,8 @@ struct net_device *batadv_softif_create(const char *name)
 	if (!soft_iface)
 		return NULL;
 
+	soft_iface->rtnl_link_ops = &batadv_link_ops;
+
 	ret = register_netdevice(soft_iface);
 	if (ret < 0) {
 		pr_err("Unable to register the batman interface '%s': %i\n",
@@ -589,6 +591,26 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface)
 	queue_work(batadv_event_workqueue, &bat_priv->cleanup_work);
 }
 
+/**
+ * batadv_softif_destroy_netlink - deletion of batadv_soft_interface via netlink
+ * @soft_iface: the to be removed batman-adv interface
+ * @head: list pointer
+ */
+void batadv_softif_destroy_netlink(struct net_device *soft_iface,
+				   struct list_head *head)
+{
+	struct batadv_hard_iface *hard_iface;
+
+	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface == soft_iface)
+			batadv_hardif_disable_interface(hard_iface,
+							BATADV_IF_CLEANUP_KEEP);
+	}
+
+	batadv_sysfs_del_meshif(soft_iface);
+	unregister_netdevice_queue(soft_iface, head);
+}
+
 int batadv_softif_is_valid(const struct net_device *net_dev)
 {
 	if (net_dev->netdev_ops->ndo_start_xmit == batadv_interface_tx)
@@ -597,6 +619,13 @@ int batadv_softif_is_valid(const struct net_device *net_dev)
 	return 0;
 }
 
+struct rtnl_link_ops batadv_link_ops __read_mostly = {
+	.kind		= "batadv",
+	.priv_size	= sizeof(struct batadv_priv),
+	.setup		= batadv_softif_init_early,
+	.dellink	= batadv_softif_destroy_netlink,
+};
+
 /* ethtool */
 static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
diff --git a/soft-interface.h b/soft-interface.h
index 49bc66b..2f2472c 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -27,5 +27,6 @@ void batadv_interface_rx(struct net_device *soft_iface,
 struct net_device *batadv_softif_create(const char *name);
 void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
+extern struct rtnl_link_ops batadv_link_ops;
 
 #endif /* _NET_BATMAN_ADV_SOFT_INTERFACE_H_ */
-- 
1.7.10.4

