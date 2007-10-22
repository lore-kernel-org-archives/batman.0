From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
Date: Mon, 22 Oct 2007 14:58:45 +0200
References: <4717BE98.2010206@ddmesh.de>
	<200710212007.56679.axel@open-mesh.net>
	<471BAB6F.4000408@ddmesh.de>
In-Reply-To: <471BAB6F.4000408@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710221458.45648.axel@open-mesh.net>
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

On Sonntag 21 Oktober 2007, Freifunk Dresden wrote:
> Hi,
>
> > If you NAT any forwarded traffic, the source address of related packets
> > is changed :-) Batmand supports asymmetric routing. That means the
> > packets may be routed another way back than they have come. By doing NAT
> > on the forwarded traffic within the mesh you may force packets to also
> > pass along the NATting interface on their way back. But thats not very
> > beautiful. And I am not shure about further side effects.
>
> Hmm... I'm still confused. For instance I have interface bbs with ip
> 172.0.0.1 and an interface wlan with ip 10.0.0.1
> If I ping a node behind the bbs interface the package will be created with
> ip 172.0.0.1. The SNAT of the initiating node will change this to 10.0.0.1.
> The next node will receive this package through its bbs interface but sends
> the answer back to tho the node with ip 10.0.0.1. The outgoing interface is
> determind by the routing table of the second node. This means that
> asymetric routing is still possible.
its still possible but with limitations. 
Consider another setup where the path A - B - C _ D - E is just one of many 
possible paths between A and E. Now the link C _ D is such a "hidden link" 
and nodes C and D are NATting all packets traveling along. Then, when E 
receives a packet from A which has passed along ABCDE the source address of 
that packet indicates that it came from B and not from A. The batmand on E 
might have choosen a totally different route back from E to A (e.g. E-J-B-A) 
but because the source address of the packet shows Cs IP it must be routed 
back along C.

> Because the routing entries that 
> batman creates in the second node the package goes over bbs or wlan back to
> the first node.
> But I see the point that batman internals may be disturbed when I change
> this source ip for batman packets. See next comment.
>

On Sonntag 21 Oktober 2007, Freifunk Dresden wrote:
> The Ip of the wlan is 10.12.0.1
> the ip of bbs is 172.16.0.1
> iptables -t nat -I POSTROUTING -o bbs -j SNAT --to 10.12.0.1
>
> A.eth1-A.bbc=====backbone=========B.bbs-B.eth1
> -------------------C.eth1----------D.eth1 10...1  172...1                
> 172...2  10...2                  10...3          10...4

Yes this way it should work (assuming you care for your OGMs)
But i still suggest something like:

iptables -t nat -A POSTROUTING -o bbs -s 172.16.0.1/32 -p UDP --sport 
4305  --dport 4305 -j ACCEPT # rule must be processed before the next one
iptables -t nat -A POSTROUTING -o bbs -s 172.16.0.1/32 -j SNAT --to 10.12.0.1

> >> They
> >> only go OUT or come IN. because batmand does not use the iptable roles
> >> it does not know about the change of the source address.
> >> The OGMs are generated for the original interface ip. OGMs that A sends
> >> to B will be received via WLAN and also via BBS. When I understand
> >> batmand right it uses the interface where the OGMs are comming from
> >
> > (then batman would have to trac the MAC addresses, but it is IP based )
> >
> >> to calulate the  routes (not the source ip).
> >
> > NO! Batman uses the source IP of each received OGM to identify if the OGM
> > has been received
> > - directly from the originator interface or
> > - from another intermediate interface.
> > This is important for many internal mechanisms.
>
> If I mark the batman udp packets for the port (4305) and only SNAT all
> other packages then batman should be working as designed, isn't it?
Yes
>
> You said before that OGMs are not forwarded. So I can setup a firewall rule
> to avoid forwarding the port 4305. The ports 4306 and 4307 still must be
> forwarded. Is this right?
That should be no problem !

by the way. Since batmand-exp rv 730 the parametrization of --bmx-defaults is 
now enabled by default (it detects much better routes). This parametrization 
automatically hides all non-primary interfaces and announces them as HNA.
You can revert the HNA announcements for a interface with the interface 
specific /A switch (since revision 747). 

If you really want to stick to the behavior of BATMAN-III (batmand-0.2) then 
use the --generation-III directive as the first parameter.

See batmand --dangerous for short help.

Also thanks for the hints regarding the documentation of used routing tables.

ciao
/axel

>
> Bye Stephan
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


