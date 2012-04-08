Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 08 Apr 2012 09:53:56 +0200
Message-ID: <6446119.Og1ZRWHNA3@sven-laptop.home.narfation.org>
In-Reply-To: <CAJuY50wnaeNvHJU0x7u6i+Q29Gx9hcd=qjdmZeJeEoftkgqTtA@mail.gmail.com>
References: <CAJuY50wnaeNvHJU0x7u6i+Q29Gx9hcd=qjdmZeJeEoftkgqTtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart53357160.du5LDpWTi1";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Subject: batman-adv Openwrt Kamikaze / 8.09
	problem
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart53357160.du5LDpWTi1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 08 April 2012 10:39:16 3zl Trizonelabs wrote:
> Seeking for hep to get batman-adv running on Openwrt Kamikaze 8.09
> build Kernel 2.6.30
> 
> Build runs ok, but module not loaded.  ....     batctl -v
> ...batman-adv module not loaded
> 
> Try to load manually :     insmod /lib/modules/2.6.30.10/batman-adv.ko
>  ......... unknown symbol in module or unknown parameter
> 
> Any hint how to setup the build for 8.09 trunk highly appreciated

Can you please check that kernel module crc16 is loaded.

Kind regards,
	Sven
--nextPart53357160.du5LDpWTi1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPgUQUAAoJEF2HCgfBJntGVYwQAIrMg6tO3BBWcJ7jpYXePXZb
CWMZ4RL/hUp2/5NjnEiCwn1TrDgGhGV/CSIfsIXKRArQPOrlzQCJGednMttf7TOK
JwF123hnUKAkSCxHJL3bdvbubhmF428cva9upDjdIJ3yjBv+ulAhgMq9yqZwrYxu
6Qiz6CGDg11xs9eZ+2V4O4xqrRgUnch3tFJhXGhzNeuW4Z8YIV//YMFq6fH3Ne4P
BiwyUu1hcXHX9z53xURAKnXk0h1Iuhw15CZkNco5PlmBz4TvZXus/v1s1nRMOp8o
e6NY7ASuggbYNOokN8cmRP9qDqJNMnFltUM2wwsHxy1P1Ty7+8qx/jNDwmTYYajY
4aNqwN2DhB6GtiFzv1jQh8eEl/SM+5ZUDBazvyHAohh8Fip7PGelgYTlC0sy4lkW
ReaoPPK+Pq8ajjkQiVLmLl0PNFQbnCP8xtM1IZdKimnYJnYX9RgWUI+iAQkClFZ6
gZsxRzrWxPCZUx8q3gFZCquvd4Sw/8tGZI5wSTp2xFTnpz3kZXHFG4HF6GE+g4U+
L9XdifGEc50ufvo+SICrBOmzFGs8T71pce7jkkRuzpHQHTC7pSuJp34YlXpgjHe2
KcgZX2PUo+iHwuGG5OlVXb+6e/986ArCwntxC/VXWwnTJAPDh95NHyfhzWhQiz0e
YfDefc32iVlamnZAupJ4
=IAUq
-----END PGP SIGNATURE-----

--nextPart53357160.du5LDpWTi1--

