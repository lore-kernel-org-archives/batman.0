Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 12 Aug 2013 16:31:29 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130812143129.GB18832@pandem0nium>
References: <1376224403-2494-1-git-send-email-ordex@autistici.org>
 <1376224403-2494-8-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <1376224403-2494-8-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 7/9] batman-adv: adapt the neighbor
 purging routine to use the new API functions
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


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2013 at 02:33:21PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  originator.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/originator.c b/originator.c
> index b3f6910..3ee8806 100644
> --- a/originator.c
> +++ b/originator.c
> @@ -380,6 +380,8 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_p=
riv,
>  	bool neigh_purged =3D false;
>  	unsigned long last_seen;
>  	struct batadv_hard_iface *if_incoming;
> +	struct batadv_algo_ops *bao =3D bat_priv->bat_algo_ops;
> +	uint32_t neigh_metric, best_metric;
> =20
>  	*best_neigh_node =3D NULL;
> =20
> @@ -414,10 +416,11 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat=
_priv,
>  			batadv_bonding_candidate_del(orig_node, neigh_node);
>  			batadv_neigh_node_free_ref(neigh_node);
>  		} else {
> -			if ((!*best_neigh_node) ||
> -			    (neigh_node->bat_iv.tq_avg >
> -			     (*best_neigh_node)->bat_iv.tq_avg))
> +			neigh_metric =3D bao->bat_metric_get(neigh_node);
> +			if (!*best_neigh_node || (neigh_metric > best_metric)) {

Shouldn't you initialize best_metric at some point?

>  				*best_neigh_node =3D neigh_node;
> +				best_metric =3D bao->bat_metric_get(neigh_node);
> +			}
>  		}
>  	}
> =20
> --=20
> 1.8.1.5
>=20

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlII8cEACgkQrzg/fFk7axbVtwCgjbihG3p4CKewbfqmyepjIMh3
4qAAoNpxc0DtuD+kvRPnFc/hykg7IAnB
=8pRH
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
