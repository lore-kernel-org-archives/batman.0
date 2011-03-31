Return-Path: <andrew@lunn.ch>
Date: Thu, 31 Mar 2011 08:08:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110331060840.GA19781@lunn.ch>
References: <006701cbef3f$b70d9590$2528c0b0$@britton@adelaide.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006701cbef3f$b70d9590$2528c0b0$@britton@adelaide.edu.au>
Subject: Re: [B.A.T.M.A.N.] Modification of BATMAN IV's route selection
 algorithm
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

On Thu, Mar 31, 2011 at 11:35:24AM +1030, Matthew Britton wrote:
> Hi,
> 
> We have just completed a brief research project looking at the performance
> of BATMAN IV in a MANET with directional antennas. We've augmenting BATMAN's
> route selection algorithm with a simple hysteresis mechanism called
> "Batrytis" to reduce route-flapping in some circumstances. Please find
> attached an initial technical report describing our work. You are welcome to
> publish this on your site if you wish, and any feedback would also be
> welcome. We have as yet not published this work, although it may be modified
> into a conference paper later in the year. We probably will not have time to
> extend this work although there are clearly many issues that could be
> explored further.

Hi Matthew

Nice paper.

A few comments and questions....

I would probably remove the directional antenna text from the
paper. There is no real research results presented about the use of
them, they are just a tool to allow your semicircle test to be
made. The work presented here is about hysteresis, and the directional
antenna test in the paper does not really add any value.

Looking at the Batrytis algorithm, it is not clear to me what value of
TQ you put into the redistributed OGMs. Do you use TQ or TQc as the
basis, then add the hop penalty etc? In order to avoid routing loops,
the downstream node makes assumptions about what the upstream node
routing tables contains based on the OGMs it received. I'm wondering
if these assumptions have been invalidated by the hysteresis? Did you
analysis this to see if you had additional routing loops when using
Batrytis? For me this is an important point and if you did look at
this, it should be mentioned in the paper.

I don't know the BATMAN code too well, but in BATMAN-adv, the TQ value
put into the redistributed OGM is of the best link to the
originator. Does BATMAN have this feature? Did you use the best TQc or
the best TQ?

The outdoor test setup is a nice idea. I've always setup a chain of
devices to test handovers. You semi circle is much more compact. Does
the sports field you used also have a 70m circle marked out which you
can follow? It looks like there could be a 35m circle. What
directional antennas did you use? Are they COTS i can buy somewhere?

What i don't like about these outdoor results is that it appears you
did not reproduce the tests exactly. You went in opposite
directions. It would be nice to repeat this experiment a few times,
and always use the same direction.

Overall i like the idea, but i need convincing that it does not
introduce routing loops.

	  Andrew
