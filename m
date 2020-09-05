Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH maint v2 3/4] batman-adv: mcast: fix duplicate mcast packets in BLA backbone from mesh
Date: Sat, 05 Sep 2020 09:14:18 +0200
Message-ID: <266559078.Ph8ahLCQK0@sven-desktop>
In-Reply-To: <20200904182803.8428-4-linus.luessing@c0d3.blue>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue> <20200904182803.8428-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1634379.hfMa9LtLtK"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart1634379.hfMa9LtLtK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, 4 September 2020 20:28:02 CEST Linus L=FCssing wrote:
> For DHCPv6: This is even trickier... DHCPv6 potentially uses
> non-broadcast multicast addresses. However according to RFC8415, section
> 7.1 it seems that currently multicast is only used from a DHCPv6 client
> to a DHCPv6 server, but not the other way round.
>=20
> Working through the gateway feature part in batadv_interface_tx() it can
> be inferred that a DHCPv6 packet to a DHCP client would have been the only
> option for a DHCPv6 multicast packet to be sent via unicast through the
> gateway feature. Ergo, the newly introduced claim check won't wrongly
> drop a DHCPv6 packet received via the gateway feature either.

I don't really get this part. Shouldn't it be the other way around in the=20
code? But I haven't the time at the moment to check  the code - maybe we ca=
n=20
discuss this on Monday.

And I would also like to ask Simon to check the BLA patches before I merge=
=20
them.

Kind regards,
	Sven
--nextPart1634379.hfMa9LtLtK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9TOsoACgkQXYcKB8Em
e0YYbQ/+OLgyG3CceXOO3AZiVvLzOwlvcjCnPMag4hhRJS+mzyIg6qP2rpuej2HH
BjT+o/3I96FMfkeNvEofFNmyNdZVD2pq9MvQJxBqlg6Ww78jHnYMJ9SU9ZmtnjgM
IsoGtW/s5dtl2qvI63yUI+DxXEWH78X6QKGIDlUdtxVAopHnn/BnC62eMtleC5ug
VNbJlO4f+Fj3jUBZmTqdoei/QYdHqw4GxHt+89DBdBS3uHasgugd9Q7aQUxAhC74
t01KrqlL+LtcM9uz+9yGCwoLqtWSncY5ie6c2t41SHtsRq8YlYObuNUyZFcoyVsU
1d6cl/icgfveNvmiLbbF6V5dsaTTUKgRaG2T3gXz2bkGsaHCauCzBmrR8JUpf9fo
DHsSeHgPKaBv8ZyVtHGNi9nDGCiL2FigtX8Ujlz4BDXymrahiXmbzvh/Rw2sQMH+
2kTi0yZBVBmxLW8xRZvRa9cjmbjPEke7D5e6RH89EtMye23ZLaFcLSoqc7AOKA1q
y2S3FxyHL8VEOJ45dC1ZYxYcpbY8y4j92Z9EyGH/CyLaGa2NL5EOb6JoHcJlEX+Q
LqfX04sN6iPVGJ1Kk+x0KTsrBf1JDVZqQO6HLxwCV6ZCR7ywOEnvX3IyJhWQwKEB
K+H4yYmjUKRuLVavIi0EKhw7XiwZYa3qLJMBf41DjKNoxI31MfM=
=7Ump
-----END PGP SIGNATURE-----

--nextPart1634379.hfMa9LtLtK--


