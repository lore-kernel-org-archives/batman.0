Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  3 May 2010 08:28:38 +0800
Message-Id: <1272846518-2589-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201005030828.08856.lindner_marek@yahoo.de>
References: <201005030828.08856.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: adding sysfs compat
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

The linux sysfs layer changed with 2.6.25 which breaks batman-adv
on older versions. This patch adds a compat layer for the affected
function calls.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/bat_sysfs.c |    1 +
 batman-adv-kernelland/compat.h    |   70 +++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/bat_sysfs.c b/batman-adv-kernelland/bat_sysfs.c
index c700359..7690368 100644
--- a/batman-adv-kernelland/bat_sysfs.c
+++ b/batman-adv-kernelland/bat_sysfs.c
@@ -27,6 +27,7 @@
 #include "gateway_common.h"
 #include "gateway_client.h"
 #include "vis.h"
+#include "compat.h"
 
 #define to_dev(obj)     container_of(obj, struct device, kobj)
 
diff --git a/batman-adv-kernelland/compat.h b/batman-adv-kernelland/compat.h
index 4eaa128..9f21f5a 100644
--- a/batman-adv-kernelland/compat.h
+++ b/batman-adv-kernelland/compat.h
@@ -23,6 +23,7 @@
  */
 
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
+#include "bat_sysfs.h"		/* struct bat_attribute */
 
 #ifndef IPPROTO_UDP
 #define IPPROTO_UDP 17
@@ -80,6 +81,75 @@ static inline int skb_clone_writable(struct sk_buff *skb, unsigned int len)
 	ret; \
 })
 
+#define transtable_local_read(kobj, attr, buff, off, count) \
+	transtable_local_read(kobj, buff, off, count)
+#define transtable_global_read(kobj, attr, buff, off, count) \
+	transtable_global_read(kobj, buff, off, count)
+#define originators_read(kobj, attr, buff, off, count) \
+	originators_read(kobj, buff, off, count)
+#define gateways_read(kobj, attr, buff, off, count) \
+	gateways_read(kobj, buff, off, count)
+#define vis_data_read(kobj, attr, buff, off, count) \
+	vis_data_read(kobj, buff, off, count)
+
+#define to_battr(a) container_of(a, struct bat_attribute, attr)
+
+static inline ssize_t bat_wrapper_show(struct kobject *kobj,
+				   struct attribute *attr, char *buf)
+{
+	struct bat_attribute *bat_attr = to_battr(attr);
+
+	if (bat_attr->show)
+		return bat_attr->show(kobj, attr, buf);
+
+	return -EIO;
+}
+
+static inline ssize_t bat_wrapper_store(struct kobject *kobj,
+				    struct attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct bat_attribute *bat_attr = to_battr(attr);
+
+	if (bat_attr->store)
+		return bat_attr->store(kobj, attr, (char *)buf, count);
+
+	return -EIO;
+}
+
+static struct sysfs_ops bat_wrapper_ops = {
+	.show   = bat_wrapper_show,
+	.store  = bat_wrapper_store,
+};
+
+static struct kobj_type ktype_bat_wrapper = {
+	.sysfs_ops      = &bat_wrapper_ops,
+};
+
+static inline struct kobject *kobject_create_and_add(const char *name,
+						     struct kobject *parent)
+{
+	struct kobject *kobj;
+	int err;
+
+	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+	if (!kobj)
+		return NULL;
+
+	kobject_set_name(kobj, name);
+	kobj->ktype = &ktype_bat_wrapper;
+	kobj->kset = NULL;
+	kobj->parent = parent;
+
+	err = kobject_register(kobj);
+	if (err) {
+		kobject_put(kobj);
+		return NULL;
+	}
+
+	return kobj;
+}
+
 #endif /* < KERNEL_VERSION(2, 6, 25) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 26)
-- 
1.7.0

