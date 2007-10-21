Message-ID: <471BAB6F.4000408@ddmesh.de>
Date: Sun, 21 Oct 2007 21:41:35 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
References: <4717BE98.2010206@ddmesh.de>	<200710201300.01043.axel@open-mesh.net>	<471B8DCD.2020204@ddmesh.de>
	<200710212007.56679.axel@open-mesh.net>
In-Reply-To: <200710212007.56679.axel@open-mesh.net>
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

> If you NAT any forwarded traffic, the source address of related packets is 
> changed :-) Batmand supports asymmetric routing. That means the packets may 
> be routed another way back than they have come. By doing NAT on the forwarded 
> traffic within the mesh you may force packets to also pass along the NATting 
> interface on their way back. But thats not very beautiful. And I am not shure 
> about further side effects. 
Hmm... I'm still confused. For instance I have interface bbs with ip 172.0.0.1
and an interface wlan with ip 10.0.0.1
If I ping a node behind the bbs interface the package will be created with
ip 172.0.0.1. The SNAT of the initiating node will change this to 10.0.0.1.
The next node will receive this package through its bbs interface but sends the
answer back to tho the node with ip 10.0.0.1. The outgoing interface
is determind by the routing table of the second node. This means that
asymetric routing is still possible. Because the routing entries that batman
creates in the second node the package goes over bbs or wlan back to the first
node.
But I see the point that batman internals may be disturbed when I change this
source ip for batman packets. See next comment.

>> They  
>> only go OUT or come IN. because batmand does not use the iptable roles
>> it does not know about the change of the source address.
>> The OGMs are generated for the original interface ip. OGMs that A sends to
>> B will be received via WLAN and also via BBS. When I understand batmand
>> right it uses the interface where the OGMs are comming from 
> (then batman would have to trac the MAC addresses, but it is IP based )
>> to calulate the  routes (not the source ip).
> NO! Batman uses the source IP of each received OGM to identify if the OGM has 
> been received 
> - directly from the originator interface or 
> - from another intermediate interface. 
> This is important for many internal mechanisms. 
If I mark the batman udp packets for the port (4305) and only SNAT all other packages
then batman should be working as designed, isn't it?

You said before that OGMs are not forwarded. So I can setup a firewall rule to avoid
forwarding the port 4305. The ports 4306 and 4307 still must be forwarded. Is this right?

Bye Stephan

