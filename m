Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Nov 2016 08:14:58 +0100
Message-ID: <2867028.pt44pYxOGK@bentobox>
In-Reply-To: <20161029071843.4614-1-sven@narfation.org>
References: <20161029071843.4614-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2308367.dNnyZv1ROQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [maint] batman-adv: Detect missing primaryif
	during tp_send as error
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
Cc: a@unstable.cc

--nextPart2308367.dNnyZv1ROQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 29. Oktober 2016 09:18:43 CET Sven Eckelmann wrote:
> The throughput meter detects different situations as problems for the
> current test. It stops the test after these and reports it to userspace.
> This also has to be done when the primary interface disappeared during the
> test.
> 
> Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/tp_meter.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in 41af4814a81c0ff3c228f130578347b2f77805e0 [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/41af4814a81c0ff3c228f130578347b2f77805e0
--nextPart2308367.dNnyZv1ROQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHDVyAAoJEF2HCgfBJntGVrUQAJx7mhkS4F+91AZsn7to/YkJ
nKTHTm9nsgW2hVkFzhop/PQVxn7AZ+V+Rii9TpIubbZgLcsU8u0vZ0yqfzmkgntc
21L8yyGPieoEdK885sQb4coRNA2GjVJvB0NRt2wUXYVXPfNlYGGVqIcafheDH0eI
O5D9donNOTFmbd2ZCOKX5sdm07eyO79KeqFB2JyTIY3/Qmp33jtghbEgD58SK7Ni
hZRj4BijBFYHFTLsin59NFnelmBw2FiMUtywdZfm3OofOEfO0AjVjLvS1y/yBNji
Tnl3bsHBEhj4wrKDd3t6OohNOLE9Wb/6YsLWXSvxxNYyjqBlNXw3CzbEF4OsZPhu
a+GQ/FMY3hj0vCo0fyzxMAArNnyx/dxAaMFwCWosRx651uw9CJvIpWwqAXFDvWXs
Kqon6WXIgyDjQ35RZpWcyUqcoo+pQf3Yoqzb8t8ICMO+U5upKypp8rHSX+TvBHe/
wWWc7zDtnvhCtmTfYD9EA5T3VPjEYu5V+OoVBmshVK1PsNH3vmpnOdNsoF7qlgtK
wH38JPSWtG7KtdWfYEUUgx34CbQseHsF8hGj743nancdWpJdPfTlDeWMJpTGE0V1
fFdyfV5BoHO9kezCogvFz9RQXF4UmFALZaLjuRnm272Jx29yRyD8Ke2GvcFmz9GS
4bZmzFJw48iHwlpyRuTp
=k6jU
-----END PGP SIGNATURE-----

--nextPart2308367.dNnyZv1ROQ--

