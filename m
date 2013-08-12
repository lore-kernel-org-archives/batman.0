Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 12 Aug 2013 16:28:12 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130812142812.GA18832@pandem0nium>
References: <1376224403-2494-1-git-send-email-ordex@autistici.org>
 <1376224403-2494-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <1376224403-2494-3-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/9] batman-adv: make struct
 batadv_orig_node algorithm agnostic
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


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> diff --git a/routing.c b/routing.c
> index d4f512d..5b8f087 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -1091,6 +1091,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
>  	int hdr_size =3D sizeof(*bcast_packet);
>  	int ret =3D NET_RX_DROP;
>  	int32_t seq_diff;
> +	uint32_t seqno;
> =20
>  	/* drop packet if it has not necessary minimum size */
>  	if (unlikely(!pskb_may_pull(skb, hdr_size)))
> @@ -1126,12 +1127,13 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
> =20
>  	spin_lock_bh(&orig_node->bcast_seqno_lock);
> =20
> +	seqno =3D ntohl(bcast_packet->seqno);
>  	/* check whether the packet is a duplicate */
>  	if (batadv_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqno,
> -			    ntohl(bcast_packet->seqno)))
> +			    seqno))
>  		goto spin_unlock;
> =20
> -	seq_diff =3D ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
> +	seq_diff =3D seqno - orig_node->last_bcast_seqno;
> =20
>  	/* check whether the packet is old and the host just restarted. */
>  	if (batadv_window_protected(bat_priv, seq_diff,
> @@ -1142,7 +1144,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
>  	 * if required.
>  	 */
>  	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
> -		orig_node->last_bcast_seqno =3D ntohl(bcast_packet->seqno);
> +		orig_node->last_bcast_seqno =3D seqno;
> =20
>  	spin_unlock_bh(&orig_node->bcast_seqno_lock);

Why are you changing this seqno stuff? Although this might be a valid
(micro-)optimization, I don't think this should be in this patch ... or
at least I don't understand it. :)

Cheers,
	Simon

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlII8PwACgkQrzg/fFk7axbYdQCg0Om1/9ahGeh+QlnvRd+HKb1r
RC8Anii76ar+zq3jTzC7vZWq1TNdxKhg
=bZU2
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
