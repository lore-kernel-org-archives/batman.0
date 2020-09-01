Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH maint 3/4] batman-adv: mcast: fix duplicate mcast packets in BLA backbone from mesh
Date: Tue,  1 Sep 2020 03:26:05 +0200
Message-Id: <20200901012606.7620-3-linus.luessing@c0d3.blue>
In-Reply-To: <20200901012606.7620-1-linus.luessing@c0d3.blue>
References: <20200901012606.7620-1-linus.luessing@c0d3.blue>
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
* Multicast frame send from mesh to a BLA backbone (multiple nodes
  with their bat0 bridged together, with BLA enabled)

Issue:
* BLA backbone nodes receive the frame multiple times on bat0,
  once from mesh->bat0 and once from each backbone_gw from LAN

For unicast, a node will send only to the best backbone gateway
according to the TQ. However for multicast we currently cannot determine
if multiple destination nodes share the same backbone if they don't share
the same backbone with us. So we need to keep sending the unicasts to
all backbone gateways and let the backbone gateways decide which one
will forward the frame. We can use the CLAIM mechanism to make this
decision.

One catch: The batman-adv gateway feature for DHCP packets potentially
sends multicast packets in the same batman-adv unicast header as the
multicast optimizations code. And we are not allowed to drop those even
if we did not claim the source address of the sender, as for such
packets there is only this one multicast-in-unicast packet.

How can we distinguish the two cases?

For DHCPv4: Here the broadcast MAC address is used and the multicast
optimizations will never send a broadcast frame via batman-adv unicast
packets (see the !is_broadcast_ether_addr() check in after the goto-send
in batadv_interface_tx().

For DHCPv6: This is even trickier... DHCPv6 potentially uses
non-broadcast multicast addresses. However according to RFC8415, section
7.1 it seems that currently multicast is only used from a DHCPv6 client
to a DHCPv6 server, but not the other way round.

Working through the gateway feature part in batadv_interface_tx() it can
be inferred that a DHCPv6 packet to a DHCP client would have been the onl=
y
option for a DHCPv6 multicast packet to be sent via unicast through the
gateway feature. Ergo, the newly introduced claim check won't wrongly
drop a DHCPv6 packet received via the gateway feature either.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/bridge_loop_avoidance.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/brid=
ge_loop_avoidance.c
index d8c5d317..9603a6d0 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1848,7 +1848,8 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, st=
ruct sk_buff *skb,
=20
 	if (unlikely(atomic_read(&bat_priv->bla.num_requests)))
 		/* don't allow broadcasts while requests are in flight */
-		if (is_multicast_ether_addr(ethhdr->h_dest) && is_bcast)
+		if (is_multicast_ether_addr(ethhdr->h_dest) &&
+		    (!is_broadcast_ether_addr(ethhdr->h_dest) || is_bcast))
 			goto handled;
=20
 	ether_addr_copy(search_claim.addr, ethhdr->h_source);
@@ -1885,7 +1886,8 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, st=
ruct sk_buff *skb,
 	}
=20
 	/* if it is a broadcast ... */
-	if (is_multicast_ether_addr(ethhdr->h_dest) && is_bcast) {
+	if (is_multicast_ether_addr(ethhdr->h_dest) &&
+	    (!is_broadcast_ether_addr(ethhdr->h_dest) || is_bcast)) {
 		/* ... drop it. the responsible gateway is in charge.
 		 *
 		 * We need to check is_bcast because with the gateway
--=20
2.28.0
