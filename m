Return-Path: <ordex@autistici.org>
Date: Wed, 15 May 2013 09:22:07 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130515072207.GB3350@ritirata.org>
References: <1368476582-19220-1-git-send-email-martin@hundeboll.net>
 <1368476582-19220-3-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <1368476582-19220-3-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: Receive fragmented
 packets and merge
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


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 13, 2013 at 10:23:01PM +0200, Martin Hundeb=C3=B8ll wrote:

[...]

> +/**
> + * batadv_frag_size_limit - maximum possible size of packet to be fragme=
nted.
> + *
> + * Returns the maximum size of payload that can be fragmented.
> + */
> +static int batadv_frag_size_limit(void)
> +{
> +	int limit =3D BATADV_FRAG_MAX_FRAG_SIZE;

a blank line should go here

> +	limit -=3D sizeof(struct batadv_frag_packet);
> +	limit *=3D BATADV_FRAG_MAX_FRAGMENTS;
> +	return limit;
> +}
> +
> +/**
> + * batadv_frag_init_chain - check and prepare fragment chain for new fra=
gment.
> + * @chain: Chain in fragments table to init.
> + * @seqno: Sequence number of the received fragment.
> + *
> + * Make chain ready for a fragment with sequence number "seqno". Delete =
existing
> + * entries if they have an "old" sequence number.
> + *
> + * Returns true if chain is empty and caller can just insert the new fra=
gment
> + * without searching for the right position.
> + *
> + * Caller must hold chain->lock.
> + */
> +static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
> +				   uint16_t seqno)
> +{
> +	if (chain->seqno =3D=3D seqno)
> +		return false;
> +
> +	if (!hlist_empty(&chain->head))
> +		batadv_frag_clear_chain(&chain->head);
> +
> +	chain->size =3D 0;
> +	chain->seqno =3D seqno;
> +
> +	return true;
> +}
> +
> +/**
> + * batadv_frag_insert_packet - insert a fragment into a fragment chain.
> + * @orig_node: Originator that the fragment was received from.
> + * @skb: skb to insert.
> + * @head: head to attach complete chains of fragments to.
> + *
> + * Insert a new fragment into the reverse ordered chain in the right tab=
le
> + * entry. The hash table entry is cleared if "old" fragments exist in it.
> + *
> + * Returns true if skb is buffered, false on error. If the chain has all=
 the
> + * fragments needed to merge the packet, the chain is moved to the passe=
d head
> + * to avoid locking the chain in the table.
> + */
> +static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
> +				      struct sk_buff *skb,
> +				      struct hlist_head *chain_out)
> +{
> +	struct batadv_frag_table_entry *chain;
> +	struct batadv_frag_list_entry *frag_entry_new, *frag_entry_curr;
> +	struct batadv_frag_packet *frag_packet;
> +	uint8_t bucket;
> +	uint16_t seqno, hdr_size =3D sizeof(struct batadv_frag_packet);
> +
> +	if (skb_linearize(skb) < 0)
> +		goto err;
> +

I guess the skb is linearised here so that, later, during the merge, the sk=
bs
can be copied by means of memcpy. I think you should put a comment here to
explain why this skb_linearise is done, otherwise it seems to be unrelated =
to
everything since the skb data is not accessed in this function (I guess we =
do it
here and not in the merge function so that we do one linearisation at a time
instead of linearising all the fragments at once).

Moreover, I'll add a todo saying that we may want to optimise fragmented sk=
bs
manipulation in the future and avoid this linearisation at all.

> +	frag_packet =3D (struct batadv_frag_packet *)skb->data;
> +	seqno =3D ntohs(frag_packet->seqno);
> +	bucket =3D seqno % BATADV_FRAG_BUFFER_COUNT;
> +
> +	frag_entry_new =3D kmalloc(sizeof(*frag_entry_new), GFP_ATOMIC);
> +	if (!frag_entry_new)
> +		goto err;
> +
> +	frag_entry_new->skb =3D skb;
> +	frag_entry_new->no =3D frag_packet->no;
> +
> +	/* Select entry in the "chain table" and delete any prior fragments
> +	 * with another sequence number. batadv_frag_init_chain() returns true,
> +	 * if the list is empty at return.
> +	 */
> +	chain =3D &orig_node->fragments[bucket];
> +	spin_lock_bh(&chain->lock);
> +	if (batadv_frag_init_chain(chain, seqno)) {
> +		hlist_add_head(&frag_entry_new->list, &chain->head);
> +		chain->size =3D skb->len - hdr_size;
> +		chain->timestamp =3D jiffies;
> +		goto out;
> +	}
> +
> +	/* Find the position for the new fragment. */
> +	hlist_for_each_entry(frag_entry_curr, &chain->head, list) {
> +		/* Drop packet if fragment already exists. */
> +		if (frag_entry_curr->no =3D=3D frag_entry_new->no)
> +			goto err_unlock;
> +
> +		/* Order fragments from highest to lowest. */
> +		if (frag_entry_curr->no < frag_entry_new->no) {
> +			hlist_add_before(&frag_entry_new->list,
> +					 &frag_entry_curr->list);
> +			chain->size +=3D skb->len - hdr_size;
> +			chain->timestamp =3D jiffies;
> +			goto out;
> +		}
> +	}
> +
> +	/* We reached the end of the list, so insert after 'frag_entry_curr'. */
> +	if (likely(frag_entry_curr)) {
> +		hlist_add_after(&frag_entry_curr->list, &frag_entry_new->list);
> +		chain->size +=3D skb->len - hdr_size;
> +		chain->timestamp =3D jiffies;
> +	}
> +
> +out:
> +	if (chain->size > batadv_frag_size_limit() ||
> +	    ntohs(frag_packet->total_size) > batadv_frag_size_limit()) {
> +		/* Clear chain if total size of either the list or the packet
> +		 * exceeds the maximum size of one merged packet.
> +		 */
> +		batadv_frag_clear_chain(&chain->head);
> +		chain->size =3D 0;
> +	} else if (ntohs(frag_packet->total_size) =3D=3D chain->size) {
> +		/* All fragments received. Hand over chain to caller. */
> +		hlist_move_list(&chain->head, chain_out);
> +		chain->size =3D 0;
> +	}
> +
> +	spin_unlock_bh(&chain->lock);
> +	return true;
> +
> +err_unlock:
> +	spin_unlock_bh(&chain->lock);
> +	kfree(frag_entry_new);
> +err:
> +	return false;
> +}
> +

[...]

> =20
> +/*
> + * batadv_recv_frag_packet() - Process received fragment.
> + * @skb:     The received fragment.
> + * @recv_if: Interface that the skb is received on.
> + *
> + * This function does one of the three following things: 1) Forward frag=
ment, if
> + * the assembled packet will exceed our MTU; 2) Buffer fragment, if we t=
ill
> + * lack further fragments; 3) Merge fragments, if we have all needed par=
ts.
> + *
> + * Returns NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherw=
ise.
> + */
> +int batadv_recv_frag_packet(struct sk_buff *skb,
> +			    struct batadv_hard_iface *recv_if)
> +{
> +	struct batadv_priv *bat_priv =3D netdev_priv(recv_if->soft_iface);
> +	struct batadv_orig_node *orig_node_src =3D NULL;
> +	struct batadv_frag_packet *frag_packet;
> +	int ret =3D NET_RX_DROP;
> +
> +	if (batadv_check_unicast_packet(bat_priv, skb,
> +					sizeof(*frag_packet)) < 0)
> +		goto out;
> +
> +	frag_packet =3D (struct batadv_frag_packet *)skb->data;
> +	orig_node_src =3D batadv_orig_hash_find(bat_priv, frag_packet->orig);
> +	if (!orig_node_src)
> +		goto out;
> +
> +	/* Route the fragment if it is not for us and too big to be merged. */
> +	if (!batadv_is_my_mac(bat_priv, frag_packet->dest) &&
> +	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src)) {
> +		ret =3D NET_RX_SUCCESS;
> +		goto out;
> +	}
> +
> +	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_RX);
> +	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_RX_BYTES,
> +			   skb->len + ETH_HLEN);

why adding ETH_HLEN ? skb->len already counts the outer Ethernet header, no?

> +
> +	/* Add fragment to buffer and merge if possible. */
> +	if (!batadv_frag_skb_buffer(&skb, orig_node_src))
> +		goto out;
> +
> +	/* Deliver merged packet to the appropriate handler, if it was
> +	 * merged
> +	 */
> +	if (skb)
> +		batadv_batman_skb_recv(skb, recv_if->net_dev,
> +				       &recv_if->batman_adv_ptype, NULL);
> +
> +	ret =3D NET_RX_SUCCESS;
> +
> +out:
> +	if (orig_node_src)
> +		batadv_orig_node_free_ref(orig_node_src);
> +
> +	return ret;
> +}
>

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRkzefAAoJEADl0hg6qKeOdXYQAJSfCQMRTkm5a0K+YTO7IRQl
upuYQp94pbnvmdLStkpri5FRpgv5EdnW5l3Y0V2zNHASdOlRRUyTUe3sDax5dki0
usKRB/qUpSs6x9GqFuMawLLpM0j7PT4cayhvq6NBt6g7rW9/G0xEIYeuRQSjihcE
tyJRoG8INihhmihFDEfy9GFSYlB2lwvmxi1rewKcNWOFDtkUdBEod6VBoXdxlSVg
3m1fljdqxPS8jaeaN3jyRcyaAal5Of3Uz0HfNB3YHxKjkzpdrteR2PgNyYSnPHfE
MIkKmMNrkaDvlidvYTpPFPpXWZA04mg5q2H0gL7kbwCRCKs/s/Om/5AN7Am6Wyw/
YGno24YtRgxZjU2ntxATHNk+RrVSVL1PzDfgKdTij+VZZO5AOGOhSW5Gv7U4C3bp
FheocZ6IsVJUpPrNUtQk7nPoS2SqIElq1IWlLzoEyBYCgTJAcVYek43Dt1t5Dw5V
4bc+rNc/Zr6V5BWRPYTYpzHMGPu0In/IXX3OLELjgvKNcF2Lyn6i/aGAfCIU7Jha
juSYZgVA2TcaqNKC0fNBbMJFw15kkxRp9I7rR1uG1bhIh1nvQPwaax3FiGpQEYv5
YasgNsxfz3cg0D6zA9hlv1h9B0KedYbnoMYEEppr21FMfxC6A1pF6J4VbdZt/z/T
jLCYo5agU3y8IGTaShGS
=nehi
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
