Return-Path: <andrew@lunn.ch>
Date: Wed, 2 Jun 2010 07:31:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100602053144.GB31330@lunn.ch>
References: <4C058626.4060108@interia.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C058626.4060108@interia.pl>
Subject: Re: [B.A.T.M.A.N.] building testbed for batman-adv and expected
 performance/throughput
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

On Wed, Jun 02, 2010 at 12:13:58AM +0200, Krzysztof Urbas wrote:
> Hello,
> I am writing my master thesis about performance of BATMAN routing
> protocol and so I build a simple testbed consisting of 4 nodes and
> configured them to run batman-adv. But results of my tests are quite
> strange and I don't really know what should I expected.

Hi Krysztof

What is your definition of "performance of BATMAN routing protocol"?
What are you interested in?

Building a testbed using real hardware is actually very hard. There is
so much radio pollution in the 2.4GHz band you can never have
reproducibility and your bandwidths measurements are mostly
meaningless. The question is, do you want real world measurements,
where pollution is normal, or do you want ideal world measurements?

A few suggestions:

Move to 5GHz. There is less pollution, but still some, so your
reproducibility will improve.

Throw away the antennas and use coax cables, splitters and
attenuators. By moving to a wired system, you should be able to block
much of the interference from pollution. It will not be perfect, since
the devices themselves are generally not very well shielded, but it
will make it better. It also gives you better control of the mesh,
since you can determine the attenuation between nodes.

To make your test setup easier to use, add more linux boxes. Each
wireless node should be connected to a linux box as source/sink of the
traffic. Using a second interface network these boxes together on a
separate network. You can then manage these boxes remotely using the
management network, performing tests over the mesh network.

Throw away the hardware and use a software only solution. People have
used qemu to emulate nodes and bridged them together. Take a look at:

http://www.open-mesh.org/wiki/Emulation

	Andrew
