Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 13:46:04 +0200
Message-ID: <2394098.zSA1hTeZKT@prime>
In-Reply-To: <20170613110824.27786-2-philipp.psurek@gmail.com>
References: <20170613103916.27299-1-philipp.psurek@gmail.com>
 <20170613110824.27786-1-philipp.psurek@gmail.com>
 <20170613110824.27786-2-philipp.psurek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4993340.4OMjdkEZGQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: suppress implicit-fallthrough
 compiler warning
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Philipp Psurek <philipp.psurek@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4993340.4OMjdkEZGQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, June 13, 2017 1:08:24 PM CEST Philipp Psurek wrote:
> GCC 7.1.0 complains about an intended fallthrough.
> =E2=80=9C__attribute__ ((fallthrough))=E2=80=9D in this part of code woul=
d suppress this
> warning. Because older GCC compiler don=E2=80=99t understand this stateme=
nt
> attribute and because there is already a comment in the source containing
> =E2=80=9Cfalls?[ \t-]*thr(ough|u)=E2=80=9D we can suppress the warning wi=
th the
> =E2=80=9C-Wimplicit-fallthrough=3D2=E2=80=9D warning option. Unintended f=
allthroughs without a
> comment would trigger this warning again.
>=20
> To avoid compiler recognition in the Makefile a simply change of the comm=
ent
> is sufficient to suppress the warning. For some reason only stand alone
> comments mentioned in [1] are recognized so the comment has to be split up
> into two parts.
>=20
> [1]
> https://gcc.gnu.org/onlinedocs/gcc-7.1.0/gcc/Warning-Options.html#index-W=
im
> plicit-fallthrough_003d
>=20
> Signed-off-by: Philipp Psurek <philipp.psurek@gmail.com>

Thank you for your persistence and testing!

I've adopted your patch, but put the second part of the comment into the=20
following case to avoid the ugliness. I didn't test with gcc 7.1 but hope t=
hat=20
should work. Please check here:

https://git.open-mesh.org/batctl.git/blobdiff/
620226bf8cff30e6dd966c8fe922b2d4cddf843b..
50ee3c45feeda6d8c04ee127097badf99f78a26e:/tp_meter.c

Thank you!
      Simon
--nextPart4993340.4OMjdkEZGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlk/0HwACgkQoSvjmEKS
nqHvXA/5AdBTamW9wgGBWfE30qoGYDb7UV7vgWhEKo428Q7kWNKyHkfRpm8qB+hB
tfBykj4dOWWK1ryqdZttsMZuFUW6ONj4TDTYTGpb9NALlN4U55FNOEHLqdz3thTd
cz0tswKQ636Erfr67XEFWB+uSwXGRFv7e3c/tDBsYiDwcr913FsvC3GZhwO8u7fi
IkJiC/Vy2y6YiJSbMFiiJHcppeD3+4xdB/X+TCXMqJVoh7ZGsrNHrRonAblC32jL
KSSpMC0oBS4NIGQkW8SAHzXEa5ZHrpW4hgf6NefD9z+zUAHgfkIO+rhVPa/dWbxl
FnpLZ7+j2S2sT37zAHug6R1aQelO762peMZLCrfQIjLNAMjXWvEvRPvf95UIjI8+
VJaAjzSB1p435pmNM6pvLJfna/jZyfe4PBjICLfHVceS/7Xx7EPxtdGNRy22LF6D
9bijKGu1J1l0H8GzeDC+hHHLMyAm9nJx8AhLGlRUwfljRUz/cFjxfdfbqnWH6lOA
mHEcSKNbRJxZrJLsged8VRWDeNgI14eR/+S93h6mpaxtIFR7x3rPKVyR6WWl1aVk
2wwAPYWRmggqCLsmnoEQseicqLffG7KLWkQFvtrUjmWkdmUmWOxt1aEgiQq/tJql
7MdunLhbIPnkGQCO2XnsU/5u5sejq6Gfw0YsG2xIEtUBD8oPfQA=
=pI56
-----END PGP SIGNATURE-----

--nextPart4993340.4OMjdkEZGQ--

