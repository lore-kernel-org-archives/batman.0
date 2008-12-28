From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 28 Dec 2008 17:52:57 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200812281752.58019.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman advanced 0.1 release
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi, 

today, after a 6 months stabilization and debugging phase we release the first 
milestone towards a stable version: batman advanced 0.1.
As this implementation resides in the kernel land only we wanted to make sure 
its stability before releasing it to the public.

This batman implemention is marked with the label "advanced" to outline the 
fact that it operates on layer 2 (mac layer) as opposed to batman which 
operates on layer 3. To gain optimal performance it resides in the kernel as a 
module and can be enabled/disabled/configured via the /proc/net/batman-adv/ 
interface.

Unfortunately, we can not offer precompiled packages for your kernel as the 
module sources need to be linked against your very own kernel headers. If you 
are using debian you will find packages that you can install via apt-get. 
OpenWRT also has the package included. If you intend to use the module on your 
own system, simply download the sources, build and load the module.

You can find the sources here:
http://downloads.open-mesh.net/batman/stable/sources/

Special thanks to Sven Eckelmann and Scott Raynel who spent a considerable 
amount of time testing, debugging and patching the sources. We included all 
their patches which allow us to release today.

The biggest changes since the beta release are:
- support latest kernel version (2.6.20 - 2.6.28)
- LOTS of cleanup: locking, stack usage, memory leaks
- Change Ethertype from 0x0842 to 0x4305
unregistered at IEEE, if you want to sponsor an official Ethertype ($2500) 
please contact us


We welcome any feedback/patches/ideas, 
The B.A.T.M.A.N. developer team


