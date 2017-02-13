Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 13 Feb 2017 21:00:08 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170213200008.GK29718@otheros>
References: <20170213194431.24075-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170213194431.24075-1-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix transmission of
 final, 16th fragment
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

On Mon, Feb 13, 2017 at 08:44:31PM +0100, Linus Lüssing wrote:
> Trying to split and transmit a unicast packet in 16 parts will fail for
> the final fragment: After having sent the 15th one with a frag_packet.no
> index of 14, we will increase the the index to 15 - and return with an
> error code immediately, even though one more fragment is due for
> transmission and allowed.
> 
> Fixing this issue by moving the check before incrementing the index.
> 
> While at it, adding an unlikely(), because the check is actually more of
> an assertion.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> ---
> 
> Compile time tested only
> ---
>  net/batman-adv/fragmentation.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
> index 0854ebd..f181868 100644
> --- a/net/batman-adv/fragmentation.c
> +++ b/net/batman-adv/fragmentation.c
> @@ -499,6 +499,12 @@ int batadv_frag_send_packet(struct sk_buff *skb,

And one more thing which seems fishy to me in this function:

526         /* Make room for the fragment header. */
527         if (batadv_skb_head_push(skb, header_size) < 0 ||
528             pskb_expand_head(skb, header_size + ETH_HLEN, 0, GFP_ATOMIC) < 0) {
529                 ret = -ENOMEM;
530                 goto put_primary_if;
531         }
532 
533         memcpy(skb->data, &frag_header, header_size);


For the pskb_expand_head() case, there is an skb_push(header_size) missing,
isn't it?
