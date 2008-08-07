Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 07 Aug 2008 11:45:18 +0200
From: "Elektra Elektra" <onelektra@gmx.net>
In-Reply-To: <200808061520.59927.axel@open-mesh.net>
Message-ID: <20080807094518.56620@gmx.net>
MIME-Version: 1.0
References: <7itzdzzero.fsf@lanthane.pps.jussieu.fr>
	<200808061520.59927.axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Re: A few comments on the BATMAN routing protocol
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>, Juliusz.Chroboczek@pps.jussieu.fr
Cc: b.a.t.m.a.n@open-mesh.net, elektra@open-mesh.net, siwu@hrz.tu-chemnitz.de, olsr-users@lists.olsr.org, babel-users@lists.alioth.debian.org, lindner_marek@yahoo.de, roman@steinerweb.at

Hello Juliusz!

Axel and Simon are right,  in the situation you have described the protocol=
 wouldn't loop. It is a broken route.

> > S crashes, and A switches to B as its next hop for S.  At this point,
> > B is still using A as its next hop, so we have a temporary routing loop.

If S crashes A and B are not going to change their routing tables anymore -=
 since S doesn't send any OGMs anymore which could trigger a change in the =
routing tables of A and B. So A and B stay put until the garbage collector =
purges the broken route. The assumption that A switches to B is false.=20

The reason why I believe that Batman is loop free is, that routes are updat=
ed upon receiving OGMs from the best ranking next hop. The best ranking nex=
t hop knows the best route better than me, because its likelihood of receiv=
ing OGMs is greater than the local likelihood. If a locally received OGM - =
received via the best ranking neighbor - triggers an update it is granted t=
hat the best ranking next hop is already informed - naturally,,, So the cha=
in of potential forwarders is loop free until the destination.=20

This is particularly so because the current implementations are sequence nu=
mber based, rather than using timers. This is granting that temporary loops=
 can't occur - which could happen if timers could occasionally trigger purg=
es that are not synced.  =20

This is consistent with the test results of Batman-Experimental at Meraka i=
n a physical 49-node grid. I did some inital tests there on the 4 longest p=
ossible routes in the grid (from each corner to each opposite corner, from =
each center of side to center of opposite side) at -30 dBm transmit power, =
-30dbm receive attenuation. 4 simultaneous traffic streams were saturating =
the capacity of these routes, all colliding in the center of the grid. Link=
s were very weak, with high packet loss to single hop neighbors even when t=
he whole network was idle. So a round trip from corner to corner often took=
 12 - 15 hops.=20

Under no circumstances did the protocol loop. Also we did run a long series=
 of tests with Batman-EXP and OLSR with ETX and Fisheye enabled, that David=
 Johnson had previously used to compare mesh routing protocols, like AODV, =
DART, OLSR-RFC, OLSR with ETX .

http://wirelessafrica.meraka.org.za/wiki/images/9/98/Batman_ifip.pdf

cu elektra




--=20
Psssst! Schon das coole Video vom GMX MultiMessenger gesehen?
Der Eine f=FCr Alle: http://www.gmx.net/de/go/messenger03
