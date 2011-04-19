Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 19 Apr 2011 13:45:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201104191345.36184.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2011.1.0 released
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


The B.A.T.M.A.N. team is publishing its second 2011 release - 2011.1.0,=20
containing major code changes under the hood to improve performance and=20
scalability plus the usual set of bug fixes. As the kernel module always=20
depends on the Linux kernel it was compiled against, it does not make sense=
 to=20
provide binaries on our website. As usual, you will find the signed tarball=
s=20
in our download section:=20

http://downloads.open-mesh.org/batman/releases/batman-adv-2011.1.0/=20

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

  * Jesper Juhl <jj@chaosbits.net>
  * Linus L=FCssing <linus.luessing@web.de>
  * Lucas De Marchi <lucas.demarchi@profusion.mobi>
  * Marek Lindner <lindner_marek@yahoo.de>
  * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
  * Sven Eckelmann <sven@narfation.org>
  * Sylvestre Ledru <sylvestre.ledru@scilab.org>


batman-adv
=2D---------

The principal objective while working towards this release was to remove th=
e=20
originator hash lock (also known as the batman-adv private "big kernel lock=
").=20
It was introduced in the very early stages of the batman-adv development wh=
ich=20
proved to be a simple and effective way to protect all originator node=20
information from parallel access. As time went on, the module grew and gain=
ed=20
more features - most of them making heavy use of the aforementioned origina=
tor=20
hash lock as it safeguarded the module's central pool of data. It thereby=20
became a major bottleneck because almost every piece of code had to acquire=
=20
this very same lock. An extensive effort was necessary to replace the=20
originator hash lock by fine grained locking which only locks the bare mini=
mum=20
of data to improve the module's performance and scalability.
Other parts of the code received attention too: After learning about=20
bufferbloat in one of Jim Getty's talks we revisited our own buffering=20
settings and decided to set the txqueuelen to zero. Fragmented packets are =
now=20
properly linearized upon receipt to avoid a crash if the network card split=
s=20
the packet into smaller chunks. The fragment numbering became more robust a=
nd=20
several spelling mistakes have been corrected.


batctl
=2D-----

To render batctl more versatile packet dump functionality support for raw W=
iFi=20
packet decapsulation was added. This allows to keep an eye on your network=
=20
using interfaces in monitor mode which output packets including all WiFi=20
headers. The bug causing to display an erroneously warning message when=20
changing gateway settings has been squashed. Unused code and the last trace=
 of=20
our subversion integration in the Makefile have been removed.


Happy routing,=20
The B.A.T.M.A.N. team
