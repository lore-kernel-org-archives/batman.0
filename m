Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH maint v2 2/4] batman-adv: mcast: fix duplicate mcast packets in BLA backbone from LAN
Date: Wed, 09 Sep 2020 13:38:49 +0200
Message-ID: <12905687.KyMRHU7LPt@prime>
In-Reply-To: <20200904182803.8428-3-linus.luessing@c0d3.blue>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue> <20200904182803.8428-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1678547.dNe71AlPue"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart1678547.dNe71AlPue
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, September 4, 2020 8:28:01 PM CEST Linus L=FCssing wrote:
> Scenario:
> * Multicast frame send from a BLA backbone (multiple nodes with
>   their bat0 bridged together, with BLA enabled)
>=20
> Issue:
> * BLA backbone nodes receive the frame multiple times on bat0
>=20
> For multicast frames received via batman-adv broadcast packets the
> originator of the broadcast packet is checked before decapsulating and
> forwarding the frame to bat0 (batadv_bla_is_backbone_gw()->
> batadv_recv_bcast_packet()). If it came from a node which shares the
> same BLA backbone with us then it is not forwarded to bat0 to avoid a
> loop.
>=20
> When sending a multicast frame in a non-4-address batman-adv unicast
> packet we are currently missing this check - and cannot do so because
> the batman-adv unicast packet has no originator address field.
>=20
> However, we can simply fix this on the sender side by only sending the
> multicast frame via unicasts to interested nodes which do not share the
> same BLA backbone with us. This also nicely avoids some unnecessary
> transmissions on mesh side.
>=20
> Note that no infinite loop was observed, probably because of dropping
> via batadv_interface_tx()->batadv_bla_tx(). However the duplicates still
> utterly confuse switches/bridges, ICMPv6 duplicate address detection and
> neighbor discovery and therefore leads to long delays before being able
> to establish TCP connections, for instance. And it also leads to the Linux
> bridge printing messages like:
> "br-lan: received packet on eth1 with own address as source address ..."
>=20
> Fixes: 405cc1e5a81e ("batman-adv: Modified forwarding behaviour for
> multicast packets") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.b=
lue>
> ---
>  net/batman-adv/send.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
> index d267b948..67f493c0 100644
> --- a/net/batman-adv/send.c
> +++ b/net/batman-adv/send.c
> @@ -29,6 +29,7 @@
>  #include <linux/stddef.h>
>  #include <linux/workqueue.h>
>=20
> +#include "bridge_loop_avoidance.h"
>  #include "distributed-arp-table.h"
>  #include "fragmentation.h"
>  #include "gateway_client.h"
> @@ -343,6 +344,18 @@ int batadv_send_skb_unicast(struct batadv_priv
> *bat_priv, if (!orig_node)
>  		goto out;
>=20
> +	/* Avoid sending multicast-in-unicast packets to other BLA
> +	 * gateways - they already got the frame from the LAN side
> +	 * we share with them.
> +	 * TODO: Refactor multicast code to anticipate this, to
> +	 * avoid this check here.
> +	 */
> +	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest) &&
> +	    batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid)) {
> +		dev_kfree_skb(skb);
> +		return NET_XMIT_SUCCESS;
> +	}
> +

Would it make sense to perform this check in the BATADV_UNICAST case, witho=
ut=20
checking the ethernet destination for multicast?

A backbone gateway should never send a unicast frame to another backbone=20
gateway, regardless of multicast or not - those things should go over the=20
backbone either way.

=46or 4addr unicasts, I see two cases: TT Unicasts could be dropped in the =
same=20
way, as TT is ignored between backbone gateways. For DAT, there is currentl=
y=20
no specific BLA handling for the unicast handling as far as I see, there ar=
e=20
only some checks to make sure that ARP replies coming out of the correct=20
backbone gateway. Since DAT is "best effort" and requests may get dropped, =
it's=20
probably safe to drop this too.

That would allow us to use the same check as you have here, but dropping th=
e=20
check multicast ethernet address check.

Cheers,
       Simon

>  	switch (packet_type) {
>  	case BATADV_UNICAST:
>  		if (!batadv_send_skb_prepare_unicast(skb, orig_node))


--nextPart1678547.dNe71AlPue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl9YvskACgkQoSvjmEKS
nqGpxBAAlaSpxkKum4DouczDYi46CxLlKWYqkuMwn8rI0h7wfebdmUOkXwDe0OIz
rvt11FMdiLO7CTozBYTK8BHaMYBH7na+dK0CU6sFgWs7x7yuWU5oBNEKDjd80O8C
QE/VjA+XaKblE5eLAAODjDnaSPyDobw/YJhoGrL5VV4AOYMaUmrQJLUeEKjQkKIx
NO059OR+dmavQ9NpnSXnaiFbppWxeWaBH8zoP7yL+EB09E+dluIx+hS/kcJRcyXW
I2GpFF/7E0Sn6Wybdp0wSZeEdw4duL+1J6OLv60/haEBEDY/9FGwSMd9AQW+J2NO
23yyJlp5beDljS/NxfHOdE/EROPLbBj58Hmk8WTIetxtyFrruq+MfFKXgkk5X/da
yHLUOPstX9kM5NpbgOjtWC0RYxB9DG9WrzVQX8TaryclKtL+trbKKUl5F4IV5iLs
LIB0cf5Fy4WwJUhabjVxJBIE21Cs7ON7ENZyJujbUjNQrHrztAYY0fdYvYgOcr48
v3mMk6PzL27BdP5fn7/nbUkKtYLi3etSgSU/V8cUFU/1WvE7BnCYUrGeQqBJRkaK
gl2oGLx0Udi7O2ZTO/+WAnsOat6qcwqGA13NnQ/XbRhQ5+7jAehSjup87yU1Xmt0
0X9+SrSEy2J+snZCtCc2nuBh5OcDOIXePIGH+jrsflyKLcDBHyk=
=RJqB
-----END PGP SIGNATURE-----

--nextPart1678547.dNe71AlPue--


