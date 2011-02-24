Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 24 Feb 2011 11:23:41 +0100
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<20101220090502.GA30598@Sellars>
	<AANLkTi=7es_PbdB+-_+pGZ7B1n2Ke8xFUXRA7vFdP_O-@mail.gmail.com>
In-Reply-To: <AANLkTi=7es_PbdB+-_+pGZ7B1n2Ke8xFUXRA7vFdP_O-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7595868.t57k8dEUVB";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102241123.43797.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing
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
Cc: hlabishi kobo <hlabishik@gmail.com>

--nextPart7595868.t57k8dEUVB
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Disclaimer: I will not comment on the whole subject. All my comments are on=
ly=20
based on following code.

On Thursday 24 February 2011 10:58:02 hlabishi kobo wrote:
> int weighted_bit_packet_count(TYPE_OF_WORD *seq_bits)
> {
>         int i, count =3D 0;
>         TYPE_OF_WORD word;
>=20
>         for (i =3D 0; i < NUM_WORDS; i++) {
>                 //word =3D seq_bits[i];
>                =20
>                 if (seq_bits[i] =3D=3D 1)
>                         count +=3D i;            =20
>         }
>         return count;
>=20
> }

You only gave us the following code and no other information. I must assume=
=20
that other parts of the code weren't modified. The part of the code seems t=
o=20
be derived from following function:

int bit_packet_count(unsigned long *seq_bits)                              =
                                                                   =20
{                                                                          =
                                                                   =20
        int i, hamming =3D 0;                                              =
                                                                     =20
                                                                           =
                                                                   =20
        for (i =3D 0; i < NUM_WORDS; i++)                                  =
                                                                     =20
                hamming +=3D hweight_long(seq_bits[i]);                    =
                                                                     =20
                                                                           =
                                                                   =20
        return hamming;                                                    =
                                                                   =20
}

It is easy to notice that the original function is aware that many bits ins=
ide=20
a word (unsigned long) are set either to zero or to one. The sum of all bit=
s=20
inside all words (sum of the hamming weights) is complete set of informatio=
n=20
the routing algorithm needs to make any decision.

Your function is also operating on the same data, but only tests if the las=
t=20
bit in every word is 1. Lets assume that a unsigned long is 64 bit long and=
 we=20
have 8 of them. That means that we are only allowed to have received every =
8th=20
ogm and that we are currently shifted these bits to the lsb position of eac=
h=20
word. Something tells me that I should not start to calculate the probabili=
ty=20
of such an event.

I would suggest that you check your originator and global/local translation=
=20
tables.

Best regards,
	Sven

--nextPart7595868.t57k8dEUVB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNZjGuAAoJEF2HCgfBJntGLu4P/0CmIF6pI6T0PF/Eku7MNAiP
R68u2g9+QL231KYsWBc6vR8aSjhIHWQuQIty3krpwpLOvyRFzu4Uwjbq+HBD3LCG
sdG0p0FI00deQtXmzfNmoWFLUvlr3hzImBIrJlQFEV1Gyzm9+56v/SvgCDBGcPV8
QVgKRIHzFvjk0IE1Bl6rr4dVbfomBRpv6CCUL7ywaZmngXSOJZ5M8JL2Otxhge0r
hxmvBiIgLkFCOyuO7sr6RKe96+uYunc0Sz0sghW2XD+jianPg1F51++JsveqGvnn
3GCLugHRg/prlZuLIM9sKbIr8Lr6BdZqziHcq423UqpLugCTsyjN2h+BfQKzp/6B
l4Y0YGVbi/hBNhhQVVcKi7CIriQ0nYLZ0ZniXhGoq2UdcvmBOu/neSmAkOexvP8n
GBf5ScX2S9Fw+bBB4Jp0NHobMl94pKPFPapnMEUa0R2rBWRNrLCLpKAYgss5/t2x
T4uP7Tr8TFfPv6o+Jngy6tNNOF05Dh8E1r0JN80SKiVS+IRNErCA+KwhqjwQBwIv
MBjqoEPPEn/br+kRjfB/ZA3v2lX/YFa1Mgf1Y3Fz2Yts2LLq2DuXvJXXI8FGSpwT
S4qWUYYJF6dd9CWpgkrUsj4crx+6q6nCRJ6/tuhKn4OxMkd/nEFUiOn/4KZknBLo
8TEQALckPa5bQBtVq5T2
=0p4z
-----END PGP SIGNATURE-----

--nextPart7595868.t57k8dEUVB--
