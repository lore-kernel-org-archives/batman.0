Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 14 Jul 2009 15:38:05 +0200
References: <20090714130926.GM19071@ma.tech.ascom.ch>
	<20090714132004.GN19071@ma.tech.ascom.ch>
In-Reply-To: <20090714132004.GN19071@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1696307.p208tRnbro";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200907141538.10902.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] bitarray.[ch] Linux coding
	style	cleanup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart1696307.p208tRnbro
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> On Tue, Jul 14, 2009 at 03:09:26PM +0200, Andrew Lunn wrote:
> What are peoples opinion about this? Should i spend a little time
> cleaning up all the files? Some code needs refactoring a little, to
> reducing the nesting, creating more helper functions, but mostly its
> white space changes. However such changes can cause pain when trying
> to merge in other work people who diff's are against before the
> cleanup. Does anybody have any major patches?
I am not a batman-adv developer but I am definitely pro cleanup. There aren=
't=20
many known people which write code against the current version who wants to=
=20
merge with trunk. And I think it is better to remove the clutter now instea=
d=20
of waiting until more "chaos" was created.
You should check out the scripts inside Andrew Morton's kernel[1,2]. I chec=
ked=20
them some time ago and they were far better then the ones inside the vanill=
a=20
kernel. I think most of that changes are already merged, but I don't know i=
n=20
which version.

[1] http://userweb.kernel.org/~akpm/mmotm/
[2] git://git.zen-sources.org/zen/mmotm.git

--nextPart1696307.p208tRnbro
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKXIo9AAoJEF2HCgfBJntGGr0P/1gvvtEvspyLpA8gq/NVCnP2
/bAT6/VnzI2l0gcZrBTQd/R7MDmunQZL6toxgAyg45kfBVyqrTA04UNOdjWoqNXm
WmeDTzNjEkhGrqMAsQqJGLZC3Fp3I7sUD/3QaIlc1FpWA5ztV2+xJ8PpXBw107ID
OS8aVWYaujNfHe+QNlknkJZvSQTUrqSrOhtLM/F5/obLj92/nwQHTA8kFHSWSCT6
iPZ/kQDk/j23ztIsVV410Q7tAQU853v3saZWfP38PJLPe9BUxU3pZiVIaF7WE9ZN
7CdTLs09GAIIjbp/5E5s5mJgXRxmq5a5Xqu2mf6xcxjYNBwmwQ1RyhPEIad/f8KK
RTa1o8fLStChG4H93K/Oa//xM8My9a/TEB7A56TqlcT0xg1hGcCyXMBFNkOX6bGz
rJ6ChKMpQmGyPXabkvvdsV7AUZLjg/+1IgRKDiRhUwuLJdYwMaf8hrpv6UzFo67u
dveFFQy0vYnIrwMsurxb0O0m72WyryOuPxHjsPhTzYd9ly8IptE8Y6yEIGkXmizj
7Dh1ut5KB6Ey0xI3rdSmLJA+8wqkW2wWnlrpAFzq2+R6boDKRwrwNN3Ln4j4olan
tqz4Q2yH5Jn1afxIy8x7XGVUcBB0eOPixboXcDEyBh3QNj2nKI3WQylGKpOul3tB
2kqsDzZEz+0eBBYkmLiu
=rsCU
-----END PGP SIGNATURE-----

--nextPart1696307.p208tRnbro--
