Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 21 Aug 2011 16:29:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201108211629.54193.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2011.3.0 released
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


The B.A.T.M.A.N. team is delighted to announce its latest release, 2011.3.0=
,=20
introducing major protocol changes for better roaming of non-mesh clients,=
=20
gateway convenience features and a pile of bug fixes & code stability chang=
es.=20
As the kernel module always depends on the Linux kernel it was compiled=20
against, it does not make sense to provide binaries on our website. As usua=
l,=20
you will find the signed tarballs in our download section:=20

http://downloads.open-mesh.org/batman/releases/batman-adv-2011.3.0/=20

as well as prepackaged binaries in your distribution.


Important changes
=2D----------------

The extensive work on roaming improvements for non-mesh clients led to a=20
protocol change which breaks backward compatibility. Be sure to update all=
=20
your mesh network participants to the latest version to avoid orphan nodes.
=46urthermore, a change in the networking infrastructure of the Linux kerne=
l=20
made us drop the support of Linux kernels older than 2.6.29. Maintaining=20
compatibility would be an uphill battle while not being worthwhile for us a=
s a=20
Linux kernel project.


Thanks
=2D-----

Thanks to all people sending in patches:

   * Antonio Quartulli <ordex@autistici.org>
   * Daniele Furlan <daniele.furlan@gmail.com>
   * David Howells <dhowells@redhat.com>
   * David S. Miller <davem@davemloft.net>
   * Joe Perches <joe@perches.com>
   * Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
   * Marek Lindner <lindner_marek@yahoo.de>
   * Sven Eckelmann <sven@narfation.org>


batman-adv
=2D---------

This release comes with a redesign of one of the oldest code segments /=20
concepts in batman-adv: the non-mesh client announcement mechanism. When=20
batman-adv detects a non-mesh client it automatically starts announcing the=
=20
client's mac address in the mesh network to make the mesh aware of the=20
client's location. The new protocol extension mainly deals with the optimal=
=20
handling and propagation of these client position packets. Major benefits=20
include: Only changes (client arriving or leaving) are propagated in the me=
sh,=20
thereby reducing the protocol overhead; traffic redirection when a client=20
roams from one mesh node to the next until the mesh network has converged t=
o=20
reduce the packet loss while roaming; extensible packet format to construct=
=20
more features on top of it.
In addition, batman-adv gained support for informing the user space about=20
events via uevent (a long-standing feature request). The gateway subsystem =
is=20
the first to make use of it by sending signals when a new gateway has been=
=20
selected / selected gateway has been changed / the selected gateway has bee=
n=20
removed. Also, when enabled the gateway subsystem will filter out incoming=
=20
DHCP renewal requests if they are not targeted at a high quality gateway to=
=20
force the client to switch to the best available gateway.
The routing algorithm received a minor tweaking which make it accept delaye=
d=20
OGM rebroadcasts to avoid bogus routing under heavy load. A bug hindering t=
he=20
correct broadcast of OGM packets if interfaces were added & removed in a=20
particular order was fixed. A similar problem affecting the OGM aggregation=
=20
was eliminated too. The many smaller bug fixes and code stability improveme=
nts=20
make this release a well-rounded package.


batctl
=2D-----

The Makefile received major attention and various cleanups to make packagin=
g=20
of batctl easier. tcpdump was updated, so that it can analyze the new tt &=
=20
roaming packets and was extended by a new option to filter all packets exce=
pt=20
the specified types. An additional debug level for all client announcement=
=20
related information was added too. A pair of small bugs was squashed along =
the=20
way: bisect did not properly initialize a variable which led to a compile t=
ime=20
warning and a potential memory leak in the bat-hosts parser fixed.


Happy routing,=20
The B.A.T.M.A.N. team
