Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 29 Apr 2010 23:31:50 +0200
References: <201004291621.08579.sven.eckelmann@gmx.de>
	<1272550944-8522-2-git-send-email-sven.eckelmann@gmx.de>
	<20100429163429.GF3734@lunn.ch>
In-Reply-To: <20100429163429.GF3734@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3435021.zB6DRu05sN";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201004292331.51887.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 2/2] batman-adv: Reduce max
	characters on a line to 80
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

--nextPart3435021.zB6DRu05sN
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> On Thu, Apr 29, 2010 at 04:22:24PM +0200, Sven Eckelmann wrote:
> > Documentation/CodingStyle sets a strongly prefered limit of 80
> > characters per line in "Chapter 2: Breaking long lines and strings".
> >=20
> > Strings must be broken into smaller parts and long statements must be
> > rewritten.
>=20
> Hi Sven
>=20
> This rules seems to be in dispute. I've seen comments that this should
> not be done since it can prevent a grep -r from finding the string
> when it is split over multiple lines.
>=20
> But as you said, we repeatedly get patches from people trying to
> remove these checkpatch warnings.....
>=20
> So we need a compromise. Overall i like what you have done.

Thanks for these great comments. I will look again over the
 "Reduce max characters on a line to 80" patches and submit v2 version of t=
hem=20
later.

Best regards,
	Sven

--nextPart3435021.zB6DRu05sN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL2frHAAoJEF2HCgfBJntGW94P/2yYSfasS6muk5ubRdGO59y6
ijknqdcQGxbEpyJR/cxrDFnQg8CPLjCzggNJEuo3qyWvS+VeJKOBNj5j0Uy2bU0A
3lf4P27UkE4/Y9QceqkuvwSqdKlHyiQYeDxxuC1+G9DGYdy06MDVLzQDqHAKxUvw
OApEWwEBRiZTvcn+wZ+C9nyDWWKBjG24E4byfDhhNLCdPuUv67eCyMfwCBVa/zD5
fKUpNvxFZgsNd/OoXJg6SI19B6m4TSqIPfqVDyVTUNDVpErnASHsgHrXgRD70opz
n0VEHPZyEi3Wmt2iZJEgbAy4rn6pLt2c+ch2ed2CdKhEWEfi10XcmzMJM9I7Gwc1
76sxkT7wCV/pxlNSx+/TX1U0lWGRFAL4WLeNEDuKzOawTXolYz+uAEs+6vI5BYVE
cc2gxBtoRJRjGfqVHUVr2Jtk3sBziyqp524qYWsFb/ucWP2b/7qn9fweAHN6bZIh
sFA3T6z+GI0M09eqYoIeQvDB9p23wrdsQqIXM70yaRyLT7vuGD5q5VXPCtPyfWQ2
fsJmikkmhdnT7ydczWi7lZt5T0KsxxSoe6gI9d4jQvGGgkkQzsNvoCG9EJr4ID3u
sEzQz8ZZNAg0UaxPXzpQ151626SHwP0OCou+sACHn92htfJeNbaUDX1PZj4Tmgr2
ZQ4ajzVmPnGhmtM/G9BA
=VcOd
-----END PGP SIGNATURE-----

--nextPart3435021.zB6DRu05sN--
