Return-Path: <antonio@meshcoding.com>
Message-ID: <53C3C569.1080702@meshcoding.com>
Date: Mon, 14 Jul 2014 13:56:25 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
 <1405081595-23371-11-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-11-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="80tN8mTEFNpoAskbNcllt0mskJf8prLpk"
Subject: Re: [B.A.T.M.A.N.] [PATCH 11/13] batman-adv: kernel doc fixes for
 sysfs.{c, h}
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
Cc: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--80tN8mTEFNpoAskbNcllt0mskJf8prLpk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/07/14 14:26, Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  sysfs.c | 5 ++---
>  sysfs.h | 8 ++++----
>  2 files changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/sysfs.c b/sysfs.c
> index fc47baa..bf8800e 100644
> --- a/sysfs.c
> +++ b/sysfs.c
> @@ -62,6 +62,7 @@ static struct batadv_priv *batadv_vlan_kobj_to_batpri=
v(struct kobject *obj)
> =20
>  /**
>   * batadv_kobj_to_vlan - convert a kobj in the associated softif_vlan =
struct
> + * @bat_priv: batman-adv private data


Martin,

what about re-using the same text we use in all the other kerneldocs for
bat_priv ?

Cheers,


--=20
Antonio Quartulli


--80tN8mTEFNpoAskbNcllt0mskJf8prLpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTw8VtAAoJEJgn97Bh2u9e+0QP/i6+1rQ3Jcb9fegev9L/nFqR
/vvMmz96Q757eWfnPkgDHFNWPLrKijqgDNK9rGPqw2hELU4qSm7B7sw7Cr483ieG
TsMGdupeOqnRrrwQORKLXZ4k+DV/r2/6sSgtHxs8MxMNb1HdMEmuK4d6HDBA0htg
Q/B+DOhpLki6fsrh8ZaqyUnwpWRsWhC05V73fzGO9zsGs7twz1OnGyKGtq7nIG37
jFMysA1sH/fFj73g2ojc0cwUgEYl5NBtpJ9V/6xAe7I9bPdyAS4UveG3f88d/XB4
5ZgKBzaLUU3Ow1rJE1FvFk4MmWHgrSHehKnI7PMOIe3aqtVjWFzyGhEofZpC+Kzb
NgkUjrYAWWNakkvuTGV0QgHJ6sSfe+ZcMdG5ShvHyCSK1dyTO0c7QSVFPx7SmkDG
/aVBxrWLAmthS4ROrm/bAGXryIpWU1bFNSpmp/HwguHFy5fHQbEko6xRbHeDMM2B
I8ZhGe6xo3CN4RWHGMR6rBJOfSbP+rfUhHZUsObz0M7qOL6mYwKGkfwlz7eDdnFw
m9wdLjClPgZip9tVncbViXBIvb0xphjuYIayMy6wm5wWaNRd7w7DPXn0hc1lmDrn
r6KcrxpLZN8xp0scdWm/PsEXgP+5A8Xw2fFKF/xNTVD2YfG/S5VTo0xAzknm8T9y
hKcKqnrhETkuXMLWGOz4
=J56a
-----END PGP SIGNATURE-----

--80tN8mTEFNpoAskbNcllt0mskJf8prLpk--
