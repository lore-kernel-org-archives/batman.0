Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 7 May 2019 17:17:23 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v2] batman-adv: Introduce no noflood mark
Message-ID: <20190507151723.GB1493@otheros>
References: <20190507072821.8147-1-linus.luessing@c0d3.blue>
 <3693433.LtgH54LjNc@bentobox> <3691280.TvIfeD7Em7@rousseau>
 <1895475.8kFdyZb9vl@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1895475.8kFdyZb9vl@bentobox>
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

On Tue, May 07, 2019 at 10:21:40AM +0200, Sven Eckelmann wrote:
> On Tuesday, 7 May 2019 10:00:18 CEST Marek Lindner wrote:
> [...]
> > > I still don't see why this has to be implemented in batman-adv and not as an
> > > external filter (tc-ebpf or something like that).
> > 
> > As I understand the use-case (Linus correct me if I am wrong): The mark is 
> > supposed to drop packets that couldn't be $optimized by one of the various 
> > batman-adv payload traffic optimizations. From outside of batman-adv it would be 
> > difficult to tell if a broadcast / multicast packet was optimized (think: served 
> > via DAT cache, sent as unicast, etc) or not.
> 
> It should be easy to see in tc whether a packet is transmitted as unicast or 
> broadcast. It is just a bit check in the destination mac. So it would end up 
> as a filter somewheere in the hardif tx path which first checks following 
> before rejecting a packet:
> 
> * is it a multicast/broadcast destination address?
> 
>   - maybe this part isn't even necessary - at least the mcast2unicast stuff 
>     uses batadv_send_skb_unicast 
> 
> * is it a batman-adv packet?
> * is is a batman-adv compat 15 broadcast packet?
> * does it have the noflood mark?
> 
> This would even allow some fancy stuff like rate limiting or per hardif 
> behavior. With the problem that there is no package yet which does this in 
> gluon.

Ah, that's an interesting idea. So basically filtering on the
hardif instead of in batman-adv via some custom compiled BPF
filters. So basically similar to writing a small program like the
gluon-radv-filterd with a BPF_* parser?

https://github.com/freifunk-gluon/gluon/blob/master/package/gluon-radv-filterd/src/gluon-radv-filterd.c#L223

> Or am I missing something essential here which is also done in the 
> batadv_interface_tx path?

Hm, I guess functionally this would be mostly equivalent. Maybe
except a bit of performance due to our custom queueing
infrastructure. Not sure how much performance it would cost on our
small MIPS devices if a client were sending a few MBit/s of UDP
multicast through our batadv_add_bcast_packet_to_list()
infrastructure.

The noflood-mark would drop the packet early on in batadv_interface_tx(),
before any queueing or copying happens.

Maybe more importantly even before the bcast_packet->seqno is
increased. It could become an issue if a node were increasing it's
seqno quickly without other nodes noticing the new seqnos.
Broadcast packets we actually let through might then be received
with a seqno outside of the seqno window on the receiving nodes.

> And why would we see see stuff which as served via DAT? This is usually not 
> transmitted on the hardif ports.

I guess Marek ment it the other way round (see his "or not" at the
end of his sentence).

Regards, Linus
