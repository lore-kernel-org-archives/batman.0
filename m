Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Dec 2010 21:36:46 +0100
References: <1291233547-9437-1-git-send-email-sven.eckelmann@gmx.de>
	<201012122029.47019.lindner_marek@yahoo.de>
In-Reply-To: <201012122029.47019.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10861579.l5JJ9hQanW";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201012122136.48156.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use kernel facilities for
	bit operations
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart10861579.l5JJ9hQanW
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Wednesday 01 December 2010 20:59:07 Sven Eckelmann wrote:
> > set_bit and test_bit provide an efficient way to set and test bits of an
> > unsigned long.
>=20
> Since test_bit() / set_bit() expect 32Bit values we should at least add a
> comment next to TYPE_OF_WORD, so that nobody changes this define ?!

unsigned long is not always 32 bit.... I will send a patch which completely=
=20
replaces TYPE_OF_WORD

Best regards,
	Sven

--nextPart10861579.l5JJ9hQanW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNBTJeAAoJEF2HCgfBJntGKjAQAJV/7FwITzTRQQqGch3G2Pic
XRHbMsnC1MkZQq1NGaF8gGL3Xn92OC64nWmzROZSa9NhX+LNLfJlNyHjgNO05Urj
beIJr/3+fCMP+PWL33pUK3gFtH0X6xZMOW+D4PvBWOSTZnLsM50kGXCNdDP90iNI
PyhgES+AFWi6E/jf6+JtLlJn6OqsQydexeBAhaOMmS3lRPvmUw4qQHEAeY3iHUKZ
5+/Ls2cLHTejlEgFe/Gxq+38e5rxS8QkSFY7B4rsO+jM8/ssXhj4yIq7r1IVe7Ts
r60MHqOXjVNBv4lomHWWFsyl+Y955BR+1i9SZgqv66fYO4EB3A+3Fnzj7zIPFKCA
gkw9xaYPTFre2HFTDKfg5P1i3YfPAst5ngB70TqAN5gXKz7Q78NpbyG3hmDRMrhY
edwE5n5gX5DL5GjFuBkTXTMRdN+23Gu1ovGBgwZgyxWqwfj3m369h+BrLiq1mVIX
2WS6a2XNZWbOxtS5LWb4tHkEXvMeh4XjEkNCqL31F1mZL9nFuL/+7TkNAG6fCjhI
ZrVGp3hczAXsaRSyuiXWUDdjmCEsUtAtbZf2z6kDy+kPmC6mAUqim5clqopwQy2H
gfUALac5eAkj2VkpBMy9fWEl9bGuw+Qcjo/W/OyFvEUFTSAlOr8DgbpG8Vv6u+w7
JbS6AXJCx1w1d+qdBYOO
=Ycgh
-----END PGP SIGNATURE-----

--nextPart10861579.l5JJ9hQanW--
