Return-Path: <gregkh@suse.de>
Date: Wed, 23 Jun 2010 07:31:30 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20100623143130.GC16997@suse.de>
References: <201006101303.45771.sven.eckelmann@gmx.de>
	<20100622230258.GD18495@suse.de>
	<201006230948.01188.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201006230948.01188.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: Migration from staging to net
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jun 23, 2010 at 09:47:59AM +0200, Sven Eckelmann wrote:
> Greg KH wrote:
> [...]
> > If everything is now moved into debugfs, and everything in sysfs is only
> > "one-value-per-file" then I don't really have an objection.
> > 
> > I would say let the networking developers start reviewing it.
> 
> Thanks for the response.
> 
> Can please also make some comments about the last part of the mail (regarding 
> the merge process):
> 
> Sven Eckelmann wrote:
> > To the merge process itself. We should prepare a patch which adds
> > everything in net/batman-adv/ (and Documentation/ABI/testing/,
> > MAINTAINERS) and then send it to netdev@vger.kernel.org/David S. Miller.
> > After it was merged we just send you a patch which removes
> > drivers/staging/batman-adv. Is that correct (just searched for an example
> > and only found benet[1, 2])?

Oops, sorry about that.

Yes, a new patch would be easiest for the network developers to review.
When it gets accepted we can then delete the drivers/staging/ code.

thanks,

greg k-h
