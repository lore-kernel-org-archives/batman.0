Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 5 Oct 2009 23:24:52 +0200
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052201.30645.lindner_marek@yahoo.de>
	<d9bba8670910051354i1039f6f7x76c2467032f68db2@mail.gmail.com>
In-Reply-To: <d9bba8670910051354i1039f6f7x76c2467032f68db2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1626401.fY1nk8O2RK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910052324.55426.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
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

--nextPart1626401.fY1nk8O2RK
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

a wrote:
> The ping with 1500 byte packets works.
How can you send 1500 bytes packets with an mtu of 1476?
Do the test with `ping -M do -s 1472 IP` (this should create an 1500 bytes=
=20
packet and disables fragmentation).

> The three nodes are connected in this way:
> B1 --- batman --- GW1 ------- EX1
> eth1 on B1 and GW1 is managed by batman. eth2 on gw1 not.
> The IP configuration is:
>=20
> B1:
> # ip a
> eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
> UNKNOWN qlen 1000
>     link/ether 52:54:00:00:20:01 brd ff:ff:ff:ff:ff:ff
> bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1476 qdisc pfifo_fast state
> UNKNOWN qlen 1000
>     link/ether 00:ff:ad:e2:6f:dd brd ff:ff:ff:ff:ff:ff
>     inet 192.168.100.2/24 brd 192.168.100.255 scope global bat0
> # ip r
> 192.168.100.0/24 dev bat0  proto kernel  scope link  src 192.168.100.2
> default via 192.168.100.3 dev bat0

Best regards,
	Sven

--nextPart1626401.fY1nk8O2RK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJKymQkAAoJEF2HCgfBJntGV3QP+gPOgLOPBre20yutFbutRXMj
dcJv/UaFgglkluZggloXQegetjY2iT9fQPAxObdcuZgwAla9zf1bZlbYL+82xzsW
E095UsSaGm1Y3CjPBnifUHcrxgdKK1MVON2VsPEAZEOqAlUjJ+xM+/4A3iD0v2go
mUB84aDZq6/IU2NH2vKGGDTkFYe65Pmw5QSgB7FcCiPKpzMhMAJBfj4YOaQbY4Dn
aP9uQDeqeWCmdg07sVOzNjXQMAivjZNUXizy0dJGewEqlUqk8tSFlVgb0RYa6rot
0Dl0rzobvFCp+XyrOlAGHc7tEHf02KbIhiNxz8HJ1nKUq72Om8koRQkzxPAITPGY
lg1OYVXUwR/DXk5Oa0je7WgEUpYSnUnpgrNySy3S03QaW9DocFO1GJA+5yAQ51Pq
VxBUNaTPesZ5Q4x+nlQw4UbjBxLQJ5GVDLE0O5KU7BCiE74wLBrrWKcVGEq3nvz+
cVnGYY/SkYpv0sTMUZ0cCHxmHIS9+ODRAFPAtItvBQ9dU5nxggjMAHljv6VCZi1b
Izm/gYJbefkjvk42hdF4dxq77GcVOpOYqsJuRzgROIhrJwPISxaV3AQAIyhLINdL
dhYIsJHdqZUVSJlFhBEVkK77J5clQhHYpbJfGc1W52/jdItG1+q5m5NO49rKl2iM
42WlepI2J7k7KKpu+LI6
=UC4N
-----END PGP SIGNATURE-----

--nextPart1626401.fY1nk8O2RK--
