Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 Oct 2017 19:12:45 +0200
Message-ID: <2676445.Gb182XQt8A@sven-edge>
In-Reply-To: <2908300.Ae86fhuNlt@sven-edge>
References: <20171007121853.6278-1-sven@narfation.org>
 <2908300.Ae86fhuNlt@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2724713.ys3k6x2xMU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Add extack to
 ndo_add_slave
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

--nextPart2724713.ys3k6x2xMU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 16. Oktober 2017 19:07:25 CEST Sven Eckelmann wrote:
> On Samstag, 7. Oktober 2017 14:18:52 CEST Sven Eckelmann wrote:
> > From: David Ahern <dsahern@gmail.com>
> > 
> > Pass extack to do_set_master and down to ndo_add_slave
> > 
> > Signed-off-by: David Ahern <dsahern@gmail.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > [sven@narfation.org: Add compat code]
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> >  compat.h                        | 7 +++++++
> >  net/batman-adv/soft-interface.c | 3 ++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> 
> All three patches applied in 7a1f25d9..0ce469be [1,2,3]
> 
> Kind regards,
> 	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/621c17e76450528c6803c326837917d96388d992
[2] https://git.open-mesh.org/batman-adv.git/commit/93418db608c2d131ef2956aa6c436c8182183184
[3] https://git.open-mesh.org/batman-adv.git/commit/0ce469be3baf302612379995611ae285a886fb57

--nextPart2724713.ys3k6x2xMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlnk6I0ACgkQXYcKB8Em
e0aR6Q//bCxb5pHaAva98BtjCJvX+AB4CFlTrvCmMtccXw/S7Sq4QCB/93PdbfU+
jJf83/Aa4oAHhDZJYfNAHPUdwbMuVDmYNcmfIUSpQNS0oviMzAw8xxYG7m/oaul5
i6rL5vJSfgIe+yevnnbgfY/7DtGWf/vfL+M5WE2fav04YYsqk1FdwyQSogH9Hpii
VtfkLyZ5XqpgjMIpcmdb0spayA83dA9zBPGUYB1AobXVUmoryrddpqfWmqcTaOYk
y2VrNbWYExkIrgjqdq667EGJZ+OLIouD83EOCRAymKPK1b7bGLJ2X/m4yMeUJUP4
pSAIXSl9hm0/ktQRF9uUEBWgS5MN+UhrTviXSNkBnL/YIR1EoztzDwuw0TtTssn2
qKwE6Mur0yOYuMtcJtl9AO7Dh6jTq0u4lEKJ/pmta1hOoOe9efgDHNPkDHQuCMZn
qcodt/QXPRyFEBnJfvlMEg5GvIuewFZ+45fdbVLGu1DylPiFwNblc3Jo8OHs/cIx
R29ffDWA2uQ6xU+57dN2oBM1BVoEieUbTYSYqkU7GwxDJH9EOjbDliiE/gL4NNO4
AUxmI42DCQaHCoZXTuPP6hWlSil86Q8GOhUrLq3DLKmN+wR8aLo0hC2K84TOKtJS
wamjFFBqWZcWxHBo6Y7lWPFGE7e4kd34ScqQJOwJbHizxJKWshw=
=eNgZ
-----END PGP SIGNATURE-----

--nextPart2724713.ys3k6x2xMU--

