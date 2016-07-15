Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jul 2016 22:54:02 +0200
Message-ID: <3799253.h3yhEookLG@sven-edge>
In-Reply-To: <CACgQMVKA+UMo7CJZdWkojWqrx4urrK5oUxzXS1wonUcEtdRDQA@mail.gmail.com>
References: <CACgQMVKA+UMo7CJZdWkojWqrx4urrK5oUxzXS1wonUcEtdRDQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2013430.yzI1P6bX15";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Mesh speed comparison between Atheros and
	MediaTek
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
Cc: Dirk van der Walt <dirkvanderwalt@gmail.com>

--nextPart2013430.yzI1P6bX15
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 15. Juli 2016 21:41:53 CEST Dirk van der Walt wrote:
> Hi list,
> 
> This is not strictly a Batman question, but I figured that it would be
> a good place to ask.

Is this device only using rt2x00? Then a good place to ask would be linux-
wireless@vger.kernel.org + Stanislaw Gruszka <sgruszka@redhat.com>, Helmut 
Schaa <helmut.schaa@googlemail.com>. If this device is also using some more 
recent wifi chips (the ones supported by mt76) then you should also contact 
Felix Fietkau <nbd@nbd.name>.

To make it short: my current tests with different hardware from Mediatek/
Ralink was rather disappointing (currently unknown what causes it). I had most 
of the time rather low speeds (also in AP mode). But I haven't tested and 
cannot provide any insight.

Kind regards,
	Sven
--nextPart2013430.yzI1P6bX15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXiU1qAAoJEF2HCgfBJntGMCQP/3F6VS5pFGOUnYPdMly1z6cd
eL6pug4Ukab36ZXPA6p5cvvybM+YhESI6EZ/r9j83mjmiZhKWdgs8y3GHzO7D9Nc
K6MJ/Xy0NfUMogX5s91F0Hy7qzRq/nNRR2HArXh5ro0ZRe6Csn2h4ilqaILUqMqv
04mLhJIczocaycJeB7TilhxrcJl4Bnjf7v40NEXCduGJKWR595l47ciE7OXC7Slc
N0Nj+Z60yxIZWRREB24JuPADcLS0vP5hjt0CpCoc1TZFyx8o0DKVHdfXfVyjw0+z
pJYgYO31ptbK42w6Kn0UAQWl2b0qkVe0ZU5Lua+AHWMZXorcHUfiLat0BcXlqvHy
qIeM0mTYVE79PhNzayvaBu/PCeE0tmwMBslR9VzEzUIlNspnltgeA95DtTbOrEbV
SpU5+pjQDz8wHm1JP8hfabLFucktznheh7XBzadIF1VwYuGB1/UbAi3bjo8LyfK4
LcXVShNyKDi/unbHtCAmXGroAnMFQa/QyL42g/I7LkAOiwQPe2usjBWWUvHzYvX5
AL4yrmaENZpTyEV8/Q9TrYh+T6RqlS6WvT1oewCcQkKubMEnRbmIw2V85viqztsH
866/BLM3D3vjSyjTjM4sf3lwwogh5uvUT06EXQKSQYBmnQVKA63yU6sLIEGD8MA3
/kKVbGQsZfGiSqzEFwsI
=rwXA
-----END PGP SIGNATURE-----

--nextPart2013430.yzI1P6bX15--

