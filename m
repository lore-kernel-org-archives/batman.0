Return-Path: <mpa@pengutronix.de>
Date: Tue, 2 Dec 2014 17:22:25 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20141202162225.GA30436@pengutronix.de>
References: <3895904.RefSiyY2EJ@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <3895904.RefSiyY2EJ@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 30/31] batman-adv: packet.h,
 add some missing includes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 02:03:16PM +0100, Sven Eckelmann wrote:
> Hi,
>=20
> please explain how this file can now be used unmodified in userspace (bat=
ctl)=20
> and kernel. If it cannot be done without modifying the file then please=
=20
> provide patches to modify the daily checks which make sure that the files=
 in=20
> both repos are the same. I think the batman-adv developers can give you t=
he=20
> original scripts.

I added an ifdef __KERNEL__ around the includes which should work for
the userspace.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUfedBAAoJEEpcgKtcEGQQ8a0P/iPg7FouQVJzb7Tl8OC7g7nL
UfMlxqSar0gn5/Ry6LbAZgirZhaHKD4I3wRv8pOLkREdYfb2uys95enhtEyFI9wI
zMywTwcEbI5mNYIZbXH/heOnKA5UOusVXMj5K4DrpvpfVZ+iGKdNiRPsd+O9iG6C
x85rjHRh/Fkc95yp/kNXdKZWE7G1OThBIpWj/TCfKeAhRCKTB+W9Xs+pTE4sQatV
xPt1aNquzcl8hZkwFSfDykjFSmcNsidDUhUpKn55oIyITjIV+Z18U+9CG4p89HNr
F8afL8LCemeUZ+UWb9Y950WK1PcNiuDFDKjGY9kcOaDezGEj6mBnFpVGWy9/PhC6
QuVngd+qXmqeo9XK6BULaUJE6/iozXEkCxiPNPE6hDM/KS/pxI3OkOBUmTpjsx/8
wj7a8cvUWZqHzw89b6klZAWfk+kgdAD6yyovT3nsaYw8fDwCWCUYVaNq3F+o7Gjj
/ihB2PeFgZ4J9eyH4hPFT4ZRI+yK35gMktkEXRSn/ODBV0wU1FHrW+YBYrA3YkGF
WmxljjTZMCgbatE9o/9+UCcw9N9VAso1T4CGUtaQvlpNqUbMfdWvJXJGIvnf5us8
oYRidKDSsZOrd98X8hqpHtHEUfK9/MIhgHQJTiPinMBhNyEVqoeL8DQNLZVo2Oj5
8VUjUiaGGyoT11Uk/V+F
=dfHI
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
