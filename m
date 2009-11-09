Return-Path: <Juliusz.Chroboczek@pps.jussieu.fr>
From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
References: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
	<006301ca60f7$991ca3a0$f90a8282@sharlyn>
Date: Mon, 09 Nov 2009 18:06:04 +0100
In-Reply-To: <006301ca60f7$991ca3a0$f90a8282@sharlyn> (Mehran Abolhasan's
	message of "Mon, 9 Nov 2009 15:46:16 +1100")
Message-ID: <7iiqdjmxvn.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [B.A.T.M.A.N.] A peer-reviewed assessment of OLSR,
	BATMAN and Babel
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "Dr. Mehran Abolhasan" <mehrana@uow.edu.au>
Cc: olsr-users@lists.olsr.org, b.a.t.m.a.n@lists.open-mesh.net, justin.lipman@gmail.com, Brett Hegelstein <brett.hagelstein@gmail.com>, Chun-Ping Wang <jerryw@uow.edu.au>, babel-users@lists.alioth.debian.org, Brett Hagelstein <bretth@uow.edu.au>

Hello to both of you, and thanks a lot for your paper.

MA:

> 1. The aim of this paper was to study all the protocols in their default
> settings.

I realise that.  My comments were just a quick guide to the paper, to
make it easier for folks to read it, by no way a criticism.

MA:

> We did not switch off ETX with olsr 

CPW:

> The results shown in our paper is actually the performance of OLSR
> with ETX.

In Section IV.A, at the bottom of the first column, you say

   OLSR, which based on hop-count metric, always maintains the minimum
   number of hops for any given destination.

I'd really like this to be clarified, it is part of an ongoing debate in
our community (which I'm not going to summarise right now, since I'm
trying to avoid a flamewar).

MA:

> 3. In terms of overheads, given that this was a small scale indoor
> test-bed, we believed the amount of overhead introduced into the
> network is not signficant enough to adversely affect the network.

I agree.  However, this is the kind of informaton that would be
interesting to me -- Babel extensively uses reactive requests and
updates, and the heuristics used are somewhat tricky to tune.  Packet
count is the information I need in order to know out if I got it right.

(I'm not quite sure what to measure here, but I'd say that the values of
interest are the number of packets sent on average per unit of time, the
average, median and standard derivation of packet size, and the average
interval between two packets -- the latter being an estimate of how
bursty the routing traffic is).

CPW:

> You may also aware the protocols that we used are already out-dated.
> This is because this work was done back in 2008.

The results are still very interesting.  While our routing daemons have
gone through extensive amounts of tuning since then, the basic
principles have not changed, and your paper validates the approaches
that we've taken.

CPW:

> We are more than happy to undergo another study with more recent
> protocols.

That would be excellent.  We all know how time-consuming it is to set up
a testbed and perform quantitative measures, and we're most grateful for
any data you're willing to share.

Two comments:

In Figure 3, you show that Babel tends to have a packet loss rate of 1%.
Since you had redundant routes in your case, and were running normal
802.11 with link-layer ARQ, this should not happen -- and the BATMAN
results show that, indeed, it is possible to have 0% loss rate.

I suspect that the explanation is that Babel ocasionally loses a packet
when it switches routes -- that would be consistent with the RCF given
in Table I.  Do you have any extra data on this test that you'd be
willing to share?  In particular, do you know whether the losses were
evenly distributed, or whether they came in bursts?

Finally, in Section IV.C, you say

  BABEL had the fastest route convergence time with a fastest repair
  time of nine seconds. Interestingly, it was found in the bandwidth
  test that the route changed in as little as two seconds when parallel
  paths were available. This suggests the route preference algorithm is
  more active than the route repair algorithm.

This is, unfortunately, an effect that I don't know how to avoid.  Since
you were running with a Hello interval of 2 seconds, you have shown that
Babel repairs a broken route after 2 to 3 hellos; anything more
aggressive than that, and you risk massive amounts of route flapping,
since a single stray packet could too easily cause a route switch.

However, you have witnessed route flaps happening in two seconds in the
worst case -- given two neighbours A and B, two seconds is the average
time for receiving first a packet from A, then a packet from B; if the
two routes have very similar metrics, slight oscillations of ETX might
cause Babel to switch after just two hellos.

As you justly point out, the two facts put together indicate that the
link cost computation and hysteresis in Babel do not interact quite
right.  This is the most tricky bit of Babel, since it appears to be
a pure engineering tradeoff and I don't see any theoretical arguments to
guide me in its design.

Thanks again for your work,

                                        Juliusz
