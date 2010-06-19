Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 20 Jun 2010 00:23:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201006200023.47924.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2010.0.0 released
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


The B.A.T.M.A.N. team today announces the release of the latest batman-adv=
=20
milestone which brings API changes, new features as well as bugfixes and li=
nux=20
coding style compliance. As the kernel module always depends on the Linux=20
kernel it was compiled against, it does not make sense to provide binaries =
on=20
our website. As usual, you will find the signed tarballs in our download=20
section:
http://downloads.open-mesh.net/batman/releases/batman-adv-2010.0.0/
as well as prepackaged binaries in your distribution.

Important changes
=2D---------------

The batman-adv version numbering has been adapted to better reflect our rel=
ease=20
/ feature cycle (the detailed explanation can be found here:=20
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-June/002875.html). T=
he=20
first part of the number represents the year of the release, the second par=
t is=20
the release number per year and the last digit is the bugfix release counte=
r.=20
Because this release is the first of its kind in 2010 we chose "2010.0.0" a=
s=20
its name.
=46urthermore, all batman-adv options residing in the proc filesystem have =
been=20
migrated to the sys filesystem, therefore all scripts accessing these optio=
ns=20
directly need to be adjusted. Scripts using batctl are (almost) not affecte=
d by=20
this transition as the batctl commandline parameters are unchanged. More=20
details can be found below as well as in our documentation.

Thanks
=2D---------------

Thanks to all people sending in patches:

 * Andrea Gelmini <andrea.gelmini@gelma.net>
 * Andrew Lunn <andrew@lunn.ch>
 * Dan Carpenter <error27@gmail.com>
 * Daniel Seither <post@tiwoc.de>
 * Jiri Pirko <jpirko@redhat.com>
 * Joe Perches <joe@perches.com>
 * Linus L=FCssing <linus.luessing@web.de>
 * Luis de Bethencourt <luisbg@ubuntu.com>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven.eckelmann@gmx.de>
 * Tejun Heo <tj@kernel.org>=20

batman-adv
=2D---------------

This release contains a complete rework of the configuration interface,=20
formerly to be found in the proc filesystem. The options have been split in=
to=20
the mesh wide settings and per interface settings. It is now possible to=20
activate/deactivate individual interfaces via their respective folder withi=
n=20
sysfs which fullfills an often wanted feature request. In addition, the ker=
nel=20
module will automatically detect & avoid non-compatible interfaces such as=
=20
non-ethernet or mesh interfaces. During this transition many smaller & bigg=
er=20
annoyances have been cleaned up and prepared the way for features yet to co=
me.=20
Details regarding the new settings interface can be found in our=20
documentation.
Explicit netfilter support has been added that allows to filter batman's la=
yer2=20
traffic and protocol messages with e.g. ebtables, the broadcast traffic cod=
e has=20
been restructered to deal with broadcast storms and the internal sequence=20
number handling has been revamped fixing several bugs. Linux coding style=20
compliance was a big topic too in order to ensure the code is "checkpatch=20
clean".

batctl
=2D---------------

Most of the work went into the sysfs changes to make sure the new API is=20
properly handled. When using batctl you won't notice the difference except =
for=20
the interface handling. Since you can activate and deactivate interfaces on=
e=20
by one, the parameter list had to be adjusted. Also, batctl parses your inp=
ut=20
before configuring the kernel module and warns if the input is not correct=
=20
which saves you from having to consult the kernel logs. Some bugfixes in pi=
ng=20
and traceroute complete this release.

Happy routing,
The B.A.T.M.A.N. team
