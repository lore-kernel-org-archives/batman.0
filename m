Message-ID: <471B8DCD.2020204@ddmesh.de>
Date: Sun, 21 Oct 2007 19:35:09 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
References: <4717BE98.2010206@ddmesh.de>	<200710191251.35340.lindner_marek@yahoo.de>	<4718E6AC.9020100@ddmesh.de>
	<200710201300.01043.axel@open-mesh.net>
In-Reply-To: <200710201300.01043.axel@open-mesh.net>
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

Hello,

If I use SNAT to change the source address, all other nodes
know where to send the ping answers:

The Ip of the wlan is 10.12.0.1
the ip of bbs is 172.16.0.1
iptables -t nat -I POSTROUTING -o bbs -j SNAT --to 10.12.0.1

A.eth1-A.bbc=====backbone=========B.bbs-B.eth1 -------------------C.eth1----------D.eth1
 10...1  172...1                 172...2  10...2                  10...3          10...4

Sendint from A to D is not a problem, all packages the have the
ip 172... as source address will be assigned the new 10er IP.
Node B,C and D will send answer back to the 10er IP.
Node B has a route to A over backbone (bbs).

>> If the 
>> only connection is via bbs or bbc the packages are natted to 172.12.. 
>> Only 
>> the the routers that are connected directly via the backbone (bbc->bbs)
>> should have routing entries of 172.16.0.0/12. All other nodes in the
>> network do not need to know these addresses and therefore I don't HNA
>> these.
> How could any non-neighboring node respond to a packet with a 172.12.. source 
> address?
> I would say you better NAT to the IP addresses of your  10.10.0.0/8 because 
> these are the addresses known by any node. But be careful not to NAT any OGMs 
> and any forwarded traffic.
What can happen if I do the SNAT? I think that OGMs are not FORWARDED. They
only go OUT or come IN. because batmand does not use the iptable roles
it does not know about the change of the source address.
The OGMs are generated for the original interface ip. OGMs that A sends to B
will be received via WLAN and also via BBS. When I understand batmand right
it uses the interface where the OGMs are comming from to calulate the routes
(not the source ip).

Bye Stephan

