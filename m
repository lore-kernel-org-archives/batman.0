Return-Path: <danielehlers@mindeye.net>
Message-ID: <538314FE.9020808@mindeye.net>
Date: Mon, 26 May 2014 12:18:38 +0200
From: Daniel Ehlers <danielehlers@mindeye.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Init and use batman
 interface with correc netns.
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

Enables us to use batman-adv inside of network namespaces.
Unfortunately it does not enable us to use multiple batX interfaces
in different namespaces. This limitation results from using
debugfs and its unawareness of namespaces.

Signed-off-by: Daniel Ehlers <danielehlers@mindeye.net>
---
 hard-interface.c    | 10 ++++++----
 hard-interface.h    |  2 +-
 soft-interface.c    |  8 ++++++--
 soft-interface.h    |  2 +-
 sysfs.c             |  4 +++-
 translation-table.c |  4 +++-
 6 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index b851cc5..c3497de 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -31,6 +31,7 @@
  #include <linux/if_arp.h>
 #include <linux/if_ether.h>
+#include <net/net_namespace.h>
  void batadv_hardif_free_rcu(struct rcu_head *rcu)
 {
@@ -76,6 +77,7 @@ out:
 static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 {
 	struct net_device *parent_dev;
+	struct net *net = dev_net(net_dev);
 	bool ret;
  	/* check if this is a batman-adv mesh interface */
@@ -87,7 +89,7 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 		return false;
  	/* recurse over the parent device */
-	parent_dev = __dev_get_by_index(&init_net, net_dev->iflink);
+	parent_dev = __dev_get_by_index(net, net_dev->iflink);
 	/* if we got a NULL parent_dev there is something broken.. */
 	if (WARN(!parent_dev, "Cannot find parent device"))
 		return false;
@@ -365,7 +367,7 @@ static int batadv_master_del_slave(struct batadv_hard_iface *slave,
 }
  int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
-				   const char *iface_name)
+				   struct net *net, const char *iface_name)
 {
 	struct batadv_priv *bat_priv;
 	struct net_device *soft_iface, *master;
@@ -379,10 +381,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (!atomic_inc_not_zero(&hard_iface->refcount))
 		goto out;
 -	soft_iface = dev_get_by_name(&init_net, iface_name);
+	soft_iface = dev_get_by_name(net, iface_name);
  	if (!soft_iface) {
-		soft_iface = batadv_softif_create(iface_name);
+		soft_iface = batadv_softif_create(net, iface_name);
  		if (!soft_iface) {
 			ret = -ENOMEM;
diff --git a/hard-interface.h b/hard-interface.h
index 1918cd5..00ba971 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -44,7 +44,7 @@ bool batadv_is_wifi_iface(int ifindex);
 struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
-				   const char *iface_name);
+				   struct net *net, const char *iface_name);
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 				     enum batadv_hard_if_cleanup autodel);
 void batadv_hardif_remove_interfaces(void);
diff --git a/soft-interface.c b/soft-interface.c
index dcaf02b..79c7243 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -35,6 +35,7 @@
 #include "multicast.h"
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
+#include <net/net_namespace.h>
   static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
@@ -822,13 +823,14 @@ static int batadv_softif_slave_add(struct net_device *dev,
 				   struct net_device *slave_dev)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct net *net = dev_net(dev);
 	int ret = -EINVAL;
  	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
 	if (!hard_iface || hard_iface->soft_iface != NULL)
 		goto out;
 -	ret = batadv_hardif_enable_interface(hard_iface, dev->name);
+	ret = batadv_hardif_enable_interface(hard_iface, net, dev->name);
  out:
 	if (hard_iface)
@@ -927,7 +929,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	memset(priv, 0, sizeof(*priv));
 }
 -struct net_device *batadv_softif_create(const char *name)
+struct net_device *batadv_softif_create(struct net *net, const char *name)
 {
 	struct net_device *soft_iface;
 	int ret;
@@ -937,6 +939,8 @@ struct net_device *batadv_softif_create(const char *name)
 	if (!soft_iface)
 		return NULL;
 +	dev_net_set(soft_iface, net);
+
 	soft_iface->rtnl_link_ops = &batadv_link_ops;
  	ret = register_netdevice(soft_iface);
diff --git a/soft-interface.h b/soft-interface.h
index dbab22f..c213c80 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -22,7 +22,7 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *soft_iface,
 			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
 			 int hdr_size, struct batadv_orig_node *orig_node);
-struct net_device *batadv_softif_create(const char *name);
+struct net_device *batadv_softif_create(struct net *net, const char *name);
 void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
diff --git a/sysfs.c b/sysfs.c
index fc47baa..cbd5534 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -25,6 +25,7 @@
 #include "soft-interface.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
+#include <net/net_namespace.h>
  static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
 {
@@ -754,6 +755,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 				       size_t count)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct net *net = dev_net(net_dev);
 	struct batadv_hard_iface *hard_iface;
 	int status_tmp = -1;
 	int ret = count;
@@ -797,7 +799,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 		batadv_hardif_disable_interface(hard_iface,
 						BATADV_IF_CLEANUP_AUTO);
 -	ret = batadv_hardif_enable_interface(hard_iface, buff);
+	ret = batadv_hardif_enable_interface(hard_iface, net, buff);
  unlock:
 	rtnl_unlock();
diff --git a/translation-table.c b/translation-table.c
index 5f59e7f..08d7e7d 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -27,6 +27,7 @@
 #include "multicast.h"
  #include <linux/crc32c.h>
+#include <net/net_namespace.h>
  /* hash class keys */
 static struct lock_class_key batadv_tt_local_hash_lock_class_key;
@@ -513,6 +514,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_softif_vlan *vlan;
 	struct net_device *in_dev = NULL;
+	struct net *net = dev_net(soft_iface);
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added, table_size, packet_size_max;
@@ -521,7 +523,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	uint32_t match_mark;
  	if (ifindex != BATADV_NULL_IFINDEX)
-		in_dev = dev_get_by_index(&init_net, ifindex);
+		in_dev = dev_get_by_index(net, ifindex);
  	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
 -- 1.9.2

