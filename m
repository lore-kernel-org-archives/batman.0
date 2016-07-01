Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Jul 2016 15:09:04 +0200
Message-Id: <1467378549-9646-13-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
References: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 12/17] batman-adv: Set skb priority in
	fragments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Andrew Lunn <andrew@lunn.ch>

BATMAN will set the skb->priority based on the IP precedence or 802.1q
tag. However, if it needs to fragment the frame, it currently leaves
the fragment skb with the default priority and actually overwrites the
priority in the unfragmented frame. Fix this.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 65536db..a119b6a 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -27,7 +27,6 @@
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
-#include <linux/pkt_sched.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -414,7 +413,7 @@ static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
 	if (!skb_fragment)
 		goto err;
 
-	skb->priority = TC_PRIO_CONTROL;
+	skb_fragment->priority = skb->priority;
 
 	/* Eat the last mtu-bytes of the skb */
 	skb_reserve(skb_fragment, header_size + ETH_HLEN);
-- 
2.8.1

