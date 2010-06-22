Return-Path: <gregkh@suse.de>
Date: Tue, 22 Jun 2010 16:02:58 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20100622230258.GD18495@suse.de>
References: <201006101303.45771.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201006101303.45771.sven.eckelmann@gmx.de>
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

On Thu, Jun 10, 2010 at 01:03:36PM +0200, Sven Eckelmann wrote:
> Hi,
> 
> the batman-adv developers had a smaller discussion what we wanted to achieve
> in drivers/staging and if we have done everything we wanted to do. We think
> that everything we wanted to do in staging is finished (the TODO file is
> empty since a while), but that is just our opinion.
> 
> So we wanted to ask you first if you see any showstopper which make batman-adv
> insufficient for net before we would ask the net maintainer. Our personal
> favorite kernel for the move would be 2.6.37. Before that we would have 2.6.35
> (which is not completely correct using the sysfs infrastructure) and at least
> some RCs of 2.6.36 (which moves the remaining wrong stuff from sysfs to
> debugfs).

If everything is now moved into debugfs, and everything in sysfs is only
"one-value-per-file" then I don't really have an objection.

I would say let the networking developers start reviewing it.

good luck,

greg k-h
