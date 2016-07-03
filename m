Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 Jul 2016 08:22:43 +0200
Message-ID: <3010820.LJPqpTImjv@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2314659.rysgvYOl03";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Copyright of netlink batman_adv.h
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2314659.rysgvYOl03
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

you've created the batman_adv.h for the netlink interface of batman-adv and
you've used the GPL-2-only license header. It is a header which is installed
for userspace programs and will maybe be used for things which have a
different license then the GPL-2. So it would maybe better for these use cases
to have clear statement that they can use it freely. This can for example be
done with a more liberal license like the ISC [1] (like in nl80211.h [2]).

What do you think about a license change? If you agree then I would like to
propose a patch which requires a reply by you with an "Acked-by: ...".

Kind regards,
	Sven

[1] https://en.wikipedia.org/wiki/ISC_license
[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/nl80211.h?id=4f302921c1458d790ae21147f7043f4e6b6a1085#n15

--nextPart2314659.rysgvYOl03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXeK80AAoJEF2HCgfBJntGSGkQAL14+sSR+ABa7gB0P4kzX2+o
wu3Fe0MdSNWSV/0NIkUFgAIcYuNZRFiFzZNdswUvpAvL9rF/qu3JV0IIDRWCAZTd
r+60GjwCAcH0+PhJNB+ninduvtzj9whhbjSEXdpMBKbw65g6zMlHK8NIbjnQEfpf
Zar8LRajOjpjEKtRAFGH2KM3/aNcZEYtGuPxgC52VGfgHKIwutNaG/ijpUc3Kii/
7IJhAlBWqw/G4uDozmjEFenTWFBmCoyUVsBk+l6STLifhtXCB9gAb5oWJWxdNjAR
11YbzoJDB+M3FQ0wAmxq6NYq4LhxGJcX1oAK8ewrWtaZ26BbxKkoZIxp7GwCjsma
BYwUyb2TVTQqPCB1kTbIQpg1vpZxRqGofkLUNEQRg90WqO8fddiixV1c9RUDx459
0vW4IZCxx3S/ABx/O/V4AGcWbq/KDvaX+we3B+eliPtbFxN6kX87H3SbghKiyEaS
ML1R2Af19WIq+/V9TyjRH1MdDI5LUp2X0o11zTlrOob9BX6rB2okuP7Pb2fr0Hpy
p+IY7UirQLidkVhTpMTVX1MWsGlDHeUYaZx22AqOVxB/1f9DSTBhBEurpZME1NDn
DCnd1ooetiDCr71klN38YNAoB1P2WmWQP6ftAhRVxQBLdzrt2pOYNho5CxNWtMCM
IjkS5U2BE55wEEXnlucR
=sCXQ
-----END PGP SIGNATURE-----

--nextPart2314659.rysgvYOl03--

