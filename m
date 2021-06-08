Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 08/11] batman-adv: Drop implicit creation of batadv net_devices
Date: Tue,  8 Jun 2021 17:26:57 +0200
Message-Id: <20210608152700.30315-9-sw@simonwunderlich.de>
In-Reply-To: <20210608152700.30315-1-sw@simonwunderlich.de>
References: <20210608152700.30315-1-sw@simonwunderlich.de>
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
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The sysfs code in batman-adv was could create a new batadv interfaces on
demand when a string (interface name) was written to the
batman-adv/mesh_iface file. But the code no longer exists in the current
batman-adv codebase. The helper code to implement this behavior must be
considered as unused and can be dropped.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 12 ++----------
 net/batman-adv/soft-interface.c | 34 +--------------------------------
 net/batman-adv/soft-interface.h |  2 --
 3 files changed, 3 insertions(+), 45 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index b99f64f483fc..a638f35598f0 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,17 +725,9 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	kref_get(&hard_iface->refcount);
 
 	soft_iface = dev_get_by_name(net, iface_name);
-
 	if (!soft_iface) {
-		soft_iface = batadv_softif_create(net, iface_name);
-
-		if (!soft_iface) {
-			ret = -ENOMEM;
-			goto err;
-		}
-
-		/* dev_get_by_name() increases the reference counter for us */
-		dev_hold(soft_iface);
+		ret = -EINVAL;
+		goto err;
 	}
 
 	if (!batadv_softif_is_valid(soft_iface)) {
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index a21884c0d47f..0c5b34251a6d 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -26,7 +26,6 @@
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/percpu.h>
-#include <linux/printk.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -37,6 +36,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <net/net_namespace.h>
 #include <net/netlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
@@ -1086,38 +1086,6 @@ static int batadv_softif_newlink(struct net *src_net, struct net_device *dev,
 	return register_netdevice(dev);
 }
 
-/**
- * batadv_softif_create() - Create and register soft interface
- * @net: the applicable net namespace
- * @name: name of the new soft interface
- *
- * Return: newly allocated soft_interface, NULL on errors
- */
-struct net_device *batadv_softif_create(struct net *net, const char *name)
-{
-	struct net_device *soft_iface;
-	int ret;
-
-	soft_iface = alloc_netdev(sizeof(struct batadv_priv), name,
-				  NET_NAME_UNKNOWN, batadv_softif_init_early);
-	if (!soft_iface)
-		return NULL;
-
-	dev_net_set(soft_iface, net);
-
-	soft_iface->rtnl_link_ops = &batadv_link_ops;
-
-	ret = register_netdevice(soft_iface);
-	if (ret < 0) {
-		pr_err("Unable to register the batman interface '%s': %i\n",
-		       name, ret);
-		free_netdev(soft_iface);
-		return NULL;
-	}
-
-	return soft_iface;
-}
-
 /**
  * batadv_softif_destroy_netlink() - deletion of batadv_soft_interface via
  *  netlink
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 38b0ad182584..67a2ddd6832f 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -12,14 +12,12 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
-#include <net/net_namespace.h>
 #include <net/rtnetlink.h>
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *soft_iface,
 			 struct sk_buff *skb, int hdr_size,
 			 struct batadv_orig_node *orig_node);
-struct net_device *batadv_softif_create(struct net *net, const char *name);
 bool batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
-- 
2.20.1

