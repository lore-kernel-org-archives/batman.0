Return-Path: <greg@kroah.com>
Date: Wed, 12 May 2010 12:17:20 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100512191720.GB30678@kroah.com>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005130119.39204.lindner_marek@yahoo.de>
	<20100512173830.GA27912@kroah.com>
	<201005122056.05476.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005122056.05476.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 13/26] staging:batman-adv: convert
 multiple /proc files to use sysfs
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
Cc: b.a.t.m.a.n@lists.open-mesh.net, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, gregkh@suse.de

On Wed, May 12, 2010 at 08:55:56PM +0200, Sven Eckelmann wrote:
> Thank you for the fast answer. 
> 
> Greg KH wrote:
> > On Thu, May 13, 2010 at 01:19:38AM +0800, Marek Lindner wrote:
> > > Hi Greg,
> > > 
> > > > Please document all sysfs files with a Documentation/ABI/ entry.  You
> > > > can put it in the drivers/staging/batman-adv/ directory for now.
> > > > 
> > > > Also note, binary sysfs files are for things that are "pass-through",
> > > > not for things that you try to intrepret like I think you are doing
> > > > here.  What's wrong with configfs for something like this?
> > > 
> > > I drafted the ABI documentation which you will find attached to this
> > > mail. Since this is my very first attempt I'd appreciate feedback from
> > > your side before we submit it. I looked at various existing ABI docs in
> > > the linux kernel tree to get an idea how it should look like. Bear with
> > > me if it is not perfect yet.  ;-)
> > > 
> > > Regarding the question which kernel configuration interface to use, we
> > > would be more than happy to receive some guidance. At this point we are
> > > rather unsure which of the many (procfs/sysfs/configfs/etc) filesystems
> > > are we supposed to go forward with. To better judge our case I recommend
> > > reading this page http://www.open-mesh.org/wiki/tweaking-batman-adv
> > > as it explains the purpose of the various sysfs files.
> > > 
> > > Right now, I would say that configfs does not belong to my favorite
> > > solutions, simply because it seems to be a rather new/uncommon choice.
> > 
> > configfs is very old, and has been around almost as long as sysfs has
> > been.  But yes, it's not used as much, that is true.
> > 
> > > Batman's main deployment field are embedded devices (mostly low cost
> > > routers) that have quite some contraints regarding cpu power and
> > > available disk space. Typically, those systems try to deactivate all
> > > "unnecessary" functionality in the kernel to have a few more bytes
> > > available for other stuff. For example OpenWRT: They deactivated
> > > configfs on all platforms (except one). I fear we create more problems
> > > than we solve if we go down this path.
> > 
> > Well, it is simple to enable configfs if you need/want batman, right?
> > It's not that much extra kernel code.
> 
> Yes, it should be possible to enable it. It was just meant to describe the 
> current situation and the target systems were batman-adv is currently used. 
> There is for example the requirement by one developer that it runs on his 
> hardware which currently only support 2.6.24 as kernel due to different out of 
> kernel drivers. There were also some request to port it back to 2.6.15 to get 
> the Atheros drivers working... which is out of scope for us due to different 
> changes in the kernel since 2.6.15. It isn't always easy to support all those 
> requirements and get it in the right shape for a merge in the mainline kernel 
> (and my/our gap in education about all virtualfs doesn't help either).

configfs has been around since 2.6.3 or so, so even ancient kernels like
2.6.15 is fine.

> This makes invalid entries in sysfs not better, but maybe helps you to get in 
> the correct mood to point us in the right direction.

I honestly don't care about older kernels, as this is all about merging
the code into the current kernel version, not older ones :)

> > > What:           /sys/class/net/<mesh_iface>/mesh/originators
> [...]
> > 
> > Sorry, but sysfs is for "one value per file" attributes, which this one
> > violates.
> > 
> > Is this something that everyone always needs to know?  Or could it be a
> > debugfs file?
> 
> Everyone/always - not really. They are needed by someone who wants to test and 
> debug the status of batman-adv - which sounds like a perfect target for 
> debugfs, right?

Yup.

> So batctl has to check if /sys/kernel/debug/ is mounted (or the batman-
> adv/mesh_iface/originator) file can be found and give the user a helpful error 
> message that either batman-adv is not loaded, debugfs is not mounted at 
> /sys/kernel/debug/ or the mesh_iface just doesn't exists.

Yes, that should be quite simple.  The perf code does this today, you
can just steal their function that handles this.  Almost all distros are
mounting debugfs these days, so it's not really a big deal.

> > > What:           /sys/class/net/<mesh_iface>/mesh/transtable_global
> [...]
> > 
> > Again, no "tables" in sysfs please.
> > 
> > > What:           /sys/class/net/<mesh_iface>/mesh/transtable_local
> [...]
> > 
> > Same here.
> > 
> > > What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
> [...]
> > > 
> > > What:           /sys/class/net/<mesh_iface>/mesh/vis_data
> [...]
> > 
> > Again, this is not a single value, so please move it somewhere else.
> 
> As far as I can see only these files with (more or less) debug information are 
> the problem right now and should go to the debugfs?

Yes.

> The rest can be in sysfs?:
>  * /sys/class/net/<iface>/batman-adv/mesh_iface
>  * /sys/class/net/<iface>/batman-adv/iface_status
>  * /sys/class/net/<mesh_iface>/mesh/aggregate_ogm
>  * /sys/class/net/<mesh_iface>/mesh/orig_interval
>  * /sys/class/net/<mesh_iface>/mesh/vis_mode (not sure about that one because
>    it is in the no-list, but without comment. You can only write "client"/
>    "server" into that file and read the same value. So probably in the sysfs
>    list)

The mode is only a single value that you write to, right?  If it makes
sense to be in debugfs (not a normal config value), then is should move
there.

The others are all single-value files, right?  Or did I miss something?
If they are single-value files, then yes, they can stay in sysfs, unless
you feel they are debug-type things, then debugfs is the place for them
(debugfs makes is trivial to handle single value files, even easier than
sysfs.)

thanks,

greg k-h
