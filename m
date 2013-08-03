Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 3 Aug 2013 22:57:36 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130803205736.GA12891@pandem0nium>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
 <1375303667-3018-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <1375303667-3018-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 01/10] batman-adv: make struct
 batadv_neigh_node algorithm agnostic
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


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 10:47:38PM +0200, Antonio Quartulli wrote:
> @@ -974,6 +973,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethh=
dr,
>  	uint32_t seqno =3D ntohl(batadv_ogm_packet->seqno);
>  	uint8_t *neigh_addr;
>  	uint8_t packet_count;
> +	unsigned long (*bitmap)[];
> [...]
> @@ -1010,13 +1010,13 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *=
ethhdr,
>  		}
> =20
>  		/* if the window moved, set the update flag. */
> -		need_update |=3D batadv_bit_get_packet(bat_priv,
> -						     tmp_neigh_node->real_bits,
> +		bitmap =3D &tmp_neigh_node->bat_iv.real_bits;
> +		need_update |=3D batadv_bit_get_packet(bat_priv, *bitmap,
>  						     seq_diff, set_mark);
Why referencing and derefencing here? That looks odd, you don't use the bit=
map after that, do you?
> =20
> -		packet_count =3D bitmap_weight(tmp_neigh_node->real_bits,
> +		packet_count =3D bitmap_weight(tmp_neigh_node->bat_iv.real_bits,
>  					     BATADV_TQ_LOCAL_WINDOW_SIZE);
> -		tmp_neigh_node->real_packet_count =3D packet_count;
> +		tmp_neigh_node->bat_iv.real_packet_count =3D packet_count;
>  	}
>  	rcu_read_unlock();
> =20
>  	/* ... and is good enough to be considered */
> -	if (neigh_node->tq_avg < router->tq_avg - BATADV_BONDING_TQ_THRESHOLD)
> +	if (neigh_node->bat_iv.tq_avg <
> +	    router->bat_iv.tq_avg - BATADV_BONDING_TQ_THRESHOLD)
>  		goto candidate_del;

alignment looks a little weird, although this will probably replaced anyway=
 in the later patches?

>  /**
> - * struct batadv_neigh_node - structure for single hop neighbors
> - * @list: list node for batadv_orig_node::neigh_list
> - * @addr: mac address of neigh node
> + * struct batadv_neigh_bat_iv - structure for single hop neighbors
>   * @tq_recv: ring buffer of received TQ values from this neigh node
>   * @tq_index: ring buffer index
>   * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
> - * @last_ttl: last received ttl from this neigh node
> - * @bonding_list: list node for batadv_orig_node::bond_list
> - * @last_seen: when last packet via this neighbor was received
>   * @real_bits: bitfield containing the number of OGMs received from this=
 neigh
>   *  node (relative to orig_node->last_real_seqno)
>   * @real_packet_count: counted result of real_bits
> - * @orig_node: pointer to corresponding orig_node
> - * @if_incoming: pointer to incoming hard interface
>   * @lq_update_lock: lock protecting tq_recv & tq_index
>   * @refcount: number of contexts the object is used
> - * @rcu: struct used for freeing in an RCU-safe manner
>   */
> -struct batadv_neigh_node {
> -	struct hlist_node list;
> -	uint8_t addr[ETH_ALEN];
> +struct batadv_neigh_bat_iv {
>  	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
>  	uint8_t tq_index;
>  	uint8_t tq_avg;
> -	uint8_t last_ttl;
> -	struct list_head bonding_list;
> -	unsigned long last_seen;
>  	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
>  	uint8_t real_packet_count;
> +	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */

I'd like to suggest to split out struct batadv_neigh_bat_iv in an own struc=
t instead
of keeping it in batadv_neigh_node. If you want to keep it there, you shoul=
d at least
do some indendation for the bat_iv specific parts (and maybe also the kerne=
l doc?)

Cheers,
	Simon
=20

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH9bsAACgkQrzg/fFk7axYHRgCbBZY2S5WVBga8Wakw7PMXcIAD
2ooAn09xyz28L7e58akoBpvsvRCjRfHe
=6xps
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
