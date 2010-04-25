Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 25 Apr 2010 22:08:27 +0200
References: <201004252136.25395.adebex@gmail.com>
In-Reply-To: <201004252136.25395.adebex@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1545683.Qkndv9E5D2";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201004252208.35822.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Security & node authentication in BATMAN network
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

--nextPart1545683.Qkndv9E5D2
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Adrian Byszuk wrote:
> Hello,
>=20
> I'm currently working on project (part of my Bachelor work) which will use
> to transfer very sensitive data over the network, and I'd like to use mesh
> networks to transfer this data. Additionally, it should also be possible
> for "normal people" to connect to this network (e.g. to surf internet).
> Preliminary, I've chosen BATMAN to build this network. But I've got a few
> questions regarding security of this solution:
>=20
> 1. Does BATMAN provide any method of *authenticating* nodes?
> As I've said earlier, sometimes transferred data will be highly sensitive
> (for example: information of patients health in hospital), so it's
> absolutely critical to not allow leaking this information. I can imagine
> situation when some fake nodes claim "Hey, I'm the server collecting this
> data"... I think this is also important when someone would try to destroy
> our mesh network by placing some fake nodes in it.

No, it doesn't provide any form of authentication. Normally this should be=
=20
done in any layer above batman-adv. As in other network setups it is possib=
le=20
to create local blackhole by a node which says that it is the perfect route=
 or=20
that he is someone else. Maybe Simon can give more information about such=20
strategies.

I would say that it a good idea not to allow other nodes to join the mesh=20
directly if you have mission critical data send over it.

> 2. If point nr one isn't possible, maybe there is some other way to ensure
> security? I don't know too much about security or cryptography, but I can
> think of solutions such as openVPN or IPsec.

Correct. This is the best idea to do it. To prevent others to enter the mes=
h=20
setup it should be possible to use wpa_none. Maybe there are other suggesti=
ons=20
floating around on the mailing list.
=20
> Generally, the goal is to assert security of transmitting some data
> *without* losing open characteristics of mesh network.

The problem is that you have two different goals. It is ok to say that data=
=20
must be encrypted over the mesh (vpn/ipsec/..), but it is hard to keep=20
something really open and at the the same time also prevent the user to hav=
e=20
control over the mesh (because the mesh is not for the nodes, but the nodes=
=20
form the mesh).

But if it is only important that data cannot be captured by other people th=
en=20
go for a good higher level encryption and authentication strategy.

And are you sure that you really want to connect endu ser to the mesh=20
directly? It is a lot easier to use dedicated nodes (ask Linus or Marek) wh=
ich=20
connects to the mesh and provide some kind of gateway to/over the mesh. Tho=
se=20
endpoints could for example also use to provide the vpn (depends on your=20
setup).

Best regards,
	Sven

--nextPart1545683.Qkndv9E5D2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL1KE8AAoJEF2HCgfBJntG5aUQAJrCXHkuOV9Hohg52Oqc8dH5
K7mx2mHiI5uGaLetkD+mHQsTIyJBfkOjTZVrDllCBU4cTKDML3DwK0AJGUWMD7NV
9Wasd0ca6up54fdk8DT8j8jaoDoWKoqtV2Xc4+nasq+WeGaQjBwlbhbeiS6ovodJ
uYGYcLZn4t3roJVF5/8PZyVa1UF2oNkOLLD6d8Yx5vHQ/gr+hLjpdvk+opNIxC3I
CiBeLQ2nUTXhQUL75Hk/VCfIKVeUjDAbYaG+KQfq9jjOH/YG0bWYgNLyx1SUVwA2
MGt7obGyoc4+uzLpVRLZtHNHpQi6VUaB3JB/Q2d7b6VU55yXrbzk3ymixYlVRr62
HetlWd928burGvZxUDa4Po73MBhaqdLK0/2B8yiYcuC42s7jP1QP1SIICEBLz8bM
jZjMUJ6nJa304aB06kYNzc9/LQkOnomu8w1OYQRXeaJFJ9P4gnIVVPBEkefcq3Yf
p5gAypQobJ+paCWB0ZcKhwQLqntBFdwlK9DFKswE69XXtSqHhlEi3NSL5w9C8iLO
Lk4Xtb7k4AW4lpZp/Wi25qT99e6Wu9zGsIFKNIN+RL71pCV1amj+zcWNnTf+GAAw
+7CvKt08zKArSBEoX27oSvxRK3HcTWK+1oJ1H12VpVk80mxUAK/gh57FDxVCNuzR
cxw+7/bv14LY0haaHJa8
=w7K3
-----END PGP SIGNATURE-----

--nextPart1545683.Qkndv9E5D2--
