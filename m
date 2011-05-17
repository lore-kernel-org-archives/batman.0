Return-Path: <clint3112@gmx.de>
From: Elmo <clint3112@gmx.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Gd3ljDpbd1UoQvG6KskT"
Date: Tue, 17 May 2011 21:34:32 +0200
Message-ID: <1305660872.22368.6.camel@elmo-ubuntu>
Mime-Version: 1.0
Subject: [B.A.T.M.A.N.] Extending the Exporter
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


--=-Gd3ljDpbd1UoQvG6KskT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to extend the Exporter of OpenMesh to put another float
stored at each Vertex to an off or obj file. But the Tutorial on your
website dosn't make it clear i think.=20
Do I have to extend the the BaseExporter by a Iterator for my float
like:
virtual PVertexIter const_myFloat_begin()   =3D 0;
virtual PVertexIter const_myFloat_end()   =3D 0;

Where do i have to add the code to get these iterators called?

Is there anything else to add?=20

Thanks in advance
Malte


--=-Gd3ljDpbd1UoQvG6KskT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJN0s3CAAoJEKitp9RgVrs9T7kH/1oPMMqJGDmHgaQbt+Uctm1m
Y+I7tvHIUO7BbVv3DVQNl2ODLwv+UI5AMM076qK/gAbWLn3Ls676eVm95fS+pM/V
h5HirvL9Cl95P0Zm5+ZzCHxRD5KfmfhuGIW2kY6Zp1w7ASEUJ9jdZfzit7Lk3UAL
SzWwc+Y8f7P4M+y5ExUNR7y46Yy7C1xx0CwzhIWkgJSV1D9eDJS3bokn0i69z54D
dEboN55Z/6Y/bGs/zCkKwBZeND3rPv/o5UozATJs4ZTHP8Ione1sukTPEQ3/1kmm
GAsAQhInbUbg55lfe+VcqTlANQge52KlZn2OBsz/9+qJ41ndHdXw8HWdsAUojGk=
=ZZQ0
-----END PGP SIGNATURE-----

--=-Gd3ljDpbd1UoQvG6KskT--

