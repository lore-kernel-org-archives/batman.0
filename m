From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 21 Jan 2009 16:21:17 +0100
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
	<200901211436.08998.sven.eckelmann@gmx.de>
	<20090121143814.GA13404@pandem0nium>
In-Reply-To: <20090121143814.GA13404@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12457788.YJrIHSQ4hY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200901211621.21753.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Install Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

--nextPart12457788.YJrIHSQ4hY
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi
On Wednesday 21 January 2009 15:38:14 Simon Wunderlich wrote:
> another option is to compile/linu batmand with the -static flag on your
> x86 (i386) desktop
Thx, forgot that one. You should be able to link it statically by using the=
=20
current version from trunk and running
 LDFLAGS=3D"-s -static" /usr/bin/make

You can check it with `file batmand`. It should print something like
 batmand: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statica=
lly=20
linked, for GNU/Linux 2.6.8, stripped
=20
best regards,
	Sven

--nextPart12457788.YJrIHSQ4hY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl3PW4ACgkQqQGwKVlMoDu60gCfd5wRxKuZcCxLa/bre2ShG4Ij
3+oAoO7jkEa808rdpaXdSi0IXpyHBZue
=nfI9
-----END PGP SIGNATURE-----

--nextPart12457788.YJrIHSQ4hY--
