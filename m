Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 27 Aug 2009 22:58:57 +0200
References: <4A96E28C.4050409@gmail.com>
In-Reply-To: <4A96E28C.4050409@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4484940.yeX5gKZtqP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200908272259.00216.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Is svn broken?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: sebastian.criado@gmail.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart4484940.yeX5gKZtqP
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
> svn co http://downloads.open-mesh.net/svn/batman/trunk/batman-experimenta=
l/
> svn: Could not open the requested SVN filesystem
Seems to be broken at the moment. If you need the data at the moment you ca=
n=20
get a svndump of the everything until r1417 (which was the last commit I kn=
ow=20
of) at http://www-user.tu-chemnitz.de/~ecsv/mirror/batman-svn.dump.xz
This file will disappear without any warning - so better fetch now :)

It can be used quite easily:
 $ wget http://www-user.tu-chemnitz.de/~ecsv/mirror/batman-svn.dump.xz
 $ svnadmin create batman-mirror
 $ xzcat batman-svn.dump.xz | svnadmin load batman-mirror
 $ svn co "file://${PWD}/batman-mirror/trunk/batman-experimental/"

Tools used:
 * wget - http://www.gnu.org/software/wget/
 * subversion - http://subversion.tigris.org/
 * xz-utils - http://tukaani.org/xz/

Regards,
	Sven

--nextPart4484940.yeX5gKZtqP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKlvORAAoJEF2HCgfBJntGbEoP/1dzUeL1ofh1hwD5XYXU3J2F
aDGbLJR6hb9J2ra0fwG+3QvWFGgBzB+35Ay98D9MQPK1pzmB7z/7s1GqwZTsvyax
EDo0EHyH8/JbufO1D7eH0MBqwWjU8Ko3Tm6IB7reWqmwlyHcG7MepBaENmVZy8KO
AjSOhNlZGS1iGx3bWZpWTAMjFoO3jNTKVsdxMaAaui7ZX6ZAC734yYsOay2eytiZ
0WAHEMjKcxxHtWE+rE883sgAjvmpCHzwNGAVHSMh3sYr/7f90D3f+iOVWOXb/087
tgl8OCPsLclTiKyH92qQXBCs7sNnHlxgO+eqB+A1DJYNOyvnyF0D04WKUZ9MZq38
Liv0HQxD80Uyqa2WD+PPe0p/PkEsLo7S/g5oBT6hb+LtOS6YnJmPZ9bkqWjzCpXL
JyhXzNE2XiIRaheP9URJ2szScG5f3JBrPN/3TSpHCAgzsLXpU5AD9CcSse9+UUfm
8/hULIEUtxFzjA2M+TDD6WUepxYwresN3GAs7oLXUz9ssFeaggGhgfb/Mv0MrExf
BmXxq7btyncCUENWXVcsABK9akSbCmvpYHw6izvgmv/riWc7q95AkeXhKTomM3yw
zqzOicjs6hsEqtV0P9nqjqvv1phSR+uv9jtWb/vx/eljmhN/FZX0cWopehLoY+3z
95fMbPhzCd9GCOjhFglk
=oAzb
-----END PGP SIGNATURE-----

--nextPart4484940.yeX5gKZtqP--
