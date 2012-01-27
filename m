Return-Path: <andrew@lunn.ch>
Date: Fri, 27 Jan 2012 20:13:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120127191334.GF27169@lunn.ch>
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<20120127151914.GB19664@lunn.ch>
	<201201272354.26055.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201201272354.26055.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
 shorter routes by changing the default hop penalty
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> So, you had to reduce the default value of 10 to something even smaller ? A 
> hop penalty of 10 results in a penatly of 4% per hop. A rough equivalent of 2 
> lost packets (62/64). Does not sound very much to me. Can you explain your 
> test setup a little more ?

These observations come from a research project made together with
Hochschule Luzern. There is some flyer like documentation in:

www.hslu.ch/t-spawn-project-description_en.pdf

It is a deployable indoor network. The tests i made were with a mesh
of 6 nodes, deployed in a chain. The deployment is intelligent, made
independently of BATMAN. It uses packet probing at the lowest coding
rate to ensure there is always a link to two nodes upstream in the
chain. So you walk along with 5 nodes in your hand. When the algorithm
determines the link upstream to two nodes has reach a threshold, it
tells you to deploy the next mesh node. We kept doing this, along the
corridor, down the steps, along another corridor, through a fire door,
etc, until we were out of nodes.

When iperf was used to measure the traffic from one end of the chain
to the other. With the default hop penalty we got poor
performance. With the traceroute facility of batctl, we could see it
was route flipping between 3 hops and 4 hops. When it used 3 hops, the
packet loss was too high and we got poor bandwidth. Then it went up to
4 hops, the packet loss was lower, so we got more bandwidth.
 
This was repeatable, with each deploy we made.

Then we tried with a lower hop penalty. I think it was 5, but i don't
remember. BATMAN then used 5 hops and there was no route flipping. We
also got the best iperf bandwidth for end to end of the chain.

The fact BATMAN was route flipping with a hop penalty of 10 suggests
to me the links had similar TQ. So OGMs are getting through at the
lowest coding rate. But data packets are having trouble, maybe because
they are full MTU, or because the wifi driver is using the wrong
coding rate.

I suspect the TQ measurements as determined by OGMs are more
optimistic than actual data packets. Linus's played with different NDP
packet sizes, and i think he ended up with big packets in order to
give more realistic TQ measurements.

Unfortunately, this project is now finished. I do have access to the
hardware, but no time allocated to play with it :-(

> Nevertheless, this patch was intended to get a discussion going. 

Well, i'm happy to take part in the discussion. I've no idea if our
use case is typical, or an edge case. So comments, and results from
other peoples networks would be useful.

If this change it to help 11n, maybe some more intelligence would be
better, to ask the wireless stack is the interface abg or n, and from
that determine what hop penalty should be used?

     Andrew
