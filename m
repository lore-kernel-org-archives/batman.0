Return-Path: <ben@decadent.org.uk>
Message-ID: <1341111847.4852.71.camel@deadeye.wl.decadent.org.uk>
From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 01 Jul 2012 04:04:07 +0100
In-Reply-To: <1341003484-8457-2-git-send-email-ordex@autistici.org>
References: <1341003484-8457-1-git-send-email-ordex@autistici.org>
	<1341003484-8457-2-git-send-email-ordex@autistici.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-HUzUZMH/KQwLzHv6uKnl"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2 stable 3.2-3.3-3.4] batman-adv: only
 drop packets of known wifi clients
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
To: David Miller <davem@davemloft.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, stable@vger.kernel.org


--=-HUzUZMH/KQwLzHv6uKnl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-06-29 at 22:58 +0200, Antonio Quartulli wrote:
> From: Marek Lindner <lindner_marek@yahoo.de>
>=20
> commit 5870adc68fc39d81089f1e80efdf64b97e5c37a1 upstream
>=20
> bug introduced with 59b699cdee039d75915c354da06937102d1f9a84
>=20
> If the source or destination mac address of an ethernet packet
> could not be found in the translation table the packet was
> dropped if AP isolation was turned on. This behavior would
> make it impossible to send broadcast packets over the mesh as
> the broadcast address will never enter the translation table.
[...]

Are you OK with this going into 3.2.y, David?

Ben.

--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.

--=-HUzUZMH/KQwLzHv6uKnl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT+++J+e/yOyVhhEJAQoJ3xAAyA55U92YBXJTlrtJpKkSf6RAxV6XpSts
pAwujrFDoEFwSjnTVjcOopLmjHn5p6Tywc4tp9C6yAYlx3mb3PbdtlhMvZ2yVHLM
aV8KNV/XAWY62GfRAcrdV+8Q2x/bEKOxhDEUKY+iD66AIlp2cYnoMFS0r1yCIyaJ
KG5v3AoBVK9HZ7ROapjOrh0FofwzJuV++ofzwRe6YbN3cP0kzL/qcie+zbr6u0rY
yN+Sx4o+1fMydumuRnKc0HTt4JYIEzC2vLdIVobS25M7unpG/0Bnw6AtjXo5NK70
ZSd1lP1sLBwgkjbZf6FbGQXbgnZneZTQn698MSwY4JdXvQXm0q/fbj80WRmykbz1
ZONfuJ3D9Za/uVnIiwmcnct3sgG9xHY1mppYwRb1o0U+QT2MELt4IaG0xI49Zafs
bZyKzq6p8spw67ONxANPdu2L4XEcO/f2ALtV0T21R/Mv1zf33bLGBGhOvlRJ3J4R
2Sow2V+DQ8jtEJj/m8TGbuaOmuPPxdiEFNhTQ2okUptQ8xYzvahoAbRYfkF00Zpl
EJ1wq6lsjDeMvkjX6bCpWeUMpT/mZUzOsIw/qyY2dnUlvwZJMEy3hQBXakRXrH76
G1kBwkN4PgE0LxdPFsfJ4OPbMR9n2aZNTFkos6c1NgT8Ul6wvHf7GK6bEsX9XQPl
+dust8bHsYI=
=qzni
-----END PGP SIGNATURE-----

--=-HUzUZMH/KQwLzHv6uKnl--
