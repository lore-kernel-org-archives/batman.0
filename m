Return-Path: <a@unstable.cc>
References: <1453296735-8319-1-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <569F9AF1.5080403@unstable.cc>
Date: Wed, 20 Jan 2016 22:34:25 +0800
MIME-Version: 1.0
In-Reply-To: <1453296735-8319-1-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xpcaq828oLtilPuWk2wBH9dtUE5tQ08pu"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: move and restructure
 batadv_v_ogm_forward
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
--xpcaq828oLtilPuWk2wBH9dtUE5tQ08pu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20/01/16 21:32, Simon Wunderlich wrote:
>  static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
>  				 const struct batadv_ogm2_packet *ogm_received,
> -				 u32 throughput,
> +				 struct batadv_neigh_node *neigh_node,
>  				 struct batadv_hard_iface *if_incoming,
>  				 struct batadv_hard_iface *if_outgoing)
>  {
> +	struct batadv_neigh_ifinfo *neigh_ifinfo =3D NULL;
> +	struct batadv_orig_ifinfo *orig_ifinfo =3D NULL;
> +	struct batadv_neigh_node *router =3D NULL;
>  	struct batadv_ogm2_packet *ogm_forward;
>  	unsigned char *skb_buff;
>  	struct sk_buff *skb;
>  	size_t packet_len;
>  	u16 tvlv_len;
> =20
> +	/* only forward for specific interfaces, not for the default one. */
> +	if (if_outgoing !=3D BATADV_IF_DEFAULT)
> +		goto out;
> +

personally I'd prefer the forward function to do what it says: forward
the OGM. The checks whether or not we should do this should stay in
ogm_process_per_outif().

> +	orig_ifinfo =3D batadv_orig_ifinfo_new(orig_node, if_outgoing);
> +	if (!orig_ifinfo)
> +		goto out;
> +	/* acquire possibly updated router */
> +	router =3D batadv_orig_router_get(orig_node, if_outgoing);
> +
> +	/* strict rule: forward packets coming from the best next hop only */=

> +	if (neigh_node !=3D router)
> +		goto out;
> +

this is changing the behaviour.
here now we get a router which potentially was elected during the
previous update_route() call while processing this very OGM. We are
still discussing if we want to do this or not, but this patch should be
just a style change, while this is not.

This check should be performed against the router which was selected
before performing any route update.


Cheers,

--=20
Antonio Quartulli


--xpcaq828oLtilPuWk2wBH9dtUE5tQ08pu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWn5r1AAoJENpFlCjNi1MRyDwP/2gG6QyZLE5WYcbwGxihKPsv
dq/r9K9FscUt27g6a2uBTo0j66q/hNvRYFAdbGODGn+Xaz+xVE44auTCE4aAxwGz
CeI06wMU9WkGsqJdZieBs0rOdgb3KtxtNmyXuegq32htpfaPUIItAYAgOQWOm5I5
2BICu0BVYbcc4ZOwBRzyT1kZ+lKcj1PVIZq5dMurvj3VmMhN3bij4CvKe8VfesSk
/UP0dPl0YoRVVkxZ45Cnsy4EX7ahDShAXIDogl+BQMdoJq9A5Azz/imTjOtp/jaZ
SNJhGTxwnCFnkuXHZzl7AewV9yhWQsW0ANqRxezyfX6gBY+KavuPLes9TOVAw7fO
6I5ABWRKTMrAdsEhoil4X3zbTrk/pIlXdLigB7/9x1nRpApK1XTTG00OO28rU0yL
BA0BHuIqq1R5Qehk9iI0XtrszXH61eD+TQCwZO394g3swFUbJGTm539bSbpZM+7n
EvsDqnuqJ9rqrv+iBVoKUXKo9xEkDihP7vYR2cENugz0V8b5OLzjTIZ45uNISJwE
vrGuHyFZlgAvCcKbzDJMZadEK1QO5rOCh3ZI9d5phC5pDGhWiVwMNBqeEpeCRT1F
LtQSGWMzPQXNJa3CI8dfizDnGZ+jNDaByGe5nv/N6WISpJKUHvQ9M/BgNpoouMCS
1DbILY4kpCJluQ1hK1W4
=rbJ0
-----END PGP SIGNATURE-----

--xpcaq828oLtilPuWk2wBH9dtUE5tQ08pu--
