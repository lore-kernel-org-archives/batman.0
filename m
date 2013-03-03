Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 4 Mar 2013 01:46:19 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201303040146.19284.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2013.1.0 released
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


Today, the B.A.T.M.A.N. team publishes batman-adv 2013.1.0 - a stability an=
d=20
bugfix release, addressing bugs and open issues only. No new features were=
=20
added to ensure maximum stability. As the kernel module always depends on t=
he=20
Linux kernel it was compiled against, it does not make sense to provide=20
binaries on our website. As usual, you will find the signed tarballs in our=
=20
download section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2013.1.0/

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

 * Akinobu Mita <akinobu.mita@gmail.com>
 * Antonio Quartulli <ordex@autistici.org>
 * Jiri Pirko <jiri@resnulli.us>
 * Linus L=FCssing <linus.luessing@web.de>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Matthias Schiffer <mschiffer@universe-factory.net>
 * Pau Koning <paukoning@gmail.com>
 * Shan Wei <davidshan@tencent.com>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

and to all those that supported us with good advice, code review and/or=20
rigorous testing:

 * Sasha Levin <sasha.levin@oracle.com>


batman-adv
=2D---------

The translation table has been further polished by not adding multicast=20
addresses to avoid interfering with multicast traffic. The output of the=20
translation tables has been modified to not print the 'last seen' values fo=
r=20
batX interfaces (these entries are never subject to purging). Moreover, the=
=20
CRC consistency checksums are printed along with the rest of the table to=20
facilitate debugging. As part of our ongoing effort to document the code=20
itself the entire types.h file was 'kernel doc'-ified, thereby documenting =
the=20
bulk of all struct definitions and defines used throughout the batman-adv c=
ode=20
base. While reviewing and documenting all these definitions a few unused bu=
t=20
forgotten variables we identified and removed, reducing the memory consumpt=
ion=20
by a few bytes.

The previously added distributed ARP table (DAT) received more testing and=
=20
reviews which led to a number of fixes: ARP packets with invalid MAC or IP=
=20
addresses are not added to the ARP table anymore. A potential crash due to =
a=20
NULL pointer dereference in the hash collision avoidance section was fixed.=
=20
The batman-adv interface removal could lead to deadlock in the kernel if it=
=20
was triggered at the wrong moment. To resolve the issue  the internal=20
interface cleanup is delayed until all necessary locks can safely be acquir=
ed.=20
The initialization of the lockdep class keys for has structures inside batm=
an-
adv has been improved to mitigate false warnings when running lockdep to fi=
nd=20
problems in the locking routines.


batctl
=2D-----

The batctl man page carried a broken format instruction leading to an=20
"undefined macro" warning and partial disappearance of text. The text=20
misinterpretation was removed and the man page text restored.


Happy routing,
The B.A.T.M.A.N. team
