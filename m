Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 29 Jul 2013 23:27:28 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201307292327.28470.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2013.3.0 released
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


The B.A.T.M.A.N. team proudly presents its newest release - batman-adv=20
2013.3.0 - a stability and bugfix release uniquely focused on ironing out b=
ugs=20
and annoyances. As the kernel module always depends on the Linux kernel it =
was=20
compiled against, it does not make sense to provide binaries on our website=
=2E=20
As usual, you will find the signed tarballs in our download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2013.3.0/

as well as prepackaged binaries in your distribution.


Important changes
=2D----------------

=46or the first time, a batman-adv and batctl release is accompanied by=20
A.L.F.R.E.D. (Almighty Lightweight Fact Remote Exchange Daemon) - a user sp=
ace=20
daemon conceived for the purpose of replacing the in-kernel visualization=20
component with an easy to extend user space application. It bears the strik=
ing=20
advantage of not only distributing visualization data but all kinds of data=
=20
within a mesh network, thereby filling an often felt gap.

Note: The alfred vis support is not compulsory for obtaining visualization=
=20
data as the in-kernel code still is enabled. Both systems are compatible an=
d=20
can even be deployed side by side. It is planned to remove the in-kernel co=
de=20
by the end of the year which is why it is recommended to check out alfred=20
soon, in the interest of making sure the transition goes as smooth as=20
possible.


Thanks
=2D-----

Thanks to all people sending in patches:

  * Antonio Quartulli <ordex@autistici.org>
  * Jiri Pirko <jiri@resnulli.us>
  * Linus L=FCssing <linus.luessing@web.de>
  * Marek Lindner <lindner_marek@yahoo.de>
  * Martin Hundeb=F8ll <martin@hundeboll.net>
  * Matthias Schiffer <mschiffer@universe-factory.net>
  * Patrick McHardy <kaber@trash.net>
  * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
  * Sven Eckelmann <sven@open-mesh.com>


batman-adv
=2D---------

The batman-adv kernel module takes special care when transporting payload=20
broadcast traffic across the mesh network to increase the likelihood of a=20
successful transmission. To reduce overhead this mechanism was tweaked to o=
nly=20
be enabled on wireless interfaces as it is safe to assume wired connections=
=20
and VPNs suffer less from packet loss. The internal handling of VLAN IDs ha=
s=20
been unified to prepare for the upcoming translation table VLAN support. DA=
T=20
has learned not to reply to ARP requests sent by local clients destined for=
=20
other local clients to avoid duplicate ARP replies. The batman-adv protocol=
=20
(OGM) duplicate check was applied too strictly in certain situations which=
=20
could lead to route starvation of better routes. To mitigate this effect th=
e=20
duplicate policy is applied on a per neighbor basis. Upon configuring an=20
interface batman-adv would try to acquire the in-kernel network configurati=
on=20
lock or return with ERESTARTSYS in case the lock was held by some other par=
ty.=20
To avoid having to abort an interface activation this part of the code was=
=20
reworked and the need to acquire the lock removed. A crash on kernel module=
=20
unload triggered by a double free of the traffic statistic counters was fix=
ed.=20
The network coding neighbor table won't display neighbors unsuitable for=20
network coding anymore.


batctl
=2D-----

A misleading warning about an uninitialized variable when compiling with "O=
2"=20
was fixed and a few typographic errors in the bisect output were corrected.


alfred
=2D-----

Alfred is a user space daemon for distributing arbitrary local information=
=20
over the mesh/network in a decentralized fashion. This data can be anything=
=20
which appears to be useful - originally designed to replace the batman-adv=
=20
visualization (vis), you may distribute hostnames, phone books, administrat=
ion=20
information, DNS information, the local weather forecast, etc.
Alfred runs as daemon in the background of the system. A user may insert=20
information by using the alfred binary on the command line, or use special=
=20
programs to communicate with alfred (done via unix sockets). The daemon the=
n=20
takes care of distributing the local information to other alfred servers on=
=20
other nodes. This is done via IPv6 link-local multicast, and does not requi=
re=20
any configuration. A user can request data from alfred, and will receive th=
e=20
information available from all alfred servers in the network.


Happy routing,
The B.A.T.M.A.N. team
