Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  3 Feb 2013 19:41:54 +0100
Message-Id: <1359916914-9798-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1405827.5RSdDMUrGW@sven-desktop.home.narfation.org>
References: <1405827.5RSdDMUrGW@sven-desktop.home.narfation.org>
Subject: [B.A.T.M.A.N.] [FIX] batman-adv: fix master setting in rtnl
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

Sven: I think this is enough to account the correct "master" setting? In net-next it
is now called upper_device and they also changed some api. Therefore a compat
solution is also provided.

Cheers,

 compat.h         | 2 ++
 hard-interface.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index e21b310..e5807d7 100644
--- a/compat.h
+++ b/compat.h
@@ -211,6 +211,8 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p) \
 }\
 static int __batadv_interface_set_mac_addr(x, y)
 
+#define netdev_master_upper_dev_link netdev_set_master
+
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index 6c32607..bbc6188 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -313,7 +313,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	struct batadv_priv *bat_priv;
 	struct net_device *soft_iface;
 	__be16 ethertype = __constant_htons(ETH_P_BATMAN);
-	int ret;
+	int ret = 0;
 
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		goto out;
@@ -398,6 +398,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	/* begin scheduling originator messages on that interface */
 	batadv_schedule_bat_ogm(hard_iface);
 
+	ret = netdev_master_upper_dev_link(hard_iface->net_dev, soft_iface);
+	if (ret)
+		goto err_dev;
+
 out:
 	return 0;
 
-- 
1.8.1.2

