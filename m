Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Mar 2012 06:17:52 +0800
Message-Id: <1331417873-19354-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Adding hard_iface specific
	sysfs wrapper macros for UINT
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Linus Luessing <linus.luessing@web.de>

This allows us to easily add a sysfs parameter for an unsigned int
later, which is not for a batman mesh interface (e.g. bat0), but for a
common interface instead. It allows reading and writing an atomic_t in
hard_iface (instead of bat_priv compared to the mesh variant).

Developed by Linus during a 6 months trainee study period in Ascom
(Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_sysfs.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 91107fd..35c15e9 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -117,6 +117,49 @@ ssize_t show_##_name(struct kobject *kobj,				\
 	static BAT_ATTR(_name, _mode, show_##_name, store_##_name)
 
 
+#define BAT_ATTR_HIF_STORE_UINT(_name, _min, _max, _post_func)		\
+ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
+		      char *buff, size_t count)				\
+{									\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
+	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);	\
+	ssize_t length;							\
+									\
+	if (!hard_iface)						\
+		return 0;						\
+									\
+	length = __store_uint_attr(buff, count, _min, _max, _post_func,	\
+				   attr, &hard_iface->_name, net_dev);	\
+									\
+	hardif_free_ref(hard_iface);					\
+	return length;							\
+}
+
+#define BAT_ATTR_HIF_SHOW_UINT(_name)					\
+ssize_t show_##_name(struct kobject *kobj,				\
+		     struct attribute *attr, char *buff)		\
+{									\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
+	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);	\
+	ssize_t length;							\
+									\
+	if (!hard_iface)						\
+		return 0;						\
+									\
+	length = sprintf(buff, "%i\n", atomic_read(&hard_iface->_name));\
+									\
+	hardif_free_ref(hard_iface);					\
+	return length;							\
+}
+
+/* Use this, if you are going to set [name] in hard_iface to an
+ * unsigned integer value*/
+#define BAT_ATTR_HIF_UINT(_name, _mode, _min, _max, _post_func)		\
+	static BAT_ATTR_HIF_STORE_UINT(_name, _min, _max, _post_func)	\
+	static BAT_ATTR_HIF_SHOW_UINT(_name)				\
+	static BAT_ATTR(_name, _mode, show_##_name, store_##_name)
+
+
 static int store_bool_attr(char *buff, size_t count,
 			   struct net_device *net_dev,
 			   const char *attr_name, atomic_t *attr)
-- 
1.7.9.1

