Return-Path: <andrew@lunn.ch>
Date: Thu, 12 Apr 2012 17:36:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120412153625.GP18675@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
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
Cc: Jernej Kos <kostko@unimatrix-one.org>

On Thu, Apr 12, 2012 at 05:13:33PM +0200, Mitar wrote:
> Hi!
> 
> It is possible to announce a network behind a router without exposing
> it on L2? So that you would have nodes and clients meshed in L2, but
> subnets behind nodes are only routed to?
> 
> In what shape is L3 batman implementation?

L3 problems are L3 problems. So you need OSPF, RIP, BPG, etc, to solve
your L3 routing. This works well, i've had OSPF routers talked to each
other over the mesh, so building a routed network of multiple subnets,
some subnets being mesh, some being plain old ethernet.

Your DHCP server could announce a default route which might be enough,
depending on your network topology. BATMAN also has the ability to
filter DHCP requests so that the "nearest" DHCP server replies, and
that server could have a different default route as all the other DHCP
servers on the mesh.

Or, if you are in a transition phase, and don't mind your head
exploding, run olsr, babel, etc, on top of BATMAN to gateway between
the L2 meshes!

	   Andrew

