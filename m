Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 29 Oct 2009 14:15:57 +0100
References: <200910061328.04894.holger@layer-acht.org>
	<200910201204.37562.sven.eckelmann@gmx.de>
	<200910201235.02231.holger@layer-acht.org>
In-Reply-To: <200910201235.02231.holger@layer-acht.org>
MIME-Version: 1.0
Message-Id: <200910291415.58094.sven.eckelmann@gmx.de>
Content-Type: multipart/signed; boundary="nextPart10064425.5CLKmZBLVI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Debian extra modules
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart10064425.5CLKmZBLVI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Holger Levsen wrote:
> On Dienstag, 20. Oktober 2009, Sven Eckelmann wrote:
> > I will search for some more information what must be done to support dk=
ms
>=20
> http://lists.debian.org/debian-kernel/2009/10/msg00683.html

Thanks. The packages[1,2] are now in Debian unstable. You must have the
headers and kbuild for your running kernel installed (for example over
linux-header-2.6 which is recommended by dkms). The rest is handled by dkms.
Binary precompiled packages will disappear somewhere in the future when
linux-modules-extra-2.6[3] gets removed..

I don't think that the dkms configurations[4,5] are useful for upstream at =
the
moment.

Best regards,
	Sven

[1] http://packages.debian.org/sid/batman-adv-dkms
[2] http://packages.debian.org/sid/batmand-gateway-dkms
[3] http://packages.qa.debian.org/l/linux-modules-extra-2.6.html
[4] http://git.debian.org/?p=3Dcollab-maint/batman-adv-kernelland.git;a=3Db=
lob;f=3Ddebian/dkms.conf.in;hb=3Dmaster
[5] http://git.debian.org/?p=3Dcollab-maint/batmand.git;a=3Dblob;f=3Ddebian=
/dkms.conf.in;hb=3Dmaster

--nextPart10064425.5CLKmZBLVI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK6ZWNAAoJEF2HCgfBJntGTQwP/RUTT/5LdC8eRWNF5Gro995U
hOD/vxmr0x2yj3B+nmdR/vbAhN+3NEYQP9IPi6VapoLTdUbZr8V38K/cMM5tM83d
sSRo3scXgpLdOUbpIgt2Ax67R1aHg0QMR2ECe/l47YWggDx2iDQxd2DHfEUJ6XQl
MezMsOIaXt756P+DHrCdttBOIo6C998tf2M5j/0oSZRHCY7DQKCMnIpSQW68KImg
X0xbkn2vjvUcvEiFE9Tn6gVCA5RZ62BT+X1gn90Uh+CNGZLPi+gq41Y+231Jlf65
cvEB4WD1zeRoxqvcBeH60klOqbCZSjVBDb44hs/hvgV00XNT/cXNGbAhE5EENvqq
QG36N7LicUQDybPlu3OYtwxfrkZQ5RDOlydDobSL0AsjP2+5qZxjiTo6wyj5FkZj
QkEohgQe11wn54fJxYasVHu9QWGuQ0xk6EX016JjnAbmT00F+u4P6D2CV3tfVrIf
TE3m/zOgZzqqKaTb1C+AyPxl8lIKRZp4J1BvsguFdye0LWLWNx6hfoqafkx9jOfG
U8m8aj/dHCz1k/n9l1d+fu2k7SpM6phAcwpSxjceULzWhZ+reIBaxfbPDwTdCwRj
XPIFC5PEXYw2bhELotCLA3Vno4ZoHU26QuXVlKEwnR21tENd5/v9oFRa87ndsfnV
5TtFmJ7VvmnCcD7A0wXu
=snaz
-----END PGP SIGNATURE-----

--nextPart10064425.5CLKmZBLVI--
