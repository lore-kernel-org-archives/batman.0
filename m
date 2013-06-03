Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  3 Jun 2013 11:48:50 +0200
Message-Id: <1370252930-3601-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next] net: pass info struct via netdevice
	notifier
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

From: Jiri Pirko <jiri@resnulli.us>

So far, only net_device * could be passed along with netdevice notifier
event. This patch provides a possibility to pass custom structure
able to provide info that event listener needs to know.

Signed-off-by: Jiri Pirko <jiri@resnulli.us>

v2->v3: fix typo on simeth
	shortened dev_getter
	shortened notifier_info struct name
v1->v2: fix notifier_call parameter in call_netdevice_notifier()
Signed-off-by: David S. Miller <davem@davemloft.net>
[ordex@autistici.org: added compat code]
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.h         | 6 ++++++
 hard-interface.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index 08b7500..17ef089 100644
--- a/compat.h
+++ b/compat.h
@@ -302,4 +302,10 @@ static int __batadv_interface_set_mac_addr(x, y)
 
 #endif /* < KERNEL_VERSION(3, 10, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
+
+#define netdev_notifier_info_to_dev(ptr) ptr
+
+#endif /* < KERNEL_VERSION(3, 11, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index dc4ac29..c478e6b 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -645,7 +645,7 @@ void batadv_hardif_remove_interfaces(void)
 static int batadv_hard_if_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
-	struct net_device *net_dev = ptr;
+	struct net_device *net_dev = netdev_notifier_info_to_dev(ptr);
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_priv *bat_priv;
-- 
1.8.1.5

