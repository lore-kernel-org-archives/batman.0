Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Oct 2011 01:05:46 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111031000546.GC10726@pandem0nium>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <1319964962-5092-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: implement an helper
 function to forge unicast packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 30, 2011 at 09:55:57AM +0100, Antonio Quartulli wrote:
> @@ -304,33 +331,22 @@ int unicast_send_skb(struct sk_buff *skb, struct ba=
t_priv *bat_priv)
>  	orig_node =3D transtable_search(bat_priv, ethhdr->h_source,
>  				      ethhdr->h_dest);
> =20
> -find_router:
> +prepare_packet:
>  	/**
>  	 * find_router():

I guess the comment should be changed as well when the label is renamed.

>  	 *  - if orig_node is NULL it returns NULL
>  	 *  - increases neigh_nodes refcount if found.
>  	 */
>  	neigh_node =3D find_router(bat_priv, orig_node, NULL);
> -

Do we really need to remove this newline?


>  	if (!neigh_node)
>  		goto out;
> =20
> -	if (my_skb_head_push(skb, sizeof(*unicast_packet)) < 0)
> +	skb =3D prepare_unicast_packet(skb, orig_node);
> +	if (!skb)
>  		goto out;
> =20
>  	unicast_packet =3D (struct unicast_packet *)skb->data;
> =20
> -	unicast_packet->version =3D COMPAT_VERSION;
> -	/* batman packet type: unicast */
> -	unicast_packet->packet_type =3D BAT_UNICAST;
> -	/* set unicast ttl */
> -	unicast_packet->ttl =3D TTL;
> -	/* copy the destination for faster routing */
> -	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
> -	/* set the destination tt version number */
> -	unicast_packet->ttvn =3D
> -		(uint8_t)atomic_read(&orig_node->last_ttvn);
> -
>  	if (atomic_read(&bat_priv->fragmentation) &&
>  	    data_len + sizeof(*unicast_packet) >
>  				neigh_node->if_incoming->net_dev->mtu) {
> @@ -350,7 +366,7 @@ out:
>  		neigh_node_free_ref(neigh_node);
>  	if (orig_node)
>  		orig_node_free_ref(orig_node);
> -	if (ret =3D=3D 1)
> +	if (ret =3D=3D 1 && skb)
>  		kfree_skb(skb);
>  	return ret;
>  }

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6t5lkACgkQrzg/fFk7axbx6ACeMvYj3tQqBdaN6BgDrq8+Ofuf
EUQAn3tkj52wH/yRJka0LcS7m6GQdllK
=e1vP
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
