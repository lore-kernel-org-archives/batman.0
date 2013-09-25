Return-Path: <antonio@meshcoding.com>
Date: Wed, 25 Sep 2013 22:18:32 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130925201832.GW3911@neomailbox.net>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1378312060-30922-5-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gvPGo+RAdjC9O5ul"
Content-Disposition: inline
In-Reply-To: <1378312060-30922-5-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 4/6] batman-adv: add WiFi penalty
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


--gvPGo+RAdjC9O5ul
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2013 at 06:27:38PM +0200, Simon Wunderlich wrote:
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index d32b2f2..efddadf 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -1085,6 +1085,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig=
_node *orig_node,
>  	uint8_t orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
>  	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
>  	int tq_asym_penalty, inv_asym_penalty, if_num, ret =3D 0;
> +	int tq_iface_penalty;
>  	unsigned int combined_tq;

please, add the new variable at the end (line length sorting).

> =20
>  	/* find corresponding one hop neighbor */
> @@ -1169,15 +1170,33 @@ static int batadv_iv_ogm_calc_tq(struct batadv_or=
ig_node *orig_node,
>  	inv_asym_penalty /=3D neigh_rq_max_cube;
>  	tq_asym_penalty =3D BATADV_TQ_MAX_VALUE - inv_asym_penalty;
> =20
> -	combined_tq =3D batadv_ogm_packet->tq * tq_own * tq_asym_penalty;
> -	combined_tq /=3D BATADV_TQ_MAX_VALUE * BATADV_TQ_MAX_VALUE;
> +	/* penalize if the OGM is forwarded on the same interface. WiFi
> +	 * interfaces and other half duplex devices suffer from throughput
> +	 * drops as they can't send and receive at the same time.
> +	 */
> +	tq_iface_penalty =3D BATADV_TQ_MAX_VALUE;
> +	if (if_outgoing && (if_incoming =3D=3D if_outgoing) &&
> +	    batadv_is_wifi_netdev(if_outgoing->net_dev))
> +		tq_iface_penalty =3D batadv_hop_penalty(BATADV_TQ_MAX_VALUE,
> +						      bat_priv);
> +
> +	combined_tq =3D batadv_ogm_packet->tq *
> +		      tq_own *
> +		      tq_asym_penalty *
> +		      tq_iface_penalty;
> +	combined_tq /=3D BATADV_TQ_MAX_VALUE *
> +		       BATADV_TQ_MAX_VALUE *
> +		       BATADV_TQ_MAX_VALUE;

Mh..I am not sure about the style of these assignments...but we can live wi=
th
those for now.

>  	batadv_ogm_packet->tq =3D combined_tq;
> =20
>  	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> -		   "bidirectional: orig =3D %-15pM neigh =3D %-15pM =3D> own_bcast =3D=
 %2i, real recv =3D %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i\n",
> +		   "bidirectional: orig =3D %-15pM neigh =3D %-15pM =3D> own_bcast =3D=
 %2i, real recv =3D %2i, local tq: %3i, asym_penalty: %3i, iface_penalty: %=
3i, total tq: %3i, if_incoming =3D %s, if_outgoing =3D %s\n",
>  		   orig_node->orig, orig_neigh_node->orig, total_count,
>  		   neigh_rq_count, tq_own,
> -		   tq_asym_penalty, batadv_ogm_packet->tq);
> +		   tq_asym_penalty, tq_iface_penalty,
> +		   batadv_ogm_packet->tq,

this one can go on the line above..

> +		   if_incoming ? if_incoming->net_dev->name : "NULL",
> +		   if_outgoing ? if_outgoing->net_dev->name : "NULL");
> =20
>  	/* if link has the minimum required transmission quality
>  	 * consider it bidirectional

Cheers,


--=20
Antonio Quartulli

--gvPGo+RAdjC9O5ul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSQ0UYAAoJEADl0hg6qKeOwnQQALWDjwrsBX7eN5M5lssYQ5Tt
ME3Lp3H26y0Jgk+91lDKsxZ7Q2Zo2BMjfEJ//gifo3PNYcEoVQgJgLqx4mxA1LS9
EntPe2AXwsqK6RHMJHlB254Cp/qTAjy38mHK3YoIZHsOoZlds5iBbGyyA+4aSqHi
PxvLDG36zIjRbttHVXzFWvkxpc/hNSW6/wpKCvnLi8uyOaGBTrwiMN/OyhDicslA
1a5fZm6Lhu7SLtDrrYXn9W7vjtEUHCTYJN7klKYI5UYw2WKHkvVXy5um/WT934TR
6/Kr6YftotZQjdHYxwMrpavyLYW3Wg/YFnjDis9P1FPrWPwBJndB/6jup/ckrXxw
L7jt9yin28ljcFnG/KJ9VayQrZOgIrhsCjdFlic2uevOGnBHeXX5LrvfrblLeZI6
Rao82Y5GtcflL0znUmvuBeOxHWBbrhI3QsW1c/GTKPidRs4kXfKmdE2QjsmsJBKm
XF3fPeOrpAVsxk521Eu2I/8Wco3CYrTcK+B6w7d7Jk52zMPoG2JQtKTP+K3Nk2vG
cgZ6Xc4BZ+lyrxNu4qWcTI3Ck1aW0qgzlZFibeiUVrNMKAb6lzyqvHsSVduwfUZc
BVuEHAhvKezeAuFCyf+1k+aoRCosWVG9i5NVvOLQ+qxH0RRCWOwTe5OKzjukci2O
WoAQMeazPOp6xx4iYHoY
=W42h
-----END PGP SIGNATURE-----

--gvPGo+RAdjC9O5ul--
