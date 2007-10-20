From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
Date: Sat, 20 Oct 2007 13:00:00 +0200
References: <4717BE98.2010206@ddmesh.de>
	<200710191251.35340.lindner_marek@yahoo.de>
	<4718E6AC.9020100@ddmesh.de>
In-Reply-To: <4718E6AC.9020100@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200710201300.01043.axel@open-mesh.net>
Content-Transfer-Encoding: 8bit
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

Hello, 
> >> >> Laptop: batmand -g 1024/200 -a 104.61.0.0/16 -s 10.12.0.1
> >> >> --no-unreachable-rule --no-throw-rules --no-prio-rules
> >> >> --no-unresp-gw-check --resist-blocked-send wlan0 bbs /t 1 /i bbc /t 1
> >> >> /i wrt54gs: batmand
> >> >>
> >> >> batmand -d 4 -r 2 --t 63 --no-unreachable-rule --no-throw-rules
> >> >> --no-prio-rules --no-unresp-gw-check --resist-blocked-send eth1 bbs
> >> >> /t 1 /i bbc /t 1 /i
> > >
> > > Generally you should announce the ip address of your non-primary
> > > interfaces (bbs and bbc) with HNA. Otherwise the traffic you generate
> > > on these nodes might leave the node with a source IP address which is
> > > simply not known beyond that link. If you really want to completely
> > > hide the IP addresses of bbs and bbc then you  need to do NAT for all
> > > locally generated packets, except for the OGMs.
>
> I don't understand your idea.
> Each node in the network has an official ip of the 10.0.0.0/8 network. If I
> use additional interfaces for backbone (bbs,bbc) these interfaces have
> there own ip range 172.16.0.0/12. if a node wants to connect a fare away
> node it will use the "official" ip address from 10.0.0.0/8 range. 
Ok if you can ensure this, then there is no problem. But how do you do that?

We observed nodes (also with multiple interfaces and hidden non-primary 
interfaces) where local application have chosen the ip address of a 
non-primary interface as the source address for its outgoing traffic.
From my understanding, the default behavior of most applications is to always 
use the IP address of the interface via which a packet is routed out, as the 
source address of an outgoing packet. So in case you send a ping to a node to 
which batmand has decided to route via your bbs  device, the ping packet 
should by default have the IP address of this bbs device. If the destination 
node of the ping is link-local for the bbs device, then this is no problem 
because all link-local neighbors of bbs have learned about the IP address of 
the bbs device. But if the final destination of the ping packet is more than 
one hop away, then the destination node does not know anything about the IP 
address of bbs unless it has been announced with HNA.

> If the 
> only connection is via bbs or bbc the packages are natted to 172.12.. 
> Only 
> the the routers that are connected directly via the backbone (bbc->bbs)
> should have routing entries of 172.16.0.0/12. All other nodes in the
> network do not need to know these addresses and therefore I don't HNA
> these.
How could any non-neighboring node respond to a packet with a 172.12.. source 
address?
I would say you better NAT to the IP addresses of your  10.10.0.0/8 because 
these are the addresses known by any node. But be careful not to NAT any OGMs 
and any forwarded traffic.


> This avoids filling up the routing tables with ip addresses that finally
> point to the same node.
>
> A.eth1-A.bbc=====backbone=========B.bbs-B.eth1
> -------------------C.eth1----------D.eth1 10...1  172...1                 
> 172...2  10...2                  10...3          10...4
>
> Node D with IP 10.12.0.4 can send packages to node 10.12.0.1
> The package is NATed in node B to be send over backbone interface (bbs).
What is the benifit of this NAT here?
> Node A receives this package with ip 172.12.0.1 and because node A has also
> an interface with ip 10.12.0.1 the package has reached the target specified
> by node D (target:10.12.0.1).

Yes I understand that that works from D to A. But does it also work with a 
ping send from node A to node D? The source address of the ping request would 
be 172.12.0.1 and when it finally arrives at node D, the receiver does not 
know how to reply!

ciao,
axel

