Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jul 2011 11:04:22 +0200
Message-ID: <1892575.V8ZBOEZBaQ@sven-laptop.home.narfation.org>
In-Reply-To: <CAJA-1Lg=T_xkp4vdopQ2fscQgSnB9pLiThTBcmf=y_HocYKm=w@mail.gmail.com>
References: <CAJA-1Lg=T_xkp4vdopQ2fscQgSnB9pLiThTBcmf=y_HocYKm=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart87331863.d6fiGngsNn";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] make batctl 2011.1.0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Max Ip <ipmax2011@googlemail.com>


--nextPart87331863.d6fiGngsNn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"

On Wednesday 06 July 2011 10:55:40 Max Ip wrote:
> Hi all,
>=20
> I downloaded the batctl package 2011.1.0 from the batman website. I
> installed it using command make all.

You didn't install it, but build it.

> It generates the following two warnings:
>=20
> functions.c: In function =91read_file=92:
> functions.c:153:9: warning: ignoring return value of =91system=92,
> declared with attribute warn_unused_result
>=20
> and
>=20
> bisect.c: In function =91bisect=92:
> bisect.c:197:9: warning: =91j=92 may be used uninitialized in this fu=
nction

Both warnings don't show problems/

> I just ignored the warnings. But, I wasn't able to run the batctl
> command neither could I see the manual page for batctl.

Ehrm....
$ ./batctl
$ man -l ./man/batctl.8

> I couldn't figure out what exactly could be the issue though I have
> been going through the codes and the makefile.
>=20
> Do anyone of you have an idea if my way of installation is correct?

No, my crystal ball broke yesterday and the gypsy express isn't as fast=
 as the=20
name would suggest.

Kind regards,
=09Sven
--nextPart87331863.d6fiGngsNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOFCUWAAoJEF2HCgfBJntGW70QAKyPa+eYiXFInb65yQWq3ghC
QqJUkSX5GVxYcGWmRjmNTga0v1c0GLRgGM7/K7upoKYAvN7x9wvdtWi5BjVBLYQm
W3a22EuxKIXF4KCtSXUeDz1eO53hJfwhA6tTtDyBU1kPdsq/Jd9VIg/zkbT5fMIX
8aHF/220y2bGmuor7Xid5kn5hY6CfkVxS61addzDgvop1uDhka5FrJ7cVxGWRR7Y
q1vRd36tMdb9SMs3nGvjodCbrwtNWi7sOU6lDZdvDz+o2hMsWQW5Znf/5YBDjBB2
6bqNkXMYWnJl7kHmENt8+0vNSdao/XauZ4lFKIwFs/NrDSYQi1OwFN5jGeF8oXv8
VN8myR7UoOj/CCA2BWoUO5Gn+0riMTvPQJime7m7CT0rRB/VO2MrEyPaR7sYPwyq
7ALmESzK0dijAWIK2/3Tt6Ncb4Zxzkydxf8iu1Kvb4Ca3vtx5qHqV8mDal6wruXk
D6ZPpUu++9YP0lHM4sl3Zwal0eOPzslgWHra9d7KBf/d2SG9bjjK5sQ91B8kt9wf
avgpzeIXo4mEOo82m+RtbN5a2vwCymcblUzYEAVyuu+YGhTa7upP+q98HDHreg2j
UCNO4Vx77D99xSGNjhdjdryUaw0cupoO8Xp+YZWsmNPNFAA6CJiOXriBi2rJIGyZ
GJTGfijm57S2gciklSpL
=C81A
-----END PGP SIGNATURE-----

--nextPart87331863.d6fiGngsNn--

