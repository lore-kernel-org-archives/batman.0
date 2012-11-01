Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 1 Nov 2012 09:34:32 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201211010934.32360.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2012.4.0 released
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


The B.A.T.M.A.N. team proudly presents its newest release, batman-adv=20
2012.4.0, mostly dedicating itself to stability with some smaller enhanceme=
nts=20
to improve the user experience. As the kernel module always depends on the=
=20
Linux kernel it was compiled against, it does not make sense to provide=20
binaries on our website. As usual, you will find the signed tarballs in our=
=20
download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2012.4.0/

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

  * Antonio Quartulli <ordex@autistici.org>
  * Def <def@laposte.net>
  * Jonathan Corbet <corbet@lwn.net>
  * Linus L=FCssing <linus.luessing@web.de>
  * Marek Lindner <lindner_marek@yahoo.de>
  * Martin Hundeb=F8ll <martin@hundeboll.net>
  * Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
  * Sven Eckelmann <sven@narfation.org>


batman-adv
=2D---------

The translation table (the core system for managing all non-mesh clients=20
across the mesh network) has been supplemented by the "speedy join" mechani=
sm.=20
Speedy join was designed to make the location of non-mesh clients known=20
throughout the mesh without depending on OGM messages. As soon as non-mesh=
=20
clients issue a DHCP or ARP request or any other broadcast message they are=
=20
immediately full participants of the network. This will lead to a faster=20
network connection experience, especially when the mesh network has been=20
configured with higher OGM intervals.
All remaining traffic counters were converted to the recently introduced=20
traffic counting framework and its ethtool API, thereby completely replacin=
g=20
the old traffic counter mechanism for the purpose of better scalability. Th=
e=20
bridge loop avoidance comes with an additional backbone gateway table=20
(exported via debugfs) allowing to retrieve the list of all detected backbo=
ne=20
gateways attached to the same LAN, regardless of whether or not it has clai=
med=20
any non-mesh client.=20

Several reports about packet loss in combination with vlan tagging encourag=
ed=20
us to investigated the cause. A bug was found in the Linux kernel vlan code=
=20
and a patch was submitted. At the same time a workaround was added to our o=
ut-
of-tree kernel module which automatically takes effect for kernel versions=
=20
older than Linux 3.8 (which contains the proper fix). This release also com=
es=20
with a few bug fixes concerning the batman-adv code directly: with the inte=
nt=20
of suppressing duplicate broadcast packets in the mesh the bridge loop=20
avoidance computes CRC checksums for each broadcast packet it receives and=
=20
compares them to a list of already received broadcast checksums. The check-
summing code miscalculated the CRC leading to overly aggressive broadcast=20
packet drops. Also addressed was the missing "no purge" flag for the batX m=
ac=20
addresses after manually changing its mac address. The code refactoring=20
regression leading to route flapping in multiple interfaces setup was=20
corrected along with wrong OGM counting on Intel x86.=20


batctl
=2D-----

As gradually more functionality of the batman-adv kernel module is optional=
=20
and can be compiled out, batctl won't be able to find the corresponding fil=
es=20
in sysfs or debugfs. Therefore, batctl now maintains a list of optional=20
features and informs the user about a possibly deactivated optional feature=
=2E=20
At the same time the sysfs / debugfs code has been refactored to remove=20
redundant boilerplate code. Also removed was the code querying the traffic=
=20
statistics through the old API because all statistics can be retrieved via =
the=20
new API. The batctl utility also gained an option to display the newly adde=
d=20
backbone gateway table.


Happy routing,
The B.A.T.M.A.N. team
