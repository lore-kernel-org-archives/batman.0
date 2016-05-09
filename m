Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:07:12 +0200
Message-Id: <1462817239-18104-6-git-send-email-andrew@lunn.ch>
In-Reply-To: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv4 05/12] batman-adv: compat: Workarounds for
	previous patch
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

* NETLINK_CB portid changed name
* info->snd_portid changed name
* genl_register_family_with_ops implementation

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 compat-include/linux/netlink.h | 45 ++++++++++++++++++++++++++++++++++++++++++
 compat-include/net/genetlink.h | 34 +++++++++++++++++++++++++++++++
 compat.h                       |  6 ++++++
 3 files changed, 85 insertions(+)
 create mode 100644 compat-include/linux/netlink.h
 create mode 100644 compat-include/net/genetlink.h

diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
new file mode 100644
index 0000000..696f6da
--- /dev/null
+++ b/compat-include/linux/netlink.h
@@ -0,0 +1,45 @@
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
+
+#include <linux/version.h>
+#include_next <linux/netlink.h>
+
+#include <net/scm.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+struct batadv_netlink_skb_parms {
+	struct ucred		creds;		/* Skb credentials	*/
+	union {
+		__u32		portid;
+		__u32		pid;
+	};
+	__u32			dst_group;
+};
+
+#undef NETLINK_CB
+#define NETLINK_CB(skb) (*(struct batadv_netlink_skb_parms*)&((skb)->cb))
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_ */
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
diff --git a/compat.h b/compat.h
index 813e637..ac4f7a0 100644
--- a/compat.h
+++ b/compat.h
@@ -62,6 +62,12 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 3, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+#define snd_portid snd_pid
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #define batadv_interface_set_mac_addr(x, y) \
-- 
2.8.0.rc3

