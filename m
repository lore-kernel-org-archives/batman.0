From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] routing tables
Date: Tue, 6 Nov 2007 12:42:01 +0100
References: <473055F2.8020206@leipzig.freifunk.net>
In-Reply-To: <473055F2.8020206@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711061242.02259.axel@open-mesh.net>
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

On Dienstag 06 November 2007, tetzlav wrote:
> > root@13-18:~# batmand -v
> > B.A.T.M.A.N. 0.3-beta rv780 (compatibility version 4)
> >
> > root@13-18:~# ip r s t 65
> > throw 105.61.89.81  proto static
> > 105.61.89.86 dev vlan1  proto static  scope link  src 105.61.89.81
> > 105.61.89.89 dev vlan1  proto static  scope link  src 105.61.89.81
> > 105.61.89.90 dev vlan1  proto static  scope link  src 105.61.89.81
> > 105.61.89.92 dev vlan1  proto static  scope link  src 105.61.89.81
> >
> > root@13-18:~# ip r s t 66
> > 105.61.17.1 via 105.61.89.92 dev vlan1  proto static  src 105.61.89.81
> > 105.61.17.17 via 105.61.89.92 dev vlan1  proto static  src 105.61.89.81
> > 105.61.17.32 via 105.61.89.86 dev vlan1  proto static  src 105.61.89.81
> > throw 105.61.89.81  proto static
> > 105.61.17.2 via 105.61.89.89 dev vlan1  proto static  src 105.61.89.81
> > 105.61.17.18 via 105.61.89.89 dev vlan1  proto static  src 105.61.89.81
> > 105.61.17.35 via 105.61.89.89 dev vlan1  proto static  src 105.61.89.81
> > 105.61.17.21 via 105.61.89.90 dev vlan1  proto static  src 105.61.89.81
> > 105.61.89.86 dev vlan1  proto static  scope link  src 105.61.89.81
> > 105.61.89.89 dev vlan1  proto static  scope link  src 105.61.89.81
> > 105.61.89.90 dev vlan1  proto static  scope link  src 105.61.89.81
> > 105.61.89.92 dev vlan1  proto static  scope link  src 105.61.89.81
>
> The 105.61.89.x-IPs are secandary BATMAN-interfaces (cable-connections).
> Why are routes to this IPs in the table 65 (for announced networks)?
> Bug or Feature? I think this is new in rv780...

Its a feature!

and its related to:
"Hiding redundant topology information beyond the local neighborhood"
Nodes may reduce the default TTL of their own OGMs to limit the number of hops 
that these OGMs are propagated through the mesh. This can be done for all 
OGMs or just for OGMs propagating the existence of particular interfaces. 
This does not affect the routing between other nodes in the mesh, but may be 
used to limit the range of presence (existence) of individual interfaces. For 
example, a node with three interfaces may be configured to send OGMs with a 
high TTL only for the first (primary) interface and a small TTL for OGMs 
representing the second and third (all non-primary) interfaces. This way, the 
node is always reachable via the IP of it's first interface. But it does not 
burden the nodes beyond its neighbor horizon with the efforts of maintaining 
and re-broadcasting OGMs from it's second and third interface.

One side effect of the one-TTL OGMs is that data-packets generated on these 
nodes may leave the node with a source address of such a secondary interface. 
This has the consequence that non-neighboring nodes could not reply to this 
source address, simply because the OGMs for this source address have never 
been propagated that fare. 

The Solution to counter the above problem is that each multi-homed node  
automatically makes an HNA announcement for all non-primary (hidden) 
interfaces and propagates this HNAs with the OGM representing its primary 
interface. This way the IP addresses of the non-primary interfaces are also 
reachable beyond the local neighbor horizon.
All HNA announcements end up in routing table 65.
It tells the network stack to route packets with a destination address of a 
non-primary interface towards the IP address of the corresponding primary 
interface.

This is now the default behavior in 0.3




ciao,
axel


>
>
> Regards
> tetzlav
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


