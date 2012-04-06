Return-Path: <andrew@lunn.ch>
Date: Fri, 6 Apr 2012 11:13:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120406091320.GB10020@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<20120323063206.GA5662@lunn.ch>
	<201204052330.06655.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201204052330.06655.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] ELP
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

On Thu, Apr 05, 2012 at 11:30:06PM +0300, Marek Lindner wrote:
> 
> Hi Andrew,
> 
> excuse the delayed answers - the wbmv5 was rather intense.  ;-)

I got that impression for the mailing lists... 
 
> On the other hand I think we should move towards throughput based
> path decisions. It tells us so much more about what we really care
> about. Some obstacles are waiting for us if we go down this
> path. Have you ever experimented with this approach ?

Not directly, but we did something in SPAWN which might be relevant.

SPAWN is the automatic deployment of nodes to form a mesh inside a
building. The use case is for firemen deploying nodes behind them to
give mesh access to outside the building.

We want to know the link quality to the last two nodes in the chain as
part of the decision when to deploy the next node in the chain. Due to
work split between partners in the project, and other reasons, BATMAN
is not involved in the deployment, it only gets involved once a node
has been deployed. However, there is obvious overlap here...

The user space code monitors the link quality making use of the
monitor interface of mac80211. One minor change was made in the kernel
that allowed us to set the rate the packet would be sent at from user
space on a packet by packet basis. So we could send probe packets at
different rates and see which got received. You then have some idea of
the link quality, what coding rates work. But it does not necessarily
tell you too much about the link capacity, since you have no idea
about other users of the air-space.

For a research project, such code is O.K. However, for something going
into mainline, i doubt it would be accepted without strong arguments
about why the existing rate control algorithm cannot be used. One
difference is active vs passive. Minstral, as far as i know, makes use
of existing data packets to determine the best coding rate. What the
project built used its own packets. Thus it was faster to react in a
changing environment when there was little traffic, which is the exact
conditions during deployment.

There is a continuum here. What BATMAN has, and probably also OLSR,
Babel, etc, is:

The quality of packets sent using broadcast at 1Mbps.

Using the idea above, probing using different rates we get:

The quality of packets sent using broadcast at X Mbps.

We can build a metric based on (TQ, X), picking X such that TQ is
above some threshold.

If we can get reliable information out of minstral, we get:

X Mbps used for sending unicast packets in the recent past.

but this is a big change. We have lost TQ, but gained unicast to the
specific originator we want the metric for. We no longer need to send
probe packets, so have less overhead, but depend on there being some
traffic in order that minstral can do its thing.

If we send unicast probe packets, and combine it with minstral:

The quality of packets send using unicast at X Mbps.

We have no choice on X, Minstral decides it. This is in fact good,
since the real data also get X. We have a metric based on (TQ, X). How
we actually determine X is interesting. TQ is a moving window
average. Can we do the same for X? Minstral will already be doing some
averaging, so maybe just use the latest value?

So far, we have no idea about available capacity of the link:

Determine X from Minstral. Send a burst of packets forcing them to be
sent at rate X and without retries. Time how long it takes to send the
packets. Compare this with the theoretical time needed, assuming no
congestion, to calculate a congestion factor C.

You now can build a metric based on (TQ, X, C). But you have more
overhead, because you need a burst of unicast packets, and a lot more
complexity, but you have an idea of the free capacity of the link.

	    Andrew
