Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2011 14:30:43 +0200
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
	<1305011821-5411-1-git-send-email-sven@narfation.org>
	<1305011821-5411-4-git-send-email-sven@narfation.org>
In-Reply-To: <1305011821-5411-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1823103.tWxhmJxGnA";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105201430.44397.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: convert
	call_rcu(softif_neigh_free_rcu) to kfree_rcu
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

--nextPart1823103.tWxhmJxGnA
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20
> The RCU callback softif_neigh_free_rcu() just calls kfree(), so we can
> use kfree_rcu() instead of call_rcu().
>=20
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Marek Lindner <lindner_marek@yahoo.de>
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Acked-by: David S. Miller <davem@davemloft.net>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Linus applied it in 8e3572cff70ee19a0a1f2e2dde0bca0b7c8b54dc

Applied in 8bd9620

--nextPart1823103.tWxhmJxGnA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN1l7zAAoJEF2HCgfBJntGoAsP/Arfy5aaRA+DjPKijDmS79Ud
Ir1kablbj/cnn/xBKatfdpO/pO8NiPeRkGjgf6+rYCqZ4EY8j1nNqF6DukoARpOV
EFttkyqxUN/uoJG8x094dkp+0UzGovcT1673CLJxfq2CpL1y7V7nSv4VRx0QRwHI
pD0Rds68+dwVs52DWz6DFMfNUKn/liLdDtRer8CX//n2c+fydmxsePggfbYXHupl
lPa2/Wj2z/+rsJqaxPUP8VhMScilmV20sC0Dq1sFlh8lvZ29rDRcD1VpxIdI+H3t
7R/aS8mZZR9bzKOizwUw8QiJPmHWNkqejFjsN6ocJI7bg+WtZat8jj/s9Gtw+kuX
T6zelYhgqot9joeilSt1O+hLywYP9jAYqbVin1FwZiby9VHhvYZQ8Tpm3hyzTEUq
2PrE0PZsqBrLQTr0AO7cI4i69TA96TZjh/mo1qQx0HZvC3IY+ja03zhLLwkHCJL4
72kgKdq3Xu0zRhKzjaSInCvaPV2TAdInqB+4L0NPkdobgZbuYLbyWoOiK3dj4L2q
ElXSaemX1kBtq7JEMrEB16CTBguuM2jYDTdN2+Osm832hhem6z0kJ2neJi8T4F0f
sAPX48O6SpdM8lJ3yFsJ/JoRy7DEjJ4/a1BoaewdXGKYUtZ5RFRb9kL125nh8LXc
cXmjJHElxZfHawAgTljR
=ueIH
-----END PGP SIGNATURE-----

--nextPart1823103.tWxhmJxGnA--
