Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:57:43 +0100
Message-Id: <20180302175745.12551-4-sw@simonwunderlich.de>
In-Reply-To: <20180302175745.12551-1-sw@simonwunderlich.de>
References: <20180302175745.12551-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Fix indentation of
 batadv_seq_before
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

Also multiline macros should have their statements start on a tabstop. This
was detected by checkpatch.pl after commit a134f8de9f40 ("checkpatch:
improve the TABSTOP test to include declarations").

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index d5d65999207e..057a28a9fe88 100644
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

