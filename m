Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 4 Jan 2010 23:44:02 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201001042344.02273.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv gateway support
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

batman-adv still lacks the well-known gateway functionality the batman daemon 
offered since quite a while. Since batman-adv works sufficiently well without it 
and due to the ongoing debate whether a layer 2 mesh protocol should interfere 
with layer 3 this topic has been neglected for a while. In multi-gateway 
environments proper gateway support is a must have. Therefore I hereby propose 
a set of patches to add this functionality. Comments welcome!

What you get:
* The first patch will add gateway announce / handling support to the protocol. 
You will have additional /proc files to switch gateway modes, get a list of 
gateways in the network and see the currently selected best gateway. 
* The second patch simply adds batctl support to conveniently configure the 
gateway setup.
* The third patch checks whether locally received packets are DHCP queries and 
forwards them via uncicast to the best gateway instead of broadcasting them.

Note:
* These patches change the routing protocol, therefore the compat version is 
increased. This (intentionally) breaks interoperability with older batman-adv 
versions!
* Only DHCP traffic gets redirected to the best gateway - no other traffic is 
affected. This is part of the compromise we achieved during the last 
discussions.
* IPv6 support is still missing but should be fairly easy to add. Any 
volunteers ?

Regards,
Marek
