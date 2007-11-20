From: Marek Lindner <lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] single IP for multiple interfaces (was: Re:
	[B.A.T.M.A.N.] problem starting batmand (v799))
Date: Tue, 20 Nov 2007 11:59:15 +0100
References: <47426F09.9060605@absorb.it>
	<200711201008.13700.axel@open-mesh.net>
	<4742B775.2060601@absorb.it>
In-Reply-To: <4742B775.2060601@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711201159.15845.lindner_marek@yahoo.de>
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

> 05:12:09.512310 arp who-has 192.168.43.255 tell 192.168.42.25
> 05:12:10.512178 arp who-has 192.168.43.255 tell 192.168.42.25

These ARP request are not issued by BATMAN itself. BATMAN does only send 
broadcast packets - your system creates these requests. 


> This is two times the same node, first time it recognizes the broadcast
> the right way, second time not.

BATMAN askes the system for the IP and broadcast addresses. In both cases the 
system responds with the same answer. I don't see much difference from 
batmans point of view.


> Is this implemented like this (where?)? Can't work BATMAN with the
> interfaces (or can't we change it to work this way), it would make the
> whole configuration much easier to assign to every node only one single
> IP address (or two, one for olsr and ne for BATMAN)? We are doing this
> with olsr and this really makes the network-structure much cleaner -
> every node has one IP.

You have multihomed OLSR nodes with a single IP and that works ? Can anyone of 
the OLSR folks say something about that ? I can't imagine how the routing 
daemon can distinguish 2 distinct connections with the same address ...

Regards,
Marek
