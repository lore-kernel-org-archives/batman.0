Return-Path: <martin@hundeboll.net>
Message-ID: <547C534E.5010405@hundeboll.net>
Date: Mon, 01 Dec 2014 12:38:54 +0100
From: =?windows-1252?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1417426648-9319-1-git-send-email-sven@narfation.org>
In-Reply-To: <1417426648-9319-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/2] batman-adv: Check total_size when
 queueing fragments
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
Cc: Sven Eckelmann <sven@narfation.org>

Hi,

On 2014-12-01 10:37, Sven Eckelmann wrote:
> The fragmentation code was replaced in 9b3eab61754d74a93c9840c296013fe3b4=
a1b606
> ("batman-adv: Receive fragmented packets and merge") by an implementation=
 which
> handles the queueing+merging of fragments based on their size and the
> total_size of the non-fragmented packet. This total_size is announced by =
each
> fragment. The new implementation doesn't check if the the total_size
> information of the packets inside one chain is consistent.
>
> This is consistency check is recommended to allow using any of the packet=
s in
> the queue to decide whether all fragments of a packet are received or not.
>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This is only compile tested
>
> v3.
>   - withdrawing from inclusion in maint
>   - remove wrong example from the commit message
> v2:
>   - proposed for maint
>   - changed commit message slightly
> ---
>   fragmentation.c | 7 +++++--
>   types.h         | 2 ++
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fragmentation.c b/fragmentation.c
> index 5251aa1..6e4c957 100644
> --- a/fragmentation.c
> +++ b/fragmentation.c
> @@ -161,6 +161,7 @@ static bool batadv_frag_insert_packet(struct batadv_o=
rig_node *orig_node,
>   		hlist_add_head(&frag_entry_new->list, &chain->head);
>   		chain->size =3D skb->len - hdr_size;
>   		chain->timestamp =3D jiffies;
> +		chain->total_size =3D ntohs(frag_packet->total_size);
>   		ret =3D true;
>   		goto out;
>   	}
> @@ -195,9 +196,11 @@ static bool batadv_frag_insert_packet(struct batadv_=
orig_node *orig_node,
>
>   out:
>   	if (chain->size > batadv_frag_size_limit() ||
> -	    ntohs(frag_packet->total_size) > batadv_frag_size_limit()) {
> +	    chain->total_size !=3D ntohs(frag_packet->total_size) ||
> +	    chain->total_size > batadv_frag_size_limit()) {
>   		/* Clear chain if total size of either the list or the packet
> -		 * exceeds the maximum size of one merged packet.
> +		 * exceeds the maximum size of one merged packet. Don't allow
> +		 * packets to have different total_size.
>   		 */
>   		batadv_frag_clear_chain(&chain->head);
>   		chain->size =3D 0;
> diff --git a/types.h b/types.h
> index 462a70c..c4d7d24 100644
> --- a/types.h
> +++ b/types.h
> @@ -132,6 +132,7 @@ struct batadv_orig_ifinfo {
>    * @timestamp: time (jiffie) of last received fragment
>    * @seqno: sequence number of the fragments in the list
>    * @size: accumulated size of packets in list
> + * @total_size: expected size of the assembled packet
>    */
>   struct batadv_frag_table_entry {
>   	struct hlist_head head;
> @@ -139,6 +140,7 @@ struct batadv_frag_table_entry {
>   	unsigned long timestamp;
>   	uint16_t seqno;
>   	uint16_t size;
> +	uint16_t total_size;
>   };
>
>   /**
>

As with the first version:
Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>
