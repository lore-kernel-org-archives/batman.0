Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Aug 2014 13:38:47 +0200
Message-Id: <1408102727-12671-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] list: fix order of arguments for
	hlist_add_after(_rcu)
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
Cc: sven@narfation.org

From: Ken Helias <kenhelias@firemail.de>

All other add functions for lists have the new item as first argument
and the position where it is added as second argument.  This was changed
for no good reason in this function and makes using it unnecessary
confusing.

The name was changed to hlist_add_behind() to cause unconverted code to
generate a compile error instead of using the wrong parameter order.

[akpm@linux-foundation.org: coding-style fixes]
Signed-off-by: Ken Helias <kenhelias@firemail.de>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>	[intel driver bits]
Cc: Hugh Dickins <hughd@google.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[sven@narfation.org: fix parameter order, add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
The patch to fix the order of arguments was already submitted to davem via
http://article.gmane.org/gmane.linux.network/326598

 compat.h        | 6 ++++++
 fragmentation.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index ed5b815..eb837ae 100644
--- a/compat.h
+++ b/compat.h
@@ -446,4 +446,10 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 16, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
+
+#define hlist_add_behind(n, prev) hlist_add_after(prev, n)
+
+#endif /* < KERNEL_VERSION(3, 17, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/fragmentation.c b/fragmentation.c
index 022d18a..fc1835c 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -188,7 +188,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 
 	/* Reached the end of the list, so insert after 'frag_entry_last'. */
 	if (likely(frag_entry_last)) {
-		hlist_add_after(&frag_entry_last->list, &frag_entry_new->list);
+		hlist_add_behind(&frag_entry_new->list, &frag_entry_last->list);
 		chain->size += skb->len - hdr_size;
 		chain->timestamp = jiffies;
 		ret = true;
-- 
2.1.0.rc1

