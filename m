Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Oct 2016 08:36:28 +0100
Message-Id: <20161031073629.31819-5-sven@narfation.org>
In-Reply-To: <1637163.TC9CcXIrIP@sven-edge>
References: <1637163.TC9CcXIrIP@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Revert "compat: Port netlink
	port hack to coccinelle"
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

The coccinelle in Debian Jessie seems to be broken. It fails to parse
the patches and thus makes it impossible to use the out-of-tree
module in these systems. Therefore drop it for now.

This reverts commit 57ed6cbca85a0a681a0fa8b4690259429f3ea9a5.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/netlink.h           | 20 +++++++++++++-------
 compat-include/net/genetlink.h           | 11 -----------
 compat-patches/0001-netlink-portid.cocci | 17 -----------------
 compat.h                                 |  6 ++++++
 4 files changed, 19 insertions(+), 35 deletions(-)
 delete mode 100644 compat-patches/0001-netlink-portid.cocci

diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index ca2bdf0..4f2185d 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -26,13 +26,19 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
 
-#define netlink_notify_portid(__notify) (__notify->pid)
-#define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).pid
-
-#else
-
-#define netlink_notify_portid(__notify) (__notify->portid)
-#define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).portid
+#include <net/scm.h>
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
+#define NETLINK_CB(skb) (*(struct batadv_netlink_skb_parms *)&((skb)->cb))
 
 #endif /* < KERNEL_VERSION(3, 7, 0) */
 
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index b057e6c..2e8e17a 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -24,17 +24,6 @@
 #include <linux/version.h>
 #include_next <net/genetlink.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
-
-#define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
-
-#else
-
-#define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
-
-#endif /* < KERNEL_VERSION(3, 7, 0) */
-
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0)
 
 #include <linux/export.h>
diff --git a/compat-patches/0001-netlink-portid.cocci b/compat-patches/0001-netlink-portid.cocci
deleted file mode 100644
index 5fc504e..0000000
--- a/compat-patches/0001-netlink-portid.cocci
+++ /dev/null
@@ -1,17 +0,0 @@
-@@
-struct netlink_notify *notify;
-@@
--notify->portid
-+netlink_notify_portid(notify)
-
-@@
-struct genl_info *info;
-@@
--info->snd_portid
-+genl_info_snd_portid(info)
-
-@@
-expression skb;
-@@
--NETLINK_CB(skb).portid
-+NETLINK_CB_PORTID(skb)
diff --git a/compat.h b/compat.h
index 78de7ea..d987577 100644
--- a/compat.h
+++ b/compat.h
@@ -67,6 +67,12 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
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
2.10.1

