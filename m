Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 6 Jul 2010 21:13:11 +0200
References: <20100706175814.6927f767@rechenknecht>
	<20100706173956.GA9429@ritirata.org>
	<20100706185729.GB18453@lunn.ch>
In-Reply-To: <20100706185729.GB18453@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2843739.We4bBgFHFV";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007062113.12980.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: layer2 unicast packet
	fragmentation
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

--nextPart2843739.We4bBgFHFV
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> On Tue, Jul 06, 2010 at 07:39:56PM +0200, Antonio Quartulli wrote:
> > Hi all, Hi Andreas,
> >=20
> > > +#define FRAG_TIMEOUT 60000     /* purge frag list entrys after time =
in
> > > ms */
> >=20
> > Why did you choose a so large timeout? Is there a particular reason for
> > that?
> >=20
> > I think that in 60 seconds an host could receive a very large amount of
> > "orphan" packets in case of a bad link causing memory problems.
>=20
> It will not cause memory problems. The linked list is limited to
> FRAG_BUFFER_SIZE (6) segments.

He didn't say that it will take all available system memory. There is still=
=20
the problem that the 6 slots per originator (so the memory per originator)=
=20
could be full when we have a bad link and a too big waiting time for missin=
g=20
fragments.

Best regards,
	Sven

--nextPart2843739.We4bBgFHFV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMM4BIAAoJEF2HCgfBJntGUDgP/3ahF5mrhLJLKlV3zjSG/VyK
lwfyEbJ/fPoC6DUdrPImYBIuTV/2IUGOfWRhs7tJxy2WUdEajNcqnezCkn6pVOSb
uNgIW6CGPuPIwLBuUxeU2HC80VrtG5Po0QX7KsdNBb0ZFpald/b9INDhLQY8CsPe
uCpYH+7g06cFGoNGjMfanW3EvEPqkgeG6v9Xa3GSvopegbd4f18ta2Bh5HJcn5OI
wwMwo/S/Ok8TI1VtTT+Q/6pRUuV6NyF0hfdENtOmho5oz4pnow6WMQFBaYu9PPIn
nSx9xyhh+pjwgDgwzI7lklgPeeMldTNX3/uIVdmcJ00ZJ8gQ4e69U2y0Uu/hN7bh
80F9mYQkdPDdPmvZwSl2zNu0WUsfwtEA7vjPF94NoJfT8G59CiLn6OYijXEAaDK8
0abL27ftW60OBRQHNKHu9SY5D1+RrRq6FFCxGToGR09pGt23EJDAYPASqgYgvzsb
OETzuHdoZhyBGQQytwZgho1iKhSxAxHNCg6nrc1dqWSDn5idveO18THNpjG38eJg
jKQX6JPFOsspIzLtv3FZmoD5drK44ZJM6jIOctKKFURXQUONW8W+YoSPwFWNzGW6
Hld3+vZynC7gQ6mPL5uZFphKghlgeAhOHh2k7r22Szmafz2PJf5bc8hjOlipPk+G
Iu9dgnn8ueBOHwAmfnSa
=xFxC
-----END PGP SIGNATURE-----

--nextPart2843739.We4bBgFHFV--
