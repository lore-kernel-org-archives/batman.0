Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2016 19:54:49 +0200
Message-Id: <1466445289-17840-2-git-send-email-sven@narfation.org>
In-Reply-To: <1466445210-17616-1-git-send-email-sven@narfation.org>
References: <1466445210-17616-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next v2 4/4] batman-adv: Remove unnecessary
	call to dev_xmit_complete
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

The dev_xmit_complete function is only necessary to check the return value
for *_hard_xmit functions. But batman-adv only uses dev_queue_xmit to send
data via the interface queue.

From the kerneldoc of __dev_queue_xmit:

    Regardless of the return value, the skb is consumed, so it is currently
    difficult to retry a send to this method.  (You can bump the ref count
    before sending to hold a reference for retry if you are careful.)

Fixes: e3b8acbff9c8 ("batman-adv: return netdev status in the TX path")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - added this patch

 net/batman-adv/routing.c | 10 ++++------
 net/batman-adv/send.c    |  2 +-
 net/batman-adv/tvlv.c    |  2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 2bc9645..af8e119 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -274,8 +274,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 		if (res == -1)
 			goto out;
 
-		if (dev_xmit_complete(res))
-			ret = NET_RX_SUCCESS;
+		ret = NET_RX_SUCCESS;
 
 		break;
 	case BATADV_TP:
@@ -335,7 +334,7 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet->ttl = BATADV_TTL;
 
 	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (res != -1 && dev_xmit_complete(res))
+	if (res != -1)
 		ret = NET_RX_SUCCESS;
 
 out:
@@ -423,7 +422,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 	/* route it */
 	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
-	if (res != -1 && dev_xmit_complete(res))
+	if (res != -1)
 		ret = NET_RX_SUCCESS;
 
 out:
@@ -671,8 +670,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 				   len + ETH_HLEN);
 	}
 
-	if (dev_xmit_complete(res))
-		ret = NET_RX_SUCCESS;
+	ret = NET_RX_SUCCESS;
 
 out:
 	if (orig_node)
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 80208f1..3a10d87 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -366,7 +366,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
 	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (res != -1 && dev_xmit_complete(res))
+	if (res != -1)
 		ret = NET_XMIT_SUCCESS;
 
 out:
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 8c59420..3d1cf0f 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -625,7 +625,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
 
 	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (!(res != -1 && dev_xmit_complete(res)))
+	if (res == -1)
 		kfree_skb(skb);
 out:
 	batadv_orig_node_put(orig_node);
-- 
2.8.1

