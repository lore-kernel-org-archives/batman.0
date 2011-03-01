Return-Path: <linus.luessing@web.de>
Date: Tue, 1 Mar 2011 09:51:41 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110301085141.GA24189@Sellars>
References: <AANLkTim+tN9NKUUHJqcaaxS-RpWeLQqrUoB0D+=sA0J7@mail.gmail.com>
	<20110228123720.GG4698@lunn.ch>
	<AANLkTikdyLe01RSdet=Y1bZgjnCAUCcbdvJdXyUDSVw=@mail.gmail.com>
	<20110228144820.GH4698@lunn.ch>
	<AANLkTikH6y62sEUUmW9UuXdY=koyDSk5K9Zmnhd6cp7U@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTikH6y62sEUUmW9UuXdY=koyDSk5K9Zmnhd6cp7U@mail.gmail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] OGM overhead and routing metric proposal
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Feb 28, 2011 at 05:00:23PM +0100, Daniele Furlan wrote:
> 2011/2/28 Andrew Lunn <andrew@lunn.ch>:
> >> I'm not a kernel guru but i find out that the new core mac80211 and
> >> cfg80211 (http://linuxwireless.org/) offers the possibility to obtain
> >> a per-station bit-rate information that should be driver independent.
> >
> > O.K. I will take a look at this.
> >
> >> I have not mentioned the hidden node problem. But I think this problem
> >> is very difficult to remove, the only best practice to reduce the
> >> problem is to force the RTS/CTS mechanism to be active.
> >
> > RTS/CTS helps, true. But it has a few problems. e.g. most meshing
> > protocols use broadcast packets for there management. e.g. BATMANs
> > OGMs are broadcast. These cannot be protected with RTS/CTS. So the
> > OGMs can collide with RTS packets from a hidden node, or OGMs from a
> > hidden node.
> >
> In my opinion the use of broadcast is somehow useful. If many OGM
> packet collide it means that the link is congested and batman will use
> another.
And what if the other link is not really useful for e.g. TCP?
batman would switch to that link then anyway. At least that's what
I had been experiencing in some indoor scenarios here. The hidden
node can lead to degrading the measured LQ values from ~90% down to
< 10% packet delivery ratio.
> It would be wrong to protect OGM from collision or hidden node.
So I'd not quite agree with that.

But I'm actually also a little confused why you, Andrew, came up
with the hidden node problem :) (which these papers did not try to
solve, if I'm not missing something). Or do you mean, that this
idea could be extended maybe be able to solve that hidden node
problem for OGMs, using the bitrate measuremens to detect / avoid
switching to bad links?

> 
> > Another way to help reduce the hidden node problem, or interference
> > with other nodes, is to use a low coding rate and transmit power when
> > possible. So for example when we don't have much traffic to send to
> > node X, it could send the packets with the lowest coding rate and low
> > power. This keeps the interference with other nodes to a minimum. As
> > the amount of data for X increases, the coding rate and transmit power
> > can be increased, so increasing the available bandwidth to X, but at
> > the same time increasing the amount of interference the traffic
> > produces.
> >
> Yes, I think that it is always better to use low transmission power
> and favor multi-hop so short link, especially in dense network. The
> schema I propose effectively favor short link offering the possibility
> of reducing transmission power.
> Anyhow a transmission power management system is out of the scope of
> my work, but it is a very interesting area. It is certainly possible
> to add transmission power level to OGM in order to use also this
> information in routing decision. More information we now of link and
> more accurate will be the routing decisions.
> 
> > Such a scheme to minimize interference does not play too well with
> > your idea of putting the coding rate into the OGMs. We would have to
> > ensure that the coding rate is the highest possible coding rate usable
> > between two peers, not the currently used coding rate, which could be
> > low in order to avoid interference.
> >
> The current rate is decided by the driver basing on link quality and
> collision so indirectly tells us how much interference there are in
> the link. Why it is a bad idea to use this information?
Hmm, I guess that depends on the interference pattern a lot.
Afaik minstrel for instance is one of the rate selection
algorithms which can chose higher enconding rates to reduce
interference in case of bursty loss. So when your rate selection
algorithm selects 54MBit/s, that does not necessarily mean that
you have a higher net throughput / that the link is "better"
compared to another link where the rate selection algorithm has chosen
for instance 36MBit/s. So to make the selected rate information
somehow useful, you'd have to take the loss rates at that
enconding rate into account too.

> 
> >> > Will you be at the WBMv4 next Month?
> >> >
> >> I'm afraid but I cannot be at WMBv4, I hope I can come to the next
> >> WBM, maybe with a working implementation :)
Hmm, what a pitty. But, ok, see you next time then :).

> >
> > Shame, i plan to talk more about the hidden node problem during WBMv4.
> > It is also a good place to discuss new ideas like adding information
> > into the OGMs.
> >
> >     Andrew
> >

Nice papers there, thanks for sharing! Just looked at them briefly
so far but seems very interesting.

Cheers, Linus
> 
> 
> 
> -- 
> Daniele Furlan
> 

PS: Just one thing I noticed so far, isn't it possible to simplify
the formula B = 1 + \sum^{N\\{0\}}_{k \in N} p^{l_{o,k}} to just:
B = \sum_{k \in N} p^{l_{o,k}}? p^{l_{o,k}} is already 1 for k = o
isn't it?
