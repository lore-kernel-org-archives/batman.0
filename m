Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 May 2011 21:48:03 +0200
Message-Id: <1304797684-31778-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Don't include bat_sysfs.h in
	compat.h
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

bat_sysfs.h is included in compat.h to provide bat_attribute which is
used in bat_wrapper_show and bat_wrapper_store. This could create a
include loop which prevents that functions or datastructures defined
elsewhere cannot be found in bat_sysfs.h when batman-adv gets compiled
as external module, but are available when it is used as in-kernel
module.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.c |   29 +++++++++++++++++++++++++++++
 compat.h |   26 ++++----------------------
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/compat.c b/compat.c
index f4561c3..34b27a1 100644
--- a/compat.c
+++ b/compat.c
@@ -1,4 +1,33 @@
 #include <linux/version.h>
+#include "main.h"
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25)
+
+#include "bat_sysfs.h"		/* struct bat_attribute */
+
+ssize_t bat_wrapper_show(struct kobject *kobj, struct attribute *attr,
+			 char *buf)
+{
+	struct bat_attribute *bat_attr = to_battr(attr);
+
+	if (bat_attr->show)
+		return bat_attr->show(kobj, attr, buf);
+
+	return -EIO;
+}
+
+ssize_t bat_wrapper_store(struct kobject *kobj, struct attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct bat_attribute *bat_attr = to_battr(attr);
+
+	if (bat_attr->store)
+		return bat_attr->store(kobj, attr, (char *)buf, count);
+
+	return -EIO;
+}
+
+#endif /* < KERNEL_VERSION(2, 6, 25) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
 
diff --git a/compat.h b/compat.h
index c3fd2cd..fb49f9d 100644
--- a/compat.h
+++ b/compat.h
@@ -26,7 +26,6 @@
 #define _NET_BATMAN_ADV_COMPAT_H_
 
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
-#include "bat_sysfs.h"		/* struct bat_attribute */
 
 #ifndef IPPROTO_UDP
 #define IPPROTO_UDP 17
@@ -107,28 +106,11 @@ static inline int skb_cow_head(struct sk_buff *skb, unsigned int headroom)
 
 #define to_battr(a) container_of(a, struct bat_attribute, attr)
 
-static inline ssize_t bat_wrapper_show(struct kobject *kobj,
-				   struct attribute *attr, char *buf)
-{
-	struct bat_attribute *bat_attr = to_battr(attr);
+ssize_t bat_wrapper_show(struct kobject *kobj, struct attribute *attr,
+			 char *buf);
 
-	if (bat_attr->show)
-		return bat_attr->show(kobj, attr, buf);
-
-	return -EIO;
-}
-
-static inline ssize_t bat_wrapper_store(struct kobject *kobj,
-				    struct attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct bat_attribute *bat_attr = to_battr(attr);
-
-	if (bat_attr->store)
-		return bat_attr->store(kobj, attr, (char *)buf, count);
-
-	return -EIO;
-}
+ssize_t bat_wrapper_store(struct kobject *kobj, struct attribute *attr,
+			  const char *buf, size_t count);
 
 static struct sysfs_ops bat_wrapper_ops = {
 	.show   = bat_wrapper_show,
-- 
1.7.5.1

