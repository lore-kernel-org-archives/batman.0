Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 May 2011 14:22:13 +0200
Message-Id: <1305721333-28947-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1305703250-23111-1-git-send-email-ordex@autistici.org>
References: <1305703250-23111-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC/PATCH] net: add seq_before/seq_after functions
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

Introduce two operations to handle comparison between packet sequence
numbers taking into account overflow/wraparound. Batman-adv uses
these functions already to check for successor packet even in case of
overflow.
---

I added this two functions in net.h because I didn't really know where
best placement is. I saw several modules that redefine their own functions
for the same purpose.

 include/linux/net.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 94de83c..c7bc9bf 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -295,4 +295,21 @@ extern struct ratelimit_state net_ratelimit_state;
 #endif
 
 #endif /* __KERNEL__ */
+
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
 #endif	/* _LINUX_NET_H */
-- 
1.7.3.4

