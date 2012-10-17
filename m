Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 17:59:43 +0200
Message-Id: <1350489584-10428-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Add function to calculate crc32c
	for the skb payload
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c |   34 ++++++++++++++++++++++++++++++++++
 main.h |    1 +
 2 files changed, 35 insertions(+)

diff --git a/main.c b/main.c
index 70797de..122c675 100644
--- a/main.c
+++ b/main.c
@@ -33,6 +33,7 @@
 #include "vis.h"
 #include "hash.h"
 #include "bat_algo.h"
+#include <linux/crc32c.h>
 
 
 /* List manipulations on hardif_list have to be rtnl_lock()'ed,
@@ -432,6 +433,39 @@ int batadv_compat_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+/**
+ * batadv_crc32 - calculate CRC32 of the whole packet and skip bytes in header
+ * @skb: skb pointing to fragmented socket buffers
+ * @payload_ptr: Pointer to position inside the head buffer of the skb
+ *  marking the start of the data to be CRC'ed
+ *
+ * payload_ptr must always point to the point in the skb head buffer and not to
+ * a fragment.
+ */
+__be32 batadv_crc32(const struct sk_buff *skb, u8 *payload_ptr)
+{
+	u32 crc = 0;
+	struct sk_buff *iter;
+	size_t skip_len, read_len;
+	const skb_frag_t *f;
+	int i;
+
+	skip_len = payload_ptr - skb->data;
+	read_len = skb_headlen(skb) - skip_len;
+	if (read_len)
+		crc = crc32c(crc, payload_ptr, read_len);
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		f = &skb_shinfo(skb)->frags[i];
+		crc = crc32c(crc, skb_frag_address(f), skb_frag_size(f));
+	}
+
+	skb_walk_frags(skb, iter)
+		crc = crc32c(crc, iter->data, skb_headlen(iter));
+
+	return htonl(crc);
+}
+
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
diff --git a/main.h b/main.h
index 2dfcf8c..bb0a710 100644
--- a/main.h
+++ b/main.h
@@ -177,6 +177,7 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_compat_seq_print_text(struct seq_file *seq, void *offset);
+__be32 batadv_crc32(const struct sk_buff *skb, u8 *payload_ptr);
 
 /**
  * enum batadv_dbg_level - available log levels
-- 
1.7.10.4

