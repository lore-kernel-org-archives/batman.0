Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 14 Feb 2017 09:30:18 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170214083018.GL29718@otheros>
References: <20170213194431.24075-1-linus.luessing@c0d3.blue>
 <20170213200008.GK29718@otheros> <3594207.H7EOxyrbqM@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3594207.H7EOxyrbqM@sven-edge>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: martin@hundeboll.net

On Mon, Feb 13, 2017 at 10:23:52PM +0100, Sven Eckelmann wrote:
> On Montag, 13. Februar 2017 21:00:08 CET Linus Lüssing wrote:
> [...]
> > And one more thing which seems fishy to me in this function:
> > 
> > 526         /* Make room for the fragment header. */
> > 527         if (batadv_skb_head_push(skb, header_size) < 0 ||
> > 528             pskb_expand_head(skb, header_size + ETH_HLEN, 0, GFP_ATOMIC) < 0) {
> > 529                 ret = -ENOMEM;
> > 530                 goto put_primary_if;
> > 531         }
> > 532 
> > 533         memcpy(skb->data, &frag_header, header_size);
> > 
> > 
> > For the pskb_expand_head() case, there is an skb_push(header_size) missing,
> > isn't it?
> 
> I am a little bit confused about your remark... and about the code.
> 
> So let's check what Martin wrote:
> 
>  * get header_size more room in our data section
>  * allocate new buffer to get header_size + ETH_HLEN in front (but not part)
>    of our data section
> 
> If one of these two fails then it will get in panic mode and leave the
> function.

Aiy, I'm sorry, misread that, you are right. Forget my remark.
