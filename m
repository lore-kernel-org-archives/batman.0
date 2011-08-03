Return-Path: <andrew@lunn.ch>
Date: Wed, 3 Aug 2011 18:50:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110803165018.GF9901@lunn.ch>
References: <201108030952.35467.lindner_marek@yahoo.de>
	<20110803083056.GE9901@lunn.ch>
	<201108031639.53966.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201108031639.53966.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] routing code re-organization / the road ahead
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

On Wed, Aug 03, 2011 at 04:39:53PM +0200, Marek Lindner wrote:
> 
> Hi,
> 
> > Looking at the header files, it is not clear to me which contains this
> > routing algo API. Is it bat_ogm.h?
> 
> yes, it is.
> 
> 
> > Has there been any discussion if compile time is sufficient? How about
> > making it a runtime decision? I presume mixing routing algorithms
> > within a mesh is not going to work. However, being able to configure
> > the algorithm per mesh should be possible. This gives a greater degree
> > of interoperability, which might make the Linux Network maintainers
> > happier?
> 
> we discussed various options but at the end decided to move forward with the 
> compile time option. Personally, I doubt many people will want the new routing 
> algorithm until it has been stabilized (we will provide a 'default' option 
> that enables B.A.T.M.A.N. IV).

So it is maybe not needed now, but once the code does start reaching
stability, run time selection becomes more interesting.

> 
> Nevertheless, I am not against having the run time option if someone wants to 
> do it. Are you going to provide the necessary patches ?

Probably not, at least not now.
 
> Where is the interoperability coming from ? The protocols won't be compatible.

Interoperability has many meanings. I've seen it mean the protocol
does not actively destroy the operation of another protocol. I've seen
this in powerline networks. Company X proprietary powerline protocol
is interoperable with HomePlug in that it will not destroy the
HomePlug network if run in parallel with it. It won't talk to it
either...

By making it a runtime option, i don't need to recompile my kernel to
swap from one to the other. I just need "batctl algo V" or "batctl
algo IV". My kernel is interoperable, i just need to configure the
mesh correctly for it to work.

What might also be interesting is
batctl algo IV bat0
batctl algo V bat1
brctl addif br0 bat0
brctl addif br0 bat1

It won't give optimal routes, but it at least gets the two meshs
talking to each other.

> However, we are planing on integrating an extensible header format which 
> allows to add features that will be backward compatible.

Ah, good. Is there any documentation about this?

    Thanks
	Andrew
