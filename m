Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  9 Jun 2015 12:50:15 +0200
Message-Id: <1433847020-1427-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1433847020-1427-1-git-send-email-antonio@meshcoding.com>
References: <1433847020-1427-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: split name from variable for
	uint mesh attributes
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Some mesh attributes are behind substructs in the
batadv_priv object and for this reason the name cannot be
used anymore to refer to them.

This patch allows to specify the variable name where the
attribute is stored inside batadv_priv instead of using the
name

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/sysfs.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index fa8c347..7278b2b 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -151,7 +151,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
 			   batadv_store_##_name)
 
-#define BATADV_ATTR_SIF_STORE_UINT(_name, _min, _max, _post_func)	\
+#define BATADV_ATTR_SIF_STORE_UINT(_name, _var, _min, _max, _post_func)	\
 ssize_t batadv_store_##_name(struct kobject *kobj,			\
 			     struct attribute *attr, char *buff,	\
 			     size_t count)				\
@@ -161,24 +161,24 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 									\
 	return __batadv_store_uint_attr(buff, count, _min, _max,	\
 					_post_func, attr,		\
-					&bat_priv->_name, net_dev);	\
+					&bat_priv->_var, net_dev);	\
 }
 
-#define BATADV_ATTR_SIF_SHOW_UINT(_name)				\
+#define BATADV_ATTR_SIF_SHOW_UINT(_name, _var)				\
 ssize_t batadv_show_##_name(struct kobject *kobj,			\
 			    struct attribute *attr, char *buff)		\
 {									\
 	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);	\
 									\
-	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_name));	\
+	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_var));	\
 }									\
 
 /* Use this, if you are going to set [name] in the soft-interface
  * (bat_priv) to an unsigned integer value
  */
-#define BATADV_ATTR_SIF_UINT(_name, _mode, _min, _max, _post_func)	\
-	static BATADV_ATTR_SIF_STORE_UINT(_name, _min, _max, _post_func)\
-	static BATADV_ATTR_SIF_SHOW_UINT(_name)				\
+#define BATADV_ATTR_SIF_UINT(_name, _var, _mode, _min, _max, _post_func)\
+	static BATADV_ATTR_SIF_STORE_UINT(_name, _var, _min, _max, _post_func)\
+	static BATADV_ATTR_SIF_SHOW_UINT(_name, _var)			\
 	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
 			   batadv_store_##_name)
 
@@ -540,19 +540,20 @@ BATADV_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, batadv_update_min_mtu);
 static BATADV_ATTR(routing_algo, S_IRUGO, batadv_show_bat_algo, NULL);
 static BATADV_ATTR(gw_mode, S_IRUGO | S_IWUSR, batadv_show_gw_mode,
 		   batadv_store_gw_mode);
-BATADV_ATTR_SIF_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * BATADV_JITTER,
-		     INT_MAX, NULL);
-BATADV_ATTR_SIF_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, BATADV_TQ_MAX_VALUE,
-		     NULL);
-BATADV_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, BATADV_TQ_MAX_VALUE,
-		     batadv_post_gw_reselect);
+BATADV_ATTR_SIF_UINT(orig_interval, orig_interval, S_IRUGO | S_IWUSR,
+		     2 * BATADV_JITTER, INT_MAX, NULL);
+BATADV_ATTR_SIF_UINT(hop_penalty, hop_penalty, S_IRUGO | S_IWUSR, 0,
+		     BATADV_TQ_MAX_VALUE, NULL);
+BATADV_ATTR_SIF_UINT(gw_sel_class, gw_sel_class, S_IRUGO | S_IWUSR, 1,
+		     BATADV_TQ_MAX_VALUE, batadv_post_gw_reselect);
 static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 		   batadv_store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_MCAST
 BATADV_ATTR_SIF_BOOL(multicast_mode, S_IRUGO | S_IWUSR, NULL);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
+BATADV_ATTR_SIF_UINT(log_level, log_level, S_IRUGO | S_IWUSR, 0,
+		     BATADV_DBG_ALL, NULL);
 #endif
 #ifdef CONFIG_BATMAN_ADV_NC
 BATADV_ATTR_SIF_BOOL(network_coding, S_IRUGO | S_IWUSR,
-- 
2.4.2

