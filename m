Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 Jan 2013 22:06:41 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301152206.42051.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2013.0.0 released
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


On January 13th, the B.A.T.M.A.N. team has released batman-adv 2013.0.0,=20
bringing many new features, performance improvements and tweaks under the=20
hood. As the kernel module always depends on the Linux kernel it was compil=
ed=20
against, it does not make sense to provide binaries on our website. As usua=
l,=20
you will find the signed tarballs in our download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2013.0.0/

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

 * Akinobu Mita <akinobu.mita@gmail.com>
 * Antonio Quartulli <ordex@autistici.org>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Martin Hundeb=F8ll <martin@hundeboll.net>
 * Moritz Warning <moritzwarning@web.de>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven@narfation.org>


batman-adv
=2D---------

In summer 2011, the B.A.T.M.A.N. project participated in Google's Summer of=
=20
Code for the first time. One of the two projects was about implementing a=20
distributed ARP table for batman-adv (short: DAT), enabling a mesh node to=
=20
speed up the ARP discovery phase for its non-mesh clients by intelligently=
=20
caching & retrieving IPv4 address/MAC address translations. Many obstacles=
=20
like clean code, lack of time and kernel maintainer objections had to be ta=
ken=20
before DAT could finally be merged. This release finally brings the long-
awaited distributed ARP table. The wiki features basic DAT documentation as=
=20
well as technical insights for those who are interested.
The batman-adv Ethernet type (0x4305) was accepted as "official" Ethernet t=
ype=20
inside the Linux kernel to help avoiding future collisions with other=20
protocols. Only the IEEE is entitled to raise our Ethernet type to the leve=
l=20
of "standard" recognized beyond the realm of Linux but this step still move=
s=20
us forward.

Thanks to a hint from David Miller we began removing the famously known=20
"__packed" attribute from our packet definitions as it allows the compiler =
to=20
generate slightly faster code on some platforms. He also encouraged us to=20
implement a minor modification in our hash code to squeeze a little more=20
performance out of it. The translation table was enhanced with the ability =
to=20
handle multiple roaming events during a single OGM interval (especially use=
ful=20
in environments with higher OGM intervals). The bridge loop avoidance drops=
=20
ECTP traffic to avoid packets looping around. In addition, various race=20
conditions during the bridge loop avoidance initialization phase have been=
=20
identified & fixed. An unusual speedy join / bridge loop avoidance interact=
ion=20
bug caught our attention and was addressed soon thereafter.


batctl
=2D-----

The batctl utility was enriched with a couple of tools completing the=20
distributed ARP table support: A switch to enable / disable DAT at runtime,=
 an=20
ARP cache viewer and a minimal unicast 4addr dissector (unicast 4addr packe=
ts=20
are used to exchange DAT packets). This release also features small but use=
ful=20
'translation' helpers: Whenever an IP or MAC address needs to be 'translate=
d'=20
to the originator mac address responsible for the IP or MAC the 'batctl=20
translate' functionality can be used. It is now also possible to call 'batc=
tl=20
ping' and 'batctl traceroute' with an IP or MAC address because these tools=
=20
will take advantage of the 'translate' functionality internally. Beware: la=
yer=20
2 ping and traceroute will still only work across batman-adv enabled nodes.
All of batctl's output errors are redirected to stderr instead of stdout. T=
o=20
save space on embedded devices 'batctl bisect' was turned into a compile-ti=
me=20
option which is disabled by default. The manpage explaining gateway=20
functionality received some attention as well.=20


Happy routing,
The B.A.T.M.A.N. team
