Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH maint v2 1/4] batman-adv: mcast/TT: fix wrongly dropped or rerouted packets
Date: Wed, 09 Sep 2020 13:50:37 +0200
Message-ID: <1657805.LVLZ2NAnD4@prime>
In-Reply-To: <20200904182803.8428-2-linus.luessing@c0d3.blue>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue> <20200904182803.8428-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2572932.bRomXxpJkB"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart2572932.bRomXxpJkB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, September 4, 2020 8:28:00 PM CEST Linus L=FCssing wrote:
> The unicast packet rerouting code makes several assumptions. For
> instance it assumes that there is always exactly one destination in the
> TT. This breaks for multicast frames in a unicast packets in several ways:
>=20
> For one thing if there is actually no TT entry and the destination node
> was selected due to the multicast tvlv flags it announced. Then an
> intermediate node will wrongly drop the packet.
>=20
> For another thing if there is a TT entry but the TTVN of this entry is
> newer than the originally addressed destination node: Then the
> intermediate node will wrongly redirect the packet, leading to
> duplicated multicast packets at a multicast listener and missing
> packets at other multicast listeners or multicast routers.
>=20
> Fixing this by not applying the unicast packet rerouting to batman-adv
> unicast packets with a multicast payload. We are not able to detect a
> roaming multicast listener at the moment and will just continue to send
> the multicast frame to both the new and old destination for a while in
> case of such a roaming multicast listener.
>=20
> Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>


--nextPart2572932.bRomXxpJkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl9YwY0ACgkQoSvjmEKS
nqGM2w/+MeHlxptvgs4bQp3Hlez3xyevGFh/CV6ntSIhPP6Y7m89UgG+EdzmNUmm
36YtacWGd/3sKktG2LsHNUrvXQI/NS+u7o9ttFvND6on2npfru/WRl3H7Rinaat0
g4l9kaLcutxzRdqivVqxVfmwJxBWoRZtNI3B4PonVen59XiUiVEoWJPkvM8rGYrJ
nOF1WziOUkFhsGyeCLL7btqsQUJQkwN7oj2pQa/kdv91CTVvVEsBxZxHdkl32SKR
97Du7i+Bkw5c2mC00CZVql2g5KzusfO4haFDj3ds9h5FXi/c62t6L/jztuLGR+5g
cUDPKcumfyTScM26F5OHFeusTdz7bAeeO91JYf6PpXjJoW9rHwHCI7orUN5w+00O
B7VBHScjWXiKynFGwR/oq+XYlKrX+CuStyZD5TiMon/knTRQuJUvRqfwcDlMfKr8
SZNoVXfszHW0jG+H9kU8pO77z0HoV98ID+rZ1pxBXxwd2IgT+qWWIDP8mhpLXJdi
BMVKAPu8kVRLtJPtkx7u8dEl7k7H6xf6zdabpOB2M79i8YEOnIicaj8leUoP3jgv
enKcP3x5zMWkJoIuQmMH0KeuGWKIjpRNvAKBVP2GdVi74uYoj008KlcRa8veX2jR
s+ihuSPvgZdvIZ00Vy7wE7iUMomMBBFvA/hFUKAFABIrwUO1QU8=
=UdUR
-----END PGP SIGNATURE-----

--nextPart2572932.bRomXxpJkB--


