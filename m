From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] problem starting batmand (v799)
Date: Tue, 20 Nov 2007 12:32:11 +0100
References: <47426F09.9060605@absorb.it>
	<200711201008.13700.axel@open-mesh.net>
	<4742B775.2060601@absorb.it>
In-Reply-To: <4742B775.2060601@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711201232.11894.axel@open-mesh.net>
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

On Dienstag 20 November 2007, rene wrote:
> Hi,
>
> Axel Neumann wrote:
> > Hi,
> >
> > On Dienstag 20 November 2007, rene wrote:
> >> Hi,
> >>
> >> starting batmand, the daemon sometimes doesn't seem to recognize the
> >> network the right way.
> >>
> >>
> >> root@25:~# killall batmand
> >> root@25:~# batmand eth1:1 vlan0:1
> >> Using interface eth1:1 with address 192.168.42.25 and broadcast address
> >> 192.168.43.255
> >> Using interface vlan0:1 with address 192.168.42.25 and broadcast address
> >> 192.168.43.255
> >>
> >> -------------------------------------------
> >> on the other node:
> >> root@25:~# killall batmand
> >> root@25:~# batmand eth1:1 vlan0:1
> >> Using interface eth1:1 with address 192.168.42.25 and broadcast address
> >> 192.168.43.255
> >> Using interface vlan0:1 with address 192.168.42.25 and broadcast address
> >> 192.168.43.255
> >> root@25:~#
> >
> > What is definitively not correct is that your capture indicates 4 times
> > the same IP address (192.168.42.25) on 4 different interfaces.
>
> This is two times the same node, first time it recognizes the broadcast
> the right way, second time not.
of course, ive been somwhow distracted by "the other node"
>
> > There MUST be a different IP address for each BATMAN interface in the
> > network (also if a single BATMAN node has more than one interface).
>
> Is this implemented like this (where?)? 
Yes it is implemented/designed like this. It operates on layer three and 
above. IP addresses are used to differentiate between different links to the 
same neighbors. For example two nodes A and B, each with two wireless 
interfaces 1 and 2. All interfaces operating in the same channel, bssid, ...
How could node A differentiate between the link A1<->B1 and A1<->B2 if it is 
not aware of any MAC addresses. But even if it is aware of MAC addresses. How 
could it set up the routing table to ensure that a packet to a distant node C 
should be routed via B1 (and NOT via B2)?
 
> Can't work BATMAN with the 
> interfaces (or can't we change it to work this way)
i guess its not that easy but if you are familiar with protocol design and c 
coding go ahead...
Or you take a look on batman-advanced, but thats another story :-)
> , it would make the 
> whole configuration much easier to assign to every node only one single
> IP address (or two, one for olsr and ne for BATMAN)? We are doing this
> with olsr and this really makes the network-structure much cleaner -
> every node has one IP.

Actually, I did not even know that this is possible - is such a configuration 
proposed somewhere. I can imagine that this somehow works but how shure are 
you that this does not introduce any negative side effects?

ciao, 
axel

>
> Is the described problem with the misconfigured broadcast related to the
> 'same IP on different interfaces' issue?
>
> regards,
> Rene
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


