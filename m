Return-Path: <martin@hundeboll.net>
Message-ID: <547C53C5.7090205@hundeboll.net>
Date: Mon, 01 Dec 2014 12:40:53 +0100
From: =?windows-1252?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1417426648-9319-1-git-send-email-sven@narfation.org>
 <1417426648-9319-2-git-send-email-sven@narfation.org>
In-Reply-To: <1417426648-9319-2-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: Use only queued
 fragments when merging
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

Hi Sven,

On 2014-12-01 10:37, Sven Eckelmann wrote:
> The fragment queueing code now validates the total_size of each fragment,
> checks when enough fragments are queued to allow to merge them into a sin=
gle
> packet and if the fragments have the correct size. Therefore, it is not
> required to have any other parameter for the merging function than a list=
 of
> queued fragments.
>
> This change should avoid problems like in the past when the different skb=
 from
> the list and the function parameter were mixed incorrectly.
>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>   fragmentation.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/fragmentation.c b/fragmentation.c
> index 6e4c957..0ab228f 100644
> --- a/fragmentation.c
> +++ b/fragmentation.c
> @@ -231,19 +231,13 @@ err:
>    * Returns the merged skb or NULL on error.
>    */
>   static struct sk_buff *
> -batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
> +batadv_frag_merge_packets(struct hlist_head *chain)
>   {
>   	struct batadv_frag_packet *packet;
>   	struct batadv_frag_list_entry *entry;
>   	struct sk_buff *skb_out =3D NULL;
>   	int size, hdr_size =3D sizeof(struct batadv_frag_packet);
>
> -	/* Make sure incoming skb has non-bogus data. */
> -	packet =3D (struct batadv_frag_packet *)skb->data;
> -	size =3D ntohs(packet->total_size);
> -	if (size > batadv_frag_size_limit())
> -		goto free;
> -
>   	/* Remove first entry, as this is the destination for the rest of the
>   	 * fragments.
>   	 */
> @@ -252,6 +246,9 @@ batadv_frag_merge_packets(struct hlist_head *chain, s=
truct sk_buff *skb)
>   	skb_out =3D entry->skb;
>   	kfree(entry);
>
> +	packet =3D (struct batadv_frag_packet *)skb_out->data;
> +	size =3D ntohs(packet->total_size);
> +
>   	/* Make room for the rest of the fragments. */
>   	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0)=
 {
>   		kfree_skb(skb_out);
> @@ -307,7 +304,7 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
>   	if (hlist_empty(&head))
>   		goto out;
>
> -	skb_out =3D batadv_frag_merge_packets(&head, *skb);
> +	skb_out =3D batadv_frag_merge_packets(&head);
>   	if (!skb_out)
>   		goto out_err;
>
>

Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>
