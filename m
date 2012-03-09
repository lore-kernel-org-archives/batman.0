Return-Path: <andrew@lunn.ch>
Date: Fri, 9 Mar 2012 15:15:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120309141531.GD16608@lunn.ch>
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<20120309111203.GE15059@kerneis.info>
	<201203091926.54899.lindner_marek@yahoo.de>
	<20120309120455.GF15059@kerneis.info>
	<20120309123905.GB436@ritirata.org>
	<20120309125741.GJ15059@kerneis.info>
	<74A4488FAEEC56408507A6FECA6909910122184D@SC000647.CHASCOM.INT>
	<20120309134928.GL15059@kerneis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120309134928.GL15059@kerneis.info>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh]   Battlemesh v5 tests
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
Cc: battlemesh@ml.ninux.org

On Fri, Mar 09, 2012 at 02:49:28PM +0100, Gabriel Kerneis wrote:
> Andrew,
> 
> On Fri, Mar 09, 2012 at 01:09:26PM +0000, andrew.lunn@ascom.com wrote:
> > Remember that BATMAN is a Layer 2 mesh, not layer 3. 
> 
> Sorry, I just recalled what it implies. 

:-)

> You can ignore my previous answer, I was focused on babel-like,
> layer 3 examples.

       l0        l1
    A ---- B ---------- C  Example:
           \           /   I want to restrict the link l1 to communication
            D -- E -- F    between A??and C. (Nice frying-pan, isn???t it? ;-)


It is still possible, but requires more configuration effort. But
anybody who can setup iptable rules should be able to achieve it.

Create a mesh with B, D, E, F, C, but leave out the interfaces for
B-l0, B-l1 and C-l1. Setup a bridge on B. Add to the bridge the interfaces
bat0, b-l1, b-l0. Add ebtable rules to the bridge to bridge A<->C
frames between b-l0 and b-bl1 interfaces, the rest of the traffic from
A is bridged into the bat0 interface. You need a similar bridge on C,
with ebtable rules to pass the frames over the correct interfaces.

You also need to take a little bit of care with multicast frames, or
the spanning tree protocol might get upset and block some of the
interfaces in order to break the loops it sees.

     Andrew
