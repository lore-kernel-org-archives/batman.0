Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 Jan 2017 10:25:25 +0100
Message-Id: <20170128092526.9219-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix double call of
	dev_queue_xmit
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

The net_xmit_eval has side effects because it is not making sure that e
isn't evaluated twice.

    #define net_xmit_eval(e)        ((e) == NET_XMIT_CN ? 0 : (e))

The code proposed by David Miller

    return net_xmit_eval(dev_queue_xmit(skb));

will therefore get transformed into

    return ((dev_queue_xmit(skb)) == NET_XMIT_CN ? 0 : (dev_queue_xmit(skb)))

dev_queue_xmit will therefore be tried again (with an already consumed skb)
whenever the return code is not NET_XMIT_CN.

Fixes: 17efab9867c5 ("batman-adv: Simplify handling of NET_XMIT_CN")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d9b28890..1489ec27 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -77,6 +77,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv;
 	struct ethhdr *ethhdr;
+	int ret;
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
@@ -115,7 +116,8 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
 	 * (which is > 0). This will not be treated as an error.
 	 */
-	return net_xmit_eval(dev_queue_xmit(skb));
+	ret = dev_queue_xmit(skb);
+	return net_xmit_eval(ret);
 send_skb_err:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
-- 
2.11.0

