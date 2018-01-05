Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  5 Jan 2018 09:54:32 +0100
Message-Id: <20180105085432.15692-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixed statements not starting on
 a tabstop
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

Also multiline macros should have their statements start on a tabstop. This
was detected by checkpatch.pl with "checkpatch: Improve the TABSTOP test to
include declarations".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 5f34c495..1a9c7a3c 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -331,11 +331,13 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
  *
  * Return: true when x is a predecessor of y, false otherwise
  */
-#define batadv_seq_before(x, y) ({typeof(x)_d1 = (x); \
-				 typeof(y)_d2 = (y); \
-				 typeof(x)_dummy = (_d1 - _d2); \
-				 (void)(&_d1 == &_d2); \
-				 _dummy > batadv_smallest_signed_int(_dummy); })
+#define batadv_seq_before(x, y) ({ \
+	typeof(x)_d1 = (x); \
+	typeof(y)_d2 = (y); \
+	typeof(x)_dummy = (_d1 - _d2); \
+	(void)(&_d1 == &_d2); \
+	_dummy > batadv_smallest_signed_int(_dummy); \
+})
 
 /**
  * batadv_seq_after() - Checks if a sequence number x is a successor of y
-- 
2.11.0

