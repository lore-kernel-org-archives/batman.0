Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 01 Dec 2017 12:19:51 +0100
Message-ID: <4625975.FkqdkO5tjk@prime>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart32874063.EFIeEBKbbZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/10] batctl: Fixes and minor cleanup
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

--nextPart32874063.EFIeEBKbbZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, November 23, 2017 3:04:34 PM CET Sven Eckelmann wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> Hi,
> 
> today I had the unpleasent experience to receive [1] to a lot of PDF files
> which seem to contain some reports of the Klocwork static code analysis
> tool. Most of the stuff was nonsense about memory/resource leaks (even when
> it stored in some kind of structure one line before). I gathered the only
> interesting portions and prepared some patches for them.
> 
> The last two patches are actually not really bug fixes but are about code
> which completely killed the static analyzer. I didn't like the code in
> the last patch (looked to complex for something relatively easy) and thus
> I've just replaced it.
> 
> WARNING: these things were only compile tested
> 
> Kind regards,
> 	Sven

I'ved picked up the series into 6116097..cfaec23

Thank you!
      Simon
--nextPart32874063.EFIeEBKbbZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlohOtcACgkQoSvjmEKS
nqGODg/+OEM3hDDTbP2cAcwdXDI9TeKbYhAYE5VQ0Zl2Dy4hdC4/Hk6TWFGjL4hl
4ZY5v3r0fz+YFROnH0C+mrMXlBan+XH0E0cr7fMVj86HPmADQR/dvZRhy06yCRwF
Wrle4eea4/54+cWWnPG4E8zHdf4RjFfc8VXeBt21OBS2Z/IKkUpCGFQpaRANiGoP
UGE+BOosDNVeAkidU/cj8lEIvKTDGJs6KkFzvkoE+h38WX8x+ls3Exw2nt/5MxoL
69XVfasj6rh2ccgKJ2/eM9EQXSxbAd2cOBVKDENBEPSN4kUIWaiAJBOuUy8uZ+b3
Wvp3kow7sl0ze10V4A4qUjyNUvwNRm04RBBMJuWZXIN9SJ4NoSKvXVj9GDO6AaBt
AHfmAkCyahvf9TWUgtkkORVEGxXx24c+MecpkeAu3CZabYNjxrRfQjHyBZeGnmd4
cGoEm1R5mzVutgTtj8jn6uIi0YE9dPE+payTB6LpunRZoBirqSkQGH+svo9d4i3X
JJCVes3Zellp6M6G0OFf9Dnekk0qq6asa4JJ80tjOqJVY5XGFO4sU0dxn0Je2Tc8
nxvTJkyQhfRW9G98w+aK+boS2LkYn0IOT/5tfXMeboaKbNdxN54iBEyzqoQuc8gV
alLx+aa0ybuIh3xsjN/6ieB7wGTl/X1pDHvCP1r5DrVku0w96hA=
=C4uw
-----END PGP SIGNATURE-----

--nextPart32874063.EFIeEBKbbZ--

