Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 22 Nov 2010 00:43:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201011220043.28143.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2010.2.0 released
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
To: b.a.t.m.a.n@lists.open-mesh.org


The B.A.T.M.A.N. team proudly presents the last batman-adv release in the y=
ear=20
2010, carrying the version number 2010.2.0. This release contains a mix of =
new=20
features, Linux kernel compliance and bug fixes. As the kernel module alway=
s=20
depends on the Linux kernel it was compiled against, it does not make sense=
 to=20
provide binaries on our website. As usual, you will find the signed tarball=
s in=20
our download section:
http://downloads.open-mesh.org/batman/releases/batman-adv-2010.2.0/=20
as well as prepackaged binaries in your distribution.


Important changes
=2D---------------

The batman-adv module now supports multiple mesh clouds simultaneously whic=
h=20
made changes to the 'bat0' interface behavior necessary: Mesh interfaces (s=
uch=20
as bat0) are created only after 'real' interfaces (e.g. wlan0) have been=20
assigned. Mesh interfaces that have no real interfaces assigned are removed=
=20
from the system. Furthermore the mesh interface can be freely named such as=
=20
bat5, mesh0, etc, therefore batman-adv might be active even though bat0 doe=
s=20
not exist. More details can be found below as well as in our documentation.=
=20


Thanks
=2D---------------

Thanks to all people sending in patches:

 * Andreas Langer <an.langer@gmx.de>
 * Andy Shevchenko <andy.shevchenko@gmail.com>
 * Chris Lang <clang@gateworks.com>
 * Linus L=FCssing <linus.luessing@web.de>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven.eckelmann@gmx.de>
 * Tracey Dent <tdent48227@gmail.com>
 * Vasiliy Kulikov <segooon@gmail.com>

and to all those that supported us with good advice or rigorous testing:

 * Dan Carpenter <error27@gmail.com>
 * David S. Miller <davem@davemloft.net>
 * Paul E. McKenney <paulmck@linux.vnet.ibm.com>
 * Rafal Lesniak <lesniak@eresi-project.org>
 * Sam Yeung <sam.cwyeung@gmail.com>


batman-adv
=2D---------------

The work that nearly a year ago began has finally come to an end: Multiple =
mesh=20
cloud support has been completed. This allows one host to participate in=20
multiple meshes at the same time via different interfaces. This often reque=
sted=20
feature is particularly useful to segment large batman-adv installations,=20
thereby reducing overhead. Each mesh cloud can be individually configured,=
=20
deals with its traffic flow independently and possesses its own batX interf=
ace.=20
Also added was a layer 2 fragmentation for unicast data flowing through the=
=20
mesh which will allow to run batman-adv over interfaces / connections that=
=20
don't allow to increase the MTU beyond the standard Ethernet packet size of=
=20
1500 bytes. This initial fragmentation only supports splitting the large=20
packets at "the beginning of mesh" whereas an extension which allows=20
fragmenting "on the fly" anywhere in the mesh network will be included in t=
he=20
following release.

As usual, many improvements happened under the hood: The module uses the=20
kernel supplied functions for network buffer manipulations instead of re-
implementing them and takes advantage of the optimized kernel functionality=
=20
for OGM counting. The RCU protected lists have been revamped and enhanced w=
ith=20
referenced based counting which squashes quite some race conditions. The HN=
A=20
handling needed some fixes too when it was stress tested with a very large=
=20
local network. Many minor bugs such as false warnings, reduced memory usage=
=20
and coding style issues were addressed.


batctl
=2D---------------

To support the "multiple mesh clouds" feature batctl received a new (option=
al)=20
parameter '-m' to specify the mesh cloud interface in order to query the me=
sh=20
cloud of interest. If '-m' is not specified batctl will assume 'bat0' as me=
sh=20
cloud interface which maintains backward compatibility and suits most users=
=2E=20
The newly added fragmentation on/off switch also was added as well as batct=
l=20
tcpdump support for fragmented packets. In addition, the batctl tcpdump can=
=20
deal with multiple header encapsulation (e.g. HTTP in VLAN in BAT UNICAST i=
n=20
VLAN) and the batctl ping utilities' '-i' option is not silently ignored an=
y=20
longer. Various cleanups took place and a crash fixed if the HOME environme=
nt=20
variable is not set.

Happy routing,
The B.A.T.M.A.N. team

