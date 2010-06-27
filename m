Return-Path: <xxx@nei.mv.com>
Date: Sun, 27 Jun 2010 14:12:48 -0400 (EDT)
From: RHS Linux User <xxx@nei.mv.com>
In-Reply-To: <201006270259.28362.lindner_marek@yahoo.de>
Message-ID: <Pine.LNX.3.95.1100627140608.1393R-100000@nei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [B.A.T.M.A.N.] batman-adv debug logging (v2)
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


Hi,

   IMHO if the logs are more or less small put them into kernel log. 
That's where I would first look for them.

   If "big" into their own circular log. So I can leave them on and just
look at them when I have a problem to (hopefully) see what led up to the
problem.

   Consider the case where I get an error fatal/non-fatal once every day
or so. I just happen to be sitting there and want to stop and examine the
history file. 

   Comment: There have been a number of subtle Atheros bugs like this
recently. No one knows what is going wrong and now what do we do? Or do we
just grab at straws!!  

   Wouldn't it be nice to put my multichannel recording oscilloscope
probes on several software points and then just review the tracings after
I notice a problem. 

   Just MHO.

   wiz


On Sun, 27 Jun 2010, Marek Lindner wrote:

> On Sunday 27 June 2010 02:47:16 RHS Linux User wrote:
> >    Would have the debugging available VIA the "usual" kernel process mean
> > I could more easily turn on debugging. That is to say: I think I have a
> > problem, I turn on debugging without having to recompile, etc. I can now
> > easily observe what is going wrong and solve my problem more easily?
> 
> No, debugging can be turned on/off at runtime no matter where the logs end up 
> (given you enabled the debugging option at compile time). Both systems behave 
> identical in this aspect.
> The question is: Should the routing logs go into the standard linux log or in 
> a seperate file that only contains batman stuff. 
> 
> Cheers,
> Marek
> 

