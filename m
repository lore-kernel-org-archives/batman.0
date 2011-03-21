Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 22 Mar 2011 00:01:45 +0100
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201103181218.56535.sven@narfation.org>
	<AANLkTinPwwPP-kP9QajcgC5+90w1x-3-wc0S3MhJdF8F@mail.gmail.com>
In-Reply-To: <AANLkTinPwwPP-kP9QajcgC5+90w1x-3-wc0S3MhJdF8F@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4947768.YsVVF9G8Oi";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201103220001.48909.sven@narfation.org>
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
To: hlabishi kobo <hlabishik@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4947768.YsVVF9G8Oi
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 21 March 2011 23:40:57 hlabishi kobo wrote:
[...]
> I actually printed the seq_bits[i] and that is basically why i used 32
> but that was just for debugging purpose. But actually if i use
> NUM_WORDS, my weighted sum become very small whereas if i use 32 it
> becomes very big, trying to understand what might be causing it to be
> that way.

NUM_WORDS =3D=3D amount of unsigned long/words
WORD_BIT_SIZE =3D=3D amount of bits in a unsigned long
TQ_LOCAL_WINDOW_SIZE =3D=3D sum of bits in seq_bits

Nothing really fancy here.

> > you only calculate the weighted sum of a single "word" (which you static
> > casted to int....?) and not all words.
>=20
> i actually dont understand this very well, how many words does seq_bits[i]
> have?

a single "word"/unsigned long. seq_bits consist of NUM_WORDS words (words a=
re=20
defined in context of seq_bits as unsigned long - that's why we removed=20
TYPE_OF_WORD completely and just use unsigned long).

Regards,
	Sven

--nextPart4947768.YsVVF9G8Oi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNh9jaAAoJEF2HCgfBJntGnlwQAMv2vrF2FwosXxQIZZKciB7m
zKKqDFqNaAqtS711mkeLU5Vu3Winm0rFakOyu6DJBPOa6i/ZTprPdH4BxJXMlpDg
STFk5hDD3uda9N03ZmGyeSog++MTnfC2c15XKBhB7iDLITRBJ2bcAmEj62GXKfBG
h+y1x/qzJdrfdhDEbXc7G6ioYaoXMBYmkLJo3r3L8cX+gDtSsp/WoP2iB47Ewrx/
ehC6HTWtIzgy0fcvTl9O0KxNuKNRXB5rf37HwTRxNdKtQv04W1FJDwtsOMMnrEP3
0j/EAdpWbNWY8B6kSwCL0fPuQfuQP6tfNNHkDez65eyqcq+AsRGRq9g5G+lbTfTd
7GwBI/6GeN9Q2w26B4ZgH6b71wEXHbbmTnXDT2wFKrgl+fxwgS4Ml7AP62lyM9vO
r+2MmSxLedu8myU5/THrfR+qvfsqw/NvSaz+EPlVTuEBORXI3K10pGFHIzwE9F6e
8g1CVnhEIcwXDGOT2RohEQCPDJ/L1rFo1ToArhO05w2zLfG21emh9xrbOBf3T4c3
1H/RHp3rM0dzN25E6thYo+Fzv9MPlQPscKjwkELjd19Wo83782aS5r5GOi27zwVP
0vAZEZAPPAL4HI6eKqvH23oQIAkfIkxj1BSmLe/iLehjHHusfMl+hA7/H6phNF2z
7uFspTP809f2omI7Mxxt
=2uZ+
-----END PGP SIGNATURE-----

--nextPart4947768.YsVVF9G8Oi--
