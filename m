Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 23:07:59 +0200
Message-Id: <1281820085-13507-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/9] batman-adv: Provide skb_cow_head on
	kernels prior 2.6.23
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
To: b.a.t.m.a.n@lists.open-mesh.org

skb_cow_head was first introduced in v2.6.23-rc6-155-gd9cc204 and we
must use skb_cow on those kernel which will also copy the skb when it
shares data with other skbs and not only when the header is only shared.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/compat.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index f0f0b16..5bf1532 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -70,6 +70,11 @@ static inline int skb_clone_writable(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
+static inline int skb_cow_head(struct sk_buff *skb, unsigned int headroom)
+{
+	return skb_cow(skb, headroom);
+}
+
 #define cancel_delayed_work_sync(wq) cancel_delayed_work(wq)
 
 #endif /* < KERNEL_VERSION(2, 6, 23) */
-- 
1.7.1

