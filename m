Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  3 Nov 2014 23:16:19 +0100
Message-Id: <1415052979-11108-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix double fetch in RCU version
	of hlist_*entry*
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
Cc: Sven Eckelmann <sven@narfation.org>

The backported (<3.9) version of hlist_for_each_entry_rcu and
hlist_for_each_entry_safe uses the new macro hlist_entry_safe. It is called
with an ACCESS_ONCE parameter for the first parameter ptr. This disallows
merging of the two loads which the current version of the macro uses.

This is problematic because this macro must only generate one load. Otherwise
with two contexts (or CPUs) following could happen:

1. context 1 fetches the ptr to the last entry in hlist_entry_safe() and
   accepts this non-NULL ptr

2. context 2 deletes the last entry and terminates the list with NULL

3. context 1 re-fetches the pointer, doesn't check for zero, calculates the
   entry based on a NULL pointer

4. context 1 crashes because it tries to load/write data from/to the invalid
   address

Instead use a single load to a temporary variable and do the NULL-check and
calculation based on that one.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat.h b/compat.h
index ed5b815..4311207 100644
--- a/compat.h
+++ b/compat.h
@@ -347,7 +347,9 @@ static int __batadv_interface_tx(struct sk_buff *skb, \
 	dev->master;\
 })
 #define hlist_entry_safe(ptr, type, member) \
-	(ptr) ? hlist_entry(ptr, type, member) : NULL
+	({ typeof(ptr) ____ptr = (ptr); \
+	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
+	})
 
 #undef hlist_for_each_entry
 #define hlist_for_each_entry(pos, head, member) \
-- 
2.1.1

