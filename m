Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH maint v2 4/4] batman-adv: mcast: fix duplicate mcast packets from BLA backbone to mesh
Date: Thu, 10 Sep 2020 11:32:08 +0200
Message-ID: <1604713.itQ50Tx4xl@prime>
In-Reply-To: <20200909152756.GD2391@otheros>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue> <3191833.Be6Uz4tNrB@prime> <20200909152756.GD2391@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2266084.Gcmbeqm8zX"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart2266084.Gcmbeqm8zX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, September 9, 2020 5:27:56 PM CEST Linus L=FCssing wrote:
> On Wed, Sep 09, 2020 at 02:15:51PM +0200, Simon Wunderlich wrote:
> > On Friday, September 4, 2020 8:28:03 PM CEST Linus L=FCssing wrote:
> > > @@ -1626,7 +1626,8 @@ bool batadv_bla_check_bcast_duplist(struct
> > > batadv_priv *bat_priv, if (entry->crc !=3D crc)
> > >=20
> > >                         continue;
> > >=20
> > > -               if (batadv_compare_eth(entry->orig, bcast_packet->ori=
g))
> > > +               if (!is_zero_ether_addr(entry->orig) &&
> > > +                   batadv_compare_eth(entry->orig, orig))
> > >=20
> > >                         continue;
> > >                =20
> > >                 /* this entry seems to match: same crc, not too old,
> >=20
> > Shouldn't this check also be skipped if the orig parameter is a zero mac
> > address? i.e.:
> >=20
> > if (!is_zero_ether_addr(orig)) {
> >=20
> > 	if (!is_zero_ether_addr(entry->orig) && batadv_compare_eth(entry->orig,
> >=20
> > orig))
> >=20
> > 		continue;
> >=20
> > }
>=20
> Would be redundant. If entry->orig is non-zero and
> the compare_eth() says they are equal, then orig must also be
> non-zero.

OK good point, that's not really obvious (at least to me).

>=20
> I initially wanted to leave the code as unchanged as possible for
> net / maint. Should I do the restructuring to enhance readability, with
> the bool in this patch or in additional patch for net-next?

Personally, I would prefer having a bit more readability or verbose comment=
s=20
in front of those kind of logic if statements. Or avoid those logic=20
connections and have multiple "ifs" in a row where possible to enhance=20
readbility.

This patch is pretty heavy already as is, adding a bool doesn't make a big=
=20
difference IMHO.

Cheers,
       Simon


--nextPart2266084.Gcmbeqm8zX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl9Z8pgACgkQoSvjmEKS
nqG0WQ/+Ognd7uRujDLikRbIQbgfVJZM6z33riXjzdZibmliOVX1hE8rQ2jLZNgE
PlvigY1S2ILd7YOI/Kc3Nfe6Xh52AevE7XU7hLXyQU4cqriMM0HUmsp6LGAT1MfR
oWJ2hemxUGD4KmDyxM6Fp8verutwOeQnrnPhIWmIKDlw5ipx3nB4GBdj8eHBqvMm
LyY7lQetH0kH4PlSwsnyCbrTAEMdLzfdyj2ugf6ePCh9suBw+XC2bdTTEHNu2R+r
yfppKanUZxEcJYryzM+wJ6aWO/XaMoX0kdKd04AlaIXq59l05KkA9mfqmF9pJlB3
5K4TXUz/OnWi0IxklLHeb9CgRPq3BdZf2ObLRBwx+dspqzsXd8ULATMfAl5BQCYJ
qkwN+JwnqiMb3FKi23vVfS6sR8TLvLtmHsx57aMLWPoFBjsL4TUOKGkiiJ3yXaJQ
rp8PgWup6QENpEP/kbWNa4MAS3ecRj1cu5lsjRP/GnU/cSnSM8tIExF+CqiwjMl8
/dwVsqC+fnPYmv5KUnbvTxtvaiwM6wYdBZ6UhbGyI81J4+xkadZ9422jWcYmWXO8
TsLbuXTWnKlVzvrqC4A4/+4QT90yP/wYWHLS84W+Wrgit7+kRkAikCxzO8Sqoax3
HmPb1m18ZhP8LzEuL/3Y9i1ePSuTt7zCXr96ue2MYscbbeRGrzg=
=cfK7
-----END PGP SIGNATURE-----

--nextPart2266084.Gcmbeqm8zX--


