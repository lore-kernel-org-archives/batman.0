Return-Path: <antonio@meshcoding.com>
References: <1437991098-22983-1-git-send-email-def@laposte.net>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55BFC6AC.5080308@meshcoding.com>
Date: Mon, 3 Aug 2015 21:53:16 +0200
MIME-Version: 1.0
In-Reply-To: <1437991098-22983-1-git-send-email-def@laposte.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wNrROe7Sls1GqBxHeWf4NDuepSWj0Cpqh"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix batadv_compare_tt
 function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wNrROe7Sls1GqBxHeWf4NDuepSWj0Cpqh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Def,


On 27/07/15 11:58, Def wrote:
> batadv_compare_tt have to check vid.
>=20

since this is a fix and has to it go to the net tree of the kernel, can
you please elaborate a bit more about what you are fixing ? Not just on
the implementation level, but also from an higher point of view: i.e.
what is not working ? why is this fix required ? (you can also take
inspiration from what I wrote in the ticket about this problem).

Thanks!


--=20
Antonio Quartulli


--wNrROe7Sls1GqBxHeWf4NDuepSWj0Cpqh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVv8awAAoJEOb/4TMchkvf15sP/R7GHTjFdIk7DJfZ7p2KnmsF
tnv3sLa7xzepeFH+IXRd1szU5jz96tseD6IwD8kkhp1hZbBvGn/FFdtiF1rDVcav
V+Ycdu2Bm1wpNgucd7lqHAHe8l9aPtrAOkIJoHdJrijw9B5FgR2qIx5cS1toqA5N
igl9V1BmcT/NEHPMfTvVZH/E8R4TV65j3C89QTMDmOjOKdIwjVpEft1Ca07opZ09
mDEXVHWGSzpVGfQEDyi8xx/ZpxOVDTgwU21426Re8iTSqFlugGWIosPf3Kp2ER5S
RYqjbvomcAmJePdq7c4sdgqSrnLbUQ8xInOi6rkm+8yfcjI9yz+qq5Zcez87pLqn
obX1TTQgYvkDJciRUnzHZOOyYCAzbg5tt0FzS5P6uv/WHCvVFL5LGHlT52P3KRG0
pTLHzksZJyR87NkLKFVXB6plvqdNechX876lt39mOUZvR8LIH/0fxbpxeQbK7X3h
UIrd+/FYISGDoSZwcHoC/yNuPvgtJ6r8w9xVzEONk9qKbhXvx6DDhNIiVV0N4I0z
B8Ntm5pcrUO9AHvSX3eyK4ztSwXYUz8T+ljH7lNMJ9T/BL4rV9hQ8ZysfKVhroj3
77P/7D5o5mCn82wkcErMh9cQgyVEJB84QwIXnDdYggF7rF2pxakWisG3lRRr6rM0
aADfIsfp7VjYM5RiH9ho
=MJr/
-----END PGP SIGNATURE-----

--wNrROe7Sls1GqBxHeWf4NDuepSWj0Cpqh--
