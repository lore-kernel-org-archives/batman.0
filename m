Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 04 Dec 2017 12:59:23 +0100
Message-ID: <6784418.ciu8HoDoe8@prime>
In-Reply-To: <20171202074559.3582-1-sven@narfation.org>
References: <20171202074559.3582-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2153741.zO6c1yocZh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Handle allocation error in
 vlan_get_link_parse
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

--nextPart2153741.zO6c1yocZh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, December 2, 2017 8:45:59 AM CET Sven Eckelmann wrote:
> The malloc could fail and return NULL. In this case, the processing of the
> current interface index has to be stopped to avoid writing to NULL (which
> would cause a segfault).
> 
> Fixes: d29288fe0583 ("batctl: implement vlan-to-link helper functions")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in 2ea390c.

Thank you!
      Simon
--nextPart2153741.zO6c1yocZh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlolOJsACgkQoSvjmEKS
nqEjjxAAs7pXzJj5Mnw5Ydnl1GlPR5WMpfHcWTZjyEUfy3N/fjczawvuhEoTezK5
AYbVE/gPCr1PQwdklEuuvUpE7lQJdHVTKDbZ+xo5QxOiwlo96ooqzDBb0JP45X51
kH7MNQcxdFuVWmxrG6137rOWsrA5QFHThihe6GVGfNm1WS2SKQv63jEno8XimI9t
qpCS0gozJV7wcPEUQhRyZtvoq3B4Itm0ni8RVAcdbe8ivSRL2xhRoPbvSiMeP6eU
ICI1cQ48uHixTVbsKwN/0NVU8MpZjy0mGUDQV5i13pQDiCkt73MOJBwCluFBUIYH
Qu3yOkgYVQ8Jw3zZWw8h4EsGjX3AtGb2FRupBtW7s1KzBNTbm1dcIyG65nh3/YMM
6NEsrXq/1JW1qGIhI05AVRQbuJq9OJyNd0wvTohAY2HCn50MXyoB9KJPjH4iiI3h
hClxwW9ASEeFM7QEDMXLQf3EZmg8FUAUSuQNYksu6hlNb/QX+bfsAG9kTr9hfxNU
/+Jt8ZJI1T1/44FAjCRInfW137s3pj9R+xv27uFn2HP/PwY5paNwKOpzhIk0pzPg
N6z5+QgqrqA7erh5Qh3MthW+kDYBOxuD+NpgyZcAWFsNEEWjPIlDDfGkWk6t48mC
Y2oI2/179ZOTQDCPnboJ2lJYmt0w9cnwOmy/PnVjhepVKC21a1o=
=LJHL
-----END PGP SIGNATURE-----

--nextPart2153741.zO6c1yocZh--

