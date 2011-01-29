Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 29 Jan 2011 22:47:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201101292247.04342.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2011.0.0 released
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


The B.A.T.M.A.N. team is excited to announce its latest release, 2011.0.0,=
=20
mainly fulfilling popular feature requests but also delivering bug fixes an=
d=20
performance enhancements as well as modifications under the hood. As the ke=
rnel=20
module always depends on the Linux kernel it was compiled against, it does =
not=20
make sense to provide binaries on our website. As usual, you will find the=
=20
signed tarballs in our download section:
http://downloads.open-mesh.org/batman/releases/batman-adv-2011.0.0/
as well as prepackaged binaries in your distribution.


Important changes
=2D---------------

The "gateway support" coming with this release manipulates the DHCP request=
 /=20
reply behavior once activated. It is strongly suggested that you read our=20
documentation before you make use of this feature to avoid surprises.


Thanks
=2D---------------

Thanks to all people sending in patches:

 * Andreas Langer <an.langer@gmx.de>
 * Jesper Juhl <jj@chaosbits.net>
 * Linus L=FCssing <linus.luessing@web.de>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven@narfation.org>

and to all those that supported us with good advice or rigorous testing:

 * David S. Miller <davem@davemloft.net>
 * Russell Senior <russell@personaltelco.net>
 * Tobias Klauser <tklauser@distanz.ch>


batman-adv
=2D---------------

This release brings the long awaited internet gateway support: Batman-adv=20
nodes in a network can be declared 'gateways' with a certain bandwidth at=20
their disposal. All clients learn about these gateways and can choose their=
=20
preferred gateway based on link qualities / bandwidth. The decision is=20
'propagated' to the higher layers by manipulating the DHCP requests.=20
=46urthermore, batman-adv implements a bridge loop detection & avoidance th=
at=20
aim to allow multiple batman-adv nodes connected to the same LAN segment=20
without provoking a loop.
The initial layer2 fragmentation implementation that was included in the la=
st=20
releases was further enhanced. Batman-adv nodes forwarding other nodes' tra=
ffic=20
inspect the to be transfered packets to automatically fragment the packet i=
f=20
the MTU of the outgoing interface does not allow a normal forward. Fragment=
ed=20
packets are reassembled whenever possible to keep the overhead as low as=20
possible. Also new is the possibility to configure the hop penalty at runti=
me=20
(via sysfs).

The internally used hash implementation has been reimplemented after David=
=20
Miller pointed out major deficiencies. These changes gave the batman-adv mo=
dule=20
a 10% speedup when forwarding payload traffic as these operations heavily m=
ake=20
use of the hash code. The Linux kernel bit operation functions replaced the=
=20
custom functions in batman-adv which are better debugged. The cleanup of th=
e=20
sysfs code greatly reduced the code size and makes this code more manageabl=
e.


batctl
=2D---------------

The support for the new gateway sysfs API was among the biggest changes for=
=20
this release. It allows to easily turn the gateway mode on/off and displays=
 all=20
known gateways including their announced bandwidth. To monitor the bridge l=
oop=20
avoidance batctl offers a new parameter to display the the bridge neighbor=
=20
table while highlighting the 'gateway to LAN'. The bisect component now can=
=20
deal with the 32Bit sequence numbers in the OGMs and the bat-hosts parser=20
became more robust while replacing MAC addresses with bat-host names.

Happy routing,
The B.A.T.M.A.N. team
