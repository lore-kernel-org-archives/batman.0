Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 19 Jun 2011 22:59:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201106192259.16044.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2011.2.0 released
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


The B.A.T.M.A.N. team is publishing its latest edition, 2011.2.0, primarily=
=20
focusing on bug fixes and compatibility plus some smaller features. As the=
=20
kernel module always depends on the Linux kernel it was compiled against, i=
t=20
does not make sense to provide binaries on our website. As usual, you will=
=20
find the signed tarballs in our download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2011.2.0/

as well as prepackaged binaries in your distribution.


Important changes
=2D----------------

A series of patches has been merged that replaces all occurrences of 'HNA' =
by=20
'TT' (standing for 'translation table'). Originally, batman-adv inherited t=
he=20
term 'HNA' from our layer 3 implementation which caused some confusion as=20
people expected it to behave in the same way. The new name is meant to outl=
ine=20
the difference. Scripts / tools expecting the string 'HNA' in the debugfs /=
=20
batctl output need to be adjusted.
This renaming is the first step in a number of changes regarding the client=
=20
announcement mechanisms. Expect more to come with the following releases.


Thanks
=2D-----

Thanks to all people sending in patches:

  * Andrew Lunn <andrew@lunn.ch>
  * Antonio Quartulli <ordex@autistici.org>
  * Daniele Furlan <daniele.furlan@gmail.com>
  * David Decotigny <decot@google.com>
  * Linus L=C3=BCssing <linus.luessing@web.de>
  * Lucas De Marchi <lucas.demarchi@profusion.mobi>
  * Marek Lindner <lindner_marek@yahoo.de>
  * Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
  * Paul E. McKenney <paulmck@linux.vnet.ibm.com>
  * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
  * Sven Eckelmann <sven@narfation.org>
  * Sylvestre Ledru <sylvestre.ledru@scilab.org>


batman-adv
=2D---------

In the aftermath of the orig hash lock removal released with 2011.1.0, batm=
an-
adv underwent a stabilization phase in which fixing bugs was the highest=20
priority. Unsurprisingly, the transition to fine grained locking required=20
further attention such as properly protecting data structures with rcu lock=
s.=20
During the debugging phase race conditions were fixed, duplicate code remov=
ed,=20
memory leaks eliminated and reference counting imbalances addressed.
The backward compatibility with older kernel versions as well as the suppor=
t=20
of upcoming kernel releases has been thoroughly tested and improved. The lo=
cal=20
and global translation table output is reflecting the HNA to TT conversion.=
=20
Adding support for multiple vlan ids to the bridge loop avoidance code is t=
he=20
only noticeable new feature coming with this release.


batctl
=2D-----

The batctl tool also has been affected by the renaming: the vis data option=
=20
'--no-HNA|-H' has been renamed to '--no-TT|-T' and the vis data output prin=
ts=20
'label=3DTT' instead of 'label=3DHNA'. To be compliant with the JSON Schema=
 the=20
JSON vis data output has been slightly modified.


Happy routing,
The B.A.T.M.A.N. team
