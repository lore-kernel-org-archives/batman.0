From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 27 May 2009 00:13:08 +0200
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
	<4313f3060905261150o6c9fe82at6dd40d26456ac03a@mail.gmail.com>
In-Reply-To: <4313f3060905261150o6c9fe82at6dd40d26456ac03a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2307306.8eIAMyi1j1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200905270013.12447.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Debug Malloc Problem
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

--nextPart2307306.8eIAMyi1j1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 26 May 2009 20:50:56 Nathan Wharton wrote:
> I added the following patch:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- batmand-r1269/batman/allocate.c     2009-05-20 13:54:18.000000000 -05=
00
> +++ batmand-r1269.mod/batman/allocate.c 2009-05-26 12:25:07.000000000 -05=
00
> @@ -206,6 +206,10 @@
>        struct chunkHeader *chunkHeader;
>        struct chunkTrailer *chunkTrailer;
>        unsigned char *chunk;
> +       uint32_t remainder =3D length % 4;
> +
> +       if (remainder > 0)
> +         length +=3D 4 - remainder;
>
>  /*     printf("sizeof(struct chunkHeader) =3D %u, sizeof (struct
> chunkTrailer) =3D %u\n", sizeof (struct chunkHeader), sizeof (struct
> chunkTrailer)); */
Please don't introduce more magic numbers. If you need an alignment on inte=
ger=20
granularity then please use sizeof(int) instead of a simple constant.
The rest looks quite good and logical. I assumed that the only architecture=
=20
without automatic catching of alignment problems is mips with load operator=
s=20
to the fp registers (never had such problems on simple arm machine nor coul=
d I=20
produce that problem on them). Is there any other documentation about such=
=20
problems on xscale or can you proof this with an test program (malloc 6 byt=
e,=20
write uint32_t to first 4 byte, write another uint32_t to byte 2-5, compare=
=20
bytes with input - don't forget to set it volatile)? Your current proof if=
=20
concept test only shows that the "overriden" bytes will not get overriden=20
after moving them some bytes higher.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#include <stdio.h>
#include <stdlib.h>

#define x_moved(pos) ((int*)&x[pos])[0]
static const int value1 =3D 0x01234567;
static const int value2 =3D 0x89abcdef;

int main() {
	volatile char *x =3D (char*)malloc(sizeof(int) * 2);
	x_moved(0) =3D value1;
	x_moved(2) =3D value2;

	if (x_moved(2) !=3D value2) {
		printf("ERROR Value: ");
	} else {
		printf("Value: ");
	}
	printf("%x %x\n", x_moved(0) , x_moved(2));

	free(x);
	return 0;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Best regards,
	Sven

--nextPart2307306.8eIAMyi1j1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKHGl0AAoJEF2HCgfBJntGmyoQAKhKUvR0mYOOElGI6OSS8gzf
2eG1xIJJfZoqR/wOLOiWdDMdH0VorB6lVGoN1DBq2183nLWTm2psHzFPD8T5w//a
U2Yj84jaG3vD/HDgM0oFY03DW65yiffkPHLGijjxtYpNmvzLSuuGM/SVogBtoiQw
3m3ZUqV881yk+0/zdsWL4HSp1sjoG0gDdcyu4OXOos67Gfk5i0ovgTHYrBIm6l89
HPIILE8R4gDCQERr+leM82BTgtEYIjRl2SQFosyjToVgZc+H8w7rxJPkEGmXdOKe
DnIv45XOtVc37vqHkCdQ+AsDDEVWm7gvK512XbxCSzh2NWHSJvSlosob+Nwv8LMt
QKtV5vGTG3NvHyyg646WVg3uhNZ5qkVS2Be8BY49kI3iONb8Z5yWnqISBTFoYLKh
SOZisx7XSwzxBHUv/tEnYDh1mGYhEOxT9quS90ZvmwN2NngGyIoNI1qJ24dgxED1
YeVGxl8riz9dqagSGzPr7VRgHj+WvfQSYqk+byOPncbiBvdrIiOZqxyE8cVyZK72
nRChtb3H985tsNTM3gRGSpdi2hgg0Booos5EsfbV0KjQe/mD9+mGyUEp9bARlZVY
IVZX4F2f8G3xKJOleoM0ItuSfSixIpgZTlrOTXOODifzvHsdtuinEgdUyw/xmnYu
4XCSP05ZC5X17KxmjqhL
=wUks
-----END PGP SIGNATURE-----

--nextPart2307306.8eIAMyi1j1--
