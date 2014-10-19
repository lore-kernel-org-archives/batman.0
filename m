Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 19 Oct 2014 19:59:41 +0200
Message-Id: <1413741581-20407-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: move misplaced compat code
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

consume_skb() has to be re-defined only for kernels <2.6.30
but the macro was accidentally placed right above any #ifdef
block causing the function to be always redefined.

Fix this by moving the macro to the proper #ifdef block.

Introduced by: 15fb0fab51a3695738f65dfaab045e979fc89dce
("batman-adv add compat code for consume_skb")

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index ed5b815..8de2010 100644
--- a/compat.h
+++ b/compat.h
@@ -23,10 +23,10 @@
 
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
 
-#define consume_skb(_skb) kfree_skb(_skb)
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
 
+#define consume_skb(_skb) kfree_skb(_skb)
+
 #undef __alloc_percpu
 #define __alloc_percpu(size, align) \
 	percpu_alloc_mask((size), GFP_KERNEL, cpu_possible_map)
-- 
2.0.4

