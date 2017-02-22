Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Feb 2017 17:24:47 +0100
Message-ID: <4486600.Xps1bk75uv@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3218682.Z2CvcKjbXh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v2 0/2] batman-adv: fragment size adjustments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3218682.Z2CvcKjbXh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

here is the second version of both fragment size patches. There is no actual
change - just rebased on top of master.

I'll recommend the commit message (from Linus!) of the first patch for more
details.

v2:

 * rebased on top of master

Kind regards,
	Sven


Matthias Schiffer (1):
  batman-adv: decrease maximum fragment size

Sven Eckelmann (1):
  batman-adv: Keep fragments equally sized

 net/batman-adv/fragmentation.c | 20 +++++++++++++-------
 net/batman-adv/main.h          |  2 +-
 2 files changed, 14 insertions(+), 8 deletions(-)
--nextPart3218682.Z2CvcKjbXh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlitu08ACgkQXYcKB8Em
e0bjjRAAvNKjpxwQ7hF565bRsPhkMWcyzYBjmO1uESUEdCayT1rWimjy0p9i/CAf
0G7Y4nTsrf/5aLjd07m/DuCJyXHEswV7uwcFNtNOE5BItA6dzejnamtt0EdWGmp5
dy73EtZnB+8NhFc6cQry7igM5btLer57+63cSGMSUEQ0vgmNY7BbZFQjqbAA+Hwe
6isqvxRr2XV4H0ldzKRl3cE1Hc4qQXxfuuvJmrsj9PhcxiVAQg71NdFoMVxSV59p
uNdRH2Tsc0aRWSkPfuwVJAwhJsnzIbRzNO9xChDgN485jr9thvo61hD0u2bzUMVv
28eiLLe3bxL04sU7PKJfgOnG2pB4Sr8X47WNDhtEGzCVARImh7JZIXa0sSRqz1jQ
X17tTX+VxJjEB6uImChBk90EB9rNjZcd5yhhnrSJoFpNspa529L3Icm5DHgmbjZF
e1UPC1/1ltsAhh4kCVaTxTJdDsPJvHfjafLfEOpOnuetXtlv92b9UPTFv0NJq65L
2q26+ELV0zAbs8PVsqDy6c6V3zqM39HILI0LJx7AZB8TuT85Hs3VVFwx82TbNpdU
8dVWXHDyYpczf5RE0BfatMQkW0yBozFkqTRjwx6S7KQzjzKKsc5MLGJX/Pc99utW
WgZ5sAeF80blWDnIUkLpZsBF7YaJVo63jAroFGQTdA9ldgJ3Z2k=
=rkEA
-----END PGP SIGNATURE-----

--nextPart3218682.Z2CvcKjbXh--

