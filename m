Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 20 Jan 2016 18:48:28 +0100
Message-Id: <1453312110-32683-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Create batman soft
	interfaces within correct netns.
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

When creating a soft interface, create it in the same netns as the
hard interface. Replace all references to init_net with the correct
name space for the interface being manipulated.

Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/batman-adv/hard-interface.c    | 9 +++++----
 net/batman-adv/hard-interface.h    | 2 +-
 net/batman-adv/soft-interface.c    | 7 +++++--
 net/batman-adv/soft-interface.h    | 2 +-
 net/batman-adv/sysfs.c             | 3 ++-
 net/batman-adv/translation-table.c | 3 ++-
 6 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f11345e..a5ce58a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -90,6 +90,7 @@ out:
 static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 {
 	struct net_device *parent_dev;
+	struct net *net = dev_net(net_dev);
 	bool ret;
 
 	/* check if this is a batman-adv mesh interface */
@@ -102,7 +103,7 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 		return false;
 
 	/* recurse over the parent device */
-	parent_dev = __dev_get_by_index(&init_net, dev_get_iflink(net_dev));
+	parent_dev = __dev_get_by_index(net, dev_get_iflink(net_dev));
 	/* if we got a NULL parent_dev there is something broken.. */
 	if (WARN(!parent_dev, "Cannot find parent device"))
 		return false;
@@ -418,7 +419,7 @@ static int batadv_master_del_slave(struct batadv_hard_iface *slave,
 }
 
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
-				   const char *iface_name)
+				   struct net *net, const char *iface_name)
 {
 	struct batadv_priv *bat_priv;
 	struct net_device *soft_iface, *master;
@@ -432,10 +433,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (!atomic_inc_not_zero(&hard_iface->refcount))
 		goto out;
 
-	soft_iface = dev_get_by_name(&init_net, iface_name);
+	soft_iface = dev_get_by_name(net, iface_name);
 
 	if (!soft_iface) {
-		soft_iface = batadv_softif_create(iface_name);
+		soft_iface = batadv_softif_create(net, iface_name);
 
 		if (!soft_iface) {
 			ret = -ENOMEM;
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 5a31420..4ed737f 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -55,7 +55,7 @@ bool batadv_is_wifi_iface(int ifindex);
 struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
-				   const char *iface_name);
+				   struct net *net, const char *iface_name);
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 				     enum batadv_hard_if_cleanup autodel);
 void batadv_hardif_remove_interfaces(void);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index f3f096c0..2eeec3d 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -853,13 +853,14 @@ static int batadv_softif_slave_add(struct net_device *dev,
 				   struct net_device *slave_dev)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct net *net = dev_net(dev);
 	int ret = -EINVAL;
 
 	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
 	if (!hard_iface || hard_iface->soft_iface)
 		goto out;
 
-	ret = batadv_hardif_enable_interface(hard_iface, dev->name);
+	ret = batadv_hardif_enable_interface(hard_iface, net, dev->name);
 
 out:
 	if (hard_iface)
@@ -956,7 +957,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	memset(priv, 0, sizeof(*priv));
 }
 
-struct net_device *batadv_softif_create(const char *name)
+struct net_device *batadv_softif_create(struct net *net, const char *name)
 {
 	struct net_device *soft_iface;
 	int ret;
@@ -966,6 +967,8 @@ struct net_device *batadv_softif_create(const char *name)
 	if (!soft_iface)
 		return NULL;
 
+	dev_net_set(soft_iface, net);
+
 	soft_iface->rtnl_link_ops = &batadv_link_ops;
 
 	ret = register_netdevice(soft_iface);
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 8e82176..d616cd5 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -29,7 +29,7 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *soft_iface,
 			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
 			 int hdr_size, struct batadv_orig_node *orig_node);
-struct net_device *batadv_softif_create(const char *name);
+struct net_device *batadv_softif_create(struct net *net, const char *name);
 void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 9de3c88..d6867da 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -773,6 +773,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 				       size_t count)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	struct net *net = dev_net(net_dev);
 	struct batadv_hard_iface *hard_iface;
 	int status_tmp = -1;
 	int ret = count;
@@ -816,7 +817,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 		batadv_hardif_disable_interface(hard_iface,
 						BATADV_IF_CLEANUP_AUTO);
 
-	ret = batadv_hardif_enable_interface(hard_iface, buff);
+	ret = batadv_hardif_enable_interface(hard_iface, net, buff);
 
 unlock:
 	rtnl_unlock();
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 76f19ba..0dbda83 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -534,6 +534,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_tt_global_entry *tt_global = NULL;
+	struct net *net = dev_net(soft_iface);
 	struct batadv_softif_vlan *vlan;
 	struct net_device *in_dev = NULL;
 	struct hlist_head *head;
@@ -545,7 +546,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	u32 match_mark;
 
 	if (ifindex != BATADV_NULL_IFINDEX)
-		in_dev = dev_get_by_index(&init_net, ifindex);
+		in_dev = dev_get_by_index(net, ifindex);
 
 	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
 
-- 
2.7.0.rc3

