Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH maint v5 1/3] batman-adv: mcast: fix duplicate mcast packets in BLA backbone from LAN
Date: Tue, 15 Sep 2020 09:11:49 +0200
Message-ID: <1726730.ZNdbpBcDRY@prime>
In-Reply-To: <20200914195347.10505-2-linus.luessing@c0d3.blue>
References: <20200914195347.10505-1-linus.luessing@c0d3.blue> <20200914195347.10505-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2542353.8oxAI3WAsd"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart2542353.8oxAI3WAsd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, September 14, 2020 9:53:45 PM CEST Linus L=FCssing wrote:
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

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
--nextPart2542353.8oxAI3WAsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl9gaTUACgkQoSvjmEKS
nqFC0BAArYCUDmW2StTjFSFDh6qDbKHDeLNOhY71xO0CQCcBUJbh22uMg7ysctqp
T4/w7THcjgD5iOAIzCyvqhwt2GvqwllM4uFe+lVnDjrO33YW70MZfMEZWIWfKcn6
bezuZZmqqr762z4NuFa9mbgvNWSLkjY6iU2PY67SDy7SPHtGoqLXe/W1B3DsQW/W
3WIPtOx1cLO8xlXF6mULZmkr6lssowF+otCSx8k17Pwl1GDzl65VRDePNGpqK+Qa
Cy044p7WMUOSmiJY9JoQ9R2Ur2aWBTvLcyBJwrByS0N20YMvYZlZ1ol7cRdP1NsS
4T27wrkmVHAqih0kXdlyy/ui4YeOM1EPnPnsPHpXXi9uxEBCMS0z2Fmh7IzqAx6r
AvFbNHGSI6b2HSSP6oF4LYSoVfBmsZePT48GU47UwY6DWriG396HiBZEuE/Sf9fC
QuMUPItTWbPwVxtKajYfYe8/LPNfLA2M4wkXyRjPwptefI7QZb+ALb1JTZQbwQBz
xMd4T2MYgW+ZVCfv23sZsqJ6BqzfJTmRUjQkGW/mPXSvBBZadHjsAfn5SW88mly0
7jLOycBYsfkrsBilUR7tYffhbEHpBlR54y1t1idgGi6W94ZQIp8vKhkjZGZPBQQO
g2ZUszZHsK9nDuJOZefj8GWDlotD3LA/cSIvlztoF0NjdTvrmXU=
=z+YY
-----END PGP SIGNATURE-----

--nextPart2542353.8oxAI3WAsd--


