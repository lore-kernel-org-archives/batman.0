Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 16:40:08 +0800
Message-Id: <1452933619-6712-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <8047297.0qIFjkW2bL@voltaire>
References: <8047297.0qIFjkW2bL@voltaire>
Subject: [B.A.T.M.A.N.] [PATCH v2 01/12] batman-adv: Add hard_iface specific
	sysfs wrapper macros for UINT
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Linus Luessing <linus.luessing@web.de>

This allows us to easily add a sysfs parameter for an
unsigned int later, which is not for a batman mesh interface
(e.g. bat0), but for a common interface instead. It allows
reading and writing an atomic_t in hard_iface (instead of
bat_priv compared to the mesh variant).

Developed by Linus during a 6 months trainee study period in
Ascom (Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
[antonio@open-mesh.com: rename functions and move macros]
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 net/batman-adv/sysfs.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 4d70d44..d3f69d5 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -242,6 +242,55 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
 	static BATADV_ATTR_VLAN(_name, _mode, batadv_show_vlan_##_name,	\
 				batadv_store_vlan_##_name)
 
+#define BATADV_ATTR_HIF_STORE_UINT(_name, _var, _min, _max, _post_func)	\
+ssize_t batadv_store_##_name(struct kobject *kobj,			\
+			     struct attribute *attr, char *buff,	\
+			     size_t count)				\
+{									\
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
+	struct batadv_hard_iface *hard_iface;				\
+	ssize_t length;							\
+									\
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
+	if (!hard_iface)						\
+		return 0;						\
+									\
+	length = __batadv_store_uint_attr(buff, count, _min, _max,	\
+					  _post_func, attr,		\
+					  &hard_iface->_var, net_dev);	\
+									\
+	batadv_hardif_put(hard_iface);				\
+	return length;							\
+}
+
+#define BATADV_ATTR_HIF_SHOW_UINT(_name, _var)				\
+ssize_t batadv_show_##_name(struct kobject *kobj,			\
+			    struct attribute *attr, char *buff)		\
+{									\
+	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
+	struct batadv_hard_iface *hard_iface;				\
+	ssize_t length;							\
+									\
+	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
+	if (!hard_iface)						\
+		return 0;						\
+									\
+	length = sprintf(buff, "%i\n", atomic_read(&hard_iface->_var));	\
+									\
+	batadv_hardif_put(hard_iface);				\
+	return length;							\
+}
+
+/* Use this, if you are going to set [name] in hard_iface to an
+ * unsigned integer value
+ */
+#define BATADV_ATTR_HIF_UINT(_name, _var, _mode, _min, _max, _post_func)\
+	static BATADV_ATTR_HIF_STORE_UINT(_name, _var, _min,		\
+					  _max, _post_func)		\
+	static BATADV_ATTR_HIF_SHOW_UINT(_name, _var)			\
+	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
+			   batadv_store_##_name)
+
 static int batadv_store_bool_attr(char *buff, size_t count,
 				  struct net_device *net_dev,
 				  const char *attr_name, atomic_t *attr,
-- 
2.7.0.rc3

