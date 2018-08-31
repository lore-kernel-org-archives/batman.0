Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Aug 2018 16:56:29 +0200
Message-Id: <20180831145629.26332-1-sven@narfation.org>
In-Reply-To: <20180831144648.24032-1-sven@narfation.org>
References: <20180831144648.24032-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint v2 2/2] batman-adv: Fix segfault when
 writing to sysfs elp_interval
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

The per hardif sysfs file "batman_adv/elp_interval" is using the generic
functions to store/show uint values. The helper __batadv_store_uint_attr
requires the softif net_device as parameter to print the resulting change
as info text when the users writes to this file. It uses the helper
function batadv_info to add it at the same time to the kernel ring buffer
and to the batman-adv debug log (when CONFIG_BATMAN_ADV_DEBUG is enabled).

The function batadv_info requires as first parameter the batman-adv softif
net_device. This parameter is then used to find the private buffer which
contains the debug log for this batman-adv interface. But
batadv_store_throughput_override used as first argument the slave
net_device. This slave device doesn't have the batadv_priv private data
which is access by batadv_info.

Writing to this file with CONFIG_BATMAN_ADV_DEBUG enabled can either lead
to a segfault or to memory corruption.

Fixes: ec46535b8275 ("batman-adv: Add hard_iface specific sysfs wrapper macros for UINT")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:

* changed how ifname gets initialized (not sure why I've added \0)

 net/batman-adv/sysfs.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 3a76e897..09427fc6 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -188,7 +188,8 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 									\
 	return __batadv_store_uint_attr(buff, count, _min, _max,	\
 					_post_func, attr,		\
-					&bat_priv->_var, net_dev);	\
+					&bat_priv->_var, net_dev,	\
+					NULL);	\
 }
 
 #define BATADV_ATTR_SIF_SHOW_UINT(_name, _var)				\
@@ -262,7 +263,9 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 									\
 	length = __batadv_store_uint_attr(buff, count, _min, _max,	\
 					  _post_func, attr,		\
-					  &hard_iface->_var, net_dev);	\
+					  &hard_iface->_var,		\
+					  hard_iface->soft_iface,	\
+					  net_dev);			\
 									\
 	batadv_hardif_put(hard_iface);				\
 	return length;							\
@@ -356,10 +359,12 @@ __batadv_store_bool_attr(char *buff, size_t count,
 
 static int batadv_store_uint_attr(const char *buff, size_t count,
 				  struct net_device *net_dev,
+				  struct net_device *slave_dev,
 				  const char *attr_name,
 				  unsigned int min, unsigned int max,
 				  atomic_t *attr)
 {
+	char ifname[IFNAMSIZ + 3] = "";
 	unsigned long uint_val;
 	int ret;
 
@@ -385,8 +390,11 @@ static int batadv_store_uint_attr(const char *buff, size_t count,
 	if (atomic_read(attr) == uint_val)
 		return count;
 
-	batadv_info(net_dev, "%s: Changing from: %i to: %lu\n",
-		    attr_name, atomic_read(attr), uint_val);
+	if (slave_dev)
+		snprintf(ifname, sizeof(ifname), "%s: ", slave_dev->name);
+
+	batadv_info(net_dev, "%s: %sChanging from: %i to: %lu\n",
+		    attr_name, ifname, atomic_read(attr), uint_val);
 
 	atomic_set(attr, uint_val);
 	return count;
@@ -397,12 +405,13 @@ static ssize_t __batadv_store_uint_attr(const char *buff, size_t count,
 					void (*post_func)(struct net_device *),
 					const struct attribute *attr,
 					atomic_t *attr_store,
-					struct net_device *net_dev)
+					struct net_device *net_dev,
+					struct net_device *slave_dev)
 {
 	int ret;
 
-	ret = batadv_store_uint_attr(buff, count, net_dev, attr->name, min, max,
-				     attr_store);
+	ret = batadv_store_uint_attr(buff, count, net_dev, slave_dev,
+				     attr->name, min, max, attr_store);
 	if (post_func && ret)
 		post_func(net_dev);
 
@@ -571,7 +580,7 @@ static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
 	return __batadv_store_uint_attr(buff, count, 1, BATADV_TQ_MAX_VALUE,
 					batadv_post_gw_reselect, attr,
 					&bat_priv->gw.sel_class,
-					bat_priv->soft_iface);
+					bat_priv->soft_iface, NULL);
 }
 
 static ssize_t batadv_show_gw_bwidth(struct kobject *kobj,
-- 
2.18.0

