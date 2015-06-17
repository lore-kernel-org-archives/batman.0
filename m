Return-Path: <antonio@meshcoding.com>
Message-ID: <55819143.8050701@meshcoding.com>
Date: Wed, 17 Jun 2015 17:24:51 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434537770-15161-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434537770-15161-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fxV2cG87awfCjw8W3g1D8jrbHBacPPCg2"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix kernel crash due to
 missing NULL checks
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fxV2cG87awfCjw8W3g1D8jrbHBacPPCg2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/06/15 12:42, Marek Lindner wrote:
> batadv_softif_vlan_get() may return NULL which has to be verified
> by the caller.
>=20
> Reported-by: Ryan Thompson <ryan@eero.com>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

one comment is inline:

> ---
>  soft-interface.c    |  3 +++
>  translation-table.c | 17 +++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/soft-interface.c b/soft-interface.c
> index da89336..7841a4b 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -455,6 +455,9 @@ out:
>   */
>  void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
>  {
> +	if (!vlan)
> +		return;
> +
>  	if (atomic_dec_and_test(&vlan->refcount)) {
>  		spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
>  		hlist_del_rcu(&vlan->list);
> diff --git a/translation-table.c b/translation-table.c
> index e95a424..efbcb59 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -575,6 +575,8 @@ bool batadv_tt_local_add(struct net_device *soft_if=
ace, const uint8_t *addr,
> =20
>  	/* increase the refcounter of the related vlan */
>  	vlan =3D batadv_softif_vlan_get(bat_priv, vid);
> +	if (!vlan)
> +		goto out;

In this case I'd use a WARN here because if we are adding a local client
to a specific VLAN the assumption is that batman-adv is already aware of
this VLAN, therefore this condition is not expected to be true.


Cheers,


--=20
Antonio Quartulli


--fxV2cG87awfCjw8W3g1D8jrbHBacPPCg2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgZFDAAoJEOb/4TMchkvf6xwQAJlK760u98LvnLM3jgNHkVoH
kedfnTv+2wAsCzAEu4i/6YpYmQp4uefYQ2F9ZMvZAnNRE53/z1p66A3+8P6pK66W
v8DMhDOWpvw5TqgTkSTJZUnkiGqWn2eoy+4mGP0ybuPZ3ZDZtpSBZlQOcDMa3z1j
7ZEBYBOI9DngLMPRm5gqGEr4pweaQZILlpxOFOlCZTvgTmfXaW6h/Vp+TUc7SyfW
7IUc1M3QyoP1caWCHO543BVDELuYdq49p0+ujGc1vdvUOXX4D5SwAtP1cS092dER
mQvTux6OijCZshs5pay4whVzvs8KvthpVdv+nX6G5XaNIZDADa5xGNyCSiaXsb0/
8rge6QDPsR4atxf0YnJr0OvKg7YHVqcHq24+1zpCY0NPiNIqJ/qewbbnVW7zRWuo
nNeOkuTCSqdpjUbzV2YzSC2d3xtxYC6Sl0x3aZtBJuJPD35/IzpcBF/5vCMp22BO
1x4aTtOlcBlk+ubajV0jrKEgYAhSnS5OfsHz6zxS+OKX/0bzVECgIsvpNAYnj5/E
ifXwevp/e3PAZ9nd2Ode0uNZK+DlKZKuoRA6QMPJvP3U/outyR/tqLPyyQB8NLYV
0WvbFDy9oYaqdKykrOI8cn/XUF1z0VgJQB2akgPqtAgPQn624az8Et5Vsws3I4N4
F04GwGMCxMFlMeIjKj3A
=YyWS
-----END PGP SIGNATURE-----

--fxV2cG87awfCjw8W3g1D8jrbHBacPPCg2--
