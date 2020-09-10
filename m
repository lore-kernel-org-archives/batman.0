Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH maint v2 3/4] batman-adv: mcast: fix duplicate mcast packets in BLA backbone from mesh
Date: Thu, 10 Sep 2020 11:34:24 +0200
Message-ID: <1876602.pz3MLid8rM@prime>
In-Reply-To: <20200909145357.GB2391@otheros>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue> <2973088.WcO1NEu1zB@prime> <20200909145357.GB2391@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15385405.xT5Lyqm7BY"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart15385405.xT5Lyqm7BY
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, September 9, 2020 4:53:57 PM CEST Linus L=FCssing wrote:
> The 3rd one should be different. Note that "is_bcast" is not the same as
> is_broadcast_ether_addr(ethhdr->h_dest). The former refers to the
> batman-adv packet header, while the latter refers to the
> destination MAC of the inner ethernet header.

Oh right, one is is_multicast() and the other one is_broadcast().

This part definitely needs either some comment or, even better, split into=
=20
multiple conditions checks or a helper function which makes it clear.

I've stared on this for a couple of minutes, but we should be able to revie=
w=20
that kind of code faster. Maybe it's just me, but I think this can be=20
improved. :P

Cheers,
       Simon

--nextPart15385405.xT5Lyqm7BY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl9Z8yAACgkQoSvjmEKS
nqGqXg//T0qCOBhh1njNw6xxMC0RSnTE2DhY68Yp1RHsQ+Di3m5JVqwBcL/Mnlp/
uj35/tA7ZAtSq4YscEYcyA29A/qnhvuEcVmqLOee8w75xAHA86ynVnFk28NYSMlB
L7c/Y/HXMuI1Kbh+Q5gDe5b+gOX1d4Pij4/tA/tKLStIK2eN3XoXAuhEQ9kavwWO
lIUJEC2/Hc2r7GyXSze3zc470kWKRvogCcuTxElUtlblG5n64AwigSdae8KI4GXi
XN0A7UAIwC2jO0rbQoFX7ONZbeRMdMk6Qhl4onodaUuVl8v00VmaACqi97OHFdtx
evGFqOBsC6tJum4h1GNwaYDwcTtQrKbPl67RZozYKMpFDDut8T929Hb6J6jDJjC9
ftmCkK3H2vwlfHhSCHSXCDSv5Wl8uR26VNC4lcRzhPbEoxuA4pIdoenjaK6ntApc
F6Bqyy0qzxi7HSsIhF/1Bh5DSWK/VXqf4Z9sNoOnwV1W+5Q4eQuh8UZMFMrAtgTc
xlRMnp0OzUmu0nm51LV3kNvjYX9WVhJsrnkYSxBTpaUxFhTbZBjykAni1hNL9+JW
E3hWKSl4hQ2OdUC8BUX52fB4rOiK1hNbzFZcIzYqvf/Xo7XsVK5R9zzNprXken73
BOy8CQu21CNEQykqPSENv60qZWkoa4wFkb2r6Ft0OePHQF4NoKs=
=ucY9
-----END PGP SIGNATURE-----

--nextPart15385405.xT5Lyqm7BY--


