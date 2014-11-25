Return-Path: <martin@hundeboll.net>
Message-ID: <5474CCF8.9030008@hundeboll.net>
Date: Tue, 25 Nov 2014 19:39:52 +0100
From: =?windows-1252?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
In-Reply-To: <1416938767-29156-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check size information when
 reassembling fragments
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

Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>

Philipp:
Can you please test this patch, and report back if it fixes your crash?

Thanks!

// Martin

On 2014-11-25 19:06, Sven Eckelmann wrote:
> The fragmentation code doesn't check if the the total_size information of=
 the
> packets inside one chain is consistent. This allows an attacker to inject
> packets belonging to the same fragmentation sequence number with different
> total_size. This can cause a crash when these are assembled because the
> total_size information is only parsed from the first packet in
> batadv_frag_merge_packets but the queueing function always uses the total=
_size
> of the latest packet.
>
> Assume two packets with the size x and y.
>
> 1. first packet is sent with a size x and the total_size x+y' (y' < y)
> 2. second packet is sent with a size y and the total_size x+y
>
> The fragmentation code would try to assemble the two packets because the
> accumulated packets have a combined size of x+y and the second packet had=
 the
> total_size of x+y.
>
> The fragmentation assembling code only took the information from the first
> packet with the total_size x+y' and create a packet with enough space for=
 x+y'
> bytes. But the second packet cannot be copied inside the prepared free sp=
ace
> because it is y-y' bytes larger than the remaining space.
>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This is only build tested. I've never spend time in creation of these pac=
kets
> to verify my claim.
>
>   fragmentation.c | 7 +++++--
>   types.h         | 2 ++
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fragmentation.c b/fragmentation.c
> index 362e91a..3a19d4d 100644
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

--=20
Kind Regards,
Martin Hundeb=F8ll
Frederiks All=E9 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net
