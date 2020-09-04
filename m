Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH maint v2 2/4] batman-adv: mcast: fix duplicate mcast packets in BLA backbone from LAN
Date: Fri,  4 Sep 2020 20:28:01 +0200
Message-Id: <20200904182803.8428-3-linus.luessing@c0d3.blue>
In-Reply-To: <20200904182803.8428-1-linus.luessing@c0d3.blue>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue>
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

Scenario:
* Multicast frame send from a BLA backbone (multiple nodes with
  their bat0 bridged together, with BLA enabled)

Issue:
* BLA backbone nodes receive the frame multiple times on bat0

For multicast frames received via batman-adv broadcast packets the
originator of the broadcast packet is checked before decapsulating and
forwarding the frame to bat0 (batadv_bla_is_backbone_gw()->
batadv_recv_bcast_packet()). If it came from a node which shares the
same BLA backbone with us then it is not forwarded to bat0 to avoid a
loop.

When sending a multicast frame in a non-4-address batman-adv unicast
packet we are currently missing this check - and cannot do so because
the batman-adv unicast packet has no originator address field.

However, we can simply fix this on the sender side by only sending the
multicast frame via unicasts to interested nodes which do not share the
same BLA backbone with us. This also nicely avoids some unnecessary
transmissions on mesh side.

Note that no infinite loop was observed, probably because of dropping
via batadv_interface_tx()->batadv_bla_tx(). However the duplicates still
utterly confuse switches/bridges, ICMPv6 duplicate address detection and
neighbor discovery and therefore leads to long delays before being able
to establish TCP connections, for instance. And it also leads to the Linu=
x
bridge printing messages like:
"br-lan: received packet on eth1 with own address as source address ..."

Fixes: 405cc1e5a81e ("batman-adv: Modified forwarding behaviour for multi=
cast packets")
Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/send.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d267b948..67f493c0 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -29,6 +29,7 @@
 #include <linux/stddef.h>
 #include <linux/workqueue.h>
=20
+#include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
 #include "fragmentation.h"
 #include "gateway_client.h"
@@ -343,6 +344,18 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_=
priv,
 	if (!orig_node)
 		goto out;
=20
+	/* Avoid sending multicast-in-unicast packets to other BLA
+	 * gateways - they already got the frame from the LAN side
+	 * we share with them.
+	 * TODO: Refactor multicast code to anticipate this, to
+	 * avoid this check here.
+	 */
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest) &&
+	    batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid)) {
+		dev_kfree_skb(skb);
+		return NET_XMIT_SUCCESS;
+	}
+
 	switch (packet_type) {
 	case BATADV_UNICAST:
 		if (!batadv_send_skb_prepare_unicast(skb, orig_node))
--=20
2.28.0
