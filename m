Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 25 Apr 2010 22:48:13 +0200
References: <20100425165152.GA1577@pandem0nium>
In-Reply-To: <20100425165152.GA1577@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4502828.oQz8DXYucs";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201004252248.20341.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] 32bit sequence number and TTL for
	broadcasts
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4502828.oQz8DXYucs
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=46irst thing: it doesn't compile here :( (UML), but I am quite unsure if t=
his=20
is a UML problem like many other things or a bigger problem.... it seems th=
at=20
it is uml specific as ATOMIC64_INIT and other thingss are defined, but the=
=20
implementation of specific functions are missing... but this is not the fir=
st=20
time such thing happens with uml. Maybe someone with some time can check=20
different openwrt builds.

=46or example other architecture seems to use the generic implementation of=
 it:
 * arm
 * parisc
 * powerpc
 * sh

UML in contrast uses a x86 specific header for it, but doesn't compile the=
=20
actual lib/atomic64_32.c file

I will check if this is maybe gone with a never version of linux (still=20
running 2.6.32 in my uml), but the rest looks fine to me.

By the way, on which platforms have you checked it? I've just noticed anoth=
er=20
problem with copied skbs which prevents the discovery of other nodes - not=
=20
specific to that commit. I haven't finished the debugging of that problem a=
nd=20
will change the wireshark dissector before doing that.

Best regards,
	Sven

--nextPart4502828.oQz8DXYucs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL1KqNAAoJEF2HCgfBJntGeLcP/1HsrBUTAnVoxqnvxLspXWfx
cfaWxIAt79GNhzYVop1zl0Dk0Cvpy2n4W0d6HU/WYsWzvrkVkpFiWYmieCetNMNU
pKRQ9f0AAORi7n9AoOujqb/V9tIA6yYCRutU4RHoZZmb4T2UMiPI+GZuf6DUTv/q
WOmkCi3Ccv2eSBLwkpEPFwhVDskn8+dS90dE1SiNh4XLLviEa4SA9GQNznfHScEM
QcypWgETT30PysifmclMV1lZEFl5J81r/3uYoJ2K1RxyvPnzTCBw5SCTylLIFfzX
1sJwwyYpdj7IN4DZMRrAUoM/zAQNX94cvMwKuWhbqE9Lm6hCbC+dzb3vabjkvhvM
2OY63zhsQWWLW9ohFTOHDtIGC9TjcQBeHqJTWbfhsaKTCWwNXU0VEChiPW2sEN+a
4Dto1xlFdoYwhOzSgEBBWZffNt4odgbr0YHw28sajcF5tM57qxEawLbFv9TOKMqh
aGpXU3aFZ51g/M4kl9k5XcQb0JBBKLXLXcg820VAY1nKHAo+ynl6hY+JntgkFO+g
u3c/0mfv5R41mxQeAuoKwFVwTwZBz/6Co0sqaILaVx7Jxc4JAGEBQ+XIKnHMOe7Q
LRVQapO4Y3BNs6cRBqfzZKjuo0yo6lYwU9G9E+cSsaulJnfXdTf9GD0jCkIax509
CcKx1IKl/okraM18PZwk
=WWxb
-----END PGP SIGNATURE-----

--nextPart4502828.oQz8DXYucs--
