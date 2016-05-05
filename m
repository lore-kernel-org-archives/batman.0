Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 05 May 2016 16:05:02 +0100
Message-ID: <1759558.96OGEHYiP1@prime>
In-Reply-To: <1461031839-31182-1-git-send-email-linus.luessing@c0d3.blue>
References: <1461031839-31182-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1785281.0efFupkAuj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv13 0/4] Multicast optimizations for
	bridges
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1785281.0efFupkAuj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tuesday 19 April 2016 04:10:35 Linus L=C3=BCssing wrote:
> This patchset enables the usage of the batman-adv multicast optimizat=
ions
> for scenarios involving bridges on top of e.g. bat0, too.
>=20
> The first one alters the forwarding behaviour for IGMP and MLD report=
s
> which is a prerequisite before enabling multicast optimizations in
> bridged setups. It also increases the MCAST TVLV version number to 2.=

> More on the issue of insufficient report handling with the v1
> MCAST TVLV can be found here:
>=20
> http://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizat=
ions-li
> stener-reports
>=20
> The second patch finally enables the multicast optimizations for
> bridged setups.
>=20
> Along come two more patches adding according debugging facilities
> to make it possible for the user to check why the multicast
> optimizations might not work ideally to give hints about
> what they might change about their topology.
>=20
>=20
> This patchset can be found in the current linus/multicast-bridge
> branch.
>=20
> Cheers, Linus

I've tested this patchset in my virtual environment with 6 nodes (based=
 on=20
OpenWRT), where 3 of them were meshed and another 3 were connected to e=
ach of=20
the mesh nodes through a bridge. I've run the querier on various nodes,=
 used=20
the simple multicast listener [1] to create an IPv6 listener and verifi=
ed that=20
the querier detection and multicast forwarding was working as expected.=
 There=20
was a kernel bug which created problems with the querier detection (det=
ected=20
as enabled/disabled every 2 minutes or so), but Linus fixed that proble=
m [2],=20
and since the fix is targeted for stable I don't think it is an obstacl=
e for=20
us.

I've also checked the code briefly and didn't find any problems.

There is one last comment from Sven on v12 on the compat part which nee=
ds some=20
attention, but other than that I think it is ready to merge.

Feel free to add=20

Tested-by: Simon Wunderlich <sw@simonwunderlich.de>

to the patches.

Thanks,
     Simon

[1] https://github.com/T-X/sm-listener
[2] https://lkml.org/lkml/2016/5/3/780
--nextPart1785281.0efFupkAuj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXK2EeAAoJEKEr45hCkp6h1F4QAJtRyZ0Qmds4kCxcG8PWoyI1
mWneD8ru4K1CJ9N72C9Lv8uhbYb5n/shcd1ly+Pj84JGf/IFLzMl/T3uJKGwZB1/
xVv7QRV25tcB/0LC72uAaI0wGzE2tjsx2tpEduk7XwjW5O6c5eypnNsp6VGvrcoB
0VbYfj0H2BPDyt7IMRpky4lEsCN1br6ZBzwv6Ydz/8v+wEzD/2zOqx2vV+H1KO4d
I1c+wtJFwA/kXGNuRorsDDTaPiFxo335COnrR6nU7OU2BOCCdH4fmPNxFz7o1LI7
++eMIl7Yo9dPazf37UzRX+mbmEGYS1An+aSu0lPz1sxRG4eK8egrJEjCCLEmLRLy
lJJLhDZPZBCnbxI2w57KaF8Vg0xvA66wwaAbvJd3PSVVFjubBwnopaoqN/3jwDNe
RgzUjteAFjrrs5HnKZFRT5v8h06geHS7ycD8h6ybx/DLm7akyOJDW36K5DUqeZh9
puacwG1Ksgs0CzAXcFpjIiqFj9+S54UTo4DTitWBScnOm1oGyJ+UsRXoOGZdwx1v
bojpc91pBfK9L1MY2d7m+twmLZQSM65uQxAA3njPWH3zXfKWAd1oZGP+rbBHEud8
um23N9DtR+jaQizcou9HlpFxqjqPcmdHOxStYpIYohuZ638rSIfmtlsM9x2bvKc6
nfO86po1Wua10S8DN9gB
=UlY/
-----END PGP SIGNATURE-----

--nextPart1785281.0efFupkAuj--

