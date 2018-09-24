Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 24 Sep 2018 11:16:09 +0200
Message-Id: <20180924091609.20794-2-sven@narfation.org>
In-Reply-To: <20180924091609.20794-1-sven@narfation.org>
References: <20180924091609.20794-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix colliding
 redefinition of skb_postpush_rcsum
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

Linux >=4.4.47 have the function skb_postpush_rcsum already and also v3.16
got it with  v3.16.57. Even older stable kernel versions might also have
gotten this function with a stable release. Maintaining a full list of
kernel versions which have this functionality is too much of a burden and
thus the calls to this function are simply replaced with calls to a new
private function batadv_skb_postpush_rcsum.

Reported-by: Andreas Ziegler <dev@andreas-ziegler.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/skbuff.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 36e4d10d..376ea10b 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -45,16 +45,18 @@ struct sk_buff *skb_checksum_trimmed(struct sk_buff *skb,
 
 #endif /* < KERNEL_VERSION(4, 2, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 4, 47)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
 
-static inline void skb_postpush_rcsum(struct sk_buff *skb,
-				      const void *start, unsigned int len)
+static inline void batadv_skb_postpush_rcsum(struct sk_buff *skb,
+					     const void *start, unsigned int len)
 {
 	if (skb->ip_summed == CHECKSUM_COMPLETE)
 		skb->csum = csum_block_add(skb->csum,
 					   csum_partial(start, len, 0), 0);
 }
 
+#define skb_postpush_rcsum batadv_skb_postpush_rcsum
+
 #endif /* < KERNEL_VERSION(4, 5, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 13, 0)
-- 
2.11.0

