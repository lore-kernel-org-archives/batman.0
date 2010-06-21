Return-Path: <greg@kroah.com>
Date: Mon, 21 Jun 2010 16:16:17 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100621231617.GA1346@kroah.com>
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
	<20100621223427.GA22687@kroah.com>
	<201006220059.48628.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201006220059.48628.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (2)
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

On Tue, Jun 22, 2010 at 12:59:47AM +0200, Sven Eckelmann wrote:
> Greg KH wrote:
> > On Sat, Jun 19, 2010 at 02:51:45AM +0200, Sven Eckelmann wrote:
> > > Hi,
> > > 
> > > here are patches targetted for 2.6.36. They are made on top of patches
> > > you have
> > > 
> > > already received in 1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de :
> > >  * Staging: batman-adv: remove redundant struct declaration
> > >  * Staging: batman-adv: Move device for icmp injection to debugfs
> > >  * Staging: batman-adv: Move tables from sysfs to debugfs
> > >  * Staging: batman-adv: convert all sysfs files to single value files
> > >  * Staging: batman-adv: Adding netfilter-bridge hooks
> > >  * Staging: batman-adv: Add information about batman-adv sysfs entries
> > >  * Staging: batman-adv: remove superfluous hint to "translation table"
> > >  * Staging: batman-adv: convert vis_interval into define
> > >  * Staging: batman-adv: Convert MAC_FMT to %pM
> > > 
> > > They also depend on patches not yet applied on 2.6.35, but sent to you:
> > >  * Staging: batman-adv: return -EFAULT on copy_to_user errors
> > >  * Staging: batman-adv: fix function prototype
> > 
> > Something's still not right.  I applied the above 2 patches, and then
> > tried to apply the 1/8 patch above:
> > 	Subject: [PATCH 1/8] Staging: batman-adv: Mark locally used symbols as
> > static
> > 
> > It fails with:
> > 	patching file drivers/staging/batman-adv/bitarray.c
> > 	patching file drivers/staging/batman-adv/bitarray.h
> > 	patching file drivers/staging/batman-adv/hash.c
> > 	patching file drivers/staging/batman-adv/hash.h
> > 	patching file drivers/staging/batman-adv/originator.c
> > 	patching file drivers/staging/batman-adv/originator.h
> > 	patching file drivers/staging/batman-adv/routing.c
> > 	patching file drivers/staging/batman-adv/routing.h
> > 	patching file drivers/staging/batman-adv/send.c
> > 	patching file drivers/staging/batman-adv/send.h
> > 	patching file drivers/staging/batman-adv/soft-interface.c
> > 	patching file drivers/staging/batman-adv/soft-interface.h
> > 	patching file drivers/staging/batman-adv/translation-table.c
> > 	Hunk #2 succeeded at 250 (offset 5 lines).
> > 	Hunk #3 succeeded at 442 with fuzz 1 (offset 16 lines).
> > 	patching file drivers/staging/batman-adv/translation-table.h
> > 	Hunk #1 FAILED at 26.
> > 	1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/staging/batman-adv/translation-table.h.rej patching file
> > drivers/staging/batman-adv/vis.c
> > 	patching file drivers/staging/batman-adv/vis.h
> > 	Hunk #1 FAILED at 44.
> > 	1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/staging/batman-adv/vis.h.rej
> > 
> > So, any thoughts?
> 
> I have currently no idea what you try to achieve by applying all patches out
> of order, but you have done following:
> 
>  * Staging: batman-adv: return -EFAULT on copy_to_user errors
>  * Staging: batman-adv: fix function prototype
>  * Staging: batman-adv: Mark locally used symbols as static
>    => of course fails because it was applied out of order and misses
>       9 patches inbetween

Ick, you are right, I had thought the 8 patches you sent me were the
ones that I should start with as I had already applied some of the
previous series.

So, to make it dirt-simple for me, so my simple mind can figure it out,
can you resend the patches that I need to apply that are not in my
staging-next tree?

thanks,

greg k-h
