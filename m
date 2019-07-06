Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: Replace usage of strlcpy with strscpy
Date: Sat,  6 Jul 2019 15:05:55 +0200
Message-Id: <20190706130555.13343-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The strscpy was introduced to fix some API problems around strlcpy. And
checkpatch started to report recently that strlcpy is deprecated and
strscpy is preferred.

The functionality introduced in commi 30035e45753b ("string: provide
strscpy()") improves following points compared to strlcpy:

* it doesn't read from memory beyond (src + size)
* provides an easy way to check for destination buffer overflow
* robust against asynchronous source buffer changes

Since batman-adv doesn't depend on any of the previously mentioned behavior
changes, the usage of strlcpy can simply be replaced by strscpy to silence
checkpatch.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/string.h   | 51 +++++++++++++++++++++++++++++++++
 net/batman-adv/soft-interface.c |  8 +++---
 net/batman-adv/sysfs.c          |  2 +-
 3 files changed, 56 insertions(+), 5 deletions(-)
 create mode 100644 compat-include/linux/string.h

diff --git a/compat-include/linux/string.h b/compat-include/linux/string.h
new file mode 100644
index 00000000..36ec689e
--- /dev/null
+++ b/compat-include/linux/string.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2015  Chris Metcalf <cmetcalf@ezchip.com>
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_STRING_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_STRING_H_
+
+#include <linux/version.h>
+#include_next <linux/string.h>
+#include <asm-generic/errno-base.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
+
+#ifndef __HAVE_ARCH_STRSCPY
+
+static inline ssize_t batadv_strscpy(char *dest, const char *src, size_t count)
+{
+	long res = 0;
+
+	if (count == 0)
+		return -E2BIG;
+
+	while (count) {
+		char c;
+
+		c = src[res];
+		dest[res] = c;
+		if (!c)
+			return res;
+		res++;
+		count--;
+	}
+
+	/* Hit buffer length without finding a NUL; force NUL-termination. */
+	if (res)
+		dest[res-1] = '\0';
+
+	return -E2BIG;
+}
+
+#define strscpy(_dest, _src, _count) \
+	batadv_strscpy((_dest), (_src), (_count))
+
+#endif
+
+#endif /* < KERNEL_VERSION(4, 3, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_STRING_H_ */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c7a2e77c..a1146cb1 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -943,10 +943,10 @@ static const struct net_device_ops batadv_netdev_ops = {
 static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
-	strlcpy(info->driver, "B.A.T.M.A.N. advanced", sizeof(info->driver));
-	strlcpy(info->version, BATADV_SOURCE_VERSION, sizeof(info->version));
-	strlcpy(info->fw_version, "N/A", sizeof(info->fw_version));
-	strlcpy(info->bus_info, "batman", sizeof(info->bus_info));
+	strscpy(info->driver, "B.A.T.M.A.N. advanced", sizeof(info->driver));
+	strscpy(info->version, BATADV_SOURCE_VERSION, sizeof(info->version));
+	strscpy(info->fw_version, "N/A", sizeof(info->fw_version));
+	strscpy(info->bus_info, "batman", sizeof(info->bus_info));
 }
 
 /* Inspired by drivers/net/ethernet/dlink/sundance.c:1702
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 1efcb970..e5bbc28e 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1070,7 +1070,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
 	dev_hold(net_dev);
 	INIT_WORK(&store_work->work, batadv_store_mesh_iface_work);
 	store_work->net_dev = net_dev;
-	strlcpy(store_work->soft_iface_name, buff,
+	strscpy(store_work->soft_iface_name, buff,
 		sizeof(store_work->soft_iface_name));
 
 	queue_work(batadv_event_workqueue, &store_work->work);
-- 
2.20.1

