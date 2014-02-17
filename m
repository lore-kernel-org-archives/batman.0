Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 09:29:32 +0100
Message-Id: <1392625772-1860-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv add compat code for consume_skb
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

consume_skb() has been implemented in 2.6.30, therefore some
some compat code is needed for 2.6.29. This patch adds it.

Introduced by 9289542085d7e298b90c7b6fb6efb509dab69d8b
("batman-adv: free skb on TVLV parsing success")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat.h b/compat.h
index deea92b..94407a6 100644
--- a/compat.h
+++ b/compat.h
@@ -26,6 +26,8 @@
 
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
 
+#define consume_skb(_skb) kfree_skb(_skb)
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
 
 #undef __alloc_percpu
-- 
1.8.5.3

