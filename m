Return-Path: <andrew@lunn.ch>
Date: Fri, 13 Apr 2012 10:15:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120413081501.GJ7664@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
	<CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikNJMzdMSgCkHjf5xNWM0ibEWW+W9BPrskJjaL0b_8VK4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKLmikNJMzdMSgCkHjf5xNWM0ibEWW+W9BPrskJjaL0b_8VK4g@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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
Cc: Mitar <mitar@tnode.com>

On Fri, Apr 13, 2012 at 09:58:26AM +0200, Mitar wrote:
> Hi!
> 
> On Fri, Apr 13, 2012 at 7:59 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> > This comes back to:
> >
> > ?? ?? You need, in your head, a clear separation between L3 and L2.
> 
> :-)
> 
> OK, maybe I am getting a bit of hold on this. :-)
> 
> OK, so if we would like to provide a way for all nodes to also
> announce their L3 subnets which are maybe behind them, we should run
> additional L3 routing protocol between them so that they can exchange
> information about those subnets and configure routes accordingly.
> Which routing protocol are you proposing for such task?

How many subnets do you think you will have? Are they all using
classful networks or classless network?

http://en.wikipedia.org/wiki/Classful_network
http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing

If you have a small network which is classful, you could use RIP.

http://en.wikipedia.org/wiki/Routing_Information_Protocol

Otherwise, i would probably use ospf.
http://en.wikipedia.org/wiki/Ospf

OSPF is much more scale-able, and typically used for enterprise
networks. If you are considering joining this network to some other
network, you are probably going to end up using OSPF, or maybe BGP as
the protocol between the networks. OSPF is designed for this sort of
multi-organizational networks.

quagga is a well used suite of routing protocols.
http://www.nongnu.org/quagga/

	Andrew
