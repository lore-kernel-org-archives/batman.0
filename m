Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 4 Sep 2010 16:29:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201009041629.58372.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2010.1.0 released
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


New versions of the batman-adv kernel module and batctl are released today=
=20
with the version number 2010.1.0. The B.A.T.M.A.N. team's main focus was on=
=20
new features, Linux kernel compliance and a bunch of bug fixes. As the kern=
el=20
module always depends on the Linux kernel it was compiled against, it does =
not=20
make sense to provide binaries on our website. As usual, you will find the=
=20
signed tarballs in our download section:
http://downloads.open-mesh.net/batman/releases/batman-adv-2010.1.0/=20
as well as prepackaged binaries in your distribution.


Important changes
=2D---------------

As part of the ongoing kernel interface restructuring all remaining tables =
and=20
debug output was migrated from the proc filesystem to the debug filesystem.=
=20
Also, some tables which went into sysfs followed this example as well as th=
e=20
layer 2 icmp socket which resided in /dev. All programs / scripts accessing=
=20
these files directly need to be adjusted. Scripts using batctl are not affe=
cted=20
by this transition as the batctl command line parameters are unchanged. Mor=
e=20
details can be found below as well as in our documentation.=20


Thanks
=2D---------------

Thanks to all people sending in patches:

 * Antonio Quartulli <ordex@ritirata.org>
 * Dan Carpenter <error27@gmail.com>
 * Daniel Seither <post@tiwoc.de>
 * Eric Dumazet <eric.dumazet@gmail.com>
 * Jiri Pirko <jpirko@redhat.com>
 * Joe Perches <joe@perches.com>
 * Linus L=FCssing <linus.luessing@web.de>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Randy Dunlap <randy.dunlap@oracle.com>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven.eckelmann@gmx.de>
 * Tejun Heo <tj@kernel.org>


batman-adv
=2D---------------

The first B.A.T.M.A.N. V features left the experimental stage and went into=
=20
this release: interface alternating (formerly known as incoming interface=20
based routing) & bonding mode. These are optimizations for scenarios in whi=
ch=20
mesh nodes possess several WiFi cards to run the mesh on. In alternating mo=
de=20
batman-adv will switch the WiFi interface to forward the traffic with each =
hop,=20
thereby avoiding store & forward (which would half the bandwidth with each=
=20
forwarding node). Bonding mode will use all available interfaces at the sam=
e=20
time to forward the traffic. Both modes do not require the whole network to=
 have=20
the same hardware configuration - the available interfaces are automaticall=
y=20
detected and used if possible. Per default batman-adv operates in the=20
alternating mode, bonding mode can be activated.

To achieve Linux kernel compliance all tables and debug information have be=
en=20
concentrated in the debug filesystem (all configuration options remain in=20
sysfs). Make sure your kernel has the debug filesystem compiled in if you w=
ant=20
to access those information. The user space API is now considered clean and=
=20
won't require significant changes in the future. The originator table outpu=
ts=20
the "last seen" field to allow observing originator outages in real time. T=
he=20
batman-adv debug log returned with the debugfs changes, after it had been=20
removed in previous releases. The batman icmp socket left the /dev director=
y=20
to join the other debug facilities in debugfs (before it was not possible t=
o=20
create a socket for each configured mesh). This release also contains numer=
ous=20
bug fixes regarding stability, broadcast flood protection through 32Bit seq=
uence=20
numbers, supporting newer kernel versions, multiple interface bugs, roundin=
g=20
issues and more.


batctl
=2D---------------

Batctl has been adapted to retrieve the tables and other information from t=
he=20
debug filesystem. To provide a smooth user experience batctl automatically=
=20
mounts the debug filesystem whenever necessary. As the debug log output mov=
ed=20
from the standard kernel logging to the batman-adv log file, batctl re-
introduces the convenience features to retrieve the logs and replace mac=20
addresses with names. Batctl also followed the icmp socket move and is=20
prepared for the multiple mesh support. The ping utility received the "reco=
rd=20
route" ability which allows to monitor route changes. The originator table=
=20
viewer gained some additional options to filter for "fresh" entries (using =
the=20
"last seen" field) and allows to specify a refresh interval to continuously=
=20
print the table.=20


Happy routing,
The B.A.T.M.A.N. team

