Return-Path: <a@unstable.cc>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-23-git-send-email-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <5693D456.40908@unstable.cc>
Date: Tue, 12 Jan 2016 00:12:06 +0800
MIME-Version: 1.0
In-Reply-To: <1451992006-13191-23-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UisOAaid0DvotjFMLr1D1JDBitdSWejEA"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 23/31] batman-adv: Convert
 batadv_tt_orig_list_entry to kref
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
--UisOAaid0DvotjFMLr1D1JDBitdSWejEA
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


--UisOAaid0DvotjFMLr1D1JDBitdSWejEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWk9RWAAoJENpFlCjNi1MRkJ8P/RDztcwrME2QMtedGGSCcqSa
r+STCEuowSv7QW3d5/89OF+eaRkJXOEOXZwq6lRCpT6kzXdKj/2oZnwxh3+8lpwn
DCMoIZUmoCM/b/rr9bvI2hW7d+zDQF9v2ANcuKppzvGOOQrXlijTPXrUPN4zKQNz
EW93YpfpR8v30+5c7jeecNMhUJwvT1dKSdqWDQGsPi8gXzwFIDPsdspV5DPvi02h
b8BJh3kMVyzOBOFEGOktgxqwee3rsMyOtnbLFDzR1etZTb65lO65NAe8kd3DkEcq
YU52x33SJbNUe+Zp+6SYrquLvXzihmMYzDz6L+EsljUR17AuNIQinAKBGNd5aWRx
TTXuScYoRUL/FzrZtiXiIs1NG0GYmCVHH6ad9KxYW9GX7w/WqL2N2PNiXiiUsc+j
fFu5/zx1QAA63ckFPDXPumZ5CcirZdWmqns6TpBYm1pcnoaIgWWZibRRhKhBuwU9
36g0tSV8ZXBvbhLqE0J+c3otbTpWyMM9ZtJMLcw11cAsyxvmDBK00ESCaHBxn300
qsc4rgJi2YiBD4k/YWDAj1q23CSM0sqPbo+CKp600A6Bxg1WvYoZ2JCEisTAvo4g
0jB37Se/ZmTm7zvdhqlUTh/4xO9n0iIKkGBzj5otih+20w+4byGziJcUqs8u/6Em
C5+Ug4Nj+XvQ35hVyb0v
=RsP5
-----END PGP SIGNATURE-----

--UisOAaid0DvotjFMLr1D1JDBitdSWejEA--
