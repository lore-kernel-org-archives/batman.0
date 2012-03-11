Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 11 Mar 2012 22:50:39 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120311215039.GA26577@pandem0nium>
References: <1331417873-19354-1-git-send-email-lindner_marek@yahoo.de>
	<1331417873-19354-5-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <1331417873-19354-5-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: avoid temporary routing
 loops by being strict on forwarded OGMs
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey there,

I've tested this patch on my old ring setup which used to create temporary
routing loops, and this patch improved the situation.

Feel free to add:

Tested-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Sun, Mar 11, 2012 at 06:17:53AM +0800, Marek Lindner wrote:
> batman-adv would forward OGMs from non-besthops while replacing the the TQ
> and TTL values with the values from the best hop. In certain corner cases
> this leads to a temporary routing loop.
> This patch changes this behavior: Only packets from best next hops are
> forwarded - TQ and TTL values won't be replaced anymore. However, the pro=
tocol
> needs to rebroadcast OGMs from single hop neighbors regardless of whether=
 or
> not they are the best hop. To handle this case a new flag is introduced to
> alert neighboring nodes about the forwarded OGM that is not from my best
> next hop. It is to be discarded by all nodes except for the one originati=
ng
> the OGM.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  bat_iv_ogm.c |   61 ++++++++++++++++++++++++++++++----------------------=
-----
>  packet.h     |    1 +
>  2 files changed, 33 insertions(+), 29 deletions(-)
>=20
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 1e92e38..85617c4 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -507,11 +507,10 @@ static void bat_iv_ogm_forward(struct orig_node *or=
ig_node,
>  			       const struct ethhdr *ethhdr,
>  			       struct batman_ogm_packet *batman_ogm_packet,
>  			       bool is_single_hop_neigh,
> +			       bool is_from_best_next_hop,
>  			       struct hard_iface *if_incoming)
>  {
>  	struct bat_priv *bat_priv =3D netdev_priv(if_incoming->soft_iface);
> -	struct neigh_node *router;
> -	uint8_t in_tq, in_ttl, tq_avg =3D 0;
>  	uint8_t tt_num_changes;
> =20
>  	if (batman_ogm_packet->header.ttl <=3D 1) {
> @@ -519,41 +518,31 @@ static void bat_iv_ogm_forward(struct orig_node *or=
ig_node,
>  		return;
>  	}
> =20
> -	router =3D orig_node_get_router(orig_node);
> +	if (!is_from_best_next_hop) {
> +		/**
> +		* Mark the forwarded packet when it is not coming from our best
> +		* next hop. We still need to forward the packet for our neighbor
> +		* link quality detection to work in case the packet originated
> +		* from a single hop neighbor. Otherwise we can simply drop the
> +		* ogm.
> +		*/
> +		if (is_single_hop_neigh)
> +			batman_ogm_packet->flags |=3D NOT_BEST_NEXT_HOP;
> +		else
> +			return;
> +	}
> =20
> -	in_tq =3D batman_ogm_packet->tq;
> -	in_ttl =3D batman_ogm_packet->header.ttl;
>  	tt_num_changes =3D batman_ogm_packet->tt_num_changes;
> =20
>  	batman_ogm_packet->header.ttl--;
>  	memcpy(batman_ogm_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
> =20
> -	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
> -	 * of our best tq value */
> -	if (router && router->tq_avg !=3D 0) {
> -
> -		/* rebroadcast ogm of best ranking neighbor as is */
> -		if (!compare_eth(router->addr, ethhdr->h_source)) {
> -			batman_ogm_packet->tq =3D router->tq_avg;
> -
> -			if (router->last_ttl)
> -				batman_ogm_packet->header.ttl =3D
> -					router->last_ttl - 1;
> -		}
> -
> -		tq_avg =3D router->tq_avg;
> -	}
> -
> -	if (router)
> -		neigh_node_free_ref(router);
> -
>  	/* apply hop penalty */
>  	batman_ogm_packet->tq =3D hop_penalty(batman_ogm_packet->tq, bat_priv);
> =20
>  	bat_dbg(DBG_BATMAN, bat_priv,
> -		"Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i=
, ttl_forw: %i\n",
> -		in_tq, tq_avg, batman_ogm_packet->tq, in_ttl - 1,
> -		batman_ogm_packet->header.ttl);
> +		"Forwarding packet: tq: %i, ttl: %i\n",
> +		batman_ogm_packet->tq, batman_ogm_packet->header.ttl);
> =20
>  	batman_ogm_packet->seqno =3D htonl(batman_ogm_packet->seqno);
>  	batman_ogm_packet->tt_crc =3D htons(batman_ogm_packet->tt_crc);
> @@ -949,6 +938,7 @@ static void bat_iv_ogm_process(const struct ethhdr *e=
thhdr,
>  	int is_my_addr =3D 0, is_my_orig =3D 0, is_my_oldorig =3D 0;
>  	int is_broadcast =3D 0, is_bidirectional;
>  	bool is_single_hop_neigh =3D false;
> +	bool is_from_best_next_hop =3D false;
>  	int is_duplicate;
>  	uint32_t if_incoming_seqno;
> =20
> @@ -1070,6 +1060,13 @@ static void bat_iv_ogm_process(const struct ethhdr=
 *ethhdr,
>  		return;
>  	}
> =20
> +	if (batman_ogm_packet->flags & NOT_BEST_NEXT_HOP) {
> +		bat_dbg(DBG_BATMAN, bat_priv,
> +			"Drop packet: ignoring all packets not forwarded from "
> +			"the best next hop (sender: %pM)\n", ethhdr->h_source);
> +		return;
> +	}
> +
>  	orig_node =3D get_orig_node(bat_priv, batman_ogm_packet->orig);
>  	if (!orig_node)
>  		return;
> @@ -1094,6 +1091,10 @@ static void bat_iv_ogm_process(const struct ethhdr=
 *ethhdr,
>  	if (router)
>  		router_router =3D orig_node_get_router(router->orig_node);
> =20
> +	if ((router && router->tq_avg !=3D 0) &&
> +	    (compare_eth(router->addr, ethhdr->h_source)))
> +		is_from_best_next_hop =3D true;
> +
>  	/* avoid temporary routing loops */
>  	if (router && router_router &&
>  	    (compare_eth(router->addr, batman_ogm_packet->prev_sender)) &&
> @@ -1144,7 +1145,8 @@ static void bat_iv_ogm_process(const struct ethhdr =
*ethhdr,
> =20
>  		/* mark direct link on incoming interface */
>  		bat_iv_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
> -				   is_single_hop_neigh, if_incoming);
> +				   is_single_hop_neigh, is_from_best_next_hop,
> +				   if_incoming);
> =20
>  		bat_dbg(DBG_BATMAN, bat_priv,
>  			"Forwarding packet: rebroadcast neighbor packet with direct link flag=
\n");
> @@ -1167,7 +1169,8 @@ static void bat_iv_ogm_process(const struct ethhdr =
*ethhdr,
>  	bat_dbg(DBG_BATMAN, bat_priv,
>  		"Forwarding packet: rebroadcast originator packet\n");
>  	bat_iv_ogm_forward(orig_node, ethhdr, batman_ogm_packet,
> -			   is_single_hop_neigh, if_incoming);
> +			   is_single_hop_neigh, is_from_best_next_hop,
> +			   if_incoming);
> =20
>  out_neigh:
>  	if ((orig_neigh_node) && (!is_single_hop_neigh))
> diff --git a/packet.h b/packet.h
> index 02b0c87..3c4c533 100644
> --- a/packet.h
> +++ b/packet.h
> @@ -47,6 +47,7 @@ enum bat_subtype {
>  #define COMPAT_VERSION 14
> =20
>  enum batman_iv_flags {
> +	NOT_BEST_NEXT_HOP   =3D 1 << 3,
>  	PRIMARIES_FIRST_HOP =3D 1 << 4,
>  	VIS_SERVER	    =3D 1 << 5,
>  	DIRECTLINK	    =3D 1 << 6
> --=20
> 1.7.9.1
>=20
>=20

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9dHi8ACgkQrzg/fFk7axbJ+QCg5TaIOetOvSoTjr5vHCHr4k7M
/6YAoKC76tkASLbl9TuYFKqLTIHXRK2s
=JNhg
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
