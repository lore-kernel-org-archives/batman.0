From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] gateway-tunnel crashes with multiple net-dev
Date: Thu, 29 Nov 2007 14:13:08 +0100
References: <473F0B87.9050002@leipzig.freifunk.net>
	<474734E7.2030903@leipzig.freifunk.net>
	<200711241816.31241.lindner_marek@yahoo.de>
In-Reply-To: <200711241816.31241.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200711291413.08971.lindner_marek@yahoo.de>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

some thoughts regarding your problem. I debugged that issue with Bj=F6rn fr=
om=20
Leipzig and it turned out that the source of your trouble lies within your =

firmware configuration.
On a client you can have 2 situations (regarding the tunnel):
- The batman host generates traffic and sends it through the tunnel.
- Other hosts (LAN/OLSR/etc) generate traffic and are routed into the tunne=
l.

In the later case you have to masquerade the original IP with the gate0 IP =

otherwise the gateway wont recognize the IP and can't send back the data.

If you don't do so you get something like that (on the gw):
kern.err batmand[17436]: Error - got packet from unknown client: 105.61.116=
.10=20
(virtual ip 104.61.116.10)=20

Here the OLSR IP was not masqueraded, therefore the gateway does not recogn=
ize=20
the clients IP, drops the packet and the blackhole detection on your batman=
=20
host kicks the connection as the gateway does not respond.

Your firmware (1.6.10 Kit: 1.6.10-a973) has NAT entries but only for the LA=
N=20
connected to that device. You should either manipulate the policy routing o=
r=20
extend the NAT for all clients. I guess you are going to choose the first=20
option and as soon as you do so your problem will vanish.  :-)

Greetings,
Marek

