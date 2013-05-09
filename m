Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 9 May 2013 11:17:05 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201305091117.06515.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2013.2.0 released
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


The B.A.T.M.A.N. team is delighted to announce its latest release - batman-=
adv=20
2013.2.0 - introducing a complete new submodule for optimized packet=20
transport, new features and our regular set of bugfixes. As the kernel modu=
le=20
always depends on the Linux kernel it was compiled against, it does not mak=
e=20
sense to provide binaries on our website. As usual, you will find the signe=
d=20
tarballs in our download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2013.2.0/

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

 * Antonio Quartulli <ordex@autistici.org>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Martin Hundeb=F8ll <martin@hundeboll.net>
 * Matthias Schiffer <mschiffer@universe-factory.net>
 * Sasha Levin <sasha.levin@oracle.com>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven@narfation.org>


batman-adv
=2D---------

The highlight of this release certainly is the newly added network coding=20
support. Network Coding aims to improve transmission efficiency to preserve=
=20
precious air time. The principle behind network coding builds upon wireless=
=20
being a shared medium and exploiting this fact to our advantage (given that=
=20
the situation allows to do so). The increased efficiency is achieved by=20
combining two packets into a single transmission that is received by 2=20
destinations at the same time (due to the aforementioned shared medium=20
characteristics). Tests have shown an increase in performance of up to 60% =
due=20
to this clever mechanism. Exhaustive documentation has been made available =
for=20
the curious reader explaining every detail regarding configuration,=20
implementation and future work.

Henceforward, batman-adv interfaces can be configured via the rtnl interfac=
e=20
configuration API in addition to the known sysfs API. The rtnl API offers a=
=20
generic approach to configure all modern Linux interfaces which is used by=
=20
utilities like 'ip'. As part of the interface API restructuring batman-adv=
=20
also gained the ability to automatically resolve duplicate interface usage.=
=20
=46or example, adding an interface to batman-adv while the interface still =
is=20
part of a bridge will now result in the removal of the interface from the=20
bridge without manual intervention. The identification of own mac addresses=
 in=20
multi-meshes setups (multiple batX interfaces on the same host) has been fi=
xed=20
and a necessary length check when parsing OGMs has been added.=20


batctl
=2D-----

To complement the network coding submodule a variety of new features went i=
nto=20
batctl. It is now possible to enable/disable the network coding at runtime =
via=20
a new commandline switch. Furthermore, batctl is able to print the network=
=20
coding neighbor table and allows to configure the network coding log level =
for=20
advanced debugging.
The minimal unicast 4addr dissector had incorrect size expectations which w=
as=20
fixed. The 4addr dissector learned to print the unicast 4addr subtype in or=
der=20
to facilitate keeping the individual 4addr types apart.


Happy routing,
The B.A.T.M.A.N. team
