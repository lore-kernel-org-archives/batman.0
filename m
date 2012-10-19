Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 Oct 2012 11:51:50 +0200
Message-Id: <1350640310-8968-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Simplify crc for skb with
	skb_prepare_seq_read
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

a7fe30736a46d203b74e9fb2df3fb4e1d94222bc ("batman-adv: Add function to
calculate crc32c for the skb payload") introduced a function that walked
through the three different socket buffer classes to compute the crc32 for an
skb. This function is affected by many changes to the sk_buff structure in
future. This can be avoided by using the sequential read functions to access
blocks transparently.

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h |   35 -----------------------------------
 main.c   |   31 +++++++++++++------------------
 main.h   |    2 +-
 3 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/compat.h b/compat.h
index 83befd1..be685aa 100644
--- a/compat.h
+++ b/compat.h
@@ -37,9 +37,6 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 31)
 
-#define skb_walk_frags(skb, iter)       \
-	for (iter = skb_shinfo(skb)->frag_list; iter; iter = iter->next)
-
 #define __compat__module_param_call(p1, p2, p3, p4, p5, p6, p7) \
 	__module_param_call(p1, p2, p3, p4, p5, p7)
 
@@ -81,18 +78,6 @@
 #endif /* < KERNEL_VERSION(2, 6, 35) */
 
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 37)
-
-#define kmap_atomic(p)  kmap_atomic(p, KM_SKB_DATA_SOFTIRQ)
-
-#ifdef kunmap_atomic
-#undef kunmap_atomic
-#endif
-#define kunmap_atomic(x, arg...)        do { pagefault_enable(); } while (0)
-
-#endif /* < KERNEL_VERSION(2, 6, 37) */
-
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
 
 #define __rcu
@@ -160,26 +145,6 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 2, 0)
-
-static inline struct page *skb_frag_page(const skb_frag_t *frag)
-{
-	return frag->page;
-}
-
-static inline void *skb_frag_address(const skb_frag_t *frag)
-{
-	return page_address(skb_frag_page(frag)) + frag->page_offset;
-}
-
-static inline unsigned int skb_frag_size(const skb_frag_t *frag)
-{
-	return frag->size;
-}
-
-#endif /* < KERNEL_VERSION(3, 2, 0) */
-
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
 
 static inline void eth_hw_addr_random(struct net_device *dev)
diff --git a/main.c b/main.c
index 2b1123d..253e240 100644
--- a/main.c
+++ b/main.c
@@ -444,29 +444,24 @@ int batadv_compat_seq_print_text(struct seq_file *seq, void *offset)
  * payload_ptr must always point to an address in the skb head buffer and not to
  * a fragment.
  */
-__be32 batadv_skb_crc32(const struct sk_buff *skb, u8 *payload_ptr)
+__be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
 {
 	u32 crc = 0;
-	struct sk_buff *iter;
-	size_t skip_len, read_len;
-	const skb_frag_t *f;
-	u8 *vaddr;
-	int i;
+	unsigned int from;
+	unsigned int to = skb->len;
+	struct skb_seq_state st;
+	const u8 *data;
+	unsigned int len;
+	unsigned int consumed = 0;
 
-	skip_len = payload_ptr - skb->data;
-	read_len = skb_headlen(skb) - skip_len;
-	if (read_len)
-		crc = crc32c(crc, payload_ptr, read_len);
+	from = (unsigned int)(payload_ptr - skb->data);
 
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-		f = &skb_shinfo(skb)->frags[i];
-		vaddr = kmap_atomic(skb_frag_page(f));
-		crc = crc32c(crc, vaddr + f->page_offset, skb_frag_size(f));
-		kunmap_atomic(vaddr);
+	skb_prepare_seq_read(skb, from, to, &st);
+	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
+		crc = crc32c(crc, data, len);
+		consumed += len;
 	}
-
-	skb_walk_frags(skb, iter)
-		crc = crc32c(crc, iter->data, skb_headlen(iter));
+	skb_abort_seq_read(&st);
 
 	return htonl(crc);
 }
diff --git a/main.h b/main.h
index e147261..3321173 100644
--- a/main.h
+++ b/main.h
@@ -177,7 +177,7 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_compat_seq_print_text(struct seq_file *seq, void *offset);
-__be32 batadv_skb_crc32(const struct sk_buff *skb, u8 *payload_ptr);
+__be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
 
 /**
  * enum batadv_dbg_level - available log levels
-- 
1.7.10.4

