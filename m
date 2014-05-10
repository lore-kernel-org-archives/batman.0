Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 10 May 2014 18:56:37 +0200
Message-Id: <1399740997-30784-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add blank line between
	declarations and the rest of the code
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Reported by checkpatch with the following message:
"WARNING: Missing a blank line after declarations"

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 debugfs.c               |  9 +++++++++
 distributed-arp-table.c |  1 +
 network-coding.c        |  1 +
 sysfs.c                 | 10 ++++++++++
 4 files changed, 21 insertions(+)

diff --git a/debugfs.c b/debugfs.c
index b758881..99f2ba0 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -245,6 +245,7 @@ static int batadv_algorithms_open(struct inode *inode, struct file *file)
 static int batadv_originators_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_orig_seq_print_text, net_dev);
 }
 
@@ -258,18 +259,21 @@ static int batadv_originators_hardif_open(struct inode *inode,
 					  struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_orig_hardif_seq_print_text, net_dev);
 }
 
 static int batadv_gateways_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_gw_client_seq_print_text, net_dev);
 }
 
 static int batadv_transtable_global_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_tt_global_seq_print_text, net_dev);
 }
 
@@ -277,6 +281,7 @@ static int batadv_transtable_global_open(struct inode *inode, struct file *file)
 static int batadv_bla_claim_table_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_bla_claim_table_seq_print_text,
 			   net_dev);
 }
@@ -285,6 +290,7 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
 					  struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_bla_backbone_table_seq_print_text,
 			   net_dev);
 }
@@ -300,6 +306,7 @@ static int batadv_bla_backbone_table_open(struct inode *inode,
 static int batadv_dat_cache_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_dat_cache_seq_print_text, net_dev);
 }
 #endif
@@ -307,6 +314,7 @@ static int batadv_dat_cache_open(struct inode *inode, struct file *file)
 static int batadv_transtable_local_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_tt_local_seq_print_text, net_dev);
 }
 
@@ -319,6 +327,7 @@ struct batadv_debuginfo {
 static int batadv_nc_nodes_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
+
 	return single_open(file, batadv_nc_nodes_seq_print_text, net_dev);
 }
 #endif
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index aa5d494..dcd99b2 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -662,6 +662,7 @@ static void batadv_dat_tvlv_container_update(struct batadv_priv *bat_priv)
 void batadv_dat_status_update(struct net_device *net_dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+
 	batadv_dat_tvlv_container_update(bat_priv);
 }
 
diff --git a/network-coding.c b/network-coding.c
index a9546fe..40a2fc4 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -86,6 +86,7 @@ static void batadv_nc_tvlv_container_update(struct batadv_priv *bat_priv)
 void batadv_nc_status_update(struct net_device *net_dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+
 	batadv_nc_tvlv_container_update(bat_priv);
 }
 
diff --git a/sysfs.c b/sysfs.c
index 1ebb0d9..f51b484 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -29,12 +29,14 @@
 static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
 {
 	struct device *dev = container_of(obj->parent, struct device, kobj);
+
 	return to_net_dev(dev);
 }
 
 static struct batadv_priv *batadv_kobj_to_batpriv(struct kobject *obj)
 {
 	struct net_device *net_dev = batadv_kobj_to_netdev(obj);
+
 	return netdev_priv(net_dev);
 }
 
@@ -124,6 +126,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
+									\
 	return __batadv_store_bool_attr(buff, count, _post_func, attr,	\
 					&bat_priv->_name, net_dev);	\
 }
@@ -133,6 +136,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 			    struct attribute *attr, char *buff)		\
 {									\
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
+									\
 	return sprintf(buff, "%s\n",					\
 		       atomic_read(&bat_priv->_name) == 0 ?		\
 		       "disabled" : "enabled");				\
@@ -155,6 +159,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
+									\
 	return __batadv_store_uint_attr(buff, count, _min, _max,	\
 					_post_func, attr,		\
 					&bat_priv->_name, net_dev);	\
@@ -165,6 +170,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 			    struct attribute *attr, char *buff)		\
 {									\
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
+									\
 	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_name));	\
 }									\
 
@@ -188,6 +194,7 @@ ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
 	size_t res = __batadv_store_bool_attr(buff, count, _post_func,	\
 					      attr, &vlan->_name,	\
 					      bat_priv->soft_iface);	\
+									\
 	batadv_softif_vlan_free_ref(vlan);				\
 	return res;							\
 }
@@ -202,6 +209,7 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
 	size_t res = sprintf(buff, "%s\n",				\
 			     atomic_read(&vlan->_name) == 0 ?		\
 			     "disabled" : "enabled");			\
+									\
 	batadv_softif_vlan_free_ref(vlan);				\
 	return res;							\
 }
@@ -324,12 +332,14 @@ static ssize_t batadv_show_bat_algo(struct kobject *kobj,
 				    struct attribute *attr, char *buff)
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+
 	return sprintf(buff, "%s\n", bat_priv->bat_algo_ops->name);
 }
 
 static void batadv_post_gw_reselect(struct net_device *net_dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
+
 	batadv_gw_reselect(bat_priv);
 }
 
-- 
1.8.5.5

