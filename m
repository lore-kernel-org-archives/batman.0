Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 May 2011 09:20:50 +0200
Message-Id: <1305703250-23111-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: move smallest_signed_int(),
	seq_before() and  seq_after() into main.h
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

smallest_signed_int(), seq_before() and seq_after() are very useful
functions that help to handle comparisons between sequence numbers.
However they were only defined in vis.c. With this patch every
batman-adv function will be able to use them.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.h |   16 ++++++++++++++++
 vis.c  |   16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/main.h b/main.h
index 3ca3941..90db244 100644
--- a/main.h
+++ b/main.h
@@ -181,4 +181,20 @@ static inline int compare_eth(void *data1, void *data2)
 
 #define atomic_dec_not_zero(v)	atomic_add_unless((v), -1, 0)
 
+/* Returns the smallest signed integer in two's complement with the sizeof x */
+#define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
+
+/* Checks if a sequence number x is a predecessor/successor of y.
+ * they handle overflows/underflows and can correctly check for a
+ * predecessor/successor unless the variable sequence number has grown by
+ * more then 2**(bitwidth(x)-1)-1.
+ * This means that for a uint8_t with the maximum value 255, it would think:
+ *  - when adding nothing - it is neither a predecessor nor a successor
+ *  - before adding more than 127 to the starting value - it is a predecessor,
+ *  - when adding 128 - it is neither a predecessor nor a successor,
+ *  - after adding more than 127 to the starting value - it is a successor */
+#define seq_before(x, y) ({typeof(x) _dummy = (x - y); \
+			_dummy > smallest_signed_int(_dummy); })
+#define seq_after(x, y) seq_before(y, x)
+
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/vis.c b/vis.c
index c39f20c..e1ed552 100644
--- a/vis.c
+++ b/vis.c
@@ -30,22 +30,6 @@
 
 #define MAX_VIS_PACKET_SIZE 1000
 
-/* Returns the smallest signed integer in two's complement with the sizeof x */
-#define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
-
-/* Checks if a sequence number x is a predecessor/successor of y.
- * they handle overflows/underflows and can correctly check for a
- * predecessor/successor unless the variable sequence number has grown by
- * more then 2**(bitwidth(x)-1)-1.
- * This means that for a uint8_t with the maximum value 255, it would think:
- *  - when adding nothing - it is neither a predecessor nor a successor
- *  - before adding more than 127 to the starting value - it is a predecessor,
- *  - when adding 128 - it is neither a predecessor nor a successor,
- *  - after adding more than 127 to the starting value - it is a successor */
-#define seq_before(x, y) ({typeof(x) _dummy = (x - y); \
-			_dummy > smallest_signed_int(_dummy); })
-#define seq_after(x, y) seq_before(y, x)
-
 static void start_vis_timer(struct bat_priv *bat_priv);
 
 /* free the info */
-- 
1.7.3.4

