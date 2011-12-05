Return-Path: <ordex@autistici.org>
Date: Mon, 5 Dec 2011 15:09:16 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111205140915.GA15946@ritirata.org>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<201112051935.06611.lindner_marek@yahoo.de>
	<20111205121342.GD10131@lunn.ch>
	<201112052138.55069.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201112052138.55069.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] switch routing algorithm at runtime
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

On Mon, Dec 05, 2011 at 09:38:54 +0800, Marek Lindner wrote:
> On Monday, December 05, 2011 20:13:42 Andrew Lunn wrote:
> > Changing routing protocol is something you don't want to accidentally
> > do. So i think it should be reasonably hard to do, so you don't get
> > any surprises. I would limit it to when the soft interface is down,
> > and at other times return EBUSY. EBUSY seems like a reasonable good
> > way to indicate the mesh is busy.
> > 
> > However, i think a cleanup call probably is needed, since the routing
> > protocol will probably have its own internal state, memory
> > allocations, etc which needs freeing when the mesh is going down.
> 
> The mesh is not going down when you bring down bat0. You can do whatever you 
> want with bat0 - the mesh continues to operate normally. Only when a hard-
> interface goes down the routing information relying on that very interface are 
> purged.
> 
> Here comes the chicken & egg problem: We can't have bat0 and its routing 
> algorithm selection before we did not add at least one hard-interface.

What about specifying the routing algorithm directly on "soft-iface creation"
and deny any further change?

I discussed a little bit about this with Marek on IRC and we figured out that
the soft-iface is created after writing "bat0" (or any other name) in to the
sysfs. At this point the routing algorithm has not been specified yet, but the
soft-iface has already been created...

As solution I would suggest about splitting the soft-iface creation into two
steps:

1) specify the soft-iface name => create the interface and allocate all the
structure (that are not dependant on the routing algo)

   1.1) the interface is in ALGO-WAITING state, any action that tries to enable it
   is denied and EBUSY (?) is returned.

2) specify the routing algo => launch the routing algo init function and create
all the needed strctures.

   2.1) the interface is now READY


I don't exclude that I wrote something totally wrong :-)

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
