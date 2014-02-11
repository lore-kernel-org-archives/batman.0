Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:10 +0100
Message-Id: <1392122903-805-11-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 10/23] batman-adv: split name from variable for
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Some mesh attributes are behind substructs in the
batadv_priv object and for this reason the name cannot be
used anymore to refer to them.

This patch allows to specify the variable name where the
attribute is stored inside batadv_priv instead of using the
name

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 sysfs.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index 1d6653c..9139319 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -148,7 +148,7 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 			   batadv_store_##_name)
 
 
-#define BATADV_ATTR_SIF_STORE_UINT(_name, _min, _max, _post_func)	\
+#define BATADV_ATTR_SIF_STORE_UINT(_name, _var, _min, _max, _post_func)	\
 ssize_t batadv_store_##_name(struct kobject *kobj,			\
 			     struct attribute *attr, char *buff,	\
 			     size_t count)				\
@@ -157,23 +157,32 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);		\
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
-	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_name));	\
+	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_var));	\
 }									\
 
 /* Use this, if you are going to set [name] in the soft-interface
  * (bat_priv) to an unsigned integer value
  */
 #define BATADV_ATTR_SIF_UINT(_name, _mode, _min, _max, _post_func)	\
-	static BATADV_ATTR_SIF_STORE_UINT(_name, _min, _max, _post_func)\
-	static BATADV_ATTR_SIF_SHOW_UINT(_name)				\
+	static BATADV_ATTR_SIF_STORE_UINT(_name, _name, _min, _max, _post_func)\
+	static BATADV_ATTR_SIF_SHOW_UINT(_name, _name)			\
+	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
+			   batadv_store_##_name)
+
+/* Same as BATADV_ATTR_SIF_UINT, but allow to specify the variable name as
+ * second parameter so that it does not need to match the attribute name
+ */
+#define BATADV_ATTR_SIF_UINT2(_name, _var, _mode, _min, _max, _post_func)\
+	static BATADV_ATTR_SIF_STORE_UINT(_name, _var, _min, _max, _post_func)\
+	static BATADV_ATTR_SIF_SHOW_UINT(_name, _var)			\
 	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
 			   batadv_store_##_name)
 
-- 
1.8.5.3

