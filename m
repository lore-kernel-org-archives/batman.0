Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2016 13:27:39 +0200
Message-ID: <2911091.OSPWlnrdxm@sven-edge>
In-Reply-To: <20160514145129.GD4375@otheros>
References: <20160514145129.GD4375@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart28694308.2fDDb6oY2P";
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

--nextPart28694308.2fDDb6oY2P
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 14 May 2016 16:51:29 Linus L=FCssing wrote:
> Hi,
>=20
> Is anyone familiar with the implications of using kmalloc() vs.
> kmem_cache_alloc()? Not just allocation speed, but also RAM
> fragmentation is something I'm currently wondering about.

Yes, it should reduce the effects of allocating differently sized objec=
ts=20
(which can create smaller regions of memory which cannot be used anymor=
e). But=20
my guess is that SLAB isn't that bad because it already has some caches=
 for=20
differently sized memory regions.

I think we should check if this helps by first testing it with the main=
 TT=20
objects. I've send an RFC patch [1]. Unfortunately, I am not aware of a=
ny nice=20
tools to really check the size of the available, continuous memory chun=
ks. The=20
only thing partially interesting I know about is /proc/slabinfo which s=
hows=20
you the state of the available caches (including the slab page caches).=


Kind regards,
=09Sven=20

[1] https://patchwork.open-mesh.org/patch/16200/

--nextPart28694308.2fDDb6oY2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOF0rAAoJEF2HCgfBJntGQUUP/3ndTHbK6ddvBR9C9pjKVEKn
HtHJGIX3oTG3iRJVcn3GL1WKjg+QTulXaodtQ6iCqOp2GObt6KENIlKlqnhZAirP
NU8f2bEAs3k0xs8pqL2XIkeamUr4KQgWRN1UHudoFfPMGkx67J1Ohko/nrJ9Zm4J
+DQk2EKZiu1BuNermU1VEOgZen6m8rDlZHfrxU+D4obBU5+2i96/z25KxYL1xHJu
Ca0lwrFlNcCMnSrt5DQpyz8OZMC1x+SdORo33cxCt9Cm3pJsUaYb/DyeyFAsY6SZ
/Q5PHsQP3PnmlCjmoeTso5zxEzfwWl1JSRIlLWdfDV1skCakCaHWfkZtK10+pBJP
pfhddf4b0oLyezYb8b2e2ljfIsiT+bNjf2itWQ45NSmBg6NACeEvbs3U4y6i5bFI
/9AXXGRrQxbZ/uVKKyFvbk9fdq2e3wfffF4ySYSuwfo7tihCdVhPJ23gI9Jj7dcb
VhSM83zEz0cPNH0c2/lPjH+IkbQhjVutA8/m+MUS0HH3XGVnQ4YwwsTx3uvET1e5
jQ6XGfXrkucwM5McKq8XujroWfqrPmOjqlKI7bccRR8Q8uHOH3ai7PvPsUpc5Efd
H+YPYtDC7FBLQxWYY9B4bGJ4FdCsId47kwAWuDqTp1y1MiP3XBALj4zli+0Gdro6
DpMtYY+mm3IMdB2FmjBi
=+MV0
-----END PGP SIGNATURE-----

--nextPart28694308.2fDDb6oY2P--

