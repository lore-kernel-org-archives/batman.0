Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 10 Aug 2012 15:46:32 +0200
Message-Id: <1344606392-27130-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused hlist macros in
	compat.h
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 compat.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/compat.h b/compat.h
index 13253dd..8ac22a8 100644
--- a/compat.h
+++ b/compat.h
@@ -67,14 +67,6 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 34)
 
-#define hlist_first_rcu(head) (*((struct hlist_node **)(&(head)->first)))
-#define hlist_next_rcu(node) (*((struct hlist_node **)(&(node)->next)))
-
-#define __hlist_for_each_rcu(pos, head) \
-	for (pos = rcu_dereference(hlist_first_rcu(head)); \
-	     pos && ({ prefetch(pos->next); 1; }); \
-	     pos = rcu_dereference(hlist_next_rcu(pos)))
-
 #define rcu_dereference_protected(p, c) (p)
 
 #endif /* < KERNEL_VERSION(2, 6, 34) */
-- 
1.7.11.4

