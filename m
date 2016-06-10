Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jun 2016 18:45:24 +0200
Message-Id: <1465577124-3678-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't propagate negative
	dev_queue_xmit return values
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

batadv_send_skb_packet used by batadv_send_skb_to_orig and its return value
is given directly to callers of batadv_send_skb_packet.

    batadv_send_skb_to_orig
    -> batadv_send_unicast_skb
       -> batadv_send_skb_packet
          -> dev_queue_xmit

These callers of batadv_send_skb_to_orig expect that the skb isn't consumed
when they receive a -1. But dev_queue_xmit may still have consumed it and
still returned -1. Thus the free for the skb would be called twice.

Fixes: e3b8acbff9c8 ("batman-adv: return netdev status in the TX path")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Antonio, this is not really tested. Could you please review it and tell me
if I may have missed something.

 net/batman-adv/send.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 49836da..d76ccb2 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -72,6 +72,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv;
 	struct ethhdr *ethhdr;
+	int ret;
 
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
@@ -109,8 +110,15 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	/* dev_queue_xmit() returns a negative result on error.	 However on
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
 	 * (which is > 0). This will not be treated as an error.
+	 *
+	 * a negative value cannot be returned because it could be interepreted
+	 * as not consumed skb by callers of batadv_send_skb_to_orig.
 	 */
-	return dev_queue_xmit(skb);
+	ret = dev_queue_xmit(skb);
+	if (ret < 0)
+		ret = NET_XMIT_DROP;
+
+	return ret;
 send_skb_err:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
-- 
2.8.1

