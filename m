Return-Path: <greg@kroah.com>
Date: Sat, 19 Jun 2010 10:27:00 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100619172700.GE28159@kroah.com>
References: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
	<20100619000333.GC1128@kroah.com>
	<201006190249.39204.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201006190249.39204.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (renewed)
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
Cc: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

On Sat, Jun 19, 2010 at 02:49:36AM +0200, Sven Eckelmann wrote:
> Greg KH wrote:
> > On Sun, Jun 06, 2010 at 09:28:12PM +0200, Sven Eckelmann wrote:
> > > Hi,
> > > 
> > > here are patches targetted for 2.6.36. These replace all patches send to
> > > you for 2.6.36 in mails following
> > > 1275850985-27105-1-git-send-email-sven.eckelmann@gmx.de due to
> > > conflicting changes for 2.6.35 from Dan Carpenter and Javier Martinez
> > > Canillas.
> > 
> > I could not apply the following patches for some odd reason:
> > 	2, 3, 4, 7, 9
> > 
> > I applied the others.
> > 
> > So you might want to resync on the my staging-next tree and see what
> > went wrong.  Does it have something to do with the other batman patches
> > I have in my staging.current tree to go to Linus?
> 
> You forgot(?) to apply the patches
> 
>  * Staging: batman-adv: return -EFAULT on copy_to_user errors
>  * Staging: batman-adv: fix function prototype
> 
> With those patches it works like a charm. And at least the second one is 
> extreme important for 2.6.35.

Ah, no, I didn't forget, they are just in a different branch.

Sorry, I didn't think about that one.  I'll go merge those patches into
this branch as well, so as to make it all work out properly.  Git will
handle the fact that they show up twice just fine when it comes to
merging things.

Sorry about this, I'll resolve it all on my end on Monday, and thanks
for resending everything.

greg k-h
