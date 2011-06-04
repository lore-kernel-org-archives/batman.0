Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 4 Jun 2011 13:59:13 +0200
References: <1307184038-32426-1-git-send-email-sven@narfation.org>
	<1307184038-32426-2-git-send-email-sven@narfation.org>
	<201106041344.29995.lindner_marek@yahoo.de>
In-Reply-To: <201106041344.29995.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1732458.6WnF4k7qZb";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106041359.15552.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix signedness problem
	in parse_gw_bandwidth
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1732458.6WnF4k7qZb
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Saturday 04 June 2011 12:40:38 Sven Eckelmann wrote:
> > strict_strtoul as used in parse_gw_bandwidth is defined for unsigned
> > long and strict_strtol should be used instead for long.
>=20
> Don't we need a strict_strtol macro in compat.h next to the strict_strtoul
> that we have now ?

Yes, forgot to add that change to the patch.

Kind regards,
	Sven

--nextPart1732458.6WnF4k7qZb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN6h4SAAoJEF2HCgfBJntGBXAP/AuMjJ+g1pMZarzavpZbw0EB
62+FvpR6e6UbWsDPmDl7KMPr10MSK3U8M4kQUqhejVrYUF+xlfTvVTnVnSuGUGkX
LmEdv4TraLwSffWEVcQNI4qw1FRlpuv6WcpKDbHe1PRMaJIe8YVBDjUrbQ9DYT1J
1rRFoiV4aYmDrb4YqFgwSUHwmOGboFnDeZ+Cdv04wBAixUFdKP7H6KQeuYVgq733
uPTcyPFhIbSH5dN5UzM3mhAwiTZywwR0PtAB0Kt+QlrK+7g71EbGgfwS7Vo3R1T4
SprLY/vqrBcYjbBxvqqMH2dbFqfgX4nbe2hl+Rx6iuUBjd2oacdV6/8raGqRAIer
C7p1p+WSvRB1plCsZiv3rRK5oJ5HtHdcx4l8RNQ450zKkgY0CoHeKhfUBgItX0zG
bS/sg5Zn+k296ZzcsnT5Qbf+2N56aOWssXn5w/Ve72slLaaesEv+TF3m+WeezGOj
WRpe+ssI2Las3mBee+fqU8D/qv0rTudsl+ZoAMy1tQal9j0QxcFVSOZbBKXK5A5m
7ek2A9jEcK++flRjm+akyF0s0zH3YcpF+x0qnSXk1jPE2fCY/LOLLj0HCoEHYfc4
uL31LMZInM/X0m1j7iMoVpmY5/0QR0nNA2limwFVzu9Sk1rpO31xT8cinjtVZUzc
wSolpJTlvq9eB6oPywZS
=mFuX
-----END PGP SIGNATURE-----

--nextPart1732458.6WnF4k7qZb--
