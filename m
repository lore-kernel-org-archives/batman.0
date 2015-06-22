Return-Path: <antonio@meshcoding.com>
Message-ID: <5588432C.5040604@meshcoding.com>
Date: Mon, 22 Jun 2015 19:17:32 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434795203-21947-1-git-send-email-sven@narfation.org>
 <1434795203-21947-2-git-send-email-sven@narfation.org>
In-Reply-To: <1434795203-21947-2-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JATcF1lr9RtKT8CgCm6Lna1d05RkWVVCi"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Add lockdep_asserts for
 documented external locks
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JATcF1lr9RtKT8CgCm6Lna1d05RkWVVCi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20/06/15 12:13, Sven Eckelmann wrote:
> Some functions already have documentation about looks they require insi=
de
                                                  ^^^^^

little typ0 here, but I think $somebody can easily fix it before merging
the patch.


> their kerneldoc header. These can be directly tested during runtime usi=
ng
> the lockdep asserts.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--JATcF1lr9RtKT8CgCm6Lna1d05RkWVVCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViEMwAAoJEOb/4TMchkvf92cP+gNhJ0CGvGwFFCiH68D/NQIC
5DIh9DMKyIwcQ8gKp/rJfUcmMTFNglEKc/7CVbrqCn7tJK1Yak6ozixWXZ2B6yPX
jq9tcBbIICvWjc5wHIDCFqOR2D4WjBT+N2CRXGZNlYaiPO+B41L3DddWS9X2kpqj
BACvzCjZdRUVVhQpA7RudRZXcFGebyZ0RWdrbpdZkPgcEF+MlOmBxlklfiQBUpQ2
yE4fJZUnxTIGVHH9E2YHUImN1hHeTg24/Ptn+tXsLiHLoZf4tB7rfV/Qk73lgFSc
IkdBNdUbIxNWqnhn+Br/+K5C41pCgGD/ih1wGCnAZ3S4iSKZuwncVybuGQjGlR/2
aFQ5lJHLdvpvgohuqU3p4t3Io8H2zefUEv0NDgCANzCZt8+BvZOv/6qwDKvR6YTh
bSSPk7yHKvNLgW4Cy/+r7FJ7CKDAULio8H5oDIvzDuye8ZAA6BUAe1hM9Rhrd85b
+ltK+SN8dxU8hwoBpheeopXiT3ybUbPTs2UU2w5SJS6vx/yX8G3v+o7Obr86XLpF
o0YKACsMBdjTMhLFQpNsldyjDm0Gtw5XXke40xIXNRjau+psuUUhF7pp6CuV7y9j
cA7yzVTGyxQo1MkOAiiCqzD3BnIZe/Ci7Yt41shVjcCqAdTySJSmTCSHEuH090e0
tjnVSH7XQPKp/Gp8uf7K
=TyCY
-----END PGP SIGNATURE-----

--JATcF1lr9RtKT8CgCm6Lna1d05RkWVVCi--
