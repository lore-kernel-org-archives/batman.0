Return-Path: <andrew@lunn.ch>
Date: Sun, 8 May 2011 14:55:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110508125553.GA4071@lunn.ch>
References: <BANLkTi=jP-N9wR2TMdB6oDEZcLVpROndUg@mail.gmail.com>
	<201105071933.19780.lindner_marek@yahoo.de>
	<BANLkTi=NMtjCDO5461N+mxmKqmDnSpPa+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTi=NMtjCDO5461N+mxmKqmDnSpPa+w@mail.gmail.com>
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

Hi Daniele

> It is not a real Link State routing, the document maybe is not
> completely clear.  Every node before the OGM rebroadcast, attach its
> current best path toward the originator node.  I could do this
> without adding an hop list, but simply substituting the TQ with PCE.

How you tried this? How well does this work?

Not adding path information will be a big help in avoiding routing
loops. It seems to me, just the simple idea of weighting the local TQ
with a bitrate factor might help. 

The hard part is correctly handling the total air time. One 36Mbps hop
is better than two 54Mbps hops, because of the total air time.

It would also be interesting to see how bit rates change with
usage. It could be that you pick a next hop partially based on its bit
rate, which puts load onto the next hop, and its bit rate drops, since
it is now being used more and so suffers more interference. The
dropping bit rate causes the next hop route decision to change.

It could be, you are actually introducing more route flipping.

What would be interesting is to look at the effect of route
flipping. Is it bad for performance? If so, can hysteresis be added
without causing routing loops. There was some work posted here a
couple of months ago that started to look at these
questions. Unfortunately, it did not consider if routing loops would
be introduced.

   Andrew
