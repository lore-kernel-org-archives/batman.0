Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Thu,  9 Dec 2010 10:23:56 +0100
Message-Id: <1291886638-19344-9-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 08/10] batman-adv: Adding batman_if specific
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

This allows us to easily add a sysfs parameter for an unsigned int
later, which is not for a batman mesh interface (e.g. bat0), but for a
common interface instead. It allows reading and writing an atomic_t in
batman_if (instead of bat_priv compared to the mesh variant).

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 bat_sysfs.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index cd7bb51..98c10a3 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -94,6 +94,33 @@ ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
 	static BAT_ATTR(_name, _mode, show_##_name, store_##_name)
 
 
+#define BAT_ATTR_IF_STORE_UINT(_name, _min, _max, _post_func)		\
+ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
+			     char *buff, size_t count)			\
+{									\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
+	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);	\
+	return __store_uint_attr(buff, count, _min, _max, _post_func,	\
+				 attr, &batman_if->_name, net_dev);	\
+}
+
+#define BAT_ATTR_IF_SHOW_UINT(_name)					\
+ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
+			    char *buff)					\
+{									\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
+	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);	\
+	return sprintf(buff, "%i\n", atomic_read(&batman_if->_name));	\
+}									\
+
+/* Use this, if you are going to set [name] in batman_if to unsigned integer
+ * values only */
+#define BAT_ATTR_IF_UINT(_name, _mode, _min, _max, _post_func)		\
+	static BAT_ATTR_IF_STORE_UINT(_name, _min, _max, _post_func)	\
+	static BAT_ATTR_IF_SHOW_UINT(_name)				\
+	static BAT_ATTR(_name, _mode, show_##_name, store_##_name)
+
+
 static int store_bool_attr(char *buff, size_t count,
 			   struct net_device *net_dev,
 			   char *attr_name, atomic_t *attr)
-- 
1.7.1

