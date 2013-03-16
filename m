Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 16 Mar 2013 12:49:18 +0100
Message-Id: <1363434558-29876-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: add RCU compat code for kernel
	< 2.6.37
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

In linux version < 2.6.37 hlist_first_rcu() and hlist_next_rcu() do not exist
and therefore they need to be backported.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat.h b/compat.h
index e1c6cd2..a71be7d 100644
--- a/compat.h
+++ b/compat.h
@@ -129,6 +129,12 @@ static inline int batadv_param_set_copystring(const char *val,
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 37)
+
+#define hlist_first_rcu(head)	(*((struct hlist_node __rcu **)(&(head)->first)))
+#define hlist_next_rcu(node)	(*((struct hlist_node __rcu **)(&(node)->next)))
+
+#endif /* < KERNEL_VERSION(2, 6, 37) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
 
-- 
1.8.1.5

