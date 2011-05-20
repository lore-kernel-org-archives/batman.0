Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2011 14:29:59 +0200
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
	<1305011821-5411-1-git-send-email-sven@narfation.org>
	<1305011821-5411-3-git-send-email-sven@narfation.org>
In-Reply-To: <1305011821-5411-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1655250.7G7DPNqbfj";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105201430.00852.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: convert
	call_rcu(neigh_node_free_rcu) to kfree()
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

--nextPart1655250.7G7DPNqbfj
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20
> The RCU callback neigh_node_free_rcu() just calls kfree(), so we can use
> kfree_rcu() instead of call_rcu().
>=20
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Marek Lindner <lindner_marek@yahoo.de>
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Acked-by: David S. Miller <davem@davemloft.net>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Linus applied it in ae179ae433bb4ef6b6179c5c1c7b6cc7dc01c670

Applied in 178a37e6f

--nextPart1655250.7G7DPNqbfj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN1l7IAAoJEF2HCgfBJntGgcAQALvSjl3pKe/n7TQ9FPNkYHcC
lxQb+D+KXJNOBJ4FToInptXqK9GFlhnUEuvmXXSb6r78P21kNxeAiCVebbR7nWc3
7YFR/LPwRD/DDM1ows23OLPKFaNYC762vQ8Cm6cVMORp+NJ2U6B4Lmfzr4JYO1de
CUc+MGbSjrdILQ83RnpqMdIBBAFxh+zwmasQcq7srCFs1CRXGei8NFZneF+rC3Ja
IukoBEeBuhuIIY/S5scJZbFOSyYOrcW8Vpu82HLaK6F2ML0pkK/faJ0ixVxmbLq2
HuNU6RCn+EK0+pYuNXgHGHfzA+bTbs4vIUT2T2KsmN6wr9CmUAxSRpoCk1H1IYCO
cqMYFkTwrf9gJKgHGnHaL67aQbM6kAKBJPVxxQOKUs1HGYws+cfYhB6cvBT9hiQt
DsAFP6BlDuXsQKcZ0erLBhw3HayEJyUgnEmfyUc5pB36iAEnazpb2YVZdPDP0c0m
qdOslHVbThzCrS4madUJPaJYw2f0t6VLu9Xyi4tZ4gVHqTeXyAZdGcekSPp/o83S
pJSrW4TU/QgqOwBv/Ys+KZuX5cO/vS82Pp6b1vts4kW65YDMbLDiNy+MuTbqAMZ+
vUHkJQkAi/KKYeZs1NvPSNfoUK1X+xbnBC87/iatScovkMpS0Lm2IpyIkmOkGv0i
Wge7DHwbYYjnVWaALkdU
=62El
-----END PGP SIGNATURE-----

--nextPart1655250.7G7DPNqbfj--
