From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 21 Feb 2007 13:28:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702211328.24551.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] Announcement: batman 0.2 alpha released
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


Hi,

we are happy to announce the first test release of the upcoming batmand. A lot 
of work has been done under the hood:

- many cpu and memory usage optimizations
- Big Endian / Little Endian support added
- 64 Bit compability added
- ability to give access to the various debug levels without restarting the 
daemon

Since a while the *BSD and MacOS X support is unmaintained. Therefore the 
systems are not supported any longer until a maintainer is found. 

The 0.2 release will be fully backward compatible to 0.1.1 and above. That 
enables you to use the stable branch for most of your network and try 0.2 
alpha on test machines. Any feedback is highly appreciated.


Short explanation how to use the debug levels now:

At first start batman normally:
batmand  <your_options> <interface(s)>

Use another shell and type this:
batmand -c -d <your_desired_debug_level>

The option "c" tells batman to connect to a running batman instead of behaving 
like a normal batman. You even can connect more than once or different debug 
level. For debug level 1 and 2 a batch mode was included which prevents 
redrawing the screen and is ideal for script integration:

batmand -c -b -d 1


You can get the sources and precompiled mips / arm binaries from 
open-mesh.net.

Regards,
Marek
