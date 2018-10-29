Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Oct 2018 18:34:54 +0100
Message-ID: <19262377.tOAJaTasav@sven-edge>
In-Reply-To: <a6b00b8957e483dbb895204d33f554ac35a826ee.camel@sdl.usu.edu>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <17712655.F8A4oun0WA@sven-edge>
 <a6b00b8957e483dbb895204d33f554ac35a826ee.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9012674.yz94QG3eO6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: "guohuizou2000@sina.com" <guohuizou2000@sina.com>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart9012674.yz94QG3eO6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 29. Oktober 2018 18:25:19 CET Jonathan Haws wrote:
[...]
> > But your memory initialization is completely broken and have to be
> > fixed. 
> > Right now, you are just comparing uninitialized memory regions
> > against each 
> > other.
> 
> It looks like you fixed the memory initialization issue in your latest
> commit (recv.c, zeroing the alfred_source variable)? I'll pull this and
> see how it affects the behavior.

There is no commit yet and it is still queued in patchwork [1]. I am still 
waiting for a reply with Tested-by: ... line from you.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/17596/
--nextPart9012674.yz94QG3eO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvXRL4ACgkQXYcKB8Em
e0YxGQ/+MKc0K6jYxqEh4wIVfwDO6BL8FM6ZMc7cyXReYuq0uwup9d9YM0wTM3UI
HIhQYfL5g42jxR4SRYjWPwh9tiDq1U3jn1QKJOUJTpH+qNqW3I8c4URIVhljowbT
hicwzK+CulEfNFSy6rwos+xf1FExEOdfuvstL94V3HJHE5nvexWvL1ZvRZJbMPar
KraUIKjMEIUX/UkgiELZ/v91/Bj58fc+ODs2ScObC3kOsDfQj5troTSd+N/KKT+s
SC1n6POQ/5GFnsyUSPVd7w4PxofgQaaypVmssc5ZeYJMGKk0lRx8KMmUZau+Q4HU
m7LveWpcmYZwHHEc3cjq9wigrMCs2x55nW5eC1xTF+oKHJaWhLICTsIzbzehqAzz
jVSLr1cVG1ebBvIQQKDHPP54qAO+OA4h/JhSc3V2CwGKtmXEPl3yhE7VP/gbQ4du
KKUunNWRd2fBGuYpvzUQL/g2T14gsQp+l/LLNeEdZHjIVeA7uk8utyiLGDcHaXAw
xBrBfDVqT1SDKOAxFZS555T2hcI0WlV1I+8fNzmuHoujwRCY1PAvTkkx0YKtH0Ks
Ys7VwznJ2UpxxpHasofxxUChOZs5umybbDKVvCL9JUQjpnNL1ObtD1ZfhzFtB73R
33qQh73RRui1rOxSoU5I8H2pyToEUYcj7CFZ6841B+NN60KzjUE=
=BXVN
-----END PGP SIGNATURE-----

--nextPart9012674.yz94QG3eO6--



