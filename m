Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201105081528.06184.lindner_marek@yahoo.de>
References: <BANLkTi=jP-N9wR2TMdB6oDEZcLVpROndUg@mail.gmail.com>
	<201105071933.19780.lindner_marek@yahoo.de>
	<BANLkTi=NMtjCDO5461N+mxmKqmDnSpPa+w@mail.gmail.com>
	<201105081528.06184.lindner_marek@yahoo.de>
Date: Sun, 8 May 2011 17:12:53 +0200
Message-ID: <BANLkTinnvguraeAvVkbvG-7pN_vCdpeuHg@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Routing improvement taking into account links
	bit-rate
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

2011/5/8 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>> > * The concept of attaching all hops and their information to the OGM
>> > brings us dangerously close to the problems other routing protocols
>> > suffer from (especially Link State): The more a node is away from the
>> > source the more its information are outdated. Imagine a 10 hop path -
>> > how can we rely on this information at the end of that path ?
>> > Furthermore, by making a decision at the end of the path it does not
>> > mean the next hop (which has newer information) agrees with us on that
>> > path. It might send it the packet somewhere else. All that depends at
>> > which point the bandwidth influences the routing decision. Do you mind
>> > providing a more precise example how the route switching happens ? I
>> > hope you thought about loops..
>>
>> It is not a real Link State routing, the document maybe is not completely
>> clear. Every node before the OGM rebroadcast, attach its current best path
>> toward the originator node. I could do this without adding an hop list, but
>> simply substituting the TQ with PCE. This modification, as explained in the
>> report, has been done to permit future addition of further information about
>> link such as, for example, the load.
>
> No, it is not exactly like Link State but it goes into the same direction. The
> problem is this: The more information you propagate through the mesh the more
> you have to pay attention to not make decisions based on outdated data. In a 4
> node testbed you will not see this but as your mesh grows you will.
> Your document explains how the PCE is calculated but I could not find the
> section which explains how every individual node comes to a routing decision.
> That part is essential for the routing loops.

You are perfectly right. I will revise the report as soon as possible
to add this information.
Certainly routing loops are the worse problem that can occur, so I
will think deeply on it.
Thanks for the suggestion!

> In addition you gain no value by sending all these information. Even if every
> node had up-to-date information about all other nodes in the mesh and made a
> decision based on that, the next hop can come to a completely different
> decision and sends the packet somewhere else. That is one of the main reason
> why I don't see the multipath routing to work as you envision in the paper.
>
mmh..if I have up-to-date information, maybe using the OGM sequence number
I can tell my neighbor use a specific path, in particular the best
path that there was when that
specific OGM traversed the network.
And this can be valid also for an hypothetical multi-path routing.

Now that I think on it, with this trick can be demonstrated also the
absence of routing loops
because in every moment I know the path that a packet will follow.
>
>> > - Bit-rates are not a fixed value either - mistrel for example maintains
>> > a table of 3 different bit-rates. How do you obtain one value ? What
>> > about the other bit rate algorithms ?
>>
>> As far as I know, the value given from driver is the current
>> "best-throughput" one in the minstrel case. In any case is reported the most
>> used by the wireless card.
>
> Ok, your results are not accurate then. Not sure whether this is a problem or
> not.
>
>
>> > - Bit-rates are a best guess too which might drop rapidly as soon as you
>> > try to actually use the link.
>>
>> For the minstrel case, no estimation of bit-rate is done, the bit-rate
>> is obtained only measuring real traffic. For the other algorithms I have
>> surely to do a more accurate research.
>
> What makes you think this is not an "estimation" ? On wireless you never know
> the actual throughput unless you use the link. Even then the outcome is highly
> variable depending on whether you have neighboring nodes that also send
> traffic, whether there is a sudden interference (microwave is turned on) and
> so forth and so on.
>
As answered to Andrew Lunn, I can exploit the bit-rate variability
that summarize many
aspects of a link (load, node distance, microwave oven, ..). So we can
carefully, use this info,
opportunely averaged over time to obtain a better description of a link.
>
>> In addition I assume that links are used periodically, otherwise why is
>> routing necessary? :)
>
> You assume a steady flow of data which rarely is the case. Imagine a user
> surfing the web - you'll have peaks of traffic and then longer periods of no
> traffic. During the peak time the bandwidth estimate will drop and recover
> quickly as soon as the link is not used anymore (I have seen that many times).
>
As said before, this is not necessarily a defect, is a better
understanding of link conditions.
When load is heavy in a sector of the network, packet are routed in
another direction as actually
happens also with current batman (and this is much valuable!!!!!!)

> Cheers,
> Marek
>
>



-- 
Daniele Furlan
