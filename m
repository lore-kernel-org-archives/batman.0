Return-Path: <a@unstable.cc>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-30-git-send-email-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <5693D556.4030304@unstable.cc>
Date: Tue, 12 Jan 2016 00:16:22 +0800
MIME-Version: 1.0
In-Reply-To: <1451992006-13191-30-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9ASxC9Um8cp3owW2W8QInxXq8h86oaqjF"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 30/31] batman-adv: Convert
 batadv_tt_common_entry to kref
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9ASxC9Um8cp3owW2W8QInxXq8h86oaqjF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/01/16 19:06, Sven Eckelmann wrote:
> batman-adv uses a self-written reference implementation which is just b=
ased
> on atomic_t. This is less obvious when reading the code than kref and
> therefore increases the change that the reference counting will be miss=
ed.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>


--=20
Antonio Quartulli


--9ASxC9Um8cp3owW2W8QInxXq8h86oaqjF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWk9VXAAoJENpFlCjNi1MRMcoP/RThMuH6iiR4bKBrmbsuTgfU
+uSnBEqvbHUv0hxuFOyMhOt9m2fE62l6FuTj8GPoF/UjaZ8TdAVaWy09/KffLUCe
E5H18FbIV6JJrxD3gqX1OiURr5VhNoKlkLdtAfGFJkZrirHa0s+AmyFtCE8r2FbA
R8A0X/2bbR0FJsfayBcTEsCwRVX84hqRWQSiZg6qec+in6emPcasHvioLET5mvo6
421uHUvtftlNGn4CY7NlHzq592vE5VcON9T5aSVnwMu6AnymPSPV70W+idlAPFx2
C9MwKSioBL4DoZVrq/hlQA6Ql+8IKWHeLLXAOmO9H51D6JBKn00mxV6HmPKrWyUp
1Hgm/3wCkjezLg7y/SzIL1o3G0AeIlSs25Ltd/zxwo2WYojT/VjbBehbWMs/MU8T
iDLup3y1oJdWB4VpB8pWeNRUa9s8B47hartTjzvZqo9YDkDPj/PTAUOSibP1Rvhv
qks6DqnlKML8yQK13nETeL+/8a4pgMtmZF7qJ2gbSJJXlZiUob2GHtqy/EE/K+LS
xkDddMORpJ9gJHFOtX/MaY5eOgCuwXVbzup676WJtXI7AEH2sVZDC5Gf3G9WkO9M
funjknjCJtCUqkgKQn0xmJoc211NBx0Sj/xotfupRF1Sno+sC2YHm7v6QxicTSww
om7/vZdM1gcBJvflJGXh
=jNX9
-----END PGP SIGNATURE-----

--9ASxC9Um8cp3owW2W8QInxXq8h86oaqjF--
