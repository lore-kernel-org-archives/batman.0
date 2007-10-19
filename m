Message-ID: <4718E6AC.9020100@ddmesh.de>
Date: Fri, 19 Oct 2007 19:17:32 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
References: <4717BE98.2010206@ddmesh.de>	<200710190135.41117.axel@open-mesh.net>
	<200710191251.35340.lindner_marek@yahoo.de>
In-Reply-To: <200710191251.35340.lindner_marek@yahoo.de>
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

I have got it working and below I copy/paste some text from previous posts
of Marek and Axel.

First the problem was the firewall. As you have mentioned you have been an official
port number 4305 assigned. Looking into the port list batman uses only port 4305.
This is why I have assumed that all packages (at least OGMs and GW) are using this
port.

The second problem is that the documentation speeks about three routing tables
65,66,67 where table 67 is used for adding the gateway routes.
I haven't added a rule to this table 68 (see ip rule below).

> > But his output shows that the client has selected a gateway. Therefore a
> > default route should exist. I guess you just looked into the wrong table. I
> > assume that "bat_default" is table 67 ?! The batman default route can be
> > found in table 68.
> >
When table 68 is the table that carries the default route to dev bat0, what is
the table 67 for?
Are there now four routing tables?

Here are my ip rules just for info (table 68 the the "new" table):
root@10-2:~# ip rule
0:      from all lookup local
100:    from all lookup gateway
200:    from all to 192.168.0.0/16 lookup main
201:    from all to 169.254.0.0/16 lookup main
202:    from all to 10.255.255.255 lookup main
203:    from all to 10.12.10.16/28 lookup main
300:    from all lookup bat_route
301:    from all to 172.16.0.0/12 lookup main
302:    from all lookup bat_hna
303:    from all lookup bat_default
#after adding the next rule it is working
304:    from all lookup 68
32766:  from all lookup main
32767:  from all lookup default

#batman
65      bat_hna
66      bat_route
67      bat_default


> >
> > Correct. The connection to the gateway itself is triggered as soon as you
> > begin to use the tunnel. This output shows you to which gateway the
> > connection will be established (assuming that the gateway responds).
For my understanding, when batman starts it collects packages to decide what
gateway should be used. It then adds the default route via dev bat0 and establishes
the tunnel via UDP to port 4306.
The connection should be independent of whether a client (pda connected to router or
local process) tries to use to connect the internet. If no internet connection
was used for weeks, batmand should always have the default route added.
If batman removes this default route, because no traffic through the tunnel was
present for a while, how does batman detect a client trying to make an internet
connection later and add this default route again?
Perhaps I didn't get you right.

Axel:
>> >> Laptop: batmand -g 1024/200 -a 104.61.0.0/16 -s 10.12.0.1
>> >> --no-unreachable-rule --no-throw-rules --no-prio-rules --no-unresp-gw-check
>> >> --resist-blocked-send wlan0 bbs /t 1 /i bbc /t 1 /i wrt54gs: batmand
> >
>> >> batmand -d 4 -r 2 --t 63 --no-unreachable-rule --no-throw-rules
>> >> --no-prio-rules --no-unresp-gw-check --resist-blocked-send eth1 bbs /t 1 /i
>> >> bbc /t 1 /i
> >
> > Generally you should announce the ip address of your non-primary interfaces
> > (bbs and bbc) with HNA. Otherwise the traffic you generate on these nodes
> > might leave the node with a source IP address which is simply not known
> > beyond that link. If you really want to completely hide the IP addresses of
> > bbs and bbc then you  need to do NAT for all locally generated packets,
> > except for the OGMs.
I don't understand your idea.
Each node in the network has an official ip of the 10.0.0.0/8 network. If I use additional
interfaces for backbone (bbs,bbc) these interfaces have there own ip range 172.16.0.0/12.
if a node wants to connect a fare away node it will use the "official" ip address from
10.0.0.0/8 range. If the only connection is via bbs or bbc the packages are natted to 172.12..
Only the the routers that are connected directly via the backbone (bbc->bbs) should have
routing entries of 172.16.0.0/12. All other nodes in the network do not need to know these
addresses and therefore I don't HNA these.
This avoids filling up the routing tables with ip addresses that finally point to the same
node.

A.eth1-A.bbc=====backbone=========B.bbs-B.eth1 -------------------C.eth1----------D.eth1
10...1  172...1                  172...2  10...2                  10...3          10...4

Node D with IP 10.12.0.4 can send packages to node 10.12.0.1
The package is NATed in node B to be send over backbone interface (bbs).
Node A receives this package with ip 172.12.0.1 and because node A has also an interface
with ip 10.12.0.1 the package has reached the target specified by node D (target:10.12.0.1).

> > The bat0 tunnel interface does not get an IP address until the client node
> > sends some data over the tunnel. But if the GW is not reachable (see above)
> > it can never get one.
This only can be batman privat data that are sent over the tunnel, because a local process
needs the routing entry (default route to dev bat0). Right?

> > ??? Which tunnel has been removed by batman and when?
I have tried to add the default route via dev bat0 to table 67 just to check if only
the routing entry is missing. durning this tests, batman has removed this route from
this table after about one minute.
But because it is working now (table 68 and missing to add a rule for this) it is obsolete.

Many thanks to you and you all do a very good job  :)
Stephan




