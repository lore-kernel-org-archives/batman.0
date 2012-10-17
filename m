Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 21:10:39 +0200
Message-Id: <1350501039-18346-1-git-send-email-sven@narfation.org>
In-Reply-To: <1350494314-16089-1-git-send-email-sven@narfation.org>
References: <1350494314-16089-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFCv3] batman-adv: Add function to calculate crc32c
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
v3: Now with support for kernels till 2.6.29

 compat.h |   34 ++++++++++++++++++++++++++++++++++
 main.c   |   38 ++++++++++++++++++++++++++++++++++++++
 main.h   |    1 +
 3 files changed, 73 insertions(+)

diff --git a/compat.h b/compat.h
index 0caf43b..83befd1 100644
--- a/compat.h
+++ b/compat.h
@@ -37,6 +37,9 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 31)
 
+#define skb_walk_frags(skb, iter)       \
+	for (iter = skb_shinfo(skb)->frag_list; iter; iter = iter->next)
+
 #define __compat__module_param_call(p1, p2, p3, p4, p5, p6, p7) \
 	__module_param_call(p1, p2, p3, p4, p5, p7)
 
@@ -78,6 +81,17 @@
 #endif /* < KERNEL_VERSION(2, 6, 35) */
 
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 37)
+
+#define kmap_atomic(p)  kmap_atomic(p, KM_SKB_DATA_SOFTIRQ)
+
+#ifdef kunmap_atomic
+#undef kunmap_atomic
+#endif
+#define kunmap_atomic(x, arg...)        do { pagefault_enable(); } while (0)
+
+#endif /* < KERNEL_VERSION(2, 6, 37) */
+
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
 
@@ -146,6 +160,26 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 2, 0)
+
+static inline struct page *skb_frag_page(const skb_frag_t *frag)
+{
+	return frag->page;
+}
+
+static inline void *skb_frag_address(const skb_frag_t *frag)
+{
+	return page_address(skb_frag_page(frag)) + frag->page_offset;
+}
+
+static inline unsigned int skb_frag_size(const skb_frag_t *frag)
+{
+	return frag->size;
+}
+
+#endif /* < KERNEL_VERSION(3, 2, 0) */
+
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
 
 static inline void eth_hw_addr_random(struct net_device *dev)
diff --git a/main.c b/main.c
index 70797de..df5f7d6 100644
--- a/main.c
+++ b/main.c
@@ -17,6 +17,8 @@
  * 02110-1301, USA
  */
 
+#include <linux/crc32c.h>
+#include <linux/highmem.h>
 #include "main.h"
 #include "sysfs.h"
 #include "debugfs.h"
@@ -432,6 +434,42 @@ int batadv_compat_seq_print_text(struct seq_file *seq, void *offset)
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
+	u8 *vaddr;
+	int i;
+
+	skip_len = payload_ptr - skb->data;
+	read_len = skb_headlen(skb) - skip_len;
+	if (read_len)
+		crc = crc32c(crc, payload_ptr, read_len);
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		f = &skb_shinfo(skb)->frags[i];
+		vaddr = kmap_atomic(skb_frag_page(f));
+		crc = crc32c(crc, vaddr + f->page_offset, skb_frag_size(f));
+		kunmap_atomic(vaddr);
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

