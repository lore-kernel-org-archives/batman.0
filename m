Return-Path: <gregkh@suse.de>
Date: Mon, 24 May 2010 11:43:17 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20100524184317.GE8291@suse.de>
References: <201005221616.46785.sven.eckelmann@gmx.de>
	<201005221708.45102.sven.eckelmann@gmx.de>
	<20100522152712.GA4671@suse.de>
	<201005221732.01710.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005221732.01710.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/26] Staging: batman-adv
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

On Sat, May 22, 2010 at 05:32:00PM +0200, Sven Eckelmann wrote:
> Greg KH wrote:
> [...]
> > > The merge window is already closed? v2.6.34 was released 6 days ago. Or
> > > do you mean that your merge window for staging is closed?
> > 
> > The merge window is for the subsystem maintainers to send stuff to
> > Linus.  That stuff must have already been in the linux-next tree for a
> > bit to test it out and ensure that it doesn't break anyone.
> > 
> > So that means that you need to get things to the subsystem maintainers a
> > week or so before the merge window opens up if you want to see it go
> > into the next kernel release.
> > 
> > And yes, this means the merge window for the staging tree for new
> > features is now closed.  Only bugfixes will be accepted for .35 from now
> > on, but I can easily queue up stuff for .36, I just have to wait until
> > .35-rc1 is out before I can add it to my public tree for inclusion in
> > the linux-next tree.
> > 
> > Hope this explains things a bit better.
> 
> Yes, helped a lot :)

Great, I got your patches, and will queue them up starting next week
when the .35-rc1 kernel is out.

thanks,

greg k-h
