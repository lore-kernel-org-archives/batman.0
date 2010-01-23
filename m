Return-Path: <andrew@lunn.ch>
Date: Sat, 23 Jan 2010 12:14:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100123111427.GM24649@lunn.ch>
References: <20100122100238.GL24649@lunn.ch>
	<201001231127.30577.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001231127.30577.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] State of batman-adv in mainline
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

On Sat, Jan 23, 2010 at 11:27:30AM +0800, Marek Lindner wrote:
> 
> Hey,
> 
> > Our first patch landed by GregKH just before the merge window for
> > 2.6.33 opened. This patch made it into 2.6.33-rc1. So at around the
> > end of march when 2.6.33 is released, we will be in mainline.
> > 
> > All patches submitted after this first big one was after the merge
> > window closed. So they are currently queued up by GregKH. They appear
> > in linux-next and should be accepted during the 2.6.34 merge window.
> 
> thanks a lot for posting this overview!
> 
> 
> > 1) We should make it clear on www.open-mesh.org which version of
> >    batctl should be used with 2.6.33. The trunk version will not work
> >    correctly, an older version is needed. Probably we want to make a
> >    tarball release and put it somewhere prominent on the website.
> 
> Since a while I maintain batctl 0.2.x in its own branch:
> http://www.open-mesh.org/browser/branches/batctl-0.2.x
> As the name implies it should be compatible with batman-adv 0.2.x. It does not 
> contain any links and will build right out of this branch.
> Are there any known incompatibilities between batman-adv in 2.6.33 and this 
> branch ?

Well, 2.6.33 will have the in kernel dot/json formatting. So the vis
stuff in batctl 0.2.x is useless. 0.2.x however no longer has the
controls to set the vis format the kernel uses. 2.6.33 still has the
old logging concept, so the loglevel command with three levels is
wrong and the man page talks about dmesg etc...

In other works, users don't want the tip of 0.2.x, they need 0.2.x
from about the end of December. We should make a tarball of this and
put it somewhere on the website. The tip of 0.2.x works well for
linux-next, but nothing older.
 
> 
> > 2) We still have the chance to get bug fixes into 2.6.33. Is there
> >    anything in 2.6.33-rc5 which can cause oopses, deadlocks, etc?
> 
> As Sven already pointed out I merged all relevant bugfix patches
> into the maint branch. Unless I overlooked something it should be
> ready to go.

I think you missed the point about the merge window etc. Stuff in
maint will be merged during the next merged window into 2.6.34, around
the beginning of April and will be released end of June. I'm talking
about 2.6.33 here, which will be released end of March. We can still
get bug fixes into 2.6.33 if we want. Are there any bad bugs in the
code from the end of December?

> > 4) We should review what is currently in subversion but not yet pushed
> >    to GregKH ready for 2.6.34. eg gateway support, vis server startup
> >    fix, bonding, etc. In another email i will produce a list of
> >    patches we should consider.
> 
> I think we should stick to our original agreement to not push new
> features too fast. Gateway stuff, bonding, etc need more time to
> mature.  The vis patch is waiting in the maint branch - ready for
> inclusion.  :)

O.K, i can push vis stuff into 2.6.34. So you are happy for gateway,
bonding etc to go into 2.6.35, merge window beginning of July and
released sometime around end of September?

	 Andrew
