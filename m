Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 03:17:26 +0800
References: <1366474654-26361-1-git-send-email-martin@hundeboll.net>
 <1366474654-26361-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366474654-26361-3-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304240317.27196.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Receive fragmented
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

On Sunday, April 21, 2013 00:17:33 Martin Hundeb=C3=B8ll wrote:
> @@ -0,0 +1,372 @@
> +/* Copyright (C) 2012 B.A.T.M.A.N. contributors:

The copyright year could be updated.


> +/**
> + * batadv_frag_clear_list() - Delete entries in the fragment buffer list.
> + * @head: head of list with entries.
> + *
> + * Frees fragments in the passed hlist. Should be called with appropriate
> lock. + */

The kernel doc should not contain "()" following the function name and no=20
capital letter after the hyphen. You do this multiple times ..


> +static void batadv_frag_clear_list(struct hlist_head *head)
> +{
> +	struct batadv_frag_list_entry *entry;
> +	struct hlist_node *node, *node_tmp;
> +
> +	hlist_for_each_safe(node, node_tmp, head) {
> +		entry =3D hlist_entry(node, struct batadv_frag_list_entry, list);
> +		hlist_del(node);
> +		kfree_skb(entry->skb);
> +		kfree(entry);
> +	}
> +}

Why not hlist_for_each_entry_safe() ?


> +/**
> + * batadv_frag_clear_orig() - Free fragments associated to an orig.
> + * @orig_node: Originator to free fragments from.
> + */
> +void batadv_frag_clear_orig(struct batadv_orig_node *orig_node)
> +{
> +	uint8_t i;
> +
> +	for (i =3D 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
> +		spin_lock_bh(&orig_node->fragments[i].lock);
> +		batadv_frag_clear_list(&orig_node->fragments[i].head);
> +		orig_node->fragments[i].size =3D 0;
> +		spin_unlock_bh(&orig_node->fragments[i].lock);
> +	}
> +}
> +
> +/**
> + * batadv_frag_check_orig() - Free timed out fragments from an orig.
> + * @orig_node: originator to check fragments from.
> + *
> + * Check timestamp of every hlist in fragment table and delete all entri=
es
> if + * timed out.
> + */
> +void batadv_frag_check_orig(struct batadv_orig_node *orig_node)
> +{
> +	struct batadv_frag_table_entry *frags;
> +	uint8_t i;
> +
> +	for (i =3D 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
> +		frags =3D &orig_node->fragments[i];
> +		spin_lock_bh(&frags->lock);
> +
> +		if (!hlist_empty(&frags->head) &&
> +		    batadv_has_timed_out(frags->timestamp, BATADV_FRAG_TIMEOUT))
> +			batadv_frag_clear_list(&frags->head);
> +
> +		spin_unlock_bh(&frags->lock);
> +	}
> +}

batadv_frag_clear_orig() and batadv_frag_check_orig() nearly do the same th=
ing=20
except for the timestamp check. Would it be feasible to merge these functio=
ns=20
into one ?


> +/**
> + * batadv_frag_size_limit() - Maximum possible size of fragmented packet.
> + */

Kernel doc mentioning the return value ?


> +static inline int batadv_frag_size_limit(void)

No need to explicitely "inline" the function. The compiler will do this for=
=20
us.


> +/**
> + * batadv_frag_init_list() - Check and prepare fragment buffer for new
> fragment.=20

How about we call individual slices of the large packet "fragments" and the=
=20
list of fragments we buffer "fragment chain" for the sake of clarity ?


> +/**
> + * batadv_frag_insert_packet() - Insert a fragment into an fragment
> buffer.

Same here. The "an" is a typo.


> +	struct batadv_frag_list_entry *new =3D NULL, *curr =3D NULL;
> +	struct batadv_frag_packet *packet;

There seems to be no apparent reason to initialize new and curr ?!
The naming of the three variables "new", "curr" and "packet" make this=20
function hard to read. I understand you try to avoid confusion between the=
=20
different types. Do you feel comfortable with "frag_entry_new",=20
"frag_entry_curr" and "frag_packet" ?


> +/**
> + * batadv_frag_merge_packets() - Merge a list of fragments.
> + * @head: head if list with fragments.
> + * @skb: Packet with total size of skb after merging.
> + *
> + * Expands the first skb in the list and copies the content of the
> remaining + * skb's into the expanded one. After doing so, it clears the
> list. + *
> + * Returns NULL on error.
> + */

Returns the merged skb or NULL on error.


> +	/* Make room for the rest of the fragments. */
> +	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
> +		kfree_skb(skb_out);
> +		goto free;
> +	}

If pskb_expand_head() really fails this function will lead to a crash becau=
se=20
skb_out points to undefined memory.

Btw, is pskb_expand_head() enough to handle all cases ? Did you try this wi=
th=20
a large (4000 bytes or more) packet ?=20


> diff --git a/fragmentation.h b/fragmentation.h
> new file mode 100644
> index 0000000..16d1a62
> --- /dev/null
> +++ b/fragmentation.h
> @@ -0,0 +1,31 @@
> +/* Copyright (C) 2012 B.A.T.M.A.N. contributors:

Copyright year ...


>  #define BATADV_GW_THRESHOLD	50
> +#define BATADV_FRAG_BUFFER_COUNT 8
> +#define BATADV_FRAG_MAX_FRAGMENTS 16
> +#define BATADV_FRAG_MAX_FRAG_SIZE 1400
> +#define BATADV_FRAG_TIMEOUT 10000

Some comments explaining the meaning of these defines would be nice.


> +/**
> + * struct batadv_frag_packet - Network structure for fragments.
> + * @header: Common batman-adv header with type, compatibility version, a=
nd
> ttl. + * @dest: Final destination used when routing fragments.
> + * @orig: Originator of the fragment used when merging the packet.
> + * @no: Fragment number within this sequence.
> + * @reserved: Unused
> + * @seqno: Sequence identification.
> + * @total_size: Size of the merged packet.
> + */
> +struct batadv_frag_packet {
> +	struct  batadv_header header;
> +	uint8_t dest[ETH_ALEN];
> +	uint8_t orig[ETH_ALEN];
> +	uint8_t no:4;
> +	uint8_t reserved:4;
> +	__be16  seqno;
> +	__be16  total_size;
> +} __packed;

If you moved the no/reserved byte between header and dest the packet would =
be=20
properly aligned. Furthermore, the bitfield requires manual endianess=20
"support" (as we recently learned). You might want to check the tvlv patche=
s=20
as reference.

Last but not least, Simon proposed patches to route unicast packets without=
=20
knowing their type. This requires the dest field to be in the right place.=
=20
That is one of the reasons for the BUILD_BUG_ON() macro. You removed the ol=
d=20
one but forgot to add the new fragment check.


> +int batadv_recv_frag_packet(struct sk_buff *skb,
> +			    struct batadv_hard_iface *recv_if)
> +{
> +	struct batadv_priv *bat_priv =3D netdev_priv(recv_if->soft_iface);
> +	struct batadv_orig_node *orig_node_src =3D NULL;
> +	struct batadv_frag_packet *packet;

Same nitpick here: packet isn't that clear - frag_packet would be better.


>@@ -178,6 +206,7 @@ struct batadv_orig_node {
>        spinlock_t in_coding_list_lock; /* Protects in_coding_list */
>        spinlock_t out_coding_list_lock; /* Protects out_coding_list */
> #endif
>+       struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
> };

Kernel doc ?


> @@ -307,6 +336,10 @@ enum batadv_counters {
>  	BATADV_CNT_MGMT_TX_BYTES,
>  	BATADV_CNT_MGMT_RX,
>  	BATADV_CNT_MGMT_RX_BYTES,
> +	BATADV_CNT_FRAG_RX,
> +	BATADV_CNT_FRAG_RX_BYTES,
> +	BATADV_CNT_FRAG_FWD,
> +	BATADV_CNT_FRAG_FWD_BYTES,
>  	BATADV_CNT_TT_REQUEST_TX,
>  	BATADV_CNT_TT_REQUEST_RX,
>  	BATADV_CNT_TT_RESPONSE_TX,

Kernel doc ?

Cheers,
Marek
