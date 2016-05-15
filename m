Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2016 14:15:01 +0200
Message-ID: <22866212.dooYpi8Uhz@sven-edge>
In-Reply-To: <20160515120626.GG4375@otheros>
References: <20160514145129.GD4375@otheros> <2911091.OSPWlnrdxm@sven-edge>
 <20160515120626.GG4375@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3397084.R1zBKERJzx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
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

--nextPart3397084.R1zBKERJzx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 15 May 2016 14:06:26 Linus L=FCssing wrote:
[...]
> [0]
> https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/km=
em-cac
> he

This patchset has a bad bug. It still uses kfree for tt_local objects=20=

allocated via kmem_cache_(z)alloc.

Kind regards,
=09Sven
--nextPart3397084.R1zBKERJzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOGhFAAoJEF2HCgfBJntG0zoQAJ7jbM1oKiG7ZJ8Pdz3qQdaI
8xgcyyQRNnvRzpq+Gg7sEnyQ+z64b/jo5l6L824pJMan1IjpcLlGtSEvqdx3scgl
So3cMPplnTDtaBp7+a+MbAdKxR3zMKbe8CnWp0xIRIJh+7oGaKX9no1pjjaCcmGL
yz85XDsIwNdnKsyJdWy3HnQM5/6umrhT+uVOJBC+kiP/yNIZ+k0YOAZLFq88GWD8
nawBPzBnIaSzCC2OhlujgzY9tbVNaB/D7fJRxI4TBLLtjlhF2rbAsUQ4gjc80xrK
moXWGQJApg+Jfq7cDu8T56hAznMY3Fixrx7ggk9ieIJeDdSLklRW2FPN6s5TRevV
tWDorCydDyujXGr0NjaY7mI5VpNzk+6THCeiQiIqDJP08kF0sIsMnaaB4afuZszG
zk3VJMOqsNTg1c7sQGJ48IEMG46cIpl6uFR4+9VLbT96sIdNsDmP6WWRxBVIFMer
/084GFtPxe5q97aJ4wgvoK3XnrvGSc3QoTSI+SvVnedl8BHjMxkep7PFbSLv7pQ0
XSQWQpdLsFV26Of7iU0dlNZ+GGRbEXXgKd3noYmEOqOxu3b0id+xmudTfghZEWWw
JJfc/3bpyh/PFUDYpEduuPtM4EiglHGlYsTs6Tu1ZbDExl37ICzowX2hg+YygluJ
Q6rdfHs0HrCUAKFGjcbS
=+LQR
-----END PGP SIGNATURE-----

--nextPart3397084.R1zBKERJzx--

