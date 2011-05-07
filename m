Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 7 May 2011 19:33:18 +0200
References: <BANLkTi=jP-N9wR2TMdB6oDEZcLVpROndUg@mail.gmail.com>
In-Reply-To: <BANLkTi=jP-N9wR2TMdB6oDEZcLVpROndUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105071933.19780.lindner_marek@yahoo.de>
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


Hi,

> I have called the new metric PCE (Physical Capacity Estimation), which
> is defined for each path as the minimum value of (tq_local * bit-rate)
> among all the link forming it.
> 
> After a quick and dirty modification of the code, I've done some test
> on two simple topologies to verify whether there is an improvement or
> not. From this preliminary test seems that the improvement is
> remarkable.

thanks for posting your paper. I have a few remarks:

* You claim that route flapping degrades performance more than once in your 
paper without providing detailed explanations. Do you have further proofs / 
observations why and how route flapping leads to performance degradations ? In 
your test setup the performance penalty comes from the fact that a suboptimal 
path is chosen, not because the route changed. You would need to equally good 
paths to test the performance influence of route flapping.

* The concept of attaching all hops and their information to the OGM brings us 
dangerously close to the problems other routing protocols suffer from 
(especially Link State): The more a node is away from the source the more its 
information are outdated. Imagine a 10 hop path - how can we rely on this 
information at the end of that path ? Furthermore, by making a decision at the 
end of the path it does not mean the next hop (which has newer information) 
agrees with us on that path. It might send it the packet somewhere else. 
All that depends at which point the bandwidth influences the routing decision. 
Do you mind providing a more precise example how the route switching happens ? 
I hope you thought about loops..

* Taking throughput into the routing equation is an old dream that often 
clashes with reality. Any idea how to solve the following real world issues: 
- Different drivers have different bit-rate APIs (the mac80211 stack is 
supposed to address that but we are not there yet).
- Bit-rates are not a fixed value either - mistrel for example maintains a 
table of 3 different bit-rates. How do you obtain one value ? What about the 
other bit rate algorithms ?
- How to handle interfaces that have no bit-rate (VPN / cable / etc) ?
- Bit-rates are a best guess too which might drop rapidly as soon as you try 
to actually use the link.

Regards,
Marek
