Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 26 Apr 2010 00:04:25 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100425220425.GA6389@pandem0nium>
References: <20100425165152.GA1577@pandem0nium>
	<201004252248.20341.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <201004252248.20341.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] 32bit sequence number and TTL
	for	broadcasts
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven,

thank you for your review. I've compiled and tested it in my openwrt qemu=
=20
build environment, which is built on linux 2.6.31.1.

I have not checked it on any other platforms so far.

best regards,
	Simon

On Sun, Apr 25, 2010 at 10:48:13PM +0200, Sven Eckelmann wrote:
> First thing: it doesn't compile here :( (UML), but I am quite unsure if t=
his=20
> is a UML problem like many other things or a bigger problem.... it seems =
that=20
> it is uml specific as ATOMIC64_INIT and other thingss are defined, but th=
e=20
> implementation of specific functions are missing... but this is not the f=
irst=20
> time such thing happens with uml. Maybe someone with some time can check=
=20
> different openwrt builds.
>=20
> For example other architecture seems to use the generic implementation of=
 it:
>  * arm
>  * parisc
>  * powerpc
>  * sh
>=20
> UML in contrast uses a x86 specific header for it, but doesn't compile th=
e=20
> actual lib/atomic64_32.c file
>=20
> I will check if this is maybe gone with a never version of linux (still=
=20
> running 2.6.32 in my uml), but the rest looks fine to me.
>=20
> By the way, on which platforms have you checked it? I've just noticed ano=
ther=20
> problem with copied skbs which prevents the discovery of other nodes - no=
t=20
> specific to that commit. I haven't finished the debugging of that problem=
 and=20
> will change the wireshark dissector before doing that.
>=20
> Best regards,
> 	Sven



--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvUvGkACgkQrzg/fFk7axbN1ACdGrg74Eo3hzMXgIxCVcOYRxfK
zB8AoJLSt0GGW5yyECynqyYpvW99TTsv
=qbks
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
