Return-Path: <greg@kroah.com>
Date: Wed, 12 May 2010 10:38:30 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100512173830.GA27912@kroah.com>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<1273177132-8792-14-git-send-email-andrew@lunn.ch>
	<20100506204133.GA19717@kroah.com>
	<201005130119.39204.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005130119.39204.lindner_marek@yahoo.de>
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, b.a.t.m.a.n@lists.open-mesh.net, gregkh@suse.de

On Thu, May 13, 2010 at 01:19:38AM +0800, Marek Lindner wrote:
> 
> Hi Greg,
> 
> > Please document all sysfs files with a Documentation/ABI/ entry.  You
> > can put it in the drivers/staging/batman-adv/ directory for now.
> > 
> > Also note, binary sysfs files are for things that are "pass-through",
> > not for things that you try to intrepret like I think you are doing
> > here.  What's wrong with configfs for something like this?
> 
> I drafted the ABI documentation which you will find attached to this mail. 
> Since this is my very first attempt I'd appreciate feedback from your side 
> before we submit it. I looked at various existing ABI docs in the linux kernel 
> tree to get an idea how it should look like. Bear with me if it is not perfect 
> yet.  ;-)
> 
> Regarding the question which kernel configuration interface to use, we would be 
> more than happy to receive some guidance. At this point we are rather unsure 
> which of the many (procfs/sysfs/configfs/etc) filesystems are we supposed to go 
> forward with. To better judge our case I recommend reading this page
> http://www.open-mesh.org/wiki/tweaking-batman-adv
> as it explains the purpose of the various sysfs files.
> 
> Right now, I would say that configfs does not belong to my favorite solutions, 
> simply because it seems to be a rather new/uncommon choice.

configfs is very old, and has been around almost as long as sysfs has
been.  But yes, it's not used as much, that is true.

> Batman's main deployment field are embedded devices (mostly low cost
> routers) that have quite some contraints regarding cpu power and
> available disk space. Typically, those systems try to deactivate all
> "unnecessary" functionality in the kernel to have a few more bytes
> available for other stuff. For example OpenWRT: They deactivated
> configfs on all platforms (except one). I fear we create more problems
> than we solve if we go down this path.

Well, it is simple to enable configfs if you need/want batman, right?
It's not that much extra kernel code.

> What:           /sys/class/net/<mesh_iface>/mesh/originators
> Date:           May 2010
> Contact:        Marek Lindner <lindner_marek@yahoo.de>
> Description:
>                 Displays the table of all batman nodes (in range) and
>                 the link quality towards them. Each line contains the
>                 following values:
>                   1 - originator
>                   2 - TQ (transmit quality) value of originator
>                   3 - best next hop towards originator
>                   4 - outgoing iface to reach best next hop
>                   5 - list of alternative best next hops

Sorry, but sysfs is for "one value per file" attributes, which this one
violates.

Is this something that everyone always needs to know?  Or could it be a
debugfs file?

> What:           /sys/class/net/<mesh_iface>/mesh/transtable_global
> Date:           May 2010
> Contact:        Marek Lindner <lindner_marek@yahoo.de>
> Description:
>                 Displays the table of mesh-wide announced mac
>                 addresses. Each line contains the following values:
>                   1 - announced mac address
>                   2 - originator announcing the mac address

Again, no "tables" in sysfs please.

> What:           /sys/class/net/<mesh_iface>/mesh/transtable_local
> Date:           May 2010
> Contact:        Marek Lindner <lindner_marek@yahoo.de>
> Description:
>                 Displays the table of mac addresses announced to the
>                 mesh network by this node. Each line contains the
>                 following values:
>                   1 - announced mac address

Same here.

> What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
> Date:           May 2010
> Contact:        Marek Lindner <lindner_marek@yahoo.de>
> Description:
>                 Each batman node only maintains information about its
>                 own local neighborhood, therefore generating graphs
>                 showing the topology of the entire mesh is not easily
>                 feasible without having a central instance to collect
>                 the local topologies from all nodes. This file allows
>                 to activate the collecting (server) mode. Once
>                 activated the topology can be retrieved by reading
>                 the vis_data file.
> 
> What:           /sys/class/net/<mesh_iface>/mesh/vis_data
> Date:           May 2010
> Contact:        Marek Lindner <lindner_marek@yahoo.de>
> Description:
>                 This file outputs the collected entire mesh topology
>                 information (if available) in a neutral (raw) format.
>                 Each line contains a set of identifiers. Values may
>                 or may not follow depending on their respective
>                 meanings:
>                  * "mac" - mac address of an originator's source
>                            interface (each line begins with it)
>                  * "TQ mac  value" - src mac's link quality towards
>                                      mac address of a neighbor
>                                      originator's interface which is
>                                      being used for routing
>                  * "HNA mac" - HNA announced by source mac
>                  * "PRIMARY" - this  is a primary interface
>                  * "SEC mac" - secondary mac address of source
>                                (requires preceding PRIMARY)

Again, this is not a single value, so please move it somewhere else.

thanks,

greg k-h
