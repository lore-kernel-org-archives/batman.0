Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 19 May 2011 21:43:08 +0200
Message-Id: <1305834188-15514-1-git-send-email-sven@narfation.org>
In-Reply-To: <201105192141.18647.sven@narfation.org>
References: <201105192141.18647.sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Check type of x and y in
	seq_(before|after)
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

seq_before and seq_after depend on the fact that both sequence numbers
have the same type and thus the same bitwidth. We can ensure that by
compile time checking using a compare between the pointer to the
temporary buffers which were created using the typeof of both
parameters. For example gcc would create a warning like
"warning: comparison of distinct pointer types lacks a cast".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/main.h b/main.h
index db29444..3395bf9 100644
--- a/main.h
+++ b/main.h
@@ -196,8 +196,11 @@ static inline int compare_eth(const void *data1, const void *data2)
  *  - before adding more than 127 to the starting value - it is a predecessor,
  *  - when adding 128 - it is neither a predecessor nor a successor,
  *  - after adding more than 127 to the starting value - it is a successor */
-#define seq_before(x, y) ({typeof(x) _dummy = (x - y); \
-			_dummy > smallest_signed_int(_dummy); })
+#define seq_before(x, y) ({typeof(x) _d1 = (x); \
+			  typeof(y) _d2 = (y); \
+			  typeof(x) _dummy = (_d1 - _d2); \
+			  (void) (&_d1 == &_d2); \
+			  _dummy > smallest_signed_int(_dummy); })
 #define seq_after(x, y) seq_before(y, x)
 
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
-- 
1.7.5.1

