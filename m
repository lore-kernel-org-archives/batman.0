Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  1 Sep 2014 14:37:26 +0200
Message-Id: <1409575049-32726-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
References: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: checkpatch - No space is
	necessary after a cast
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

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 main.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/main.h b/main.h
index 4c557eb..52cb007 100644
--- a/main.h
+++ b/main.h
@@ -313,10 +313,10 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
  *  - when adding 128 - it is neither a predecessor nor a successor,
  *  - after adding more than 127 to the starting value - it is a successor
  */
-#define batadv_seq_before(x, y) ({typeof(x) _d1 = (x); \
-				 typeof(y) _d2 = (y); \
-				 typeof(x) _dummy = (_d1 - _d2); \
-				 (void) (&_d1 == &_d2); \
+#define batadv_seq_before(x, y) ({typeof(x)_d1 = (x); \
+				 typeof(y)_d2 = (y); \
+				 typeof(x)_dummy = (_d1 - _d2); \
+				 (void)(&_d1 == &_d2); \
 				 _dummy > batadv_smallest_signed_int(_dummy); })
 #define batadv_seq_after(x, y) batadv_seq_before(y, x)
 
-- 
1.8.5.5

