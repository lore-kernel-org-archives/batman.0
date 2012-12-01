Return-Path: <ordex@autistici.org>
Date: Sat, 1 Dec 2012 03:23:46 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121201022346.GH24115@ritirata.org>
References: <cover.1354287613.git.martin@hundeboll.net>
 <96863da15554203e10f89fde514157b1acaed698.1354287613.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline
In-Reply-To: <96863da15554203e10f89fde514157b1acaed698.1354287613.git.martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Code and transmit
 packets if possible.
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2012 at 04:08:33PM +0100, Martin Hundeb=C3=B8ll wrote:
> diff --git a/main.h b/main.h
> index 9fd81b8..c738d27 100644
> --- a/main.h
> +++ b/main.h
> @@ -303,4 +303,10 @@ static inline uint64_t batadv_sum_counter(struct bat=
adv_priv *bat_priv,
>  	return sum;
>  }
> =20
> +/* Define a macro to reach the control buffer of the skb. The members of=
 the
> + * control buffer are defined in struct bat_skb_cb in types.h.

is it batadv?				   ^^^

> + * The macro is inspired by the similar macro TCP_SKB_CB() in tcp.h.
> + */
> +#define BATADV_SKB_CB(__skb)       ((struct batadv_skb_cb *)&((__skb)->c=
b[0]))
> +
>  #endif /* _NET_BATMAN_ADV_MAIN_H_ */
> diff --git a/network-coding.c b/network-coding.c
> index 85288f2..ebbe0e9 100644
> --- a/network-coding.c
> +++ b/network-coding.c
> @@ -803,6 +803,396 @@ static struct batadv_nc_path *batadv_nc_get_path(st=
ruct batadv_priv *bat_priv,
>  }
> =20
>  /**
> + * batadv_random_weight_tq - scale the receivers TQ-value to avoid unfair
> + *  selection of a receiver with slightly lower TQ than the other
> + * @tq: to be weighted tq value
> + */
> +static uint8_t batadv_random_weight_tq(uint8_t tq)
> +{

namespace: why didn't you put _nc_ here?

> +	uint8_t rand_val, rand_tq;
> +
> +	get_random_bytes(&rand_val, sizeof(rand_val));
> +
> +	rand_tq =3D rand_val * (BATADV_TQ_MAX_VALUE - tq);
> +	rand_tq /=3D BATADV_TQ_MAX_VALUE;
> +

is this computation worth a comment? with the short description I got "why"=
, but
it would be nice to understand "how", so that we don't forget in the future=
 what
we are doing here exactly?

> +	return BATADV_TQ_MAX_VALUE - rand_tq;
> +}
> +
> +/* Code the bytes from data2 into data1 */
> +static void batadv_memxor(char *data1, const char *data2,
> +				 unsigned int len)

and here?

> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < len; ++i)
> +		data1[i] ^=3D data2[i];
> +}
> +
> +/**
> + * batadv_nc_code_packets - code a received unicast_packet with an nc pa=
cket
> + *  into a coded_packet and send it
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: data skb to forward
> + * @ethhdr: pointer to the ethernet header inside the skb
> + * @nc_packet: structure containing the packet to the skb can be coded w=
ith
> + * @neigh_node: next hop to forward packet to
> + *
> + * Returns true if both packets are consumed, false otherwise.
> + */
> +static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
> +				   struct sk_buff *skb,
> +				   struct ethhdr *ethhdr,
> +				   struct batadv_nc_packet *nc_packet,
> +				   struct batadv_neigh_node *neigh_node)
> +{
> +	const int unicast_size =3D sizeof(struct batadv_unicast_packet);
> +	const int coded_size =3D sizeof(struct batadv_coded_packet);
> +	const int header_add =3D sizeof(struct batadv_coded_packet) -
> +			       sizeof(struct batadv_unicast_packet);

we just have a discussion about assignment over multiple lines like this. It
seems that David doesn't like it that much..please refactor it so that you =
don't
have a two line assignment.
 +

[...]

> +	/* Make room for the larger coded_packet header. */
> +	if (skb_cow(skb_dest, header_add) < 0)
> +		goto out;
> +

what's the purpose of this cow()?


> +	if (skb_linearize(skb_dest) < 0 || skb_linearize(skb_src) < 0)
> +		goto out;
> +
> +	skb_push(skb_dest, header_add);
> +
> +	coded_packet =3D (struct batadv_coded_packet *)skb_dest->data;
> +	skb_reset_mac_header(skb_dest);
> +
> +	coded_packet->header.packet_type =3D BATADV_CODED;
> +	coded_packet->header.version =3D BATADV_COMPAT_VERSION;
> +	coded_packet->header.ttl =3D packet1->header.ttl;
> +
> +	/* Info about first unicast packet */
> +	memcpy(coded_packet->first_source, first_source, ETH_ALEN);
> +	memcpy(coded_packet->first_orig_dest, packet1->dest, ETH_ALEN);
> +	coded_packet->first_crc =3D packet_id1;
> +	coded_packet->first_ttvn =3D packet1->ttvn;
> +
> +	/* Info about second unicast packet */
> +	memcpy(coded_packet->second_dest, second_dest, ETH_ALEN);
> +	memcpy(coded_packet->second_source, second_source, ETH_ALEN);
> +	memcpy(coded_packet->second_orig_dest, packet2->dest, ETH_ALEN);
> +	coded_packet->second_crc =3D packet_id2;
> +	coded_packet->second_ttl =3D packet2->header.ttl;
> +	coded_packet->second_ttvn =3D packet2->ttvn;
> +	coded_packet->coded_len =3D htons(coding_len);
> +
> +	/* This is where the magic happens: Code skb_src into skb_dest */
> +	batadv_memxor(skb_dest->data + coded_size, skb_src->data + unicast_size,
> +		      coding_len);
> +
> +	/* Update counters accordingly */
> +	if (BATADV_SKB_CB(skb_src)->decoded &&
> +	    BATADV_SKB_CB(skb_dest)->decoded) {
> +		/* Both packets are recoded */
> +		count =3D skb_src->len + ETH_HLEN;
> +		count +=3D skb_dest->len + ETH_HLEN;
> +		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE, 2);
> +		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES, count);
> +	} else if (!BATADV_SKB_CB(skb_src)->decoded &&
> +		   !BATADV_SKB_CB(skb_dest)->decoded) {
> +		/* Both packets are newly coded */
> +		count =3D skb_src->len + ETH_HLEN;
> +		count +=3D skb_dest->len + ETH_HLEN;
> +		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE, 2);
> +		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES, count);
> +	} else if (BATADV_SKB_CB(skb_src)->decoded &&
> +		   !BATADV_SKB_CB(skb_dest)->decoded) {
> +		/* skb_src recoded and skb_dest is newly coded */
> +		batadv_inc_counter(bat_priv, BATADV_CNT_NC_RECODE);
> +		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES,
> +				   skb_src->len + ETH_HLEN);
> +		batadv_inc_counter(bat_priv, BATADV_CNT_NC_CODE);
> +		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES,
> +				   skb_dest->len + ETH_HLEN);
> +	} else if (!BATADV_SKB_CB(skb_src)->decoded &&
> +		   BATADV_SKB_CB(skb_dest)->decoded) {
> +		/* skb_src is newly coded and skb_dest is recoded */
> +		batadv_inc_counter(bat_priv, BATADV_CNT_NC_CODE);
> +		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES,
> +				   skb_src->len + ETH_HLEN);
> +		batadv_inc_counter(bat_priv, BATADV_CNT_NC_RECODE);
> +		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES,
> +				   skb_dest->len + ETH_HLEN);
> +	}
> +
> +	/* skb_dest might be the one from nc_packet, so free only skb_src */

might be? what if it is not? or it IS always so?

> +	kfree_skb(skb_src);
> +	nc_packet->skb =3D NULL;
> +	batadv_nc_packet_free(nc_packet);
> +
> +	/* Send the coded packet and return true */
> +	batadv_send_skb_packet(skb_dest, neigh_node->if_incoming, first_dest);
> +	res =3D true;
> +out:
> +	if (router_neigh)
> +		batadv_neigh_node_free_ref(router_neigh);
> +	if (router_coding)
> +		batadv_neigh_node_free_ref(router_coding);
> +	return res;
> +}
> +
> +/**
> + * batadv_nc_skb_coding_possible - Whenever we network code a packet we =
have to
> + *  check whether we received it in a network coded form. If so, we may =
not be
> + *  able to use it for coding because some neighbors may also have recei=
ved
> + *  (overheard) the packet in the network coded form without being able =
to
> + *  decode it. It is hard to know which of the neighboring nodes was abl=
e to
> + *  decode the packet, therefore we can only re-code the packet if the s=
ource
> + *  of the previous encoded packet is involved. Since the source encoded=
 the
> + *  packet we can be certain it has all necessary decode information.

Here I would suggest the same as the other description (in the other patch).
Move the core of the description below and leave here just the flavour, in =
order
to immediately grasp what this function is about, but without entering the
details.

> + * @skb: data skb to forward
> + * @dst: destination mac address of the other skb to code with
> + * @src: source mac address of skb
> + *
> + * Returns true if coding of a decoded packet is allowed.
> + */
> +static bool batadv_nc_skb_coding_possible(struct sk_buff *skb,
> +						 uint8_t *dst,
> +						 uint8_t *src)
> +{
> +	if (BATADV_SKB_CB(skb)->decoded && !batadv_compare_eth(dst, src))
> +		return false;
> +	else
> +		return true;
> +}
> +

[...]

> +/**
> + * batadv_nc_skb_dst_search - Loops through list of neighboring nodes th=
e next
> + *  hop has a good connection to (receives OGMs with a sufficient qualit=
y). We
> + *  need to find a neighbor of our next hop that potentially sent a pack=
et which
> + *  our next hop also received (overheard) and has stored for later deco=
ding.

ehm.. :-)

> + * @skb: data skb to forward
> + * @neigh_node: next hop to forward packet to
> + * @ethhdr: pointer to the ethernet header inside the skb
> + *
> + * Returns true if the skb was consumed (encoded packet sent) or false o=
therwise
> + */
> +static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
> +				     struct batadv_neigh_node *neigh_node,
> +				     struct ethhdr *ethhdr)
> +{
> +	struct net_device *netdev =3D neigh_node->if_incoming->soft_iface;
> +	struct batadv_priv *bat_priv =3D netdev_priv(netdev);
> +	struct batadv_orig_node *orig_node =3D neigh_node->orig_node;
> +	struct batadv_nc_node *nc_node;
> +	struct batadv_nc_packet *nc_packet =3D NULL;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(nc_node, &orig_node->in_coding_list, list) {
> +		/* Search for coding opportunity with this in_nc_node */
> +		nc_packet =3D batadv_nc_skb_src_search(bat_priv, skb,
> +						     neigh_node->addr,
> +						     ethhdr->h_source, nc_node);
> +
> +		/* Opportunity was found, so stop searching */
> +		if (nc_packet)
> +			break;
> +	}
> +	rcu_read_unlock();
> +
> +	if (!nc_packet)
> +		return false;
> +
> +	/* Code and send packets */
> +	if (batadv_nc_code_packets(bat_priv, skb, ethhdr, nc_packet,
> +				   neigh_node))
> +		return true;
> +
> +	/* out of mem ? Coding failed - we have to free the buffered packet
> +	 * to avoid memleaks. The skb passed as argument will be dealt with
> +	 * by the calling function.
> +	 */
> +	batadv_nc_send_packet(nc_packet);
> +	return false;
> +}
>=20


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQuWoyAAoJEADl0hg6qKeOcvoQAJ+HKPbKULt6e5/VazaiNVMk
CVl0Dp7K2xJmNFTeBDI3xTz6or3Brtb5JNYWvkDwuri7up81I5KlxJ1b2APoqCTi
aRWAIFtf6hzblNViIjXbCWsb7DugHYXuU3BMhuA/80Ia4VWSScL4fiWG3HHDsyoC
4kNKV+AnsfODa30QFMsCB+8fEc4Y+eZupUWRbsIvaahOJ0ZfmwuobOAIf1yQ6HFP
eEfBfZhGPbPqBGEyoDS+XJkv8DoatvzKT8Uv8S2vWZSl5Am4uZiZTxDEFYoSWIyq
Xdo4H0Co3cXKiG9ga2fBRnoIynbj24xHV40clZe7+Ij7herLVLkzZh0wWv4V/FBa
EZmNGHoni/seHRutdk2UlNUvs7fkF7IS5dAPwRi++ii80fwfI1RicWTwWTQz7Ic4
BczL99MEhZGBDhDoY4UZqV1Twkeit2qEQ5W+TFK54yPf3vFVgzqz1NObD/2XOXz4
G/1nXalOsmR8g+WIXPuhhY3hMKWvsAC1EVL8hPTkwnBQLKBSvr7oyAx8qEw4Wb0y
sQK5x2eB1vv+vz8zf4Hiyx8BGYq9dbGYyuVlhK+g8CPuwLopdN/nXFPJk+VL1nLf
OHV9S3aL6f73D7wTqRtqXAeGN/sV+/uIk8vGQN0b0xUv+EVKNsaINsxGCMRPwkUR
i9GPWHzeRpbdxWpvaUiW
=pZzU
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
