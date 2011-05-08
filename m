Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201105071933.19780.lindner_marek@yahoo.de>
References: <BANLkTi=jP-N9wR2TMdB6oDEZcLVpROndUg@mail.gmail.com>
	<201105071933.19780.lindner_marek@yahoo.de>
Date: Sun, 8 May 2011 10:15:41 +0200
Message-ID: <BANLkTi=NMtjCDO5461N+mxmKqmDnSpPa+w@mail.gmail.com>
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

2011/5/7 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>> I have called the new metric PCE (Physical Capacity Estimation), which
>> is defined for each path as the minimum value of (tq_local * bit-rate)
>> among all the link forming it.
>>
>> After a quick and dirty modification of the code, I've done some test
>> on two simple topologies to verify whether there is an improvement or
>> not. From this preliminary test seems that the improvement is
>> remarkable.
>
> thanks for posting your paper. I have a few remarks:
>
> * You claim that route flapping degrades performance more than once in your
> paper without providing detailed explanations. Do you have further proofs /
> observations why and how route flapping leads to performance degradations ? In
> your test setup the performance penalty comes from the fact that a suboptimal
> path is chosen, not because the route changed. You would need to equally good
> paths to test the performance influence of route flapping.
>
You are right, route flapping require a deeper study using equivalent
link and measuring
whether there is a real performance degradation or not.
By the way, the fact that batman changes route frequently is proven.
Certainly I will
do some experiment regarding this aspect.

> * The concept of attaching all hops and their information to the OGM brings us
> dangerously close to the problems other routing protocols suffer from
> (especially Link State): The more a node is away from the source the more its
> information are outdated. Imagine a 10 hop path - how can we rely on this
> information at the end of that path ? Furthermore, by making a decision at the
> end of the path it does not mean the next hop (which has newer information)
> agrees with us on that path. It might send it the packet somewhere else.
> All that depends at which point the bandwidth influences the routing decision.
> Do you mind providing a more precise example how the route switching happens ?
> I hope you thought about loops..
>
It is not a real Link State routing, the document maybe is not completely clear.
Every node before the OGM rebroadcast, attach its current best path toward the
originator node.
I could do this without adding an hop list, but simply substituting
the TQ with PCE.
This modification, as explained in the report, has been done to permit
future addition
of further information about link such as, for example, the load.

> * Taking throughput into the routing equation is an old dream that often
> clashes with reality. Any idea how to solve the following real world issues:
> - Different drivers have different bit-rate APIs (the mac80211 stack is
> supposed to address that but we are not there yet).

This is a major problem, I have based my work to mac 80211 which is the de-facto
future standard. I know it is not very mature but it is promising.
For example it now works also on Foneras..

> - Bit-rates are not a fixed value either - mistrel for example maintains a
> table of 3 different bit-rates. How do you obtain one value ? What about the
> other bit rate algorithms ?

As far as I know, the value given from driver is the current
"best-throughput" one
in the minstrel case. In any case is reported the most used by the
wireless card.

> - How to handle interfaces that have no bit-rate (VPN / cable / etc) ?

I think to read the net-device type and assign for cables their bit-rate
(for example 100 for ethernet device).
Where the bit-rate information instead is not available (old driver
for example..) maybe is better
to assign to bit-rate a value of 0 and use only the TQ for routing decision.
Any suggestion is welcome!!!

> - Bit-rates are a best guess too which might drop rapidly as soon as you try
> to actually use the link.

For the minstrel case, no estimation of bit-rate is done, the bit-rate
is obtained
only measuring real traffic. For the other algorithms I have surely to
do a more accurate research.
In addition I assume that links are used periodically, otherwise why
is routing necessary? :)

>
> Regards,
> Marek
>

Thank you very much for your precious comments!!



PS. thanks Sven Eckelmann for fixing my patch!! :)

-- 
Daniele Furlan
