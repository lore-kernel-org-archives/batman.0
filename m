Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 8 Nov 2009 21:44:49 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200911082144.49637.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 0.2 released
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
To: b.a.t.m.a.n@lists.open-mesh.net


The B.A.T.M.A.N. team is pleased to announce the availability of the second 
batman-adv release which brings major improvements, new features, changes
along the way and a series of bugfixes.
As the kernel module always depends on the kernel it was compiled against it 
does not make sense to provide binaries. However, you will find binaries for 
batctl at the usual location:
http://downloads.open-mesh.net/batman/stable/binaries/
as well as signed source tarballs for the module and batctl:
http://downloads.open-mesh.net/batman/stable/sources/


Important changes
-----------------

With this release we believe that the kernel module is fully capable to 
replace a routing daemon feature wise as well stability wise. Therefore the 
batman-adv user space daemon (which was marked deprecated since the last 
release) as well as the vis-adv daemon have been removed from our repositories 
as they are no longer supported. We urge all remaining users to consider a 
migration towards the the kernel module. 


Thanks
------

Special thanks go to:
* Sven Eckelmann who continuously provides us with patches and advice
   whenever problems show up
* Andrew Lunn & Yang Su for their analysis of the routing protocol which 
   helped us to identify temporary routing loops in the code
* Linus Luessing & Freifunk Luebeck for the rigorous testing & bug 
   reporting of all (im)possible race conditions they encountered
* Jacob Marble who tried to find a new home for our extravagant mailing list
   requirements and gave birth to the batctl idea

Thanks to all people sending in patches (in no particular order): 
 - Andrea Ghittino <a.mailevent@gmail.com>
 - Sven Eckelmann <sven.eckelmann@gmx.de>
 - Andrew Lunn <andrew.lunn@ascom.ch>
 - Yang Su <Yang.Su@ascom.ch>
 - Linus Luessing <linus.luessing@web.de>
 - Antoine van Gelder <antoine@7degrees.co.za> (JSON patch was ported)


batman-adv
----------

The module has undergone some major changes to better fit into the event based
nature of the kernel. We removed a number of timers (e.g the new interface 
detection) which also greatly reduces the risk of race conditions. Also new is 
the packet queue that allowed implementing the aggregation (already known from 
the user space implementation) as well as transmission retry (ARQ) for payload 
broadcasts because we noticed most broadcasts vanish in transit. This feature 
merits some extra attention as it is the first in which the routing module 
influences the payload traffic directly to enhance the mesh experience. 
We also spent quite some energy to fix bugs in the routing algorithm that 
triggered temporary routing loops, squashed a TTL code bug and removed the 
ghost entries from the originator table. The whole code received linux coding 
style adjustments, refactoring & cleanups. Furthermore all kernel version 
compatibility code has been unified in compat.h. The internal vis server 
received another output format (JSON) plus secondary interface export 
functionality in the dot draw format. Numerous small bugs were fixed such as 
using the random ethernet generator from the kernel for better randomness, 
exporting the version via /sys/module/batman_adv/version, fixing alignment 
issues, race conditions and deadlocks.


batctl
------

Although this is the first release of batctl it carries the same release 
version as the kernel module (for the sake of simplicity). It is based on the 
work of Andreas Langer who created the battools which were never officially 
released. Since then it has been extended to the point that it serves as 
configuration utility, monitoring and debugging application. It allows to 
modify the module parameters, reading the logfiles & tables, decapsulate 
embedded packets on the fly, traceroute to & ping mac addresses, generate 
sequence number graphs and more. Check the README to get an impression: 
http://www.open-mesh.net/browser/trunk/batctl/README?rev=1466


road ahead
----------

The batman-adv development lying ahead can be separated into 2 big chunks: The 
linux kernel integration already started and we began working on batman's move 
into the linux land (more information can be found on www.open-mesh.net) - 
expect follow up news in the coming weeks. In the meantime a large number of 
ideas are flying around how to further improve the B.A.T.M.A.N. algorithm to 
increase its convergence speed, reduce traffic overhead and much more. A first 
idea collection will be published soon.

Happy routing,
The B.A.T.M.A.N. team
