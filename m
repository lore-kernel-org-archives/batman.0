Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  9 Oct 2016 08:57:33 +0200
Message-Id: <20161009065738.8279-6-sven@narfation.org>
In-Reply-To: <1647833.jYley1tZnH@sven-edge>
References: <1647833.jYley1tZnH@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v2 06/11] batman-adv: compat: Port netlink
	port hack to coccinelle
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - new patch
---
 compat-include/linux/netlink.h           | 20 +++++++-------------
 compat-include/net/genetlink.h           | 11 +++++++++++
 compat-patches/0001-netlink-portid.cocci | 17 +++++++++++++++++
 compat.h                                 |  6 ------
 4 files changed, 35 insertions(+), 19 deletions(-)
 create mode 100644 compat-patches/0001-netlink-portid.cocci

diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index 4f2185d..ca2bdf0 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -26,19 +26,13 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
 
-#include <net/scm.h>
-
-struct batadv_netlink_skb_parms {
-	struct ucred		creds;		/* Skb credentials	*/
-	union {
-		__u32		portid;
-		__u32		pid;
-	};
-	__u32			dst_group;
-};
-
-#undef NETLINK_CB
-#define NETLINK_CB(skb) (*(struct batadv_netlink_skb_parms *)&((skb)->cb))
+#define netlink_notify_portid(__notify) (__notify->pid)
+#define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).pid
+
+#else
+
+#define netlink_notify_portid(__notify) (__notify->portid)
+#define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).portid
 
 #endif /* < KERNEL_VERSION(3, 7, 0) */
 
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index b48e37a..19390c7 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -24,6 +24,17 @@
 #include <linux/version.h>
 #include_next <net/genetlink.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+#define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
+
+#else
+
+#define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0)
 
 #include <linux/export.h>
diff --git a/compat-patches/0001-netlink-portid.cocci b/compat-patches/0001-netlink-portid.cocci
new file mode 100644
index 0000000..5fc504e
--- /dev/null
+++ b/compat-patches/0001-netlink-portid.cocci
@@ -0,0 +1,17 @@
+@@
+struct netlink_notify *notify;
+@@
+-notify->portid
++netlink_notify_portid(notify)
+
+@@
+struct genl_info *info;
+@@
+-info->snd_portid
++genl_info_snd_portid(info)
+
+@@
+expression skb;
+@@
+-NETLINK_CB(skb).portid
++NETLINK_CB_PORTID(skb)
diff --git a/compat.h b/compat.h
index d987577..78de7ea 100644
--- a/compat.h
+++ b/compat.h
@@ -67,12 +67,6 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 3, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
-
-#define snd_portid snd_pid
-
-#endif /* < KERNEL_VERSION(3, 7, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #define batadv_interface_set_mac_addr(x, y) \
-- 
2.9.3

