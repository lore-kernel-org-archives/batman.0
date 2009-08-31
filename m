Return-Path: <andrew@lunn.ch>
Date: Mon, 31 Aug 2009 07:50:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090831055007.GR16067@lunn.ch>
References: <20090830013647.GA26017@Linus-Debian>
	<20090830073752.GO16067@lunn.ch>
	<20090830202306.GB2410@pandem0nium>
	<200908311326.29339.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908311326.29339.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] development flow
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

On Mon, Aug 31, 2009 at 01:26:29PM +0800, Marek Lindner wrote:
> On Monday 31 August 2009 04:23:06 Simon Wunderlich wrote:
> > Usually we have stable versions (e.g. batman-adv 0.1) with a specific
> > format, and an ongoing development in the svn trunk. Maybe we should do the
> > same for future kernel development - maintaining one packet and algorithm
> > version in the kernel, and further develop the algorithm on our own (e.g.
> > in a git tree or with sets of patches)?
> > In this case, we should post the current batman-adv to the list when
> > 0.2 is stabilized and finished. Mainline algorithm should only be changed
> > when we reach a new stable version.
> 
> Actually, I came to a similar conclusion:
> We "only" submit stable versions to mainline (including stability fixes) 
> whereas the development stays outside of the official linux tree. That way we 
> can keep our development speed without worrying too much about compatibility. 
> When we are getting to the next stable release we can think about how to 
> soften the transition. 

The rules when in staging some somewhat different when in the main
part of the tree.

The point of staging is that it allows cleanup work to be done, fixing
bad practices etc. User space APIs are not baked in stone, since bad
practices in these APIs needs cleaning up etc. So we have some
flexibility here.

Gazing into my crystal ball:

2.6.31 is out 7th September.
2.6.32 merge window ends 21st September.

Maybe GregKH prioritizes main tree patches during the window. staging
is low priority. So batman is not in 2.6.32-rc1.

Batman appears in rc2.

We have around 2 1/2 months time for cleanup work.

Sometime in December 2.6.32 is released with batman in staging.

By the time 2.6.33 is released, March 2010, we are in the main tree.


I would say we have around three months to get 0.2 finished and into
2.6.32 staging. For 2.6.33 we don't break compatibility any more and
aim to finish the cleanup and get into the main tree.

I would also suggest we post our patches as soon as possible, so we
start getting feedback from the kernel community about what else needs
adding to the TODO list etc.

       Andrew

