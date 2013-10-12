Return-Path: <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 01:52:20 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131012235220.GK576@neomailbox.net>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1381323938-26931-3-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <1381323938-26931-3-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: split tq information in
 neigh_node struct
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2013 at 03:05:33PM +0200, Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> For the network wide multi interface optimization it is required to save
> metrics per outgoing interface in one neighbor. Therefore a new type is
> introduced to keep interface-specific information. This also requires
> some changes in access and list management.
>=20
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---

[...]

>  void batadv_gw_check_election(struct batadv_priv *bat_priv,
>  			      struct batadv_orig_node *orig_node)
>  {
> +	struct batadv_neigh_node_ifinfo *router_orig_tq =3D NULL;
> +	struct batadv_neigh_node_ifinfo *router_gw_tq =3D NULL;
>  	struct batadv_orig_node *curr_gw_orig;
>  	struct batadv_neigh_node *router_gw =3D NULL, *router_orig =3D NULL;
>  	uint8_t gw_tq_avg, orig_tq_avg;
> =20
> +	rcu_read_lock();
>  	curr_gw_orig =3D batadv_gw_get_selected_orig(bat_priv);
>  	if (!curr_gw_orig)
>  		goto deselect;
> @@ -297,6 +316,10 @@ void batadv_gw_check_election(struct batadv_priv *ba=
t_priv,
>  	if (!router_gw)
>  		goto deselect;
> =20
> +	router_gw_tq =3D batadv_neigh_node_get_ifinfo(router_gw, NULL);
> +	if (!router_gw_tq)
> +		goto deselect;
> +
>  	/* this node already is the gateway */
>  	if (curr_gw_orig =3D=3D orig_node)
>  		goto out;
> @@ -305,8 +328,15 @@ void batadv_gw_check_election(struct batadv_priv *ba=
t_priv,
>  	if (!router_orig)
>  		goto out;
> =20
> -	gw_tq_avg =3D router_gw->bat_iv.tq_avg;
> -	orig_tq_avg =3D router_orig->bat_iv.tq_avg;
> +	router_orig_tq =3D batadv_neigh_node_get_ifinfo(router_orig, NULL);
> +	if (!router_orig_tq) {
> +		batadv_gw_deselect(bat_priv);
> +		goto out;
> +	}
> +
> +
> +	gw_tq_avg =3D router_gw_tq->bat_iv.tq_avg;
> +	orig_tq_avg =3D router_orig_tq->bat_iv.tq_avg;
> =20
>  	/* the TQ value has to be better */
>  	if (orig_tq_avg < gw_tq_avg)
> @@ -324,6 +354,7 @@ void batadv_gw_check_election(struct batadv_priv *bat=
_priv,
>  		   gw_tq_avg, orig_tq_avg);
> =20
>  deselect:
> +	rcu_read_unlock();
>  	batadv_gw_deselect(bat_priv);
>  out:

there are several "goto out;" after having acquired the rcu_read_lock.....
maybe they should be converted to "goto deselect;"? Otherwise this
rcu_read_unlock() has been misplaced.

Next time use C=3D2 when compiling your code: sparse would have told you ab=
out
this mistake :-) (this is how I found it).


Cheers,

--=20
Antonio Quartulli

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSWeC0AAoJEADl0hg6qKeOtjMQALtOMX1VSceGESubX4wO/tUe
Ud3p2IuRxuw8RLuOSLWmlqZRMPwwmvY5aBFyrqBhMW5bpSKxk1CQUZFZf1MMwggl
nqtvaKMn7D472J7/l+wMN9XvtTCLZEB2pLADZLIoBtcvCscMyGzpgyndW6qGK5zG
XPemOz3ne+z3uM5BQmcmqKUSrawVeovBQsPk7+lCsXM6yEWZgEzs2GBGplZnzsW3
yK6E+TeLFzaKrJWFgO6dhRTJlvXEM/cohxBUL4IlRArpDJu7G74EuNanqpWnQmEa
JzMUV+Y1xo+GH5s9bNds0AnGmR/w5uEZpFMLVSe4QpfVHpwcLPFwk2dB9nezUYkz
ljIjAFEj2/GKHckrNFuf0REyKOiY/1WZ4AJ7TYbro6fi0fiTAY38JtbEfU/ai8e3
60udn2rqv1YB8FEQyXUT4njnWHNE38jK0BIXvtqF8NykHe1Uoz1SpMSBxmiPm8IG
7wUr7AajGoDtOC9JVuwlMyngejZngzcoWHLmC0NNXzk84w2FpMTSFxEQ2cLQWFCr
5nzKq/0R6PQGAINPByCUtwNkF9SmpiQQpgS7vuA364+dmtC9oODtU3NqOKvSPm2r
YOM0/N3WDY1EOUu19/pomcw+bW4ZLQTwBk0vlnyACBEmhE42mSlssxh7U0i0L3ND
7jUjKzM+4E777pP54ErD
=H7+x
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
