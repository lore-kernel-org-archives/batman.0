Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Dec 2011 22:38:01 +0100
Message-Id: <1324676281-20118-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix compilation with linux
	2.6.29 and 2.6.30
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

Linux v2.6.30-2332-gfddd520 introduced a seventh parameter to
__module_param_call. It is used to give a slightly different user experience
for bool parameters. Older kernels can just drop this information using a
special compat wrapper for __module_param_call.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/compat.h b/compat.h
index 3733f68..eb7ab50 100644
--- a/compat.h
+++ b/compat.h
@@ -56,6 +56,20 @@
 
 #endif /* < KERNEL_VERSION(2, 6, 34) */
 
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 31)
+
+#define __compat__module_param_call(p1, p2, p3, p4, p5, p6, p7) \
+	__module_param_call(p1, p2, p3, p4, p5, p7)
+
+#else
+
+#define __compat__module_param_call(p1, p2, p3, p4, p5, p6, p7) \
+	__module_param_call(p1, p2, p3, p4, p5, p6, p7)
+
+#endif /* < KERNEL_VERSION(2, 6, 31) */
+
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
 
 #define __rcu
@@ -77,10 +91,10 @@ struct kernel_param_ops {
 	static int __compat_get_param_##name(char *buffer,		\
 					     struct kernel_param *kp)	\
 				{ return (ops)->get(buffer, kp); }	\
-	__module_param_call(MODULE_PARAM_PREFIX, name,			\
-			    __compat_set_param_##name,			\
-			    __compat_get_param_##name, arg,		\
-			    __same_type((arg), bool *), perm)
+	__compat__module_param_call(MODULE_PARAM_PREFIX, name,		\
+				    __compat_set_param_##name,		\
+				    __compat_get_param_##name, arg,	\
+				    __same_type((arg), bool *), perm)
 
 static inline int __param_set_copystring(const char *val,
 					 const struct kernel_param *kp)
@@ -91,6 +105,7 @@ static inline int __param_set_copystring(const char *val,
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
 
 #define kstrtoul strict_strtoul
-- 
1.7.7.3

