Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 20 May 2010 20:06:27 +0200
References: <4BF56357.3000208@tiwoc.de>
	<201005201900.01910.sven.eckelmann@gmx.de>
	<4BF5782D.8010207@tiwoc.de>
In-Reply-To: <4BF5782D.8010207@tiwoc.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8519443.KZA165rFfV";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005202006.33313.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Correct mdev calculation in
	ping subcommand
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

--nextPart8519443.KZA165rFfV
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Daniel Seither wrote:
> Am 20.05.2010 19:00, schrieb Sven Eckelmann:
> > Sven Eckelmann wrote:
> > Ok, have a small suggestion. Please check that mdev - ... is positive.
> > Otherwise we would have something like (mdev - avg * avg =3D=3D -0.000.=
=2E...,
> > sqrt(...) =3D=3D NaN):
> >=20
> > PING 02:00:00:00:00:02 (02:00:00:00:00:02) 19(47) bytes of data
> > 19 bytes from 02:00:00:00:00:02 icmp_seq=3D1 ttl=3D50 time=3D0.10 ms
> > --- 02:00:00:00:00:02 ping statistics ---
> > 1 packets transmitted, 1 received, 0% packet loss
> > rtt min/avg/max/mdev =3D 0.101/0.101/0.101/nan ms
>=20
> There seems to be a problem with the floats... The value of mdev - avg^2
> cannot become negative if computed with infinite precision. In this
> case, it seems to be slightly less than zero because of rounding errors.
> In iputils' ping, all calculations are done using integers which
> prevents this kind of problems.

Correct. Because of that I recommended to check before calling sqrt.

> I think there are two solutions for the problem you discovered:
>=20
> 1) check whether the difference is <=3D 0 (easy)
>=20
> 2) rewrite the time measurement to use integers (more code to change,
> but calculations will be exact)
>=20
> Please check whether replacing the line calling sqrt by the following
> code fixes the problem for you (first solution):
>=20
> 		mdev =3D mdev - avg * avg;
> 		if (mdev > 0.0)
> 			mdev =3D sqrt(mdev);
> 		else
> 			mdev =3D 0.0;

Already done that - that's why I recommended it :)

> Or should we aim for the second solution?

I think the first solution is good enough for now. Please send the patch ag=
ain=20
with that fix and it is ok for now. If you want you can rewrite the code la=
ter=20
to use only integers.

Best regards,
	Sven

--nextPart8519443.KZA165rFfV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9XojAAoJEF2HCgfBJntGstIQAJBzDF/G08juKhO0zplpXyWw
lmVdqoXRhG7qJuFKgH9yUoGmFOhRgRx/mhw9iZymdHnNCLzPKgFdKLaYJsj14uEP
O01KilXbL4R+VI74sgjjgydBUAA0do4Bu8tH9wjJacavCr0awso/E5CxbqjSIoao
l27oVFCkq8NJUliuG9Q5wKQmThQRhrQZktcGueNhxViPwNnsa8T67i1vPzdip4l8
KL5837EyjSBieiCf2ziUXcbaASEAP32AAfLAxIaXski7l5pRscUmmPVl4ybt7MHR
9QHxg5inKcHDkSPzmKG1ydOja4sxZdFjN3XGsfXBNbMmR0zyYtYy/FZcebX7AV3r
X5yvVgvmLJVzqaylagNxXSr7P4MzSqsZCGjOGLGZU7czNhwKu2vnP86Nj3goH0lD
zs4/zg7zJG2c2wsZjc8yrepCVZTI/ZbzdadBFdMqnBXCXdkEsF32N+jMzGlVu1gE
NgreffCuxXpzMuANm9fQh0P2hTNYdxz1o0ZRX+QIn1yJfgkuR+xJoBQ1b9uD3jY0
T4jiyOs0/9hdHAZzwo9Cjb/aPWQIUNbY0bq5U63qi3LCSXh+afqefsHNreBe0y2r
x51M19N+12JTyuCwp+Ba/3wQNoNuCjQOnC81NYYHBU/iqApVzrbqvoLzHqeGyffT
qRhcm93INQsb2U4/ugE3
=2JAk
-----END PGP SIGNATURE-----

--nextPart8519443.KZA165rFfV--
