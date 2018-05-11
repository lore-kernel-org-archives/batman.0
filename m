Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat, 12 May 2018 03:02:44 +0800
Message-Id: <20180511190244.18204-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't implement
 skb_postpush_rcsum() for linux >=4.4.47
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
Cc: Antonio Quartulli <a@unstable.cc>

skb_postpush_rcsum() has been implemented in 4.4.47 therefore
our compat code has to be changed to prevent this function to
be implemented when using those kernels.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 compat-include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 6f739464..371bb561 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -77,7 +77,7 @@ struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 
 #endif /* < KERNEL_VERSION(4, 2, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 4, 47)
 
 static inline void skb_postpush_rcsum(struct sk_buff *skb,
 				      const void *start, unsigned int len)
-- 
2.17.0

