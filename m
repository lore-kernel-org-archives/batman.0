Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Mon,  9 May 2016 18:41:08 +0200
Message-Id: <1462812071-16467-1-git-send-email-sven@open-mesh.com>
In-Reply-To: <6307812.WAqRcEYAvX@bentobox>
References: <6307812.WAqRcEYAvX@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v7 1/4] batman-adv: add generic netlink
	family for batman-adv
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

From: Matthias Schiffer <mschiffer@universe-factory.net>

debugfs is currently severely broken virtually everywhere in the kernel
where files are dynamically added and removed (see
http://lkml.iu.edu/hypermail/linux/kernel/1506.1/02196.html for some
details). In addition to that, debugfs is not namespace-aware.

Instead of adding new debugfs entries, the whole infrastructure should be
moved to netlink. This will fix the long standing problem of large buffers
for debug tables and hard to parse text files.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
[sven.eckelmann@open-mesh.com: Strip down patch to only add genl family,
add missing kerneldoc]
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 MAINTAINERS                     |  1 +
 Makefile                        |  1 +
 compat-include/net/genetlink.h  | 34 ++++++++++++++++++++++++
 include/uapi/linux/batman_adv.h | 53 ++++++++++++++++++++++++++++++++++++++
 net/batman-adv/Makefile         |  1 +
 net/batman-adv/main.c           |  3 +++
 net/batman-adv/netlink.c        | 57 +++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/netlink.h        | 24 +++++++++++++++++
 8 files changed, 174 insertions(+)
 create mode 100644 compat-include/net/genetlink.h
 create mode 100644 include/uapi/linux/batman_adv.h
 create mode 100644 net/batman-adv/netlink.c
 create mode 100644 net/batman-adv/netlink.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e47274..ff0322d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9,4 +9,5 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
 F:	Documentation/ABI/testing/sysfs-class-net-mesh
 F:	Documentation/networking/batman-adv.txt
+F:	include/uapi/linux/batman_adv.h
 F:	net/batman-adv/
diff --git a/Makefile b/Makefile
index 5d2c058..f17bde5 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,7 @@ REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 			fi)
 export NOSTDINC_FLAGS := \
 	-I$(PWD)/compat-include/ \
+	-I$(PWD)/include/ \
 	-include $(PWD)/compat.h \
 	$(CFLAGS)
 
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
new file mode 100644
index 0000000..bf1ba3d
--- /dev/null
+++ b/compat-include/net/genetlink.h
@@ -0,0 +1,34 @@
+/* Copyright (C) 2007-2016 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
+
+#include <linux/version.h>
+#include_next <net/genetlink.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0)
+
+#define genl_register_family_with_ops(family, ops)     \
+	genl_register_family_with_ops((family), (ops), ARRAY_SIZE(ops))
+
+#endif /* < KERNEL_VERSION(3, 13, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_ */
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
new file mode 100644
index 0000000..ba611a7
--- /dev/null
+++ b/include/uapi/linux/batman_adv.h
@@ -0,0 +1,53 @@
+/* Copyright (C) 2016 B.A.T.M.A.N. contributors:
+ *
+ * Matthias Schiffer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _UAPI_LINUX_BATMAN_ADV_H_
+#define _UAPI_LINUX_BATMAN_ADV_H_
+
+#define BATADV_NL_NAME "batadv"
+
+/**
+ * enum batadv_nl_attrs - batman-adv netlink attributes
+ *
+ * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
+ * @__BATADV_ATTR_AFTER_LAST: internal use
+ * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
+ * @BATADV_ATTR_MAX: highest attribute number currently defined
+ */
+enum batadv_nl_attrs {
+	BATADV_ATTR_UNSPEC,
+	/* add attributes above here, update the policy in netlink.c */
+	__BATADV_ATTR_AFTER_LAST,
+	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
+	BATADV_ATTR_MAX = __BATADV_ATTR_AFTER_LAST - 1
+};
+
+/**
+ * enum batadv_nl_commands - supported batman-adv netlink commands
+ *
+ * @BATADV_CMD_UNSPEC: unspecified command to catch errors
+ * @__BATADV_CMD_AFTER_LAST: internal use
+ * @BATADV_CMD_MAX: highest used command number
+ */
+enum batadv_nl_commands {
+	BATADV_CMD_UNSPEC,
+	/* add new commands above here */
+	__BATADV_CMD_AFTER_LAST,
+	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
+};
+
+#endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 797cf2f..4e5adba 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -33,6 +33,7 @@ batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
+batman-adv-y += netlink.o
 batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
 batman-adv-y += routing.o
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 627d14e..e78b318 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -57,6 +57,7 @@
 #include "hard-interface.h"
 #include "icmp_socket.h"
 #include "multicast.h"
+#include "netlink.h"
 #include "network-coding.h"
 #include "originator.h"
 #include "packet.h"
@@ -101,6 +102,7 @@ static int __init batadv_init(void)
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
 	rtnl_link_register(&batadv_link_ops);
+	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
 		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
@@ -111,6 +113,7 @@ static int __init batadv_init(void)
 static void __exit batadv_exit(void)
 {
 	batadv_debugfs_destroy();
+	batadv_netlink_unregister();
 	rtnl_link_unregister(&batadv_link_ops);
 	unregister_netdevice_notifier(&batadv_hard_if_notifier);
 	batadv_hardif_remove_interfaces();
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
new file mode 100644
index 0000000..af3e87e
--- /dev/null
+++ b/net/batman-adv/netlink.c
@@ -0,0 +1,57 @@
+/* Copyright (C) 2016 B.A.T.M.A.N. contributors:
+ *
+ * Matthias Schiffer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "main.h"
+#include "netlink.h"
+
+#include <linux/genetlink.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <net/genetlink.h>
+#include <uapi/linux/batman_adv.h>
+
+static struct genl_family batadv_netlink_family = {
+	.id = GENL_ID_GENERATE,
+	.hdrsize = 0,
+	.name = BATADV_NL_NAME,
+	.version = 1,
+	.maxattr = BATADV_ATTR_MAX,
+};
+
+static struct genl_ops batadv_netlink_ops[] = {
+};
+
+/**
+ * batadv_netlink_register - Register batadv genl netlink family
+ */
+void __init batadv_netlink_register(void)
+{
+	int ret;
+
+	ret = genl_register_family_with_ops(&batadv_netlink_family,
+					    batadv_netlink_ops);
+	if (ret)
+		pr_warn("unable to register netlink family");
+}
+
+/**
+ * batadv_netlink_unregister - Unregister batadv genl netlink family
+ */
+void batadv_netlink_unregister(void)
+{
+	genl_unregister_family(&batadv_netlink_family);
+}
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
new file mode 100644
index 0000000..fa152a8
--- /dev/null
+++ b/net/batman-adv/netlink.h
@@ -0,0 +1,24 @@
+/* Copyright (C) 2016 B.A.T.M.A.N. contributors:
+ *
+ * Matthias Schiffer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _NET_BATMAN_ADV_NETLINK_H_
+#define _NET_BATMAN_ADV_NETLINK_H_
+
+void batadv_netlink_register(void);
+void batadv_netlink_unregister(void);
+
+#endif /* _NET_BATMAN_ADV_NETLINK_H_ */
-- 
2.8.1

