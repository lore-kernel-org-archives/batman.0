Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 03:35:49 +0800
References: <1366474654-26361-1-git-send-email-martin@hundeboll.net>
 <1366474654-26361-4-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366474654-26361-4-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304240335.49403.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Fragment and send skbs
	larger than mtu
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Martin =?utf-8?q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Sunday, April 21, 2013 00:17:34 Martin Hundeb=C3=B8ll wrote:
> Non-broadcast packets larger than MTU are fragmented and sent with
> an encapsulating header. Up to 16 fragments are supported, which are
> sent in reverse order on the wire.

If you explicitely mention the reverse order you should also say why it is=
=20
done that way.


> +/**
> + * batadv_frag_create() - Create a fragment from skb.

Same kernel doc complaints as in the other patch: no parenthesis and no=20
capital letters.


> + * @skb: skb to create fragment from.
> + * @frag_head: header to use in new fragment.
> + * @mtu: Size of new fragment.
> + *
> + * Split the passed skb into two fragments: A new one with size matching
> the + * passed mtu and the old one with the rest. The new skb contains
> data from the + * tail of the old skb.
> + *
> + * Returns the new fragment, NULL on error.
> + */
> +static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
> +					  struct batadv_frag_packet *frag_head,
> +					  unsigned int mtu)
> +{
> +	struct sk_buff *skb_fragment;
> +	unsigned header_size =3D sizeof(*frag_head);
> +	unsigned fragment_size =3D mtu - header_size - ETH_HLEN;
> +
> +	skb_fragment =3D dev_alloc_skb(mtu);
> +	if (!skb_fragment)
> +		goto out_err;
> +
> +	/* Eat the last mtu-bytes of the skb */
> +	skb_reserve(skb_fragment, header_size);
> +	skb_split(skb, skb_fragment, skb->len - fragment_size);
> +
> +	/* Add the header */
> +	skb_push(skb_fragment, header_size);
> +	memcpy(skb_fragment->data, frag_head, header_size);
> +
> +	return skb_fragment;
> +
> +out_err:
> +	return NULL;
> +}

The two return statements can be merged into one.


> +/**
> + * batadv_frag_send_packet() - Create up to 16 fragments from the passed
> skb. + * @skb: skb to create fragments from.
> + * @orig_node: Final destination of the created fragments.
> + * @neigh_node: Next-hop of the created fragments.
> + *
> + * Returns true on success, false otherwise.
> + */
> +bool batadv_frag_send_packet(struct sk_buff *skb,
> +			     struct batadv_orig_node *orig_node,
> +			     struct batadv_neigh_node *neigh_node)
> +{
> +	struct batadv_priv *bat_priv;
> +	struct batadv_hard_iface *primary_if;
> +	struct batadv_frag_packet frag_header;
> +	struct sk_buff *skb_fragment;
> +	unsigned mtu =3D neigh_node->if_incoming->net_dev->mtu;
> +	unsigned header_size =3D sizeof(frag_header);
> +	unsigned max_fragment_size, max_packet_size;
> +
> +	/* To avoid merge and refragmentation at next-hops we never send
> +	 * fragments larger than BATADV_FRAG_MAX_FRAG_SIZE
> +	 */
> +	mtu =3D min_t(int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
> +	max_fragment_size =3D (mtu - header_size - ETH_HLEN);
> +	max_packet_size =3D max_fragment_size*BATADV_FRAG_MAX_FRAGMENTS;

Afaik the linux coding style demands spaces between "*" and its neighbors.


> --- a/types.h
> +++ b/types.h
> @@ -336,6 +336,8 @@ enum batadv_counters {
>  	BATADV_CNT_MGMT_TX_BYTES,
>  	BATADV_CNT_MGMT_RX,
>  	BATADV_CNT_MGMT_RX_BYTES,
> +	BATADV_CNT_FRAG_TX,
> +	BATADV_CNT_FRAG_TX_BYTES,
>  	BATADV_CNT_FRAG_RX,
>  	BATADV_CNT_FRAG_RX_BYTES,
>  	BATADV_CNT_FRAG_FWD,

Kernel doc ?


> @@ -577,6 +579,7 @@ struct batadv_priv {
>  	atomic_t aggregated_ogms;
>  	atomic_t bonding;
>  	atomic_t fragmentation;
> +	atomic_t frag_seqno;
>  	atomic_t ap_isolation;
>  #ifdef CONFIG_BATMAN_ADV_BLA
>  	atomic_t bridge_loop_avoidance;

Kernel doc ?

Cheers,
Marek
