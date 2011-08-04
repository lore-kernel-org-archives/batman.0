Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 4 Aug 2011 10:29:32 +0200
References: <201108030952.35467.lindner_marek@yahoo.de>
	<201108031639.53966.lindner_marek@yahoo.de>
	<20110803165018.GF9901@lunn.ch>
In-Reply-To: <20110803165018.GF9901@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201108041029.32930.lindner_marek@yahoo.de>
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

On Wednesday, August 03, 2011 18:50:18 Andrew Lunn wrote:
> > we discussed various options but at the end decided to move forward with
> > the  compile time option. Personally, I doubt many people will want the
> > new routing algorithm until it has been stabilized (we will provide a
> > 'default' option that enables B.A.T.M.A.N. IV).
> 
> So it is maybe not needed now, but once the code does start reaching
> stability, run time selection becomes more interesting.

Agreed.


> Interoperability has many meanings. I've seen it mean the protocol
> does not actively destroy the operation of another protocol. I've seen
> this in powerline networks. Company X proprietary powerline protocol
> is interoperable with HomePlug in that it will not destroy the
> HomePlug network if run in parallel with it. It won't talk to it
> either...

There is no difference between compile time and run time option - both won't 
destroy the other.


> By making it a runtime option, i don't need to recompile my kernel to
> swap from one to the other. I just need "batctl algo V" or "batctl
> algo IV". My kernel is interoperable, i just need to configure the
> mesh correctly for it to work.
> 
> What might also be interesting is
> batctl algo IV bat0
> batctl algo V bat1
> brctl addif br0 bat0
> brctl addif br0 bat1
> 
> It won't give optimal routes, but it at least gets the two meshs
> talking to each other.

True. That is an interesting point you are making here.


> > However, we are planing on integrating an extensible header format which 
> > allows to add features that will be backward compatible.
> 
> Ah, good. Is there any documentation about this?

I'll post a follow-up once it is available.

Regards,
Marek
