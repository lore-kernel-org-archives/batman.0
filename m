Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 26 Jan 2017 17:44:04 +0100
Message-Id: <20170126164404.16074-8-sw@simonwunderlich.de>
In-Reply-To: <20170126164404.16074-1-sw@simonwunderlich.de>
References: <20170126164404.16074-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: Treat NET_XMIT_CN as
	transmit successfully
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
Cc: Gao Feng <gfree.wind@gmail.com>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Gao Feng <gfree.wind@gmail.com>

The tc could return NET_XMIT_CN as one congestion notification, but
it does not mean the packet is lost. Other modules like ipvlan,
macvlan, and others treat NET_XMIT_CN as success too.

So batman-adv should handle NET_XMIT_CN also as NET_XMIT_SUCCESS.

Signed-off-by: Gao Feng <gfree.wind@gmail.com>
[sven@narfation.org: Moved NET_XMIT_CN handling to batadv_send_skb_packet]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d7308263b8fa..d9b2889064a6 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -115,7 +115,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
 	 * (which is > 0). This will not be treated as an error.
 	 */
-	return dev_queue_xmit(skb);
+	return net_xmit_eval(dev_queue_xmit(skb));
 send_skb_err:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
-- 
2.11.0

