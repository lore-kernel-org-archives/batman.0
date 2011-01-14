Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri, 14 Jan 2011 01:59:50 +0100
Message-Id: <1294966794-17780-8-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
References: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 07/11] batman-adv: Adding batman_if specific
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
 bat_sysfs.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index cd7bb51..5954389 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -94,6 +94,49 @@ ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
 	static BAT_ATTR(_name, _mode, show_##_name, store_##_name)
 
 
+#define BAT_ATTR_IF_STORE_UINT(_name, _min, _max, _post_func)		\
+ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
+			     char *buff, size_t count)			\
+{									\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
+	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);	\
+	ssize_t length;							\
+									\
+	if (!batman_if)							\
+		return 0;						\
+									\
+	length = __store_uint_attr(buff, count, _min, _max, _post_func,	\
+				 attr, &batman_if->_name, net_dev);	\
+									\
+	kref_put(&batman_if->refcount, hardif_free_ref);		\
+	return length;							\
+}
+
+#define BAT_ATTR_IF_SHOW_UINT(_name)					\
+ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
+			    char *buff)					\
+{									\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
+	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);	\
+	ssize_t length;							\
+									\
+	if (!batman_if)							\
+		return 0;						\
+									\
+	length = sprintf(buff, "%i\n", atomic_read(&batman_if->_name));	\
+									\
+	kref_put(&batman_if->refcount, hardif_free_ref);		\
+	return length;							\
+}
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

