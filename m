Return-Path: <antonio@meshcoding.com>
Message-ID: <53298849.5060104@meshcoding.com>
Date: Wed, 19 Mar 2014 13:06:33 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1395225186-18597-1-git-send-email-sw@simonwunderlich.de>
 <1395225186-18597-4-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1395225186-18597-4-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O8IRtIag679i6imOfXtjmLlQWOEUvRoUm"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 3/3] batman-adv: always run
	purge_orig_neighbors
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
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O8IRtIag679i6imOfXtjmLlQWOEUvRoUm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 19/03/14 11:33, Simon Wunderlich wrote:
> @@ -854,7 +854,7 @@ static bool batadv_purge_orig_node(struct batadv_pr=
iv *bat_priv,
>  {
>  	struct batadv_neigh_node *best_neigh_node;
>  	struct batadv_hard_iface *hard_iface;
> -	bool changed;
> +	bool changed, changed_neigh;
> =20
>  	if (batadv_has_timed_out(orig_node->last_seen,
>  				 2 * BATADV_PURGE_TIMEOUT)) {
> @@ -865,7 +865,8 @@ static bool batadv_purge_orig_node(struct batadv_pr=
iv *bat_priv,
>  		return true;
>  	}
>  	changed =3D batadv_purge_orig_ifinfo(bat_priv, orig_node);
> -	changed =3D changed || batadv_purge_orig_neighbors(bat_priv, orig_nod=
e);
> +	changed_neigh =3D batadv_purge_orig_neighbors(bat_priv, orig_node);
> +	changed |=3D changed_neigh;
> =20
>  	if (!changed)

Maybe we should just remove the |=3D and use this if condition:
=09
	if (!changed && !changed_neigh)

?

The |=3D now is just useless..

Cheers,

--=20
Antonio Quartulli


--O8IRtIag679i6imOfXtjmLlQWOEUvRoUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTKYhNAAoJEEKTMo6mOh1VjwsP/iIfIDZjaCTHJrmy8UCPvbGl
M44o8jbKSuA9xMCex98nypNkuRIGIEhiLaz6Sw+88pBLRlvtYg0UogVs/Gra+X5A
iGwQlk1S3KdXEmH+5U2XQrKiVq2p0xjPbiXIfbj1OfNGGxF43hArr1Y+vaP2U6rW
0uyJrqSN1QrF0RbAy6AjetgNdwDdou25lZgHp8A5oRsyCW0uebXSouHLOfUo5q60
qcmuO+leRuYmzQq+NHxzhOrFhODYT24cXeuePahN6F1IAx5Y3bXNKW5KZ+hYt3MB
whbonKwo2gJwbaXgOuUNZU4vKXLwLeJS11JnXenZdVNcR1fO+pew5aBPFMcCRVsz
KE1io4kKKlpMkOeHc55N7rv656aocUnenuzQr4+V1ZizwbI+Xg2tFVpFbvoP9s5D
ESxxOrZSK5lHekrYgyztNqEdGzMrriShOeivmRXrdDdQjeTdOnDTizMO9yLKLMup
UDd4F8ZCC7DlnW8pThN4yBGnlQHM9QfCe0J5xkHw7zbq8OiYlnDON5n7JtoW3Rlb
vFIOYsVq3ovS3B7Z7argYsugQeYDIswQeuuaz1Hr47OoqU2lfhz925sqTRBrzq1x
xM4g6foX9Zc3Y/YUrNJYwblZj0/FzYOEcnC5zLtPZuq2AYi/d1kdaEU4XvLnDUCA
GOhZDJIqzOSwvN999pvz
=bm5a
-----END PGP SIGNATURE-----

--O8IRtIag679i6imOfXtjmLlQWOEUvRoUm--
