Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Apr 2012 14:16:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204171416.33017.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2012.1.0 released
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


The B.A.T.M.A.N. team is delighted to announce its newest release, 2012.1.0=
,=20
bringing mainly bug fixes and code cleanups. Also part of the release is a=
=20
newly developed routing algorithm framework which allows switching between=
=20
different routing algorithms. As the kernel module always depends on the Li=
nux=20
kernel it was compiled against, it does not make sense to provide binaries =
on=20
our website. As usual, you will find the signed tarballs in our download=20
section:

http://downloads.open-mesh.org/batman/releases/batman-adv-2012.1.0/

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

 * Alexey Fisher <bug-track@fisher-privat.net>
 * Antonio Quartulli <ordex@autistici.org>
 * Danny Kukawka <danny.kukawka@bisect.de>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Martin Hundeb=F8ll <martin@hundeboll.net>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven@narfation.org>


batman-adv
=2D---------

Most changes coming with this release happened under the hood to either=20
improve stability or pave the way for new features, most notably the routin=
g=20
algorithm abstraction. Over the last months several ideas centering around =
the=20
question how to improve the current routing algorithm have surfaced. To bet=
ter=20
experiment with these ideas while keeping a working system for our users th=
e=20
routing algorithm abstraction was added. It allows to easily develop and te=
st=20
new routing concepts while taking advantage of the existing batman-adv=20
features and infrastructure. The API will be further refined with the next=
=20
releases to enable alternative algorithms to be included as well.
The translation table code received further attention which led to the=20
discovery of endless loops in the tt-request mechanism (under certain=20
circumstances). This was addressed along with a TT_CLIENT_NEW flag race=20
condition when a new client was added to the internal hash. All batman-adv=
=20
internal timeouts have been converted to milliseconds for consistency=20
purposes. Even the batman-adv makefile was modernized to provide an install=
=20
target and a selection system for conveniently compiling features into the=
=20
module.=20


batctl
=2D-----

Each batman-adv (layer 2) ICMP packet used to ping or traceroute a node com=
es=20
with a sequence number to detect failures. Prior to this release batctl=20
ping/traceroute did not compare the outgoing sequence number with the incom=
ing=20
sequence number to verify whether they indeed match. In WiFi environments=20
exhibiting high packet loss and excessive packet retransmissions this missi=
ng=20
check led to false results.
=46urthermore, the return code of batctl ping was improved to properly indi=
cate=20
a failure.


Happy routing,=20
The B.A.T.M.A.N. team
