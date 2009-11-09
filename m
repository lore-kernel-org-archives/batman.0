Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 9 Nov 2009 16:26:18 +0100
References: <200911082144.49637.lindner_marek@yahoo.de>
	<200911091608.44365.sven.eckelmann@gmx.de>
	<200911092313.08777.lindner_marek@yahoo.de>
In-Reply-To: <200911092313.08777.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1614535.Daa2rKn9SR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200911091626.19190.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 released
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1614535.Daa2rKn9SR
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Monday 09 November 2009 23:08:27 Sven Eckelmann wrote:
> > And if a router receives a to large IP packet is should send an ICMP
> > "fragmentation needed and DF set" when it cannot be fragmented by the
> > router.
>=20
> The problem is we keep the payload on layer 2, so that it never will bubb=
le
>  up to layer 3, hence never emit fragmentation needed (we even might not
>  have an IP address). All you see is a hanging connection.
Ah, I think I misunderstood him. My idea was that he has meshA and a meshB =
and=20
between them is a normal router which connects both. In this case it would=
=20
work - but yes, he probably meant one mesh and only one connection is ether=
net=20
cable (or many of them) instead of a wireless link. In this case there is=20
nothing like a router which looks at the layer 3 stuff.

Best regards,
	Sven

--nextPart1614535.Daa2rKn9SR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK+DSbAAoJEF2HCgfBJntGnG0QAK0Ez0c30SrXYbg09zAkjJOe
4KCkC2f6ssIQmCpRwgz2e7BN+4ZLNSaehLrpVx174dTZnYKdjUzbjspgYouKrwdX
3rulR/BgF+4xPgZ7hUfKmjLfkrf253WgdbPEWunWZ8cOWVk5i5tchl+EB+nhzg7m
6BchXJApYQzUFAAzNtJr4vjoeGZexviwmwE4M6S+vvQosn2FlVSpAg2jmtbBXiV6
lnYITRteqZbypegAUpdnzUq3Vk8EFGCJ2RjUuqDHm61iNIqZGw8RQPmkRO/OKiTb
9W14t68bYzSiJbVLTxRJ3bpwrYq13XZKE8d005LWgLjfABssJmWCq60lcRT/jfNy
hxfdASByRe/197sbjxYuRJqT809oheDHmihJ4A31e1Pertz3dYa8Y8iMBj1+pktu
qH6q48ij0mrnf64HKZmE61qD+NiYjh3Lyoeyq93yweNk+opT09JpBofnXAv9Xg8Y
RoQnNJqSbm7tRFuHFN8Jgrd23/PeaVyeAQ6ki2UXkkOF+LrRgfUB2wW4HWbnq7wj
fSDnVu8lHJtZXVW3gpdTQaBOueWbKr4h/15vK37Lgu0rORtZjz0CuK4j7SdedOdi
djLvX9qrz2CWbtwPQv5NnSxy1648Fp0QFAkO4Fv1ZSBzvwXXFEM6T27ql64qnjqW
huFojC3doqeastqVMQRV
=LmBA
-----END PGP SIGNATURE-----

--nextPart1614535.Daa2rKn9SR--
