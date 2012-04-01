Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201204020032.37555.lindner_marek@yahoo.de>
References: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
	<20120331204322.GA31423@ritirata.org>
	<CAA_JP8VjODMM-znsQLM-GyxWjXDJ70Y5yjh_EhgokEY3O+iKAg@mail.gmail.com>
	<201204020032.37555.lindner_marek@yahoo.de>
Date: Sun, 1 Apr 2012 16:23:36 -0600
Message-ID: <CAA_JP8VhdK__mRZoL6DY+vPth9wOE6=BqLE5EDpV5rC0RB2kCQ@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] any throughput mechanism or plans?
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

> This approach bears some drawbacks: We can only assess the maximum throughput
> by saturating the link. Saturating the link isn't what we really want to do
> because it means nobody else can use the link to transfer data.
> Furthermore, what if nobody transmits anything whithin your interval ? The
> counters won't increase and the link will be considered "bad" ?
>
> Regards,
> Marek

I am making some assumptions.  I assume that the link will at some
point become saturated.  If we simply track the maximum then we can
advertise an available amount.  This might be tunable to a % of actual
if trying to avoid saturating a link is a goal.

Here is an example

             Y
              |
A---B---C---D---E---X
  \                      /
   F---G---H---I

every node A-I has an equal amount of bandwidth available.  All the
links are the same quality and have the same connection rate. (lets
say 10Mb aggregate)

A is looking for the best route to X, which is the gateway.  TQ says
that A<>X via B and A<>X via F are good, but A<>X via B has a slightly
lower TQ because it is once less hop.

The catch here is that Y is sending traffic through C at a rate of 5Mb
aggregate.  This means that in our route selection, A<>X via B is
identified as the best path because TQ sees clean links with very
little packet loss.  Y is not sending at a rate that saturates C so
performance is still good and TQ is still good.

We should have a mechanism that identifies that although A<>B and A<>F
are both good paths, I should prefer to route through A>F>G>H>I>E>X
because the most restrictive available bandwidth in 10Mb while on
A>B>C>D>E>F>X path, the C node can only provide 5Mb aggregate speed.

How do we identify this? Well, if the C radio has historically
transfered 10Mb (on the interface closest to the gateway) and we have
tracked it, we can take the current 5Mb away from that an see that
there is 5Mb remaining.  This does also assume that a specific
interface has a consistent speed.

Each node could simply ask the next node closest to the gateway the
available speed on the path.  Each node would offer the lowest speed
available, either the upstream nodes advertised speed or it's own.
Since batman-adv only really cares about routing to the next neighbor
with ideal TQ then this method plays right into the batman-adv system.

I don't suggest making throughput the #1 route selection method, only
what would be used if similar quality links where available.  in this
case, A<>B and A<>F are very similar quality so we would use
available throughput in the decision making.  Have a tunable threshold
for TQ vs TQ before this load balancing is taken into account.

Send the throughput information frequently so that as a node takes on
routes due to available bandwidth, it is less likely to be routed
through.

I would add that it is probably a good idea to try to lock in a route
sourced from a single source else the routes might jump around.  If a
client device is downloading at a high speed, once batman-adv has
selected a route, it should stick with it for that client for some
period unless the TQ on the link plummets.  Else a route might jump
back and forth between two paths because as one path gets more
saturated, the other will start looking very interesting and switch,
creating a swinging pattern.

I have another though on how to determine maximum speed but it is more
'destructive'
Have batman-adv do a test on each link for tx, rx, and bi-directional
and store the results and consider these the interfaces potential.
Also identify if an interface is FD or HD.  retest on an interval,
and/or when the TQ on a link is consistently worse than when tested
last.  If the test was thorough enough, it would be able to identify
at what throughput ping times and packet loss spike and have an
effective 'safe' maximum vs absolute maximum.
