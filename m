Return-Path: <michael.rack@rsm-freilassing.de>
Message-ID: <4B0D0DD2.1040107@rsm-freilassing.de>
Date: Wed, 25 Nov 2009 11:58:26 +0100
From: Michael Rack <michael.rack@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] What routingprotocol is similar to B.A.T.M.A.N ?
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

Dear List,

sorry if that is not the right place for my question. But the approach=20
of B.A.T.M.A.N in how to choise the next hop is phantastic. Protocols=20
how BGPv4 and OSPF only take the shortest path to the destination.=20
B.A.T.M.A.N looks for the fastest way where the Hello-Message arrives first.

So long. I need a Routing-Protocol for static mash. My Wireless-Network=20
besides on fixed Wireless Stations they become never to be dynamic. The=20
complete Wireless Network is in Infrastructure-Mode. All members in the=20
Network have just one role (AP / Client).

Currently OLSR does the routing job. But there lots of problems. OLSR=20
also take the shortest path, also in case, a better link is available.

B.A.T.M.A.N is not suitable for my situation. The Client should not be=20
able to select a desired gateway. A gateway should inject a default=20
gateway to the clients, how OLSR does it.

Is there any other routing protocol on the market, that combine all that=20
features, that i need?

     * Routing descission on fastest HelloMessage
     * Inject Default-Gateway via 0.0.0.0/0
     * Without tunneling data

I know. B.A.T.M.A.N is opensource. But i'm not familiar with C/C++ and=20
so, i'm not able to do some modifications to the source.

Or is anyone out there, that can do the modification for me? Tell me,=20
how long the work takes, and what you interested to earn for.

Requirements:

     * Disable the bat0 Interface
     * Enable announcing 0.0.0.0/0

Liebe Gr=FC=DFe aus Freilassing,

Michael Rack
RSM Freilassing
--=20
RSM Freilassing                 Tel.: +49 8654 607110
Nocksteinstr. 13                Fax.: +49 8654 670438
D-83395 Freilassing            www.rsm-freilassing.de

