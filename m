Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 27 Sep 2017 22:27:13 +0200
Message-Id: <20170927202713.16934-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove useless function
 skb_header_release
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

From: Gao Feng <gfree.wind@vip.163.com>

There is no one which would invokes the function skb_header_release.
So just remove it now.

Signed-off-by: Gao Feng <gfree.wind@vip.163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch was already accepted by David and should be applied directly after
the release of batman-adv 2017.3. And yes, I know that this line is too long
now

 net/batman-adv/soft-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 10f7edfb..c2c98674 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -69,7 +69,7 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
 	int result;
 
 	/* TODO: We must check if we can release all references to non-payload
-	 * data using skb_header_release in our skbs to allow skb_cow_header to
+	 * data using __skb_header_release in our skbs to allow skb_cow_header to
 	 * work optimally. This means that those skbs are not allowed to read
 	 * or write any data which is before the current position of skb->data
 	 * after that call and thus allow other skbs with the same data buffer
-- 
2.11.0

