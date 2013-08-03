Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 3 Aug 2013 23:05:13 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130803210512.GB12891@pandem0nium>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
 <1375303667-3018-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <1375303667-3018-3-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 02/10] batman-adv: make struct
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 10:47:39PM +0200, Antonio Quartulli wrote:
>  	/* check whether the packet is a duplicate */
> -	if (batadv_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqno,
> +	if (batadv_test_bit(orig_node->bcast_bits,
> +			    orig_node->last_bcast_seqno,

Is this change really neccesary? Looks rather random to me. :)

>  			    ntohl(bcast_packet->seqno)))
>  		goto spin_unlock;
> =20
> -	seq_diff =3D ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
> +	seqno =3D orig_node->last_bcast_seqno;
> +	seq_diff =3D ntohl(bcast_packet->seqno) - seqno;

Same here ... you are not using the seqno variable below, are you?

> =20
>  	/* check whether the packet is old and the host just restarted. */
>  	if (batadv_window_protected(bat_priv, seq_diff,
> @@ -1125,7 +1128,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
>  	/* mark broadcast in flood history, update window position
>  	 * if required.
>  	 */
> -	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
> +	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits,
> +				  seq_diff, 1))

=2E.. same here.

>  		orig_node->last_bcast_seqno =3D ntohl(bcast_packet->seqno);
> =20
>  	spin_unlock_bh(&orig_node->bcast_seqno_lock);
> diff --git a/types.h b/types.h
> index 0088a53..0c0d999 100644
> --- a/types.h
> +++ b/types.h
> @@ -133,14 +133,28 @@ struct batadv_orig_node_vlan {
>  };
> =20
>  /**
> + * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
> + * @bcast_own: bitfield containing the number of our OGMs this orig_node
> + *  rebroadcasted "back" to us (relative to last_real_seqno)
> + * @bcast_own_sum: counted result of bcast_own
> + * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
> + *  neigh_node->real_bits & neigh_node->real_packet_count

Hmm, neigh_node is not part of this structure, please change the reference
(if it's actually still protecting things).

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH9cIgACgkQrzg/fFk7axYgdQCggcVcfxXviIy/70QdMT64zobq
8BsAn1wRsp8ii5zemg22G16mpaO6Y0zF
=Mg8C
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
