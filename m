Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  8 Dec 2015 21:35:58 +0100
Message-Id: <1449606958-6548-1-git-send-email-sven@narfation.org>
In-Reply-To: <1449606915-6457-1-git-send-email-sven@narfation.org>
References: <1449606915-6457-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next 3/3] batman-adv: Act on
	NETDEV_*_TYPE_CHANGE events
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

From: Andrew Lunn <andrew@lunn.ch>

A network interface can change type. It may change from a type which
batman does not support, e.g. hdlc, to one it does, e.g. hdlc-eth.
When an interface changes type, it sends two notifications. Handle
these notifications.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 compat-include/linux/netdevice.h | 3 +++
 net/batman-adv/hard-interface.c  | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 34e5ac7..10253e0 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -58,6 +58,9 @@ struct batadv_dev_addr_list {
 	int da_gusers;
 };
 
+#define NETDEV_PRE_TYPE_CHANGE	0x000E
+#define NETDEV_POST_TYPE_CHANGE	0x000F
+
 #endif /* < KERNEL_VERSION(2, 6, 35) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 2d1470f..49e05d2 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -714,7 +714,8 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	}
 
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
-	if (!hard_iface && event == NETDEV_REGISTER)
+	if (!hard_iface && (event == NETDEV_REGISTER ||
+			    event == NETDEV_POST_TYPE_CHANGE))
 		hard_iface = batadv_hardif_add_interface(net_dev);
 
 	if (!hard_iface)
@@ -729,6 +730,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		batadv_hardif_deactivate_interface(hard_iface);
 		break;
 	case NETDEV_UNREGISTER:
+	case NETDEV_PRE_TYPE_CHANGE:
 		list_del_rcu(&hard_iface->list);
 
 		batadv_hardif_remove_interface(hard_iface);
-- 
2.6.2

