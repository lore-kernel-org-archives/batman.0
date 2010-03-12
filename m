Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 12 Mar 2010 10:04:55 +0100
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<201003120004.48753.sven.eckelmann@gmx.de>
	<20100312000931.GB13786@Linus-Debian>
In-Reply-To: <20100312000931.GB13786@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1786150.TOZMTezx6g";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003121004.56182.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
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

--nextPart1786150.TOZMTezx6g
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> Sorry still does not seem to work :). Despite testing it on a
> setup in batman itself I also tested it with a small c program
> (which does not work as expected either):

But your version works? I would really doubt that when we do the same. The
macro will only replace the thing and we would have the same formular in th=
at
situation.

> -----
> #include <stdio.h>
> #include <stdint.h>
>=20
> #define seq_before(x,y) ((x - y) > 1 << 7 + 8 * (sizeof(x) - 1))
> #define seq_after(x,y) ((y - x) >=3D 1 << 7 + 8 * (sizeof(x) - 1))
>=20
> int main() {
>         uint8_t old =3D 0;
>         uint8_t new =3D 1;
>         if (!seq_after(new,old))
>                 printf("foobar\n");
>=20
>         return 0;
> }
> -----
> $ ./test
> foobar
> $

Now it gets real cruel, but who cares... C++ wasn't accept in the kernel, s=
o we have
to deal with it using some GNUish stuff.

#define seq_before(x,y) ({typeof(x) _dummy =3D (x - y); \
                          _dummy > 1u << (7u + 8u * (sizeof(_dummy) - 1u));=
})
#define seq_after(x,y) ({typeof(x) _dummy =3D (y - x); \
                         _dummy >=3D 1u << (7u + 8u * (sizeof(_dummy) - 1u)=
);})

Thanks for testing (I never did it :) ) and please test that one.

Best regards,
	Sven

--nextPart1786150.TOZMTezx6g
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLmgO3AAoJEF2HCgfBJntGbOoP/3nMSAyRwtJj22sQvMxbbpg5
FuBCkyVUm1OXRO/AG3siR+rryv++5VTpxdSdEIzUfH8yOAHdjAlTjtePBZhHkdra
HppslXmFsxiXFCIrFCWUDTMurm72ocotTXr5z5h+NX+4xPz/JYeNQssHOcSQG5oH
Xn8fedfN0JbO0BdUQvlYSuGBfp/Px5J+SEwf2U4n5Es/z2Z6/+l9Bu8KBxFQWv2r
PUvSbv2k3g7W6873bPdnGUO3eKUk0LhFJJWqQ3QfXpxkKZnFd9Y9xBg/Wur1cunG
jLYyFvi+F0FiEBJAlydUuoZHHtFiQzbgpfhnMM5p30pFkRDRkmp8oUo+UIFLLsHY
jxGJooqSNS2n67nJ3m2fK4+7NbvyUh8UcbRMJjyb2jfYl3nOgEhgB39Ky7IuelbV
Aow9IdxrsapErjl+u13CMuePZ/i/ToZSDQy/dUBml9FvHZihvAhFTWHgprVPTXsB
Qz/x3pZAVRSw6Gc3GY0EGHqxkkkJwo83kBZtKCKaM5/QVUw1VgB/HL3xXrfh2wI4
ifvNFzdgGD/u3zglpOWpd1gXuBeadZ7+r1hPwWzYFWvIZbehypY4QSnzGtzK+oX/
MmfEKLnqLhXXpC1vqAaKjgNTWUu/fLshLUO69K2fdBbEyY9fcz9C11kJjY/7Qd+K
KB+KO8m0Cn5uAJM9yQ+0
=VUp9
-----END PGP SIGNATURE-----

--nextPart1786150.TOZMTezx6g--
