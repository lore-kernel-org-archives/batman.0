From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] originator timeout
Date: Sun, 8 Jul 2007 10:43:30 +0200
References: <2bda28cd0707072316p4dbbddbauaf1a1124b8542918@mail.gmail.com>
In-Reply-To: <2bda28cd0707072316p4dbbddbauaf1a1124b8542918@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707081043.31142.axel@open-mesh.net>
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

Hi Stefano

one observation according to your log files:
node2 (interface 10.1.1.13) never gets any of its own originator messages back 
(rebroadcasted) from node6. Despite node2 receives OGMs from node6. I assume 
that node6 simply can not hear node2 (and maybe also others) and therefore 
node6 can not rebroadcast OGMs from node2 (which is necessary for the 
bidirectional link check). One reason for that might be, that the netmask and 
broadcast address of the (alias) interfaces batman is using on node2 and 
node6 are not identical. can you check that?

Another problem you have indicated is that node6 dissapears after a while from 
the routing table at node2. Well, actually the real problem is, that node6 
should never appear at the routing table at node2. 
This is of course confusing but normally not a problem. Its just that during 
the first life-time-seconds of a batman instances links to nighboring nodes 
may falsely be assumed as bidirectional (even if they are unidirectional as 
in your case). We shall fix that someday:-)

ciao,
axel





On Sunday 08 July 2007 08:16, Stefano Scipioni wrote:
> I'm testing batman 0.2 rv451 with 6 nodes.
> node1                  node2                  node3            node4
> 10.0.1.1 ------------- | 10.0.1.3 |
>                           | 10.1.1.1 |----------- 10.1.1.10 ------
>                           | 10.1.1.13
>
>                                           \                        \
>          \
>                                            \                         \
>           \
>                                             \
> --------------------------10.1.1.20    node 5
>                                              \
>                                               \--10.1.1.33 node 6
>
>
> node2 has two interfaces
> On node2 after a while node6 (10.1.1.33) originator is deleted.
> node2 batman:
>   batmand -g 0 -o 2000 -r 3 -s 10.0.1.1 -d 4 wl0 eth0.0
>
> Wireless links are good, with olsrd network has no problem
>
> --- very long log
PS.: please use compressed attachements for log files (also leaving long lines 
as they are, without word wraps)

