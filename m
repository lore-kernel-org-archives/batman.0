Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 18:02:59 +0100
Message-Id: <20190303170259.31798-6-sven@narfation.org>
In-Reply-To: <20190303170259.31798-1-sven@narfation.org>
References: <20190303170259.31798-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: Warn about sysfs file access
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

The sysfs files to read and modify the configuration settings were replaced
by the batadv generic netlink family. They are also marked as obsolete in
the ABI documentation. But not all users of this functionality might follow
changes in the Documentation/ABI/obsolete/ folder. They might benefit from
a warning messages about the deprecation of the functionality which they
just tried to access

  batman_adv: [Deprecated]: batctl (pid 30381) Use of sysfs file "orig_interval".
  Use batadv genl family instead

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/sysfs.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 0a0f5775..73edf099 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -19,6 +19,7 @@
 #include "sysfs.h"
 #include "main.h"
 
+#include <asm/current.h>
 #include <linux/atomic.h>
 #include <linux/compiler.h>
 #include <linux/device.h>
@@ -34,6 +35,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/rtnetlink.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
@@ -52,6 +54,16 @@
 #include "network-coding.h"
 #include "soft-interface.h"
 
+/**
+ * batadv_sysfs_deprecated() - Log use of deprecated batadv sysfs access
+ * @attr: attribute which was accessed
+ */
+static void batadv_sysfs_deprecated(struct attribute *attr)
+{
+	pr_warn_ratelimited(DEPRECATED "%s (pid %d) Use of sysfs file \"%s\".\nUse batadv genl family instead",
+			    current->comm, task_pid_nr(current), attr->name);
+}
+
 static struct net_device *batadv_kobj_to_netdev(struct kobject *obj)
 {
 	struct device *dev = container_of(obj->parent, struct device, kobj);
@@ -141,6 +153,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
 	ssize_t length;							\
 									\
+	batadv_sysfs_deprecated(attr);					\
 	length = __batadv_store_bool_attr(buff, count, _post_func, attr,\
 					  &bat_priv->_name, net_dev);	\
 									\
@@ -155,6 +168,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 {									\
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
 									\
+	batadv_sysfs_deprecated(attr);					\
 	return sprintf(buff, "%s\n",					\
 		       atomic_read(&bat_priv->_name) == 0 ?		\
 		       "disabled" : "enabled");				\
@@ -178,6 +192,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
 	ssize_t length;							\
 									\
+	batadv_sysfs_deprecated(attr);					\
 	length = __batadv_store_uint_attr(buff, count, _min, _max,	\
 					  _post_func, attr,		\
 					  &bat_priv->_var, net_dev,	\
@@ -194,6 +209,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 {									\
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
 									\
+	batadv_sysfs_deprecated(attr);					\
 	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_var));	\
 }									\
 
@@ -218,6 +234,7 @@ ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
 					      attr, &vlan->_name,	\
 					      bat_priv->soft_iface);	\
 									\
+	batadv_sysfs_deprecated(attr);					\
 	if (vlan->vid)							\
 		batadv_netlink_notify_vlan(bat_priv, vlan);		\
 	else								\
@@ -238,6 +255,7 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
 			     atomic_read(&vlan->_name) == 0 ?		\
 			     "disabled" : "enabled");			\
 									\
+	batadv_sysfs_deprecated(attr);					\
 	batadv_softif_vlan_put(vlan);					\
 	return res;							\
 }
@@ -259,6 +277,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 	struct batadv_priv *bat_priv;					\
 	ssize_t length;							\
 									\
+	batadv_sysfs_deprecated(attr);					\
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
 	if (!hard_iface)						\
 		return 0;						\
@@ -286,6 +305,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 	struct batadv_hard_iface *hard_iface;				\
 	ssize_t length;							\
 									\
+	batadv_sysfs_deprecated(attr);					\
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
 	if (!hard_iface)						\
 		return 0;						\
@@ -430,6 +450,7 @@ static ssize_t batadv_show_bat_algo(struct kobject *kobj,
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 
+	batadv_sysfs_deprecated(attr);
 	return sprintf(buff, "%s\n", bat_priv->algo_ops->name);
 }
 
@@ -446,6 +467,8 @@ static ssize_t batadv_show_gw_mode(struct kobject *kobj, struct attribute *attr,
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	int bytes_written;
 
+	batadv_sysfs_deprecated(attr);
+
 	/* GW mode is not available if the routing algorithm in use does not
 	 * implement the GW API
 	 */
@@ -480,6 +503,8 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 	char *curr_gw_mode_str;
 	int gw_mode_tmp = -1;
 
+	batadv_sysfs_deprecated(attr);
+
 	/* toggling GW mode is allowed only if the routing algorithm in use
 	 * provides the GW API
 	 */
@@ -554,6 +579,8 @@ static ssize_t batadv_show_gw_sel_class(struct kobject *kobj,
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 
+	batadv_sysfs_deprecated(attr);
+
 	/* GW selection class is not available if the routing algorithm in use
 	 * does not implement the GW API
 	 */
@@ -574,6 +601,8 @@ static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	ssize_t length;
 
+	batadv_sysfs_deprecated(attr);
+
 	/* setting the GW selection class is allowed only if the routing
 	 * algorithm in use implements the GW API
 	 */
@@ -604,6 +633,8 @@ static ssize_t batadv_show_gw_bwidth(struct kobject *kobj,
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	u32 down, up;
 
+	batadv_sysfs_deprecated(attr);
+
 	down = atomic_read(&bat_priv->gw.bandwidth_down);
 	up = atomic_read(&bat_priv->gw.bandwidth_up);
 
@@ -619,6 +650,8 @@ static ssize_t batadv_store_gw_bwidth(struct kobject *kobj,
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
 	ssize_t length;
 
+	batadv_sysfs_deprecated(attr);
+
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
@@ -643,6 +676,7 @@ static ssize_t batadv_show_isolation_mark(struct kobject *kobj,
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 
+	batadv_sysfs_deprecated(attr);
 	return sprintf(buff, "%#.8x/%#.8x\n", bat_priv->isolation_mark,
 		       bat_priv->isolation_mark_mask);
 }
@@ -666,6 +700,8 @@ static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
 	u32 mark, mask;
 	char *mask_ptr;
 
+	batadv_sysfs_deprecated(attr);
+
 	/* parse the mask if it has been specified, otherwise assume the mask is
 	 * the biggest possible
 	 */
@@ -921,6 +957,8 @@ static ssize_t batadv_show_mesh_iface(struct kobject *kobj,
 	ssize_t length;
 	const char *ifname;
 
+	batadv_sysfs_deprecated(attr);
+
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface)
 		return 0;
@@ -1025,6 +1063,8 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
 	struct batadv_store_mesh_work *store_work;
 
+	batadv_sysfs_deprecated(attr);
+
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
@@ -1056,6 +1096,8 @@ static ssize_t batadv_show_iface_status(struct kobject *kobj,
 	struct batadv_hard_iface *hard_iface;
 	ssize_t length;
 
+	batadv_sysfs_deprecated(attr);
+
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface)
 		return 0;
@@ -1107,6 +1149,8 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 	u32 old_tp_override;
 	bool ret;
 
+	batadv_sysfs_deprecated(attr);
+
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface)
 		return -EINVAL;
@@ -1146,6 +1190,8 @@ static ssize_t batadv_show_throughput_override(struct kobject *kobj,
 	struct batadv_hard_iface *hard_iface;
 	u32 tp_override;
 
+	batadv_sysfs_deprecated(attr);
+
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface)
 		return -EINVAL;
-- 
2.20.1

