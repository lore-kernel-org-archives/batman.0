Return-Path: <felix@kaechele.ca>
From: Felix Kaechele <felix@kaechele.ca>
Subject: [PATCH] batman-adv: compat: Fix build on RHEL 8.1 and clones
Date: Sat, 25 Jan 2020 13:07:45 -0500
Message-Id: <20200125180745.19517-1-felix@kaechele.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

RHEL 8.1 backported some fixes from newer kernels so we need to treat it's 4.18
kernel as if it were a newer kernel in some cases.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
---
 compat-include/linux/igmp.h    | 2 +-
 compat-include/linux/uaccess.h | 2 +-
 compat-include/net/addrconf.h  | 2 +-
 compat.h                       | 6 ++++++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/compat-include/linux/igmp.h b/compat-include/linux/igmp.h
index ecedc915..60606f05 100644
--- a/compat-include/linux/igmp.h
+++ b/compat-include/linux/igmp.h
@@ -17,7 +17,7 @@
 
 int ip_mc_check_igmp(struct sk_buff *skb);
 
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(5, 1, 0)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(5, 1, 0) && !defined(RHEL_81)
 
 static inline int batadv_ip_mc_check_igmp(struct sk_buff *skb)
 {
diff --git a/compat-include/linux/uaccess.h b/compat-include/linux/uaccess.h
index e81ed805..5a337441 100644
--- a/compat-include/linux/uaccess.h
+++ b/compat-include/linux/uaccess.h
@@ -13,7 +13,7 @@
 #include <linux/version.h>
 #include_next <linux/uaccess.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 0, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 0, 0) && !defined(RHEL_81)
 
 static inline int batadv_access_ok(int type, const void __user *p,
 				   unsigned long size)
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
index b826ee95..5ab19043 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -17,7 +17,7 @@
 
 int ipv6_mc_check_mld(struct sk_buff *skb);
 
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(5, 1, 0)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(5, 1, 0) && !defined(RHEL_81)
 
 static inline int batadv_ipv6_mc_check_mld(struct sk_buff *skb)
 {
diff --git a/compat.h b/compat.h
index 980fca9f..7f4a5ee4 100644
--- a/compat.h
+++ b/compat.h
@@ -44,6 +44,12 @@
 
 #endif /* < KERNEL_VERSION(4, 15, 0) */
 
+#ifdef RHEL_RELEASE_CODE
+# if RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(8, 1)
+#  define RHEL_81
+# endif
+#endif /* RHEL_RELEASE_CODE */
+
 #endif /* __KERNEL__ */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
2.24.1

