Return-Path: <antonio@meshcoding.com>
Message-ID: <52D84B0A.10208@meshcoding.com>
Date: Thu, 16 Jan 2014 22:11:38 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <6312194.LhI8hzXjyH@bentobox>
In-Reply-To: <6312194.LhI8hzXjyH@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lqQg9PVcfqkHNQQ4Xrdqsw5frxB4fehu0"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/3] batctl: Use libnl(-tiny) for netlink
 communication
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
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lqQg9PVcfqkHNQQ4Xrdqsw5frxB4fehu0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sven,

On 06/01/14 20:35, Sven Eckelmann wrote:
> Hi,
>=20
> the current release 2014.0.0 made some problems for me because Debian t=
he new=20
> function "rtnl_open" conflicted with libnl-3.0. libnl-3.0 was used in t=
he=20
> Debian package to follow the Debian policy chapter 4 about duplicated c=
ode.
>=20
> Using libnl should not be a problem for any linux system because everyo=
ne uses=20
> it when wireless configuration is done. For example libnl-tiny is alrea=
dy used=20
> by the normal OpenWrt system in base system packages:

I think that it may still be the case that we want to compile batctl on
an host without libnl.

In the end batman-adv can run on Ethernet and we may have an embedded
system with no wifi which has no libnl at all.

I was wondering....what if we check if libnl is installed or not and in
case it is missing we disable the address translation and vlan operations=
?
In this way we can add the dependency to libnl and avoid code
duplication but at the same time we keep libnl-free users happy.

I think batctl can be useful for many things, also if libnl is not
installed.

What do you think?

Cheers,

--=20
Antonio Quartulli


--lqQg9PVcfqkHNQQ4Xrdqsw5frxB4fehu0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS2EsNAAoJEEKTMo6mOh1VmbkP/1bRvbf3blISUgBhdrw+JsgB
M7Sdj6omJco9aAefT4Sc6PZdZNdKmyeJ81VqDKbzdlEYO30dMug7KfpqLQYp/TMT
MDV5+vMcyD27NeJdRiPdtxVVVUHt7ncnebe6Qu1TqDznYHgU3ENCdxqntg/cCreN
jFz1LE3LPyaI7s0Kcw8B3MW2ADl7N5WQ04rIR/QzijCjRQd92EPyr4ZdvsE6KdmR
LbeVTdl03V6aFUlbWVlFsg9GMfmnX7w+NLsX++Y9FIJqu/h1odR4z4s3zXUuS21o
rNh1QHzLZ7xWN9PwPWjJX7DSMwG8weGepb49R+E9lfpDmnQG6KjVgRaMsqyjTUfT
qwPiO79632Je/cuHsTpGPQN6d0nOnbBbr10gsy8Bx3Zf7IcRXkoNtotHBIgfC/5V
eSbif1YmucQvMbnIgNgo9L0TBhE2riYT1iwxiXfrDF/6sEcPDMGy7WyzBgLSwS+8
zHKlcUwBaCDDFXoV+vUQzjQjk5Ts59wP4FCpRct51erkeFDx3xRN+7MYr+YlSPpV
iyyzrhhg9bZPGrq6B96WIyr06uciwTg7cLqeSeCOqph2DZSOF6FHJwfFH8zkVQRA
l9IRHSDjuG8JTeve8bkEOf0NcualSYyrlLJWejNhTFkQACxTHCM/4Ab1bAMLZDjN
XBlqqCIGb4bxGcByUTvV
=5H6e
-----END PGP SIGNATURE-----

--lqQg9PVcfqkHNQQ4Xrdqsw5frxB4fehu0--
