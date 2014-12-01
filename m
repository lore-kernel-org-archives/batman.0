Return-Path: <martin@hundeboll.net>
Message-ID: <547C52EF.2060908@hundeboll.net>
Date: Mon, 01 Dec 2014 12:37:19 +0100
From: =?windows-1252?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1417426330-9178-1-git-send-email-sven@narfation.org>
In-Reply-To: <1417426330-9178-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Calculate extra tail
 size based on queued fragments
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

Thanks for looking into this!

On 2014-12-01 10:32, Sven Eckelmann wrote:
> The fragmentation code was replaced in 9b3eab61754d74a93c9840c296013fe3b4=
a1b606
> ("batman-adv: Receive fragmented packets and merge"). The new code provid=
ed a
> mostly unused parameter skb for the merging function. It is used inside t=
he
> function to calculate the additionally needed skb tailroom. But instead of
> increasing its own tailroom, it is only increasing the tailroom of the fi=
rst
> queued skb. This is not correct in some situations because the first queu=
ed
> entry can be a different one than the parameter.
>
> An observed problem was:
>
> 1. packet with size 104, total_size 1464, fragno 1 was received
>     - packet is queued
> 2. packet with size 1400, total_size 1464, fragno 0 was received
>     - packet is queued at the end of the list
> 3. enough data was received and can be given to the merge function
>     (1464 =3D=3D (1400 - 20) + (104 - 20))
>     - merge functions gets 1400 byte large packet as skb argument
> 4. merge function gets first entry in queue (104 byte)
>     - stored as skb_out
> 5. merge function calculates the required extra tail as total_size - skb-=
>len
>     - pskb_expand_head tail of skb_out with 64 bytes
> 6. merge function tries to squeeze the extra 1380 bytes from the second q=
ueued
>     skb (1400 byte aka skb parameter) in the 64 extra tail bytes of skb_o=
ut
>
> Instead calculate the extra required tail bytes for skb_out also using sk=
b_out
> instead of using the parameter skb. The skb parameter is only used to get=
 the
> total_size from the last received packet. This is also the total_size use=
d to
> decide that all fragments were received.
>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Reported-by: Philipp Psurek <philipp.psurek@gmail.com>
> ---
> This is a minimized version which doesn't require the patch
> "[PATCH-maint] batman-adv: Check total_size when reassembling fragments".
> ---
>   fragmentation.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fragmentation.c b/fragmentation.c
> index f14e54a..af16844 100644
> --- a/fragmentation.c
> +++ b/fragmentation.c
> @@ -247,7 +247,7 @@ batadv_frag_merge_packets(struct hlist_head *chain, s=
truct sk_buff *skb)
>   	kfree(entry);
>
>   	/* Make room for the rest of the fragments. */
> -	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
> +	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0) {
>   		kfree_skb(skb_out);
>   		skb_out =3D NULL;
>   		goto free;
>

I noticed the same mistake, when looking into Philipp's issue, but=20
couldn't make wrap my head around it (as to why it should cause the=20
crash). Your description makes sense, and I think my mistake was to=20
forget the inverse tx/rx of fragments.

Anyways:
Acked-by: Martin Hundeb=F8ll <martin@hundeboll.net>
+45 61 65 54 61
martin@hundeboll.net
