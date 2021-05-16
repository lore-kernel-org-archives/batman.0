Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v3 3/3] batman-adv: bcast: remove remaining skb-copy calls for broadcasts
Date: Mon, 17 May 2021 00:33:09 +0200
Message-Id: <20210516223309.12596-3-linus.luessing@c0d3.blue>
In-Reply-To: <20210516223309.12596-1-linus.luessing@c0d3.blue>
References: <20210516223309.12596-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

We currently have two code paths for broadcast packets: A)
self-generated, via batadv_interface_tx()->batadv_send_bcast_packet().
Or B) received/forwarded, via batadv_recv_bcast_packet()->
batadv_forw_bcast_packet().

For A), self-generated broadcast packets the only modifications to the
skb data is the ethernet header which is added/pushed to the skb in
batadv_send_broadcast_skb()->batadv_send_skb_packet(). However before
doing so batadv_skb_head_push() is called which calls skb_cow_head() to
unshare the space for the to be pushed ethernet header. So for this
case, it is safe to use skb clones.

For B), received/forwarded packets the same applies as in A) for the
to be forwarded packets. Only the ethernet header is added. However
after (queueing for) forwarding the packet in
batadv_recv_bcast_packet()->batadv_forw_bcast_packet() a packet is
additionally decapsulated and is sent up the stack through
batadv_recv_bcast_packet()->batadv_interface_rx(). Which needs an
unshared skb data for potential modifications from other protocols.
To be able to use skb clones for (re)broadcasted batman-adv broadcast
packets while still ensuring that interface_rx() has a freely writeable
skb we use skb_cow() to avoid sharing skb data with the skb clones in
the forwarding calls.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---

Changelog v3:

* newly added this patch, to move skb_copy()->skb_clone() changes from
  PATCH 01/03 to a separate patch with its own explanation

 net/batman-adv/send.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 0b9dd29d..1db6b217 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -748,6 +748,10 @@ void batadv_forw_packet_ogmv1_queue(struct batadv_pr=
iv *bat_priv,
  * Adds a broadcast packet to the queue and sets up timers. Broadcast pa=
ckets
  * are sent multiple times to increase probability for being received.
  *
+ * This call clones the given skb, hence the caller needs to take into
+ * account that the data segment of the original skb might not be
+ * modifiable anymore.
+ *
  * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
  */
 static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv=
,
@@ -761,7 +765,7 @@ static int batadv_forw_bcast_packet_to_list(struct ba=
tadv_priv *bat_priv,
 	unsigned long send_time =3D jiffies;
 	struct sk_buff *newskb;
=20
-	newskb =3D skb_copy(skb, GFP_ATOMIC);
+	newskb =3D skb_clone(skb, GFP_ATOMIC);
 	if (!newskb)
 		goto err;
=20
@@ -800,6 +804,10 @@ static int batadv_forw_bcast_packet_to_list(struct b=
atadv_priv *bat_priv,
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
@@ -814,7 +822,7 @@ static int batadv_forw_bcast_packet_if(struct batadv_=
priv *bat_priv,
 	int ret =3D NETDEV_TX_OK;
=20
 	if (!delay) {
-		newskb =3D skb_copy(skb, GFP_ATOMIC);
+		newskb =3D skb_clone(skb, GFP_ATOMIC);
 		if (!newskb)
 			return NETDEV_TX_BUSY;
=20
@@ -966,6 +974,8 @@ static int __batadv_forw_bcast_packet(struct batadv_p=
riv *bat_priv,
  * after that. Furthermore, queues additional retransmissions on wireles=
s
  * interfaces.
  *
+ * This call might reallocate skb data.
+ *
  * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
  */
 int batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
@@ -973,7 +983,15 @@ int batadv_forw_bcast_packet(struct batadv_priv *bat=
_priv,
 			     unsigned long delay,
 			     bool own_packet)
 {
-	return __batadv_forw_bcast_packet(bat_priv, skb, delay, own_packet);
+	int ret =3D __batadv_forw_bcast_packet(bat_priv, skb, delay, own_packet=
);
+
+	if (ret =3D=3D NETDEV_TX_BUSY)
+		return ret;
+
+	/* __batadv_forw_bcast_packet clones, make sure original
+	 * skb stays writeable
+	 */
+	return (skb_cow(skb, 0) < 0) ? NETDEV_TX_BUSY : NETDEV_TX_OK;
 }
=20
 /**
--=20
2.31.0
