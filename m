Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu,  5 May 2016 09:44:42 +0200
Message-Id: <1462434282-3307-1-git-send-email-sven.eckelmann@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: replace dev->trans_start
	update with helper
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

From: Florian Westphal <fw@strlen.de>

Replace all trans_start updates with netif_trans_update helper.
change was done via spatch:

struct net_device *d;
@@
- d->trans_start = jiffies
+ netif_trans_update(d)

Compile tested only.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
Warning: untested

 compat-include/linux/netdevice.h | 10 ++++++++++
 net/batman-adv/soft-interface.c  |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index f47f5c3..fb5b519 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -74,4 +74,14 @@
 
 #endif /* < KERNEL_VERSION(4, 5, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 7, 0)
+
+#define netif_trans_update batadv_netif_trans_update
+static inline void batadv_netif_trans_update(struct net_device *dev)
+{
+	dev->trans_start = jiffies;
+}
+
+#endif /* < KERNEL_VERSION(4, 7, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_ */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 31d1df2..b349287 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -207,7 +207,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
-	soft_iface->trans_start = jiffies;
+	netif_trans_update(soft_iface);
 	vid = batadv_get_vid(skb, 0);
 	ethhdr = eth_hdr(skb);
 
-- 
2.8.1

