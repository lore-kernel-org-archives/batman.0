Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 15 Jul 2009 15:56:29 +0200
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
In-Reply-To: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6096718.QvXisRxJ9D";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200907151556.32314.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
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

--nextPart6096718.QvXisRxJ9D
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Partial output was caused by failing to read the HTTP request. This
> patch reads the HTTP request into a temporary buffer before discarding
> it.
This patch creates an endless loop on unrecoverable socket errors. See read=
(3)=20
for more information about return codes. Please provide more information if=
 I=20
am wrong.

Best regards,
	Sven

--nextPart6096718.QvXisRxJ9D
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKXeANAAoJEF2HCgfBJntGdGYP/1KKsyu34W+xfhy5tN4LJNRL
9ufd9bTW9HVK0AcivssNa2qM9NxC9cWS7i1Ha+jwiyY0t1esdYnPiE5IRJuKU4XY
Vyem5CGZ/eI+g0I0/aofN7+ZibOIWglxNAwF8aL1P6ElN3VbCKjSenLbE6DEePIy
cSWrL5VozH1o0Nj1kAL3+MnN5Gc/5jcsE6e0xWyuyNYswvgcP48cNIdN01JcrqCK
bCuiGzpT1nvQuayPPASG0Cw0UFJ+gAYYYpRdb33RfQGz7AYmMU+eEfxU5fBlSG+A
u3jIxQK+Uv+Z+QlaR+HHr9jEG6fFPDs6qxsXh1+ODqrntAseUcO+Ji4m5XyYgb63
gj92G2rhXJEUdRD45FpPfmiOiXguHYmIeVztORLgZDQ/zzna/cnssp/Vd08pynHx
iAkyQ8P4ygblQZyfXJwsu+QfYIGzrC7mpMgBi+fClqteF3GM3DfKL4swzJZa2ln7
s2679Euccw59fJGDrMr3qycErCWx6gz9fAxdeI+ObB9uTcD0Pyl3nhDT49WptOR1
roTYUHOChleyC1beHPHrGUFfE4t6knES3Cob96cfLOICfo/B+nw/T0pMpuH77+ym
thskiX9S1LmK7pw7S5v8I1U9CfHIN0LB7U6yBdKARTHQT8WsIrTteIGqlfuD2QO+
W26Ha7yVsPME0ffZHNli
=AgJN
-----END PGP SIGNATURE-----

--nextPart6096718.QvXisRxJ9D--
