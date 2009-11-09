Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 9 Nov 2009 16:08:27 +0100
References: <200911082144.49637.lindner_marek@yahoo.de>
	<591bc9930911090043mf62cd17tac8033d316002a18@mail.gmail.com>
In-Reply-To: <591bc9930911090043mf62cd17tac8033d316002a18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2858228.JTBSKGMhpM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200911091608.44365.sven.eckelmann@gmx.de>
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

--nextPart2858228.JTBSKGMhpM
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Donald Gordon wrote:
> That's really exciting.
>=20
> I have a feature request -- has there been any consideration to getting
> batman-adv to fragment ethernet frames, so as to get a 1500 byte MTU
> batman-adv network running on top of a 1500 byte MTU ethernet network?=20
This would mean that we have to add extra information to find which parts=20
belong together. It is also needed that we buffer everything and put it=20
together if needed - so out of order receiving of ethernet frame must be=20
possible. I am not sure if we real want that as other protocols running on =
top=20
of it should do that work.

>  This would be a useful feature for people trying to reuse whatever random
>  ethernet networks happen to be nearby to extend their mesh, while not
>  requiring the mesh users to all configure a lower MTU.
Most modern switches and routers should support 800.3as which makes it=20
possible to use a larger MTU on ethernet to connect two meshes. And if a=20
router receives a to large IP packet is should send an ICMP "fragmentation=
=20
needed and DF set" when it cannot be fragmented by the router.

Is there any tunneling protocol which support ethernet frame fragmentation?

Best regards,
	Sven

--nextPart2858228.JTBSKGMhpM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK+DBsAAoJEF2HCgfBJntGBIkQANLp3tbN0HoOSztvc2p8+7Tb
2sYygBTYuObS/aitMU9CLRIhrro6ZOqJcNiTpx/R9N3ZWLd+WcMAvJFcyfCwj5Ko
wYYeHvbnmZ/D6aoEqGvnBEDX4YuGWxHN6VH9CadXv/WyYOypgOjSRcGoFtA7E+D3
PXxwAIwUQdOOf3k0DBEAy5RPqaJ3p1530JCdzBCsEWJPuFLldqF8RnT40wtoHPU/
7p8QLcDKfLHovCTf9HG417jL32A5xsk8RskW0l0XdzuiZbmnhIRvHel9YeClbur7
/iUOhwZUKnenx4c2qaYiUm/jEuZgfeDO5QVF0oJJzPG1D36RjfkM1IzUPBuCChIV
8uhtqgyZwQlehlqh2TRKw+ec2xGQHZE/fbVjHi6L5lGZRD51yy0AJ52fYJX0LvvX
q/e4Q+4JSmwfWf3a4Rm99JQoKtWuOnBj4UFZUCHfi/Q10Yjg8a2xHag0KNZPMSGa
KK8nnRHrm+871925QS2m83cZMDcl7PiKt9TmCOoTUPXWnIyss9eV35EsI7KIKs1q
4FAB2JrmzR4xj17/+VaR6H+UnTVFCIRQlfYhpSoDrRrgcKkoTZt+PPDoTpt/3t2z
yLN33Mch9hTJq5EVVlw+MIXBrKLQ9BJiH/MBAdJySjf3k2YxBBHNWVDh+cRGaneQ
bDMgTrY3giyUuXCHoqxp
=CRu6
-----END PGP SIGNATURE-----

--nextPart2858228.JTBSKGMhpM--
