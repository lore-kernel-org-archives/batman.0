Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 6/6] batman-adv: bcast: remove remaining skb-copy calls
Date: Fri, 20 Aug 2021 10:33:00 +0200
Message-Id: <20210820083300.32289-7-sw@simonwunderlich.de>
In-Reply-To: <20210820083300.32289-1-sw@simonwunderlich.de>
References: <20210820083300.32289-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

We currently have two code paths for broadcast packets:

A) self-generated, via batadv_interface_tx()->
   batadv_send_bcast_packet().
B) received/forwarded, via batadv_recv_bcast_packet()->
   batadv_forw_bcast_packet().

For A), self-generated broadcast packets:

The only modifications to the skb data is the ethernet header which is
added/pushed to the skb in
batadv_send_broadcast_skb()->batadv_send_skb_packet(). However before
doing so, batadv_skb_head_push() is called which calls skb_cow_head() to
unshare the space for the to be pushed ethernet header. So for this
case, it is safe to use skb clones.

For B), received/forwarded packets:

The same applies as in A) for the to be forwarded packets. Only the
ethernet header is added. However after (queueing for) forwarding the
packet in batadv_recv_bcast_packet()->batadv_forw_bcast_packet(), a
packet is additionally decapsulated and is sent up the stack through
batadv_recv_bcast_packet()->batadv_interface_rx().

Protocols higher up the stack are already required to check if the
packet is shared and create a copy for further modifications. When the
next (protocol) layer works correctly, it cannot happen that it tries to
operate on the data behind the skb clone which is still queued up for
forwarding.

Co-authored-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/send.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 2a33458be65c..477d85a3b558 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -742,6 +742,10 @@ void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
  * Adds a broadcast packet to the queue and sets up timers. Broadcast packets
  * are sent multiple times to increase probability for being received.
  *
+ * This call clones the given skb, hence the caller needs to take into
+ * account that the data segment of the original skb might not be
+ * modifiable anymore.
+ *
  * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
  */
 static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
@@ -755,7 +759,7 @@ static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	unsigned long send_time = jiffies;
 	struct sk_buff *newskb;
 
-	newskb = skb_copy(skb, GFP_ATOMIC);
+	newskb = skb_clone(skb, GFP_ATOMIC);
 	if (!newskb)
 		goto err;
 
@@ -794,6 +798,10 @@ static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
  * or if a delay is given after that. Furthermore, queues additional
  * retransmissions if this interface is a wireless one.
  *
+ * This call clones the given skb, hence the caller needs to take into
+ * account that the data segment of the original skb might not be
+ * modifiable anymore.
+ *
  * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
  */
 static int batadv_forw_bcast_packet_if(struct batadv_priv *bat_priv,
@@ -808,7 +816,7 @@ static int batadv_forw_bcast_packet_if(struct batadv_priv *bat_priv,
 	int ret = NETDEV_TX_OK;
 
 	if (!delay) {
-		newskb = skb_copy(skb, GFP_ATOMIC);
+		newskb = skb_clone(skb, GFP_ATOMIC);
 		if (!newskb)
 			return NETDEV_TX_BUSY;
 
-- 
2.20.1

