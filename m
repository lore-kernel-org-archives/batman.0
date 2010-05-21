Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 21 May 2010 10:08:08 +0200
References: <4BF63AD1.2030105@tiwoc.de>
In-Reply-To: <4BF63AD1.2030105@tiwoc.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5045983.U1OKnEoyTy";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005211008.16487.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batctl: Correct mdev calculation in
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

--nextPart5045983.U1OKnEoyTy
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Daniel Seither wrote:
> Fixes the calculation of the mean absolute deviation (mdev)
> of the roundtrip times. mdev was previously calculated by
> computing the difference of maximum and minimum round trip times.
>=20
> The calculation is now done using the same formula as in the iputils
> ping program.
>=20
> Signed-off-by: Daniel Seither <post@tiwoc.de>

Thanks for the adjustment. :)

Acked-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Best regards,
	Sven

--nextPart5045983.U1OKnEoyTy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9j9oAAoJEF2HCgfBJntGop0P/ighEPOSPo9X31kJvt1H2X6h
BUAy53CYgOgj/e490SpNBROeAN95W+PX4A7e/KtJ58AcfO/4Gx5huPNrm2dal5dV
tQNLCG3GDRJ3w3O6Rd9Oa3VcxA9EH17Hd+cFrt6DW2AtH85I7QvtvaXMcT9IJ140
h7WcUrVIcXa0snmYN1hn+u7OJbPB1IgaZpRFdrADeD5q5RoD8SH4UsOpnQQvjnnQ
oKp9XJBKhy35SS55sk3TJsHQm0YE0Z4xxhaQm0fCfHwVa4MK1F2LMeieauLjP53i
SCBOD6s/otMzBOQvV7ySWSf+zySNUu7vJ1RnJ3SJceI9eK6ntoU8vk9DhNCgOI8I
N6cx3/iVl/g5pI5c99Zh1a1Lf/MaaDqCT9aXUpQdT1bfq3HYN27PNyQ6z4nqDCmD
H2mBm+D08dxjmzNi2huOpTKEmPAjSwXHjKdpdRiyVbTsSGJ0nHD6Vza3BBA/wUkL
fpkBqkbQCaewvA1l5iFFdWC6/WXqXOEpxQ2lkA+2PA9TWDVOhNWmAJpHFgOjVNml
KIAUn6wfVcZAMGl7H4vplwcaUqhmyFLoZQbE5wnjXctwzAvku7oxzxEGNDqixChQ
kZ8QcWv49f/LlQTLHX0i+Sk4/Tjy+RG/CeofC79Oef+SjXSPD63KySwx5c1zAwqT
Hk+OiF/wSYtDWc008pS8
=pIDc
-----END PGP SIGNATURE-----

--nextPart5045983.U1OKnEoyTy--
