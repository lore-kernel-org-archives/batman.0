Return-Path: <andrew.lunn@ascom.ch>
Date: Mon, 24 Aug 2009 15:05:09 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090824130509.GP30255@ma.tech.ascom.ch>
References: <20090823130934.GA28556@ma.tech.ascom.ch>
	<200908241702.32201.lindner_marek@yahoo.de>
	<20090824100817.GL30255@ma.tech.ascom.ch>
	<200908242016.20992.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908242016.20992.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Use prinkt instead of debug_log
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

> > Finish stripping out debug_log.
> 
> Probably ok but how do we handle the routing protocol debugging
> stuff ? Should we pipe everything through printk ? Actually, that
> considerably slows down the system because many distros write that
> into a log file.

By default, it would be disabled, at compile time. So for 99% of
users, there is in fact a speedup. Anybody who needs the debug info
would have to recompile the module. Or there are more options. eg The
code is always compiled by default, but needs a module option to
actually enable the output. For those wanting a lean/mean system, the
code can be compile out, etc.
 
> > Make batctl standalone.
> 
> What does that mean ?
 
At the moment, to use batman-adv you need the source to batman,
layer-3, user space daemon in order to get batctl to compile. There
are symbolic links for hash.[ch] and list-batman.[ch]. To the kernel
folks, this dependency will seem a little odd. 
 
> > Maybe make batctl _The_ tool for configuration and status and
> > depreciate direct proc access, so that we can restructure it without
> > too much pain for users.
> 
> Handling everything via ioctls ?

That is probably too far. I would probably keep 
/proc/net/bat0/[originators|transtable_global|transtable_local|vis]. 

where vis contains the actual data.

and create 

/sys/class/batman/bat0/[aggregate_ogm|orig_interval|vis]
 
and here vis controls server/client functionality. Maybe it needs a
different name?

As for configuring interfaces, maybe in the long terms we should be
thinking of commands like:

batctl add bat0
batclt addif bat0 eth1
batclt addif bat0 wlan1

batctl delif bat0 eth1
batctl delif bat0 wlan1
batctl del bat0

The first implementation of this would use interfaces in proc.  Once
the ioctl calls are implemented, you then need a new version of batctl
which uses them. To the user it stay the same. 

Probably the first version would not even support bat1. It is an
interesting question if supporting multiple batman instances is
needed. There could be two overlapping meshs in different
administrative domains. Or maybe in a high redundancy situation, you
run two separate meshes, and duplicate packets to both meshs and
filter out duplicates at the other end. So maybe there are uses?

      Andrew
