Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 Nov 2011 00:56:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201111150056.58226.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2011.4.0 released
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


The B.A.T.M.A.N. team is proud to announce its final milestone in 2011,=20
2011.4.0, concentrating on the stabilization & bug fixing of the recent=20
protocol changes and adding some smaller features . As the kernel module=20
always depends on the Linux kernel it was compiled against, it does not mak=
e=20
sense to provide binaries on our website. As usual, you will find the signe=
d=20
tarballs in our download section:=20

http://downloads.open-mesh.org/batman/releases/batman-adv-2011.4.0/=20

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

   * Antonio Quartulli <ordex@autistici.org>
   * Joe Perches <joe@perches.com>
   * Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
   * Marek Lindner <lindner_marek@yahoo.de>
   * Martin Hundeb=F8ll <martin@hundeboll.net>
   * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


batman-adv
=2D---------

Above all, the 2011.4.0 milestone centers around polishing the protocol=20
changes introduced with the previous release. Non-mesh clients connected vi=
a a=20
wireless interface are marked as such. This information is then propagated =
in=20
the mesh on top of the new non-mesh client infrastructure and can be used t=
o=20
prevent mesh wide wireless client to wireless client communication (on=20
standard WiFi AccessPoints this feature is known as 'AP isolation'). The no=
n-
mesh client status flags (new/delete/purge/roaming/wireless) are exported t=
o=20
user space as part of the translation table output to allow following a=20
client's status closely.
The coming releases will be escorted by a stepwise inclusion of an improved=
=20
version of our routing algorithm. It will be possible to switch between the=
=20
current protocol and the new protocol at runtime in order to make testing a=
s=20
easy as possible. This first stage prepared the existing routing algorithm=
=20
code for the upcoming feature for switching routing protocols. No changes t=
o=20
the routing code behavior have been included.
A couple of translation table bugs have been squashed: memory leaks in the=
=20
translation table, wrong initialization of ethernet addresses of translatio=
n=20
table entries and a kernel crash on module unload. Numerous spelling mistak=
es=20
in the source code comments were corrected.


batctl
=2D-----

batctl received an option to turn on/off the aforementioned mesh wide AP=20
isolation. When called with '-v' batctl will not only print its own version=
=20
but also the batman-adv kernel module version (requires the module to be=20
loaded). The log level section was rewritten, so that it now expects human=
=20
readable log level definitions instead of digits and bitmasks. Also fixed w=
as=20
the mangled tcpdump output of the CRC value in translation table exchange=20
packets.


Happy routing,=20
The B.A.T.M.A.N. team
