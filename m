Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 13 May 2010 01:19:38 +0800
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<1273177132-8792-14-git-send-email-andrew@lunn.ch>
	<20100506204133.GA19717@kroah.com>
In-Reply-To: <20100506204133.GA19717@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qMu6LYWFe3JhgeJ"
Message-Id: <201005130119.39204.lindner_marek@yahoo.de>
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
To: b.a.t.m.a.n@lists.open-mesh.org, gregkh@suse.de
Cc: Greg KH <greg@kroah.com>, b.a.t.m.a.n@lists.open-mesh.net

--Boundary-00=_qMu6LYWFe3JhgeJ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hi Greg,

> Please document all sysfs files with a Documentation/ABI/ entry.  You
> can put it in the drivers/staging/batman-adv/ directory for now.
> 
> Also note, binary sysfs files are for things that are "pass-through",
> not for things that you try to intrepret like I think you are doing
> here.  What's wrong with configfs for something like this?

I drafted the ABI documentation which you will find attached to this mail. 
Since this is my very first attempt I'd appreciate feedback from your side 
before we submit it. I looked at various existing ABI docs in the linux kernel 
tree to get an idea how it should look like. Bear with me if it is not perfect 
yet.  ;-)

Regarding the question which kernel configuration interface to use, we would be 
more than happy to receive some guidance. At this point we are rather unsure 
which of the many (procfs/sysfs/configfs/etc) filesystems are we supposed to go 
forward with. To better judge our case I recommend reading this page
http://www.open-mesh.org/wiki/tweaking-batman-adv
as it explains the purpose of the various sysfs files.

Right now, I would say that configfs does not belong to my favorite solutions, 
simply because it seems to be a rather new/uncommon choice. Batman's main 
deployment field are embedded devices (mostly low cost routers) that have quite 
some contraints regarding cpu power and available disk space. Typically, those 
systems try to deactivate all "unnecessary" functionality in the kernel to 
have a few more bytes available for other stuff. For example OpenWRT: They 
deactivated configfs on all platforms (except one). I fear we create more 
problems than we solve if we go down this path.

Cheers,
Marek


--Boundary-00=_qMu6LYWFe3JhgeJ
Content-Type: text/plain;
  charset="UTF-8";
  name="sysfs-class-net-batman-adv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-class-net-batman-adv"


What:           /sys/class/net/<iface>/batman-adv/mesh_iface
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                The /sys/class/net/<iface>/batman-adv/mesh_iface file
                displays the batman mesh interface this <iface>
                currently is associated with.

What:           /sys/class/net/<iface>/batman-adv/iface_status
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Indicates the status of <iface> as it is seen by batman.

--Boundary-00=_qMu6LYWFe3JhgeJ
Content-Type: text/plain;
  charset="UTF-8";
  name="sysfs-class-net-mesh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-class-net-mesh"


What:           /sys/class/net/<mesh_iface>/mesh/aggregate_ogm
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Indicates whether the batman protocol messages of the
                mesh <mesh_iface> shall be aggregated or not.

What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Defines the interval in milliseconds in which batman
                sends its protocol messages.

What:           /sys/class/net/<mesh_iface>/mesh/originators
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Displays the table of all batman nodes (in range) and
                the link quality towards them. Each line contains the
                following values:
                  1 - originator
                  2 - TQ (transmit quality) value of originator
                  3 - best next hop towards originator
                  4 - outgoing iface to reach best next hop
                  5 - list of alternative best next hops

What:           /sys/class/net/<mesh_iface>/mesh/transtable_global
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Displays the table of mesh-wide announced mac
                addresses. Each line contains the following values:
                  1 - announced mac address
                  2 - originator announcing the mac address

What:           /sys/class/net/<mesh_iface>/mesh/transtable_local
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Displays the table of mac addresses announced to the
                mesh network by this node. Each line contains the
                following values:
                  1 - announced mac address

What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                Each batman node only maintains information about its
                own local neighborhood, therefore generating graphs
                showing the topology of the entire mesh is not easily
                feasible without having a central instance to collect
                the local topologies from all nodes. This file allows
                to activate the collecting (server) mode. Once
                activated the topology can be retrieved by reading
                the vis_data file.

What:           /sys/class/net/<mesh_iface>/mesh/vis_data
Date:           May 2010
Contact:        Marek Lindner <lindner_marek@yahoo.de>
Description:
                This file outputs the collected entire mesh topology
                information (if available) in a neutral (raw) format.
                Each line contains a set of identifiers. Values may
                or may not follow depending on their respective
                meanings:
                 * "mac" - mac address of an originator's source
                           interface (each line begins with it)
                 * "TQ mac  value" - src mac's link quality towards
                                     mac address of a neighbor
                                     originator's interface which is
                                     being used for routing
                 * "HNA mac" - HNA announced by source mac
                 * "PRIMARY" - this  is a primary interface
                 * "SEC mac" - secondary mac address of source
                               (requires preceding PRIMARY)

--Boundary-00=_qMu6LYWFe3JhgeJ--
