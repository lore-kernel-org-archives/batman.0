Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 16 Mar 2013 11:57:42 +0100
Message-Id: <1363431462-7651-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add RCU compat code for linux <
	2.6.34
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

In linux version < 2.6.34 rcu_dereference_raw() does not exist and needs to be
backported.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat.h b/compat.h
index 6a7e03b..23f43d5 100644
--- a/compat.h
+++ b/compat.h
@@ -81,6 +81,12 @@ static inline void batadv_this_cpu_add(uint64_t *count_ptr, size_t count)
 
 #define rcu_dereference_protected(p, c) (p)
 
+#define rcu_dereference_raw(p)	({ \
+				 typeof(p) _________p1 = ACCESS_ONCE(p); \
+				 smp_read_barrier_depends(); \
+				 (_________p1); \
+				 })
+
 #endif /* < KERNEL_VERSION(2, 6, 34) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 35)
-- 
1.8.1.5

