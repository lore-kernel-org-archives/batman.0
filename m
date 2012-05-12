Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 13:48:59 +0200
Message-Id: <1336823339-4095-8-git-send-email-sven@narfation.org>
In-Reply-To: <1336823339-4095-1-git-send-email-sven@narfation.org>
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 8/8] batman-adv: Prefix compat static inline
	functions with batadv_
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

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index 7347890..d58ba17 100644
--- a/compat.h
+++ b/compat.h
@@ -113,12 +113,12 @@ struct kernel_param_ops {
 				    __compat_get_param_##name, arg,	\
 				    __same_type((arg), bool *), perm)
 
-static inline int __param_set_copystring(const char *val,
-					 const struct kernel_param *kp)
+static inline int batadv_param_set_copystring(const char *val,
+					      const struct kernel_param *kp)
 {
 	return param_set_copystring(val, (struct kernel_param *)kp);
 }
-#define param_set_copystring __param_set_copystring
+#define param_set_copystring batadv_param_set_copystring
 
 /* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
 #define addr_assign_type ifindex
-- 
1.7.10

