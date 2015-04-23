Return-Path: <antonio@meshcoding.com>
Message-ID: <55386464.1000403@meshcoding.com>
Date: Thu, 23 Apr 2015 05:17:56 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1429729962-5365-1-git-send-email-sven@narfation.org>
In-Reply-To: <1429729962-5365-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bxWG8wSe7Gewsx9EGJ5Snl01ctGre64XS"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next] batman-adv: Remove unused compat
 function batadv_free_rcu_softif_vlan
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
To: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bxWG8wSe7Gewsx9EGJ5Snl01ctGre64XS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/04/15 21:12, Sven Eckelmann wrote:
> The commit e78c16c0550c ("batman-adv: Revert "fix var name to keep
> compatibility with old kernels"") should have renamed the function to
> batadv_free_rcu_softif_vlan instead of adding a new function
> batadv_free_rcu_vlan because it was only used in this single place.
>=20

Thanks Sven, I suspected that, but I thought that this *softif_vlan*
function was used somewhere else.

> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


Marek, if you don't think we will merge master into next soon, I'd
suggest we merge this patch and reduce the noise of the build check.



Cheers,


--=20
Antonio Quartulli


--bxWG8wSe7Gewsx9EGJ5Snl01ctGre64XS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVOGRpAAoJEJgn97Bh2u9eoLcP/2ktF9EWTdKUuFrIlMXSqKV9
PdeW6hM81PC+A9DsA6RWkksTo21iBYK+oXpdR28rN8wUiwxBI92CuApdyf0cn13P
3nZG+m2EXTHFf/qBD1DruzY+qRShUJjyxJjrMpkMBvSYDEECPHgIUpRjQwlONW5p
//YPRkt3dXUQun9fII5zb0p/Rmwb2ynjaqrhqB5JXXps3kkXSjdEkrNwfzNhGiyn
r9dKQ3Gkrmu638Z6A1IDMCTd9jxco13b0sbxwY1nQ48G0rrfhACsNVx1U4FFbEzC
NLaA1qwMGhSPa0d/8HLL4fQvw2MiYSAI/IAhHkOXqQQUWhqhDZ6aaCtpQG98HoZL
UKkJ/hVuYNrKzeqhZzvp7ZvvMddEZcOqrMCAVhYkow140ezFss+vuF76tz7rSoCm
sQ3b5lebda2jdSs6wlIlfOzSPmc2Z36ed72NdL1lRzdh0ZVFYKtatYww7H8NW4Hj
JhXgkhsKd6oz5Xwcm5Zb1ozXQvxDkIEfSYhZz6JfAO/JPQMqvcP2zICMmOJE9R49
DSot4BrQoUrG2bsE++lu1NdDE5TozdRXt+1miC6nInc25rRKoHCbLmJZL8fv7pvG
SIYN7M6xh3QfQP8+Rf2Lkptk5P3HE9Duxmv7zopWfQS3h0g6Hx5ZmapIGnUdDeP7
tVNI9OeW8nyH1eO1Nt6y
=bwQ/
-----END PGP SIGNATURE-----

--bxWG8wSe7Gewsx9EGJ5Snl01ctGre64XS--
