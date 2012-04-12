Return-Path: <andrew@lunn.ch>
Date: Thu, 12 Apr 2012 20:12:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120412181213.GF7664@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<20120412153625.GP18675@lunn.ch>
	<CAKLmikNQoxEDG-GSN-CG5Ox-=BE0DeL8uOYq_P-e5kA5FfzbDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKLmikNQoxEDG-GSN-CG5Ox-=BE0DeL8uOYq_P-e5kA5FfzbDQ@mail.gmail.com>
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

On Thu, Apr 12, 2012 at 07:12:08PM +0200, Mitar wrote:
> Hi!
> 
> On Thu, Apr 12, 2012 at 5:36 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > Or, if you are in a transition phase, and don't mind your head
> > exploding, run olsr, babel, etc, on top of BATMAN to gateway between
> > the L2 meshes!
> 
> Can you please explain a bit more what are you thinking here?

Well, your infrastructure already speaks olsr, babel, or what every L3
mesh protocol you have. It knows how to advertise additional
routes. So make one or more of your BATMAN nodes L2 mesh also a L3
mesh node. These L3 mesh nodes will see each other over the mesh, and
they will see other L3 mesh nodes over what every network technology
you have between L2 meshes. These L3 mesh nodes should also be the
default router for the devices in the L2 mesh. The L2 mesh devices
will send there packets to a L3 mesh node. It will then route it,
maybe back over the mesh, or maybe over an inter mesh links, to where
ever it needs to go. If ICMP redirect works on your L2 and L3 nodes,
it should add host routes to the L2 nodes when they use the wrong
gateway out of the L2 mesh.

	Andrew
