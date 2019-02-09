Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:41:09 +0100
Message-Id: <20190209134109.14908-20-sven@narfation.org>
In-Reply-To: <20190209134109.14908-1-sven@narfation.org>
References: <20190209134109.14908-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 19/19] batman-adv: Trigger genl
 notification on sysfs config change
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

The generic netlink code is expected to trigger notification messages when
configuration might have been changed. But the configuration of batman-adv
is most of the time still done using sysfs. So the sysfs interface should
also trigger the corresponding netlink messages via the "config" multicast
group.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 10 +++----
 net/batman-adv/netlink.h |  6 ++++
 net/batman-adv/sysfs.c   | 63 +++++++++++++++++++++++++++++++++-------
 3 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 476b4c60..67a58da2 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -385,7 +385,7 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-static int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv)
+int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv)
 {
 	struct sk_buff *msg;
 	int ret;
@@ -852,8 +852,8 @@ static int batadv_netlink_hardif_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-static int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
-					struct batadv_hard_iface *hard_iface)
+int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
+				 struct batadv_hard_iface *hard_iface)
 {
 	struct sk_buff *msg;
 	int ret;
@@ -1057,8 +1057,8 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
  *
  * Return: 0 on success, < 0 on error
  */
-static int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
-				      struct batadv_softif_vlan *vlan)
+int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
+			       struct batadv_softif_vlan *vlan)
 {
 	struct sk_buff *msg;
 	int ret;
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 216484b8..72733685 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -34,6 +34,12 @@ int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 				  u8 result, u32 test_time, u64 total_bytes,
 				  u32 cookie);
 
+int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv);
+int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
+				 struct batadv_hard_iface *hard_iface);
+int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
+			       struct batadv_softif_vlan *vlan);
+
 extern struct genl_family batadv_netlink_family;
 
 #endif /* _NET_BATMAN_ADV_NETLINK_H_ */
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 64fd5932..0b4b3fb7 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -48,6 +48,7 @@
 #include "gateway_common.h"
 #include "hard-interface.h"
 #include "log.h"
+#include "netlink.h"
 #include "network-coding.h"
 #include "soft-interface.h"
 
@@ -154,9 +155,14 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
+	ssize_t length;							\
+									\
+	length = __batadv_store_bool_attr(buff, count, _post_func, attr,\
+					  &bat_priv->_name, net_dev);	\
 									\
-	return __batadv_store_bool_attr(buff, count, _post_func, attr,	\
-					&bat_priv->_name, net_dev);	\
+	batadv_netlink_notify_mesh(bat_priv);				\
+									\
+	return length;							\
 }
 
 #define BATADV_ATTR_SIF_SHOW_BOOL(_name)				\
@@ -186,11 +192,16 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
+	ssize_t length;							\
 									\
-	return __batadv_store_uint_attr(buff, count, _min, _max,	\
-					_post_func, attr,		\
-					&bat_priv->_var, net_dev,	\
-					NULL);	\
+	length = __batadv_store_uint_attr(buff, count, _min, _max,	\
+					  _post_func, attr,		\
+					  &bat_priv->_var, net_dev,	\
+					  NULL);			\
+									\
+	batadv_netlink_notify_mesh(bat_priv);				\
+									\
+	return length;							\
 }
 
 #define BATADV_ATTR_SIF_SHOW_UINT(_name, _var)				\
@@ -223,6 +234,11 @@ ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
 					      attr, &vlan->_name,	\
 					      bat_priv->soft_iface);	\
 									\
+	if (vlan->vid)							\
+		batadv_netlink_notify_vlan(bat_priv, vlan);		\
+	else								\
+		batadv_netlink_notify_mesh(bat_priv);			\
+									\
 	batadv_softif_vlan_put(vlan);					\
 	return res;							\
 }
@@ -256,6 +272,7 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct batadv_hard_iface *hard_iface;				\
+	struct batadv_priv *bat_priv;					\
 	ssize_t length;							\
 									\
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
@@ -268,6 +285,11 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 					  hard_iface->soft_iface,	\
 					  net_dev);			\
 									\
+	if (hard_iface->soft_iface) {					\
+		bat_priv = netdev_priv(hard_iface->soft_iface);		\
+		batadv_netlink_notify_hardif(bat_priv, hard_iface);	\
+	}								\
+									\
 	batadv_hardif_put(hard_iface);				\
 	return length;							\
 }
@@ -537,6 +559,9 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 	batadv_gw_check_client_stop(bat_priv);
 	atomic_set(&bat_priv->gw.mode, (unsigned int)gw_mode_tmp);
 	batadv_gw_tvlv_container_update(bat_priv);
+
+	batadv_netlink_notify_mesh(bat_priv);
+
 	return count;
 }
 
@@ -563,6 +588,7 @@ static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
 					 size_t count)
 {
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
+	ssize_t length;
 
 	/* setting the GW selection class is allowed only if the routing
 	 * algorithm in use implements the GW API
@@ -578,10 +604,14 @@ static ssize_t batadv_store_gw_sel_class(struct kobject *kobj,
 		return bat_priv->algo_ops->gw.store_sel_class(bat_priv, buff,
 							      count);
 
-	return __batadv_store_uint_attr(buff, count, 1, BATADV_TQ_MAX_VALUE,
-					batadv_post_gw_reselect, attr,
-					&bat_priv->gw.sel_class,
-					bat_priv->soft_iface, NULL);
+	length = __batadv_store_uint_attr(buff, count, 1, BATADV_TQ_MAX_VALUE,
+					  batadv_post_gw_reselect, attr,
+					  &bat_priv->gw.sel_class,
+					  bat_priv->soft_iface, NULL);
+
+	batadv_netlink_notify_mesh(bat_priv);
+
+	return length;
 }
 
 static ssize_t batadv_show_gw_bwidth(struct kobject *kobj,
@@ -601,12 +631,18 @@ static ssize_t batadv_store_gw_bwidth(struct kobject *kobj,
 				      struct attribute *attr, char *buff,
 				      size_t count)
 {
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
+	ssize_t length;
 
 	if (buff[count - 1] == '\n')
 		buff[count - 1] = '\0';
 
-	return batadv_gw_bandwidth_set(net_dev, buff, count);
+	length = batadv_gw_bandwidth_set(net_dev, buff, count);
+
+	batadv_netlink_notify_mesh(bat_priv);
+
+	return length;
 }
 
 /**
@@ -674,6 +710,8 @@ static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
 		    "New skb mark for extended isolation: %#.8x/%#.8x\n",
 		    bat_priv->isolation_mark, bat_priv->isolation_mark_mask);
 
+	batadv_netlink_notify_mesh(bat_priv);
+
 	return count;
 }
 
@@ -1078,6 +1116,7 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 						struct attribute *attr,
 						char *buff, size_t count)
 {
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
 	struct batadv_hard_iface *hard_iface;
 	u32 tp_override;
@@ -1108,6 +1147,8 @@ static ssize_t batadv_store_throughput_override(struct kobject *kobj,
 
 	atomic_set(&hard_iface->bat_v.throughput_override, tp_override);
 
+	batadv_netlink_notify_hardif(bat_priv, hard_iface);
+
 out:
 	batadv_hardif_put(hard_iface);
 	return count;
-- 
2.20.1

