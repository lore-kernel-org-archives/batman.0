Message-ID: <472070E7.8020500@ddmesh.de>
Date: Thu, 25 Oct 2007 12:33:11 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
References: <4717BE98.2010206@ddmesh.de>	<200710212007.56679.axel@open-mesh.net>	<471BAB6F.4000408@ddmesh.de>
	<200710221458.45648.axel@open-mesh.net>
In-Reply-To: <200710221458.45648.axel@open-mesh.net>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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

> > Consider another setup where the path A - B - C _ D - E is just one of many
> > possible paths between A and E. Now the link C _ D is such a "hidden link"
> > and nodes C and D are NATting all packets traveling along. Then, when E
> > receives a packet from A which has passed along ABCDE the source address of
> > that packet indicates that it came from B and not from A. The batmand on E
> > might have choosen a totally different route back from E to A (e.g. E-J-B-A)
> > but because the source address of the packet shows Cs IP it must be routed
> > back along C.
Only packages for the bbs/bbc interface and 172er ips are considered.
This is the same as you have already mentioned.
If I SNAT also the OGMs (4305) routing is completely dead.

> > by the way. Since batmand-exp rv 730 the parametrization of --bmx-defaults is
> > now enabled by default (it detects much better routes). This parametrization
> > automatically hides all non-primary interfaces and announces them as HNA.
> > You can revert the HNA announcements for a interface with the interface
> > specific /A switch (since revision 747).
To be sure, if I add /A behind bbs then no HNA is created for this interface ip?

Bye Stephan

