Return-Path: <ordex@autistici.org>
Date: Sun, 3 Mar 2013 22:03:20 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130303210320.GB1400@ritirata.org>
References: <5133B0A6.6010306@wirelesspt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <5133B0A6.6010306@wirelesspt.net>
Subject: Re: [B.A.T.M.A.N.] batctl.8 suggested correction.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Mar 03, 2013 at 03:20:54 -0500, cmsv wrote:
> Having in mind that throughput and bandwidth are not the same and do not =
necessarily match; the use of the word "throughput" in batman-adv (Layer2)=
=20
> is misleading and can cause confusion when in measuring the real throughp=
ut on layer3 with L3 software.
>=20
> As far as i know; at the moment batman-adv (L2) has no way to know what i=
s the real throughput that the announced gateway bandwidth (l3) actually al=
lows therefore the "
> throughput" should be changed to announced bandwidth.=20
>=20

Yeah, batman-adv does not know anything about the real throughput.

> Example:
>=20
>               If the node is a gateway client the parameter will decide w=
hich
>               criterias to consider when the batman-adv module has to cho=
ose
>               between different internet connections announced by the afo=
re-
>               mentioned servers.
>                         default: 20 -> late switch (TQ 20)
>                        examples:  1 -> fast connection
>                                        consider the gateway's advertised
>                                        bandwidth as well as the link qual=
ity
>                                        towards the gateway and stick with=
 the
>                                        selection until the gateway disapp=
ears
>                                   2 -> stable connection
>                                        chooses the gateway with the best =
link
>                                        quality and sticks with it (ignore=
 the
>                                        advertised bandwidth)
>                                   3 -> fast switch connection
>                                        chooses the gateway with the best =
link
>                                        quality but switches to another ga=
teway
>                                        as soon as a better one is found
>                                  XX -> late switch connection
>                                        chooses the gateway with the best =
link
>                                        quality but switches to another ga=
teway
>                                        as soon as a better one is found w=
hich
>                                        is at least XX TQ better than the =
cur-
>                                        rently selected gateway (XX has to=
 be a
>                                        number between 3 and 256).
>=20
>=20

I think this change is correct. Why not sending a patch that we can directly
apply in the batctl repository?

Thanks.
Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRM7qYAAoJEADl0hg6qKeO/iYQAKuMJ/5muwmGO0fIhloiuPA4
e4t7l3sIZ1sLyrutQpYXEs+hoLxkTBByrHdAFbPyu3lWyp5Tzor68UPUYjOAmNCL
4q+X1eGVWqJyqTD3KGIey3guihuGHWFRSTwwwjgyye7Mnb/iW/my0lWAaK8jRmnB
mnu9i4f1YYyzNKjUnU8OhGsA/IRJZg+mPMl6RBPqRfezBr0U02cshpqemNQZc9gV
Ps/oqYieNkuWndiDjT7DXoiPGvAraZXsUW66j0Bt0I0D62tSMaggei7dI4eR55DV
kb1IKanodz4bSGkLx1JvpGq5VJQ6CpVTtEg/5EYT/OapbZgvjQc1WrKfjDtD3AvA
F0SAjNDifr9Hhh6GYgcEgOK0r/r70TWFPDdpqUjsWfBw7N7uv58z2C5nrpEcka7B
hb4F257Dcc6bESAEZVk2JekdC7GEG1OCK/bQy2tqNlBp4V/NT6PBZDiOHF2gAPrk
pmQsF1OHgdFlhBdeb9ucVtcnwJUOOjiva8WGdaFuEV/7DNiSX27xF0AovYh2zwQr
9geNzrU8OifA1jq5xFjDFgEZAPoRZsBbWcujkgPRpN3yuKnzcyvDvMwuo5U4wGlI
mvRKPEvgwbeK+AyTk1DqbdQ2GtukuSXnrJed4xMNsmVn3v+vWanYg2wP+fw3f+qi
NHRjM1Mw/3qk75uUPzt/
=3/VP
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
