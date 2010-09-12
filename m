Return-Path: <an.langer@gmx.de>
Date: Sun, 12 Sep 2010 03:14:48 +0200
From: Andreas Langer <an.langer@gmx.de>
Message-ID: <20100912031448.6f7b11f7@rechenknecht>
In-Reply-To: <201009111126.38504.sven.eckelmann@gmx.de>
References: <20100910184706.151a6728@rechenknecht>
	<1284137300-26277-1-git-send-email-an.langer@gmx.de>
	<201009111126.38504.sven.eckelmann@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: layer2 unicast packet
 fragmentation enhancements
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Am Sat, 11 Sep 2010 11:26:37 +0200
schrieb Sven Eckelmann <sven.eckelmann@gmx.de>:

> Andreas Langer wrote:
> > things that changed since the last patch:
> > - add support to fragment packets on every node,
> >   if outgoing iface mtu is smaller as the packet
> > - add support to defragment packets on every node,
> >   if outgoing iface mtu is >= original size
> > - rename some functions
> 
> Is it possible to split the patch in those parts? It would make it easier to 
> read it and understand the patches later.

I think it makes no sense, it belongs together. But I can put the renaming in an
extra patch. Would that be ok ?

> 
> I haven't checked the patch in detail, but scrolled over it a little bit.
> 
> Andreas Langer wrote:
> > This patch improves the fragmentation by also fragmenting
> > packets that came in via an interface which does not need
> > fragmentation. In addition it reassembles fragmented packets
> > as soon as the interface MTU allows it.
> > 
> > Signed-off-by: Andreas Langer <an.langer at gmx.de>
> > ---
> >  batman-adv/routing.c |   64 +++++++++---------------
> >  batman-adv/unicast.c |  130
> > +++++++++++++++++++++++++++++++++----------------- batman-adv/unicast.h | 
> >  13 ++----
> >  3 files changed, 114 insertions(+), 93 deletions(-)
> > 
> > diff --git a/batman-adv/routing.c b/batman-adv/routing.c
> > index a2c64a4..e975452 100644
> > --- a/batman-adv/routing.c
> > +++ b/batman-adv/routing.c
> > @@ -1142,15 +1142,11 @@ static int route_unicast_packet(struct sk_buff
> > *skb, unsigned long flags;
> >  	struct unicast_packet *unicast_packet;
> >  	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
> > +	int hdr_lenght = sizeof(struct unicast_packet),
> > +	    uni_diff = sizeof(struct unicast_frag_packet) - hdr_lenght;
> > 
> 
> Could you change lenght to length?

yes i can.


> 
> >  	unicast_packet = (struct unicast_packet *)skb->data;
> > 
> > -	/* packet for me */
> > -	if (is_my_mac(unicast_packet->dest)) {
> > -		interface_rx(recv_if->soft_iface, skb, hdr_size);
> > -		return NET_RX_SUCCESS;
> > -	}
> > -
> 
> There are different parts of the patch which makes ma a little bit curious - 
> for example: why it is possible to drop that check entirely? Could that be an 
> extra patch with an explanation why that can be dropped? Is it only valid in 
> context of the new fragmentation handling? .

No it's not in context, recv_unicast_packet and recv_ucast_frag_packet check this,
so it makes no sense to call it again in route_unicast_packet. I'm not sure if it 
came from the first fragmentation patch, i put it extra.

what are the other parts which makes you curious ?

> 
> [...]
> > -static int unicast_send_frag_skb(struct sk_buff *skb, struct bat_priv
> > *bat_priv, -			  struct batman_if *batman_if, uint8_t dstaddr[],
> > -			  struct orig_node *orig_node)
> > +/* if matching fragment found return reassembled skb
> > +   otherwise buffer the fragment */
> 
> Could you change the first three spaces to a " * ". Otherwise checkpatch.pl is 
> unhappy again.
> 
> thanks,
> 	Sven

thanks, andreas

