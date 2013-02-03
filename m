Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  3 Feb 2013 20:02:19 +0100
Message-Id: <1359918139-12130-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1359916914-9798-1-git-send-email-ordex@autistici.org>
References: <1359916914-9798-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [FIXv2] batman-adv: fix master setting in rtnl
	interface
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

To be merged with ("batman-adv: Allow to modify slaves of soft-interfaces
through rntl_link")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- ndo_del_slave() also have to unset the master/upper_dev device


 compat.h         | 3 +++
 hard-interface.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/compat.h b/compat.h
index e21b310..2fe555f 100644
--- a/compat.h
+++ b/compat.h
@@ -211,6 +211,9 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p) \
 }\
 static int __batadv_interface_set_mac_addr(x, y)
 
+#define netdev_master_upper_dev_link netdev_set_master
+#define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
+
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index 6c32607..f034f26 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -398,6 +398,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	/* begin scheduling originator messages on that interface */
 	batadv_schedule_bat_ogm(hard_iface);
 
+	ret = netdev_master_upper_dev_link(hard_iface->net_dev, soft_iface);
+	if (ret)
+		goto err_dev;
+
 out:
 	return 0;
 
@@ -450,6 +454,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	if (!bat_priv->num_ifaces && autodel == BATADV_IF_CLEANUP_AUTO)
 		batadv_softif_destroy_sysfs(hard_iface->soft_iface);
 
+	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
 	hard_iface->soft_iface = NULL;
 	batadv_hardif_free_ref(hard_iface);
 
-- 
1.8.1.2

