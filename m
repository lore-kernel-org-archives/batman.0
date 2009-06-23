Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Jun 2009 04:00:28 +0800
References: <20090623150602.GM19149@ma.tech.ascom.ch>
In-Reply-To: <20090623150602.GM19149@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906240400.29017.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] originator tq_avg oscilations
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> I've been playing with B.A.T.M.A.N advanced for a few weeks now.

welcome in the jungle.  :-)


> I've run into a "problem" when one vehicle/node moves away from the
> rest of the vehicles/nodes. It is taking a long time for the mesh to
> realize the node has gone and rebuild the mesh. With a 500ms
> orig_interval in our little test network, pings get lost for an
> average of 26 seconds. The variation is great, sometimes it reroutes
> in 10 seconds, sometimes in 50 seconds.

This is a known issue which is due to the current protocol design and its 
effect is increased by some code defects. 
We have a bunch of ideas how to improve the situation but we wanted to come to 
an end on our current construction sites before opening a new one. Hence we 
released a stable layer 3 version and the kernel module will follow soon 
before touching the routing code again.

If you are willing to test a few things to reduce the effect we can start right 
away. You could set TQ_GLOBAL_WINDOW_SIZE to 1 in order to deactivate the 
averaging of the TQ values. Aslo, some people reported that reducing the hop 
penalty also will increase the speed.

Beyond that we have to modify the code which is on my todo list but will 
become experimental.


> I was surprised to see that its unstable and oscillating. The
> different tq_avg values mostly oscillate together, as shown in the
> figure, but i've also seen cases when they oscillate 180 degrees out
> of phase. In that case, the routing flips on the cross overs.

The TQ is obtained by sending broadcasts which get lost easily. If you have 
interferences / collisions / etc these values might fluctuate a bit. Although 
your values look rather unusual.

Regards,
Marek


